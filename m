Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54C38C369A2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 12:46:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u28LD-00086W-Nn; Tue, 08 Apr 2025 08:46:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1u28LB-00080W-FV; Tue, 08 Apr 2025 08:46:09 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1u28L9-0003t6-9L; Tue, 08 Apr 2025 08:46:08 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-afc857702d1so2864955a12.3; 
 Tue, 08 Apr 2025 05:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744116365; x=1744721165; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=23R5nhDSCWz/LRmWKmRoqcZgwMVFAeaeGqb7O2ARyKQ=;
 b=ns1GmQeSc2+f1sgjlVliApNGw393zWY2gG42Bf2AS8OmcnsN8Oi1NglNYJBPQTq2dH
 kzrsoNrNW7BBJnXiyxPRldIlFoUS0Uhq8rTA1FHg9hEN0ammFFegqgQ9j/clzgxDKrPE
 AuXIZNxMQu7XHeyvx6Kj8zADerFFhcjjwINhRwU0Gv08Vkaew8IRGkh232lkhChOiMMa
 kcxYRUUcb3vqwuaOnF42AMOhKeBdszmZikLxF620bThOG2DGoz/hoD8DMFQPTAOl8fP8
 Rwxo6kwIkuCb/2P/jvZXcLxRXowhw0toF8G6PhPH2btu6orHceRgKDxxXvJHk5Pu8C97
 mS5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744116365; x=1744721165;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=23R5nhDSCWz/LRmWKmRoqcZgwMVFAeaeGqb7O2ARyKQ=;
 b=dGi3ZHDIIXkTmhL2hzwM4l4wJwVqCwZNkMBhVhQwbKZlFnOOaH12pNL4ideyZU7bCo
 xh8OzuyUEWJJJ6nbMHXy68d1eadjuuA6uMmXI3MvZMvUJg4rGsQihlK6JF91nJX3jQpW
 KzqwFSWYD/yQrVy5JqaHjPS4bFot361k9qKMAnJ/reLmVC0ZR7+Y2eS+t9CemD30xvbP
 BUqNd5RT8yB70CSLnj6uyxRl/x9y/rY0ocbWHb04ADz9tfltaoPeioWIhVkLaTogSlby
 1ll5ozzFIpYbFIW/8XPtYf+uhYgP1dXca7ZuTa5t1U0BcA5+O6RP2fps1yIN/qmq0H6r
 YfKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyEZz73vRryL+uiqtofkMiL3ZzSz+l1fG1lkImskAuA8OFHuqt7RnVPzLwixzYXFUV5gpxu1K62W3mKYg=@nongnu.org,
 AJvYcCVk1r3NBDJ1v+PFdqC4NDZG8EL/bLc3UfEr4NgomFHfwp1p0iso7gvz9XYapan03nVS8eu0elwaAw==@nongnu.org
X-Gm-Message-State: AOJu0YzOtYl8gVuWj+f7dviR/oV+PpGhA6eg1CuS9qwMsr//XXiVkERx
 iTBqzYEaD7eZWA24zwvb9OUvZ8Jobol3nMELyv+z76Pc5cs/IQc9jwEF1cgi
X-Gm-Gg: ASbGnctKLF25bL+DFCIeXEiZlZ6Rs1MRZj4socP3hQu2Sx8jSy8RZvt/4DsJiJIG80X
 EGnUv5Scgu1It7KMDK1jp5gU+1vHZ06Tfbp7im5dRQ9fA012S3Oc+f+E1bQv+UHnKNeA0m0UgYg
 Ixf4ZC+m3XNVBkw3YeljUpD1/kI+d7AXQ+O5xi85Ubz60K4xRh+BexpisbIYlOJy+YxMRSCA6su
 2lzK9vAfDzueIs0aBC9WISjxP+wR0sqLqiYeQAlbrkax65TKCtFzuB11pIPVqak8UOsFSmdqV5G
 5X7HxNUf6A7Eh2UBe4IBbAvMdu5ubuxCbmCbKKvOHO2qmGEkMHmuN4fNC21l6WoZML2J9fNAS56
 vUL9jNA==
X-Google-Smtp-Source: AGHT+IE8u/VO190PkBL56scHu2mL3akc3iLUaQK+f+YzHeILK7yoH4nz1uOPp2UgqqDQ63wPsLQ/BA==
X-Received: by 2002:a17:90b:55c5:b0:2ee:c91a:acf7 with SMTP id
 98e67ed59e1d1-306af704d0dmr16036283a91.4.1744116364866; 
 Tue, 08 Apr 2025 05:46:04 -0700 (PDT)
Received: from wheely.local0.net (27-32-255-92.tpgi.com.au. [27.32.255.92])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3057ca1f07fsm11036235a91.6.2025.04.08.05.46.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Apr 2025 05:46:04 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-stable@nongnu.org
Subject: [PULL 2/2] target/ppc: Fix SPRC/SPRD SPRs for P9/10
Date: Tue,  8 Apr 2025 22:45:49 +1000
Message-ID: <20250408124550.40485-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250408124550.40485-1-npiggin@gmail.com>
References: <20250408124550.40485-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Commit 60d30cff847 ("target/ppc: Move SPR indirect registers into
PnvCore") was mismerged and moved the SPRs to power8-only, instead
of power9/10-only.

Fixes: 60d30cff847 ("target/ppc: Move SPR indirect registers into PnvCore")
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Cc: qemu-stable@nongnu.org
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/cpu_init.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 7decc09aec..f81cb680fc 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -5801,6 +5801,18 @@ static void register_power9_book4_sprs(CPUPPCState *env)
                  &spr_read_generic, &spr_write_generic,
                  &spr_read_generic, &spr_write_generic,
                  0x00000000);
+
+    /* SPRC/SPRD exist in earlier CPUs but only tested on POWER9/10 */
+    spr_register_hv(env, SPR_POWER_SPRC, "SPRC",
+                 SPR_NOACCESS, SPR_NOACCESS,
+                 SPR_NOACCESS, SPR_NOACCESS,
+                 &spr_read_generic, &spr_write_sprc,
+                 0x00000000);
+    spr_register_hv(env, SPR_POWER_SPRD, "SPRD",
+                 SPR_NOACCESS, SPR_NOACCESS,
+                 SPR_NOACCESS, SPR_NOACCESS,
+                 &spr_read_sprd, &spr_write_sprd,
+                 0x00000000);
 #endif
 }
 
@@ -5822,17 +5834,6 @@ static void register_power8_book4_sprs(CPUPPCState *env)
                      SPR_NOACCESS, SPR_NOACCESS,
                      &spr_read_generic, &spr_write_generic,
                      KVM_REG_PPC_WORT, 0);
-    /* SPRC/SPRD exist in earlier CPUs but only tested on POWER9/10 */
-    spr_register_hv(env, SPR_POWER_SPRC, "SPRC",
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_write_sprc,
-                 0x00000000);
-    spr_register_hv(env, SPR_POWER_SPRD, "SPRD",
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_sprd, &spr_write_sprd,
-                 0x00000000);
 #endif
 }
 
-- 
2.47.1


