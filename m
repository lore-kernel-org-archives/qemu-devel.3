Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C65A6C021A0
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 01:55:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tikur-0006bx-A5; Thu, 13 Feb 2025 20:54:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1tikup-0006bg-OW
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 20:54:51 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1tikun-0004O6-T8
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 20:54:51 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-220d132f16dso22431955ad.0
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2025 17:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1739498088; x=1740102888;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vjFJmABBgiPrIkJaTy2ViAXPV7FmihtNfTlnacdhu6U=;
 b=Tut34dnT1dWMMyPKpxR95eGL/GgIs1htKckf+MIJL3V6PQ80hq5Hxe3b0CWhAeYQJT
 2OZMK8fk4rAZ374EcJ5dd948lZWLCdyhMb2BY32SiKGk9XVpcrRkRniHa7qnD5Ihf9Qp
 1Ilg9QJ9t8PSO5SwwRPdO52Sz7NSrGHovqXr77IEmsYUgnRK3O133Di+/o08drK+Gkqd
 dgBokBNdQkuJ6BLXvWiEQ2iKVbIZ+LS9FBz/YA4kCAq5MAgy6HZv7SQ6FcA2GXH2KcR8
 S0j0ilJk0IHF8z35ytyrrTj8j7hEHxiXbqTAvC84gvuquhKKfAkKzYloutd92Uk1x+7N
 mBmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739498088; x=1740102888;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vjFJmABBgiPrIkJaTy2ViAXPV7FmihtNfTlnacdhu6U=;
 b=vkQ0oQIBZluCZewMJSxXaUaIAPaNv2p9CHv3BxwiRtlkXSmQLqIWYPYKcJ2OyU9WGV
 nbpVSYyScfVYNuCkYDEe2FowazCBHscHp3crX+mwSdZ1L9HLSKqM7oCcLeUv/RdXGsjD
 6s92o95Rqb6e4VnqoqXktzuCupTBbO2cm4oH4/2vYnXmxu9DEj7IqV/kIu4ERaIKlKSN
 IfYJ9qW1CrnSxTa0F7XoJibqwVralW6RT0H7ld62Ky7tXxtZN5uoi6yjqFz2Lk6olonc
 nACL+xu1rSNoviMXTkf/7pdP7kEx5JirW9y2fx00SW4LoEuQYeWt24SJON6vFNzWa3Kf
 S2vw==
X-Gm-Message-State: AOJu0YxBW+o4PV6SxYKEYot7w/qpSQua5UwmFueGBrJlAo9yInnTcZbS
 THTtqdjEcZ9Fuv59u8aHaPW8PCAE3pqDw+H8Ygc2ic0ZAYGNTcx+YYLek+ygGpVfZnJVmvIPRXU
 0IS08amzh
X-Gm-Gg: ASbGncsWpdfFXJn7ajjRywpTuGI7dtkP+ZsYe72t2Ew/JXNilOqcg25pIOWvjSbaodD
 e7meDhQPjK9IP/9vp9g5ImEZmXA3vmk1qg3NB4O4VAcBGcHg6m9AplpRe8C2uqlNFAbjItg6r5l
 da5JESVDI2QSp3s7INKFCxDmlqefQZyXwa2o/ghbR5f719s6minhuSD7orOwzutQW2JyDCUUmq2
 cqEPVPXcp6vs6sjJ4znH7HHjaSO4rOk2Cn1uQME+1WVRkgJieVHBt5C0Dg1GcUgzDiIoFdq5gll
 0E5crkLOwtFead4LuLFUGhT4pyRL5cE6f+kagCAD
X-Google-Smtp-Source: AGHT+IG2wg4XgCJDXA1ppMwa9yxXz0MOFZMZx4A+4qieefAamZxr2fX9TBkPR/y2nRQHwT+jQVWIPQ==
X-Received: by 2002:a17:902:d2c9:b0:220:ee5e:6bb with SMTP id
 d9443c01a7336-220ee5e072fmr4595275ad.20.1739498088226; 
 Thu, 13 Feb 2025 17:54:48 -0800 (PST)
