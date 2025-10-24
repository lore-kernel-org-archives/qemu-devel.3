Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5393CCD1AB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 12:31:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCGwg-0005yg-VA; Fri, 24 Oct 2025 08:31:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vCGwe-0005y1-Fw
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 08:31:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vCGwb-000675-Ks
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 08:31:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761309053;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Pdv08C5oMSLrXlYJjzS6+nPDFjmTwULB8KPlHnqbBrY=;
 b=T92HkviUFH+6hVXxKcMGwK7J8cjymf0il+eHJrcO3DUpU4G8nbiwgsy+TteJM6p/SL7hk6
 InyBvIf6jvfRZab2R0XLwL4c6Zxz4tzONY+Cu2neaPFRlXjD6djaBNzotPFPPCcE5zCICo
 p//LAn8JRA8QdU2uGjWKdEt4HPZLZQ0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-205-4B65QJyROfeeYWJDHPxOOg-1; Fri,
 24 Oct 2025 08:30:51 -0400
X-MC-Unique: 4B65QJyROfeeYWJDHPxOOg-1
X-Mimecast-MFC-AGG-ID: 4B65QJyROfeeYWJDHPxOOg_1761309050
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 653861800637; Fri, 24 Oct 2025 12:30:50 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.45.225.249])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5058719540EB; Fri, 24 Oct 2025 12:30:47 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, eblake@redhat.com, armbru@redhat.com,
 qemu-devel@nongnu.org, hreitz@redhat.com
Subject: [PATCH v2 0/4] block: Expose block limits in monitor and qemu-img info
Date: Fri, 24 Oct 2025 14:30:36 +0200
Message-ID: <20251024123041.51254-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

This information can be useful both for debugging and for management
tools trying to configure guest devices with the optimal limits
(possibly across multiple hosts). There is no reason not to make it
available, so just add it both in the monitor (QMP and HMP) and in
'qemu-img info'.

v2:
- Improved QAPI documentation and adjusted formatting [Markus]
- Made the same improvements to BlockLimits comments (new patch 1)
- Added a qemu-img info option to specify the cache mode (new patch 4)

Kevin Wolf (4):
  block: Improve comments in BlockLimits
  block: Expose block limits for images in QMP
  qemu-img info: Optionally show block limits
  qemu-img: Add cache mode option

 qapi/block-core.json             | 66 ++++++++++++++++++++++++++++++++
 docs/tools/qemu-img.rst          |  6 ++-
 include/block/block_int-common.h | 30 ++++++++-------
 include/block/qapi.h             |  2 +-
 block/qapi.c                     | 66 ++++++++++++++++++++++++++++++--
 qemu-img.c                       | 40 +++++++++++++++----
 qemu-img-cmds.hx                 |  4 +-
 tests/qemu-iotests/184           |  5 ++-
 tests/qemu-iotests/184.out       |  8 ----
 tests/qemu-iotests/common.filter |  3 +-
 10 files changed, 191 insertions(+), 39 deletions(-)

-- 
2.51.0


