Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36C50C88E41
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 20:45:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4lds-00083f-UW; Thu, 10 Sep 2026 16:45:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lFn-0000gy-NS
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:20:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lFX-0007ED-Qg
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:20:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789071387;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ztnEzJr9cLGP85wdavmJjLJZCpMNN2vWplsbH2YazF8=;
 b=NtFry1IOnVVG7VtddtNt4Y0CJv3pEp/sV9+59jMijsMetpTBxjmAKEOf44LDB9Zkduw/eU
 ZmrGiMLkYSk8QmrRyoYhlokobWO3jCSRuCP5mW3ooqev0M2nIRu/YkknutnFrN/mN9C99t
 gV2a6lz10m+u/SyF8nSnxHvKu2E3Rjc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-jmgcZ_zRPlWIZS8F6UNYOg-1; Thu, 10 Sep 2026 16:15:21 -0400
X-MC-Unique: jmgcZ_zRPlWIZS8F6UNYOg-1
X-Mimecast-MFC-AGG-ID: jmgcZ_zRPlWIZS8F6UNYOg_1789071318
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-47f4bff865cso79553f8f.0
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 13:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789071318; x=1789676118; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ztnEzJr9cLGP85wdavmJjLJZCpMNN2vWplsbH2YazF8=;
 b=E1s2mSAzgL9tiIpCejdQJWsc5Afk2bOdypw7iHuUvKH+p7VNPU+gzO1JWFgfdF9yXG
 CmKRMembm1EP2hPtD+UL8FNGN0TIionQKGhVZGsgY46Xrp9cFf4RxyUtH9ZaonajFalX
 7nm9aFbESQuT7d3MwBdsmpjS8cZ0o9exiSmeyV9XnuM6AL5nS4a8JfWfDDgHbeyT1m+n
 FYtmQtOcp9ZnPwreI47FAwqFrJkrJvGoMRA+RYxpJBONYhPxj631860Ifl1D8DGPwrGz
 2TgKrBlCOB+uoMkWRecFzEqaWGfgoeNDCrRr/9CajuB0RVqmdJ/0/pRf9GaDuQIn3FkH
 ocOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789071318; x=1789676118;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ztnEzJr9cLGP85wdavmJjLJZCpMNN2vWplsbH2YazF8=;
 b=ClWBy9G0bUKvqeglI5DPWuVGXsRGKiZ33MezT0ZbF/guL9XFlKnFRO8+kpMGJzdA7Z
 Bx86Zhh3eHgG/Tdh9rtlPOeaDLRuGNDdxfrC/pvXqhgjoZH8qQI6cfLulFANVstkXBsF
 r62P9mOY+JP73FXp4F1EnwyMYy+deo2NtDYckuaiZgleP+7lgNud2RCv9WnHMEAmCz5Z
 hcuT1yIPh6T4nzYzaOCsh7jw/fZvQByiUpWwyjZLUU0KmjgzHMcsG2wLPxdCjnK3ZFpn
 5xEot2jgSX6wDFr9cr29gTe0DeqFGlOdhEWGkVeBtdasGpWLY87TVfVQg6t3I0IE84Z2
 4Mgg==
X-Gm-Message-State: AFuF++lM9eNmCIwkVljls5k7KsGxEbN0SWXarbtnvIkJ4dGS490s1SFX
 q2MSNojl5vpQg92GtulOfU2DhhV/hYdbm/p9iRU9je8h0HQwOgHCqEY6Y/I8vKs6elCW0WvLAyM
 vyuKXAqurN7WleOdHYApUYwTIpa4uuR1jH/DJIvoAIx46NgV/gyi/qFl8G/vZunMdfdRCJAsNa6
 QZfLY+DQco8kCZiZQdlqpC1q/sbG6KXC2wLg==
X-Gm-Gg: AYBFou04QViDUZTXdOSzIfU/DUhirxcu4sifJFXVWSXiOS2ZAwdUcEx43BHKr2CfLvY
 QPcbMoFx+OPPvGBmgqGUWHCZt/1F4ezx91y48hQgmWZ2gJ0JH41/LQKXxq/vHDHAuiNxqg3sCe8
 Bs49x+YH6BDd6zpiPHc6Izw3BYDhT46kr2cYiCFq7PiNXFkH7Yxm7UhniqsoB/QjbMHqQdzIKUh
 RLMbWVbDXe+Nmq4R+z7GY5tnERRv7X7n1UMYhsMRx8UOLTR/QnLRiaJCuLOcd0v5I3UrQRhgT75
 XGFK6ms2LlU0CJ0rNW4bw1WZWHwTaL1fzRZ6wyXRxTUjNmagFnRBKwLH5WzbWHTxib5eKzAc4Ct
 aDF209FBmbiyrizTENHX6kF0=
X-Received: by 2002:a5d:5290:0:b0:485:8b5d:96d with SMTP id
 ffacd0b85a97d-486eb324d34mr1121186f8f.19.1789071317902; 
 Thu, 10 Sep 2026 13:15:17 -0700 (PDT)
X-Received: by 2002:a5d:5290:0:b0:485:8b5d:96d with SMTP id
 ffacd0b85a97d-486eb324d34mr1121122f8f.19.1789071317305; 
 Thu, 10 Sep 2026 13:15:17 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb36e4a6sm814696f8f.37.2026.09.10.13.15.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 13:15:14 -0700 (PDT)
Date: Thu, 10 Sep 2026 16:15:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PULL 77/90] hw/acpi: Make AcpiGedState const in build_ged_aml()
Message-ID: <c615b7ff5bbcf82b88d8bfe12393f27715d3669e.1789071043.git.mst@redhat.com>
References: <cover.1789071042.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1789071042.git.mst@redhat.com>
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


