Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D53ADC54E66
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 15:10:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkQEv-0003x8-3k; Wed, 13 Mar 2024 11:09:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rkQEY-0003Zz-Cf; Wed, 13 Mar 2024 11:09:35 -0400
Received: from forwardcorp1c.mail.yandex.net
 ([2a02:6b8:c03:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rkQEV-0005sM-1a; Wed, 13 Mar 2024 11:09:34 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c08:8793:0:640:b059:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTPS id 318D160D9A;
 Wed, 13 Mar 2024 18:09:29 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:7318::1:20])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 99pZB52GZiE0-YxMB9SvB; Wed, 13 Mar 2024 18:09:28 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1710342568;
 bh=5ZvJ46KgdVpnV5C4Q/6UM2kcQMZH+kF/RNKW8X+vZEk=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=IJ9rSzFJ3O5UmlSuvX/2XV+NyVLBQWZ0WVWtANn2NncM+/pGFHiIiCjdvgM2V3H0U
 pQSGZLrou+DJ9bgDfa3DAvc1P3ZTXdja6TcBobYepa2kUOX5dretj0p5Y7s2aPFkWr
 D7lP8biyVMwnmiEmmLLv35X8g7OzTX3Adr5Kbwrs=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, vsementsov@yandex-team.ru,
 kwolf@redhat.com, hreitz@redhat.com, devel@lists.libvirt.org,
 eblake@redhat.com, armbru@redhat.com, michael.roth@amd.com,
 pbonzini@redhat.com, pkrempa@redhat.com, f.ebner@proxmox.com
Subject: [RFC 04/15] qapi: block-job-change: make copy-mode parameter optional
Date: Wed, 13 Mar 2024 18:08:56 +0300
Message-Id: <20240313150907.623462-5-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240313150907.623462-1-vsementsov@yandex-team.ru>
References: <20240313150907.623462-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c03:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

We are going to add more parameters to change. We want to make possible
to change only one or any subset of available options. So all the
options should be optional.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 block/mirror.c       | 5 +++++
 qapi/block-core.json | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/block/mirror.c b/block/mirror.c
index a177502e4f..2d0cd22c06 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1265,6 +1265,11 @@ static void mirror_change(BlockJob *job, JobChangeOptions *opts,
 
     GLOBAL_STATE_CODE();
 
+    if (!change_opts->has_copy_mode) {
+        /* Nothing to do */
+        return;
+    }
+
     if (qatomic_read(&s->copy_mode) == change_opts->copy_mode) {
         return;
     }
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 67dd0ef038..6041e7bd8f 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3071,7 +3071,7 @@
 # Since: 8.2
 ##
 { 'struct': 'JobChangeOptionsMirror',
-  'data': { 'copy-mode' : 'MirrorCopyMode' } }
+  'data': { '*copy-mode' : 'MirrorCopyMode' } }
 
 ##
 # @JobChangeOptions:
-- 
2.34.1


