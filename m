Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2438C61DC4
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 19:43:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzJWs-0006sN-Gf; Wed, 26 Aug 2026 15:43:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wzJWq-0006ei-B2
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 15:43:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wzJWo-0006df-8k
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 15:43:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787773397;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z3E4l/9ZBojjapKTPoc2rkBnvoRHsP4FarABuj8M8OA=;
 b=IYL6yjKqB8rMP9yWfQilLSpjWsgXF9KWcSkYoM0QhGQZOgpYXFpkNk4Otyv3kS8kga3Mps
 w8gFhDCLbqvoX/vcZbd7XixBNgbmIlHVVXHwObvDgqNpAd0TVhhGpGdQ+oy7yThZqWLFao
 HHYDQvRYp5HrCZ2LPcIs/AbGyVql85k=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-645-JqlXIFKKNV-almMHhD17wQ-1; Wed,
 26 Aug 2026 15:43:15 -0400
X-MC-Unique: JqlXIFKKNV-almMHhD17wQ-1
X-Mimecast-MFC-AGG-ID: JqlXIFKKNV-almMHhD17wQ_1787773390
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1A434184BAAB; Wed, 26 Aug 2026 19:43:10 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.99])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 14F1318005AC; Wed, 26 Aug 2026 19:43:04 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 John Snow <jsnow@redhat.com>, linux-cxl@vger.kernel.org,
 Markus Armbruster <armbru@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Peter Xu <peterx@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 zhenwei pi <zhenwei.pi@linux.dev>, qemu-trivial@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Jiri Pirko <jiri@resnulli.us>,
 qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, linux-edac@vger.kernel.org,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Jonathan Cameron <jic23@kernel.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Jason Wang <jasowangio@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Lukas Straub <lukasstraub2@web.de>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v3 30/43] qapi: convert trivial intro sections for audio.json
Date: Wed, 26 Aug 2026 15:38:27 -0400
Message-ID: <20260826193840.2152000-31-jsnow@redhat.com>
In-Reply-To: <20260826193840.2152000-1-jsnow@redhat.com>
References: <20260826193840.2152000-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/audio.json | 88 ++++++++++++++++++-------------------------------
 1 file changed, 32 insertions(+), 56 deletions(-)

diff --git a/qapi/audio.json b/qapi/audio.json
index 2df87b97101..72190f20993 100644
--- a/qapi/audio.json
+++ b/qapi/audio.json
@@ -14,9 +14,8 @@
 
 ##
 # @AudiodevPerDirectionOptions:
-#
-# General audio backend options that are used for both playback and
-# recording.
+#     General audio backend options that are used for both playback
+#     and recording.
 #
 # @mixing-engine: use QEMU's mixing engine to mix all streams inside
 #     QEMU and convert audio formats when not supported by the
@@ -53,8 +52,7 @@
 
 ##
 # @AudiodevGenericOptions:
-#
-# Generic driver-specific options.
+#     Generic driver-specific options.
 #
 # @in: options of the capture stream
 #
@@ -69,8 +67,7 @@
 
 ##
 # @AudiodevDBusOptions:
-#
-# Options of the D-Bus audio backend.
+#     Options of the D-Bus audio backend.
 #
 # @in: options of the capture stream
 #
@@ -89,9 +86,8 @@
 
 ##
 # @AudiodevAlsaPerDirectionOptions:
-#
-# Options of the ALSA backend that are used for both playback and
-# recording.
+#     Options of the ALSA backend that are used for both playback and
+#     recording.
 #
 # @dev: the name of the ALSA device to use (default 'default')
 #
@@ -111,8 +107,7 @@
 
 ##
 # @AudiodevAlsaOptions:
-#
-# Options of the ALSA audio backend.
+#     Options of the ALSA audio backend.
 #
 # @in: options of the capture stream
 #
@@ -130,8 +125,7 @@
 
 ##
 # @AudiodevSndioOptions:
-#
-# Options of the sndio audio backend.
+#     Options of the sndio audio backend.
 #
 # @in: options of the capture stream
 #
@@ -152,9 +146,8 @@
 
 ##
 # @AudiodevCoreaudioPerDirectionOptions:
-#
-# Options of the Core Audio backend that are used for both playback
-# and recording.
+#     Options of the Core Audio backend that are used for both
+#     playback and recording.
 #
 # @buffer-count: number of buffers
 #
@@ -167,8 +160,7 @@
 
 ##
 # @AudiodevCoreaudioOptions:
