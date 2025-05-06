Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 466E0C3ABBC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 14:52:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCJXu-0005oH-LZ; Tue, 06 May 2025 10:45:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uCJVJ-0001om-AF
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:42:42 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uCJVH-00028x-6h
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:42:40 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43cfe63c592so53796535e9.2
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 07:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746542557; x=1747147357; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Fp8kUQDpMWonBXU8G2b2uNI95JriAL6PmHOT3keOo+0=;
 b=I9rqKMT9XomJVv+uWMWc5SB4U+Lvnwrpq/WuebeVkjJqerd735+sRf1KYoHry8GUqq
 rdIpPUdWVcaF5+NUvj30mN/cOt1GWzLp0RAORXEwbweursPiU3fGtdxOkesa0X3UuBuw
 9xMYXA1obgY8NjZMs7zLtnr5Plq7sI87/Ios/krMxkinEzF/4NgjFiHgzf+0JUsIeVP0
 oLNbzlwWmRfR8nrb4N7ZqaWg4RKQR4EPoj+oz0DKkRqRW6oZue2dj5fHPgxX2HT3Dys2
 pyEP5AfmO2TENEKMjJ2h46fbF+Z+qe5Qz0Vv1FRari66Ccco2jyhvX6hMHHZBtRaBnAm
 8i5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746542557; x=1747147357;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fp8kUQDpMWonBXU8G2b2uNI95JriAL6PmHOT3keOo+0=;
 b=RM1gch0ps/RdLrkI4ujGMeiTcP/B7ZH+f1wqbGDR1RF+uf3lTB91RK96PUS75e9CfK
 2TNStOpnhYsNwQMJFVAQAzv8I/n+5yO/j7RTF7xZPjt6sBsEXIkLkmUXOoQH2XsS3o0R
 ivLSiZ8+V8nx7ls/dpjA3iO2GGPWcf5bZ4zQJhbR11gaUAQlZQlRleEezPVUujHn+zmN
 pPHvVdUvb1Q1R0LDEsD8Rp7OBJgVq1OtitoEkcMI5AjbZa0NN86pTctr0RF3LcNsYhAn
 iLrMrWoINH8ca2cDClkTsew2AMEsjOyj/HBs4cr+Xj2P1wwZ9XiksboGhU0As2tU9f9u
 sU/Q==
X-Gm-Message-State: AOJu0Yya0UDBtPOZNvYiT+ik4cKbBxbC8qvba3f8pVDdifLF4HxqJjfi
 M4NLZzgh05PHpppYLKfVC2aOX/5wW7GIwtmsKBPfp54nP2ufaFK6XkSndcW2CJSStqQaHNUCCY7
 I
X-Gm-Gg: ASbGncsy9dgYArv1KEjHyVYGUIUerHr+qtE9JDgJ2gdfPyDwLlE3XB6XIY8X/AjLH+/
 x7HqGP3LFuSmrU9ss5h34YKCil4g3A44yGQ6bVCW/U/xi0L6XmHjU95g5pdmjTU/bS1pUUWkkfw
 //ZqJPC7e5s6C5rba7nfGWzztZuQnq6DWNsEi/eduGbPQtR3R7DwaqsrQw8i2exn5H90ie0XTpq
 WESdiqjq6mEPyj+5ljdzWq5b19SGGx9rcqUMGTZSDldob9SJLRx5nAmVU2edu0G1Tn2SmBMEN6N
 Yz3WOtvACMKtxzwvTwf1snp4M85x/snXBEZjzOVPZW5rE4tMV2/JWweD+Q==
X-Google-Smtp-Source: AGHT+IEiRAxcQ2tZfnPDD/8Nnh24VM5KkCu8NFOuUkdbDvbEMb/3iMjrrt6q5YE7VmwSqZJlMiEIgw==
X-Received: by 2002:a05:600c:8283:b0:43c:fe5e:f03b with SMTP id
 5b1f17b1804b1-441c49483f8mr115937355e9.30.1746542557520; 
 Tue, 06 May 2025 07:42:37 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b89edfc2sm169603435e9.20.2025.05.06.07.42.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 07:42:36 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/32] hw/arm/virt: Remove deprecated virt-2.12 machine
Date: Tue,  6 May 2025 15:42:01 +0100
Message-ID: <20250506144214.1221450-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250506144214.1221450-1-peter.maydell@linaro.org>
References: <20250506144214.1221450-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

This machine has been supported for a period of more than 6 years.
According to our versioned machine support policy (see commit
ce80c4fa6ff "docs: document special exception for machine type
deprecation & removal") it can now be removed.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 3488bc4fb9d..d047983c80e 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3588,14 +3588,3 @@ static void virt_machine_3_0_options(MachineClass *mc)
     compat_props_add(mc->compat_props, hw_compat_3_0, hw_compat_3_0_len);
 }
 DEFINE_VIRT_MACHINE(3, 0)
-
-static void virt_machine_2_12_options(MachineClass *mc)
-{
-    VirtMachineClass *vmc = VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
-
-    virt_machine_3_0_options(mc);
-    compat_props_add(mc->compat_props, hw_compat_2_12, hw_compat_2_12_len);
-    vmc->no_highmem_ecam = true;
-    mc->max_cpus = 255;
-}
-DEFINE_VIRT_MACHINE(2, 12)
-- 
2.43.0


