Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E812DE77184
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 02:47:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOT2B-0001nz-E3; Thu, 19 Dec 2024 21:46:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tOT2A-0001nO-4j; Thu, 19 Dec 2024 21:46:34 -0500
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tOT28-0000He-Kq; Thu, 19 Dec 2024 21:46:33 -0500
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-7f46d5d1ad5so1032261a12.3; 
 Thu, 19 Dec 2024 18:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734662790; x=1735267590; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6vzF34pQlizNqgzOprBJ7Xal/hRzhdpRE+opT1pviwc=;
 b=dyZOaxL287GF65W5uATQ0e2BfLFqBqrmHvqNngQnxGhBGK2AWT068OVt16vjmp3ytE
 UQt3ynjyDvVQlkhm9oE/c41qaOqTBYpw+KJbrxRXv1O8pG88SZHHzBs3Up4RJiCrSTdb
 De6Xykcoy2VfFQu1z/yOJdu/KnaK5iyy5XPxIqOeEl5mFKNflXtU3rb7ZISAlWiBV3jY
 A8n9DwuSFfz2Mececim0zUqcUEviJRhDAOMYc7YbfDh/4hZUCxhFKfNGBgPOvkggtxEI
 nlAgOxB3Y2gwjFG1v9YR1UxneNkcPP1Ns31qBTxy1C10amGGFZbUz0K8DlDTk8WYtWB0
 bBgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734662790; x=1735267590;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6vzF34pQlizNqgzOprBJ7Xal/hRzhdpRE+opT1pviwc=;
 b=ZDZHnpNRnhKVkXSz0X02khOySMMYuqznrA+JXNw0f5SCd6iBTlJPaE9GUWP5dfeZ9b
 +8ErPYX1Xv70OybVIXMWZv1Cqvi4+w2gE1bjByLK4GJG/KcA0SnxFbNpV0bhYzQBckEh
 oTCNhxm1FsGlvJyHc/aHkCr7T00PkcvTzJwFAU0m8zS+9HDZDm7RWOMA1deu9ltAgxPf
 3yX9ryHueAO6WN1WvAzQOq38B/Mwqb5wKh/0g8lUAZnH7d2RsK7hqeTBKwELnIUlJtJv
 DGU+puDFhgJ+G6wAj2N5xQu5E/vflg3xtduE7GepGa5IULPo7lstB55zP8gEnyZwffCN
 8nwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUf6PrW2hFxTbJ82yv3ku5efZZB6hEARFmWEVLSb40KUZQt6ZZWXe/sYFbdpYPyM7Bn8UDJwvLNfQ==@nongnu.org
X-Gm-Message-State: AOJu0YymAvmhlIYAL3eGs9rR9/oMe3sK5F96P6OP8w2qgu3pYxpIuaf8
 thNt5I1e20Z2tZ0zmEuz9+8x8FUD9i7XU0tzNkYkSfLpN2TYc/KLgu6uEQ==
X-Gm-Gg: ASbGnctTI1EbKjyQhzK4vUp3guJ4g8vNoO66hNDnp50AO5/HMQNz2cGGB//SbdvSt9C
 Eb7+uG3hZ4SRSq2xRY6tT05f/7nvrCULG12Dkb4Xk6o2Q8OHF3wU4jkmzD22pgfBp1BB4YlAWCF
 SvjDB+i/FKKOkk8EOyiUEB8OeBsmJzmqwwtKv6yB3aB8vkOKIqxhuk+fZlvM8A1Uvym53ctR0KY
 k0GB57TWacjio/EGyODxZ17RMpd+mg7gFJBb0lDop9QTC0fSY9Veh8MHGfqytJlcUo06+H9UZ6O
 1mL1P9FH6A==
X-Google-Smtp-Source: AGHT+IEftn4n0MISXaBfqwq4/icw4vxQsRl6dSYGaCwLrA2cFFnCPe2C/ex2ih4Mxxcc54YZVxdLWQ==
X-Received: by 2002:a05:6a21:680d:b0:1e1:ac4f:d322 with SMTP id
 adf61e73a8af0-1e5e0484559mr2467555637.14.1734662790558; 
 Thu, 19 Dec 2024 18:46:30 -0800 (PST)
Received: from wheely.local0.net (14-200-18-130.tpgi.com.au. [14.200.18.130])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8dba99sm2037830b3a.92.2024.12.19.18.46.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 18:46:30 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-ppc@nongnu.org
Subject: [PATCH 1/4] tests/functional: Don't fail the whole test if a
 pre-cache fetch fails
Date: Fri, 20 Dec 2024 12:46:14 +1000
Message-ID: <20241220024617.1968556-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241220024617.1968556-1-npiggin@gmail.com>
References: <20241220024617.1968556-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

If any pre-cache downloads fail, the entire functional test run
is failed.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/functional/qemu_test/asset.py | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tests/functional/qemu_test/asset.py b/tests/functional/qemu_test/asset.py
index f126cd5863a..f82b07e7027 100644
--- a/tests/functional/qemu_test/asset.py
+++ b/tests/functional/qemu_test/asset.py
@@ -102,7 +102,8 @@ def fetch(self):
             return str(self.cache_file)
 
         if os.environ.get("QEMU_TEST_NO_DOWNLOAD", False):
-            raise Exception("Asset cache is invalid and downloads disabled")
+            raise Exception("Failed to fetch asset %s, not found in cache "
+                            "and downloads are disabled", self.url)
 
         self.log.info("Downloading %s to %s...", self.url, self.cache_file)
         tmp_cache_file = self.cache_file.with_suffix(".download")
@@ -162,7 +163,13 @@ def precache_test(test):
         for name, asset in vars(test.__class__).items():
             if name.startswith("ASSET_") and type(asset) == Asset:
                 log.info("Attempting to cache '%s'" % asset)
-                asset.fetch()
+                try:
+                    asset.fetch()
+                except:
+                    # Asset pre-cache should not be fatal. An error is printed
+                    # and the test itself will fail if it is unable to get the
+                    # assert.
+                    pass
         log.removeHandler(handler)
 
     def precache_suite(suite):
-- 
2.45.2


