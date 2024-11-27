Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A542D609CF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 10:35:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGFNg-0004m2-SS; Wed, 27 Nov 2024 05:34:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tGFNd-0004l6-18
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 05:34:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tGFNb-0000eG-BU
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 05:34:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732703680;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=koZKhyCEuyoMvVAFsER3fONz2RkByjgHSe12Y+kmwEU=;
 b=aFMJ3NQV/xpJ9+h/yuOXA0hig+LmDb5MMBw6TxjT1NsJ/nmbm7aPQzlavI3svEIt9AmzlD
 9SPwWS5dVTh6JJye4GmNDszqSw7+8qfcD/XZoTji0e8Rg9CELGDYvyA1o3mnOnxIvddM91
 E4Y8JYjfsFrK5J90y5QPM/Zin7rX3uY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-665-i81gTThANj6hBONkg9uhQQ-1; Wed,
 27 Nov 2024 05:34:33 -0500
X-MC-Unique: i81gTThANj6hBONkg9uhQQ-1
X-Mimecast-MFC-AGG-ID: i81gTThANj6hBONkg9uhQQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3D15A1956077; Wed, 27 Nov 2024 10:34:32 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.82])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0C6B81956054; Wed, 27 Nov 2024 10:34:29 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Alexander Graf <agraf@csgraf.de>
Subject: [PULL 2/7] docs: Document that hvf on Arm is supported
Date: Wed, 27 Nov 2024 11:34:20 +0100
Message-ID: <20241127103425.378289-3-thuth@redhat.com>
In-Reply-To: <20241127103425.378289-1-thuth@redhat.com>
References: <20241127103425.378289-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.931,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

hvf on Arm is supported since commit a1477da3ddeb ("hvf: Add Apple
Silicon support").

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Alexander Graf <agraf@csgraf.de>
Message-ID: <20241127-build-v1-1-65b8162733f0@daynix.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 docs/about/build-platforms.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/about/build-platforms.rst b/docs/about/build-platforms.rst
index 6102f00aec..d8b0445157 100644
--- a/docs/about/build-platforms.rst
+++ b/docs/about/build-platforms.rst
@@ -40,7 +40,7 @@ Those hosts are officially supported, with various accelerators:
    * - CPU Architecture
      - Accelerators
    * - Arm
-     - kvm (64 bit only), tcg, xen
+     - hvf (64 bit only), kvm (64 bit only), tcg, xen
    * - MIPS (64 bit little endian only)
      - kvm, tcg
    * - PPC
-- 
2.47.0


