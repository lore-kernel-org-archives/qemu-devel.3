Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C6ADC0218E
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2025 08:54:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tasy6-0007cT-1S; Thu, 23 Jan 2025 03:53:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1tasy4-0007c3-8R
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 03:53:40 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1tasy2-0000Y2-B2
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 03:53:40 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5d96944401dso1211013a12.0
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2025 00:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737622417; x=1738227217; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xJoEBFx5uK1qVNB0I6L/KByUsPzfPdocJz4RTcufOaM=;
 b=DzDZmWTLyBf4EtX8niNWR5hWH2Y7XW4B5EOKlLyROe1xj9MLq7ks/UcYWFhqDcefDP
 75DnAFPUKbRzJOY8OH3SpnCKubSS2N8R88p/AOrwnELPG/sW/V5Jtn9ykLsJdRSfbm8D
 wBTtbdr8vN4EIpWKJAtfiRszCYX4187NYdC4aru4MPEMJnOAtCxBYJ9FG/JMEgfJHq6q
 to9kPWU8w7LQPmMF9STo/KclHUcTBOqKoOPuVj4DKQSv0lg4/+9JllflspvYHSOsH7Sw
 h6aemmklmtkr63u551+VfB5b+dv+RkhDumU/sa2iN+deg8R1hQGPCUuftrDH6wKUu9Dx
 2bhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737622417; x=1738227217;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xJoEBFx5uK1qVNB0I6L/KByUsPzfPdocJz4RTcufOaM=;
 b=JDGN/sKC9bPEMlAcKSCRRQJU834zS/ioqVi9LPO0jx8i6JqtSRwzupAr4XA0B/v2fl
 HlD2an0oDilGZ0InG/0wGQ2yE0j4KfpUGuf0KanWvzsrvneh4snqOGxEkLjvtu4yfRxn
 spzvdxWjk42TkPacaFLtiMoFffZxX8XSCoAqAYa4/6QmwuY6Z3OVmraZy3rdS4eY9epR
 hqBk0oaPkfr5VhHyfTdAyS0GcpvEz2SoaToLsr+8X72LeufehFiyo0Q+sTxzpJpilgE5
 pzKNo2LKtKs2tvzGQL/NO9jj8qnESq08bRGyEtLm7bd4iJGRmIrMth1OWte4qaalDxub
 Zhdg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNjMa/WqZuvoqLFEZzFZ9/e7fdchdCwEGnRvJmFbNkngY7IIPc2RdVXurcXeuHB7F/q/8IGPU7OlAR@nongnu.org
X-Gm-Message-State: AOJu0YxJL2ES5pG29+qOC25fABieTPcgRqVuvr7tUlYB5qu3MzCUfThj
 Pns8ylOowSzdVL28GmeDTClirHNhBMrQ5XwWQ6UjkFdlNI/m5HD6
X-Gm-Gg: ASbGncv873XvH94jdOtjSzFX9oHpAGIz592ur6FSvlmrvWHDW9L8cn3+LWuSPHeYTjX
 O8mE+opjaSTtQK0i8oXBNGLiacSa2nEz5h/B59VEmr0ns7GoF3PUYWKsgdGva1GVw7SVIg5IgcI
 biEPM9LYN8+S0xJC8rWP+wABDPOAesd8VvD1m3EQ+tfiLBh+w/tu38EgvcfOFq6cp5EQV7bTITx
 C8gYTONMLVVPPlKYM96rZQ3V6qgB/DvuGnQFKbwbrYxjBNNmx5dz3kcQhNZKDbEBvemyfwlZEOw
 +NZX0YxjqdzOYcAx1jVdJtiooI2l
X-Google-Smtp-Source: AGHT+IHEdC4yg9mCCEpN0eFC6tZWwS0r+icFXihH3CuKR1Cts2dxzw6HjODPmmJuD+9gso1CfDlxyQ==
X-Received: by 2002:a05:6402:51cb:b0:5d9:fbb5:9ee with SMTP id
 4fb4d7f45d1cf-5db7d2f8ae3mr24760321a12.13.1737622416707; 
 Thu, 23 Jan 2025 00:53:36 -0800 (PST)
Received: from think.fkb.profitbricks.net
 ([2a02:8109:8384:1400:b763:14a0:8818:4012])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5dbcfb8ff37sm4424676a12.72.2025.01.23.00.53.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jan 2025 00:53:34 -0800 (PST)
From: Roman Penyaev <r.peniaev@gmail.com>
To: 
Cc: Roman Penyaev <r.peniaev@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v9 4/4] qemu-options.hx: describe hub chardev and aggregation
 of several backends
Date: Thu, 23 Jan 2025 09:53:24 +0100
Message-ID: <20250123085327.965501-5-r.peniaev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250123085327.965501-1-r.peniaev@gmail.com>
References: <20250123085327.965501-1-r.peniaev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=r.peniaev@gmail.com; helo=mail-ed1-x530.google.com
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
Reviewed-by: "Marc-André Lureau" <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
---
 qemu-options.hx | 49 +++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 45 insertions(+), 4 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 7090d59f6f10..8e28bd41a9c3 100644
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
@@ -3879,6 +3880,46 @@ The available backends are:
     Forward QEMU's emulated msmouse events to the guest. ``msmouse``
     does not take any options.
 
+``-chardev hub,id=id,chardevs.0=id[,chardevs.N=id]``
+    Explicitly create chardev backend hub device with the possibility
+    to aggregate input from multiple backend devices and forward it to
+    a single frontend device. Additionally, ``hub`` device takes the
+    output from the frontend device and sends it back to all the
+    connected backend devices. This allows for seamless interaction
+    between different backend devices and a single frontend
+    interface. Aggregation supported for up to 4 chardev
+    devices. (Since 10.0)
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


