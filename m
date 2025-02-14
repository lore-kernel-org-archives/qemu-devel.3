Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BAA2C021A4
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 01:55:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tikun-0006bF-5u; Thu, 13 Feb 2025 20:54:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1tikul-0006aX-00
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 20:54:47 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1tikuj-0004NF-00
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 20:54:46 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-220d398bea9so21093085ad.3
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2025 17:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1739498083; x=1740102883;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NdqCgSxKf8rhz7PsW2KR1K7z/q/nMu6KnVnCzC9I9Hc=;
 b=kzPXP/K1+CdZlIC6hoGTRXeE7zW/j5t1zU+eACV7LmhUuMxkCgWSyvJdaqMumZfz7b
 IwRJy1JzJdJfBv5nbgj+ax2m0Cs+9RudAF/KSwvwE50HJ0+DBbsbI1jNsArmXISVZleF
 UXkF3gXHxCgRgvkSoyEhmXNdtdNEDMGHCc5i6PM1e+GCvaQ2LYleuAkvz9IE7kXVQdVU
 OIzMGTyr9LSd7vnpMuPZ8g184Ow/P//UwCpTcWuuoLCwk4E/hnnlfrG48Bh3U1cJQTru
 ITq1ZWYDp1UiCYZJWpj4Cy8UKUqupQ/JptsvinS7gHtwsZ1rfE5niqKHu1AOVJ3nYdPg
 m8Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739498083; x=1740102883;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NdqCgSxKf8rhz7PsW2KR1K7z/q/nMu6KnVnCzC9I9Hc=;
 b=rLBPWY9QvwlrHx2yq18qeJNdVzMDUJkWtn/lzBxApuM61M1QP0c4il8rQbAZPUcdgR
 LgI4+OifungEzZvHDSEodXaHLzI7xd9wFWR6MHSP2H3YntGBQ4F2fSijW/CNzJkLbmlJ
 mR0dJ2oRVxtiVvIwS3vmd2RI1HOk0c/4H1ePloyfdt+Lj4qCRp3npDSqBXjXA6MLpB/l
 PipWWd/cryf9QYiuiHAUedrzV64Jo/D10x3KmzqQgz6bESRRTCxhHl3agpkMgU+nxe7F
 G1ake0ySzqQZBnhlE76jkYdvcA5/X4jMnki70qb40QbTuFlu//CmO+XLwffQMZAivtYV
 oYug==
X-Gm-Message-State: AOJu0YyQh/JHZikghF51NsbkoJb/mqK2Qc52GHPfop6YJDsdiVxcpcQD
 sR12K6Mu2u3Iw65pyUuWUFbVZx8dop0BukD3XghP73StmN0yRvpd/9mW07q0y7BGM9JEeQ4GW6b
 AJUzpN2hq
X-Gm-Gg: ASbGnctgH/2toUdpPf+5knM9+T5aRsf1/Z+O+DuK/umVA8o42vBe3DrD7Ctt9j7EMIl
 ryGaSj8telQDzUzUGsNHiAg8QivI6y5nvlCZ5egTYhWDRr0RvfmMMrBawTiJb5kKbo9r7vhhdT8
 1ArsK4sUUbMmHl3JeYNwl/5jBmgZvgiCGe+ayrthDeC0Z1xdJOGhVSrjMbe4xGa/1T2rLNFsaQj
 ktfjEFSv7dKfk+6KIGxIkaMSEiUsPedJDsQD6BQm/YvlYKrw1e9FgwSxFH+zEgPS65MAXI8icza
 iLprOnqpYiv+aTQPLE9ill7g+3MnfFEc3+gfnZn6
X-Google-Smtp-Source: AGHT+IHV8wdPMGuQjFRK0boX5C7OVrhUUpz62b/tGTU0/evOQeUUbE0pzPKqderg0FdTnK91IJk64Q==
X-Received: by 2002:a17:903:18e:b0:220:ea90:191e with SMTP id
 d9443c01a7336-220ea901a6emr29415115ad.4.1739498082595; 
 Thu, 13 Feb 2025 17:54:42 -0800 (PST)
Received: from Hyman-Dev-Euler.zelin.local ([154.64.226.178])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d545d67fsm18831515ad.143.2025.02.13.17.54.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2025 17:54:42 -0800 (PST)
From: yong.huang@smartx.com
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Hyman Huang <yong.huang@smartx.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v4 1/4] guestperf: Support deferred migration for multifd
Date: Fri, 14 Feb 2025 09:53:33 +0800
Message-Id: <8874e170f890ce0bc6f25cb0d9b9ae307ce2e070.1739497707.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1739497707.git.yong.huang@smartx.com>
References: <cover.1739497707.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=yong.huang@smartx.com; helo=mail-pl1-x629.google.com
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


