Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDB3EC369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 20:26:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u837p-0008HH-QS; Thu, 24 Apr 2025 16:24:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u837h-0008F3-FQ
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 16:24:43 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u837f-00050Q-Rm
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 16:24:41 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-39c13fa05ebso988866f8f.0
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 13:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745526278; x=1746131078; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3spF3BHyP+3nJq+PBnSsTeYKhoBB0RsO1qRS6M0pmcw=;
 b=MUfkEqIB7lPXGeP90ULAWyHvcSHQ9yJQur14O2b8oATemj21VJ3F7El1oFm8ps821r
 0N0pYVq69lRB8px9WLCcVyXOeTG8RbqyG0d6tpnYcILM2wym7ZGuc2m2txB5GguEOyVv
 FhtOrpWLFALjuXPH64NcINplm1luYWffa7Cz+XegSuL24zlG29eM52LLFFIq5hTgjQl9
 uLYCneLI2GpcfR+6CCfWXHvnmMZkRQJx3oJlZg1DZkA3FQQvEzIcsIopMzoFusw6F1oF
 eOP565x5LhVCf08EPSetAuJ0nEq0c5Fov1LEuNOlb1MYHil8SUUmrt5VyW6Gk4jEQRBw
 y9eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745526278; x=1746131078;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3spF3BHyP+3nJq+PBnSsTeYKhoBB0RsO1qRS6M0pmcw=;
 b=V8gFD0xh4kQ9bEjaR2Azn8QXExOOdwfsRmQ6xGCrde3Sol+4gsHyPz49aX82PvPlIG
 yzBdazMwcpS4YXTfm9vKAmvU3JPcDHZ0zZU18mhlzOG4U5Knf5/B9t+9ry6Qi3On3wO0
 UK2dNRHkJ3t7PvJ5EKrPYZP7UAl8VNz59Vgc7TlCcPyuovkMUgCz0u1iL1sZGePbIRjk
 9lcBDn4tehUGS8MpuHexvcu/b4ZhZjfa07Z7rIayyTdcNoB4DCmTb475nb1xULQNQB5m
 hOYPewx4HK7z4yPnWhBNCqG/WBC7cywFi8nWHgn2Mkz6DiTUc+VlD9BA7GuyPn3HOa+p
 Ykdg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV82L8jR9zJRzlRvHQI8BJfX+Mc2FDNtL+k5hFvgn5YV97XSzTSmLkbQtI/csKsLY+PVozyUhr22NK3@nongnu.org
X-Gm-Message-State: AOJu0YwbvArH856/rSKmPlyxodtHx1EstW73ew//ajwjN/Fu9GVRGcxL
 Ewtp7VCMiJ28iSQpDJ42fM9/C6Wgcpj66WfIhLityP0trgKacK9fqMOwJ7c5oBI=
X-Gm-Gg: ASbGncuKzEazuMoVsunJ+5uvCcrn1MqfPmwl1HGyNOASmK8N/5aX99AFUnY0f9eRu9e
 XHw3jlUU4OaZLmMk+h11PNmLDVVma4oO5OSpRJn8NebR+K0p63sAvdYZOHg4q8sLjob0bQ75qvL
 I1CwfG05ppZcuHTW3NWG8Wjo3FGHpidB3KEM5+7XaV6HpkDNv7IkIS+BuiKjEk6jBcPRgfcgxx5
 /unZQxAezh3EUPRCRqBwEa5VcccwppP6BF2PsvVp0owg25/JOiJBjM9egFM9rIGl7SY+ySIKSXj
 mywCzHhzz63542QQgxhdRRBgaQrxYveENrI+5nGNcfcA3FxJqMmm9BD8vxeacB7R8NJ1NOBf8nk
 hS4u1hUnckByOmKg=
X-Google-Smtp-Source: AGHT+IGN41rx+j8FPCY2AB3k/b8jhhgwUr9ZrqH8IdWXic8w0wKm80U35kHbxyVu5WsozwYASHkzLQ==
X-Received: by 2002:a5d:64e3:0:b0:39a:c9d9:877b with SMTP id
 ffacd0b85a97d-3a072aa6a1dmr625584f8f.27.1745526278019; 
 Thu, 24 Apr 2025 13:24:38 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073c8cd7fsm297607f8f.1.2025.04.24.13.24.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 24 Apr 2025 13:24:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 05/13] include/exec: Move tb_invalidate_phys_range to
 translation-block.h
Date: Thu, 24 Apr 2025 22:24:04 +0200
Message-ID: <20250424202412.91612-6-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250424202412.91612-1-philmd@linaro.org>
References: <20250424202412.91612-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250424011918.599958-15-richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/exec/exec-all.h          | 5 -----
 include/exec/translation-block.h | 4 ++++
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index c46255e66ef..4c5ad98c6a9 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -23,7 +23,6 @@
 #include "exec/hwaddr.h"
 #include "exec/memattrs.h"
 #include "exec/mmu-access-type.h"
-#include "exec/translation-block.h"
 #include "exec/vaddr.h"
 
 #if defined(CONFIG_TCG)
@@ -123,10 +122,6 @@ int probe_access_full_mmu(CPUArchState *env, vaddr addr, int size,
 #endif /* !CONFIG_USER_ONLY */
 #endif /* CONFIG_TCG */
 
-/* TranslationBlock invalidate API */
-void tb_invalidate_phys_range(CPUState *cpu, tb_page_addr_t start,
-                              tb_page_addr_t last);
-
 #if !defined(CONFIG_USER_ONLY)
 
 /**
diff --git a/include/exec/translation-block.h b/include/exec/translation-block.h
index 8b8e730561d..cdce399ebab 100644
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
2.47.1


