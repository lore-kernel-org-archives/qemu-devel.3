Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF011C48291
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 15:39:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVvb6-0000Nk-G0; Fri, 02 Feb 2024 10:36:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVvb2-0000Kq-Nn
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 10:36:52 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVvb0-0004UG-5W
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 10:36:52 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-40fc52c2ae4so8265555e9.3
 for <qemu-devel@nongnu.org>; Fri, 02 Feb 2024 07:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706888208; x=1707493008; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7kvYGJv6Vs1OqeEsvp2TCyEKspSHCOA1Tp8iJFztpkE=;
 b=rKo9NUzqs00wPWGkjQWt7Ot2zplIsNVBU/S3u7iJop1OLAygx3f+YrzjuADIGkuxHu
 TfixQkK/3jRN2hwfPmGIovQZnWlOMw2Pk/abqan1Kqrt84Lsc7cHYchwQv9F7YNzxM1n
 JbumORK55E6p+WHxBKABvFV650KzILXqwlVpCjIF1zde+yp3Rlf3wmII2FlKdDy7D3L4
 a23Pm6DFn/40M+NG1jHqiizAr0CGm0uSBLMNak8PJw3AFdATF9VkXN+VMHq74aZdyFmv
 Ex0NYZF2dW+AGJHilvKxaGa8FW6VN0kG+euVaGWH3kQ4uarAOBOiUSKu9k/8SdFP4Mru
 1l0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706888208; x=1707493008;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7kvYGJv6Vs1OqeEsvp2TCyEKspSHCOA1Tp8iJFztpkE=;
 b=NTZ6nrYw4RfK6xYTq8ORyxA7RrkUROj21MR2357rwfnOfncuN6IxG7Vu1c+Cfc6Q+C
 Fj2qsdWLCpqH651rU/GQPpDrOyr/9vaedlRp0Qmd7vOTVSyZ+6+PJx7lI8dbMw61EZWe
 5NJd4VU+kL+2sTXDx04z9fPm5L3TTGjNQVIAstqGHeiVwY4+kmAs2/JUBun6a23gM2BS
 OGWgbvMqg1tVxUxu2Vy5A7pHP9EjQDJPjBkfL8RsFWyYZbiLxyRD2XYDFzalpa2kn7Xw
 q7foKxvbWOmfCfb776EJb9F1yNgw3yzB1pqRtCh86fvhCjyVwJwICrPQayOF1k8uvPZ2
 RMqQ==
X-Gm-Message-State: AOJu0YztWqsbK6NNGkTKDwOlmDUKo2fJ3D+Ji4hn7Gru3DjzzGxgSob0
 HAx7a8lc9aGlhzRZYEMF+vytFzJas0/TDeojmJ0cmCyO9JKWSkH3BSxw9XsU5kgYQPdnaKPiA6d
 4
X-Google-Smtp-Source: AGHT+IF+kuUqinnTX+VPiHPELLY45Jo1Wx0u8tyaSkKOQApr6A8cvDzthEMl9+JSzN/f2He9/jDDoA==
X-Received: by 2002:a05:600c:3153:b0:40e:4f81:3f68 with SMTP id
 h19-20020a05600c315300b0040e4f813f68mr1791910wmo.16.1706888208769; 
 Fri, 02 Feb 2024 07:36:48 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 k2-20020a05600c1c8200b0040fafd84095sm214735wms.41.2024.02.02.07.36.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Feb 2024 07:36:48 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 22/36] pci-host: designware: Limit value range of iATU viewport
 register
Date: Fri,  2 Feb 2024 15:36:23 +0000
Message-Id: <20240202153637.3710444-23-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202153637.3710444-1-peter.maydell@linaro.org>
References: <20240202153637.3710444-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Guenter Roeck <linux@roeck-us.net>

The latest version of qemu (v8.2.0-869-g7a1dc45af5) crashes when booting
the mcimx7d-sabre emulation with Linux v5.11 and later.

qemu-system-arm: ../system/memory.c:2750: memory_region_set_alias_offset: Assertion `mr->alias' failed.

Problem is that the Designware PCIe emulation accepts the full value range
for the iATU Viewport Register. However, both hardware and emulation only
support four inbound and four outbound viewports.

The Linux kernel determines the number of supported viewports by writing
0xff into the viewport register and reading the value back. The expected
value when reading the register is the highest supported viewport index.
Match that code by masking the supported viewport value range when the
register is written. With this change, the Linux kernel reports

imx6q-pcie 33800000.pcie: iATU: unroll F, 4 ob, 4 ib, align 0K, limit 4G

as expected and supported.

Fixes: d64e5eabc4c7 ("pci: Add support for Designware IP block")
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Nikita Ostrenkov <n.ostrenkov@gmail.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Message-id: 20240129060055.2616989-1-linux@roeck-us.net
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/pci-host/designware.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
index dd9e389c07b..c25d50f1c6b 100644
--- a/hw/pci-host/designware.c
+++ b/hw/pci-host/designware.c
@@ -340,6 +340,8 @@ static void designware_pcie_root_config_write(PCIDevice *d, uint32_t address,
         break;
 
     case DESIGNWARE_PCIE_ATU_VIEWPORT:
+        val &= DESIGNWARE_PCIE_ATU_REGION_INBOUND |
+                (DESIGNWARE_PCIE_NUM_VIEWPORTS - 1);
         root->atu_viewport = val;
         break;
 
-- 
2.34.1


