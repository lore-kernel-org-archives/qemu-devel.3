Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88253D374A4
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 14:46:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1Rl7-0003YK-Un; Thu, 17 Oct 2024 10:45:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1t1Rl6-0003XZ-4o
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 10:45:48 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1t1Rl4-0005fe-16
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 10:45:47 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5c9625cfe4dso1383810a12.0
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2024 07:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729176344; x=1729781144; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BPum5WuUR1pl6Nf8anLI5uEzQpe4u1JtVxTalO9kwT8=;
 b=WTkDgsTzGOOE5aXRHxsZvbBLJdiILT4AX4O2caw8iXWhJzuPguwgLEkxr8GR8xQT7/
 XifHGfIlETmmzGK24sR7cDOR6wbILd8r6oNJw6jMrEmidLCbnNh7H6ytfWNbUA3ZitKQ
 X164H+ZrjK7M7wX05dVtLtbnB+l5B1kpOfeLELXcSxEeDsfGKMPWdbQA6Ehzz1sswpug
 Aid9NdVo6bfqd9ONRE6m8KrkNbI7xkEvWN7DTaOnxr/isSJqQJHDfHW3HdRReVj/lFVF
 +4H5VRLpIX7koVzaxdO0qrrhxVePfwNGBZIBiut3rJd3KpILE37qx4KlEgLMVRWHSeJ7
 P7Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729176344; x=1729781144;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BPum5WuUR1pl6Nf8anLI5uEzQpe4u1JtVxTalO9kwT8=;
 b=JtIYk5/mEKOl9Wsh0hZapvTIMPnyEnm5b5FHm0H9/7STqD1nNZG6q31MriyfRgux7e
 LggUVqiW25Bvjg1pwtt14zo4wtWVZ98VaXHno5YALEuFjVxWjFgybAqmtn0QxAdjIT2a
 SIdgLlv0UES79xuuMWDEL2TaT+axPWvXrH5v8DSNT4OFrdUEKfJqVQHl4LYacM9zhfAe
 P+52yV7daG2CLAiI4vUD39RcB/KCE7lKDBdeUjlDTC2+BwcFVQ8q0lmKTWlGpj1tjz1x
 dFIMxS8qcoGCYzEIaM369clZgTh18a1BLlzp0h/pFF/CcHMaEkc0xUQhWKjy+S3B1upR
 eutA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3Dd1Xg6RVutDluVYVqxsLu3VdKodAqcvU9vVDIvo03ScjaaQ7tZc6JjjkIluXehaJSSQd5g9MHPRg@nongnu.org
X-Gm-Message-State: AOJu0YxXwF+rQxB62LrRZFvjE7PyszvkwieUhtHInuQF7mhsQzZGrq4D
 USPAxwwj3lnrd034IL28Amy0TEt6GKjzAfremQHwol0yzc1BNufV
X-Google-Smtp-Source: AGHT+IFB7wPcnERiA5LRenZDfsxhw2O3PPrNeBoEPL1806/I5t6mCc+tmrXj3qhmVbSaVrHOPDgSVQ==
X-Received: by 2002:a05:6402:1e93:b0:5c9:845f:25fd with SMTP id
 4fb4d7f45d1cf-5c9845f2752mr10802859a12.23.1729176344220; 
 Thu, 17 Oct 2024 07:45:44 -0700 (PDT)
Received: from finn.fritz.box ([2a02:8109:8384:1400:9c4:b066:486:f408])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c98d507a14sm2867581a12.49.2024.10.17.07.45.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2024 07:45:43 -0700 (PDT)
From: Roman Penyaev <r.peniaev@gmail.com>
To: 
Cc: Roman Penyaev <r.peniaev@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v5 8/8] qemu-options.hx: describe multiplexing of several
 backend devices
Date: Thu, 17 Oct 2024 16:43:16 +0200
Message-Id: <20241017144316.517709-9-r.peniaev@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241017144316.517709-1-r.peniaev@gmail.com>
References: <20241017144316.517709-1-r.peniaev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=r.peniaev@gmail.com; helo=mail-ed1-x533.google.com
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