Received: from Hyman-Dev-Euler.zelin.local ([154.64.226.178])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d545d67fsm18831515ad.143.2025.02.13.17.54.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2025 17:54:47 -0800 (PST)
From: yong.huang@smartx.com
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Hyman Huang <yong.huang@smartx.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v4 3/4] guestperf: Introduce multifd compression option
Date: Fri, 14 Feb 2025 09:53:35 +0800
Message-Id: <c0e3313d81e8130f8119ef4f242e4625886278cf.1739497707.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1739497707.git.yong.huang@smartx.com>
References: <cover.1739497707.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=yong.huang@smartx.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Hyman Huang <yong.huang@smartx.com>

Guestperf tool does not cover the multifd compression option
currently, it is worth supporting so that developers can
analysis the migration performance with different
compression algorithms.

Multifd support 4 compression algorithms currently:
zlib, zstd, qpl, uadk

To request that multifd with the specified compression
algorithm such as zlib:
$ ./tests/migration-stress/guestperf.py \
    --multifd --multifd-channels 4 --multifd-compression zlib \
    --output output.json

To run the entire standardized set of multifd compression
comparisons, with unix migration:
$ ./tests/migration-stress/guestperf-batch.py \
    --dst-host localhost --transport unix \
    --filter compr-multifd-compression* --output outputdir

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/migration-stress/guestperf/comparison.py | 13 +++++++++++++
 tests/migration-stress/guestperf/engine.py     | 14 ++++++++++++++
 tests/migration-stress/guestperf/scenario.py   |  7 +++++--
 tests/migration-stress/guestperf/shell.py      |  3 +++
 4 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/tests/migration-stress/guestperf/comparison.py b/tests/migration-stress/guestperf/comparison.py
index 40e9d2eb1d..dee3ac25e4 100644
--- a/tests/migration-stress/guestperf/comparison.py
+++ b/tests/migration-stress/guestperf/comparison.py
@@ -158,4 +158,17 @@ def __init__(self, name, scenarios):
         Scenario("compr-dirty-limit-50MB",
                  dirty_limit=True, vcpu_dirty_limit=50),
     ]),
+
+    # Looking at effect of multifd with
+    # different compression algorithms
+    Comparison("compr-multifd-compression", scenarios = [
+        Scenario("compr-multifd-compression-zlib",
+                 multifd=True, multifd_channels=2, multifd_compression="zlib"),
+        Scenario("compr-multifd-compression-zstd",
+                 multifd=True, multifd_channels=2, multifd_compression="zstd"),
+        Scenario("compr-multifd-compression-qpl",
+                 multifd=True, multifd_channels=2, multifd_compression="qpl"),
+        Scenario("compr-multifd-compression-uadk",
+                 multifd=True, multifd_channels=2, multifd_compression="uadk"),
+    ]),
 ]
diff --git a/tests/migration-stress/guestperf/engine.py b/tests/migration-stress/guestperf/engine.py
index 4b15322e8d..e11f6a8496 100644
--- a/tests/migration-stress/guestperf/engine.py
+++ b/tests/migration-stress/guestperf/engine.py
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
diff --git a/tests/migration-stress/guestperf/scenario.py b/tests/migration-stress/guestperf/scenario.py
index 154c4f5d5f..4be7fafebf 100644
--- a/tests/migration-stress/guestperf/scenario.py
+++ b/tests/migration-stress/guestperf/scenario.py
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
diff --git a/tests/migration-stress/guestperf/shell.py b/tests/migration-stress/guestperf/shell.py
index 046afeb84e..63bbe3226c 100644
--- a/tests/migration-stress/guestperf/shell.py
+++ b/tests/migration-stress/guestperf/shell.py
@@ -131,6 +131,8 @@ def __init__(self):
                             action="store_true")
         parser.add_argument("--multifd-channels", dest="multifd_channels",
                             default=2, type=int)
+        parser.add_argument("--multifd-compression", dest="multifd_compression",
+                            default="")
 
         parser.add_argument("--dirty-limit", dest="dirty_limit", default=False,
                             action="store_true")
@@ -167,6 +169,7 @@ def get_scenario(self, args):
 
                         multifd=args.multifd,
                         multifd_channels=args.multifd_channels,
+                        multifd_compression=args.multifd_compression,
 
                         dirty_limit=args.dirty_limit,
                         x_vcpu_dirty_limit_period=\
-- 
2.27.0


