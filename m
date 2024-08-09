Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F10BBC52D7F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2024 07:47:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scKKI-0003Jo-AF; Fri, 09 Aug 2024 03:46:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1scKKG-0003Di-P2
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 03:46:16 -0400
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1scKKE-0002wV-Vp
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 03:46:16 -0400
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-2681941eae0so1138760fac.0
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2024 00:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1723189453; x=1723794253;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PlG0m1x7ya8hrxKmBgQuKNFRBggj2AEemAM32YMHYUM=;
 b=lQmcftGEUK1JmJFH8GpEmmZPOPQxwzQ9Iap2/SoY2AufD93WygfkZERa7WCG0Vc8S3
 Df2bJrDkjOSlcqkJ+lpvJPgy0AbaJ0UfQmthP+gpzkFwnwQwOaeIsBx+s7OLCUmoNVT3
 KedH3X54pUERRZvets9tlX34vUV6BjkgfRa5jNGKZaQK3FA+OrlXk277qE+vyP36Yw1u
 khkiplZPaxsn2G3OdAFCgv4LSSvIBsYUYtv6WlxE//9NOp4rv1CWhc54Dob0CSznOrTa
 V2eYFFBCWO08QSUqMH6w79V5VkKjxBS5CBsrQyu32S/NgXpuN9Fvj5AwD4Knm/LSqLis
 bKGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723189453; x=1723794253;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PlG0m1x7ya8hrxKmBgQuKNFRBggj2AEemAM32YMHYUM=;
 b=DnIsXMuabNJYAZDtFVFQZn8NIYV+8cFu9DrNZ0PY1V9OCckIrOokHjBdqamyC82+m5
 bUs7/ii1JxOvX6kCAUg8pMC8xbbdpmUKbXQpgiEbNdRcmP6GHMoxMlXk4n6KbfgWdmd6
 Ca5r/1BJtnwud6jEnRv4//WnG5MLZrRC6t6U5A5AtF7Z0CwyEYOlFm9XnqCHslhyMWNT
 zKDZeirIiK2Dzm2bQMW1a0To6jzQTYjWG+EvTLGWjnC1paVtSggolFsli5SQcGsWsfXP
 eRyRb2lm5cP1FbyzGkR4DHpTjqIat8et/07MS+r/zxRZhMp//v6Uyz1bFgEnJf933yZK
 ESwA==
X-Gm-Message-State: AOJu0Yw02O7maEPvKLisIn88ThBlUKz4P1S3VbuFtHJrZZwGb1ppAdxk
 I9Kfu4fN2cup7habaBP21tU2G2iIV1xs5oYlqUTQHQ1hDp0GeBXZZ0Z8Fr1rcyf8uLw/XwSAG5a
 vcopLaw==
X-Google-Smtp-Source: AGHT+IEAEzO8Vtnui71+5ahQDWUecs1pXgNrC+I2Vj8V6JpxtABLc3kj/7Tek/lnIFuPzp4AoX7h4g==
X-Received: by 2002:a05:6870:ec88:b0:260:f75c:c28b with SMTP id
 586e51a60fabf-26c62c14084mr848584fac.8.1723189452846; 
 Fri, 09 Aug 2024 00:44:12 -0700 (PDT)
Received: from Hyman-Dev-Euler.zelin.local ([85.208.104.155])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-710cb22a455sm2123212b3a.71.2024.08.09.00.44.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Aug 2024 00:44:12 -0700 (PDT)
From: yong.huang@smartx.com
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 yong.huang@smartx.com
Subject: [PATCH v1 5/5] guestperf: Introduce multifd compression option
Date: Fri,  9 Aug 2024 15:43:36 +0800
Message-Id: <9b17f5772ec14db0a43e03112130e588433ae68d.1723189080.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1723189080.git.yong.huang@smartx.com>
References: <cover.1723189080.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2001:4860:4864:20::2a;
 envelope-from=yong.huang@smartx.com; helo=mail-oa1-x2a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

From: Hyman Huang <yong.huang@smartx.com>

Guestperf tool does not cover the multifd compression option
currently, it is worth supporting so that developers can
analysis the migration performance with different
compression algorithms.

Multifd support 4 compression algorithms currently:
zlib, zstd, qpl, uadk

To request that multifd with the specified compression
algorithm such as zlib:
$ ./scripts/migration/guestperf.py \
    --multifd --multifd-channels 4 --multifd-compression zlib \
    --output output.json

To run the entire standardized set of multifd compression
comparisons, with unix migration:
$ ./scripts/migration/guestperf-batch.py \
    --dst-host localhost --transport unix \
    --filter compr-multifd-compression* --output outputdir

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
---
 scripts/migration/guestperf/comparison.py | 13 +++++++++++++
 scripts/migration/guestperf/engine.py     | 14 ++++++++++++++
 scripts/migration/guestperf/scenario.py   |  7 +++++--
 scripts/migration/guestperf/shell.py      |  3 +++
 4 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/scripts/migration/guestperf/comparison.py b/scripts/migration/guestperf/comparison.py
index 40e9d2eb1d..e209a68ce5 100644
--- a/scripts/migration/guestperf/comparison.py
+++ b/scripts/migration/guestperf/comparison.py
@@ -158,4 +158,17 @@ def __init__(self, name, scenarios):
         Scenario("compr-dirty-limit-50MB",
                  dirty_limit=True, vcpu_dirty_limit=50),
     ]),
