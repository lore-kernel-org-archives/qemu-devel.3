Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF022606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 13:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=a8Q5vP0l
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMQ0u-0005te-Fz; Thu, 29 Oct 2026 09:17:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xMPwv-0008Fm-6j
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 09:13:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xMPwt-0006Nr-39
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 09:13:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793279622;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q9/PReUZC5C2YCOV67favYLk9s0ugojGh4PmokjmDpQ=;
 b=a8Q5vP0lQJGuhuH8mixJysQ6+nEdroVimiW7F00xUJ+gXUjwPH7GGg0Z5B5+GXiTVBZLJX
 ElhbBIquX7mvswvw+6x0qqm04mRD8iEy2uK1O6I7aNwB+DOiDns2NqXFncMFY9Z6su6Woh
 cnh30oSp3tyO2ls6ql+/dsKcaOIfGLg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-150-x7ctSV7WOtCu0UVBxFz5JA-1; Thu,
 29 Oct 2026 09:13:38 -0400
X-MC-Unique: x7ctSV7WOtCu0UVBxFz5JA-1
X-Mimecast-MFC-AGG-ID: x7ctSV7WOtCu0UVBxFz5JA_1793279616
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6ABBA180034C; Thu, 29 Oct 2026 13:13:36 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1EDDB3000723; Thu, 29 Oct 2026 13:13:33 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-ppc@nongnu.org, qemu-block@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 18/28] hw/audio: mark Intel HDA devices & codecs as secure
Date: Thu, 29 Oct 2026 13:12:31 +0000
Message-ID: <20261029131241.2275706-19-berrange@redhat.com>
In-Reply-To: <20261029131241.2275706-1-berrange@redhat.com>
References: <20261029131241.2275706-1-berrange@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This is traditionally the primary audio backend for x86 as
virtio-snd is a relatively new invention.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/audio/hda-codec.c | 3 +++
 hw/audio/intel-hda.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/hw/audio/hda-codec.c b/hw/audio/hda-codec.c
index 173fe56bea3..ee0d18c4caa 100644
--- a/hw/audio/hda-codec.c
+++ b/hw/audio/hda-codec.c
@@ -873,6 +873,7 @@ static const TypeInfo hda_audio_output_info = {
     .name          = "hda-output",
     .parent        = TYPE_HDA_AUDIO,
     .class_init    = hda_audio_output_class_init,
+    .secure        = true,
 };
 
 static void hda_audio_duplex_class_init(ObjectClass *klass, const void *data)
@@ -888,6 +889,7 @@ static const TypeInfo hda_audio_duplex_info = {
     .name          = "hda-duplex",
     .parent        = TYPE_HDA_AUDIO,
     .class_init    = hda_audio_duplex_class_init,
+    .secure        = true,
 };
 
 static void hda_audio_micro_class_init(ObjectClass *klass, const void *data)
@@ -903,6 +905,7 @@ static const TypeInfo hda_audio_micro_info = {
     .name          = "hda-micro",
     .parent        = TYPE_HDA_AUDIO,
     .class_init    = hda_audio_micro_class_init,
+    .secure        = true,
 };
 
 static void hda_audio_register_types(void)
diff --git a/hw/audio/intel-hda.c b/hw/audio/intel-hda.c
index 3d361a4976c..b4695981e47 100644
--- a/hw/audio/intel-hda.c
+++ b/hw/audio/intel-hda.c
@@ -45,6 +45,7 @@ static const TypeInfo hda_codec_bus_info = {
     .name = TYPE_HDA_BUS,
     .parent = TYPE_BUS,
     .instance_size = sizeof(HDACodecBus),
+    .secure = true,
 };
 
 void hda_codec_bus_init(DeviceState *dev, HDACodecBus *bus, size_t bus_size,
@@ -1275,12 +1276,14 @@ static const TypeInfo intel_hda_info_ich6 = {
     .name          = "intel-hda",
     .parent        = TYPE_INTEL_HDA_GENERIC,
     .class_init    = intel_hda_class_init_ich6,
+    .secure        = true,
 };
 
 static const TypeInfo intel_hda_info_ich9 = {
     .name          = "ich9-intel-hda",
     .parent        = TYPE_INTEL_HDA_GENERIC,
     .class_init    = intel_hda_class_init_ich9,
+    .secure        = true,
 };
 
 static void hda_codec_device_class_init(ObjectClass *klass, const void *data)
-- 
2.56.0


