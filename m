Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFB03C369CB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 01:30:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7lH2-0005xN-RQ; Wed, 23 Apr 2025 21:21:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7lFU-0002mL-0c
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 21:19:35 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7lFR-0007Aw-V3
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 21:19:31 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-736bfa487c3so314065b3a.1
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 18:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745457568; x=1746062368; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VlU+5utG7ndLnI3liyhSosykEbCdiIswzRyFOphsCF8=;
 b=B9FrrQ/N7VHA6vgzAOJS9440S0deznHAksILF0WClzpSja3OMOLs0pu/pg2FOdPxlt
 ZY4NkEn5PAJV7RXA5WGgH8E9yUIx7VNIMjuoILstdnd9R1C9o35Mt7/ZKT4nG32Exx6/
 R4l/NcKEf5YmXVRYXopaZ+NW+P4B29VsFa1mW0zYG6JSmaYrRJXFImWiiwBhHM56Yjmc
 LjTliUMraQa/WotKAbDlM3HgAfgUBQyROnuOo2yKMENh1h0rBESMeolDng3z3DG1/OcT
 R954777z8kMV0s7PBcgiJyClYMN2U1rzx82MTm+V91izhbVb9tr9REmSZd5W4FhKrJ1h
 Q9kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745457568; x=1746062368;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VlU+5utG7ndLnI3liyhSosykEbCdiIswzRyFOphsCF8=;
 b=vaZxn+vZ6ZI52CA1HLFGjvVKP+xfXJb48o7njy0tmWf+q/OBRxQOSEd3lI5DX/yjoK
 8/LYw1Yy3IHUwryQCNp5joabO2yTtt3qXoYfF1cNZpQ6DTrXQ7GifjVNzGzVCsefNxsr
 fZg23DyRJOYdb9Y8b7Q6j5WJ2zFoZbx/Ocu64RRC3bHncj6fCancOpg1svm6jSE9H6jh
 M6zInNLAbgSS39S0H6zq47sZpj3sfAKAXNCjX4id/5iPOEChrUYGgyGx65FAUTswoh62
 224yppU9vEJE2d68CajADlYUkUpPA1xuz3pHHgrKq5JCsdnosts64DvE8LKDQhRdnrK3
 GtXg==
X-Gm-Message-State: AOJu0YxMeRrc3K2D7Bp8v6qpnT5++EhmdZmPQKkC0FGPpZPRv5m7RfSX
 VcyCF1vvugKaqXtcBd3RNysOvycsRRel67C9PvAA18+l/5Y+Nf+Pz9tXXwEJufPDX/g0/XeI4Oh
 P
X-Gm-Gg: ASbGncur2KoWAfILMHg8oN+glVxUz/9qGjV/HP7LfyINYqC8pUj/hJrWkSDauSQkyZn
 JTEwq2AkYgBtaAceATQ3chI1VfLW24n3d/3vKzrGSdO8ikyHVylEuhrjPHaWHwyENjzWjF9K4Wf
 uGG+hFFpsnpAgF27Op7/ocG4N5qeGLpgZK47ehkt2ONwUtiF5ReVUKGXJ0XPjCahDDAEd/77E1B
 HcJ/p8BdVuKAWvXLdXty66JJQI45zfXEPtu2lJWs8SliESzFgnLUNpOjkIvi3qix/43OJ54S8F7
 KLvWDMwX4ioT0BzBnBYKipAM74OVyq5QXXXcHGV4d1kMulMDhLCakRk269jXkvV0L5GvxKgq3vo
 =
X-Google-Smtp-Source: AGHT+IG/AiqF6TryjbnMvGK7c4DYyhTpzBnWdrxVTY1kGNrveMNEir5EvPVzevlwdam73SiFhejLnw==
X-Received: by 2002:a05:6a21:108f:b0:1f5:591b:4f7a with SMTP id
 adf61e73a8af0-20444f9e9cemr942334637.38.1745457568423; 
 Wed, 23 Apr 2025 18:19:28 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25912ef0sm244079b3a.10.2025.04.23.18.19.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 18:19:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 14/15] include/exec: Move tb_invalidate_phys_range to
 translation-block.h
Date: Wed, 23 Apr 2025 18:19:17 -0700
Message-ID: <20250424011918.599958-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424011918.599958-1-richard.henderson@linaro.org>
References: <20250424011918.599958-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/exec-all.h          | 4 ----
 include/exec/translation-block.h | 4 ++++
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 24383b6aba..90986152df 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -120,10 +120,6 @@ int probe_access_full_mmu(CPUArchState *env, vaddr addr, int size,
 #endif /* !CONFIG_USER_ONLY */
 #endif /* CONFIG_TCG */
 
-/* TranslationBlock invalidate API */
-void tb_invalidate_phys_range(CPUState *cpu, tb_page_addr_t start,
-                              tb_page_addr_t last);
-
 #if !defined(CONFIG_USER_ONLY)
 
 /**
diff --git a/include/exec/translation-block.h b/include/exec/translation-block.h
index 8b8e730561..cdce399eba 100644
--- a/include/exec/translation-block.h
+++ b/include/exec/translation-block.h
@@ -207,4 +207,8 @@ static inline void tb_set_page_addr1(TranslationBlock *tb,
 #endif
 }
 
+/* TranslationBlock invalidate API */
+void tb_invalidate_phys_range(CPUState *cpu, tb_page_addr_t start,
+                              tb_page_addr_t last);
+
 #endif /* EXEC_TRANSLATION_BLOCK_H */
-- 
2.43.0


