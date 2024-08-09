Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72747C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2024 18:10:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scU3B-0002eQ-2z; Fri, 09 Aug 2024 14:09:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1scU38-0002cI-1l
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 14:09:14 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1scU35-0007Ew-JF
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 14:09:13 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-369c609d0c7so1775434f8f.3
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2024 11:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723226950; x=1723831750; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jquWz0USW85lcynOd+V15nNwRrJbu/joQPKxFZlMmk0=;
 b=WQIwxzahEbk5TtQe53/t2dj3VLdxR0tAvSKmHpGENWXu6Zi9vzuJUK19TWaPoHofm+
 +rMzQXccEV8GbxabRLcXLT25R1Tk+BDbtDnU4ivxpMIE3SsRlxasWaDRQy1T7cVsmVdv
 2TzRIawn5y5/vejNvaiT5d7FZ0Pesw0FyFs8LzcD+pyRflXWITXmKQJaXI8I4AAxdi/W
 4FnKXy9K/nAGMx9NKhuintoOTaMxA4SEuns51eHJe+Akr7CR4vzBnvRr6G2311N13Zxu
 RXbKi7Z3I2n/JjEmbdxMJHy2oZEz5Omyq+5tAGjkbZ0nLaGCmwtsPyRKVvpgm2HGQXfj
 CE7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723226950; x=1723831750;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jquWz0USW85lcynOd+V15nNwRrJbu/joQPKxFZlMmk0=;
 b=kzvhkgAR1IErBFTopVqPTV9t9QtfwCULxok4FvxayofYPHJr6rMVFgkOvlSd26cEeq
 Wf0+QXecC4QueAY49ZGP3QKNmkEockEs6HN1j1oYDBy6BC5wAR2jP1taEffCdDXTa+eh
 EJtUbAEy3lrB3y4wGhP2jkA9zHBrZgDv0TjS3Z1gh+atF9FLHDc5brJ5SMrsMh/bwUOS
 o1ilQCFYebGhIgs4rWW7ciNHbattY5knUGKwmOA5xyegRtb1o8UrZ3VcGj0Kdz2ve0Gi
 +6fHCwz/v+m/cZhls3LgUS3lVlHtDC9bhIt+qWgD8VaeosSHKehd/8neCd/c//7CNx1A
 stXQ==
X-Gm-Message-State: AOJu0YxgGtibGNK3ZXi1V585RjaQJpoGifxEXES0AepsBYHoDGe02GtA
 G+hQLPERZEBs+UKQuYuUrMOnDWYUzL/cYzBCsU6UzM/ZJU1JMVTOxaq4mIozDgHuSkihqumyl/d
 i
X-Google-Smtp-Source: AGHT+IGks1AxJW21O1k59IG+rqXlynqIv6KrJ6vyWJ8pe9XmbJAb+S6snsja4Mv6z4jYtXp6f0M3GQ==
X-Received: by 2002:adf:ee50:0:b0:368:6596:edba with SMTP id
 ffacd0b85a97d-36d5fd7e9b0mr1986551f8f.39.1723226949954; 
 Fri, 09 Aug 2024 11:09:09 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36e4c937b6esm132262f8f.32.2024.08.09.11.09.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Aug 2024 11:09:00 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/11] hw/core/ptimer: fix timer zero period condition for freq
 > 1GHz
Date: Fri,  9 Aug 2024 19:08:34 +0100
Message-Id: <20240809180835.1243269-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240809180835.1243269-1-peter.maydell@linaro.org>
References: <20240809180835.1243269-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
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

From: Jianzhou Yue <JianZhou.Yue@verisilicon.com>

The real period is zero when both period and period_frac are zero.
Check the method ptimer_set_freq, if freq is larger than 1000 MHz,
the period is zero, but the period_frac is not, in this case, the
ptimer will work but the current code incorrectly recognizes that
the ptimer is disabled.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2306
Signed-off-by: JianZhou Yue <JianZhou.Yue@verisilicon.com>
Message-id: 3DA024AEA8B57545AF1B3CAA37077D0FB75E82C8@SHASXM03.verisilicon.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/core/ptimer.c         |  4 ++--
 tests/unit/ptimer-test.c | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/hw/core/ptimer.c b/hw/core/ptimer.c
index b1517592c6b..1d8964d8044 100644
--- a/hw/core/ptimer.c
+++ b/hw/core/ptimer.c
@@ -83,7 +83,7 @@ static void ptimer_reload(ptimer_state *s, int delta_adjust)
         delta = s->delta = s->limit;
     }
 
-    if (s->period == 0) {
+    if (s->period == 0 && s->period_frac == 0) {
         if (!qtest_enabled()) {
             fprintf(stderr, "Timer with period zero, disabling\n");
         }
@@ -309,7 +309,7 @@ void ptimer_run(ptimer_state *s, int oneshot)
 
     assert(s->in_transaction);
 
-    if (was_disabled && s->period == 0) {
+    if (was_disabled && s->period == 0 && s->period_frac == 0) {
         if (!qtest_enabled()) {
             fprintf(stderr, "Timer with period zero, disabling\n");
         }
diff --git a/tests/unit/ptimer-test.c b/tests/unit/ptimer-test.c
index 04b5f4e3d03..08240594bbd 100644
--- a/tests/unit/ptimer-test.c
+++ b/tests/unit/ptimer-test.c
@@ -763,6 +763,33 @@ static void check_oneshot_with_load_0(gconstpointer arg)
     ptimer_free(ptimer);
 }
 
+static void check_freq_more_than_1000M(gconstpointer arg)
+{
+    const uint8_t *policy = arg;
+    ptimer_state *ptimer = ptimer_init(ptimer_trigger, NULL, *policy);
+    bool no_round_down = (*policy & PTIMER_POLICY_NO_COUNTER_ROUND_DOWN);
+
+    triggered = false;
+
+    ptimer_transaction_begin(ptimer);
+    ptimer_set_freq(ptimer, 2000000000);
+    ptimer_set_limit(ptimer, 8, 1);
+    ptimer_run(ptimer, 1);
+    ptimer_transaction_commit(ptimer);
+
+    qemu_clock_step(3);
+
+    g_assert_cmpuint(ptimer_get_count(ptimer), ==, no_round_down ? 3 : 2);
+    g_assert_false(triggered);
+
+    qemu_clock_step(1);
+
+    g_assert_cmpuint(ptimer_get_count(ptimer), ==, 0);
+    g_assert_true(triggered);
+
+    ptimer_free(ptimer);
+}
+
 static void add_ptimer_tests(uint8_t policy)
 {
     char policy_name[256] = "";
@@ -857,6 +884,12 @@ static void add_ptimer_tests(uint8_t policy)
                               policy_name),
         g_memdup2(&policy, 1), check_oneshot_with_load_0, g_free);
     g_free(tmp);
+
+    g_test_add_data_func_full(
+        tmp = g_strdup_printf("/ptimer/freq_more_than_1000M policy=%s",
+                              policy_name),
+        g_memdup2(&policy, 1), check_freq_more_than_1000M, g_free);
+    g_free(tmp);
 }
 
 static void add_all_ptimer_policies_comb_tests(void)
-- 
2.34.1


