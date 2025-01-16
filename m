Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF064C02183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 15:05:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYRND-0003WG-TX; Thu, 16 Jan 2025 10:01:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYRMM-0002Qi-DR
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 10:00:40 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYRMK-0000DQ-Oy
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 10:00:38 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-436326dcb1cso6621275e9.0
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 07:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737039635; x=1737644435; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eFYoi1e0Rs5lhXGPiZea0Jlbba5nXuWhf697yraqXSo=;
 b=WME6JPvHC2GHou+nJLLFj9FU3Qy8IW3w5XQcAtElK9/9xP10JPTRefi1Yg7qidJIex
 NUMbMJtjtvHB0BzJdCH1hiBuNdeb4P6SV1utElqxBCxzoabGuR7x7AtC/xCnySqN1osk
 bVxq0ZgEdsUpUpg6PUgWUQE8S60NiOual3HDedNObeL0sLgBibylIa/AImYep5dAR5WH
 eIAfuMZt7EfWKdSVFIl9YJ6RUoPYLScZrO5c6P+hQYnvjSDl0SFoFMytoo7hei1Tnogu
 RGOo4RJYYM5DU/T32Bvf6BKlo8fWBu39E446lg3YrJ4h0PHhA27Qu0OvkxsP6Fy9BT6P
 of8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737039635; x=1737644435;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eFYoi1e0Rs5lhXGPiZea0Jlbba5nXuWhf697yraqXSo=;
 b=dJMYE2ExNlcTazr1+BtTGvP11Vk8xudjAbwWN0plxfQczh4nldWyd+GoKrAQy94DwR
 RjLWp2k0E1C4fqpJAxHgJwdn7BdF2GCW8gUBbB7rjxpEHmUgGiNPFDKIzFH7Zj5yzwfJ
 u43soxPzfe9gRwPt+9kwvS5fio7/SYTMJyt7Xp5JhexRIa4CIwYZiuC5mnEDq6bSfbud
 HlqE23McbqQt/792znCA2qxMx6pD6DzUlE89CIpzUfHKBUsRmUQp787WHDoigil39qGm
 Qqlbjo1eq1Lkd1yDbmdJbOiSR7A4/nlcTBcWdgldoJDpRENtv5g7KLv7KWIMDIpkPpHt
 ok3A==
X-Gm-Message-State: AOJu0YwPbpDtZC60iSX+a8tJ3isgu/ssEoA6gj1aEzyXategAz6aB5jJ
 Ds9C0ALGf09bd9mf4ZRQnOIIRzmeuovApetTR+p4jYrKSHVK1tWpbrG303PIC1EeGdpKepDqo94
 Akdo=
X-Gm-Gg: ASbGncuL3E9HtXAjHvUgXmrIJU9t5023uKUefuUb/yK/5ml5kIBpCduwyQb2ik9r6Jm
 iqd0SdYySrPRRbDz0plMa6n9lDb89qhEzE6YoCYk5AKMDHEiEdkWs5dJa0xQSIAqGCqFtifXZ1a
 E3dljD7zjQx5CrrsBCfkW6wwaqMb6r59/zOrVm9/krLJ28vryYuMLKQS8Ej9NkIJUoikzZFmPq4
 9ztstPoVQYBgKJa2Y6i38PsIiF0Z01tSUebAX35OdNInopF/S9d+8bRrCJ0Wuym2Y+nxHfPE2+X
 BCYO/vq7XCAIfLv4ZM44rVo8XDpiwm0=
X-Google-Smtp-Source: AGHT+IG+Lae67MnATMNadiwuWS/coc9MFIrKqXjIHHGHOFpZTTWm78nGgEVETAjm0w9RA1a3DpXvMw==
X-Received: by 2002:a05:600c:3b86:b0:434:fe4b:be18 with SMTP id
 5b1f17b1804b1-436e26bde73mr334144405e9.18.1737039634909; 
 Thu, 16 Jan 2025 07:00:34 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c16ba82csm42260715e9.1.2025.01.16.07.00.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Jan 2025 07:00:34 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>,
 Andrew Jones <ajones@ventanamicro.com>, Thomas Huth <thuth@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 v2 10/13] hw/arm/virt: Remove deprecated virt-2.11
 machine
Date: Thu, 16 Jan 2025 15:59:41 +0100
Message-ID: <20250116145944.38028-11-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250116145944.38028-1-philmd@linaro.org>
References: <20250116145944.38028-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

This machine has been supported for a period of more than 6 years.
According to our versioned machine support policy (see commit
ce80c4fa6ff "docs: document special exception for machine type
deprecation & removal") it can now be removed.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/virt.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 54c7b92b6d9..582a5aa077b 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3541,13 +3541,3 @@ static void virt_machine_2_12_options(MachineClass *mc)
     mc->max_cpus = 255;
 }
 DEFINE_VIRT_MACHINE(2, 12)
-
-static void virt_machine_2_11_options(MachineClass *mc)
-{
-    VirtMachineClass *vmc = VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
-
-    virt_machine_2_12_options(mc);
-    compat_props_add(mc->compat_props, hw_compat_2_11, hw_compat_2_11_len);
-    vmc->smbios_old_sys_ver = true;
-}
-DEFINE_VIRT_MACHINE(2, 11)
-- 
2.47.1


