Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC54CCF6D2F
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 14:08:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sw00j-0003Zx-NO; Wed, 02 Oct 2024 10:07:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sw00Q-0003T1-CZ; Wed, 02 Oct 2024 10:07:09 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sw00G-000597-KZ; Wed, 02 Oct 2024 10:06:59 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:2e8b:0:640:9795:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 9B93760A0D;
 Wed,  2 Oct 2024 17:06:52 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:8026::1:2f])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id S6cR231IXeA0-jQ7dD87J; Wed, 02 Oct 2024 17:06:51 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1727878011;
 bh=nUfW9+n5gMdvo97scLOTQBwoE09RtGygkqKTIQ3Zdq4=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=I4upPakU3oUodLP+ft7zBx/CK0cayvvP1HWoL90AynntvwTYNuDFheOhwyRs56v8z
 0OCp2Ji8VFslHHgAFrVqWJPsJNSpmni4Q9+fda0V1zHABK0Ggz4TpKvh5kn/eg0AM8
 MFZmeKfm2qeAOBhLxyo4bt6UbPiG2YhIhNVVhViM=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, eblake@redhat.com,
 devel@lists.libvirt.org, hreitz@redhat.com, kwolf@redhat.com,
 vsementsov@yandex-team.ru, jsnow@redhat.com, pkrempa@redhat.com
Subject: [PATCH v3 7/7] iotests/mirror-change-copy-mode: switch to job-change
 command
Date: Wed,  2 Oct 2024 17:06:16 +0300
Message-Id: <20241002140616.561652-8-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241002140616.561652-1-vsementsov@yandex-team.ru>
References: <20241002140616.561652-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Yandex-Filter: 1
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


