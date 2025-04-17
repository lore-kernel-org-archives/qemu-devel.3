Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 028F0C369C2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 15:06:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5Qo8-0005S3-Td; Thu, 17 Apr 2025 11:05:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u5Qo5-0005RR-Kg
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 11:05:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u5Qo3-0000QL-Ak
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 11:05:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744902334;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=aOjVA0eMHjeqcIwFk9VUbrkjKF2W7aRxm9SFvO1z9Ao=;
 b=YSZ01pdPmIH/sb71S7toER5SeiiyluZZI+vD3tMKBkBWqUlqs+1NKglE0/V/ZXhBoRYM+Q
 Y0koomNXZ3zyJ3gpgn5a1urWqeGTIpR6gfnVCmc4k18s2BM1+Ofo4oSWkU0UG2zTd9Ep8X
 FjqcJQf8C7t36vqRdNICm6Vtp3DjDsY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-518-KqbToeFBPKiuUPCoiQFYzw-1; Thu,
 17 Apr 2025 11:05:33 -0400
X-MC-Unique: KqbToeFBPKiuUPCoiQFYzw-1
X-Mimecast-MFC-AGG-ID: KqbToeFBPKiuUPCoiQFYzw_1744902332
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 736481955DC5; Thu, 17 Apr 2025 15:05:31 +0000 (UTC)
Received: from localhost (unknown [10.2.16.64])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A1C511954B0B; Thu, 17 Apr 2025 15:05:29 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Fam Zheng <fam@euphon.net>, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH v4 0/2] block: discard alignment fixes
Date: Thu, 17 Apr 2025 11:05:26 -0400
Message-ID: <20250417150528.76470-1-stefanha@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

v4:
- Mention -EINVAL in bdrv_co_pdiscard() comment [Kevin]
v3:
- Refine error handling when pdiscard_alignment is not a multiple of request_alignment [Hanna]
v2:
- Fix inverted logic in alignment check [Qing Wang]

Two discard alignment issues were identified in
https://issues.redhat.com/browse/RHEL-86032:
1. pdiscard_alignment is not populated for host_device in file-posix.c.
2. Misaligned head/tail discard requests are not skipped when file-posix.c
   returns -EINVAL. This causes an undesired pause when guests are configured
   with werror=stop.

Stefan Hajnoczi (2):
  file-posix: probe discard alignment on Linux block devices
  block/io: skip head/tail requests on EINVAL

 block/file-posix.c | 67 +++++++++++++++++++++++++++++++++++++++++++++-
 block/io.c         | 15 +++++++----
 2 files changed, 76 insertions(+), 6 deletions(-)

-- 
2.49.0


