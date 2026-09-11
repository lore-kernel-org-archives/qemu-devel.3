Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC935C88E4C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 09:12:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4xBI-0007Wx-VU; Fri, 11 Sep 2026 05:04:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4xAm-0004tr-0x
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:03:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4xAk-0008NP-Ct
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:03:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789117429;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ztnEzJr9cLGP85wdavmJjLJZCpMNN2vWplsbH2YazF8=;
 b=f/jydRMY8hF8yepxZM14X3h+7H62+mUp2XL11y5TuLKk5NQzHdhVuyB5e8qJfSNMsLB0jd
 eoVgBrSHFiYqInMQDnlNzx6xtpeP+thw45Hz0VYbDPohhQQTdBaBCErZErK196bUVpTNp5
 oyV+VgT55Nsg0X/CfauxebZVYC01Flw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-gB6eVd4sP2GoTpRU7CD-8g-1; Fri, 11 Sep 2026 05:03:48 -0400
X-MC-Unique: gB6eVd4sP2GoTpRU7CD-8g-1
X-Mimecast-MFC-AGG-ID: gB6eVd4sP2GoTpRU7CD-8g_1789117427
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-4839f9edb08so340935f8f.0
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 02:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789117427; x=1789722227; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ztnEzJr9cLGP85wdavmJjLJZCpMNN2vWplsbH2YazF8=;
 b=ehBM6RkRCEyvTjvrmar1Ie1erl1PDbr4QtkhGjhdf5t2ffeFTJyctPsgkWTWCn/YRF
 ov7K11adSO203GNWfE0LHEFeio+dqvJRYNOLA+CDkEvu1d6BWPI/rVrTfTyUx48GrbYt
 rIPK0Q3UPrPDZm7u75I1/Ayuhlt42ykgmvP9bWabhZG3B/0/UvsvKQx9pQEog9JnlT84
 I1hBuD0tum0LJ5g3aL7yAxHASj70QcHHbA8x3z4DFGyMKt9MyC4nm9eWWYGhr8Hd4bvj
 FZ+xJ4X+0f0717naby0nPJdBoWW7yKTZbHHIafIHJYBbmWoyxTXMKYjqWgKJ+8wKwuO/
 IG2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789117427; x=1789722227;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ztnEzJr9cLGP85wdavmJjLJZCpMNN2vWplsbH2YazF8=;
 b=cFdTLsez6FMrTG4LHLiyrBeIKPf+3Kz37ofLSFKEakYL1yuPf8LHxEjqS+Id/CDZQT
 AOQ39IdbB+M1WGMNXo+n/nVcaupRmS06eUtq5nyjJCnYGiGnsSNlIzWV0k4a5Ms01hh+
 HsdjM1q+HEn0E5XYMy02jO+HhEOfYPqJTmGeNW/lIg91Jth++jB1lDdlXhNHF1R3ruAl
 amEoHXdf0/18L68tiHljIJx8pOUsMcWPw4Ifeh4iBjVtRnTT4oQ7pF+gJ3XuWRts6imC
 kS4LDErpOcM8p3F3iTO8GCCQP1cv6W/ITMnXakIDZJEBBduNV6VQPcZavWxTgSaGcP0i
 tflg==
X-Gm-Message-State: AFuF++mGJprlzWm86B5TUm1CZJXJy+hoP6pu87A4SCzZ7+gu0dwyZaXh
 ymSe2FbKyjMmKftQGU6LLQOyareh5ATgEzimBPF/U9lRpqY26UGO8SLTAN1H0xvjlDFteSIlLuu
 afldzCOFX3r/w3zTZfJ6nfnXHwA8YMRuI8VtpaigBn9v+b3Eo5Ffscn7kQylC03SX3hPaPr8P4Q
 e4foLo/WorKBdUySK30JT6UB42bYLvDU/piw==
X-Gm-Gg: AYBFou2KHPOcoU2cqXOf2k0fcpQnmyw+LVRURtE94oS0UBiojgs88H1F+kfqZ7SxNMY
 4MGcQ/GeN2GUPs1dmxOkGv0lWQaEhDGG/2Et2AqBFwFlNu/daqHKL2oslsBVwLExN+pnRpL0S2C
 hGGsI4/MztqhZcknjLxGzZe68vQZ2sUWaBoDVBsdrSail6NTPb/UxuCMI4XyEPTkD97Yei+Joia
 /5BHYRB0b3KueJgg3W7EC6SblJqcAAKwTFdohzf/PLTqKJwxn9GgcNrDe2IXQ1P4OoLFNyYYalx
 MiuNDGEHsy2yG0pdSog24A8/mg/uqRs/LVtwpsO2RUD/MKxLh/y0mP/Hu7KMvySsYGtUH1lwZCA
 i0YNQjWyNTBqvxo0PcqSzP0Y=
X-Received: by 2002:a05:6000:a8c:b0:485:8c17:9767 with SMTP id
 ffacd0b85a97d-486eb30c413mr2614982f8f.41.1789117427085; 
 Fri, 11 Sep 2026 02:03:47 -0700 (PDT)
X-Received: by 2002:a05:6000:a8c:b0:485:8c17:9767 with SMTP id
 ffacd0b85a97d-486eb30c413mr2614933f8f.41.1789117426572; 
 Fri, 11 Sep 2026 02:03:46 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb330bdcsm4741514f8f.13.2026.09.11.02.03.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 02:03:46 -0700 (PDT)
Date: Fri, 11 Sep 2026 05:03:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PULL v2 62/75] hw/acpi: Make AcpiGedState const in build_ged_aml()
Message-ID: <5f5774ec8e4b7c4d00e68879fbabe00477ce244d.1789117222.git.mst@redhat.com>
References: <cover.1789117222.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1789117222.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

From: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

build_ged_aml() do not modify the AcpiGedState structure.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260903230245.65601-2-philmd@oss.qualcomm.com>
---
 hw/acpi/generic_event_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
index 67c9e9b3e8..5225e32513 100644
--- a/hw/acpi/generic_event_device.c
+++ b/hw/acpi/generic_event_device.c
@@ -48,7 +48,7 @@ static const uint32_t ged_supported_events[] = {
 void build_ged_aml(Aml *table, const char *name, HotplugHandler *hotplug_dev,
                    uint32_t ged_irq, AmlRegionSpace rs, hwaddr ged_base)
 {
-    AcpiGedState *s = ACPI_GED(hotplug_dev);
+    const AcpiGedState *s = ACPI_GED(hotplug_dev);
     Aml *crs = aml_resource_template();
     Aml *evt, *field;
     Aml *dev = aml_device("%s", name);
-- 
MST


