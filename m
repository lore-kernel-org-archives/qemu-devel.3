Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7484BE77183
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 01:10:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNM3d-0008HS-26; Mon, 16 Dec 2024 20:07:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNM3a-0008GN-DU
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 20:07:26 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNM3Y-0004xl-Kr
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 20:07:26 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-725dac69699so4067806b3a.0
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2024 17:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734397643; x=1735002443; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rWJG60kb5t0dGokgOb8XWZnNeuJ8T72pjzJRQxGzMOY=;
 b=ov7M7CZyYKFL0gapxnc5L5aNQSdL0ef6DbTVMP0ieyB0NvXj+5jP3hByKEhLspfMUm
 iFKZLR8ncm4GVkanaY9j9HvuRr1ku5k1dKNg1tGuLupHBvdcZlaIYgNE5E4RF0rpNd0f
 9F5Guih375Or2+D/YusU0xHQ7WZpTyN4VOR2kyw/C7R+VkwbBYWcxu+2n0ddxEibMyHE
 CLoxVFDLU1ARJ4kRgiV8k+YfpTljQS7uNwqaHXEEr/iTMlmcInca0O5hHZuHB3eZoIyt
 HISmPT7mkBABhr0yPIiRaOXmJeihWkEGDEuszfiuH/iusqSxPJLY51A9FRQ16PKsnEw8
 wEmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734397643; x=1735002443;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rWJG60kb5t0dGokgOb8XWZnNeuJ8T72pjzJRQxGzMOY=;
 b=Tf4k3RZgakgLsUAOz6RLaPTiNr6PsgW4TopFQmQsdEjxBysfrDKJNfDQ1i1mK7aCNm
 496iT3dWtZFVHRM/mrXpwaaIlS0/WI9+iPLhPJ5PbdDhBl9jjAkeOliVmbXIJoygYXlT
 KNl95iSwqhl0F6Y4VSrjr1dpjaaDPZ6YCnMfM2MJ2+Zl673kAzZj7/KZbvvBfuMrWksx
 j/tIsTtnCWPAt/lCrgJ6rhVRwCV5Pgq9YxjhqQX042tiBUcpof4mfoOX73lbKOGF/zfR
 QCjorKBloJ9ZVxfKWFXZBM/wx+inln3YndXEVlmD8p0MjJxwOX8GROqBNcH0lAf0qm6X
 rR0A==
X-Gm-Message-State: AOJu0Yzhujipc7eOhlfnLqL+qd8rVXuqEo+fmF17hAd+e8rsTt7Vu+d4
 7jlE+aC9qgOzGxlEy1O1g3oxWhfQtC58kIQttUUnaTg48mvYGK+6NBaC/B+VZEBVmMvPS5+6ajh
 rX68=
X-Gm-Gg: ASbGnctwXDr7imxV3wVoO1jm2mKY28nuXi4FfJmjhthG+UpjYY5gBk+EmoPkhqrmlYG
 ChPZP6oPYN8X0/zE41A/xLjmfeLebQow+I37LeuijTfZAVX0nX7VuoZ3nzeru5xaITFm/1CPAwc
 ZHzV2zggyzYkHyNeHxLFi0xz1hzKTy5Bz5/l7L3AX3qzOXaZeDNF8As8erDUTEV1PdtyJkUVKNG
 BZigkimFGWaJB0lV23sb3p317p7/loV0QUaQlkiGYDsbuF7bWKqzSCgYO+oEpneMTsHnnjEMO6q
 Nb83ZSeHxEmNKq4=
X-Google-Smtp-Source: AGHT+IGYf8j5msSPX1tFY6KU3LLekPysJggvqAiLsB6lAH+kGWhL9AKnsItKuzVuLtBne7M5Yn5dlw==
X-Received: by 2002:a17:90b:3d12:b0:2ee:ed1c:e451 with SMTP id
 98e67ed59e1d1-2f28fb67922mr23471763a91.15.1734397643406; 
 Mon, 16 Dec 2024 17:07:23 -0800 (PST)
Received: from pc.. (216-180-64-156.dyn.novuscom.net. [216.180.64.156])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-218a1e6d0e4sm48746595ad.261.2024.12.16.17.07.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2024 17:07:23 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Thomas Huth <thuth@redhat.com>,
 philmd@linaro.org
Subject: [PATCH 06/13] tests/tcg/plugins/mem: fix 32-bit build
Date: Mon, 16 Dec 2024 17:07:00 -0800
Message-Id: <20241217010707.2557258-7-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241217010707.2557258-1-pierrick.bouvier@linaro.org>
References: <20241217010707.2557258-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x436.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 tests/tcg/plugins/mem.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/tcg/plugins/mem.c b/tests/tcg/plugins/mem.c
index b0fa8a9f277..d87d6628e09 100644
--- a/tests/tcg/plugins/mem.c
+++ b/tests/tcg/plugins/mem.c
@@ -135,14 +135,14 @@ static void update_region_info(uint64_t region, uint64_t offset,
     g_assert(offset + size <= region_size);
 
     g_mutex_lock(&lock);
-    ri = (RegionInfo *) g_hash_table_lookup(regions, GUINT_TO_POINTER(region));
+    ri = (RegionInfo *) g_hash_table_lookup(regions, &region);
 
     if (!ri) {
         ri = g_new0(RegionInfo, 1);
         ri->region_address = region;
         ri->data = g_malloc0(region_size);
         ri->seen_all = true;
-        g_hash_table_insert(regions, GUINT_TO_POINTER(region), (gpointer) ri);
+        g_hash_table_insert(regions, &ri->region_address, ri);
     }
 
     if (is_store) {
@@ -392,7 +392,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
 
     if (do_region_summary) {
         region_mask = (region_size - 1);
-        regions = g_hash_table_new(NULL, g_direct_equal);
+        regions = g_hash_table_new(g_int64_hash, g_int64_equal);
     }
 
     counts = qemu_plugin_scoreboard_new(sizeof(CPUCount));
-- 
2.39.5


