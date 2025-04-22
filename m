Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0D03C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 20:12:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JR9-0001Tl-VG; Tue, 22 Apr 2025 15:37:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JP9-0005bx-Bt
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:35:41 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JP7-00077p-9j
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:35:39 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-22435603572so60092595ad.1
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350536; x=1745955336; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fw918qmxQalPO99dinob5iJyGANUib3+dTX4jzZTubw=;
 b=BkEAn1T2yYokhU0DEU6WkCedNsAzZ2WApqakxNg+36i2zIHX8y8dbIvM00V8Sy3cd4
 o3XcXb77Zf7tdiB5067JDUedy6BsaYseOYLZmo9wD00YavKq7WjXwgCstGv6HGVSRmzr
 ivYiaRWvKeC0bHS7iBGVzd0mh/uR105xJN7xowv7NLqkltRPoD4tDYF5NOAqvdGDbWt/
 lqBl9+FOATUrP0Ox8f3QehvdQutBSMTK+hl3s0902tLjqLTYaoj/45KGK3Yvk5+YLeHs
 mT68+D+zGJUUSEU0ff0DnYeZ2UNuWip9AuKPeyk/kcpXrVPRamyHmLZ5gz/fKoNELZbo
 JTjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350536; x=1745955336;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fw918qmxQalPO99dinob5iJyGANUib3+dTX4jzZTubw=;
 b=ktptJAZe8qgXpXAsfibiGa3H6j+HOW6J2Zra+E6Zwkt031fgKUoVnm7jHFz2I0cqv/
 dLScp2Su/rzUr9o8RG/nzoE/d64zLqdk8PqWA9bkqpXNe4iywHC3INbD7tqyKcez1GCB
 BbgM/T6yFFORDM2NIxDzpvdP6wmbSpCC0/svd29jbEG5K/Jr9BNt0q/LFVEuOrXggcKp
 YU9djT81CbljycgPPBCTB8t+iEwmNkFjb9c6edObCrFl7tqE87PyuYdLR7gvReIuMINb
 zVlHxo7rgTvj8VBzhG3NyMroOhMxvKze36oWsYL9ZQrDY/ANGcdI7v+mYJlQWTJEKytJ
 Cqiw==
X-Gm-Message-State: AOJu0YycVE9uud5PdizMlLvEL9GPOTWvzx1siUNCRdX/I/DsK0hiyg19
 IG0L32lv+mbaSqtu+jrgBChAtO1zMDeZuHhJawueQf544FlzpHf8MI96/Df1zxDrGTwLdQ1xF3R
 B
X-Gm-Gg: ASbGncsjD9dDtPw7UrwVF3qvaUPd0PeYGzeMZzmo7SZPUx0RwFuxxI9XSxwlFuq/zZH
 Cq8VXaOUBxmtFOCL7Ga9NaubkXcOes1FnlHbpok7bb3gmOzwnUOnHe0zeDJkiRUNd3U9WPguZom
 //d/0KL+EeEjjkKczpxidgwaDHTSj/TRuWMAccGiOKUK5tZsG5ZCm7Pc6BgUqqSXUWudYdEYuB8
 mXRojdaKQ8NZbPhnNQ3NvbwTA1wwDEEI5AL6MUQSyG6z9NpaOwbIHmhgUKaxyl/yjrS5wBO09Yx
 Xt7OQeXXuiW6q5Tffi/2nesB8M3vkQhGqhrXG54BDMVVuFhSW1B83cmCp45eWZ+j5I6Il8jkB0k
 =
X-Google-Smtp-Source: AGHT+IGEARHFn/U58Rptvv9znn0XMviagizRj+QtR+PtB2hLU6q/NKe+VhAaCK/Xr03HR0Ol1ycnjA==
X-Received: by 2002:a17:902:e747:b0:225:b718:4dff with SMTP id
 d9443c01a7336-22c5361b4cfmr252574405ad.53.1745350535920; 
 Tue, 22 Apr 2025 12:35:35 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50fdf1f1sm88996795ad.237.2025.04.22.12.35.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:35:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 115/147] target/arm/cpu: always define kvm related registers
Date: Tue, 22 Apr 2025 12:27:44 -0700
Message-ID: <20250422192819.302784-116-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

This does not hurt, even if they are not used.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250325045915.994760-20-pierrick.bouvier@linaro.org>
---
 target/arm/cpu.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index a8a1a8faf6..ab7412772b 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -971,7 +971,6 @@ struct ArchCPU {
      */
     uint32_t kvm_target;
 
-#ifdef CONFIG_KVM
     /* KVM init features for this CPU */
     uint32_t kvm_init_features[7];
 
@@ -984,7 +983,6 @@ struct ArchCPU {
 
     /* KVM steal time */
     OnOffAuto kvm_steal_time;
-#endif /* CONFIG_KVM */
 
     /* Uniprocessor system with MP extensions */
     bool mp_is_up;
-- 
2.43.0


