Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ABA8C531CB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 12:38:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmsh5-0008MA-Bn; Thu, 23 Jul 2026 08:38:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wmsgT-00089p-KB
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 08:37:55 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wmsgQ-0008Tg-Vy
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 08:37:53 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-c15f020a223so80500966b.1
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 05:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1784810269; x=1785415069; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8EXT8nLB5sfw36l6ilVcT7uL0HuaGwTIPe2pmtwCIcw=;
 b=M2mihD09iZs9UAFk7sPdJvZ58bRZ6Yiexfdg3Tdr2PwLq4tejsSs9l9r6Uw7ClxZm2
 iRow1TCAdpkJ0vy9ZrxvdAK8f3S5XxXkwLDwHH0b2sYf+qYTepHDS71zlesuN9hnXPlH
 jeuFKJm50XC5ENSurIbDExR4sSvKnyAGWw9iCFXnICxpiU2uwg9CrMdKGWEWt6Nnqymj
 6pVznZw9Av383MEANKRq4bKNwUVPj87X09H5y98yJUIqiWFjSqZwsrOu167T8YlJg3R0
 J94TleZp1KRrpPK7hzbXxci/A5F15FmwLTAxaTYuIVDcTcYw7zoSxLrlxzwccgMxj8eb
 dsAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784810269; x=1785415069;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=8EXT8nLB5sfw36l6ilVcT7uL0HuaGwTIPe2pmtwCIcw=;
 b=qrt6DULU/kqqQHJJl9HX2Uj0AGHJYq+/dHXeZvWQXjsuBC60znpiLKMT9oE4FyXe8D
 ONnhbOJJM/M9qJrS+WAmq8L3hS+ylss9ZsRtGlAcO30UhA+Y0f5tHK1dU2KFAMaFyIh/
 XixKnVXeh05RYC1mVJWFpC22Ic6jkphdI1TiJzWXqFQje9vapccP3HK6LqDRtkWXmkL3
 2PTxcodb5MYBprL94mewcKkmUxyt7hMo6kGb+QdJScootsOIms6A0K7QeQnFE08oPClw
 QjaDWnmLFc8VmA7wIhtiK7DdzO/RHLP2exVhly/1gEGfA443Eb2zkNLPxeNehq1AKR67
 TZWA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoeMbQTHWso7Iq90s9UP9HB6EXy5zVxJ0coNg/1Ixzl1jsjZwMuC4B7qjs1rEO+k8kBdb4gr03JJueP@nongnu.org
X-Gm-Message-State: AOJu0YxiwUkM8Qojrs6qjrBsEI2Ul1d/IutiEv/Y0FzWHft8Ss9wyrJ7
 AbAFJakXp+/R5JxI8iqZkBruEeb+FyLyOzV0DKKD3tLuyW+/JAuqtkIjIxJqoII97HQ=
X-Gm-Gg: AR+sD12urX3RCrVG2qX1vrdAWuWGms94uEMZmTCseMaNoucu9qppKIwb9955Xn9Fhaz
 vwPH7awMyh2WbCvryUgpVGKlgVqPe5WVIzFLorciNpEHoypwQgk2KBETlxYpi6OyEV3fqid0L3O
 EhT1x36o3Yw9WzdD2t6Mc9auepao1B/c/4QNDAGxTDu+NjwoAjvXGXuxvPmzL/BEO/R7+l0m6Lr
 E55KZ/SigVHzoq6p/uiPLkUPmflNKcFNwLdN/ZXV6jm9DjUCpfdYanPyB1AzO1/G9HfR8xRH3jq
 iZExvyqb8bbYqX19qocxEqsHRxICtWM66OZtANOcHYXpnKouVrUkSc+g69Dm77ewh0Rf+5Jl5OJ
 JT5MUJiT2iPJ3dRHkovCvwSXpmpcJAH9ROdbrmkdUr3GWrYRxdwGotHVS6mbU/2HYfIuo1SycK1
 U=
X-Received: by 2002:a17:907:1b1c:b0:c16:84dc:9607 with SMTP id
 a640c23a62f3a-c1c50b919a8mr121926966b.19.1784810269367; 
 Thu, 23 Jul 2026 05:37:49 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:b8fe:da40:80d9:ac01])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1c32c90b58sm222619166b.39.2026.07.23.05.37.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 05:37:49 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: den@openvz.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH 1/3] block/accounting: take stats->lock in latency histogram
 setters
Date: Thu, 23 Jul 2026 14:37:43 +0200
Message-ID: <20260723123745.3294227-2-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723123745.3294227-1-den@openvz.org>
References: <20260723123745.3294227-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=den@openvz.org; helo=mail-ej1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

block_latency_histogram_set() and block_latency_histograms_clear()
replace BlockLatencyHistogram's nbins/boundaries/bins without taking
stats->lock, while block_account_one_io() reads those same fields
under that lock from whatever iothread completes the I/O. The result
is usual use-after-free and qemu crash.

Take stats->lock in both setters, matching the lock already held by
the reader.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Kevin Wolf <kwolf@redhat.com>
CC: Hanna Reitz <hreitz@redhat.com>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 block/accounting.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/block/accounting.c b/block/accounting.c
index f00fe99740..c277b796eb 100644
--- a/block/accounting.c
+++ b/block/accounting.c
@@ -194,17 +194,19 @@ int block_latency_histogram_set(BlockAcctStats *stats, enum BlockAcctType type,
         return -EINVAL;
     }
 
-    hist->nbins = new_nbins;
-    g_free(hist->boundaries);
-    hist->boundaries = g_new(uint64_t, hist->nbins - 1);
-    for (entry = boundaries, ptr = hist->boundaries; entry;
-         entry = entry->next, ptr++)
-    {
-        *ptr = entry->value;
-    }
+    WITH_QEMU_LOCK_GUARD(&stats->lock) {
+        hist->nbins = new_nbins;
+        g_free(hist->boundaries);
+        hist->boundaries = g_new(uint64_t, hist->nbins - 1);
+        for (entry = boundaries, ptr = hist->boundaries; entry;
+             entry = entry->next, ptr++)
+        {
+            *ptr = entry->value;
+        }
 
-    g_free(hist->bins);
-    hist->bins = g_new0(uint64_t, hist->nbins);
+        g_free(hist->bins);
+        hist->bins = g_new0(uint64_t, hist->nbins);
+    }
 
     return 0;
 }
@@ -213,11 +215,13 @@ void block_latency_histograms_clear(BlockAcctStats *stats)
 {
     int i;
 
-    for (i = 0; i < BLOCK_MAX_IOTYPE; i++) {
-        BlockLatencyHistogram *hist = &stats->latency_histogram[i];
-        g_free(hist->bins);
-        g_free(hist->boundaries);
-        memset(hist, 0, sizeof(*hist));
+    WITH_QEMU_LOCK_GUARD(&stats->lock) {
+        for (i = 0; i < BLOCK_MAX_IOTYPE; i++) {
+            BlockLatencyHistogram *hist = &stats->latency_histogram[i];
+            g_free(hist->bins);
+            g_free(hist->boundaries);
+            memset(hist, 0, sizeof(*hist));
+        }
     }
 }
 
-- 
2.53.0


