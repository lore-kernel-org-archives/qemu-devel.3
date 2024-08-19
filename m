Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17C6AC3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2024 17:07:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sg5qW-0000yS-3K; Mon, 19 Aug 2024 13:07:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sg5qT-0000xv-Kg
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 13:07:05 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sg5qR-0006bd-Nr
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 13:07:05 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-42819654737so35613415e9.1
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2024 10:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724087222; x=1724692022; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=4GmzundrD0SbSrTOkmz6GAZvpiktdShaMN8HJog1gps=;
 b=FjEF/fTXzIzuFIffCqsm0AYqw/0c4pyIRrzybUIvbxkv41qnHvuZPXwWEWYYrJYlFR
 iSM2kqjzOdja9qmUvsaklr2zrbjcQpOOwiBGaeMy5+CKmsJ3F2wEYPzRsQJBfGyhIyJt
 qpGeG5eby96cSupm9FYJnA3tumwrjKYbyJhNMIXddkwy7SQni63M9ijhtnJwh3D1qmg5
 O5XAKDhkwCLiCoYZgzZPNf226WO6O0uJeLwoJzNRc0J8QXSv4u2BeCjxajSA7NbEVs8l
 VBx7HSfHsSltPMfPO/gwQ0QDeof5HY/q+OSCZTf7i1+s9HuXst1H9SXLHUX9Gzcyszv2
 biJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724087222; x=1724692022;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4GmzundrD0SbSrTOkmz6GAZvpiktdShaMN8HJog1gps=;
 b=rq8rYFdBuCrlN8wY75QwMAVb79DOwQpiM2XP4y61DilbhMe5TAs4Tl1z+ZCsROpFaw
 pdOS44bsOAwFP4ahcyveWEG6LLdb+jj784zNQhQLZ9kDsHOkwPgJas+1h+y3/GLtk5Q7
 dS3R7bGyUJwzD1gHML7NdR/M5T9ajkPsyYNWmxJVVMwHCX8eAWaHwLpY58HX96iL50yW
 /sMBtF3XQOgYbPTZhApD5pxez64oAwJLPBAVRM8CzrKBTDa3kQc5zw5Gu1HnTSvCTRZj
 0tZ/cIV5GRZE/YA5UjE1+D5BS+vMxkQVy5zw/5rMnUwcGg5zsFqnhbtjcQKKPmv5b1ZE
 pt2Q==
X-Gm-Message-State: AOJu0YzCvitbD6IvC/n+BesvG8cWrHvwxcFX/Ijt68r0WelwXrwHOuns
 hHw+GnknYg+bRVPyOp+I8VqlQtFJ8iLJdlGlPzwE/FZ7vBKx78A+eKZ6EIFRt5rVYnF1oqhMaif
 c
X-Google-Smtp-Source: AGHT+IFLtwXKc9fo9hisPGFBkGVBMsCMahDajEfCSLVq3HOqiCrWTUtjMWTEATmY9a0ZMM5xK1C9YQ==
X-Received: by 2002:a05:600c:3145:b0:426:62c5:4741 with SMTP id
 5b1f17b1804b1-429ed7870afmr68081085e9.2.1724087221718; 
 Mon, 19 Aug 2024 10:07:01 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3718985a35fsm11007786f8f.59.2024.08.19.10.07.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2024 10:07:01 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH] scripts/lsan-suppressions: Add a LeakSanitizer
 suppressions file
Date: Mon, 19 Aug 2024 18:07:00 +0100
Message-Id: <20240819170700.61844-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

Add a LeakSanitizer suppressions file that documents and suppresses
known false-positive leaks in either QEMU or its dependencies.
To use it you'll need to set
  LSAN_OPTIONS="suppressions=/path/to/scripts/lsan-suppressions.txt"
when running a QEMU built with the leak-sanitizer.

The first and currently only entry is for a deliberate leak in glib's
g_set_user_dirs() that otherwise causes false positive leak reports
in the qga-ssh-test because of its use of G_TEST_OPTION_ISOLATE_DIRS:

