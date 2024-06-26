Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6A22C27C4F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 11:03:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMQPW-0007Kz-46; Wed, 26 Jun 2024 07:01:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sMQPU-0007Jp-9o; Wed, 26 Jun 2024 07:01:56 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sMQPO-0003UM-G1; Wed, 26 Jun 2024 07:01:55 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:1c20:0:640:f632:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id A9686608F5;
 Wed, 26 Jun 2024 14:01:47 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:b645::1:29])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id P1OLrj0IhSw0-uxKqHE0u; Wed, 26 Jun 2024 14:01:47 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1719399707;
 bh=nUfW9+n5gMdvo97scLOTQBwoE09RtGygkqKTIQ3Zdq4=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=WkZtbKRpkbOpTRouRiAdapJSVOLbJ1svJqo2TgARvJR8uuiUiK+e8p+Fae6AJR+P1
 O/drhmtVcmtB07NPEJIEBDpBcVPIX9MrKxEVxr6NhFdORltktPoqlM7uiw2v5r3kUj
 T1/TeGazq+6f3exzIohOxnZ3AAF/rM1WQrw0dlLo=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, eblake@redhat.com,
 devel@lists.libvirt.org, hreitz@redhat.com, kwolf@redhat.com,
 vsementsov@yandex-team.ru, jsnow@redhat.com, pkrempa@redhat.com,
 f.ebner@proxmox.com
Subject: [PATCH v2 7/7] iotests/mirror-change-copy-mode: switch to job-change
 command
Date: Wed, 26 Jun 2024 14:01:24 +0300
Message-Id: <20240626110124.374336-8-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240626110124.374336-1-vsementsov@yandex-team.ru>
References: <20240626110124.374336-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
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

block-job-change is deprecated, let's move test to job-change.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 tests/qemu-iotests/tests/mirror-change-copy-mode | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/tests/mirror-change-copy-mode b/tests/qemu-iotests/tests/mirror-change-copy-mode
index 51788b85c7..e972604ebf 100755
--- a/tests/qemu-iotests/tests/mirror-change-copy-mode
+++ b/tests/qemu-iotests/tests/mirror-change-copy-mode
@@ -150,7 +150,7 @@ class TestMirrorChangeCopyMode(iotests.QMPTestCase):
         len_before_change = result[0]['len']
 
         # Change the copy mode while requests are happening.
-        self.vm.cmd('block-job-change',
+        self.vm.cmd('job-change',
                     id='mirror',
                     type='mirror',
                     copy_mode='write-blocking')
-- 
2.34.1


