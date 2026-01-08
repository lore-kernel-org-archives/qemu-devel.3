Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2FB7D1D483
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 17:04:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdtQb-0003jm-Pf; Thu, 08 Jan 2026 12:04:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vdtQW-0003fO-Vu
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 12:04:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vdtQU-0006pv-BT
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 12:04:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767891837;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XHkgffGczsjKc+JcW4hYQwviOuKk82UuO1Dcs418ofE=;
 b=JaH/5zab+5gIpKSDq2B71NTd51OfX3hIsQqSJRtWxl4YQV5hBnzGkK7gTVvIHkqeMnv+ii
 /jUZO9WF1c0Sf+6bTrV0T8M4gpERW5UhPayTwcp4KYHPR5HNUFMnUSaTbLSALQBF5k8awb
 dVNCIPsUK8RSAA+dWX4vIy5t5vBGORA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-520-pWyWZK4ePt2g8qJCsCgp_Q-1; Thu,
 08 Jan 2026 12:03:52 -0500
X-MC-Unique: pWyWZK4ePt2g8qJCsCgp_Q-1
X-Mimecast-MFC-AGG-ID: pWyWZK4ePt2g8qJCsCgp_Q_1767891830
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E207518005BB; Thu,  8 Jan 2026 17:03:49 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.44])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 30DCC19560BA; Thu,  8 Jan 2026 17:03:44 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 devel@lists.libvirt.org, qemu-block@nongnu.org, qemu-rust@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Kevin Wolf <kwolf@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v5 01/24] qemu-options: remove extraneous [] around arg values
Date: Thu,  8 Jan 2026 17:03:15 +0000
Message-ID: <20260108170338.2693853-2-berrange@redhat.com>
In-Reply-To: <20260108170338.2693853-1-berrange@redhat.com>
References: <20260108170338.2693853-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

