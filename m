Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70958FF8864
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 06:22:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHyJ4-0004pj-5T; Wed, 29 Apr 2026 02:21:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1wHyHz-0004Xq-Li; Wed, 29 Apr 2026 02:20:51 -0400
Received: from out30-118.freemail.mail.aliyun.com ([115.124.30.118])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1wHyHv-00078Y-EO; Wed, 29 Apr 2026 02:20:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1777443637; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=7BNMZsf0OZfChDgYsNAXBHtNNdE/HIiReKu3r1PFxt0=;
 b=OVbluQTkoFojZVXSiYms0TDXuBcuZCZIMO04xuYsF+uB+Pnp2nPxivUPpRicP/vP6eyhBXcfoHwV5q+mosPSjBoTuLk85TvPqyRL37mNlp/WkHYOpCfzdVT3yTnJuWTF3tBAjEx5FUNUhLnD+OCoSWdqpCFGo+RlmRygmolA4kE=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R171e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037033178;
 MF=guobin@linux.alibaba.com; NM=1; PH=DS; RN=6; SR=0;
 TI=SMTPD_---0X1wgCi6_1777443629; 
Received: from localhost(mailfrom:guobin@linux.alibaba.com
 fp:SMTPD_---0X1wgCi6_1777443629 cluster:ay36) by smtp.aliyun-inc.com;
 Wed, 29 Apr 2026 14:20:36 +0800
From: Bin Guo <guobin@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, berrange@redhat.com, kwolf@redhat.com,
 hreitz@redhat.com, qemu-block@nongnu.org
Subject: [PATCH 3/3] system/vl.c: inline qemu_opts_parse_noisily() result
 checks
Date: Wed, 29 Apr 2026 14:20:04 +0800
Message-ID: <20260429062004.36582-4-guobin@linux.alibaba.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260429062004.36582-1-guobin@linux.alibaba.com>
References: <20260429062004.36582-1-guobin@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.118;
 envelope-from=guobin@linux.alibaba.com;
 helo=out30-118.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

In qemu_init()'s option parsing switch, several cases assigned the
return value of qemu_opts_parse_noisily() to the shared 'opts'
variable solely to check for NULL, without using the pointer
afterwards.  Inline the call directly into the if-condition, matching
the style already used by QEMU_OPTION_action.

This affects the following options:
  -drive, -numa, -iscsi, -m, -mon, -chardev, -fsdev, -fwcfg

Cases where the returned QemuOpts* is subsequently used (e.g.
-acpitable, -smbios, -virtfs) are left unchanged.

Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
---
 system/vl.c | 37 +++++++++++++++----------------------
 1 file changed, 15 insertions(+), 22 deletions(-)

diff --git a/system/vl.c b/system/vl.c
index 0e1fc217b4..0e0d3cb761 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -2961,9 +2961,8 @@ void qemu_init(int argc, char **argv)
                     break;
                 }
             case QEMU_OPTION_drive:
-                opts = qemu_opts_parse_noisily(qemu_find_opts("drive"),
-                                               optarg, false);
-                if (opts == NULL) {
+                if (!qemu_opts_parse_noisily(qemu_find_opts("drive"),
+                                             optarg, false)) {
                     exit(1);
                 }
                 break;
@@ -2988,9 +2987,8 @@ void qemu_init(int argc, char **argv)
                 replay_add_blocker("-snapshot");
                 break;
             case QEMU_OPTION_numa:
-                opts = qemu_opts_parse_noisily(qemu_find_opts("numa"),
-                                               optarg, true);
-                if (!opts) {
+                if (!qemu_opts_parse_noisily(qemu_find_opts("numa"),
+                                             optarg, true)) {
                     exit(1);
                 }
                 break;
@@ -3049,9 +3047,8 @@ void qemu_init(int argc, char **argv)
                 break;
 #ifdef CONFIG_LIBISCSI
             case QEMU_OPTION_iscsi:
-                opts = qemu_opts_parse_noisily(qemu_find_opts("iscsi"),
-                                               optarg, false);
-                if (!opts) {
+                if (!qemu_opts_parse_noisily(qemu_find_opts("iscsi"),
+                                             optarg, false)) {
                     exit(1);
                 }
                 break;
@@ -3104,8 +3101,8 @@ void qemu_init(int argc, char **argv)
                 exit(0);
                 break;
             case QEMU_OPTION_m:
-                opts = qemu_opts_parse_noisily(qemu_find_opts("memory"), optarg, true);
-                if (opts == NULL) {
+                if (!qemu_opts_parse_noisily(qemu_find_opts("memory"),
+                                             optarg, true)) {
                     exit(1);
                 }
                 break;
@@ -3226,17 +3223,15 @@ void qemu_init(int argc, char **argv)
                 default_monitor = 0;
                 break;
             case QEMU_OPTION_mon:
-                opts = qemu_opts_parse_noisily(qemu_find_opts("mon"), optarg,
-                                               true);
-                if (!opts) {
+                if (!qemu_opts_parse_noisily(qemu_find_opts("mon"), optarg,
+                                             true)) {
                     exit(1);
                 }
                 default_monitor = 0;
                 break;
             case QEMU_OPTION_chardev:
-                opts = qemu_opts_parse_noisily(qemu_find_opts("chardev"),
-                                               optarg, true);
-                if (!opts) {
+                if (!qemu_opts_parse_noisily(qemu_find_opts("chardev"),
+                                             optarg, true)) {
                     exit(1);
                 }
                 break;
@@ -3246,8 +3241,7 @@ void qemu_init(int argc, char **argv)
                     error_report("fsdev support is disabled");
                     exit(1);
                 }
-                opts = qemu_opts_parse_noisily(olist, optarg, true);
-                if (!opts) {
+                if (!qemu_opts_parse_noisily(olist, optarg, true)) {
                     exit(1);
                 }
                 break;
@@ -3386,9 +3380,8 @@ void qemu_init(int argc, char **argv)
                 smbios_entry_add(opts, &error_fatal);
                 break;
             case QEMU_OPTION_fwcfg:
-                opts = qemu_opts_parse_noisily(qemu_find_opts("fw_cfg"),
-                                               optarg, true);
-                if (opts == NULL) {
+                if (!qemu_opts_parse_noisily(qemu_find_opts("fw_cfg"),
+                                             optarg, true)) {
                     exit(1);
                 }
                 break;
-- 
2.50.1 (Apple Git-155)


