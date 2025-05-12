Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17C20C3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 08:44:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEOlp-0004WZ-0W; Mon, 12 May 2025 04:44:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEOjT-0008Lm-5w
 for qemu-devel@nongnu.org; Mon, 12 May 2025 04:41:57 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEOjM-0001oq-OC
 for qemu-devel@nongnu.org; Mon, 12 May 2025 04:41:54 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-441d1ed82dbso44926305e9.0
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 01:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747039307; x=1747644107; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DxDElVV2Vn4WLDsSj0otIlxNm5IFXNud0/Q6aYpzZPw=;
 b=riW86SrPScdQsmfSEg5dJ56NCU6Ioa/B1+ntXLH9ZAzgTqLxv6a11YuZtnH9Lbbkvh
 7bv/WpmKSWPocFCTGYkd8tpi/019bMNnyhiTsBJRKgGbPGjkwr2Ux0EmlVX+4uwzRNDQ
 fV73Rqm0BEa72O2k2kNpQ0foUV/XL1tbBKYkn9wZewbkZ+nQh8sK6pt4pgQCjETaxjcD
 FkJEgRMw+938iJEk9dEDl/NpCs1WKdnHtgXE/CcmRDz9/5oWIFLWaJi8IfV9OMCQqMP9
 3Y0uZNnXqgF5hDRIzqmMPKmfZ9Ge+0B4mKkbUOtxMf0OvctDnD82xANs9LZ3k2bgHrkC
 Dr+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747039307; x=1747644107;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DxDElVV2Vn4WLDsSj0otIlxNm5IFXNud0/Q6aYpzZPw=;
 b=KPwc9UNsPpIMQDBma7FteDn5eTIQIKyY/+8JRUIwPBvTpYyx6YlZIgrUiPcwPLm/Xi
 22JdQf2neCJHPOUe8ic6A6SRpc3NXrJVkaw4HaBqk77M8g/IAo+5cnzBvYZPg1AydNrK
 ZPp36cfSbd08qVHFoXJKnrj7iNh5z60RoRNQx3B/6xnOwh5gMfFHTzBc0vBm6+J+U2z9
 3Jp4UPWcV2SgkdFWPGBGxkpwomYKcDXxagZzEutY1yERWRO0sFgPSqg3BCKD4h2si/MF
 sjanJtF3aLI2EMH2i7tgRegkRIkwOhIuXhUGzIhd09wvvAC6oAtWRkseWL7t7ZVeJKyC
 oCxA==
X-Gm-Message-State: AOJu0YwIf0McvhHxkNV2CO2tYCR7oK5ph4lQVNk0TaX7qsQF+K0zKKI+
 bFCLpmy1ibIn53Jhb6NAKTI/lpYCUQo7m39Vytn/lExJvApyisn24B3C2UpL3EOFmkMpnrLrq4S
 a4r0ILg==
X-Gm-Gg: ASbGncsqJzyWnlj1syonU8A3h/1ST9mOVugDWBYpERQGTxG+Ht2/pYGZR4nwoTRZTyi
 RKLHYzLxl+EKgfoY0vrmqD8d0RrBBMcpR6R1o9FMeW2Jl0z/Ir0vss0HOd+mSmfFfkNPvWtrHct
 i+cGcfYm4YFqhI670Wkh5VXLPDWxpnDl8Ex1+aSpVLXSqDsImFEWXRYD1QKQ7PG95wwsTDg/pWP
 w3rDM9LxIfNglGvHjtun1R3prz4nSPEdkQm4vtOcb5tcj0xWFF8HtQpmIkpoKfKMsjgufoisuZh
 +j+1vwnqJGvo5zNquxKRxTSdlrmy9IrHYBST+5H92zWMRFCLApXuqTyiNjgvhcmjphB8nZ+cveo
 6CVXlMQy8g7z2CSMujaiiMPA=
X-Google-Smtp-Source: AGHT+IHSZn0j1/bf5F0GUy7+IWxg3oZ/kwTXbk+ouvCctlO35s5rZukw3vE5WG25jrFh4RpxhEPxiQ==
X-Received: by 2002:a05:600c:34ca:b0:43c:f8fc:f6a6 with SMTP id
 5b1f17b1804b1-442d6d37115mr115193495e9.9.1747039306695; 
 Mon, 12 May 2025 01:41:46 -0700 (PDT)
Received: from localhost.localdomain (129.163.185.81.rev.sfr.net.
 [81.185.163.129]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442cd3af15bsm161173755e9.30.2025.05.12.01.41.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 12 May 2025 01:41:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>, Kevin Wolf <kwolf@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-block@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Hanna Reitz <hreitz@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, John Snow <jsnow@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v4 13/19] hw/block/fdc-isa: Remove 'fallback' property
Date: Mon, 12 May 2025 10:39:42 +0200
Message-ID: <20250512083948.39294-14-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250512083948.39294-1-philmd@linaro.org>
References: <20250512083948.39294-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The "fallback" property was only used by the hw_compat_2_5[] array,
as 'fallback=144'. We removed all machines using that array, lets
remove ISA floppy drive 'fallback' property, manually setting the
default value in isabus_fdc_realize().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
 hw/block/fdc-isa.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/block/fdc-isa.c b/hw/block/fdc-isa.c
index 6d1790e0e61..5d746d73165 100644
--- a/hw/block/fdc-isa.c
+++ b/hw/block/fdc-isa.c
@@ -97,6 +97,7 @@ static void isabus_fdc_realize(DeviceState *dev, Error **errp)
                              isa->iobase, fdc_portio_list, fdctrl,
                              "fdc");
 
+    fdctrl->fallback = FLOPPY_DRIVE_TYPE_288;
     fdctrl->irq = isa_bus_get_irq(bus, isa->irq);
     fdctrl->dma_chann = isa->dma;
     if (fdctrl->dma_chann != -1) {
@@ -293,9 +294,6 @@ static const Property isa_fdc_properties[] = {
     DEFINE_PROP_SIGNED("fdtypeB", FDCtrlISABus, state.qdev_for_drives[1].type,
                         FLOPPY_DRIVE_TYPE_AUTO, qdev_prop_fdc_drive_type,
                         FloppyDriveType),
-    DEFINE_PROP_SIGNED("fallback", FDCtrlISABus, state.fallback,
-                        FLOPPY_DRIVE_TYPE_288, qdev_prop_fdc_drive_type,
-                        FloppyDriveType),
 };
 
 static void isabus_fdc_class_init(ObjectClass *klass, const void *data)
-- 
2.47.1


