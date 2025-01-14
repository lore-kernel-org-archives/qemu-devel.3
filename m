Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85B73C02183
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 11:48:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXfOE-0004Nl-71; Tue, 14 Jan 2025 06:47:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tXfNn-0004KF-QT
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 06:46:56 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tXfNl-0006dt-Uj
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 06:46:55 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43618283d48so38404075e9.1
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 03:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736855211; x=1737460011; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CCpqJSBadXyBrjebPIu8ZLRFMr8IBo0L8bVYPsM+QnQ=;
 b=oifINEBZ+geTQwIf2jXZ4CFiekHj6JtEjBG7NfANRW8h3Rg0/Ay0wVDUgy3v4YKfTO
 eK5eR5zPK4UkeJlyCUaSv/SCx4qCWFKKWiA4/lA5sIvYrAxLsic7LpQ9pA+lr178S6Nt
 jt6PiwoniyFDOvqRqe4ab4SPnz2uaqJ1OT7WRsM9ZAKiqMce72VpSCUv5DzB9hqVG5Nz
 PqH+0wPCVwNOOT7l16H2fl6rXMoo7/sGeoTxDQj/2mmlTefRDxmJUgY4LuAbRwe2wdHW
 L9ReTpCg5bgtxyw3tm2VB2lh6uNMHfMHbtQBF8NefLa+A/Mjosjk803XwGVXCkY3DYTg
 XH8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736855211; x=1737460011;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CCpqJSBadXyBrjebPIu8ZLRFMr8IBo0L8bVYPsM+QnQ=;
 b=N1LzzDiCf5TKXhNfQRhZgDt7+T48CMbe0gdiSy1KFWk6kp7385C8/FnSAo/9C1fA1E
 56drYhRXsxhN586fkJ6a1rGgdatRKNqtMOjdn5jdkZg/eiMe7Sz6wFAwmGLjUiwQ1cRM
 PffnSxlWU3nAIzCy1fFLCLB6mXSg39npDXUCAq34DvtTWr0YZYYoYmLJtlDpOEIq8p7p
 RvvZDJRYFMyS4zF86uI5yp8c8vNQmKdLDeBu+Zj8eKcnax8et8ZWY2uN5nwzWhPRomS7
 e34y8olG/igEic0RpXerOMEyIVZmK5DY4R8GKkkL+jKANA+SlqeO0o8hWlPukhyDfWKL
 NBrQ==
X-Gm-Message-State: AOJu0Yy3va0/i6ML2VLv5jzWThvmhdV3jSYZsg/FPWn2btd/YvjBXHpB
 4jtorxCBwPht1lFw90RTh3Bo8wbkgplR5jgVb3Jf/2R3ZWFEV9ru9cghtpb5M0g=
X-Gm-Gg: ASbGncshz26fhzk+T013nGVsSjJ59TIxITfkQ0kz1UguL5mH9nJfXkjZ7BH5Hg5K6cm
 2HH6VyB2r9MyJyuZnpN2WxhDZHSPFiOg+/eLaakQFU1Fis7m3zVNizjRD4fuAhkxUXfiTtTZVVf
 4I0l9PltzS0+57uZkp5Keos2oiiu7z4+6E7dkxvtY6yax6MdggGrIFCOEE+TmuTDeiquwuBR339
 MVChZVYFtIGLlcYR6eqH/GR7/HE0LxneLzYV82B1Bl6jyTTKy5tXlQ=
X-Google-Smtp-Source: AGHT+IGiwCKXCZhfSZ5M9ZJrS7liWZwRELgRdLtLHYzveMatbIefSQo2ssjEhBnAZM7m/2hY9o6TPA==
X-Received: by 2002:a5d:64a8:0:b0:38a:8d32:272e with SMTP id
 ffacd0b85a97d-38a8d322a66mr17360640f8f.46.1736855210969; 
 Tue, 14 Jan 2025 03:46:50 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e37d01dsm14498717f8f.9.2025.01.14.03.46.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 03:46:50 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8AB855FB63;
 Tue, 14 Jan 2025 11:38:24 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Weil <sw@weilnetz.de>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>
Subject: [PATCH v2 29/37] include/exec: fix some copy and paste errors in kdoc
Date: Tue, 14 Jan 2025 11:38:13 +0000
Message-Id: <20250114113821.768750-30-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250114113821.768750-1-alex.bennee@linaro.org>
References: <20250114113821.768750-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
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

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/exec/memory.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

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


