Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15932D3DEA4
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 18:26:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1rfG-0005RC-MB; Fri, 18 Oct 2024 14:25:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1t1rfE-0005Qk-Gk
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 14:25:29 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1t1rfC-00020H-IR
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 14:25:28 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-208cf673b8dso25381985ad.3
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2024 11:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1729275925; x=1729880725;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SP7lJo4YH4pDm5n05L8kP6pYJyaFJ601AndjXi5kl1A=;
 b=J+ZU2wrmrV21xsmXScvSm1HMCH75v+seVe3QvGp1fcIUShT+Zj99jHxQwPa5ysYzuv
 PuoDDBt4CMHVWiM7qQu6iCcLOxu5qkFnSrJWbQw7b2pNrMKhMJYcdgoiZabjmA+U7eTW
 Ydv93XvZPqy81qgyHHb9tv1hZyYE7LG2CyZE7WL8jP348dC7CUqQ5g/NCFzUNI5QDzz9
 CLF0Z28fea4q3n1z5IuPZdMcQS0+lYywYC2o411C7dZfQcscP91UGHBalo0b886Lr+eU
 Cc+EOfZO1pyekE+qVqP+tglfQBp5ukeepxP7fDmXbrKE/velhaFDRZ8vvxgB9qijnWTp
 tODQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729275925; x=1729880725;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SP7lJo4YH4pDm5n05L8kP6pYJyaFJ601AndjXi5kl1A=;
 b=l5MyzBcJJPuxWdugX3lvPHKrzM2RN50oOnzcEEGe5zfsJoCj6MULywV74LyNr7Lqpt
 4w7rWRHLSoSlBfwroa53h+49a2lx395GVr782cduCHbMbcmJMlV3SEloC3+Dpg78bZ8A
 w3v9UlJIWN4P1nbgUz7v89WPDHgfL63q4RLmjCqivR1mGoct4mNuhTaAulAPSmGmREda
 CyCplTU2cP3cb9iOMBA/cn1wir7onqmgBAqzVGxYFgce62bvlToyV6ve7sEDv11Ew2rg
 xLMIcTESOFSNeroHDmBmyDYnUH3poGmeOIlgLKapsb0rMtmhQ+UZK78jN+QVeLDNag90
 CLvg==
X-Gm-Message-State: AOJu0YzNnenI6eEdqBDvFuxrl/MoxylLqWp/LQoUMN+EQUKGuC829Fj6
 n7qXJkZBhEWGwcQ4Krn+s483ejuNJXuvuVo17ytY4F4BMkJ9x8GLpAEHvFtmZWzXB7q4Ceb7Pad
 4U/73Sw==
X-Google-Smtp-Source: AGHT+IFHi/2CQT6h5npef1G4Jzx0utpPRqUSW1PI2lE5zR+kh4bQJwzv1sDppg61xLVc9wyHZGb3Ig==
X-Received: by 2002:a17:903:1d0:b0:20c:7d29:7281 with SMTP id
 d9443c01a7336-20e5a925f5cmr34834635ad.52.1729275924287; 
 Fri, 18 Oct 2024 11:25:24 -0700 (PDT)
Received: from localhost.localdomain ([118.114.60.204])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20e5a8f2034sm15668475ad.193.2024.10.18.11.25.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2024 11:25:24 -0700 (PDT)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 yong.huang@smartx.com
Subject: [PATCH v2 5/5] guestperf: Introduce multifd compression option
Date: Sat, 19 Oct 2024 02:25:07 +0800
Message-Id: <da2ae99301e701b1c6fff3e9df3ddfbf62d240f8.1729275266.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1729275266.git.yong.huang@smartx.com>
References: <cover.1729275266.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=yong.huang@smartx.com; helo=mail-pl1-x634.google.com
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
index 40e9d2eb1d..dee3ac25e4 100644
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
+                 multifd=True, multifd_channels=2, multifd_compression="zlib"),
+        Scenario("compr-multifd-compression-zstd",
+                 multifd=True, multifd_channels=2, multifd_compression="zstd"),
+        Scenario("compr-multifd-compression-qpl",
+                 multifd=True, multifd_channels=2, multifd_compression="qpl"),
+        Scenario("compr-multifd-compression-uadk",
+                 multifd=True, multifd_channels=2, multifd_compression="uadk"),
+    ]),
 ]
diff --git a/scripts/migration/guestperf/engine.py b/scripts/migration/guestperf/engine.py
index 4b15322e8d..e11f6a8496 100644
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
2.39.1


