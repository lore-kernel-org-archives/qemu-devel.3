Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D7C6C021A6
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 10:57:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1titN9-0003E4-1w; Fri, 14 Feb 2025 05:56:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1titN6-0003DX-RP
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 05:56:36 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1titN4-00068W-RV
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 05:56:36 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-21f44e7eae4so34818815ad.2
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2025 02:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1739530593; x=1740135393;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NdqCgSxKf8rhz7PsW2KR1K7z/q/nMu6KnVnCzC9I9Hc=;
 b=0h5fHFL2NTEbTpDQ6Sy8U2+QfzrqeCkpHgupoykV7nJT48Q52vj5Ps2Ui3Ux39INXR
 L6/Tj1sY1qSo8pzIXOj11uFGs9Vpi9JvtmLswVdp5XGH2P4zb03cP4YGEDyFtXqKO5mQ
 +FDfshzy19HxcUBB27mZSGSHGkrKRH5m57G0JzsOJUL9S5G2smrvKXS7wv8AnwnKFLZU
 rlOYB8a46Ul2FPfhkN3UyHXDRa23yUxfb9/nqSrq996LMznZYdQFlLV3IbVZbR/mpmeG
 EG5my7HdzFrxrKQ/kmql4Se0ocd541i87V7CImlNED9JJ+9LcvSy60d/RmE6yDAAkJrn
 sZmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739530593; x=1740135393;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NdqCgSxKf8rhz7PsW2KR1K7z/q/nMu6KnVnCzC9I9Hc=;
 b=MACpCXqB3ggpvdImzqvbOgbLyB2KS0nE3Frr+ND38jrT1HD/xSEDIdzfOOCHjA2/aA
 u1oJvbVtLrjve65JMUoskaJvRwoHTlG/MYwHMHlPZ4Uvzu0C5veHinKwvpzl97ScCTnI
 4tr0dSu6W1MLO/U9+NJQrL0kui5WigvBfnV/4xg/pVkSVipKf6NQdeTb+uzmHPVixPmR
 zXm0P/PbZflfJbzS8YM/V1Lhu2Ay7HrE5mgXkWEg0pLoT4vFvIO9+ypGVrNNKcI8BVa1
 xl2CSgwmACRlXFzOhUv0OpiBjPeHn/EeV7I2UoBHiNHPnqgLCazCarSAw7wN19FTe+KS
 Yl8w==
X-Gm-Message-State: AOJu0YxHrMmYaNUifFkjtddxziXV41/mgIpDw/dP00btkvd5PXx96rp0
 gP4hjx3jY7zuhilOJDoSXue41MX8UC/jXfvten7Rw82lq4hl/pEsXKoW0G+iwBoyoIUyaiRAjjP
 hplSMpA==
X-Gm-Gg: ASbGncs17lCPPZ5LEIFvmIsqtPvWsKu1OaUX/WFFXL1QeCeO6hPrWgsTYu9ile4/hig
 I9XCaKJ9FtA6j8aHHbFiU51dM0Z+FS0Gktl28g1/zhnqVCLi5VaUZk50dM0hIT/UARJSrD8i795
 WfV90uJ1uKiNnDwN5TmmKm3/pcj3Zcp/DOsaruCj1P2tNYJE6GkidBlQjHTLW8woW/L6CGLWeIY
 gaSseI1DDoL5Z8dmsZMkvDJvihI1ZVWP15bUiRckuAWSr7KMLWFW6nFY+1NbjxscKmQ4Hq3fEtH
 o+9d5G+kzClNn4XKGKM5uzp47/ClubjzbSTVY9yc
X-Google-Smtp-Source: AGHT+IG8BBCkWsF6u7/siO/pU4kjF/ijJMM9KsWubkiYVSA8VLcihFs4+/1/Ucwv+0jrq4MRmNNJ+Q==
X-Received: by 2002:a05:6a20:1604:b0:1ee:7ddf:f40c with SMTP id
 adf61e73a8af0-1ee7ddff695mr4824398637.11.1739530592907; 
 Fri, 14 Feb 2025 02:56:32 -0800 (PST)
