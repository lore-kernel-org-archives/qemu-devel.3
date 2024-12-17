Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6171E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 22:43:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNgHg-0004Jg-6o; Tue, 17 Dec 2024 17:43:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNgHe-0004J6-7B
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 17:43:18 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNgHc-00019D-MI
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 17:43:17 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-728eccf836bso5151642b3a.1
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 14:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734475394; x=1735080194; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+FHNfG1b8pwrU+SQi579sB8c86h/0xjzKBe/XqZ77yg=;
 b=OOtjmH7k9KPnzozY+LEnKimkvSMRBcc/6kSe+a2I5xfUk1b1OPKROBUs1a2dI/hzf2
 X/IRN1jjmfLY5Z5KUgXQFd5tEi7wUaIJ1gZPLh5M1JyNoglhEtF4J8A291/dIFcC1j84
 h1zVIT8eQ1tgFx3Xxy2+tsRmjMGcrgYYscsT27MYFa3f2NnfZn2Un1oRmslIJvPLmoc4
 49O4/fVifzV2mkCDaXacwkuVy4KS0b40HPFQVNv9Q3BO8AoOcqJxef5HVvIAz0u21nJV
 UtGcVKkjT0Dlk1nKZz3cODpufsxsw3ZGU7yV+knyNYIZY5Z9jIOZy8NWjcS95teM9MiB
 jTRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734475394; x=1735080194;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+FHNfG1b8pwrU+SQi579sB8c86h/0xjzKBe/XqZ77yg=;
 b=OoargjfdgRxVXrmvA7HNUkrGxc6SPmQJXQaZyeBE7aSD6sfsM/WL25SvSThUVJ4jRr
 NYURr8TbnBDb9wvHyBCf88iIE/+sz+WIn3tzSLqptCUSv+wRdlYMv2PeCkS8SghWI4fH
 SiYSkhtAPkt+kIJZbSDnHLFDR7AxWYedoHwgEIHxz3bRJuWew8enAH1tYaxFXxmPD5JM
 TqsIXDQYNP00AITJcyAs+oE9qjfGAgI5N3/KMOlKyhubyNBbdU05MWgHtLGbU+WUR0lN
 hYD7IqET599QU+4OKurz6weSZQvZqOYFeqNA0ty+obMfK+jVcBnlj9QwaDQRUmRGO7NB
 9E4g==
X-Gm-Message-State: AOJu0YwQobHZxvd6vR2rlcgKOmhb/xhorO8FV9/HSZ25ep+YO6AovRUk
 8R4N6MOG5trAiUqFy29NHV6JQjJ897ZHj5ANONr5aOV86oEcBedAcM7G43YM6nt2jY1jeeqdsg/
 xZcs=
X-Gm-Gg: ASbGncvLDiFt5dooZsf/4ebGrZPJGYt1rf+b2Yn+h98inoi2VnBXpMZWx60zu66FMcA
 r65U/8a4chhnKGO+2cD7Xo/E0BHCPjNul/iTjzikWVS2gpy8nrppt+zaixf9j7ISTeHCSEtekl+
 rldQqyTl3zCjAgcTiknAJbofVF7VEBfkvCc7LWziXPALzMzOx2b6CpfNdXLFSTX1e4xkZFLETKT
 4nym08ogkLhFgps7W5CdPUl5pr4V7VhsjMza168+7/3oJne562dFKyQ
X-Google-Smtp-Source: AGHT+IH97l2I3+bwXh9iofiP6Dm9PCAsdAuMxWdBjebNHx/+Mt7NL1gNlIqfA1AKWyN/Y4sQL+5FqQ==
X-Received: by 2002:a05:6a21:9990:b0:1e1:becc:1c81 with SMTP id
 adf61e73a8af0-1e5b487dfa4mr890237637.32.1734475394339; 
 Tue, 17 Dec 2024 14:43:14 -0800 (PST)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72918ac53f3sm7463214b3a.27.2024.12.17.14.43.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2024 14:43:13 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, philmd@linaro.org,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 04/11] tests/tcg/plugins/mem: fix 32-bit build
Date: Tue, 17 Dec 2024 14:42:59 -0800
Message-Id: <20241217224306.2900490-5-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241217224306.2900490-1-pierrick.bouvier@linaro.org>
References: <20241217224306.2900490-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x435.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


