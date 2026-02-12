Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DAB0EB4912
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 11:48:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqVAo-0005YE-PB; Thu, 12 Feb 2026 06:47:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vqVAm-0005XZ-PY
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 06:47:52 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vqVAl-0001Ms-3r
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 06:47:52 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-436317c80f7so1204813f8f.1
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 03:47:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770896869; x=1771501669; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=P7p285p4aWWD7iokggCSCaRg9DURJcUVTvGMhajVaMI=;
 b=L2Cbi43zOii22ZdC7i3gVwogxo6bidmcynJB9xq9/fc7ZCAaoWq5mIgLnab4y1Xa/5
 gt1oDduvUmGn5fEKz0thLTG1OurYuUZnmP1ZuRW75oimuw9wF8sPJ2Qa75vCGet+QULn
 4uwCHaYvGalJnnNDnG6XocdnvRl8W6kndYLfKqEanRS/o2PgnKMcHWNvOQvkjkHc42nh
 zEfoFXyFdmBhAqwvVxMOnEBLpW9vyq4y0TN73S0gt0+r+GkxEAf1J89BlO/sf4lI6V90
 FWeYXAZJ9Fo7jwKkt6nwYCU2IVlhClFqOCcB1dtJ8IR/AQAgKLtqUBZySs1iLT1KoeOy
 IkYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770896869; x=1771501669;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P7p285p4aWWD7iokggCSCaRg9DURJcUVTvGMhajVaMI=;
 b=TI8A5IGJZYbn5a/isOeGzAMrvM+vEP5TRHbp4176Tj+K+qWUkx0E3zmxtQZj/jIEex
 79UpBFqsDiWdr4EPdNxI3URTP6LadvDj2aStucAMU6Qk7EjQstAGkbypUTTEOg/8k2gc
 MbqaM22IxucEVs4fyLr6ztKfS8tYp9CQ+IPJfjlfiln52yRSMnhyjGgIhQ/dNo9ZYmt/
 q5FmIsfxvgbPpzYFKeDV3w+GDbYmJHKifpPMGMUutr6AXwtQLAMaKg1/JVrL4AaMmtMu
 FkM4E3C7LIvs/wC53/Qlhnmx8mWPIPAQ2c/UskpqhhywV/chS/1upO7pJVFB815rrOm1
 l15A==
X-Gm-Message-State: AOJu0Yzk3GOe2JDXk+N8L2G57tVSC9XyuzWf6zPIqXkenD/KhoDOSze2
 ojsSVBBna/Pd7cjOrxEtEZuItZX9AjUBYj56UviOPelBq75RtYN6fwb2vYAN9qVfU+HTjvK6/8O
 xIpWu
X-Gm-Gg: AZuq6aIOWxXjearoWHRx1q3TMMqSVMv7vp+0vOg69htzVSV0xg9KDR0FFtSP40mxOpq
 IbnMw0Ja0fc1/bw3UnJAKsyoyHLj3/idtPU4na7gq4XT5UPLAm5f+V5VmsbmWX0Dpx3LT2HlmWi
 3Npj9WbfyaeR4y7Vq6Y2tiIN1m5ZAGr+yGTejUUC4+6X0wkl5gg7U3sbV+bewH+QvorzDjVWpGM
 H53ZmzD1MgJ1tjmtHzWdml4X3pK6jv9lXKCWXTrtu+Zjbs7Wxo6HkOT/EbLo1oRkD4IzYzd0Fxm
 2xwvVlIbga5qUL30SbJ2tuwkZarbz6qgxnVXisLiA8uIhjZB0NakVDkJiST2ERuERPYe8TqKPqr
 0PVcNPRIofwwWDXY0a+6/nA0YpvVsHqhWrchIfdmI5OD0fya3VoXRE8neTtnDBadPlZgYbY08cm
 CSuLLTlxL+TkQv9j/59Lw1DLfW1l0x2F8CCuF55/GeU/x3ynw6rTxw8wd8xrL8lrPVhNOeyW+4q
 Nn+ALKvVzsKf62Nn/QbswCh4GeMDPQ=
X-Received: by 2002:a05:600c:4747:b0:471:793:e795 with SMTP id
 5b1f17b1804b1-48365f7ef33mr32471725e9.0.1770896869131; 
 Thu, 12 Feb 2026 03:47:49 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4835dd0deeasm101768445e9.12.2026.02.12.03.47.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Feb 2026 03:47:48 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH] tests/qtest/migration/tls-tests.c: Don't use tls_psk end hook
 for no_tls tests
Date: Thu, 12 Feb 2026 11:47:47 +0000
Message-ID: <20260212114747.1103466-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
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

If you run the TLS tests under a clang undefined-behaviour sanitizer build
it will fall over like this:

../../tests/unit/crypto-tls-psk-helpers.c:53:12: runtime error: null pointer passed as argument 1, which is declared to never be null
/usr/include/unistd.h:858:48: note: nonnull attribute specified here
    #0 0x62bd810762ee in test_tls_psk_cleanup /home/pm215/qemu/build/clang/../../tests/unit/crypto-tls-psk-helpers.c:53:5
    #1 0x62bd81073f89 in migrate_hook_end_tls_psk /home/pm215/qemu/build/clang/../../tests/qtest/migration/tls-tests.c:101:5
    #2 0x62bd81062ef0 in test_precopy_common /home/pm215/qemu/build/clang/../../tests/qtest/migration/framework.c:947:9

This happens because test_precopy_tcp_no_tls() uses a custom start_hook
that only sets a couple of parameters, but reuses the tsk_psk end_hook.
However, the end_hook runs cleanup that assumes that the data was set
up by migrate_hook_start_tls_psk_common(). In particular, it will
unconditionally call test_tls_psk_cleanup(data->pskfile), and
test_tls_psk_cleanup() will unconditionally unlink() the filename it
is passed, which is undefined behaviour if you pass it a NULL pointer.

Instead of creating a TestMigrateTLSPSKData struct which we never set
any fields in and requiring the migrate_hook_end_tls_psk() hook to
cope with that, don't allocate the struct in the start_hook. Then
there is nothing we need to clean up, and we can set the end_hook
to NULL (which the test framework will interpret as "don't call
any end_hook").

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Not sure when this would have appeared, so cc'ing stable as it
seems safe enough to backport just in case.
---
 tests/qtest/migration/tls-tests.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/tests/qtest/migration/tls-tests.c b/tests/qtest/migration/tls-tests.c
index bf0bb06a29..4ce7f6c676 100644
--- a/tests/qtest/migration/tls-tests.c
+++ b/tests/qtest/migration/tls-tests.c
@@ -488,20 +488,18 @@ static void test_precopy_tcp_tls_psk_mismatch(char *name, MigrateCommon *args)
 
 static void *migrate_hook_start_no_tls(QTestState *from, QTestState *to)
 {
-    struct TestMigrateTLSPSKData *data =
-        g_new0(struct TestMigrateTLSPSKData, 1);
-
     migrate_set_parameter_null(from, "tls-creds");
     migrate_set_parameter_null(to, "tls-creds");
 
-    return data;
+    return NULL;
 }
 
 static void test_precopy_tcp_no_tls(char *name, MigrateCommon *args)
 {
     args->listen_uri = "tcp:127.0.0.1:0";
     args->start_hook = migrate_hook_start_no_tls;
-    args->end_hook = migrate_hook_end_tls_psk;
+    /* the no_tls start hook requires no cleanup actions */
+    args->end_hook = NULL;
 
     test_precopy_common(args);
 }
-- 
2.43.0