Received: from Hyman-Dev-Euler.zelin.local ([154.64.226.178])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-add0987b223sm535013a12.17.2025.02.14.02.56.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2025 02:56:32 -0800 (PST)
From: yong.huang@smartx.com
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Hyman Huang <yong.huang@smartx.com>
Subject: [PATCH v4 RESEND 1/4] guestperf: Support deferred migration for
 multifd
Date: Fri, 14 Feb 2025 18:55:23 +0800
Message-Id: <8874e170f890ce0bc6f25cb0d9b9ae307ce2e070.1739530098.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1739530098.git.yong.huang@smartx.com>
References: <cover.1739530098.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=yong.huang@smartx.com; helo=mail-pl1-x62c.google.com
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

The way to enable multifd migration has been changed by commit,
82137e6c8c (migration: enforce multifd and postcopy preempt to
be set before incoming), and guestperf has not made the
necessary changes. If multifd migration had been enabled in the
previous manner, the following error would have occurred:
Multifd must be set before incoming starts

Supporting deferred migration will fix it.

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/migration-stress/guestperf/engine.py | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/tests/migration-stress/guestperf/engine.py b/tests/migration-stress/guestperf/engine.py
index 608d7270f6..4b15322e8d 100644
--- a/tests/migration-stress/guestperf/engine.py
+++ b/tests/migration-stress/guestperf/engine.py
@@ -106,7 +106,8 @@ def _migrate_progress(self, vm):
             info.get("dirty-limit-ring-full-time", 0),
         )
 
-    def _migrate(self, hardware, scenario, src, dst, connect_uri):
+    def _migrate(self, hardware, scenario, src,
+                 dst, connect_uri, defer_migrate):
         src_qemu_time = []
         src_vcpu_time = []
         src_pid = src.get_pid()
@@ -220,6 +221,8 @@ def _migrate(self, hardware, scenario, src, dst, connect_uri):
             resp = src.cmd("migrate-set-parameters",
                            vcpu_dirty_limit=scenario._vcpu_dirty_limit)
 
+        if defer_migrate:
+            resp = dst.cmd("migrate-incoming", uri=connect_uri)
         resp = src.cmd("migrate", uri=connect_uri)
 
         post_copy = False
@@ -373,11 +376,14 @@ def _get_common_args(self, hardware, tunnelled=False):
     def _get_src_args(self, hardware):
         return self._get_common_args(hardware)
 
-    def _get_dst_args(self, hardware, uri):
+    def _get_dst_args(self, hardware, uri, defer_migrate):
         tunnelled = False
         if self._dst_host != "localhost":
             tunnelled = True
         argv = self._get_common_args(hardware, tunnelled)
+
+        if defer_migrate:
+            return argv + ["-incoming", "defer"]
         return argv + ["-incoming", uri]
 
     @staticmethod
@@ -424,6 +430,7 @@ def _get_timings(self, vm):
 
     def run(self, hardware, scenario, result_dir=os.getcwd()):
         abs_result_dir = os.path.join(result_dir, scenario._name)
+        defer_migrate = False
 
         if self._transport == "tcp":
             uri = "tcp:%s:9000" % self._dst_host
@@ -439,6 +446,9 @@ def run(self, hardware, scenario, result_dir=os.getcwd()):
             except:
                 pass
 
+        if scenario._multifd:
+            defer_migrate = True
+
         if self._dst_host != "localhost":
             dstmonaddr = ("localhost", 9001)
         else:
@@ -452,7 +462,7 @@ def run(self, hardware, scenario, result_dir=os.getcwd()):
                           monitor_address=srcmonaddr)
 
         dst = QEMUMachine(self._binary,
-                          args=self._get_dst_args(hardware, uri),
+                          args=self._get_dst_args(hardware, uri, defer_migrate),
                           wrapper=self._get_dst_wrapper(hardware),
                           name="qemu-dst-%d" % os.getpid(),
                           monitor_address=dstmonaddr)
@@ -461,7 +471,8 @@ def run(self, hardware, scenario, result_dir=os.getcwd()):
             src.launch()
             dst.launch()
 
-            ret = self._migrate(hardware, scenario, src, dst, uri)
+            ret = self._migrate(hardware, scenario, src,
+                                dst, uri, defer_migrate)
             progress_history = ret[0]
             qemu_timings = ret[1]
             vcpu_timings = ret[2]
-- 
2.27.0


