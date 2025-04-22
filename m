Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94ABEC369D7
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 14:57:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7F32-0007uS-19; Tue, 22 Apr 2025 10:56:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7F2s-0007dN-Vb
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 10:56:26 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7F2p-0005Fj-F5
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 10:56:22 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43cf06eabdaso50859015e9.2
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 07:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745333774; x=1745938574; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YFl8Ly/qyHwYtgftZrE5c35JfKlQ5+ZoAjui+4BDjNg=;
 b=oXgfEHyKmjWzHIcNudOuNddB1ubX8BVVhIpF61mc2529tSWEJ+EnNqbV2uR/sd1zSa
 6q6t3N7+h7ASiTNddlguKVnAiBxBf1qIVsejyCQk7OSO3bj5FmoE+YMVByUjvyPq5f3w
 MwRKlKHYBDUN1PdipOsmJqFLi9HLW+MHBoQOpqT8XxRiK4FqGor28l3Tu0FFP+cD+6qt
 HFRm3HLqK6FHas7BESVsfxMVhIAex+JeCema+EjxbAZR6aQ0n3sfoVKyBCnPTYdqBAWd
 eiwYaB4gJ/zJV9HSyuVodj2LpOBxPZ8ENjbIGZeOc9CRB4C4P7ZH+Q7xXwwfc0N50iAB
 b0JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745333774; x=1745938574;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YFl8Ly/qyHwYtgftZrE5c35JfKlQ5+ZoAjui+4BDjNg=;
 b=DYsw8K2jdC1UQnuhz4nB6WrtN9YggUdDHBd2eaBbS0hDyZ7G0e6srvbkr4qTNX84ww
 56BBBv7d5ID1dcWrT44wOYiPkKxHiRnue3Pz1ShPtGxPQ7TLjFqkWIuGyLYutO6p1k9o
 +6WBod8Gg4rnv3bmnntbKqb4LDoF91/bGOgye0ur67EIyFatajtrjLbrFSbb5NDnWt0u
 Blo5UOBCn5ArFDWetXaeNdjeb9+c4hvMrTSIlsCk2Hh4Qcy3Im7ZKBwKlB3f+eMadIyJ
 VNLhcwyz53qh6/b0+aX0d9NhaQ8WZVT49LQ4OgkUD7rKXPcJFTBedS3iX5/b+0gPAFsH
 Z9Ww==
X-Gm-Message-State: AOJu0Yx6BODBfjcK1LG09Co4TqdnmC3cTUI0GHqamLfTbOmASMyUwWKf
 QZpAK/HXzaj8uLLqLafAqdGCNFG+BJeFFjVpolUCkyF8cEz63LPzYE1K6dqj20cxzl+u1I2FOqI
 l
X-Gm-Gg: ASbGncu5t6k9PVWPoGq7NkLs/0ZoRW/J97O7L63PkQYdvy20ospEXvODPED77DOP7zd
 Fe12gnmhRi5RKV0h3VaBPqm7NRCX0LM+6iaZWqcw0lQjRM6rJPWBlbOjlK1XDOwJJ0gKlo433j9
 Sap8R+QCp/gaWKH3GCPT8BAhuVaj6zuvYL4tj6gDoTyRmc8fO2aETbCmYZRxb/2Krc5NkltJD/A
 RuOy9xLLrHIxoE2vak9dnXs0pG+hPIHiJXbO4wGZSfC729+ZrsZyxlTRQVkWMv+SmYHXW2GliOa
 +vs/jNwJr7hAbI7mSrSBTAkoRGcPiMmKjGP3nLsjfzwLKxdDf+jRB/N9C21CSGWZkOQG4/oixac
 pKUebkCZsJMlPS7Y=
X-Google-Smtp-Source: AGHT+IFq8kbE/8/9p/n2YECarvmTGEHnaXJpMra01NqPxg85+24rZvXO95tpaevMNM4daDOyK7F4/Q==
X-Received: by 2002:a05:600c:54c7:b0:43c:f8fe:dd82 with SMTP id
 5b1f17b1804b1-4407075fa9cmr101218505e9.18.1745333773802; 
 Tue, 22 Apr 2025 07:56:13 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4406d5acddfsm177355865e9.15.2025.04.22.07.56.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 22 Apr 2025 07:56:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [RFC PATCH v4 15/19] qemu/target_info: Add target_aarch64() helper
Date: Tue, 22 Apr 2025 16:54:57 +0200
Message-ID: <20250422145502.70770-16-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250422145502.70770-1-philmd@linaro.org>
References: <20250422145502.70770-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

Add a helper to distinct the binary is targetting
Aarch64 or not.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/qemu/target-info.h | 7 +++++++
 target-info.c              | 5 +++++
 2 files changed, 12 insertions(+)

diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
index 0224b35b166..395c009baf2 100644
--- a/include/qemu/target-info.h
+++ b/include/qemu/target-info.h
@@ -24,4 +24,11 @@ const char *target_name(void);
  */
 const char *target_machine_typename(void);
 
+/**
+ * target_aarch64:
+ *
+ * Returns whether the target architecture is Aarch64.
+ */
+bool target_aarch64(void);
+
 #endif
diff --git a/target-info.c b/target-info.c
index 0042769e3a2..7f1758ae34f 100644
--- a/target-info.c
+++ b/target-info.c
@@ -19,3 +19,8 @@ const char *target_machine_typename(void)
 {
     return target_info()->machine_typename;
 }
+
+bool target_aarch64(void)
+{
+    return target_info()->target_arch == SYS_EMU_TARGET_AARCH64;
+}
-- 
2.47.1


