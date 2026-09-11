Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D37B8C88E45
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 14:52:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x52UX-0004vA-Uy; Fri, 11 Sep 2026 10:44:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x52Nm-0002sS-38
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 10:37:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x52NT-0008Ak-2r
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 10:37:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789137438;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yxYKHi5v7tz+GMZ37WJGGk/4FLpJ0TR7q5S8Sx5LFw0=;
 b=Mqxgw8o86ko90H9A1uV6NIUpUYjGQXzkS7zoHzcn+A+GlztIrRmH49un2Wi+E9UT7BhUBe
 HH2oWDiT5wXOsyxx+Ime8Vt6bmFXd03wewaEbDgtIfz4z4nT9K416UAuiEKjV23rws8OVX
 +HLG15iPiYhIymCNFa+EExhI2vfmIWQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-179-i4RerftSO0aK-nu0DOj5Rw-1; Fri,
 11 Sep 2026 10:37:16 -0400
X-MC-Unique: i4RerftSO0aK-nu0DOj5Rw-1
X-Mimecast-MFC-AGG-ID: i4RerftSO0aK-nu0DOj5Rw_1789137435
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 757F7195396B; Fri, 11 Sep 2026 14:37:15 +0000 (UTC)
Received: from berrange.csb (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 69BE13000229; Fri, 11 Sep 2026 14:37:13 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org, qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 qemu-block@nongnu.org, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 20/28] hw/audio: mark Intel HDA devices & codecs as secure
Date: Fri, 11 Sep 2026 15:36:19 +0100
Message-ID: <20260911143627.2743803-21-berrange@redhat.com>
In-Reply-To: <20260911143627.2743803-1-berrange@redhat.com>
References: <20260911143627.2743803-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This is traditionally the primary audio backend for x86 as
virtio-snd is a relatively new invention.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/audio/hda-codec.c | 4 ++++
 hw/audio/intel-hda.c | 5 +++++
 2 files changed, 9 insertions(+)

diff --git a/hw/audio/hda-codec.c b/hw/audio/hda-codec.c
index 173fe56bea..05bd35700f 100644
--- a/hw/audio/hda-codec.c
+++ b/hw/audio/hda-codec.c
@@ -858,6 +858,7 @@ static const TypeInfo hda_audio_info = {
     .instance_size = sizeof(HDAAudioState),
     .class_init    = hda_audio_base_class_init,
     .abstract      = true,
+    .secure        = true,
 };
 
 static void hda_audio_output_class_init(ObjectClass *klass, const void *data)
@@ -873,6 +874,7 @@ static const TypeInfo hda_audio_output_info = {
     .name          = "hda-output",
     .parent        = TYPE_HDA_AUDIO,
     .class_init    = hda_audio_output_class_init,
+    .secure        = true,
 };
 
 static void hda_audio_duplex_class_init(ObjectClass *klass, const void *data)
@@ -888,6 +890,7 @@ static const TypeInfo hda_audio_duplex_info = {
     .name          = "hda-duplex",
     .parent        = TYPE_HDA_AUDIO,
     .class_init    = hda_audio_duplex_class_init,
+    .secure        = true,
 };
 
 static void hda_audio_micro_class_init(ObjectClass *klass, const void *data)
@@ -903,6 +906,7 @@ static const TypeInfo hda_audio_micro_info = {
     .name          = "hda-micro",
     .parent        = TYPE_HDA_AUDIO,
     .class_init    = hda_audio_micro_class_init,
+    .secure        = true,
 };
 
 static void hda_audio_register_types(void)
diff --git a/hw/audio/intel-hda.c b/hw/audio/intel-hda.c
index 3d361a4976..34ca1e713c 100644
--- a/hw/audio/intel-hda.c
+++ b/hw/audio/intel-hda.c
@@ -45,6 +45,7 @@ static const TypeInfo hda_codec_bus_info = {
     .name = TYPE_HDA_BUS,
     .parent = TYPE_BUS,
     .instance_size = sizeof(HDACodecBus),
+    .secure = true,
 };
 
 void hda_codec_bus_init(DeviceState *dev, HDACodecBus *bus, size_t bus_size,
@@ -1265,6 +1266,7 @@ static const TypeInfo intel_hda_info = {
     .instance_size = sizeof(IntelHDAState),
     .class_init    = intel_hda_class_init,
     .abstract      = true,
+    .secure        = true,
     .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
@@ -1275,12 +1277,14 @@ static const TypeInfo intel_hda_info_ich6 = {
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
@@ -1298,6 +1302,7 @@ static const TypeInfo hda_codec_device_type_info = {
     .parent = TYPE_DEVICE,
     .instance_size = sizeof(HDACodecDevice),
     .abstract = true,
+    .secure = true,
     .class_size = sizeof(HDACodecDeviceClass),
     .class_init = hda_codec_device_class_init,
 };
-- 
2.55.0