-#
-# Options of the coreaudio audio backend.
+#     Options of the coreaudio audio backend.
 #
 # @in: options of the capture stream
 #
@@ -183,8 +175,7 @@
 
 ##
 # @AudiodevDsoundOptions:
-#
-# Options of the DirectSound audio backend.
+#     Options of the DirectSound audio backend.
 #
 # @in: options of the capture stream
 #
@@ -203,9 +194,8 @@
 
 ##
 # @AudiodevJackPerDirectionOptions:
-#
-# Options of the JACK backend that are used for both playback and
-# recording.
+#     Options of the JACK backend that are used for both playback and
+#     recording.
 #
 # @server-name: select from among several possible concurrent server
 #     instances (default: environment variable $JACK_DEFAULT_SERVER if
@@ -237,8 +227,7 @@
 
 ##
 # @AudiodevJackOptions:
-#
-# Options of the JACK audio backend.
+#     Options of the JACK audio backend.
 #
 # @in: options of the capture stream
 #
@@ -253,9 +242,8 @@
 
 ##
 # @AudiodevOssPerDirectionOptions:
-#
-# Options of the OSS backend that are used for both playback and
-# recording.
+#     Options of the OSS backend that are used for both playback and
+#     recording.
 #
 # @dev: file name of the OSS device (default '/dev/dsp')
 #
@@ -275,8 +263,7 @@
 
 ##
 # @AudiodevOssOptions:
-#
-# Options of the OSS audio backend.
+#     Options of the OSS audio backend.
 #
 # @in: options of the capture stream
 #
@@ -305,9 +292,8 @@
 
 ##
 # @AudiodevPaPerDirectionOptions:
-#
-# Options of the Pulseaudio backend that are used for both playback
-# and recording.
+#     Options of the Pulseaudio backend that are used for both
+#     playback and recording.
 #
 # @name: name of the sink/source to use
 #
@@ -330,8 +316,7 @@
 
 ##
 # @AudiodevPaOptions:
-#
-# Options of the PulseAudio audio backend.
+#     Options of the PulseAudio audio backend.
 #
 # @in: options of the capture stream
 #
@@ -349,9 +334,8 @@
 
 ##
 # @AudiodevPipewirePerDirectionOptions:
-#
-# Options of the PipeWire backend that are used for both playback and
-# recording.
+#     Options of the PipeWire backend that are used for both playback
+#     and recording.
 #
 # @name: name of the sink/source to use
 #
@@ -374,8 +358,7 @@
 
 ##
 # @AudiodevPipewireOptions:
-#
-# Options of the PipeWire audio backend.
+#     Options of the PipeWire audio backend.
 #
 # @in: options of the capture stream
 #
@@ -390,9 +373,8 @@
 
 ##
 # @AudiodevSdlPerDirectionOptions:
-#
-# Options of the SDL audio backend that are used for both playback and
-# recording.
+#     Options of the SDL audio backend that are used for both playback
+#     and recording.
 #
 # @buffer-count: number of buffers (default 4)
 #
@@ -405,8 +387,7 @@
 
 ##
 # @AudiodevSdlOptions:
-#
-# Options of the SDL audio backend.
+#     Options of the SDL audio backend.
 #
 # @in: options of the recording stream
 #
@@ -421,8 +402,7 @@
 
 ##
 # @AudiodevWavOptions:
-#
-# Options of the wav audio backend.
+#     Options of the wav audio backend.
 #
 # @in: options of the capture stream
 #
@@ -440,8 +420,7 @@
 
 ##
 # @AudioFormat:
-#
-# An enumeration of possible audio formats.
+#     An enumeration of possible audio formats.
 #
 # @u8: unsigned 8 bit integer
 #
@@ -464,8 +443,7 @@
 
 ##
 # @AudiodevDriver:
-#
-# An enumeration of possible audio backend drivers.
+#     An enumeration of possible audio backend drivers.
 #
 # @jack: JACK audio backend (since 5.1)
 #
@@ -488,8 +466,7 @@
 
 ##
 # @Audiodev:
-#
-# Options of an audio backend.
+#     Options of an audio backend.
 #
 # @id: identifier of the backend
 #
@@ -534,8 +511,7 @@
 
 ##
 # @query-audiodevs:
-#
-# Return information about audiodev configuration
+#     Return information about audiodev configuration
 #
 # Since: 8.0
 ##
-- 
2.55.0


