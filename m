Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5F69CCFA05
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 18:00:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGLJM-0005Mu-EY; Tue, 04 Nov 2025 12:59:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vGLFO-0001LM-JK
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 12:55:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vGLFM-00073A-PQ
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 12:55:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762278908;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lH5xtqAOdfESiQM+REAWAsG45Zyi+yUbjY66ZXmScSM=;
 b=PKoPvoEjJme++QTimw2eyz20KEYmKd7aLN74fBjyBIr2msndgJInIuslzp1GOuZx1Hgbi2
 AkEDxLhs44vUASqMIA9DTq7gFv+n/cq8r0w8C0Azh0SHdLIGustRTh/DrJXNPy9y84jQH6
 bneRZcXAlEML4WSl6HatPX40X4B/r8o=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-226-acI4E4jrPWu_cnq7oGOhzg-1; Tue,
 04 Nov 2025 12:55:06 -0500
X-MC-Unique: acI4E4jrPWu_cnq7oGOhzg-1
X-Mimecast-MFC-AGG-ID: acI4E4jrPWu_cnq7oGOhzg_1762278905
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CB8131954B0C; Tue,  4 Nov 2025 17:55:05 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.45.226.47])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7B1111800451; Tue,  4 Nov 2025 17:55:04 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 23/27] tests/qemu-iotests/184: Fix skip message for qemu-img
 without throttle
Date: Tue,  4 Nov 2025 18:54:11 +0100
Message-ID: <20251104175415.525388-24-kwolf@redhat.com>
In-Reply-To: <20251104175415.525388-1-kwolf@redhat.com>
References: <20251104175415.525388-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.788,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

If qemu-img does not support throttling, test 184 currently skips
with the message:

  not suitable for this image format: raw

But that's wrong, it's not about the image format, it's about the
throttling not being available in qemu-img. Thus fix this by using
_notrun with a proper message instead.

Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20251014104142.1281028-2-thuth@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/184 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/184 b/tests/qemu-iotests/184
index 6d0afe9d38..9248b3265d 100755
--- a/tests/qemu-iotests/184
+++ b/tests/qemu-iotests/184
@@ -51,7 +51,7 @@ run_qemu()
 }
 
 test_throttle=$($QEMU_IMG --help|grep throttle)
-[ "$test_throttle" = "" ] && _supported_fmt throttle
+[ "$test_throttle" = "" ] && _notrun "qemu-img does not support throttle"
 
 echo
 echo "== checking interface =="
-- 
2.51.1


