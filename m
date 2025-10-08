Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 713EECAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 22:06:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6cBF-00055z-Dl; Wed, 08 Oct 2025 17:58:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6cAI-0004Nl-T2
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 17:57:47 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6c9G-0006jJ-LM
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 17:57:41 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-26e68904f0eso3118735ad.0
 for <qemu-devel@nongnu.org>; Wed, 08 Oct 2025 14:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759960593; x=1760565393; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cpkzy3bVx6ucXbODXlPEH+NEBtm/T2sk9FDoLQjAyaU=;
 b=x4oEekLcjqYYsh0BACDvS08ldio7YNif7Ecm6Ydmvg2tuI6GUcMlLxpq/ygNAmRjbv
 FuKauLmzugGUPrkR1plIvCb1qWIgyo2lwJE5N0niwz12ZSqX8kFU4wOFDxfkC8udQ20t
 3aQZCOz7kx+bGorXCOh7qlMyiia8UMAaxP1L3Fc6nBhHJBf9DDVimE1yR2IzG/GfBkgI
 4s8tKQgVCwlngXyq7/pzA+pbTr/3/9hnrwIk5E+tskrpU+CDhofnGxOgWe5VEoqoO8qy
 RQyNWQfI/tRlebD2S2BEuNFFDS6QkA5Gwe3p+i8AkAXkLoP7V+FhXnePFja7HT7WYMy0
 LViw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759960593; x=1760565393;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cpkzy3bVx6ucXbODXlPEH+NEBtm/T2sk9FDoLQjAyaU=;
 b=tAO936IUL0DZu1XwG6GXMYQIZ+imjiDr98HlyRgWD0WTZmuWDpXDW3hItgVVjm7Y96
 Mm7Rr9Qyf0f8+MtRoaz3lj6DFA3W5jjt+vMQsAUIYlTHa1KHGUNaIOVMEzdS7wjlCh7p
 Wm+kniZIzDR2fFR/KPIP/f4AQBD6zJd2a0JBhuXx1YW/ItcaPxHTlCacaUwtFJ/13gq6
 Utb757g0GkEZEzOkNwgiQnN1SyYOSK8t1SrFSu7ZT6Bz6lvn4nwQYSuHveV8uGtLmrLy
 M1FZrnVcFqcNBn1iBxG1PVZbZLZPvaA1J4o9h3T8JSvaPWePMj/FMMpiz2vOrIa1t1kl
 VL1w==
X-Gm-Message-State: AOJu0Yz0rXMni9vferBP7EkutMQjG4enRBE8ExmnsH5YmW2Nsm1qcnmX
 WDZr55+8XBmXjtfgpTVd75JyOYBe8D/Z9/ACiaBOBv4wTDyRyMCIsHR/moKDHi4fMwLz/4IiZys
 M0VahV2g=
X-Gm-Gg: ASbGncvQ4RNg61yd0YYHe5r4beOoRkPjv+o2SkM4nEZBbr0ROAZWnEsKtR95Qk4v22a
 45xnGJLEzMogBf9qmq5AZ9gMR4EDg26N8OtxnHJzebPtpN5KKfgXZ5M7lReEOD2tnn2rSgb9/Mo
 2RhO+N0nPLXvrQTg539Kxkxe7xCH7vVIrCH4DWec3nkdx7+Tht6vUKkP+Ftrn0xpJ06F3oUf7qX
 F7cXNV+O1MNaSC/aNG2U58sElrqHeO0yHI7nZXuz7eEdTM+c+mC6F47ouuBGl1tip0kN/Huh9uJ
 Xc++dWAAMFSfdpFPHjWL783qANRWDald8vyRAGiBd7duCpfDS65xtfJarkbtEY85Q2ljI9dLMMF
 GzVbSakQE+TVccnl19M0FNtPtjovVLldM795QdTrmnbtCdH5yGeV/JOChcNrpFyQg+0o=
X-Google-Smtp-Source: AGHT+IHy6fHPrlzldAiRH9eQVfcpNc5mA87s1dYlKjVLIUiTHoqBkp9wMW7l/sd7b7Vm0dB2/ERSuQ==
X-Received: by 2002:a17:902:ebc5:b0:26e:e6ab:66fe with SMTP id
 d9443c01a7336-2902720f560mr64279895ad.5.1759960593373; 
 Wed, 08 Oct 2025 14:56:33 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29034e44ef9sm7354285ad.52.2025.10.08.14.56.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Oct 2025 14:56:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v7 29/73] target/arm: Support page protections for GCS mmu
 indexes
Date: Wed,  8 Oct 2025 14:55:29 -0700
Message-ID: <20251008215613.300150-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251008215613.300150-1-richard.henderson@linaro.org>
References: <20251008215613.300150-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

Take read and write from the s1perms.gcs bit computed
by the Arm pseudocode.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/ptw.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 6c52ed1ad0..d4386ede73 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -1619,12 +1619,16 @@ static int get_S1prot_indirect(CPUARMState *env, S1Translate *ptw,
         }
     }
 
-    if (perm & PAGE_WXN) {
+    if (regime_is_gcs(mmu_idx)) {
+        /*
+         * Note that the one s1perms.gcs bit controls both read and write
+         * access via AccessType_GCS.  See AArch64.S1CheckPermissions.
+         */
+        perm = (perm & PAGE_GCS ? PAGE_READ | PAGE_WRITE : 0);
+    } else if (perm & PAGE_WXN) {
         perm &= ~PAGE_EXEC;
     }
 
-    /* TODO: FEAT_GCS */
-
     return perm & PAGE_RWX;
 }
 
@@ -2277,6 +2281,13 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
              */
             prot = get_S1prot_indirect(env, ptw, mmu_idx, pi, po,
                                        result->f.attrs.space, out_space);
+        } else if (regime_is_gcs(mmu_idx)) {
+            /*
+             * While one must use indirect permissions to successfully
+             * use GCS instructions, AArch64.S1DirectBasePermissions
+             * faithfully supplies s1perms.gcs = 0, Just In Case.
+             */
+            prot = 0;
         } else {
             int xn = extract64(attrs, 54, 1);
             int pxn = extract64(attrs, 53, 1);
-- 
2.43.0


