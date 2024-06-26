Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F180EC30653
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 11:02:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMQPW-0007LS-I7; Wed, 26 Jun 2024 07:01:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sMQPT-0007JR-6R; Wed, 26 Jun 2024 07:01:56 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sMQPN-0003SE-58; Wed, 26 Jun 2024 07:01:54 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:1c20:0:640:f632:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 1006760F2C;
 Wed, 26 Jun 2024 14:01:44 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:b645::1:29])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id P1OLrj0IhSw0-2j1SLQRl; Wed, 26 Jun 2024 14:01:43 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1719399703;
 bh=IP/7c3urCxtxEZ5EuganaMwu2l+duCJlhM4632kUDA4=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=qMJ57jZkyuPAz6fZAMg5vgIx2jy2PrlxNzjl2oUZODtBKlNMnb07ojKyus47rLIGN
 uo6M0AXRk49mf8qooFfmN9eCYTiBMlP4hi5rm5YLsnA3Xt4CD3+9fzdBhd8+nvzMin
 j4oLXzSHinv/c9dFyT4eWM167aBoksUamQMdEmC8=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, eblake@redhat.com,
 devel@lists.libvirt.org, hreitz@redhat.com, kwolf@redhat.com,
 vsementsov@yandex-team.ru, jsnow@redhat.com, pkrempa@redhat.com,
 f.ebner@proxmox.com
Subject: [PATCH v2 3/7] qapi: block-job-change: make copy-mode parameter
 optional
Date: Wed, 26 Jun 2024 14:01:20 +0300
Message-Id: <20240626110124.374336-4-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240626110124.374336-1-vsementsov@yandex-team.ru>
References: <20240626110124.374336-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

We are going to add more parameters to change. We want to make possible
to change only one or any subset of available options. So all the
options should be optional.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 block/mirror.c       | 4 ++++
 qapi/block-core.json | 3 ++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/block/mirror.c b/block/mirror.c
index 2816bb1042..60e8d83e4f 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1272,6 +1272,10 @@ static void mirror_change(BlockJob *job, JobChangeOptions *opts,
 
     GLOBAL_STATE_CODE();
 
+    if (!change_opts->has_copy_mode) {
+        return;
+    }
+
     if (qatomic_read(&s->copy_mode) == change_opts->copy_mode) {
         return;
     }
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 4ec5632596..660c7f4a48 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3071,11 +3071,12 @@
 #
 # @copy-mode: Switch to this copy mode.  Currently, only the switch
 #     from 'background' to 'write-blocking' is implemented.
+#     If absent, copy mode remains the same.  (optional since 9.1)
 #
 # Since: 8.2
 ##
 { 'struct': 'JobChangeOptionsMirror',
-  'data': { 'copy-mode' : 'MirrorCopyMode' } }
+  'data': { '*copy-mode' : 'MirrorCopyMode' } }
 
 ##
 # @JobChangeOptions:
-- 
2.34.1


