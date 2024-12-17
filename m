Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FAEBE77187
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 22:39:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNgDD-0005OB-7d; Tue, 17 Dec 2024 17:38:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNgDB-0005NH-LS
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 17:38:41 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNgD5-0008QX-Lf
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 17:38:41 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-21634338cfdso70159465ad.2
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 14:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734475114; x=1735079914; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rWJG60kb5t0dGokgOb8XWZnNeuJ8T72pjzJRQxGzMOY=;
 b=krBFBrwG8AjIFDCCGxgjcFxTSWeuVKxXuGf90gPjzUgcOgbTdfjO/ZP1LdixetY4NH
 Eovy6VHCjOJh1nN5dQKdcrc6cwhUhWZKhLIY3JXuk7XR0Makn/RDHgglvN6+Vy2o+/72
 7OH6WJ6pUf0NuFyXEfLaFA1B9KdQZ+4aO7C+ebDveTlwOlldHR2zow72Dv+YyIF70CMq
 yoOLlMGV16RdGYIcB0sBfIjCwLVhiw/bY1tvaiamodtYInSExD8Xoc3/LAlReCHpKnqu
 fj7rt4lDGjaJ36CrQI21ScnC+1NFOpAF22kHrwjRusJNhRsnDB4gK+jVM1w0H2tfYIku
 4coA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734475114; x=1735079914;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rWJG60kb5t0dGokgOb8XWZnNeuJ8T72pjzJRQxGzMOY=;
 b=nB7nqYbFNjeklc9CcPHhQsvXRSGg3yFp99r8lAml14Sx2PoJKUp4YW/mKPk5Idw11Y
 lcokXUrx75XuZ9WKhdV2F8NhA4UFR4MEL09YUiVhQ2Dl10SLzzwOM2ulI/NAMlCjRIu7
 77reiq6aaI7rf6XXFAX5D4OQGAMqE26OWfySWYCvjoBocZBryfC/lUlmfAoPb9Btt/XZ
 qtQLq86uZOLOp86hyjnH+fTa1BEvnKhIW/BHQtTZ2+x93sx5iK7JrBDL2Zap+izFMil+
 X1sjbU/9H06Ass13rHErapjVqUdE4ayEySFWb+Iog3W1I+Xd/FnKP1rvdJ8guwm0n5z7
 6xRw==
X-Gm-Message-State: AOJu0Yyy8WROtrLYXlJALKUUPzRPBoIiorbengrj5QnLysX43Ldr6Aiz
 ZCw0ZlToMvLVSaJxgSBX31ZhEa6V/bi6XRvK6NGI9+c8yyLsMDqe42b/E5XgrPB2SxLbKi8sA1z
 dSWI=
X-Gm-Gg: ASbGncuTA0ZFU9ncF+BekSEdXpGTPMEuDpyGDSb6QI4QbfIObWJKC+seUc3QolktvcE
 rq9pq87GLNUsjOoZEhwLxwTu4MCr8sKQWVEf0PQvyfxs3oZBr+mzZbzH7tCGyc/8+RKTK6DlB++
 FVAzNwXkGMWy5xNert8FjN/dymM0PN2371d8KY0Df4aMc5DFjOTVWD3Jkk7OZE9jznOOk+Hzfde
 EFE2sW0x1GvMDIvD1h6Bxl06+YGJmbXSqkNx89X2gFteDkPpiZFxAbR
X-Google-Smtp-Source: AGHT+IFW9OfcVaQ+pK+/NP1dwwE+JyONDVdNHdvTwlkybJh7fSvxehIWYDaLZi0P1c7ZJMqtiEneyg==
X-Received: by 2002:a17:903:944:b0:217:803a:e47a with SMTP id
 d9443c01a7336-218d6fcd456mr10047585ad.4.1734475114139; 
 Tue, 17 Dec 2024 14:38:34 -0800 (PST)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-218a1dccb03sm64869465ad.98.2024.12.17.14.38.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2024 14:38:33 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, philmd@linaro.org,
 Mahmoud Mandour <ma.mandourr@gmail.com>, richard.henderson@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH v2 04/11] tests/tcg/plugins/mem: fix 32-bit build
Date: Tue, 17 Dec 2024 14:38:18 -0800
Message-Id: <20241217223825.2895749-5-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241217223825.2895749-1-pierrick.bouvier@linaro.org>
References: <20241217223825.2895749-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x632.google.com
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


