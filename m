Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9012BC36002
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 22:41:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvOSa-0007C3-N9; Thu, 20 Mar 2025 18:33:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tvOPr-0002hN-MA
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 18:31:13 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tvOPP-0007Al-Bm
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 18:31:07 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-22409077c06so34137075ad.1
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 15:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742509829; x=1743114629; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7b7Pa/XivG7M4hjK9jqso2S4d+dz1DGry6GtvIR3C8c=;
 b=fknhnhjdS7eh3ANUYyqYH4CcTlhwHEXY52XSl1eEofg60CEtkoV0aiBMSIBptZYws5
 2mOZKd7empHH+MLIB5BP0Q4feVNtBctre3wMd5fuXe6aGcT/rfILrkbbw/jt/tMRpCk5
 0hsl3STpBDcDoR4Ik5P3ZEILJg6fpG1WVKYE4P659dBk2Zel/blxqDmFv3IGlO1oSv1O
 DbCJ7hY6CzPMZanlB3Vx8jgF4hzZ6fR6LZerq+O6YRG6l2O7Db0aK4CMuviRLaOSeA+Z
 zbU6NqaN/RQP7fWJnwwaC7enRg48TH2PH7tQ4mOtpKFq9gd8nWf4blcQubhjGtGhNB98
 KPuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742509829; x=1743114629;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7b7Pa/XivG7M4hjK9jqso2S4d+dz1DGry6GtvIR3C8c=;
 b=dz+SL1Q7QJ8jVidV43oXE7S5fjzEhXIrhzOdHFKpwt1k/Vu7JGW9PRq6kakgPjYzyy
 0SFxfoQOjPJi/EjaT5FOTin3j+ushBR8YfmANt26p3kdYIowfVVLlDfOVwHSsQftghUT
 i10DF7tGZ0+NPXom9h34QOlk0zzJzd7+Qkr1MlhVNdJnfe8epxOC05RRI2WB6DTWoICk
 oABzpxpPDJ1HlgY2Armrdw/ejc/03BJRtoU7ZVqv2l3qVdZdhfn3obaj8ZwLXG9ns8Du
 3DXeDTTaiqomuEjMvCCLgfazzQ+9smcn2HTOyTJX4EDpwPYtlhPwpr5rJLQ6vsy5KJdV
 XDLw==
X-Gm-Message-State: AOJu0YwA8pQ+KTJX315tXhCuEWMxbCverGRKyaxy91umHxph4VyRA1qN
 a1FyJLeQM89hUC6dAy3i21nsCIVNVVY1HEeYdfc8x9fwxpfJ/bSROVwvkktuymIRPJNIJ/CLQNv
 E
X-Gm-Gg: ASbGncvqTwZj+oCZ80NM+BxCGA90SNN401m5VuYrRT9gms4evt5VGBFDZVd2TefVEfJ
 NviDsUhTgzn8z9v39VEan5vk7vKQPs7M6Ldu2+Np2PnpD3v9ynE+6TDQKqzI2S60sC49cE5TMXQ
 4Ge1f0k7iKDjGGpt1aKz3EJAGVIENvytiFacdl+ZnTXUz84kW3Ic4SOK7doN6+WqPcjdJO/PQRf
 KRNK7iMFxMxJm+I5PWIpwukkflTrXmxgaE/72VWTTbV5W91+W/bT+tVOIU3ImcDzUd6naru8i4z
 q1SssNPWnQ8HjVB+7UCBMeikz7iZ2RCLuaA7bUAMXqrU
X-Google-Smtp-Source: AGHT+IGVCpx0QpmCi1amSZVFcp3Lx1psopBE1QGnul4nGQtrAHd3RHBlWFA8EFnCJxNgJUKeuy/0dA==
X-Received: by 2002:a17:902:daca:b0:224:26f5:9c1e with SMTP id
 d9443c01a7336-22780c55312mr14787485ad.2.1742509829392; 
 Thu, 20 Mar 2025 15:30:29 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22780f4581csm3370145ad.59.2025.03.20.15.30.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Mar 2025 15:30:29 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 17/30] exec/target_page: runtime defintion for
 TARGET_PAGE_BITS_MIN
Date: Thu, 20 Mar 2025 15:29:49 -0700
Message-Id: <20250320223002.2915728-18-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250320223002.2915728-1-pierrick.bouvier@linaro.org>
References: <20250320223002.2915728-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

We introduce later a mechanism to skip cpu definitions inclusion, so we
can detect it here, and call the correct runtime function instead.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/exec/target_page.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/exec/target_page.h b/include/exec/target_page.h
index 8e89e5cbe6f..aeddb25c743 100644
--- a/include/exec/target_page.h
+++ b/include/exec/target_page.h
@@ -40,6 +40,9 @@ extern const TargetPageBits target_page;
 #  define TARGET_PAGE_MASK   ((TARGET_PAGE_TYPE)target_page.mask)
 # endif
 # define TARGET_PAGE_SIZE    (-(int)TARGET_PAGE_MASK)
+# ifndef TARGET_PAGE_BITS_MIN
+#  define TARGET_PAGE_BITS_MIN qemu_target_page_bits_min()
+# endif
 #else
 # define TARGET_PAGE_BITS_MIN TARGET_PAGE_BITS
 # define TARGET_PAGE_SIZE    (1 << TARGET_PAGE_BITS)
-- 
2.39.5


