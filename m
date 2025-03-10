Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB86FC2BA1B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 04:59:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trVES-00035v-O1; Mon, 10 Mar 2025 00:59:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1trVED-0002iE-Gq
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 00:59:01 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1trVEA-0008C6-L6
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 00:59:00 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2feb96064e4so7420520a91.1
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 21:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741582737; x=1742187537; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ErKU0wbfVZdnsjs5NMSuiTB4KixyX1gD9AraKkIZNBI=;
 b=Wwce749RdHqlRIBZdhrckPzjhjP88AYfjokiqXFaAhgQLoXstreXcOoKtRrqZFr1Q/
 7GcYLPbDlUIzkM/14W+uly017zKgkxkbl9nLoKSa7Bt7KEb1T+xvZ/s4nCGpD/CPHALl
 2h6jRWIHOEcdVQXGUY5JZQxLq6JQQJNWbaCSwAdn7owihpXGldkiiJpknoXlaDNG0B+c
 mv1PJubKa68QATrc+S4EF635osuJQB00I2WDI/qrU5HZ+4gfrSL1vDsoNtsiQiJ7uwoh
 z14m92uCqW61mWzZI3GcnLoxmzG5fZU3McNEI7x+lTBQotkjNuUmdPfglZHWM9bZEJ0z
 +XQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741582737; x=1742187537;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ErKU0wbfVZdnsjs5NMSuiTB4KixyX1gD9AraKkIZNBI=;
 b=Ou6g6OHmHRicFhWlK3+gcUDiEvrB6eNvpAvli0FelWMQvygktfLcqBqY9gcYeXXDVS
 jxwM+qbetKmZNEWWNDs+2+1IUGCMwGROXzd8sxkGNerTkq9rblJFETkAI39HCi5Hoy3J
 5SSYxVJcUNPyhd84KYjXXjilZkilIdh0Ze9cuPo7r82F4YLNVEHxL5x8G/hi/7XNqB3G
 d40tzQLGdGxjSHLE1BmV51Kb5nyf/Z9cwDjD53lgCa7FgfLfTNxUTmW10RS42hT4Y+Pa
 EjuMWqaUYYijf4toD09Kt2ripBbAJB6WY8PTYe4RUfaQWdb6qSK7ppL5wRLqPOoJo0ew
 9QWg==
X-Gm-Message-State: AOJu0YysIb7Wo4cicvlGunYY6abmVO9ehdftYr68nVEqjqzOs7Z6quoz
 S3+Zl7e/idqEuYMZgCP1qYjejIzJ6gE/3KrMar+EEI3P4nk5bS9ZNqBqWsWEpCaV/6FJ7YQoSAK
 cXRw=
X-Gm-Gg: ASbGnctHyWuKqqoUPpGKpJ193RrT6C+Nx4O+yTt8GJnvK5EJ5ELwIKtUZav/Jt+dXLD
 54MqL1ykGYSa52Nrymk8JyL3BlMhzSoXkgkpG6WIGDoY/XiRACXN89PuFUQkbRoKUN1EPjPfYS6
 uTLkA+IL7cVxj5KTIA1P+5GOgnDmzGt8RHaE4aZbDEctOdWKi8wWP0G3xhXg0yZJeJcdiFFbSPW
 kJ/xwyGvn+m9d+IMiinW879qOvKTYOXRnL4HBV7q6K0Va582sKADyRigwjQQ9nFqIE1FpEA7O5B
 NlxZaDyIYgtk0LyCVt4SniStgUcMVXh8RgTSoFBlt0za
X-Google-Smtp-Source: AGHT+IHO0adHTKDFbdiZLdbwVjzffyYfi7nVPL6wN+0ieHxoGwNOezFQMlR0NxHpJZQhWhI8f44U4w==
X-Received: by 2002:a05:6a21:9786:b0:1f5:8506:5039 with SMTP id
 adf61e73a8af0-1f585065599mr1040552637.28.1741582737079; 
 Sun, 09 Mar 2025 21:58:57 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736d2ae318csm1708308b3a.53.2025.03.09.21.58.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Mar 2025 21:58:56 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, alex.bennee@linaro.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, kvm@vger.kernel.org,
 Peter Xu <peterx@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 David Hildenbrand <david@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 Paul Durrant <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anthony PERARD <anthony@xenproject.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 manos.pitsidianakis@linaro.org, qemu-riscv@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, xen-devel@lists.xenproject.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 06/16] exec/cpu-all.h: we can now remove ld/st macros
Date: Sun,  9 Mar 2025 21:58:32 -0700
Message-Id: <20250310045842.2650784-7-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250310045842.2650784-1-pierrick.bouvier@linaro.org>
References: <20250310045842.2650784-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1031.google.com
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

Functions declared in bswap.h will be used instead.

At this point, we finished to extract memory API from cpu-all.h, and it
can be called from any common or target dependent code.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/exec/cpu-all.h | 25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 1c2e18f492b..625b4c51f3c 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -38,31 +38,6 @@
 #define BSWAP_NEEDED
 #endif
 
-/* Target-endianness CPU memory access functions. These fit into the
- * {ld,st}{type}{sign}{size}{endian}_p naming scheme described in bswap.h.
- */
-#if TARGET_BIG_ENDIAN
-#define lduw_p(p) lduw_be_p(p)
-#define ldsw_p(p) ldsw_be_p(p)
-#define ldl_p(p) ldl_be_p(p)
-#define ldq_p(p) ldq_be_p(p)
-#define stw_p(p, v) stw_be_p(p, v)
-#define stl_p(p, v) stl_be_p(p, v)
-#define stq_p(p, v) stq_be_p(p, v)
-#define ldn_p(p, sz) ldn_be_p(p, sz)
-#define stn_p(p, sz, v) stn_be_p(p, sz, v)
-#else
-#define lduw_p(p) lduw_le_p(p)
-#define ldsw_p(p) ldsw_le_p(p)
-#define ldl_p(p) ldl_le_p(p)
-#define ldq_p(p) ldq_le_p(p)
-#define stw_p(p, v) stw_le_p(p, v)
-#define stl_p(p, v) stl_le_p(p, v)
-#define stq_p(p, v) stq_le_p(p, v)
-#define ldn_p(p, sz) ldn_le_p(p, sz)
-#define stn_p(p, sz, v) stn_le_p(p, sz, v)
-#endif
-
 /* MMU memory access macros */
 
 #if !defined(CONFIG_USER_ONLY)
-- 
2.39.5