There are quite a few inappropriate uses of [...] around argument
values. The [] are intended to indicate optionality, but in some
cases it is used to wrap a set of enum values. In other cases it
is being used to show the value is entirely optional, which was
common behaviour for boolean values in the past. QEMU has deprecated
short-form boolean options for quite a while though, and we should
thus not advertize this possibility in the docs.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 qemu-options.hx | 110 ++++++++++++++++++++++++------------------------
 1 file changed, 55 insertions(+), 55 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index ec92723f10..e8057fdcc9 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -25,7 +25,7 @@ SRST
 ERST
 
 DEF("machine", HAS_ARG, QEMU_OPTION_machine, \
-    "-machine [type=]name[,prop[=value][,...]]\n"
+    "-machine [type=]name[,prop=value[,...]]\n"
     "                selects emulated machine ('-machine help' for list)\n"
     "                property accel=accel1[:accel2[:...]] selects accelerator\n"
     "                supported accelerators are kvm, xen, hvf, nvmm, whpx, mshv or tcg (default: tcg)\n"
@@ -227,7 +227,7 @@ SRST
 ERST
 
 DEF("accel", HAS_ARG, QEMU_OPTION_accel,
-    "-accel [accel=]accelerator[,prop[=value][,...]]\n"
+    "-accel [accel=]accelerator[,prop=value[,...]]\n"
     "                select accelerator (kvm, xen, hvf, nvmm, whpx, mshv or tcg; use 'help' for a list)\n"
     "                igd-passthru=on|off (enable Xen integrated Intel graphics passthrough, default=off)\n"
     "                kernel-irqchip=on|off|split controls accelerated irqchip support (default=on)\n"
@@ -789,17 +789,17 @@ ERST
 
 
 DEF("audio", HAS_ARG, QEMU_OPTION_audio,
-    "-audio [driver=]driver[,prop[=value][,...]]\n"
+    "-audio [driver=]driver[,prop=value[,...]]\n"
     "                specifies default audio backend when `audiodev` is not\n"
     "                used to create a machine or sound device;"
     "                options are the same as for -audiodev\n"
-    "-audio [driver=]driver,model=value[,prop[=value][,...]]\n"
+    "-audio [driver=]driver,model=value[,prop=value[,...]]\n"
     "                specifies the audio backend and device to use;\n"
     "                apart from 'model', options are the same as for -audiodev.\n"
     "                use '-audio model=help' to show possible devices.\n",
     QEMU_ARCH_ALL)
 SRST
-``-audio [driver=]driver[,model=value][,prop[=value][,...]]``
+``-audio [driver=]driver[,model=value][,prop=value[,...]]``
     If the ``model`` option is specified, ``-audio`` is a shortcut
     for configuring both the guest audio hardware and the host audio
     backend in one go. The guest hardware model can be set with
@@ -827,7 +827,7 @@ SRST
 ERST
 
 DEF("audiodev", HAS_ARG, QEMU_OPTION_audiodev,
-    "-audiodev [driver=]driver,id=id[,prop[=value][,...]]\n"
+    "-audiodev [driver=]driver,id=id[,prop=value[,...]]\n"
     "                specifies the audio backend to use\n"
     "                Use ``-audiodev help`` to list the available drivers\n"
     "                id= identifier of the backend\n"
@@ -840,25 +840,25 @@ DEF("audiodev", HAS_ARG, QEMU_OPTION_audiodev,
     "                valid values: s8, s16, s32, u8, u16, u32, f32\n"
     "                in|out.voices= number of voices to use\n"
     "                in|out.buffer-length= length of buffer in microseconds\n"
-    "-audiodev none,id=id,[,prop[=value][,...]]\n"
+    "-audiodev none,id=id,[,prop=value[,...]]\n"
     "                dummy driver that discards all output\n"
 #ifdef CONFIG_AUDIO_ALSA
-    "-audiodev alsa,id=id[,prop[=value][,...]]\n"
+    "-audiodev alsa,id=id[,prop=value[,...]]\n"
     "                in|out.dev= name of the audio device to use\n"
     "                in|out.period-length= length of period in microseconds\n"
     "                in|out.try-poll= attempt to use poll mode\n"
     "                threshold= threshold (in microseconds) when playback starts\n"
 #endif
 #ifdef CONFIG_AUDIO_COREAUDIO
-    "-audiodev coreaudio,id=id[,prop[=value][,...]]\n"
+    "-audiodev coreaudio,id=id[,prop=value[,...]]\n"
     "                in|out.buffer-count= number of buffers\n"
 #endif
 #ifdef CONFIG_AUDIO_DSOUND
-    "-audiodev dsound,id=id[,prop[=value][,...]]\n"
+    "-audiodev dsound,id=id[,prop=value[,...]]\n"
     "                latency= add extra latency to playback in microseconds\n"
 #endif
 #ifdef CONFIG_AUDIO_OSS
-    "-audiodev oss,id=id[,prop[=value][,...]]\n"
+    "-audiodev oss,id=id[,prop=value[,...]]\n"
     "                in|out.dev= path of the audio device to use\n"
     "                in|out.buffer-count= number of buffers\n"
     "                in|out.try-poll= attempt to use poll mode\n"
@@ -867,35 +867,35 @@ DEF("audiodev", HAS_ARG, QEMU_OPTION_audiodev,
     "                dsp-policy= set timing policy (0..10), -1 to use fragment mode\n"
 #endif
 #ifdef CONFIG_AUDIO_PA
-    "-audiodev pa,id=id[,prop[=value][,...]]\n"
+    "-audiodev pa,id=id[,prop=value[,...]]\n"
     "                server= PulseAudio server address\n"
     "                in|out.name= source/sink device name\n"
     "                in|out.latency= desired latency in microseconds\n"
 #endif
 #ifdef CONFIG_AUDIO_PIPEWIRE
-    "-audiodev pipewire,id=id[,prop[=value][,...]]\n"
+    "-audiodev pipewire,id=id[,prop=value[,...]]\n"
     "                in|out.name= source/sink device name\n"
     "                in|out.stream-name= name of pipewire stream\n"
     "                in|out.latency= desired latency in microseconds\n"
 #endif
 #ifdef CONFIG_AUDIO_SDL
-    "-audiodev sdl,id=id[,prop[=value][,...]]\n"
+    "-audiodev sdl,id=id[,prop=value[,...]]\n"
     "                in|out.buffer-count= number of buffers\n"
 #endif
 #ifdef CONFIG_AUDIO_SNDIO
-    "-audiodev sndio,id=id[,prop[=value][,...]]\n"
+    "-audiodev sndio,id=id[,prop=value[,...]]\n"
 #endif
 #ifdef CONFIG_SPICE
-    "-audiodev spice,id=id[,prop[=value][,...]]\n"
+    "-audiodev spice,id=id[,prop=value[,...]]\n"
 #endif
 #ifdef CONFIG_DBUS_DISPLAY
-    "-audiodev dbus,id=id[,prop[=value][,...]]\n"
+    "-audiodev dbus,id=id[,prop=value[,...]]\n"
 #endif
-    "-audiodev wav,id=id[,prop[=value][,...]]\n"
+    "-audiodev wav,id=id[,prop=value[,...]]\n"
     "                path= path of wav file to record\n",
     QEMU_ARCH_ALL)
 SRST
-``-audiodev [driver=]driver,id=id[,prop[=value][,...]]``
+``-audiodev [driver=]driver,id=id[,prop=value[,...]]``
     Adds a new audio backend driver identified by id. There are global
     and driver specific properties. Some values can be set differently
     for input and output, they're marked with ``in|out.``. You can set
@@ -954,11 +954,11 @@ SRST
     ``in|out.buffer-length=usecs``
         Sets the size of the buffer in microseconds.
 
-``-audiodev none,id=id[,prop[=value][,...]]``
+``-audiodev none,id=id[,prop=value[,...]]``
     Creates a dummy backend that discards all outputs. This backend has
     no backend specific properties.
 
-``-audiodev alsa,id=id[,prop[=value][,...]]``
+``-audiodev alsa,id=id[,prop=value[,...]]``
     Creates backend using the ALSA. This backend is only available on
     Linux.
 
@@ -977,7 +977,7 @@ SRST
     ``threshold=threshold``
         Threshold (in microseconds) when playback starts. Default is 0.
 
-``-audiodev coreaudio,id=id[,prop[=value][,...]]``
+``-audiodev coreaudio,id=id[,prop=value[,...]]``
     Creates a backend using Apple's Core Audio. This backend is only
     available on Mac OS and only supports playback.
 
@@ -986,7 +986,7 @@ SRST
     ``in|out.buffer-count=count``
         Sets the count of the buffers.
 
-``-audiodev dsound,id=id[,prop[=value][,...]]``
+``-audiodev dsound,id=id[,prop=value[,...]]``
     Creates a backend using Microsoft's DirectSound. This backend is
     only available on Windows and only supports playback.
 
@@ -996,7 +996,7 @@ SRST
         Add extra usecs microseconds latency to playback. Default is
         10000 (10 ms).
 
-``-audiodev oss,id=id[,prop[=value][,...]]``
+``-audiodev oss,id=id[,prop=value[,...]]``
     Creates a backend using OSS. This backend is available on most
     Unix-like systems.
 
@@ -1025,7 +1025,7 @@ SRST
         buffer sizes specified by ``buffer`` and ``buffer-count``. This
         option is ignored if you do not have OSS 4. Default is 5.
 
-``-audiodev pa,id=id[,prop[=value][,...]]``
+``-audiodev pa,id=id[,prop=value[,...]]``
     Creates a backend using PulseAudio. This backend is available on
     most systems.
 
@@ -1041,7 +1041,7 @@ SRST
         Desired latency in microseconds. The PulseAudio server will try
         to honor this value but actual latencies may be lower or higher.
 
-``-audiodev pipewire,id=id[,prop[=value][,...]]``
+``-audiodev pipewire,id=id[,prop=value[,...]]``
     Creates a backend using PipeWire. This backend is available on
     most systems.
 
@@ -1056,7 +1056,7 @@ SRST
     ``in|out.stream-name``
         Specify the name of pipewire stream.
 
-``-audiodev sdl,id=id[,prop[=value][,...]]``
+``-audiodev sdl,id=id[,prop=value[,...]]``
     Creates a backend using SDL. This backend is available on most
     systems, but you should use your platform's native backend if
     possible.
@@ -1066,7 +1066,7 @@ SRST
     ``in|out.buffer-count=count``
         Sets the count of the buffers.
 
-``-audiodev sndio,id=id[,prop[=value][,...]]``
+``-audiodev sndio,id=id[,prop=value[,...]]``
     Creates a backend using SNDIO. This backend is available on
     OpenBSD and most other Unix-like systems.
 
@@ -1079,13 +1079,13 @@ SRST
     ``in|out.latency=usecs``
         Sets the desired period length in microseconds.
 
-``-audiodev spice,id=id[,prop[=value][,...]]``
+``-audiodev spice,id=id[,prop=value[,...]]``
     Creates a backend that sends audio through SPICE. This backend
     requires ``-spice`` and automatically selected in that case, so
     usually you can ignore this option. This backend has no backend
     specific properties.
 
-``-audiodev wav,id=id[,prop[=value][,...]]``
+``-audiodev wav,id=id[,prop=value[,...]]``
     Creates a backend that writes audio to a WAV file.
 
     Backend specific options are:
@@ -1096,21 +1096,21 @@ SRST
 ERST
 
 DEF("device", HAS_ARG, QEMU_OPTION_device,
-    "-device driver[,prop[=value][,...]]\n"
+    "-device driver[,prop=value[,...]]\n"
     "                add device (based on driver)\n"
     "                prop=value,... sets driver properties\n"
     "                use '-device help' to print all possible drivers\n"
     "                use '-device driver,help' to print all possible properties\n",
     QEMU_ARCH_ALL)
 SRST
-``-device driver[,prop[=value][,...]]``
+``-device driver[,prop=value[,...]]``
     Add device driver. prop=value sets driver properties. Valid
     properties depend on the driver. To get help on possible drivers and
     properties, use ``-device help`` and ``-device driver,help``.
 
     Some drivers are:
 
-``-device ipmi-bmc-sim,id=id[,prop[=value][,...]]``
+``-device ipmi-bmc-sim,id=id[,prop=value[,...]]``
     Add an IPMI BMC. This is a simulation of a hardware management
     interface processor that normally sits on a system. It provides a
     watchdog and the ability to reset and power control the system. You
@@ -2308,19 +2308,19 @@ DEF("spice", HAS_ARG, QEMU_OPTION_spice,
     "       [,x509-dh-key-file=<file>][,addr=addr]\n"
     "       [,ipv4=on|off][,ipv6=on|off][,unix=on|off]\n"
     "       [,tls-ciphers=<list>]\n"
-    "       [,tls-channel=[main|display|cursor|inputs|record|playback]]\n"
-    "       [,plaintext-channel=[main|display|cursor|inputs|record|playback]]\n"
+    "       [,tls-channel=main|display|cursor|inputs|record|playback]\n"
+    "       [,plaintext-channel=main|display|cursor|inputs|record|playback]\n"
     "       [,sasl=on|off][,disable-ticketing=on|off]\n"
     "       [,password-secret=<secret-id>]\n"
-    "       [,image-compression=[auto_glz|auto_lz|quic|glz|lz|off]]\n"
-    "       [,jpeg-wan-compression=[auto|never|always]]\n"
-    "       [,zlib-glz-wan-compression=[auto|never|always]]\n"
-    "       [,streaming-video=[off|all|filter]][,disable-copy-paste=on|off]\n"
-    "       [,disable-agent-file-xfer=on|off][,agent-mouse=[on|off]]\n"
-    "       [,playback-compression=[on|off]][,seamless-migration=[on|off]]\n"
+    "       [,image-compression=auto_glz|auto_lz|quic|glz|lz|off]\n"
+    "       [,jpeg-wan-compression=auto|never|always]\n"
+    "       [,zlib-glz-wan-compression=auto|never|always]\n"
+    "       [,streaming-video=off|all|filter][,disable-copy-paste=on|off]\n"
+    "       [,disable-agent-file-xfer=on|off][,agent-mouse=on|off]\n"
+    "       [,playback-compression=on|off][,seamless-migration=on|off]\n"
     "       [,video-codec=<codec>\n"
     "       [,max-refresh-rate=rate\n"
-    "       [,gl=[on|off]][,rendernode=<file>]\n"
+    "       [,gl=on|off][,rendernode=<file>]\n"
     "                enable spice\n"
     "                at least one of {port, tls-port} is mandatory\n",
     QEMU_ARCH_ALL)
@@ -2380,7 +2380,7 @@ SRST
     ``tls-ciphers=<list>``
         Specify which ciphers to use.
 
-    ``tls-channel=[main|display|cursor|inputs|record|playback]``; \ ``plaintext-channel=[main|display|cursor|inputs|record|playback]``
+    ``tls-channel=main|display|cursor|inputs|record|playback``; \ ``plaintext-channel=main|display|cursor|inputs|record|playback``
         Force specific channel to be used with or without TLS
         encryption. The options can be specified multiple times to
         configure multiple channels. The special name "default" can be
@@ -2388,24 +2388,24 @@ SRST
         explicitly forced into one mode the spice client is allowed to
         pick tls/plaintext as he pleases.
 
-    ``image-compression=[auto_glz|auto_lz|quic|glz|lz|off]``
+    ``image-compression=auto_glz|auto_lz|quic|glz|lz|off``
         Configure image compression (lossless). Default is auto\_glz.
 
-    ``jpeg-wan-compression=[auto|never|always]``; \ ``zlib-glz-wan-compression=[auto|never|always]``
+    ``jpeg-wan-compression=auto|never|always``; \ ``zlib-glz-wan-compression=auto|never|always``
         Configure wan image compression (lossy for slow links). Default
         is auto.
 
-    ``streaming-video=[off|all|filter]``
+    ``streaming-video=off|all|filter``
         Configure video stream detection. Default is off.
 
-    ``agent-mouse=[on|off]``
+    ``agent-mouse=on|off``
         Enable/disable passing mouse events via vdagent. Default is on.
 
-    ``playback-compression=[on|off]``
+    ``playback-compression=on|off``
         Enable/disable audio stream compression (using celt 0.5.1).
         Default is on.
 
-    ``seamless-migration=[on|off]``
+    ``seamless-migration=on|off``
         Enable/disable spice seamless migration. Default is off.
 
     ``video-codec=<codec>``
@@ -2419,7 +2419,7 @@ SRST
         Provide the maximum refresh rate (or FPS) at which the encoding
         requests should be sent to the Spice server. Default would be 30.
 
-    ``gl=[on|off]``
+    ``gl=on|off``
         Enable/disable OpenGL context. Default is off.
 
     ``rendernode=<file>``
@@ -2649,7 +2649,7 @@ SRST
         bandwidth when playing videos. Disabling adaptive encodings
         restores the original static behavior of encodings like Tight.
 
-    ``share=[allow-exclusive|force-shared|ignore]``
+    ``share=allow-exclusive|force-shared|ignore``
         Set display sharing policy. 'allow-exclusive' allows clients to
         ask for exclusive access. As suggested by the rfb spec this is
         implemented by dropping other connections. Connecting multiple
@@ -4823,9 +4823,9 @@ SRST
 ERST
 
 DEF("mon", HAS_ARG, QEMU_OPTION_mon, \
-    "-mon [chardev=]name[,mode=readline|control][,pretty[=on|off]]\n", QEMU_ARCH_ALL)
+    "-mon [chardev=]name[,mode=readline|control][,pretty=on|off]\n", QEMU_ARCH_ALL)
 SRST
-``-mon [chardev=]name[,mode=readline|control][,pretty[=on|off]]``
+``-mon [chardev=]name[,mode=readline|control][,pretty=on|off]``
     Set up a monitor connected to the chardev ``name``.
     QEMU supports two monitors: the Human Monitor Protocol
     (HMP; for human interaction), and the QEMU Monitor Protocol
@@ -5514,14 +5514,14 @@ ERST
 #endif
 
 DEF("msg", HAS_ARG, QEMU_OPTION_msg,
-    "-msg [timestamp[=on|off]][,guest-name=[on|off]]\n"
+    "-msg [timestamp=on|off][,guest-name=on|off]\n"
     "                control error message format\n"
     "                timestamp=on enables timestamps (default: off)\n"
     "                guest-name=on enables guest name prefix but only if\n"
     "                              -name guest option is set (default: off)\n",
     QEMU_ARCH_ALL)
 SRST
-``-msg [timestamp[=on|off]][,guest-name[=on|off]]``
+``-msg [timestamp=on|off][,guest-name=on|off]``
     Control error message format.
 
     ``timestamp=on|off``
-- 
2.52.0


