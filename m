Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46C23CCD195
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 13:20:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9kER-0006EU-Nd; Fri, 17 Oct 2025 09:10:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9kDo-0004yh-Hv
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 09:10:17 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9kDj-0004lU-Vq
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 09:10:15 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-46e6a6a5e42so10640905e9.0
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 06:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760706603; x=1761311403; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F98Bt2rqPIwW1cb5a6h+iFYD8TVHtD6ORETYRyTMwr4=;
 b=hm1x+1I4RpDvod0tT87sPziTFSjsWIVsxq1ldExDZcunkt7mzBy3CaPLgkpkXvNq5G
 o0XERnFFg0mpnaO++4HPwRfiVlTf+A/ffh4tpx3wv6RP4mpzdMC1sFGIyhEUbm735rYt
 1AntdijEvQGoCerzA67zpDXyRePJSjM5TJevWfxYZMR+Vc1S8qZI/7Gp8Gv8lJfy6Mc7
 VxAAX5vNgmYUsHCchLFLnkvbggci/jf2SsYQ7X6ggBEueMtPxzKXONK8JKlSmYEhxC0S
 b78QOFJZ5Oi08y4/LhCF652gqea6o0McaNPxjicr+GaEb2U1jQa/OWjk4CSuKyOJOwTf
 rr9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760706603; x=1761311403;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F98Bt2rqPIwW1cb5a6h+iFYD8TVHtD6ORETYRyTMwr4=;
 b=Lv9tPZFN1mQuvoz8sT53oyH4/KzhEaysc/GpPtNeJWEx9IY/JJYM1gGOCdMAKxV75R
 oqd7I1j/Gtvnbc3pggu9DN1BrJWkJ2u2emqWl2JvGoXlIAuOAMNPeiUbFmvPR11eJ+Ex
 peziFFgylb6sOElPi9v93K89vZnGc6NuxbJg9d8tq0XWfgnW3aCKBUrRzDRlA0BoGJYM
 VzEFNxFMbfkkdRUWheuby4drOEuKsEQWQbyXJllmEotNuCaa4MxafM3BD0xMx/kcbcDW
 zJ1nAROaU1LvcLnK1CUV/ZshnnpFWEXUsnoiF2QyFJLzVXqW0qIMIZAQdonADXwy2iNF
 j0kw==
X-Gm-Message-State: AOJu0YzpTkw0vNkfP2aGciZHlUV171hQzZ6HaA9H5036zU4Y3+LTY4oa
 iKnVp+8ho53CeonfoITpnCRPFhV8ZpIjkqfjhaS8hyePXcrBnHgr4RxrbZOEUusVt0CKVWqbtQG
 I8VhzAEk=
X-Gm-Gg: ASbGnct3+t7muU8fxY9g2wEWJp0b4KK9Jl/S9B0QBqRVh8SD+35uS2qIj5dpHu8h4U6
 pH27yPOaE1eGClUH5eQJTAWZqmNKWMKnhOUY79p0855XVtrWp1yUweR2vADMbEgtB4xIVD+Y0fH
 NGGf9qHQDT9ebG2EafZ/TpgKnTkOSxWvtg9Ms/JXzqFrAeUbi6EbQzGc2ikpUzlxg044bpBGiXE
 uOhNNirHF2WdUZyjvDkjdqzOO8rYx4uFwmq36Er4LbpANtWHbhNx2lmn82YlL8JSpdD/6FcWEAa
 tzPOG9s/TqYqK3g4OlTayIMzzbJkp1AjuWdT2aTzzL1qQauvylqxJZzRqrDgmpc+VeP88YeXVJ/
 jdpjWapHOdznYWb6dk1kKhnPC+oQkO9dn2j5+5qufO5pkePYHrajm41d3FYQ/E8jzmQ/qVc3Tir
 fm1L26/l1+FcFOQRoDQ5tLfMaLjznBMhLbap7AEFF6KaLjhpC1rOLki7wHDtNc
X-Google-Smtp-Source: AGHT+IHj5kg7CiAB80xNILUWMc7LhMJpdmAGuhndYdMKCshtKKCQaTbnfURb421hvCqfP0DtPNL+uw==
X-Received: by 2002:a05:600c:8509:b0:471:16e5:6d7a with SMTP id
 5b1f17b1804b1-4711787dca0mr23062475e9.13.1760706603322; 
 Fri, 17 Oct 2025 06:10:03 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce5833dcsm40216776f8f.19.2025.10.17.06.10.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 17 Oct 2025 06:10:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Andrew Jones <ajones@ventanamicro.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-arm@nongnu.org, Shannon Zhao <shannon.zhaosl@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 20/20] hw/arm/virt: Remove deprecated virt-7.2 machine
Date: Fri, 17 Oct 2025 15:08:19 +0200
Message-ID: <20251017130821.58388-21-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017130821.58388-1-philmd@linaro.org>
References: <20251017130821.58388-1-philmd@linaro.org>
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
 hw/arm/virt.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 651ad4b5f63..2da5b014e2a 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3578,10 +3578,3 @@ static void virt_machine_8_0_options(MachineClass *mc)
     compat_props_add(mc->compat_props, hw_compat_8_0, hw_compat_8_0_len);
 }
 DEFINE_VIRT_MACHINE(8, 0)
-
-static void virt_machine_7_2_options(MachineClass *mc)
-{
-    virt_machine_8_0_options(mc);
-    compat_props_add(mc->compat_props, hw_compat_7_2, hw_compat_7_2_len);
-}
-DEFINE_VIRT_MACHINE(7, 2)
-- 
2.51.0


