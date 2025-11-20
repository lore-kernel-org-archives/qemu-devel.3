Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BB38CF9C7A
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 18:00:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vM8wZ-0006ut-Ct; Thu, 20 Nov 2025 12:59:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vM8wV-0006u1-Cp
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 12:59:39 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vM8wU-0006zn-2p
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 12:59:39 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-42b3b29153fso720983f8f.3
 for <qemu-devel@nongnu.org>; Thu, 20 Nov 2025 09:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763661576; x=1764266376; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zJyRPRs7zM99vWqizAhW64rpmkMpx4dp5iPuBqmDNZM=;
 b=ffrKATc0XK6k8zo/uHQJFDQo2yr/a9c7IR5vdLl129rUfjL+VKMlJcZn5pQlIKntsV
 iih79fu/dIIKl08XMudjqjKfd8vCWEGd1qKg1m8/L0yvoUDFygLBLBmfoJHKB083BMts
 62abAasTOY4ypULU6Z9MvjswP00gTfaie97bif6GKkOP2NVsbplruEvt5+6t4xkvpdaC
 vv2m/MR/vl/ZE1O0DinTiVKYEHjbgpb6v1dZA1XdrC2BO8cPND8KAFAHQIksLXL13zVv
 q1OYm9HsMjL2KdknZN+mDZWd8360o0S9vklzSSvAzZIBhj6MEpW0MKswG5g794eji4o4
 gjOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763661576; x=1764266376;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zJyRPRs7zM99vWqizAhW64rpmkMpx4dp5iPuBqmDNZM=;
 b=AEAV3fOE1tyzlofIbJDmd4DcO96BVrljQjsECmN8AikpxXHdHr7+EeSBdL+yzksSta
 D7sj57qixDvSi0HSC1loDeBIcIEnK5dceQe4metEWKeEreJkiAhgM8TZg7CG/SffBSs1
 c6l1pQ86LXyhvXZgMQyXmYBBCIGAWiK9DSEbQp3NERNI9hmE1EPGjuwEYIL4LF4Zkj07
 m8fg3kzsPYaropm4eyGs0BtThIoo9mV/3N77QiSblnPF2Gx/KSc1UCnBv1UFdy71kspQ
 hasm5gaVly5cvueltexSdanxcQaUmi9FEI0oLsh6328PmoamkbpV7DQMBvT1FzRwVgqb
 4o4A==
X-Gm-Message-State: AOJu0YxL+l/Q26sy5Ut0ZctdsJJBV7Bzkbqj2Ucc9o5jYALqA+ogRD5i
 kbU39dvXdyE60ITER32DSr+vn4szkQosxhiPoEw6WjpL/SgfeMv2eObz0EQlHNCnhkwUI94SC/z
 hPPdYY5hqow==
X-Gm-Gg: ASbGncsWRMHPliX/bX9y3NUZ/xW9Kv35jgCKtmrSrtKtK7YEtbgLYYDXFe0Hh3LqOcU
 9WGAmfRHC2xGTipZHrwZIf4Eg7EEN7QVuY6hIkvsvC2mRpo3E0fbPmBYbuUmKxXgeLVAUaFLqy2
 un22pkYZwPRkYT30719CRVcGn8wLdiiuMvILRDuM6llrDHnrrl4hA7I7f27qfSZZpVjlTtGXeyo
 SoDVdu0RBbTnCz1kMq8duvTG90qVdBOtNzzYGk1KsgPJS69NVJvypzes0Q2swDXV3ACHAX3NFsm
 W2bmrKgXeiyg2FBpqJ13uL8y9av2u4X0w2PJrOHOmxVEvQmuwY5tkxhcamA5mJlB0YKaQ4pzw0a
 GMM/DrboXnTLoR+N7AktIw+twjvu2SDkl2BSwf7zw14jPw/xz1zQ84CVUC5ok0tG4nMgaM4mgiH
 e4W5a+LUYxHyjnMkO9kQVf+tQfyqNF1mUz3outWmO17Gd5fdp0LNUiXgXviPEW
X-Google-Smtp-Source: AGHT+IEnRHbxKjwxgWNUwr2m+lzH8dXCCKK1m10+7j0tuE39dfGBzTbrpQJ91Et9AbEX1VGQDKAp4g==
X-Received: by 2002:a05:6000:40db:b0:42b:3dfb:644c with SMTP id
 ffacd0b85a97d-42cbb2611e3mr3182934f8f.10.1763661576230; 
 Thu, 20 Nov 2025 09:59:36 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7f2e5b6sm6616072f8f.1.2025.11.20.09.59.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 20 Nov 2025 09:59:35 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [RFC-PATCH-for-11.0 3/5] target/loongarch: Use little-endian variant
 of cpu_ldl_code()
Date: Thu, 20 Nov 2025 18:59:12 +0100
Message-ID: <20251120175914.6515-4-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251120175914.6515-1-philmd@linaro.org>
References: <20251120175914.6515-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

LoongArch is always little-endian.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/loongarch/tcg/tcg_cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/loongarch/tcg/tcg_cpu.c b/target/loongarch/tcg/tcg_cpu.c
index 9d077c56d9d..3f4b5f9258e 100644
--- a/target/loongarch/tcg/tcg_cpu.c
+++ b/target/loongarch/tcg/tcg_cpu.c
@@ -140,7 +140,7 @@ static void loongarch_cpu_do_interrupt(CPUState *cs)
     }
 
     if (update_badinstr) {
-        env->CSR_BADI = cpu_ldl_code(env, env->pc);
+        env->CSR_BADI = cpu_ldl_le_code(env, env->pc);
     }
 
     /* Save PLV and IE */
-- 
2.51.0


