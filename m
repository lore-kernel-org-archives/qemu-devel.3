Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDEB9C28B30
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 12:27:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsLAI-0001fQ-B4; Wed, 12 Mar 2025 08:26:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tsLAE-0001eZ-DG
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 08:26:22 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tsLAC-0001eY-Bl
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 08:26:22 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-224100e9a5cso125766205ad.2
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 05:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741782378; x=1742387178; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B0nfqgJ67/Ws3HeQSwOWQgrBH7dxTFcRp7xc72rc9Ls=;
 b=M5UL2FFtbkKXeorzkX7QUwjzvxnUREwYuWtAZdfDw8SERcoX7qOqzES3G60dlFiP6X
 g/BHMB8gW6NqeS/A+yirbNIhz2n0fpOV4va9tWixH5IZBk78Ov0eTP7xLv4/dF8ndlaG
 TfArW1FBNenr1K6A4dwpDhsoTDbN72ItwvKEJ4xIm4yubE4KFUTmjvhfAN70MV7SiuK7
 5runCupIizjTcbKBNsRKNEu8E/JYOEa7En0y2ghx9HKCxM0/DJUgj89no/zZLkjjIlqd
 yiDgKXqBzQC3hwlCSMl1Q1SwhBHc5/0aaPIYMSMGXyg2DIVKbXuVcXb6l8fD8h7QFeHy
 aUMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741782378; x=1742387178;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B0nfqgJ67/Ws3HeQSwOWQgrBH7dxTFcRp7xc72rc9Ls=;
 b=jDRyDLwLcJhKmP37icIsGuBre9o+6DX9Of5/cV5Gq7A4TXg3IWdBTsqxbvsZadP3zu
 eThYnCPLS5kq6+Bqo+obkeGPITz/EWSJQIPl8zwUFGEy2ficuPKbhexD7SoEsn8ZJp7R
 O9gP1wKW84D+dlsokvi1qKtHBCTZDZJinLJ750Ak45h5UBCzsZkRRZBkRrL07u2+/540
 rZyb1sFAQZGgmNfq1cvPeY1rc7sPrPtT734NHbHUqZu2ZTc+k/zxcfTSKVG3evz2x5Nx
 hMhy9A3iDbptVnsdrQlVBt9HbKSXeGE9REhPgiTJqMu3j+J/m++GGJ5P+s+l2ebZh20P
 nj+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVw5JCKcRgoyfWl7G7BfOiJkc2AWcW4w9EcLfpcS1tMxgvkMoJeCHcug/Uz988steHfVwvHP164dyd@nongnu.org
X-Gm-Message-State: AOJu0YxOmGw5v6VhtKavnWjqK1mLlb9hx2AmWC9SyFi3XGQCCWWESI2z
 RnKdpN2PEMf/EX23m9cOVdbjrygN9DBvYvMS55OKmldy6ZXFMOCTydcQ9g==
X-Gm-Gg: ASbGncvLb0exuw1y0xptCc7cs8lvyDrY4z/JsE0hHnMto9rEAvdOE8rzuaGPzMUhtbv
 rvctjgjT0ffhF0jPulDrq2pJqVmvgCRHBp1GVAJ8WmeJptVBoVlDq2/OahpgzzwpmTEi+nVOqt3
 MOGsZmdBoQp331fJBfkUJJBVI7UbrtG9EpJxhLFmE2t0YsWOTUhIot3bmAjCdzjirzRRJ0qGGbj
 dwl+YJCHPEhviFnE/Qx3xfm/iTrJlwFeUJGph1HFNtKd3s5chUrUfVsQLRPYyaYrs8Gs3KwIrSb
 QIxcLJY2rMFAB0os06My1JgnGq2w8I5UFjDQa51x3UJuuvYTcy4=