+
+    # Looking at effect of multifd with
+    # different compression algorithms
+    Comparison("compr-multifd-compression", scenarios = [
+        Scenario("compr-multifd-compression-zlib",
+                 multifd=True, multifd_channels=4, multifd_compression="zlib"),
+        Scenario("compr-multifd-compression-zstd",
+                 multifd=True, multifd_channels=4, multifd_compression="zstd"),
+        Scenario("compr-multifd-compression-qpl",
+                 multifd=True, multifd_channels=4, multifd_compression="qpl"),
+        Scenario("compr-multifd-compression-uadk",
+                 multifd=True, multifd_channels=4, multifd_compression="uadk"),
+    ]),
 ]
diff --git a/scripts/migration/guestperf/engine.py b/scripts/migration/guestperf/engine.py
index 4cddd05a9d..59e77edb72 100644
--- a/scripts/migration/guestperf/engine.py
+++ b/scripts/migration/guestperf/engine.py
@@ -31,6 +31,8 @@
                              '..', '..', '..', 'python'))
 from qemu.machine import QEMUMachine
 
+# multifd supported compression algorithms
+MULTIFD_CMP_ALGS = ("zlib", "zstd", "qpl", "uadk")
 
 class Engine(object):
 
@@ -191,6 +193,12 @@ def _migrate(self, hardware, scenario, src,
                                scenario._compression_xbzrle_cache))
 
         if scenario._multifd:
+            if (scenario._multifd_compression and
+                (scenario._multifd_compression not in MULTIFD_CMP_ALGS)):
+                    raise Exception("unsupported multifd compression "
+                                    "algorithm: %s" %
+                                    scenario._multifd_compression)
+
             resp = src.cmd("migrate-set-capabilities",
                            capabilities = [
                                { "capability": "multifd",
@@ -206,6 +214,12 @@ def _migrate(self, hardware, scenario, src,
             resp = dst.cmd("migrate-set-parameters",
                            multifd_channels=scenario._multifd_channels)
 
+            if scenario._multifd_compression:
+                resp = src.cmd("migrate-set-parameters",
+                    multifd_compression=scenario._multifd_compression)
+                resp = dst.cmd("migrate-set-parameters",
+                    multifd_compression=scenario._multifd_compression)
+
         if scenario._dirty_limit:
             if not hardware._dirty_ring_size:
                 raise Exception("dirty ring size must be configured when "
diff --git a/scripts/migration/guestperf/scenario.py b/scripts/migration/guestperf/scenario.py
index 154c4f5d5f..4be7fafebf 100644
--- a/scripts/migration/guestperf/scenario.py
+++ b/scripts/migration/guestperf/scenario.py
@@ -30,7 +30,7 @@ def __init__(self, name,
                  auto_converge=False, auto_converge_step=10,
                  compression_mt=False, compression_mt_threads=1,
                  compression_xbzrle=False, compression_xbzrle_cache=10,
-                 multifd=False, multifd_channels=2,
+                 multifd=False, multifd_channels=2, multifd_compression="",
                  dirty_limit=False, x_vcpu_dirty_limit_period=500,
                  vcpu_dirty_limit=1):
 
@@ -61,6 +61,7 @@ def __init__(self, name,
 
         self._multifd = multifd
         self._multifd_channels = multifd_channels
+        self._multifd_compression = multifd_compression
 
         self._dirty_limit = dirty_limit
         self._x_vcpu_dirty_limit_period = x_vcpu_dirty_limit_period
@@ -85,6 +86,7 @@ def serialize(self):
             "compression_xbzrle_cache": self._compression_xbzrle_cache,
             "multifd": self._multifd,
             "multifd_channels": self._multifd_channels,
+            "multifd_compression": self._multifd_compression,
             "dirty_limit": self._dirty_limit,
             "x_vcpu_dirty_limit_period": self._x_vcpu_dirty_limit_period,
             "vcpu_dirty_limit": self._vcpu_dirty_limit,
@@ -109,4 +111,5 @@ def deserialize(cls, data):
             data["compression_xbzrle"],
             data["compression_xbzrle_cache"],
             data["multifd"],
-            data["multifd_channels"])
+            data["multifd_channels"],
+            data["multifd_compression"])
diff --git a/scripts/migration/guestperf/shell.py b/scripts/migration/guestperf/shell.py
index c85d89efec..1452eb8a33 100644
--- a/scripts/migration/guestperf/shell.py
+++ b/scripts/migration/guestperf/shell.py
@@ -130,6 +130,8 @@ def __init__(self):
                             action="store_true")
         parser.add_argument("--multifd-channels", dest="multifd_channels",
                             default=2, type=int)
+        parser.add_argument("--multifd-compression", dest="multifd_compression",
+                            default="")
 
         parser.add_argument("--dirty-limit", dest="dirty_limit", default=False,
                             action="store_true")
@@ -166,6 +168,7 @@ def get_scenario(self, args):
 
                         multifd=args.multifd,
                         multifd_channels=args.multifd_channels,
+                        multifd_compression=args.multifd_compression,
 
                         dirty_limit=args.dirty_limit,
                         x_vcpu_dirty_limit_period=\
-- 
2.11.0


