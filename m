Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1750C02197
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 04:04:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfWdw-0008Lg-Ga; Tue, 04 Feb 2025 23:04:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tfWdm-0008IM-Jg
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 23:03:56 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tfWdk-0007BS-CA
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 23:03:53 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2162c0f6a39so7762195ad.0
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 20:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738728231; x=1739333031; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ytZ7noDAYkPUTObh2VvZQ/o6CBNJfl8UBbSNHzJglWk=;
 b=Uwufksxqw6ocSzACK8/tQh5ZoBg1MQNYoqmhXfj+j2k1+6cT9jE1vovWYtkFd5CUMq
 TMgjQm6bZ1HBrGzLqizV6nKS3S5dk9Ook/jaM7H216JLhLXOcCmFk0+gMC9qrkR76uGd
 AY3E/9hfgo+JDhVihbjLPUtVqE04U/ARA/HPAPfyH72FjVdCDTnqc0g4NNOrm6f7bXiV
 752kdT5aSm1e0B9yAbNomwaU9S0ok0/xqzy1maFHJK+brqs8uAmLRwdUhV0YKboSb1Pv
 XHNwtU7Uh0Lri/cus+hNe/ZHfMffOTneiR6h51lFWQt8JGCeoCqdlM0tMgY9EL/6LaAB
 3U4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738728231; x=1739333031;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ytZ7noDAYkPUTObh2VvZQ/o6CBNJfl8UBbSNHzJglWk=;
 b=YLxJbT9SZn6wkpwKBjjgiCgGk7J62QqYMfJm2Hsx1IBTl1acHiVyQ8SeBPb/sQQjo0
 z4XS/HGx+1q7OPCVASdy9LdZnxBHpVQzRPUrcyDtsXj+7jjctYr2sWyTRh3YrifSYV4c
 hBJdCGXgabG+wiJ7CRpt+uWIKpzBMJ0i8I8oULIhbO2Ogm/5+NuGgzYJOU0KuAqWDJU5
 FCbxrsZGi37G/eDWO4N5ykalzHSpKxj1BFiAmfCznOlKwVvQilSgA8slDeyd7ajnpG0F
 S+Ar1MxPMdB7r6EgBXQppTPnPyL4iiZbtcVjXmXFjJO08JgkA2jBfxP+tYLeW54nM8mO
 3UvA==
X-Gm-Message-State: AOJu0Yzq0ZGpEkV1H8Y86QnoZW9/uLbFxxYmvbreBfw2bGfHXucQtsDW
 0pR2Gi4VRsTZHgPmFNw8BJVLVtHXixmOCvxtgSaSuAAaWNwNbENcnmXvnHL3RrocUqotUHNikKB
 p
X-Gm-Gg: ASbGncthak4P84+7HCdHcBWjp2raRz+wvgVMmGwufqENdW+HxH6xyenDSRvTfTq0aFP
 h5Bo0oJXw4LsOCDY5iBRLDpRIWoSXkMqSrk3KgbNEuCI6fCGj31b1rfR6WH4WuNjpAdzsfd5/p+
 KExUsgTa41j1Cjo2wZZGlH4ZgwCH42Sv9/1hwucSsSlBVb60vjkEkP6c49gOxlIT2q5oKQkTuSk
 W8Y01rn1faAltE5fvUQ6dECgYmFzcBRAqb7yyb68ghLM76mHBg4Ce/u1kEGmB7jDmUNeNy78kEk
 tec2WyL5K08JxDNxEN01R2LRNLihDhpgufs1pCYueCf241I=
X-Google-Smtp-Source: AGHT+IFyaCx056mEUL0v33/F8ebkpVoyCERJK8WEcdHYgnZy4mezvEJojL2ng/1Bcl3BxnQ6w0jQeA==
X-Received: by 2002:a17:902:f681:b0:215:742e:5cff with SMTP id
 d9443c01a7336-21f17ac8ce8mr20556575ad.16.1738728230780; 
 Tue, 04 Feb 2025 20:03:50 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f054eb89esm22380325ad.79.2025.02.04.20.03.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 20:03:50 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 08/11] plugins: Fix qemu_plugin_read_memory_vaddr parameters
Date: Tue,  4 Feb 2025 20:03:38 -0800
Message-ID: <20250205040341.2056361-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250205040341.2056361-1-richard.henderson@linaro.org>
References: <20250205040341.2056361-1-richard.henderson@linaro.org>
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

The declaration uses uint64_t for addr.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 plugins/api.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/plugins/api.c b/plugins/api.c
index 4110cfaa23..cf8cdf076a 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -561,7 +561,7 @@ GArray *qemu_plugin_get_registers(void)
     return create_register_handles(regs);
 }
 
-bool qemu_plugin_read_memory_vaddr(vaddr addr, GByteArray *data, size_t len)
+bool qemu_plugin_read_memory_vaddr(uint64_t addr, GByteArray *data, size_t len)
 {
     g_assert(current_cpu);
 
-- 
2.43.0


