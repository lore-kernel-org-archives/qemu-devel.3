Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D16ECCF9F8
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 15:48:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFwm7-0005AN-Dl; Mon, 03 Nov 2025 10:47:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vFwm4-00059g-U4
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 10:47:17 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vFwlx-0002iK-49
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 10:47:16 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3ee130237a8so2779318f8f.0
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 07:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762184824; x=1762789624; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=n9WMPu5LSRciOJbiNa7PDj4nCkCQX4hBl0JqndlpJPI=;
 b=FxYKw9Zj9RMksQydTQTcLOWlgw6+a0WecliQnvxskWP4e9YKUMWkq45t4na5AAPtfM
 La4ADXOh8biWmw4sejtsycq8j6YJn+AEiNtcOIRYIIGr6isU3CPw2LTJicUzTa4hCUIm
 JQ8yc9CHSHexGRB45/jXi1iCht8Is5BiXtJQjxmBq09gRY9TeDDFq0AVTAvOuI/zrTXM
 MqX1FVclMmm3dFqiUjgCZm5dl4RRZ4BhtvtFe3a12yH3NHkZAShABu5nAnMZ8ZRUBbUb
 WkfQqAhkpeEeyGoi+p4vNFmf6nxPDZ+ESbhr4GsVyGGB5WMenulCRt+n/M84UFa1VABp
 jZ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762184824; x=1762789624;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n9WMPu5LSRciOJbiNa7PDj4nCkCQX4hBl0JqndlpJPI=;
 b=TbWUONQdD7ZtM/FR5aTMgcmWl7hkAwWa4BrPqTthfkfHOjAkcnM1h/k3zV/bcJGwKK
 fVTEmh4ycUwIx0OgpqpmGlG5sF7FgyjgSlnwro5OGt47uVPrBEAAlk8McPV7qngrWmMs
 e3/v1bdQOUxB0cRdS/R/HcDMjfCqKef8OCUNbHjEqr3/h1CuJyct4UU6yMPuRzb30BwR
 9CtOZtzocNP+JKl3IKETU3XrFwz/fjWfFDeRoblbLRl2Q+HohMZdPDOrgQIPloowRX4N
 z4GMfC7Q1gj15/XSY/9DZq8xcet0WqRs4Cy3nszDPfE2AJPc4kzb7jQjNKbg8Ebx3Rlt
 doVg==
X-Gm-Message-State: AOJu0Yxswagcr/9+QX+fb477K4YHlHcGfjpFBez7p9+tP32R1VtnbVRO
 hxolLeM5uJ1MarWJIwTuD1Eeor+UOi7fC8D0KxAZuDdBiBe57cGwa3SbSJOeAjVjlUoltoDCGMs
 pIkxB
X-Gm-Gg: ASbGncvmGxUPSaeOTsPAshIGP9CzVBS5YJ2dXp8uhnlgFffHux4AH+s5V0jJbDAcYwy
 zOizwrsMzlEQKuFsE0tHuIgYQQYOj7a6YQHOJPJHDqykRS0cF7I+n1GqKMlg0U7MVxCT6UGEJTw
 p3fbKt+0Lq0xALxwESivYkgP+C93WeFmLapyUg96bD6yHQEW4TMN2gt8XLByh3KsHJkUfEzXMgV
 JCEg3X18R8AENwLvpdjk4VnZJ8GCYRQ6XHIEbvCDeg9jzmcnHFHXP/bhLVlo3mQuOYtGgQK+rgT
 xQXPfGET5eFSEQekMfwnoW0CTKjahIVLMX9Us0aOmRGyuoA+MNjoNQqGElcYaSDuq1i8LXUDsS2
 0a9/2ruMxNF1S/KMAg7ZuomldVR30+Sa47JWelzvg41NiJTtFdqE77QXce4DnfIXluTgYnDONhQ
 06LQj6A/75c3QUeT1w
X-Google-Smtp-Source: AGHT+IEP1oDBh0dhJDzbuBNPkLPbUpTPMNaXukSdhTGBsv8U5aoQ1GW1irfF/haVksNQnVWyzhPnsw==
X-Received: by 2002:a05:6000:2306:b0:3ea:80ec:8552 with SMTP id
 ffacd0b85a97d-429bd6e3d86mr10926614f8f.57.1762184824307; 
 Mon, 03 Nov 2025 07:47:04 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429ce6b0c16sm10504156f8f.38.2025.11.03.07.47.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 07:47:03 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 2/3] hw/arm/imx8mp-evk: Fix guest time in KVM mode
Date: Mon,  3 Nov 2025 15:46:59 +0000
Message-ID: <20251103154700.4126379-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251103154700.4126379-1-peter.maydell@linaro.org>
References: <20251103154700.4126379-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Bernhard Beschow <shentey@gmail.com>

The imx8mp DTB hardcodes the clock frequency of the system counter to 8MHz.
In KVM mode, the host CPU is used whose system counter runs at a different
frequency, resulting in the guest clock running slower or faster. Fix this
by not hardcoding the clock frequency which makes the Linux driver read
the real clock frequency from the register.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-id: 20251101120130.236721-3-shentey@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/imx8mp-evk.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/arm/imx8mp-evk.c b/hw/arm/imx8mp-evk.c
index 3ddcf1af5ac..44e06019670 100644
--- a/hw/arm/imx8mp-evk.c
+++ b/hw/arm/imx8mp-evk.c
@@ -44,6 +44,15 @@ static void imx8mp_evk_modify_dtb(const struct arm_boot_info *info, void *fdt)
         fdt_nop_property(fdt, offset, "cpu-idle-states");
         offset = fdt_node_offset_by_compatible(fdt, offset, "arm,cortex-a53");
     }
+
+    if (kvm_enabled()) {
+        /* Use system counter frequency from host CPU to fix time in guest */
+        offset = fdt_node_offset_by_compatible(fdt, -1, "arm,armv8-timer");
+        while (offset >= 0) {
+            fdt_nop_property(fdt, offset, "clock-frequency");
+            offset = fdt_node_offset_by_compatible(fdt, offset, "arm,armv8-timer");
+        }
+    }
 }
 
 static void imx8mp_evk_init(MachineState *machine)
-- 
2.43.0


