Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E20EBC02192
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 17:20:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tf06e-00089O-SV; Mon, 03 Feb 2025 12:19:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1tf06Z-00088l-1r
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 12:19:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1tf06W-0003zK-Ty
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 12:19:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738603164;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S0tI05i+8GGcd69N8Bm/yfybVpUFCQn7IdSKu5mVK94=;
 b=ipfUduYT2gNQ5jXOUqep2m9vtF4Odx/Ljb546GxLsEFbOdoSBrQeRolJ1mMEHN9hbXnlB5
 d0hL2VViSFMBL6knLjvt7EfBvmQS4dutIe8Ay9HIuqGB4XH4U6W886fon3AyfRkpTPjZ5c
 mL9dGPtcUCZpFulWo4BitjooqBPBxAM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-327-KSg7_vKZP7CLHD4m9U_2cw-1; Mon,
 03 Feb 2025 12:19:20 -0500
X-MC-Unique: KSg7_vKZP7CLHD4m9U_2cw-1
X-Mimecast-MFC-AGG-ID: KSg7_vKZP7CLHD4m9U_2cw
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AF83519560B4; Mon,  3 Feb 2025 17:19:18 +0000 (UTC)
Received: from localhost (unknown [10.39.208.25])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3E9FA1800267; Mon,  3 Feb 2025 17:19:16 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 peter.maydell@linaro.org, Alexandre Iooss <erdnaxe@crans.org>,
 Roman Penyaev <r.peniaev@gmail.com>
Subject: [PULL v2 4/8] qemu-options.hx: describe hub chardev and aggregation
 of several backends
Date: Mon,  3 Feb 2025 21:18:44 +0400
Message-ID: <20250203171848.686582-5-marcandre.lureau@redhat.com>
In-Reply-To: <20250203171848.686582-1-marcandre.lureau@redhat.com>
References: <20250203171848.686582-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Roman Penyaev <r.peniaev@gmail.com>

This adds a few lines describing `hub` aggregator configuration
for aggregation of several backend devices with a single frontend
device.

Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
Reviewed-by: "Marc-André Lureau" <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
Message-ID: <20250123085327.965501-5-r.peniaev@gmail.com>
---
 qemu-options.hx | 49 +++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 45 insertions(+), 4 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index d19bf533d6..ec0090dfe2 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3733,7 +3733,7 @@ SRST
 The general form of a character device option is:
 
 ``-chardev backend,id=id[,mux=on|off][,options]``
-    Backend is one of: ``null``, ``socket``, ``udp``, ``msmouse``,
+    Backend is one of: ``null``, ``socket``, ``udp``, ``msmouse``, ``hub``,
     ``vc``, ``ringbuf``, ``file``, ``pipe``, ``console``, ``serial``,
     ``pty``, ``stdio``, ``braille``, ``parallel``,
     ``spicevmc``, ``spiceport``. The specific backend will determine the
@@ -3790,9 +3790,10 @@ The general form of a character device option is:
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
@@ -3892,6 +3893,46 @@ The available backends are:
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
2.47.0


