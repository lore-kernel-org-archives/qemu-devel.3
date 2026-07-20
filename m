Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47D3EC44529
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 18:30:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlskd-0007aJ-8r; Mon, 20 Jul 2026 14:30:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wlskb-0007Yx-3i
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 14:30:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wlskY-0002Dz-NJ
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 14:30:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784572198;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gcpkN8gWqeJ8xS0BQIAViDRfzh1XQN4938ZBejhaAPY=;
 b=doXtn0GH+vdnBrFZcefjho7X+CrzSHAgfcFsy8WxwfQewO1tj8o/oJYxNTLHjzay6sVf9r
 SznykNrHUvGgPFpd6Pzlk+HIEdZI98BRVpkqxHtLkSBuHSQAU5okQVzK7tZumsHEcb0ad0
 bW6vgAOGfGZAB9QudxOsbh/frHBUMJk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-148-WOfdwF79NNulzx1CQxdVMw-1; Mon,
 20 Jul 2026 14:29:56 -0400
X-MC-Unique: WOfdwF79NNulzx1CQxdVMw-1
X-Mimecast-MFC-AGG-ID: WOfdwF79NNulzx1CQxdVMw_1784572195
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1E34819352EB; Mon, 20 Jul 2026 18:29:55 +0000 (UTC)
Received: from localhost (unknown [10.2.16.104])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4565018001E7; Mon, 20 Jul 2026 18:29:54 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 1/1] iotests/108: avoid leaking FUSE mount
Date: Mon, 20 Jul 2026 14:29:50 -0400
Message-ID: <20260720182950.176197-2-stefanha@redhat.com>
In-Reply-To: <20260720182950.176197-1-stefanha@redhat.com>
References: <20260720182950.176197-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=stefanha@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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

The QEMU s390x CI gitlab-runner recently broke because qemu-iotests 108
FUSE mount leaked and prevented the setup of the gitlab-runner
environment:

  chmod: cannot access '/home/gitlab-runner/builds/P3MFS4LUf/0/qemu-project/qemu/build/scratch/qcow2-file-108/fuse-export': Transport endpoint is not connected

https://gitlab.com/qemu-project/qemu/-/jobs/14796143507#L11

Always umount the FUSE export when cleaning up to prevent the leak.

Closes: https://gitlab.com/qemu-project/qemu/-/work_items/3541
Cc: Hanna Czenczek <hreitz@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20260611125438.194479-1-stefanha@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/qemu-iotests/108 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/108 b/tests/qemu-iotests/108
index 54e935acf28..bf808b35125 100755
--- a/tests/qemu-iotests/108
+++ b/tests/qemu-iotests/108
@@ -34,8 +34,8 @@ _cleanup()
     if [ -f "$TEST_DIR/qsd.pid" ]; then
         qsd_pid=$(cat "$TEST_DIR/qsd.pid")
         kill -KILL "$qsd_pid"
-        fusermount -u "$TEST_DIR/fuse-export" &>/dev/null
     fi
+    fusermount -u "$TEST_DIR/fuse-export" &>/dev/null
     rm -f "$TEST_DIR/fuse-export"
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
-- 
2.55.0


