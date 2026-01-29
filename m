Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C42B4D73E86
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 17:38:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlVyJ-0004LU-JV; Thu, 29 Jan 2026 12:38:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vlVyH-0004JW-Hd
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 12:38:21 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vlVyF-0000d9-Qw
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 12:38:21 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-8220bd582ddso698785b3a.2
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 09:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769708298; x=1770313098; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HD+mMe7KagiiFksQ7+VkRlV2MOxBw/OquAe1Do4OCiQ=;
 b=Rgq1wnw7Cb4JC2fveo2ZERtwle9M1ZzzGGMaM+yDfR6L0Kn2kWLzuJMX5UrY/IbiXo
 EI7t7Fs06QIvBk3TI+jmH3OyDfPyODqg/oD6FbFBxXBB9JHTnbI7zDtbnuDjJ0FqM+Av
 66LvjC0OB8f92NVI0UCfTu8GBrARToQBcA20umM7y6fxARD+MsvNHXqn7Vqzv7xSPRH8
 zssi32/+Gibvf2eW6mKuIgdIr3CGJR0Z07mcPkW6VBp0iWp7l5p0HvSN/Az2BBCgY2Yj
 f+/HyqjXQYEb+j0yVeS4UaqWbxRFvBfe/Z2y29nhDnDiuOvA7MCy0IEm3FhYubGXNUF3
 y8Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769708298; x=1770313098;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HD+mMe7KagiiFksQ7+VkRlV2MOxBw/OquAe1Do4OCiQ=;
 b=Xz1K+B+gohmAnvYWdcbl9M+LaoyDa+6WC8C5VBZgT1S16UgdPv2y7DFT4UBezzbnUg
 0EruP+k1T9prru0Qjg+ITZfxvbUfmTkVf+CSPhkixcxnnl8CRvHMKTvSJm0dJDepjPM6
 GbHmhFD6N+MZiE76yJghxpN3qSPLb7l/CcPBEAlEDByD5tg0wp1CAZZKLs+JZjhSoCei
 5zIaqTcqkA2lJHgoQqf5kTIROcCkzB2qqJK4maspuqSAIsy3FURyKU35D2VHxB6yiSW9
 FTUGmRFtVWRU0jeVfbml9+1AfpmwhfeaWitvoJi8ZQ/ZbiDYP/7ARt8VybjXWGawb5Q+
 InBg==
X-Gm-Message-State: AOJu0YzKvu2QMGkhzFM8gPWW12SkFr/ZAHwpJDzfiyE8eDobU5csrE+b
 /sVuA6lRW6J7jgtOWFZmD3yh/iL7taERU/dF8L1vfWcnDRUlyYZHE9aUc5GpZDU0SLXrk/pnj9o
 uh1LR
X-Gm-Gg: AZuq6aJLE2N25s2Pw1hk7hf7LLxvuzdZG2HIr9oHxIGpo9eVOENx6Uql1HAru2mLJtu
 eNF8t2y5aNVEqmB5aOUvfhmUjv2IBdQu2YJpHktMB99GJNHWs09h/tTgjWQ6PbwRPohmJOzjmH8
 nDa5Dr+ga0lTjb62AwcWMHpD4CJIWr9e69moHjzpJ4J1S+f9w2Yha7AUzlES7rFp2SyxwGjtW8F
 A9ADAUIkAqNoav1HmgbInHThb+Gvyv1BKpiK0E+3EyCjfZRGqtaSaKLNrPt81ZHeM0aP/MfR58k
 DeikHfBWURopbHtdG4meYF86IGqcgCGnV6sx/s7+yYhoFneNnG6TwSwY5wwECM6/Ixi2XpQAO5n
 ljyAoU7W+R4TQcqmeadTJ+Kbg88ivxZcgxZBzINE9KJYOvKEGVPZddP6m5iu1hpG2oH+aPYrljo
 c7h7nR3hT6Frzv9MRlxBpQH9kgMBIErxL4OQUDaP/v1p5poiysSUsebq5qYgm0qy8i
X-Received: by 2002:a05:6a21:3395:b0:35f:6e12:186f with SMTP id
 adf61e73a8af0-38ec62de51bmr9492455637.23.1769708298128; 
 Thu, 29 Jan 2026 09:38:18 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82379b222f1sm6706246b3a.7.2026.01.29.09.38.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 09:38:17 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alex Bradbury <asb@igalia.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 01/21] contrib/plugins/hotblocks: Correctly free sorted counts
 list
Date: Thu, 29 Jan 2026 09:37:47 -0800
Message-ID: <20260129173811.138036-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260129173811.138036-1-pierrick.bouvier@linaro.org>
References: <20260129173811.138036-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x429.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Alex Bradbury <asb@igalia.com>

g_list_free should be passed the head of the list.

Signed-off-by: Alex Bradbury <asb@igalia.com>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Link: https://lore.kernel.org/qemu-devel/cf5a00136738b981a12270b76572e8d502daf208.1753857212.git.asb@igalia.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 contrib/plugins/hotblocks.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/contrib/plugins/hotblocks.c b/contrib/plugins/hotblocks.c
index 98404b68852..d3dd23ed9fa 100644
--- a/contrib/plugins/hotblocks.c
+++ b/contrib/plugins/hotblocks.c
@@ -73,15 +73,16 @@ static void exec_count_free(gpointer key, gpointer value, gpointer user_data)
 static void plugin_exit(qemu_plugin_id_t id, void *p)
 {
     g_autoptr(GString) report = g_string_new("collected ");
-    GList *counts, *it;
+    GList *counts, *sorted_counts, *it;
     int i;
 
     g_string_append_printf(report, "%d entries in the hash table\n",
                            g_hash_table_size(hotblocks));
     counts = g_hash_table_get_values(hotblocks);
-    it = g_list_sort_with_data(counts, cmp_exec_count, NULL);
+    sorted_counts = g_list_sort_with_data(counts, cmp_exec_count, NULL);
 
-    if (it) {
+    if (sorted_counts) {
+        it = sorted_counts;
         g_string_append_printf(report, "pc, tcount, icount, ecount\n");
 
         for (i = 0; i < limit && it->next; i++, it = it->next) {
@@ -94,7 +95,7 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
                     qemu_plugin_scoreboard_u64(rec->exec_count)));
         }
 
-        g_list_free(it);
+        g_list_free(sorted_counts);
     }
 
     qemu_plugin_outs(report->str);
-- 
2.47.3


