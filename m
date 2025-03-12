Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 229C2C28B2F
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 13:01:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsLhN-0002k2-Kt; Wed, 12 Mar 2025 09:00:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tsLhI-0002ig-Il
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 09:00:32 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tsLhF-0006Tl-MT
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 09:00:31 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-225b5448519so5668015ad.0
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 06:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741784428; x=1742389228; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=efKsAuHsEC3n3nWPeW8PU/lQXIw7WCfr+JQ3xOUouNk=;
 b=KAvsn7Gjmj1Cr0bRLBUq4/UCUgHZCpX9EugWZfKXwBw3rTegu6tUwPXzKXhIa/Zuq0
 oiok7Ins1QuOmyT79AL+PK+yuxU1g/6sT3GdoxMD+nOTnhBpFlljoyzdu0uHy0zc7BtU
 TB3hVAf8+Ymel24IsEIvByt43FfrHbohSS3+Q4DE0aIRul7vCj1vyCXefkn7h+YXm+4h
 nuYDDroC5iSVQIJmzZAIR9NA98o1EaGKY3IGM60KwD1hIQWnz5Ne57wi4cF235LuVWJ4
 wqCpnLRKEKDPaZIMofRiFeODgGb8H1GG3pEG2dg695zV0h5uxYw57HZIHMksDBDLGtj3
 MJXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741784428; x=1742389228;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=efKsAuHsEC3n3nWPeW8PU/lQXIw7WCfr+JQ3xOUouNk=;
 b=qwb/YW2eINEPnpPOXPEdAxbqWa6ATzaE3PpStHjobOnDBiSRe5X/jlW9V2N3DPneLy
 qAVUx7e9RD424+6mOAXm6cyYjVrZ0a8XN9/koJQpae8IgkfuJ/XZXfa5HbwpgLCldJxG
 0X+3kwNuQSwoE/Ohh+olE5vh25wPksax1GZRBS5LBuXIY94R2Aphejy3aavvfMmhPy1X
 EAAIHkF1Xnq02NPCNCbre0WsxPviwiUsadEwL0OZd4ERmOn0NW/w5lKEihpVQV0DlHFH
 IIZXXqGOz5iqOTEFJlVybZPJGZzBHSk0ctPlqWofROOcn7Y9mB/1vMR9BmeNatSnkCJd
 wzHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFKIyFVVqAVg3ApvHDv/qt4k5EM5DMk63Ja2OOOAzRQKDg9ux/UUg8HPULv5NPQ3VRHNtw8VBBJtrm@nongnu.org
X-Gm-Message-State: AOJu0YzRFqCljk36Nr4T/40DdysxQl3hGFKYDBPmUyRG+r9vorJI4JRz
 3RnYZEomo2P5fXRAj8TW+DjxgqETrmll89bgCXYeWw1EAR5PYTD5
X-Gm-Gg: ASbGncvagA1fFmh5Xu3ugjD3CxTOCgO6T9CClHUV28gyUosFYutz95RqZIxYmQwwnjx
 oWyZH6U9GwFEPOKvGyy2ID9xTTxqODzsg3DTNfuKz3V78xaHDL1NbYILub4uNX7gguTZUNGJXAD
 HqUWgC7jkFK1+fR8rv/uLk7HoCiPZpO+gx5XjjRLVPG0JuLqZJgIyKKXvqW1NZQDSYFmlxXj3uH
 ZQUO2OGmoWrOwteLLp2tbDCl0l3ZyCh4G7mzsY9ZUiqZIOxFTI5fSq0JrGvcyqIT049r6naRfXR
 XSzlI4IC/LlCOrQi4AyMyml7vfXI9ttZmXspq5SZUBBSUEfGhZA=
X-Google-Smtp-Source: AGHT+IHXyOmASSIHQ8tU9bICWHFBVFfRAZZKWnIkOze8wsdxCsLIdq4qml/oFUpZBUCz7+KjUa/P9Q==
X-Received: by 2002:a05:6a00:218f:b0:736:3c77:31fd with SMTP id
 d2e1a72fcca58-736aab0eeabmr29976864b3a.23.1741784427395; 
 Wed, 12 Mar 2025 06:00:27 -0700 (PDT)
Received: from wheely.local0.net ([118.208.151.101])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736bee078fasm8868407b3a.139.2025.03.12.06.00.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 06:00:26 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v3 3/3] tests/functional/asset: Add AssetError exception class
Date: Wed, 12 Mar 2025 23:00:02 +1000
Message-ID: <20250312130002.945508-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250312130002.945508-1-npiggin@gmail.com>
References: <20250312130002.945508-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/functional/qemu_test/asset.py | 43 +++++++++++++++++++----------
 1 file changed, 28 insertions(+), 15 deletions(-)

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
 
-- 
2.47.1


