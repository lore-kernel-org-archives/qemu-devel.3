Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98C11C531DC
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 14:51:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgQAm-000591-0R; Tue, 20 Aug 2024 10:49:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sgQAi-0004wS-Qc
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 10:49:21 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sgQAf-0006Kz-LR
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 10:49:18 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-42ab880b73eso6775305e9.0
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2024 07:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724165356; x=1724770156; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=srQqSMLi7+DN7GKyrDGJ1XhNsgSSac4GLNRUFZMUAQM=;
 b=Y7OTo7QTpxh1kyI+RK15lqZXxKWNntgoK9DtQEMcN0K9/amnwAuWP8RHlC3QV8abZG
 Xr0plf/LQChE47Ck7w0eyHF0zdEw+P5B8NvYKJ0QkpOFw6VRTf4vKSkVReP+21MevXnU
 iEJ47uO9tuvCmQuPYYP29ow5zDTETjw3yGMrswl+6bzG2k+gjxv/nSOcSnmPI97IjhPP
 V2wZjB5Q6xNBtXxKILaAH9AZqUCCiEFrx64bZoPTS7kk9KoVPwXOMqtm7ebicb3USJqC
 fKY10JyArv3F/B3+VxNkVuPmzuzRo4K6cAMnG1eHci5iNGUpJ3YKQ7RP3cruSF/kpFip
 rSBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724165356; x=1724770156;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=srQqSMLi7+DN7GKyrDGJ1XhNsgSSac4GLNRUFZMUAQM=;
 b=YYoECZp0YLJ2GP9on1TP+md1irmRTRuuO9wqwixTcUODzDq1eJKWPdF3I3Sl6KCCOc
 ar8JrEPH9gRD8SNlZU4X9TXOh5Hu1VZW+TuZI0MRzGYrLXUZxVoiIxEcXQerHl2O4s1f
 N5zOSgUiLQ0Ep8UrVdrY3TjSkkya5ftQPrf++izJ0BbIXdqEc+6oXCxk+Xo6wp5fshdE
 cIwCjtXJ1wKqFaJ1lcW1jke1tDUU6NUvfPKJd6RD5Wh10XeoQTvR3DIQAqr/RhsWlWhX
 5AKedfBqXCIN7GvyRbKveWc/tUu76xuQoivxt3E+GQG/P+acQHFqXZGRHLIOyjD9WS/6
 nFIQ==
X-Gm-Message-State: AOJu0YzgQN358btKwSLw1J5+7T/ZyX+8KDzOur089b3Zrtk6KTXktpXV
 Z+1UlDFASyMVVa4XmoQEsFlHH2QslEsqX3wMgcwzf+deVKv6jPnPqDPEE/WjF4Ihd4iK+q9ia7c
 1
X-Google-Smtp-Source: AGHT+IHxrkoKV4CBR7iOA/nTIHUoTupMfjzEN9DTVKrhiCY5MAjLPcJvm67J0gi3pHzrO3nV+wBrMw==
X-Received: by 2002:a5d:498b:0:b0:36d:341d:270 with SMTP id
 ffacd0b85a97d-371946a4b4emr10329066f8f.59.1724165355480; 
 Tue, 20 Aug 2024 07:49:15 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3718983a306sm13334672f8f.15.2024.08.20.07.49.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Aug 2024 07:49:15 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH for-9.2 3/9] tests/qtest/migration-test: Fix leaks in
 calc_dirtyrate_ready()
Date: Tue, 20 Aug 2024 15:49:06 +0100
Message-Id: <20240820144912.320744-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240820144912.320744-1-peter.maydell@linaro.org>
References: <20240820144912.320744-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

In calc_dirtyrate_ready() we g_strdup() a string but then never free it:

Direct leak of 19 byte(s) in 2 object(s) allocated from:
    #0 0x55ead613413e in malloc (/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/asan/tests/qtest/migration-test+0x22f13e) (BuildId: e7cd5c37b2987a1af682b43ee5240b98bb316737)
    #1 0x7f7a13d39738 in g_malloc debian/build/deb/../../../glib/gmem.c:128:13
    #2 0x7f7a13d4e583 in g_strdup debian/build/deb/../../../glib/gstrfuncs.c:361:17
    #3 0x55ead6266f48 in calc_dirtyrate_ready tests/qtest/migration-test.c:3409:14
    #4 0x55ead62669fe in wait_for_calc_dirtyrate_complete tests/qtest/migration-test.c:3422:13
    #5 0x55ead6253df7 in test_vcpu_dirty_limit tests/qtest/migration-test.c:3562:9
    #6 0x55ead626a407 in migration_test_wrapper tests/qtest/migration-helpers.c:456:5

We also fail to unref the QMP rsp_return, so we leak that also.

Rather than duplicating the string, use the in-place value from
the qdict, and then unref the qdict.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/qtest/migration-test.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 6aba527340b..9811047eeb4 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -3398,15 +3398,18 @@ static QDict *query_vcpu_dirty_limit(QTestState *who)
 static bool calc_dirtyrate_ready(QTestState *who)
 {
     QDict *rsp_return;
-    gchar *status;
+    const char *status;
+    bool ready;
 
     rsp_return = query_dirty_rate(who);
     g_assert(rsp_return);
 
-    status = g_strdup(qdict_get_str(rsp_return, "status"));
+    status = qdict_get_str(rsp_return, "status");
     g_assert(status);
+    ready = g_strcmp0(status, "measuring");
+    qobject_unref(rsp_return);
 
-    return g_strcmp0(status, "measuring");
+    return ready;
 }
 
 static void wait_for_calc_dirtyrate_complete(QTestState *who,
-- 
2.34.1


