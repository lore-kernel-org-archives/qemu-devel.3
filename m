Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB056C02187
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2025 16:42:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZBt5-00041F-Nf; Sat, 18 Jan 2025 11:41:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1tZBsw-0003wp-UY
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 11:41:24 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1tZBsv-0007ou-Cs
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 11:41:22 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5d982de9547so6125332a12.2
 for <qemu-devel@nongnu.org>; Sat, 18 Jan 2025 08:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737218480; x=1737823280; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XS8D9xyhI/DY96ppKfNxJeg817Y9hprKgKWhJEwYKyo=;
 b=i0ohyx8a/BJKfMV+T3oGxB6AAtaC2g0tDL3IAM4UODjcvIx5FwU1GeYtmSKDeRFrzU
 +e/yP3EdhuUEdA5eXmEurRfN70qlfRWAXwKZA+uVqs//DIr/2EjJXrk4w5cfnm/tOROi
 R8N5xCBWFoh9t2lqgrnbfbKNRxtuMKjHeWXRTq9J9gekp/yObwdMg/wWrXraMZDyUzt4
 Xr73ITRpg8qQ8nnaRmGue5Rj99xY4JgUGwEASrpCXsoLP2GseqskTX5FRrYN8OScKdmX
 iiMUJq10boVNZup4UHAUxRj22O8pmPk+bZpiaCx+fyGtF5cCWe4KTk2aAc+cGS9RT8o4
 2mMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737218480; x=1737823280;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XS8D9xyhI/DY96ppKfNxJeg817Y9hprKgKWhJEwYKyo=;
 b=qrmlOf10lgf8M8Vqct4Y7wqSOQUUsfYSMfPuhWRja8BGuQ2m8iyq0NElbEATNJxyE2
 NZaVObK9J5MqxnzQGkwjbHOSBtVCvPvD4jTucRQG6GIW9NRRLqXb/z8kZsO+f50aWuwy
 E21/VrDsY/rtYV8c1z6QkXlFEuLWbbiuWRGoIohWI5kVlKCY29HoVK90gvUr7Efzy/L2
 gQ1t9ykkMIPbWKsL9YXDX7abzVCBLhxubMxgp6WkIrMvD/hP0ykY2zzs9Fx7ULWgSSsP
 xchszbej/lEApycSTQobUPOgngAK8NaHW1wT1qbNiN4fGyplgd+HXoliMtp1Wzis3zsp
 fanQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVD7u4mWplXZqGDC0P85xtUurdLs5M6jtLZ/yC2Bmoz6bkBa1/YmLmxeu+EpCC978KnCD+BZHoKYpgc@nongnu.org
X-Gm-Message-State: AOJu0Ywzmy5Ydp38mmFGOEeSGvTXCnq9TjR6Or7T6/TeKFgitdKUWO7o
 dGz5V/dMDFOnrWaFtp3taoch/eVSQYaifjpD5Ufz7FKc3g/rGlJh
X-Gm-Gg: ASbGncuF+04q+Px7EKobn5dKKuZgjOVsRg1h0jpFULOC11W7yWce0GyuBD2ocymDu2f
 OJ5miHhov6HsOS6udgCWeKInhGesR6gXfP8JnhLXfdN+8jwR5PZ3u38WtDUqtq3FvkTN5TnzQz2
 +Mpx+FlEwcc8ygxEZcCzTnhLE4wWS443CLAexr0mlYjMyRKTNZ0w74P0vuh/KoXM2Roc/OLHY75
 2QSomk/40Ohebwi8igtfGWP3hLzX7N3JKpCk2XGdGoA5mhDQ1HC4EVEjwU19fJLyXRtT2v6xxpg
 qek=
X-Google-Smtp-Source: AGHT+IFcWH3+MLwzKCls063trOBw0HLqQFo1I9sDWsFTB/4vosRl+D2Ex6kdIEV8AGVDY2ZNxa+UYQ==
X-Received: by 2002:a17:907:1c1c:b0:ab2:c3ef:ed1e with SMTP id
 a640c23a62f3a-ab38b0b6891mr610759666b.10.1737218478206; 
 Sat, 18 Jan 2025 08:41:18 -0800 (PST)
