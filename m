Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8CDECA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Sep 2025 15:38:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwMtQ-0001UL-B8; Wed, 10 Sep 2025 11:37:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uwMtN-0001T9-LI
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 11:37:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uwMtL-0000rC-Oo
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 11:37:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757518670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=egz1P5ARJZip0BMZ/JsNUG371xq1bSh1M9dI58Ujl0Q=;
 b=CF3Wn/GM4vWYDykjFujVXD/FagBAbG9EFcNOmaSKEGdwueqX+2n6+JF4cfS8vMzUn9A61k
 2iMs4kOJaBwx+CAJj7BemTuzrSNvEdFI3rPoFIRmKOS+6pbRqf/ubAln9d7tX2lABKfsRU
 NerQRKEvYPcN9W0RZtINJn1cyY9yiO4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-411-5TKqdOwuPuieUFTp31RwXQ-1; Wed,
 10 Sep 2025 11:37:47 -0400
X-MC-Unique: 5TKqdOwuPuieUFTp31RwXQ-1
X-Mimecast-MFC-AGG-ID: 5TKqdOwuPuieUFTp31RwXQ_1757518666
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9ACA71800370; Wed, 10 Sep 2025 15:37:46 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.33.173])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 627CB19560AB; Wed, 10 Sep 2025 15:37:44 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-block@nongnu.org,
	Kevin Wolf <kwolf@redhat.com>
Cc: Hanna Czenczek <hreitz@redhat.com>, qemu-devel@nongnu.org,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH 1/3] tests/qemu-iotests/184: Fix skip message for qemu-img
 without throttle
Date: Wed, 10 Sep 2025 17:37:24 +0200
Message-ID: <20250910153727.226217-2-thuth@redhat.com>
In-Reply-To: <20250910153727.226217-1-thuth@redhat.com>
References: <20250910153727.226217-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qemu-iotests/184 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/184 b/tests/qemu-iotests/184
index e4cbcd86345..f7fcedacfb5 100755
--- a/tests/qemu-iotests/184
+++ b/tests/qemu-iotests/184
@@ -50,7 +50,7 @@ run_qemu()
 }
 
 test_throttle=$($QEMU_IMG --help|grep throttle)
-[ "$test_throttle" = "" ] && _supported_fmt throttle
+[ "$test_throttle" = "" ] && _notrun "qemu-img does not support throttle"
 
 echo
 echo "== checking interface =="
-- 
2.51.0


