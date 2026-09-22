Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA538C98302
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:23:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x96zi-0000B6-OO; Tue, 22 Sep 2026 16:21:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x96z5-0006us-PU
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:21:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x96z4-0008Ts-7m
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:20:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790108457;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bi7dZ4qt/ZzCBLpMRm82EPHa9uugnkunqtqUY6z0ELI=;
 b=Drun3/SyueNh0jGqv6ZB3bOwO/sj0Ukd55OSb4Y8GmeAxB6KexduURKnW01umQ8wRBufqW
 4GjmwW3YJQDL5gX9+NU8ZUgOGNM6nsmGTQ80joYS0Jg+PRkrrrEo/42HmODKU+LvrJLOsN
 IyNPvpytzGqez07K7iJA5Chd6VfUu+A=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-437-B7aCff5QNymRb50vwSeCwA-1; Tue,
 22 Sep 2026 16:20:54 -0400
X-MC-Unique: B7aCff5QNymRb50vwSeCwA-1
X-Mimecast-MFC-AGG-ID: B7aCff5QNymRb50vwSeCwA_1790108453
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2C8D018052FB; Tue, 22 Sep 2026 20:20:53 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3C89D1953941; Tue, 22 Sep 2026 20:20:51 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 23 Sep 2026 00:17:36 +0400
Subject: [PATCH 29/88] qemu-iotests/136: migrate away from HMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260923-nohmp-v1-29-ebc029d4bd80@redhat.com>
References: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
In-Reply-To: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1194;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=aKMfQJq5J4e81zVmwv/SsU+z1oiImBWtE1zBfRxQSaE=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqsuKwdK5MjLaHAFivAB+DKxxOnCeDYk39FMuz6
 T931QxofJyJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCarLisAAKCRDa6OEJdZac
 5Z+REACvapr/wU4v0zJX7392vKJBWC1E58Su7q/tMO0q5iRkQP+J438+5/266zKfR2gxLyym6WT
 BIfk9sejXolqmUb0odXHVBE/rDON8XDR8tFTmRqjIx7ACne6LX79WfkeYG5Y1dW6BWvS8rVyrZ5
 E05Qp6WQUAwozDPzlquZ6r3oOH/i3WvQVV1zWczTutMX8Os72PtWOFhQrTP/CbDkCAjdbvx7YLC
 +X0V7Xe3Xu+MNaAzrUHNsuTdW4xnQuIBgD1jpSAx1CYbG+ZdyCsy7z9ccytR7ktjN0d6shr6GKl
 l0wkAGtqgFMRGcIL4VKC3k1D83NTM/POsISNAicUwLOYXSE814Mv6UlvWDAzxyKwkvGWO28Erhp
 lGvMmdWHOGFMAzLeOalcio3Kdx9oErJU7FKFVsfGIchX4XjpGtafBMyrmsAWb6PXrH0l+Rc1FYG
 ++v6JdnvCJlCV4fOYuq5Z5sHopHt0g3rpSeMsmqAfHwupXNH766cUo8fPKmWlmikkrTgHoKj9gR
 kVDy0lOYeyVRk1tIhPRin70SJw5jkMQwzF7leMzuH5tVj52F/7yMtjCRHUyJ07mvk09OqLaP8tn
 JqyhACRk5xtCUAwMi9RMQksQwKMi+jB7U3S4cbyXTZSW4TwVQxijeQIFpvlzuPGgse7kLV+BMIv
 L5k5J3NCUi+l8rw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qemu-iotests/136 | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tests/qemu-iotests/136 b/tests/qemu-iotests/136
index 72fd638aa04d..32857990fa3e 100755
--- a/tests/qemu-iotests/136
+++ b/tests/qemu-iotests/136
@@ -58,9 +58,9 @@ class BlockDeviceStatsTestCase(iotests.QMPTestCase):
 
     def qemu_io(self, cmd):
         if self.use_blockdev:
-            self.vm.hmp_qemu_io("virtio0/virtio-backend", cmd, qdev=True)
+            self.vm.qmp_qemu_io("virtio0/virtio-backend", cmd, qdev=True)
         else:
-            self.vm.hmp_qemu_io("drive0", cmd)
+            self.vm.qmp_qemu_io("drive0", cmd)
 
     def create_blkdebug_file(self):
         file = open(blkdebug_file, 'w')
@@ -410,5 +410,4 @@ class BlockDeviceStatsTestCoroutine(BlockDeviceStatsTestCase):
 if __name__ == '__main__':
     if 'null-co' not in iotests.supported_formats():
         iotests.notrun('null-co driver support missing')
-    iotests.main(supported_fmts=["raw"],
-                 require_hmp=True)
+    iotests.main(supported_fmts=["raw"])

-- 
2.56.0.rc0.29.g47ce80527c56


