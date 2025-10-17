Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90001CCD199
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 13:23:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9kCP-0002x4-QI; Fri, 17 Oct 2025 09:08:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9kCM-0002wR-V6
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 09:08:47 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9kCH-0004Sm-NP
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 09:08:46 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4710ff3ae81so7300065e9.0
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 06:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760706517; x=1761311317; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HhXctmaGs+38JQZVNJ1bF9+hCN6zeVUF0eyaD2DT6Kg=;
 b=m/R5WCCZg35uuneXBkLqCcgfPYl9/Cf4NPuN+UcbAQ0Me2EvozbdahbDl8e1Zb7cj9
 u6g6FNy1D24RpvSlzyK4EKrPRF5j2yvNGwMulsWVKKM2INeLq4nVnro6WeClRC88BjNo
 zOoX2ZB4NOhf76G8TL55PF7LTEcx826kAcKduXqeSGgqUNsChfvXwOQq8Lnt5lxN7zqy
 MAzeUKjBIRfOyWYpgf1pFGvkZbdNTdwSaatJJbRR3xcBb4/B+U5t1QU5UMtPa5Fo73o/
 dgnhh+Tah6uduid35XFrcEpY8lpktNLtluqVBARPZ7wbieLC9yyjObItOyGuFqiJBrk5
 x/CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760706517; x=1761311317;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HhXctmaGs+38JQZVNJ1bF9+hCN6zeVUF0eyaD2DT6Kg=;
 b=FVdu4l1Tj+ZrYaV6xYpT6JOBN71+BQwwUeztEsRyrvnZVir1f6OOr7erONIu/ToyOX
 DACgE0yfAzpLPz/4+jWyjqL19GY8jBhK/OgkHzc6eMQ/A5bCCT340rizOMm9aR3WplsX
 d1s7jPVlWJPOg3HKSwEZdRByYFLK+aBqUS43IdqPxxXGry4ONkgni/grPdiMFe7Ip4GU
 9O7p3/vGokneg3qifb94yQyvcdVaRXVah2He1GJnzIHoOteNaQGJHvvPjr6vr+kcx2fo
 Ml0M1nbnY1M7tCjJllU5GjrEjYdQyqyFuXlCcDHNdrT7TWzwbJlwimzA7BBJXAwNjllx
 UyLA==
X-Gm-Message-State: AOJu0YwqkjoNC1MN4PMWSfi/BHsBZEO2OkAsIzRPRpZ+GcdcWFWDcv6G
 pd9cX4LqgRlTwHs9cCz50yKaqkPj1Vm+QuR5wBRs4W5s8M3QasijPD5HmnTRMglogYyCHN2KvHL
 RNPl+5WI=
X-Gm-Gg: ASbGncsSiQUmF818wn63YhhJhHJHWyfTpqKbVeECCSZhqJxZLdD1K066GIwL2YVWR9o
 I3TWRSz9yCKwKAFPYQZMXVYJrRmDn7tMWM3eDrPzAlaTZC2SN7pSZXxWoIr377lxW9hEno7ImH6
 VI5DZIZMzFZLIcpD1xDoQQNBZZt/NRwyhSdwAAu9qeUeLqjVqxZ3pb7zNPzJneGBDfvo2GyF0nE
 jqZo6hI0JT/1HiGWTjoobdBdgUUZ6NP9XUbQoCoSIxm6fPlmZiCmu86zA30c0ovLiGU+vw5dIXH
 uTeG3+0B/Tn5R2vkc5j7O+T786BxsqDmZDvk0pQHbCevxI3kDxSII4VJmbEQnIvQVAOYXArfIS5
 HYpywyY1K0KIgfKdh25kBiRzdoq2GKjQw+9vrNjuSaSVQixp+L6x8a/Qpn9tzA+Cfgv2JBNxbeQ
 D6lDodcXxh0J+mnmEkvNvE92acLLbhBjl5HtXj7TYYBuEBsyoGyw==
X-Google-Smtp-Source: AGHT+IHsblTCumh4P7FmMV8QNd1lu68PonExBLhrVlKC9QVmX+cxaYLypo++cRWGc0LosTGIkwsfDQ==
X-Received: by 2002:a05:600c:548c:b0:471:16e6:8e60 with SMTP id
 5b1f17b1804b1-471177c0948mr28800355e9.0.1760706517286; 
 Fri, 17 Oct 2025 06:08:37 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4711444e3fesm83931785e9.15.2025.10.17.06.08.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 17 Oct 2025 06:08:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Andrew Jones <ajones@ventanamicro.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-arm@nongnu.org, Shannon Zhao <shannon.zhaosl@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 03/20] hw/arm/virt: Remove deprecated virt-4.2 machine
Date: Fri, 17 Oct 2025 15:08:02 +0200
Message-ID: <20251017130821.58388-4-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017130821.58388-1-philmd@linaro.org>
References: <20251017130821.58388-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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
index 2eda2d43974..b781a218019 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3690,13 +3690,3 @@ static void virt_machine_5_0_options(MachineClass *mc)
     mc->auto_enable_numa_with_memdev = false;
 }
 DEFINE_VIRT_MACHINE(5, 0)
-
-static void virt_machine_4_2_options(MachineClass *mc)
-{
-    VirtMachineClass *vmc = VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
-
-    virt_machine_5_0_options(mc);
-    compat_props_add(mc->compat_props, hw_compat_4_2, hw_compat_4_2_len);
-    vmc->kvm_no_adjvtime = true;
-}
-DEFINE_VIRT_MACHINE(4, 2)
-- 
2.51.0


