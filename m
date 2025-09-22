Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A896ECAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 18:57:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0lhg-0007nI-KH; Mon, 22 Sep 2025 14:56:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0lg3-0005AM-PE
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 14:54:21 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0lfP-00050t-J7
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 14:54:18 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-77f41086c11so1133293b3a.0
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 11:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758567214; x=1759172014; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I2QV3v6q0puRhrfNpRSWoo8b8YYN0t1SOeYhVDpb47A=;
 b=wrf91L7iei04UENZYm3qBdu6cr9+JV4Z9Anqgj7nq9abdhrxLdyPTxcvbqReaAslho
 u7r01ikXqbtpRugYH4uppMWLLkr52rMhd+lNWUAVsIG7NOefZ1CsYF4Pi8OsfjUb4DYN
 sVvRw7QfByUHDlfVZQPNHN2MTPRKKmNAjSskoPccyMSvxKYZyDDGla3AOIubnwABmK6t
 xDktBo9+DFN58RzajCoMwjNL6p2SDST/c0zigyfN1c1On1OIHrKia+wyiT2kydHI/KVq
 05GKAAkrgZ+Llv6DNYJps6aUYnuj8QyY0RPHMX94ufRH6Kd/317b36VFfm6d9NyEzP4u
 sM7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758567214; x=1759172014;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I2QV3v6q0puRhrfNpRSWoo8b8YYN0t1SOeYhVDpb47A=;
 b=Cj9SI0KGG9vf8mHQdr1IK6FKIJx8vxWIKg1ZdGKQdSprlWjbqVkspx8aYvaPK7W3gJ
 BTwAVIfQCZkcdq6Xnx9RVGYYLuATsZqERph88DwQsTyf6hg/sPbFYYaBSwchGN5sbHyQ
 viTW2OvzYFHO0wHmnU8BqYJEuZOEzV1mAn/rfw30vzDEERyaKxFvkVRgmlCtjmjppCha
 hX9/lrSb2ucdUrzFyJYXqMXDoYrS8G/WthBOmOvDNEif8ByIvbPiQ74SfuJ1t1ciqlHa
 5sd1bI/G003/AIO+E2nhN2HcRTSGxBA+4q9I0Hu97a1bV0WurE+g1+HikxDZwgdW9VJV
 PpwA==
X-Gm-Message-State: AOJu0YyWhAWFwQ9H1R7fJaC4uu2SARd2Eogkl5fbaE6spbB5+PVvt/Oa
 rWLFqfiUjYYKrPXZ7c8K3bACQDfvh8NkLCQpIwZnYxtfxYItZ/FUEHBr9QST+JKnoO713Cj1j5U
 m/mbq
X-Gm-Gg: ASbGncv6Sfqb89IHnw03yEL5sQYMoQo+GtdhOj7IvdQDINwmLj3XkvfB2dobYFZHS8+
 nJ0pc7ZXJ0aVIIDMSLlawHXQo3TxCohHrgx4Zzvd57BDnDRiTeydeMupt0aHgqz5ZrIJEEFIeXJ
 5UugyuPRK/6jm9Fsjc233JPhjBMbuSCr8JxiE9jMuDBrryrIku0FE5XyT8Xq/aurMJSbdGmTlus
 R3dqzZ8q4Mh8LlJn7fkgFAmwibjDtHMXa1OeLP+NHnZFgdVW7eJyj1KKmJkn0zdPcYf9IqzCJsg
 oLhzBsVfbdrNOq9xH178b8iAKHfFSlTxXfEfw2eH3fQ6nE+bKs67JbcIB//Vswy4JMBvZ0BuoJn
 qVeuliQmkDQuJzhkE6meOvXWaRNgp
X-Google-Smtp-Source: AGHT+IFPpkLSx8g3Nm3wtO7Vhs22L+fME+iXuR9KOlLYaezmKLhwkiSEg+Pcv/gcm7tCEEDmbIuCSg==
X-Received: by 2002:a17:903:2289:b0:26c:5c03:678a with SMTP id
 d9443c01a7336-26c5c036965mr135609065ad.9.1758567213893; 
 Mon, 22 Sep 2025 11:53:33 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2698018a472sm138554795ad.58.2025.09.22.11.53.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 11:53:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5 62/76] target/arm: Load gcs record for RET with PAuth
Date: Mon, 22 Sep 2025 11:49:10 -0700
Message-ID: <20250922184924.2754205-63-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250922184924.2754205-1-richard.henderson@linaro.org>
References: <20250922184924.2754205-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 462c61032b..aae6dcd548 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -1898,7 +1898,12 @@ static bool trans_RETA(DisasContext *s, arg_reta *a)
     }
 
     dst = auth_branch_target(s, cpu_reg(s, 30), cpu_X[31], !a->m);
-    gen_a64_set_pc(s, dst);
+    if (s->gcs_en) {
+        GCSInstructionType it = a->m ? GCS_IT_RET_PauthB : GCS_IT_RET_PauthA;
+        gen_load_check_gcs_record(s, dst, it, 30);
+    } else {
+        gen_a64_set_pc(s, dst);
+    }
     s->base.is_jmp = DISAS_JUMP;
     return true;
 }
-- 
2.43.0


