Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB903C54791
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 15:14:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkQEr-0003ty-Kc; Wed, 13 Mar 2024 11:09:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rkQEg-0003cn-3G; Wed, 13 Mar 2024 11:09:42 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rkQEe-0005w0-J3; Wed, 13 Mar 2024 11:09:41 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c08:8793:0:640:b059:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 9020060E68;
 Wed, 13 Mar 2024 18:09:38 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:7318::1:20])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 99pZB52GZiE0-Q1M48Pj3; Wed, 13 Mar 2024 18:09:37 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1710342577;
 bh=smUXyHkMuIz0DGcbLHOFuueaFXuHhhxrcKuIjG0mGJs=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=D8jdFgEpcnvO71fzBOV9yfpHB0VfJG1rr1+pl6IR3OzgpJB+z3GG7vrwnigDLFjTJ
 AHSPh1oZIH9GM9ZL6dZLz8yLB5F3LjY+5GUpGVROtwfbfVaytriugwuN+2r46vkzdj
 etCRbb1OG2m4A5q0A3pgILxSk/k11Q9rKsp+eZO4=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, vsementsov@yandex-team.ru,
 kwolf@redhat.com, hreitz@redhat.com, devel@lists.libvirt.org,
 eblake@redhat.com, armbru@redhat.com, michael.roth@amd.com,
 pbonzini@redhat.com, pkrempa@redhat.com, f.ebner@proxmox.com
Subject: [RFC 13/15] qapi: move IoStatus to common.json
Date: Wed, 13 Mar 2024 18:09:05 +0300
Message-Id: <20240313150907.623462-14-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240313150907.623462-1-vsementsov@yandex-team.ru>
References: <20240313150907.623462-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

We will need to use the structure both in block-core.json and job.json.
So, move it to common.json, which could be then included to job.json.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 qapi/block-core.json | 16 ----------------
 qapi/common.json     | 16 ++++++++++++++++
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 1f00d4f031..75c02e1586 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -570,22 +570,6 @@
             '*iops_size': 'int', '*group': 'str', 'cache': 'BlockdevCacheInfo',
             'write_threshold': 'int', '*dirty-bitmaps': ['BlockDirtyInfo'] } }
 
-##
-# @IoStatus:
-#
-# An enumeration of block device I/O status.
-#
-# @ok: The last I/O operation has succeeded
-#
-# @failed: The last I/O operation has failed
-#
-# @nospace: The last I/O operation has failed due to a no-space
-#     condition
-#
-# Since: 1.0
-##
-{ 'enum': 'IoStatus', 'data': [ 'ok', 'failed', 'nospace' ] }
-
 ##
 # @BlockDirtyInfo:
 #
diff --git a/qapi/common.json b/qapi/common.json
index f1bb841951..3becca1300 100644
--- a/qapi/common.json
+++ b/qapi/common.json
@@ -19,6 +19,22 @@
 { 'enum': 'IoOperationType',
   'data': [ 'read', 'write' ] }
 
+##
+# @IoStatus:
+#
+# An enumeration of block device I/O status.
+#
+# @ok: The last I/O operation has succeeded
+#
+# @failed: The last I/O operation has failed
+#
+# @nospace: The last I/O operation has failed due to a no-space
+#     condition
+#
+# Since: 1.0
+##
+{ 'enum': 'IoStatus', 'data': [ 'ok', 'failed', 'nospace' ] }
+
 ##
 # @OnOffAuto:
 #
-- 
2.34.1