X-Google-Smtp-Source: AGHT+IHxcGnytqA/4fcavW4BXjDMt97/SdXvVg3UzbP0TqlXSaOCA5nCbISBRRcltZ+no0/Dq0cRqA==
X-Received: by 2002:a17:903:40cb:b0:223:44c5:4eb8 with SMTP id
 d9443c01a7336-22428c0752cmr338931355ad.32.1741782378072; 
 Wed, 12 Mar 2025 05:26:18 -0700 (PDT)
Received: from wheely.local0.net ([118.208.151.101])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736ab33e1d3sm10842408b3a.132.2025.03.12.05.26.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 05:26:17 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v2 3/3] tests/functional/asset: Add AssetError exception class
Date: Wed, 12 Mar 2025 22:25:58 +1000
Message-ID: <20250312122559.944533-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250312122559.944533-1-npiggin@gmail.com>
References: <20250312122559.944533-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62f.google.com
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

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 roms/skiboot                        |  2 +-
 tests/functional/qemu_test/asset.py | 43 +++++++++++++++++++----------
 tests/lcitool/libvirt-ci            |  2 +-
 3 files changed, 30 insertions(+), 17 deletions(-)

diff --git a/roms/skiboot b/roms/skiboot
index 24a7eb35966..785a5e3070a 160000
--- a/roms/skiboot
+++ b/roms/skiboot
@@ -1 +1 @@
-Subproject commit 24a7eb35966d93455520bc2debdd7954314b638b
+Subproject commit 785a5e3070a86e18521e62fe202b87209de30fa2
diff --git a/tests/functional/qemu_test/asset.py b/tests/functional/qemu_test/asset.py
index 6bbfb9e1cad..704b84d0ea6 100644
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
@@ -111,7 +119,8 @@ def fetch(self):
             return str(self.cache_file)
 
         if not self.fetchable():
-            raise Exception("Asset cache is invalid and downloads disabled")
+            raise AssetError(self,
+                             "Asset cache is invalid and downloads disabled")
 
         self.log.info("Downloading %s to %s...", self.url, self.cache_file)
         tmp_cache_file = self.cache_file.with_suffix(".download")
@@ -147,13 +156,23 @@ def fetch(self):
                                tmp_cache_file)
                 tmp_cache_file.unlink()
                 continue
+            except HTTPError as e:
+                tmp_cache_file.unlink()
+                self.log.error("Unable to download %s: HTTP error %d",
+                               self.url, e.code)
+                # Treat 404 as fatal, since it is highly likely to
+                # indicate a broken test rather than a transient
+                # server or networking problem
+                if e.code == 404:
+                    raise AssetError(self, "Unable to download: "
+                                     "HTTP error %d" % e.code)
+                continue
             except Exception as e:
-                self.log.error("Unable to download %s: %s", self.url, e)
                 tmp_cache_file.unlink()
-                raise
+                raise AssetError(self, "Unable to download: " % e)
 
         if not os.path.exists(tmp_cache_file):
-            raise Exception("Retries exceeded downloading %s", self.url)
+            raise AssetError(self, "Download retries exceeded", transient=True)
 
         try:
             # Set these just for informational purposes
@@ -167,8 +186,7 @@ def fetch(self):
 
         if not self._check(tmp_cache_file):
             tmp_cache_file.unlink()
-            raise Exception("Hash of %s does not match %s" %
-                            (self.url, self.hash))
+            raise AssetError(self, "Hash does not match %s" % self.hash)
         tmp_cache_file.replace(self.cache_file)
         # Remove write perms to stop tests accidentally modifying them
         os.chmod(self.cache_file, stat.S_IRUSR | stat.S_IRGRP)
@@ -190,15 +208,10 @@ def precache_test(test):
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
 
diff --git a/tests/lcitool/libvirt-ci b/tests/lcitool/libvirt-ci
index 18c4bfe02c4..b6a65806bc9 160000
--- a/tests/lcitool/libvirt-ci
+++ b/tests/lcitool/libvirt-ci
@@ -1 +1 @@
-Subproject commit 18c4bfe02c467e5639bf9a687139735ccd7a3fff
+Subproject commit b6a65806bc9b2b56985f5e97c936b77c7e7a99fc
-- 
2.47.1


