Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F259C28B2E
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 05:18:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsETj-0002nr-QN; Wed, 12 Mar 2025 01:18:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tsETg-0002n7-R2
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 01:18:00 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tsETe-00070n-8P
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 01:18:00 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-22359001f1aso148463865ad.3
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 22:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741756676; x=1742361476; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FKBJLiBMvTXU01UIUdx9mtjp99FG3zwnJ4eVDlAWpCk=;
 b=OcZ39v2pWXm0kOnE8DmSQtZMALkhyP9o8bKcuwY9p4rGUk+r6U8pJxBj7oNLh9r1oi
 CJJTnz6yVXy+54mDbnce2D2/67xlWi7LQLSMnTmS/RROzIqLKMZllAKPozaEOSgjekkL
 kiBgL14b8t7WHNMucYTpfFQA6kPf/5Zo9HRay/3jMMJPe1U7pp+tnb7oRB+v1wMMIrEL
 9CpPPc2gzOR2B+NnLVVfyDnFx+Jy7fk0McphSraQsDFWJnAoLUFe/sHWDsSsGeNzpe2S
 deHpF8KwBDqHoJkuiD+RVKBTOEkHwyEt8D5zQ6PDsE/l0Tuog8MeuYY3FZuULlewa27k
 R6Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741756676; x=1742361476;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FKBJLiBMvTXU01UIUdx9mtjp99FG3zwnJ4eVDlAWpCk=;
 b=nEthQBmgZN8Wq8ychZNE8Ax6G9IoYtVrfeTmECMzVS2CFotAzMeudc5pNBEXUd4b0M
 I4QQVZByOjIAnFZksge6DQXi1z6KUmoNwRn53H1w/Re25JnVvyLZAHNYPAlwfTQAutIk
 jxSdMpLcQdeAr0HgeXyQynLiDV81WlWqQIcs+jRAM/nH0lYpbeI2QXpEx1dYttQNwx+i
 Svx2XOq3lBiIITqw37OlLIo6VLqjPZeq+ebftC9UIzJmJznpHa9Tsvpz3DaJ7ObJgw43
 ETfxtru2pxXf0jFZz7WhhmRNCtnbjwR8+nIgcuPn9SXe74k+YNekRfhnXdZNGX7OhmGj
 ypFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCULOafOfdzS8BVSCfQy/ksRNkeX5TqbB91fZ1H2rK7EvnC99PAWYTzj9XgGgcURNMRupob7deAUGjfE@nongnu.org
X-Gm-Message-State: AOJu0Yye+T1mHpCltMilK09EJDK7eKi6PjXwp6UT2ItfKETAH10yxa5W
 SsbdEmkQR+R/rXp6+INT5XZVjunYQO78DkLFS+4JVR+oxvf4V1PB
X-Gm-Gg: ASbGncvthig6vY+uRJTOrO/aDYTMZVGqj4JSF1jo/gd48BSu07z33z0wDyrZqZdoJPG
 GQ+Ko/0JnOs6eWBETXBpt/qRHXQnXb6BHkFXQQADFIrGverWOB+LNKvzJpgIkVEn5g73SfkMeP5
 ia8/vwj08x2sHBhFhb7uDCuy/DrUTpTTokGMjbZT6XbXKyshrlulsdldkexLWJ1XX9NGfC9HIl5
 noWvMwYPdpmO06Tkeaholr446OMw/KL1/asENqJzws8BKAgph5Z3sAxw2DjTQuGZYeT2PXSp4R5
 AKsEMjSThPr7LdLOPoMZXKtCKOJCz9rDuGhkU19ivqTyt2TwH50=
X-Google-Smtp-Source: AGHT+IEeo4ug4yqgVLwM9LJ5Z6wU27TfL7B32UK1A0Cf4hQ+QeLvTmk9c3+N3Ggiig9cVgG72EiOtw==
X-Received: by 2002:a17:902:e80a:b0:224:1074:63a0 with SMTP id
 d9443c01a7336-22428ab7313mr309492825ad.34.1741756676472; 
 Tue, 11 Mar 2025 22:17:56 -0700 (PDT)
Received: from wheely.local0.net ([118.208.151.101])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22410a925ddsm107557475ad.203.2025.03.11.22.17.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 22:17:56 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH 3/3] tests/functional/asset: Add AssetError exception class
Date: Wed, 12 Mar 2025 15:17:38 +1000
Message-ID: <20250312051739.938441-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250312051739.938441-1-npiggin@gmail.com>
References: <20250312051739.938441-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x629.google.com
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