This adds a few lines describing `mux-be` multiplexer configuration
for multiplexing several backend devices with a single frontend
device.

Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
Cc: "Marc-André Lureau" <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
---
 qemu-options.hx | 80 ++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 60 insertions(+), 20 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index daae49414740..d620dc39b489 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3677,37 +3677,37 @@ DEFHEADING(Character device options:)
 
 DEF("chardev", HAS_ARG, QEMU_OPTION_chardev,
     "-chardev help\n"
-    "-chardev null,id=id[,mux=on|off][,logfile=PATH][,logappend=on|off]\n"
+    "-chardev null,id=id[,mux=on|off][,mux-be-id=id][,logfile=PATH][,logappend=on|off]\n"
     "-chardev socket,id=id[,host=host],port=port[,to=to][,ipv4=on|off][,ipv6=on|off][,nodelay=on|off]\n"
-    "         [,server=on|off][,wait=on|off][,telnet=on|off][,websocket=on|off][,reconnect=seconds][,mux=on|off]\n"
+    "         [,server=on|off][,wait=on|off][,telnet=on|off][,websocket=on|off][,reconnect=seconds][,mux=on|off][,mux-be-id=id]\n"
     "         [,logfile=PATH][,logappend=on|off][,tls-creds=ID][,tls-authz=ID] (tcp)\n"
     "-chardev socket,id=id,path=path[,server=on|off][,wait=on|off][,telnet=on|off][,websocket=on|off][,reconnect=seconds]\n"
-    "         [,mux=on|off][,logfile=PATH][,logappend=on|off][,abstract=on|off][,tight=on|off] (unix)\n"
+    "         [,mux=on|off][,mux-be-id=id][,logfile=PATH][,logappend=on|off][,abstract=on|off][,tight=on|off] (unix)\n"
     "-chardev udp,id=id[,host=host],port=port[,localaddr=localaddr]\n"
-    "         [,localport=localport][,ipv4=on|off][,ipv6=on|off][,mux=on|off]\n"
+    "         [,localport=localport][,ipv4=on|off][,ipv6=on|off][,mux=on|off][,mux-be-id=id]\n"
     "         [,logfile=PATH][,logappend=on|off]\n"
-    "-chardev msmouse,id=id[,mux=on|off][,logfile=PATH][,logappend=on|off]\n"
+    "-chardev msmouse,id=id[,mux=on|off][,mux-be-id=id][,logfile=PATH][,logappend=on|off]\n"
     "-chardev vc,id=id[[,width=width][,height=height]][[,cols=cols][,rows=rows]]\n"
-    "         [,mux=on|off][,logfile=PATH][,logappend=on|off]\n"
+    "         [,mux=on|off][,mux-be-id=id][,logfile=PATH][,logappend=on|off]\n"
     "-chardev ringbuf,id=id[,size=size][,logfile=PATH][,logappend=on|off]\n"
-    "-chardev file,id=id,path=path[,input-path=input-file][,mux=on|off][,logfile=PATH][,logappend=on|off]\n"
-    "-chardev pipe,id=id,path=path[,mux=on|off][,logfile=PATH][,logappend=on|off]\n"
+    "-chardev file,id=id,path=path[,input-path=input-file][,mux=on|off][,mux-be-id=id][,logfile=PATH][,logappend=on|off]\n"
+    "-chardev pipe,id=id,path=path[,mux=on|off][,mux-be-id=id][,logfile=PATH][,logappend=on|off]\n"
 #ifdef _WIN32
-    "-chardev console,id=id[,mux=on|off][,logfile=PATH][,logappend=on|off]\n"
-    "-chardev serial,id=id,path=path[,mux=on|off][,logfile=PATH][,logappend=on|off]\n"
+    "-chardev console,id=id[,mux=on|off][,mux-be-id=id][,logfile=PATH][,logappend=on|off]\n"
+    "-chardev serial,id=id,path=path[,mux=on|off][,mux-be-id=id][,logfile=PATH][,logappend=on|off]\n"
 #else
-    "-chardev pty,id=id[,path=path][,mux=on|off][,logfile=PATH][,logappend=on|off]\n"
-    "-chardev stdio,id=id[,mux=on|off][,signal=on|off][,logfile=PATH][,logappend=on|off]\n"
+    "-chardev pty,id=id[,path=path][,mux=on|off][,mux-be-id=id][,logfile=PATH][,logappend=on|off]\n"
+    "-chardev stdio,id=id[,mux=on|off][,mux-be-id=id][,signal=on|off][,logfile=PATH][,logappend=on|off]\n"
 #endif
 #ifdef CONFIG_BRLAPI
-    "-chardev braille,id=id[,mux=on|off][,logfile=PATH][,logappend=on|off]\n"
+    "-chardev braille,id=id[,mux=on|off][,mux-be-id=id][,logfile=PATH][,logappend=on|off]\n"
 #endif
 #if defined(__linux__) || defined(__sun__) || defined(__FreeBSD__) \
         || defined(__NetBSD__) || defined(__OpenBSD__) || defined(__DragonFly__)
-    "-chardev serial,id=id,path=path[,mux=on|off][,logfile=PATH][,logappend=on|off]\n"
+    "-chardev serial,id=id,path=path[,mux=on|off][,mux-be-id=id][,logfile=PATH][,logappend=on|off]\n"
 #endif
 #if defined(__linux__) || defined(__FreeBSD__) || defined(__DragonFly__)
-    "-chardev parallel,id=id,path=path[,mux=on|off][,logfile=PATH][,logappend=on|off]\n"
+    "-chardev parallel,id=id,path=path[,mux=on|off][,mux-be-id=id][,logfile=PATH][,logappend=on|off]\n"
 #endif
 #if defined(CONFIG_SPICE)
     "-chardev spicevmc,id=id,name=name[,debug=debug][,logfile=PATH][,logappend=on|off]\n"
@@ -3719,8 +3719,8 @@ DEF("chardev", HAS_ARG, QEMU_OPTION_chardev,
 SRST
 The general form of a character device option is:
 
-``-chardev backend,id=id[,mux=on|off][,options]``
-    Backend is one of: ``null``, ``socket``, ``udp``, ``msmouse``,
+``-chardev backend,id=id[,mux=on|off][,mux-be-id=id][,options]``
+    Backend is one of: ``null``, ``socket``, ``udp``, ``msmouse``, ``mux-be``,
     ``vc``, ``ringbuf``, ``file``, ``pipe``, ``console``, ``serial``,
     ``pty``, ``stdio``, ``braille``, ``parallel``,
     ``spicevmc``, ``spiceport``. The specific backend will determine the
@@ -3777,9 +3777,11 @@ The general form of a character device option is:
     the QEMU monitor, and ``-nographic`` also multiplexes the console
     and the monitor to stdio.
 
-    There is currently no support for multiplexing in the other
-    direction (where a single QEMU front end takes input and output from
-    multiple chardevs).
+    If you need to multiplex in the opposite direction (where one QEMU
+    interface receives input and output from multiple chardev devices),
+    each character device needs the ``mux-be-id=ID`` option. Please
+    refer to the paragraph below regarding chardev ``mux-be``
+    configuration.
 
     Every backend supports the ``logfile`` option, which supplies the
     path to a file to record all data transmitted via the backend. The
@@ -3879,6 +3881,44 @@ The available backends are:
     Forward QEMU's emulated msmouse events to the guest. ``msmouse``
     does not take any options.
 
+``-chardev mux-be,id=id``
+    Explicitly create chardev backend multiplexer with the possibility
+    to multiplex in the opposite direction, where one QEMU interface
+    (frontend device) receives input and output from multiple chardev
+    backend devices. (Since 9.2)
+
+    For example, the following is a use case of 2 backend devices:
+    virtual console ``vc0`` and a socket ``sock0`` connected to a
+    single virtio hvc console frontend device with multiplexer
+    ``mux0`` help. Virtual console renders text to an image, which can
+    be shared over the VNC protocol. In turn, socket backend provides
+    bidirectional communication to the virtio hvc console over the
+    socket. The example configuration can be as follows:
+
+    ::
+
+       -chardev mux-be,id=mux0 \
+       -chardev socket,path=/tmp/sock,server=on,wait=off,id=sock0,mux-be-id=mux0 \
+       -chardev vc,id=vc0,mux-be-id=mux0 \
+       -device virtconsole,chardev=mux0 \
+       -vnc 0.0.0.0:0
+
+    Once QEMU starts VNC client and any TTY emulator can be used to
+    control a single hvc console:
+
+    ::
+
+       # VNC client
+       vncviewer :0
+
+       # TTY emulator
+       socat unix-connect:/tmp/sock pty,link=/tmp/pty & \
+       tio /tmp/pty
+
+    Multiplexing of several backend devices with several frontend
+    devices is not supported. Stacking of multiplexers is not
+    supported as well.
+
 ``-chardev vc,id=id[[,width=width][,height=height]][[,cols=cols][,rows=rows]]``
     Connect to a QEMU text console. ``vc`` may optionally be given a
     specific size.
-- 
2.34.1