Received: from think.fritz.box ([2a02:8109:8384:1400:d15a:20d8:4bbe:9a4c])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab384f8624fsm358331266b.150.2025.01.18.08.41.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Jan 2025 08:41:16 -0800 (PST)
From: Roman Penyaev <r.peniaev@gmail.com>
To: 
Cc: Roman Penyaev <r.peniaev@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v7 4/4] qemu-options.hx: describe hub chardev and aggregation
 of several backends
Date: Sat, 18 Jan 2025 17:40:52 +0100
Message-ID: <20250118164056.830721-5-r.peniaev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250118164056.830721-1-r.peniaev@gmail.com>
References: <20250118164056.830721-1-r.peniaev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=r.peniaev@gmail.com; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This adds a few lines describing `hub` aggregator configuration
for aggregation of several backend devices with a single frontend
device.

Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
Cc: "Marc-André Lureau" <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
---
 qemu-options.hx | 48 ++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 44 insertions(+), 4 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 7090d59f6f10..fdc46f7e68b3 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3720,7 +3720,7 @@ SRST
 The general form of a character device option is:
 
 ``-chardev backend,id=id[,mux=on|off][,options]``
-    Backend is one of: ``null``, ``socket``, ``udp``, ``msmouse``,
+    Backend is one of: ``null``, ``socket``, ``udp``, ``msmouse``, ``hub``,
     ``vc``, ``ringbuf``, ``file``, ``pipe``, ``console``, ``serial``,
     ``pty``, ``stdio``, ``braille``, ``parallel``,
     ``spicevmc``, ``spiceport``. The specific backend will determine the
@@ -3777,9 +3777,10 @@ The general form of a character device option is:
     the QEMU monitor, and ``-nographic`` also multiplexes the console
     and the monitor to stdio.
 
-    There is currently no support for multiplexing in the other
-    direction (where a single QEMU front end takes input and output from
-    multiple chardevs).
+    If you need to aggregate data in the opposite direction (where one
+    QEMU frontend interface receives input and output from multiple
+    backend chardev devices), please refer to the paragraph below
+    regarding chardev ``hub`` aggregator device configuration.
 
     Every backend supports the ``logfile`` option, which supplies the
     path to a file to record all data transmitted via the backend. The
@@ -3879,6 +3880,45 @@ The available backends are:
     Forward QEMU's emulated msmouse events to the guest. ``msmouse``
     does not take any options.
 
+``-chardev hub,id=id,chardevs.0=id[,chardevs.N=id]`` Explicitly create
+    chardev backend hub device with the possibility to aggregate input
+    from multiple backend devices and forward it to a single frontend
+    device. Additionally, `hub` device takes the output from the
+    frontend device and sends it back to all the connected backend
+    devices. This allows for seamless interaction between different
+    backend devices and a single frontend interface. Aggregation
+    supported for up to 4 chardev devices. (Since 10.0)
+
+    For example, the following is a use case of 2 backend devices:
+    virtual console ``vc0`` and a pseudo TTY ``pty0`` connected to
+    a single virtio hvc console frontend device with a hub ``hub0``
+    help. Virtual console renders text to an image, which can be
+    shared over the VNC protocol. In turn, pty backend provides
+    bidirectional communication to the virtio hvc console over the
+    pseudo TTY file. The example configuration can be as follows:
+
+    ::
+
+       -chardev pty,path=/tmp/pty,id=pty0 \
+       -chardev vc,id=vc0 \
+       -chardev hub,id=hub0,chardevs.0=pty0,chardevs.1=vc0 \
+       -device virtconsole,chardev=hub0 \
+       -vnc 0.0.0.0:0
+
+    Once QEMU starts VNC client and any TTY emulator can be used to
+    control a single hvc console:
+
+    ::
+
+       # Start TTY emulator
+       tio /tmp/pty
+
+       # Start VNC client and switch to virtual console Ctrl-Alt-2
+       vncviewer :0
+
+    Several frontend devices is not supported. Stacking of multiplexers
+    and hub devices is not supported as well.
+
 ``-chardev vc,id=id[[,width=width][,height=height]][[,cols=cols][,rows=rows]]``
     Connect to a QEMU text console. ``vc`` may optionally be given a
     specific size.
-- 
2.43.0


