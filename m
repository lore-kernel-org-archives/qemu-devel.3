Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3A8FC54ED1
	for <qemu-devel@archiver.kernel.org>; Fri, 23 May 2025 16:31:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIVIT-0001Oc-Nx; Fri, 23 May 2025 12:31:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uIVIJ-0001NO-JP
 for qemu-devel@nongnu.org; Fri, 23 May 2025 12:30:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uIVIH-0006WT-LR
 for qemu-devel@nongnu.org; Fri, 23 May 2025 12:30:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748017847;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=GDzVuUL1EWHAoufgB5vvSYHOKzjCkY4JnynEvdhgXxY=;
 b=RCXyiDl1uk8LsYKLrprMWh7ihdD10/e41teJddAN4s695dS8F8Udu4B+dyNNwZTjoWUMgG
 dYng0eDWgBEFstxd68m4jIBDcIUqAyNH1ZvxKpJog+7+wNnw/XdPqjuYPTu8NzC5vCerQr
 m/5zJK8m0pmUEfpsTGaehqzuoDa79/Y=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-60-qOdYdqkQMB6wN61G3moKFA-1; Fri,
 23 May 2025 12:30:45 -0400
X-MC-Unique: qOdYdqkQMB6wN61G3moKFA-1
X-Mimecast-MFC-AGG-ID: qOdYdqkQMB6wN61G3moKFA_1748017845
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 81A15195608C; Fri, 23 May 2025 16:30:44 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.201])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 252E0195608F; Fri, 23 May 2025 16:30:42 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
	f.ebner@proxmox.com
Subject: [PATCH v2 0/3] iotests improvements for mirror-sparse and others
Date: Fri, 23 May 2025 11:27:20 -0500
Message-ID: <20250523163041.2548675-5-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.287,
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

v1 was here:
https://lists.gnu.org/archive/html/qemu-devel/2025-05/msg05449.html

Since then
 - add more patches
 - don't try sync; that wasn't enough for ZFS

I don't have ZFS locally, so patch 3 WILL need to be tested there (but
I did test that the skip mechanism works on ext4 when I intentionally
tweak the common.rc code to fail failure); and this only addresses the
subset of tests in Fiona's email where I could obviously see some sort
of probing of image sizes, and not every test mentioned.

Eric Blake (3):
  iotests: Use disk_usage in more places
  iotests: Improve mirror-sparse on ext4
  iotests: Filter out ZFS in several tests

 tests/qemu-iotests/common.rc                | 30 +++++++++++++++++++++
 tests/qemu-iotests/106                      |  1 +
 tests/qemu-iotests/125                      |  2 +-
 tests/qemu-iotests/175                      |  1 +
 tests/qemu-iotests/221                      |  1 +
 tests/qemu-iotests/253                      |  1 +
 tests/qemu-iotests/308                      |  5 ++--
 tests/qemu-iotests/tests/mirror-sparse      |  5 +++-
 tests/qemu-iotests/tests/write-zeroes-unmap |  1 +
 9 files changed, 43 insertions(+), 4 deletions(-)

-- 
2.49.0