Assets are uniquely identified by human-readable-ish url, so make an
AssetError exception class that prints url with error message.

A property 'transient' is used to capture whether the client may retry
or try again later, or if it is a serious and likely permanent error.
This is used to retain the existing behaviour of treating HTTP errors
other than 404 as 'transient' and not causing precache step to fail.
Additionally, partial-downloads and stale asset caches that fail to
resolve after the retry limit are now treated as transient and do not
cause precache step to fail.

For background: The NetBSD archive is, at the time of writing, failing
with short transfer. Retrying the fetch at that position (as wget does)
results in a "503 backend unavailable" error. We would like to get that
error code directly, but I have not found a way to do that with urllib,
so treating the short-copy as a transient failure covers that case (and
seems like a reasonable way to handle it in general).

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/functional/qemu_test/asset.py | 41 ++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 15 deletions(-)

diff --git a/tests/functional/qemu_test/asset.py b/tests/functional/qemu_test/asset.py
index d34e8f5e2ad..69b7a5ecb0e 100644
--- a/tests/functional/qemu_test/asset.py
+++ b/tests/functional/qemu_test/asset.py
@@ -17,6 +17,14 @@
 from shutil import copyfileobj
 from urllib.error import HTTPError
 
+class AssetError(Exception):
+    def __init__(self, asset, msg, transient=False):
+        self.url = asset.url
+        self.msg = msg
+        self.transient = transient
+
+    def __str__(self):
+        return "%s: %s" % (self.url, self.msg)
 
 # Instances of this class must be declared as class level variables
 # starting with a name "ASSET_". This enables the pre-caching logic
@@ -51,7 +59,7 @@ def _check(self, cache_file):
         elif len(self.hash) == 128:
             hl = hashlib.sha512()
         else:
-            raise Exception("unknown hash type")
+            raise AssetError(self, "unknown hash type")
 
         # Calculate the hash of the file:
         with open(cache_file, 'rb') as file:
@@ -111,14 +119,16 @@ def fetch(self):
             return str(self.cache_file)
 
         if not self.fetchable():
-            raise Exception("Asset cache is invalid and downloads disabled")
+            raise AssetError(self,
+                             "Asset cache is invalid and downloads disabled")
 
         self.log.info("Downloading %s to %s...", self.url, self.cache_file)
         tmp_cache_file = self.cache_file.with_suffix(".download")
 
         for retries in range(4):
             if retries == 3:
-                raise Exception("Retries exceeded downloading %s", self.url)
+                raise AssetError(self, "Download retries exceeded",
+                                 transient=True)
 
             try:
                 with tmp_cache_file.open("xb") as dst:
@@ -152,10 +162,17 @@ def fetch(self):
                                tmp_cache_file)
                 tmp_cache_file.unlink()
                 continue
+            except HTTPError as e:
+                tmp_cache_file.unlink()
+                # Treat 404 as fatal, since it is highly likely to
+                # indicate a broken test rather than a transient
+                # server or networking problem
+                raise AssetError(self, "Unable to download: "
+                                 "HTTP error %d" % e.code,
+                                 transient = e.code != 404)
             except Exception as e:
-                self.log.error("Unable to download %s: %s", self.url, e)
                 tmp_cache_file.unlink()
-                raise
+                raise AssetError(self, "Unable to download: " % e)
 
         try:
             # Set these just for informational purposes
@@ -169,8 +186,7 @@ def fetch(self):
 
         if not self._check(tmp_cache_file):
             tmp_cache_file.unlink()
-            raise Exception("Hash of %s does not match %s" %
-                            (self.url, self.hash))
+            raise AssetError(self, "Hash does not match %s" % self.hash)
         tmp_cache_file.replace(self.cache_file)
         # Remove write perms to stop tests accidentally modifying them
         os.chmod(self.cache_file, stat.S_IRUSR | stat.S_IRGRP)
@@ -192,15 +208,10 @@ def precache_test(test):
                 log.info("Attempting to cache '%s'" % asset)
                 try:
                     asset.fetch()
-                except HTTPError as e:
-                    # Treat 404 as fatal, since it is highly likely to
-                    # indicate a broken test rather than a transient
-                    # server or networking problem
-                    if e.code == 404:
+                except AssetError as e:
+                    if not e.transient:
                         raise
-
-                    log.debug(f"HTTP error {e.code} from {asset.url} " +
-                              "skipping asset precache")
+                    log.error("%s: skipping asset precache" % e)
 
         log.removeHandler(handler)
 
-- 
2.47.1


