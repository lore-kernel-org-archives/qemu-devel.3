Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E65FC531DF
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 14:50:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgQAn-0005F8-Ha; Tue, 20 Aug 2024 10:49:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sgQAl-00056l-D7
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 10:49:23 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sgQAj-0006M1-8P
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 10:49:23 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-42812945633so49501165e9.0
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2024 07:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724165360; x=1724770160; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cX04CHrSO6RPXxQ10TYYxqNDsV8QV6DrYzWSCmg9HZE=;
 b=FzJ7wVj2E7IMABY3xTBwuf/0mhtu/9WQR3kAvHQAqoAuc5C5/33yWnDZH7/4e96JhP
 8R0FiCu3qfb23441dFbV72hQVjYuc8VZjY59eQkfKPEzmdS+q531tDUxmG2jUrMYxw34
 /262iBVpE7CNgQvNfNpik8elsMKidFC/k/akMYYjCb+7xHYlxpxaQQH2/lq43UfLS1wh
 rIuDDx40INCdfVNb9d3SMcoFuZj9lQhIE/vpz6xV/50oJWM84/+H7RTuE3/qrsF4u2/W
 8Ykw7AJayhYx3tjNY26kDLmZEqMmNYgxVlj2PL8BL61squOpjD6j50YG9Mg32DYrEtLI
 5tuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724165360; x=1724770160;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cX04CHrSO6RPXxQ10TYYxqNDsV8QV6DrYzWSCmg9HZE=;
 b=U+UJHY4iQGO3aP/6kWYpyE8Ol783xJ4h3FqvYyXieRiEl8t+edYHkxYenAQiAq7FPA
 EgBuvMIs1+ldDZk3pm08FvdqmFSxa7GdfoOs2J2uWXKBvA32Yi6zuj+RxQ3I7diDa0SZ
 +j641uxZxuOez95ewrkg4LeIPp2mhTKZHxgxMSObhoshwARPSZl4zRpRZBNCiiNXvnY0
 Gfa37ANKJd87thVCinmZQknzVz5uUh4A/dRP2g3HpXtDn0haJwWexS/4/VrgdK0mOiVC
 380JAoJCNOsdZuBYuGke6a3eiicpvG/zG+6mBm2kePh4R1qut0QYInb7hhZRVBrU86Sh
 Rc6g==
X-Gm-Message-State: AOJu0YyKII19Gz/36l4iqRtoiCFQb3svpKohYyuy6UIOTkiFIwBUw65a
 esxWC5jdy5BmYXZAnAZxXHw4iIIJwFKdOwCfeptTjvbGySknUdczDfblC68jF3IbTbDJDM99LGi
 8
X-Google-Smtp-Source: AGHT+IHnDWcnCJrEnwVDXUDlG9y1adhxClOcx1t4xLNuadOY1NmlcCtCLEVXevJl97xfA6K11JTCHA==
X-Received: by 2002:adf:ab18:0:b0:371:8ec6:f2f0 with SMTP id
 ffacd0b85a97d-3719432dcc3mr8507017f8f.16.1724165359671; 
 Tue, 20 Aug 2024 07:49:19 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3718983a306sm13334672f8f.15.2024.08.20.07.49.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Aug 2024 07:49:18 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH for-9.2 9/9] tests/qtest/migration-test: Don't leak QTestState
 in test_multifd_tcp_cancel()
Date: Tue, 20 Aug 2024 15:49:12 +0100
Message-Id: <20240820144912.320744-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240820144912.320744-1-peter.maydell@linaro.org>
References: <20240820144912.320744-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

In test_multifd_tcp_cancel() we create three QEMU processes: 'from',
'to' and 'to2'.  We clean up (via qtest_quit()) 'from' and 'to2' when
we call test_migrate_end(), but never clean up 'to', which results in
this leak:

Direct leak of 336 byte(s) in 1 object(s) allocated from:
    #0 0x55e984fcd328 in __interceptor_calloc (/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/asan/tests/qtest/migration-test+0x22f328) (BuildId: 710d409b68bb04427009e9ca6e1b63ff8af785d3)
    #1 0x7f0878b39c50 in g_malloc0 debian/build/deb/../../../glib/gmem.c:161:13
    #2 0x55e98503a172 in qtest_spawn_qemu tests/qtest/libqtest.c:397:21
    #3 0x55e98502bc4a in qtest_init_internal tests/qtest/libqtest.c:471:9
    #4 0x55e98502c5b7 in qtest_init_with_env tests/qtest/libqtest.c:533:21
    #5 0x55e9850eef0f in test_migrate_start tests/qtest/migration-test.c:857:11
    #6 0x55e9850eb01d in test_multifd_tcp_cancel tests/qtest/migration-test.c:3297:9
    #7 0x55e985103407 in migration_test_wrapper tests/qtest/migration-helpers.c:456:5

Call qtest_quit() on 'to' to clean it up once it has exited.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/qtest/migration-test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 04122120987..169ef0209c7 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -3322,6 +3322,7 @@ static void test_multifd_tcp_cancel(void)
     /* Make sure QEMU process "to" exited */
     qtest_set_expected_status(to, EXIT_FAILURE);
     qtest_wait_qemu(to);
+    qtest_quit(to);
 
     args = (MigrateStart){
         .only_target = true,
-- 
2.34.1


