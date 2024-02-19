Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A156C48BC3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 08:38:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbz2X-00008v-DG; Mon, 19 Feb 2024 03:30:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rbz2V-0008W1-AV; Mon, 19 Feb 2024 03:30:15 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rbz2Q-000269-2j; Mon, 19 Feb 2024 03:30:14 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1d93edfa76dso21945685ad.1; 
 Mon, 19 Feb 2024 00:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708331408; x=1708936208; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZtUlfVC/CoXaXLT7OI7+r07dsTnTE47z6bChDQn+KEY=;
 b=NVUq+TAj5rl5rlRviYbMcdbr+WnlDQ1NyKbCX80tw/wcQ4ZO6njrmkoeatTLatSzU6
 ttP5GwBoDQygxNY5biauCSLQ5uZ869SPw7qpw0SJJZdbphDCAPZqm012v0cW7inIJmh5
 QSstbNuOpCGHzSQ+2u8mvXKuf9L1Icaxe6Nyx1qvr+ydSE+YbrmE0FmE+bOnWXbUrkhe
 oAyIEcLLPa3yKcD+gyOFCwCKph4OLjVz2JA10fPqOFp6vlT/ORJm7hhtxXCVqc5L6b/e
 +VPZnTY5FjbBgefJfHI0dh2wh/hDIpyPgSX5FZ9gnb/gWpWsw0IfR4XhoC0XJ2ovpJK7
 jh+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708331408; x=1708936208;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZtUlfVC/CoXaXLT7OI7+r07dsTnTE47z6bChDQn+KEY=;
 b=n7wvTK/HxFaK2RqZF+Tfbs2aDUTj4hkvRi8QIoofPHsifAxabqP/gZJvXhrHey5M7A
 MHY7apX9b835wP4nURgDie1fccrbhutAGgqPxg2pSK7kDnf9YtOeicXi+fyxirPnAObL
 fUOxp7DoIi3uMoG5RirwcqSE6IJRHj+BZWDnbXJPi5LhLyZUN79fok2FF2lgdCTuyWZQ
 0Vuf7L+LbFjVjfbtlTQSJBvIyXAGUxyUyPOPcUiyuMCycmcqyszsqtou6xzLbco8ng92
 RrT1WAzv0aj/2xJ39oZbigfIfoGzLeTv4YPtb0t+uHxmuuDHRnHyYH6GBm7BjtoChNbX
 Mmng==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2xH9+TLEZ2UZeOwmiLXO9IwJjEEvMQJhW1QmXJSL4kuJoTCzkdAZM+O1Yureh4tGSOBYljp/vdLkLwvkyqVFSpygs
X-Gm-Message-State: AOJu0YxR614feK5g0+rMv8XcdZGg8rBriA4rOeAQgxcSB8gVvQeZKEq/
 BmDF7CKa82tGqoy0CEdaoQnYqhBDkWI71xMD2uA2WZLdzcOrMp57wx4LFnrw
X-Google-Smtp-Source: AGHT+IHR1yiDSA0p5vDPtD6Q2XzpweQh47uaFuKVjeqqQq84GKKUu6Jd9quJHdUolelheoJk+QI8Zg==
X-Received: by 2002:a17:902:e804:b0:1dc:28:185a with SMTP id
 u4-20020a170902e80400b001dc0028185amr1102972plg.59.1708331408091; 
 Mon, 19 Feb 2024 00:30:08 -0800 (PST)
Received: from wheely.local0.net ([1.146.38.93])
 by smtp.gmail.com with ESMTPSA id
 mo7-20020a1709030a8700b001db5ecd115bsm3838348plb.276.2024.02.19.00.30.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Feb 2024 00:30:07 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 03/49] tests/avocado: mark boot_linux.py long runtime instead
 of flaky
Date: Mon, 19 Feb 2024 18:28:52 +1000
Message-ID: <20240219082938.238302-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240219082938.238302-1-npiggin@gmail.com>
References: <20240219082938.238302-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

The ppc64 and s390x tests were first marked skipIf GITLAB_CI by commit
c0c8687ef0f ("tests/avocado: disable BootLinuxPPC64 test in CI"), and
commit 0f26d94ec9e ("tests/acceptance: skip s390x_ccw_vrtio_tcg on
GitLab") due to being very heavy-weight for gitlab CI.

Commit 9b45cc99318 ("docs/devel: rationalise unstable gitlab tests under
FLAKY_TESTS") changed this to being flaky but it isn't really, it just
had a long runtime.

So take the SPEED=slow variable from qtests and introduce it to avocado,
and make these tests require it.

Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 docs/devel/testing.rst      | 11 +++++++++++
 tests/avocado/boot_linux.py |  8 ++------
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
index bd132306c1..5cdc23b90f 100644
--- a/docs/devel/testing.rst
+++ b/docs/devel/testing.rst
@@ -1346,6 +1346,17 @@ the environment.
 The definition of *large* is a bit arbitrary here, but it usually means an
 asset which occupies at least 1GB of size on disk when uncompressed.
 
+SPEED
+^^^^^
+Tests which have a long runtime will not be run unless ``SPEED=slow`` is
+exported on the environment.
+
+The definition of *long* is a bit arbitrary here, and it depends on the
+usefulness of the test too. A unique test is worth spending more time on,
+small variations on existing tests perhaps less so. As a rough guide,
+a test or set of similar tests which take more than 100 seconds to
+complete.
+
 AVOCADO_ALLOW_UNTRUSTED_CODE
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 There are tests which will boot a kernel image or firmware that can be
diff --git a/tests/avocado/boot_linux.py b/tests/avocado/boot_linux.py
index 7c4769904e..de4c8805f7 100644
--- a/tests/avocado/boot_linux.py
+++ b/tests/avocado/boot_linux.py
@@ -93,13 +93,11 @@ class BootLinuxPPC64(LinuxTest):
 
     timeout = 360
 
-    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on GitLab')
-
+    @skipUnless(os.getenv('SPEED') == 'slow', 'runtime limited')
     def test_pseries_tcg(self):
         """
         :avocado: tags=machine:pseries
         :avocado: tags=accel:tcg
-        :avocado: tags=flaky
         """
         self.require_accelerator("tcg")
         self.vm.add_args("-accel", "tcg")
@@ -113,13 +111,11 @@ class BootLinuxS390X(LinuxTest):
 
     timeout = 240
 
-    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on GitLab')
-
+    @skipUnless(os.getenv('SPEED') == 'slow', 'runtime limited')
     def test_s390_ccw_virtio_tcg(self):
         """
         :avocado: tags=machine:s390-ccw-virtio
         :avocado: tags=accel:tcg
-        :avocado: tags=flaky
         """
         self.require_accelerator("tcg")
         self.vm.add_args("-accel", "tcg")
-- 
2.42.0


