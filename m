Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 998A8C5478C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 04:00:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfu3j-00048F-1T; Thu, 29 Feb 2024 22:59:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bryan.zhang@bytedance.com>)
 id 1rfu3a-00047B-PG
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 22:59:35 -0500
Received: from mail-qk1-x729.google.com ([2607:f8b0:4864:20::729])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bryan.zhang@bytedance.com>)
 id 1rfu3Z-0005f0-4u
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 22:59:34 -0500
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-787dacbcfeeso90503285a.1
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 19:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1709265572; x=1709870372; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LyOj4EOEJC+5kw+zlLlJ+hZRPszzVwAFiDK3HfnEjew=;
 b=Ejk73uoaDyDXxmvHwQ+e6Mb3dY9/lFtu7Egh84+uJECcgQP2wqCpD+rNAj8MNDahZ5
 RTkFVTRWGKJ2MYP2KmExqxAZytXZuPCQKQiE01jIJU2i7UJxGZFbEv9yvpEVOG5hpuja
 NM4qeX0Jz3l87hFvP5L9KKwwOwtDoeGH3D2WTLM60TMCarwBjxhNIpmQYVFlTtQXJ1uZ
 aImCAQKvZtkbG0oCzP5H6z/cxDVR+5kDtfMs3K9wolCUDVqm94CRJJG1MqlhczWP3lje
 O8lLqK+jcrrSY9i6sIB/u68Vls/FtHlf/ZdGnlAIRdaBBqYcFNOTZhw4eM3i/o+EV3sZ
 DwJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709265572; x=1709870372;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LyOj4EOEJC+5kw+zlLlJ+hZRPszzVwAFiDK3HfnEjew=;
 b=E4rBjBE0HKfGI892t4YhfMnpSjr8UPHPsWsgH/S0a/uYxWLhyGYQAyUhtBttZZ1GV7
 rgajuGXtk9YR1Oo2ARTfljBkk87qbmQPqt0VA+jAv/n31ByZONVeoQnyHT0aq5/RzHrk
 QfLqHAmC/5ojyy03/asQi5aWjdfn8glj/QDqWx04HROsG9ynt4nwkQhBUoiI/WV3C36E
 FBuHYtH4jlIABt1StbzPuuwUQBpZMmPbvDo6U/ZcI6JHujVTrAPphmD9Ii6FLslZBejj
 J3ta3SCM5fuvJFmfDwS+JZgrrfERJtuitN0K1lJRmoI3jjojk97rsq83wP0qtNLxdrED
 k5Nw==
X-Gm-Message-State: AOJu0Yy++sOXhz6IWfgPd/f9lm+pSA3qLagsV1jmOJKkOKLHo2DPeUJo
 /wt0hg/74NNxSf2a3qDYAjHTVWNmP1jl5A9/kr69X+FW/bzfFBtd6ZUgvkSW5B8m69+Jwy7zdHR
 j
X-Google-Smtp-Source: AGHT+IFP71C6QHjsLqwg0m9nYdp5OzOGLkZeF6fhiTIhZc/aHQH07oznClUUjJZHfDiQguWaPZbawg==
X-Received: by 2002:a05:620a:471f:b0:787:dd94:a492 with SMTP id
 bs31-20020a05620a471f00b00787dd94a492mr835167qkb.16.1709265571860; 
 Thu, 29 Feb 2024 19:59:31 -0800 (PST)
Received: from n36-186-108.byted.org. ([130.44.212.90])
 by smtp.gmail.com with ESMTPSA id
 c21-20020a05620a165500b00787c6703539sm1296986qko.90.2024.02.29.19.59.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Feb 2024 19:59:31 -0800 (PST)
From: Bryan Zhang <bryan.zhang@bytedance.com>
To: qemu-devel@nongnu.org,
	peterx@redhat.com,
	farosas@suse.de
Cc: hao.xiang@bytedance.com, Bryan Zhang <bryan.zhang@BYTEDANCE.COM>,
 Bryan Zhang <bryan.zhang@bytedance.com>
Subject: [PATCH 2/2] tests/migration: Set compression level in migration tests
Date: Fri,  1 Mar 2024 03:59:01 +0000
Message-Id: <20240301035901.4006936-3-bryan.zhang@bytedance.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240301035901.4006936-1-bryan.zhang@bytedance.com>
References: <20240301035901.4006936-1-bryan.zhang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::729;
 envelope-from=bryan.zhang@bytedance.com; helo=mail-qk1-x729.google.com
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

From: Bryan Zhang <bryan.zhang@BYTEDANCE.COM>

Adds calls to set compression level for `zstd` and `zlib` migration
tests, just to make sure that the calls work.

Signed-off-by: Bryan Zhang <bryan.zhang@bytedance.com>
---
 tests/qtest/migration-test.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 8a5bb1752e..f23e860547 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -2625,6 +2625,13 @@ static void *
 test_migrate_precopy_tcp_multifd_zlib_start(QTestState *from,
                                             QTestState *to)
 {
+    /*
+     * Overloading this test to also check that set_parameter does not error.
+     * This is also done in the tests for the other compression methods.
+     */
+    migrate_set_parameter_int(from, "multifd-zlib-level", 2);
+    migrate_set_parameter_int(to, "multifd-zlib-level", 2);
+
     return test_migrate_precopy_tcp_multifd_start_common(from, to, "zlib");
 }
 
@@ -2633,6 +2640,9 @@ static void *
 test_migrate_precopy_tcp_multifd_zstd_start(QTestState *from,
                                             QTestState *to)
 {
+    migrate_set_parameter_int(from, "multifd-zstd-level", 2);
+    migrate_set_parameter_int(to, "multifd-zstd-level", 2);
+
     return test_migrate_precopy_tcp_multifd_start_common(from, to, "zstd");
 }
 #endif /* CONFIG_ZSTD */
-- 
2.30.2


