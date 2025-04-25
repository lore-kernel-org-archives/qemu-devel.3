Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 776A2C369D5
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 00:57:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u87LZ-0006iD-9v; Thu, 24 Apr 2025 20:55:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1u87LW-0006ao-BX
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 20:55:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1u87LU-0000kx-Ue
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 20:55:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745542512;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/5vYFny3KY+YPBZUlV2L+qBrM5argzflEf5xqcWdd8k=;
 b=NuUAFTDZJUV1JMuk5+uU4zeVT7CKlRAgSenH5DBraSpPduTLoMN5OeqzIYUMuh90MvOIHg
 00TOhSmWpjtq7Of77sm4fmGU0qQHt6/L0x7CseisJ44o9R5hmvjmLxVf57g59+W64vxpHq
 TK601u47RmUWPEyw1pyd8ITKuuo+EvI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-230-Kx26B9gFP-20QDggKerrvw-1; Thu,
 24 Apr 2025 20:55:08 -0400
X-MC-Unique: Kx26B9gFP-20QDggKerrvw-1
X-Mimecast-MFC-AGG-ID: Kx26B9gFP-20QDggKerrvw_1745542507
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 941911800875; Fri, 25 Apr 2025 00:55:07 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.59])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E955A18001EF; Fri, 25 Apr 2025 00:55:05 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, vsementsov@yandex-team.ru, stefanha@redhat.com,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH v3 05/11] iotests: Improve iotest 194 to mirror data
Date: Thu, 24 Apr 2025 19:52:05 -0500
Message-ID: <20250425005439.2252467-18-eblake@redhat.com>
In-Reply-To: <20250425005439.2252467-13-eblake@redhat.com>
References: <20250425005439.2252467-13-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.84,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Mirroring a completely sparse image to a sparse destination should be
practically instantaneous.  It isn't yet, but the test will be more
realistic if it has some non-zero to mirror as well as the holes.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/qemu-iotests/194 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qemu-iotests/194 b/tests/qemu-iotests/194
index c0ce82dd257..d0b9c084f5f 100755
--- a/tests/qemu-iotests/194
+++ b/tests/qemu-iotests/194
@@ -34,6 +34,7 @@ with iotests.FilePath('source.img') as source_img_path, \

     img_size = '1G'
     iotests.qemu_img_create('-f', iotests.imgfmt, source_img_path, img_size)
+    iotests.qemu_io('-f', iotests.imgfmt, '-c', 'write 512M 1M', source_img_path)
     iotests.qemu_img_create('-f', iotests.imgfmt, dest_img_path, img_size)

     iotests.log('Launching VMs...')
-- 
2.49.0


