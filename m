Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B210C531DF
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 14:51:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgQAs-0005UM-7I; Tue, 20 Aug 2024 10:49:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sgQAk-000553-VT
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 10:49:23 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sgQAj-0006Lc-46
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 10:49:22 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-371941bbfb0so2783703f8f.0
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2024 07:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724165358; x=1724770158; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pRUkeG+dSEsxsUWMQJ/bL4Qbn7uE72qA/+aTs8IItt4=;
 b=l4eOzk4fA5N9FXk87e5lLrOC6Xg/EkVbznrmQwXfy2v/Lxc3icgIwv7njzYyA8cRHg
 naqbHrxEwupOdNNSB8ZZpH4bcfZiT28Lj49FCSYP6WND0DDFbHs2IwS2kuJLeJRk3wXr
 T2oTcBLl9mOuntiFrOSs66kipIBs3k9KDOpFLotXvLRIgxUQEDNz20YTsZnMsbdwm/sV
 KKC9CjG0iJ/kqZgzbzEP8jyF3iv4QZLQiKg+p2Au++1BUNxLU969kfGuE6LqbhqaJLNI
 UCgSWJ4lP7xZGZwSXiS29gyZqZYk0rynU1CguFL0DIatZl22X7yDHItk1MDzV/ncFA36
 lqBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724165358; x=1724770158;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pRUkeG+dSEsxsUWMQJ/bL4Qbn7uE72qA/+aTs8IItt4=;
 b=b2JfPOYw0OqVN2sVmruiwMEGswr+N+H77L/e8gPygHIaaeER7YN+eqDkYpxEhALYhy
 3EoxxtT2U6eHINMjQFwUXZwr6eH6qJ51sda3lCXHjmnyL1QvI+0mvdUyVJAadNfKa0zX
 sfcZxG6Jvls3IYhZotxDchkqqnWF6BdhOoQ/Ajjbba/pmZEaOP0R7JFBDtLkZ6v7ydLo
 DppsZxNIW5iBDmmdYkipfM9kfgCuxLpEPh9YpW+z+8OiPvr0Ld7b/9tmGSRNjFo/Khx+
 o4THYaBeeud1ZvvGA0DZ+0LymrNTA9hAoZ3v8hsGOIA5VZk2RQTQNbiFOKz/xY3Vimky
 Ed4A==
X-Gm-Message-State: AOJu0YxQJiYDBI/7GCuSppTmeQK5d6RJoRh3ztYpWfRuLNqhB2x7Z9CR
 xu3gBd6VDNvFFIHrziKDNMs20xiUo1UUi2pBjSMluwe18xi3AMgFboq1rL/SR5xuvdlPDH/reAq
 U
X-Google-Smtp-Source: AGHT+IE4XMLxhzJTWOaaHFsxJVepWxxpgZR4vXNbBBzKiTwXY94axfydZ1y1ku+8TkOHbsRe+/9z1A==
X-Received: by 2002:a5d:408f:0:b0:371:83a8:afee with SMTP id
 ffacd0b85a97d-3719443d30emr9731301f8f.27.1724165358266; 
 Tue, 20 Aug 2024 07:49:18 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3718983a306sm13334672f8f.15.2024.08.20.07.49.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Aug 2024 07:49:18 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH for-9.2 8/9] tests/qtest/migration-test: Don't strdup in
 get_dirty_rate()
Date: Tue, 20 Aug 2024 15:49:11 +0100
Message-Id: <20240820144912.320744-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240820144912.320744-1-peter.maydell@linaro.org>
References: <20240820144912.320744-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

We g_strdup() the "status" string we get out of the qdict in
get_dirty_rate(), but we never free it.  Since we only use this
string while the dictionary is still valid, we don't need to strdup
at all; drop the unnecessary call to avoid this leak:

Direct leak of 18 byte(s) in 2 object(s) allocated from:
    #0 0x564b3e01913e in malloc (/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/asan/tests/qtest/migration-test+0x22f13e) (BuildId: d6403a811332fcc846f93c45e23abfd06d1e67c4)
    #1 0x7f2f278ff738 in g_malloc debian/build/deb/../../../glib/gmem.c:128:13
    #2 0x7f2f27914583 in g_strdup debian/build/deb/../../../glib/gstrfuncs.c:361:17
    #3 0x564b3e14bb5b in get_dirty_rate tests/qtest/migration-test.c:3447:14
    #4 0x564b3e138e00 in test_vcpu_dirty_limit tests/qtest/migration-test.c:3565:16
    #5 0x564b3e14f417 in migration_test_wrapper tests/qtest/migration-helpers.c:456:5

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/qtest/migration-test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index a659609ccb0..04122120987 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -3435,7 +3435,7 @@ static void wait_for_calc_dirtyrate_complete(QTestState *who,
 static int64_t get_dirty_rate(QTestState *who)
 {
     QDict *rsp_return;
-    gchar *status;
+    const char *status;
     QList *rates;
     const QListEntry *entry;
     QDict *rate;
@@ -3444,7 +3444,7 @@ static int64_t get_dirty_rate(QTestState *who)
     rsp_return = query_dirty_rate(who);
     g_assert(rsp_return);
 
-    status = g_strdup(qdict_get_str(rsp_return, "status"));
+    status = qdict_get_str(rsp_return, "status");
     g_assert(status);
     g_assert_cmpstr(status, ==, "measured");
 
-- 
2.34.1