Direct leak of 321 byte(s) in 5 object(s) allocated from:
    #0 0x5555dd8abd1e in __interceptor_malloc (/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/asan/qga/qga-ssh-test+0x19cd1e) (BuildId: 7991a166007e8206c51bee401722a8335e7990bb)
    #1 0x7fb5bc724738 in g_malloc debian/build/deb/../../../glib/gmem.c:128:13
    #2 0x7fb5bc739583 in g_strdup debian/build/deb/../../../glib/gstrfuncs.c:361:17
    #3 0x7fb5bc757a29 in set_str_if_different debian/build/deb/../../../glib/gutils.c:1659:21
    #4 0x7fb5bc757a29 in set_str_if_different debian/build/deb/../../../glib/gutils.c:1647:1
    #5 0x7fb5bc757a29 in g_set_user_dirs debian/build/deb/../../../glib/gutils.c:1743:9
    #6 0x7fb5bc743d78 in test_do_isolate_dirs debian/build/deb/../../../glib/gtestutils.c:1486:3
    #7 0x7fb5bc743d78 in test_case_run debian/build/deb/../../../glib/gtestutils.c:2917:16
    #8 0x7fb5bc743d78 in g_test_run_suite_internal debian/build/deb/../../../glib/gtestutils.c:3018:16
    #9 0x7fb5bc74380a in g_test_run_suite_internal debian/build/deb/../../../glib/gtestutils.c:3035:18
    #10 0x7fb5bc74380a in g_test_run_suite_internal debian/build/deb/../../../glib/gtestutils.c:3035:18
    #11 0x7fb5bc743fe9 in g_test_run_suite debian/build/deb/../../../glib/gtestutils.c:3112:13
    #12 0x7fb5bc744055 in g_test_run debian/build/deb/../../../glib/gtestutils.c:2231:7
    #13 0x7fb5bc744055 in g_test_run debian/build/deb/../../../glib/gtestutils.c:2218:1
    #14 0x5555dd9293b1 in main qga/commands-posix-ssh.c:439:12
    #15 0x7fb5bc3dfd8f in __libc_start_call_main csu/../sysdeps/nptl/libc_start_call_main.h:58:16
    #16 0x7fb5bc3dfe3f in __libc_start_main csu/../csu/libc-start.c:392:3
    #17 0x5555dd828ed4 in _start (/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/asan/qga/qga-ssh-test+0x119ed4) (BuildId: 7991a166007e8206c51bee401722a8335e7990bb)

(Strictly speaking, this is a genuine leak, it's just a deliberate
one by glib; they document it in their valgrind-format suppression
file upstream.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Does this seem like a good idea?  It gives us a place to document
things like this and to suppress them so we could in theory get a
complete clean 'make check' run with the leak sanitizer on.  It might
be nice if there was an easy way to enable all our "recommended
sanitizer settings" (ASAN_OPTIONS="fast_unwind_on_malloc=0 is
pretty much required to get useful backtraces, for instance), but
I'm not sure there's a neat way to do that.

 scripts/lsan-suppressions.txt | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 scripts/lsan-suppressions.txt

diff --git a/scripts/lsan-suppressions.txt b/scripts/lsan-suppressions.txt
new file mode 100644
index 00000000000..5c3cffaa5a0
--- /dev/null
+++ b/scripts/lsan-suppressions.txt
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2024 Linaro Limited
+
+# This is a set of suppressions for LeakSanitizer; you can use it
+# by setting
+#   LSAN_OPTIONS="suppressions=/path/to/scripts/lsan-suppressions.txt"
+# when running a QEMU built with the leak-sanitizer.
+
+# g_set_user_dirs() deliberately leaks the previous cached g_get_user_*
+# values. This is documented in upstream glib's valgrind-format
+# suppression file:
+# https://github.com/GNOME/glib/blob/main/tools/glib.supp
+# This avoids false positive leak reports for the qga-ssh-test.
+leak:g_set_user_dirs
-- 
2.34.1


