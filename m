Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62FDCC02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 13:47:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYmdz-0002Nv-Si; Fri, 17 Jan 2025 08:44:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYmd1-00012b-6J
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 08:43:15 -0500
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYmcz-0002Gd-Jn
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 08:43:14 -0500
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-aafc9d75f8bso357074966b.2
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 05:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737121391; x=1737726191; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jqP9s6i1XKCADbEJhUROhCpIYtt+5Tsr7aRO+xN3Yg4=;
 b=bykIVamnXCh7A2va4nJ1jzc00WssVmFkPAa1WM5pNFZ0+AwT8ikXp3lKf1NxIRERuU
 4Ikmbx1l7kNDi4SiSilx0DTuhV8DifKwnLbK29hO4HZgDvNRChGaZkCiHhArweRQoXxL
 kONvV8EB62ju1ZHurCJ65W2t267fGca0OpSVsnEH9QCJ/xHqgq4z53aiYP9d4SS4jbc/
 Cwlp4BIGmGQxGRROhx9flfLznfqXFDtYGC0eF6fGCG08wopYZbmZ9ayY4rTfnApzaQ/B
 QYhu+1c8uVCAJ7n0obcHeIvDuS32/zKzRK2/dRyXyvtqE3Q38QfasyETuj+9HChmPWSa
 7zwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737121391; x=1737726191;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jqP9s6i1XKCADbEJhUROhCpIYtt+5Tsr7aRO+xN3Yg4=;
 b=GVw2Gvrj/m00cHa/uEXSZjNHVwUCjELDXNvkQPc8vxeJCT/TixgCPQKEZbHpxNL63h
 JMiT9lmf1tH8BJHJEsbNqhotivm+3fsbsqMBVPexZ4XBAdtdd30yg+TKZ+S6D7OvOwQQ
 yW5yvyp1oGJ9YT/qP8gJ9MIYnTUwxsQKH30oIZtGqqjbYxBQ54P/o1ArO6pNENwj+pjd
 7T31x/kMcWZrFfZ2ISXI/kwIbXws6V5T2v8FGQZTbwpJ1MAGqmqVM+XUbgNkLRGo+CCp
 Haq5PUrftNZLZLT9J7NtVfmVI4tVc4lSqlvVS/oEQ7PZ6cM+0GhrcFlFpNsUelNpXwG/
 m90g==
X-Gm-Message-State: AOJu0YyHMZ6sEyeCvCQWJMSlbfoGT4sHOCP3Y42l5xSrEUC0b0jKH4ZH
 zsCoM4a/n78Jf54RNNoFqQES4C1HLjqaWdcC53COrvIJ6ZTl3xEdL8QP4oxbpSo=
X-Gm-Gg: ASbGncsrFvfEeVhP+6FJrHxGciB9El1QdoFbwgzPiXrnUEw3TL4qOq7IRT1p+nOE9gM
 hzpSgoH9sSKvfvVX2nDblbxl36vJbP5Xh95KGsRlk+aj3ExkENsQ2KMNU6951fbdYkGO6qGxar5
 aWugXpyj/0M5CCkSKM5hfJJoEhmJSEOjR+H5IW4ZQJdI+sfH68mK8KgCbvBfOTDpJ/zu+y7lYis
 4EkY5s7AKFguMnFC4muGnqewvktmou5YqBHf7OzG4FQFI8TBkxMMTc=
X-Google-Smtp-Source: AGHT+IF3kqH2/xNhwlDEsbXKNOLpAnEYoMvkTt9biQNWE8OkTIsEv3LFSKlZakxouIvn6vmLlOaYQw==
X-Received: by 2002:a17:906:c107:b0:aac:29a:2817 with SMTP id
 a640c23a62f3a-ab38b2e4528mr224538566b.26.1737121390831; 
 Fri, 17 Jan 2025 05:43:10 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab384c639easm171521166b.22.2025.01.17.05.43.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 05:43:07 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id AB960608E1;
 Fri, 17 Jan 2025 13:42:59 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 29/37] include/exec: fix some copy and paste errors in kdoc
Date: Fri, 17 Jan 2025 13:42:48 +0000
Message-Id: <20250117134256.2079356-30-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250117134256.2079356-1-alex.bennee@linaro.org>
References: <20250117134256.2079356-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62d.google.com
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

A number of copy and paste kdoc comments are referring to the wrong
definition. Fix those cases.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250116160306.1709518-30-alex.bennee@linaro.org>

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 9458e2801d..605687befa 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -1194,7 +1194,7 @@ static inline bool MemoryRegionSection_eq(MemoryRegionSection *a,
 MemoryRegionSection *memory_region_section_new_copy(MemoryRegionSection *s);
 
 /**
- * memory_region_section_new_copy: Free a copied memory region section
+ * memory_region_section_free_copy: Free a copied memory region section
  *
  * Free a copy of a memory section created via memory_region_section_new_copy().
  * properly dropping references on all relevant members.
@@ -2510,7 +2510,7 @@ MemoryRegionSection memory_region_find(MemoryRegion *mr,
 void memory_global_dirty_log_sync(bool last_stage);
 
 /**
- * memory_global_dirty_log_sync: synchronize the dirty log for all memory
+ * memory_global_after_dirty_log_sync: synchronize the dirty log for all memory
  *
  * Synchronizes the vCPUs with a thread that is reading the dirty bitmap.
  * This function must be called after the dirty log bitmap is cleared, and
-- 
2.39.5


