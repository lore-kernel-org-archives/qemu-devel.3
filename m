Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C5CBC48260
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 16:24:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSg1q-00025H-JD; Wed, 24 Jan 2024 11:23:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1rSg1o-00024N-QP; Wed, 24 Jan 2024 11:23:04 -0500
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1rSg1m-0008R4-Ry; Wed, 24 Jan 2024 11:23:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-Id:Date:Subject:From:
 Content-Type; bh=GqeLkuvsy7n5AiCTUocuntwa1Yir5gbh40eQKHcdIY8=; b=ur7rjalTXcTa
 H0aULwkXP4/oVjab0dRkV5SRIX1y+tBfkDSCdkBH+zCkyOiA0QnWxpne07QPkOZhQEy/rX9QZU+u5
 qEyyR6FdRjQ+2daY2sQPhV+ZKSUY+0bX7pZONyYJlBt9XE8PKWNd/SHMYZpnzsQi2aMtO1yCZ+Vwv
 DA1oI05nR0pNnGw/pnfBA00NCx8fQq9HouYXgzXUIzJEaG6rM//hKLclKQYq7GrTgsurXBOa6LwOr
 NL/ze8P70SA9p+y5ZyVh+wioQG8U3i3x2DQ4lKaUmvPo/WAh+/rD/eHHncD8noV/RuchVD2dSsEpR
 2WhFevTA0/PMyRFQkLX6Nw==;
Received: from [130.117.225.1] (helo=dev005.ch-qa.vzint.dev)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <andrey.drobyshev@virtuozzo.com>) id 1rSg1H-00AnY7-2f;
 Wed, 24 Jan 2024 17:22:45 +0100
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 eblake@redhat.com, andrey.drobyshev@virtuozzo.com, den@virtuozzo.com
Subject: [PATCH] iotests/277: Use iotests.sock_dir for socket creation
Date: Wed, 24 Jan 2024 18:22:57 +0200
Message-Id: <20240124162257.168325-1-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=130.117.225.111;
 envelope-from=andrey.drobyshev@virtuozzo.com; helo=relay.virtuozzo.com
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

If socket path is too long (longer than 108 bytes), socket can't be
opened.  This might lead to failure when test dir path is long enough.
Make sure socket is created in iotests.sock_dir to avoid such a case.

This commit basically aligns iotests/277 with the rest of iotests.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 tests/qemu-iotests/277 | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/277 b/tests/qemu-iotests/277
index 24833e7eb6..4224202ac2 100755
--- a/tests/qemu-iotests/277
+++ b/tests/qemu-iotests/277
@@ -27,7 +27,8 @@ from iotests import file_path, log
 iotests.script_initialize()
 
 
-nbd_sock, conf_file = file_path('nbd-sock', 'nbd-fault-injector.conf')
+conf_file = file_path('nbd-fault-injector.conf')
+nbd_sock = file_path('nbd-sock', base_dir=iotests.sock_dir)
 
 
 def make_conf_file(event):
-- 
2.39.3


