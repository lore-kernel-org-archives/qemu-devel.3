Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72C71CAC5AC
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 16:39:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v161X-00065o-LK; Tue, 23 Sep 2025 12:37:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1v161U-00064i-SP
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 12:37:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1v161T-0007bU-Bm
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 12:37:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758645466;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=BJjtnVxBmKqsL8XU/8IvyabhGsqNVhWhOGr2MhYq7Yw=;
 b=eqczD2TOAd9BX009ezNdgwAsryqY8k3GvKrH7nlSM8YDaMZfJq5Yum2L76+pJWbNwdAMCi
 eMIadEkugF/K/pNsiknV/okWt2g1BBlz6Nssy/G/jFVWs+KQPqnmsLjeSj8/7SwdhEv9ka
 ALXGbUSIRoUitK0+fBsy5vKe+lWyM/g=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-542-pTbxIU9PMhe4KS16J1iZHA-1; Tue,
 23 Sep 2025 12:37:41 -0400
X-MC-Unique: pTbxIU9PMhe4KS16J1iZHA-1
X-Mimecast-MFC-AGG-ID: pTbxIU9PMhe4KS16J1iZHA_1758645460
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A4B0A1956089; Tue, 23 Sep 2025 16:37:40 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.45.224.18])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D1512300018D; Tue, 23 Sep 2025 16:37:38 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, eblake@redhat.com,
 qemu-devel@nongnu.org
Subject: [PATCH 0/2] block: Expose block limits in monitor and qemu-img info
Date: Tue, 23 Sep 2025 18:37:33 +0200
Message-ID: <20250923163735.378254-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
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

This information can be useful both for debugging and for management
tools trying to configure guest devices with the optimal limits
(possibly across multiple hosts). There is no reason not to make it
available, so just add it both in the monitor (QMP and HMP) and in
'qemu-img info'.

Kevin Wolf (2):
  block: Expose block limits for images in QMP
  qemu-img info: Optionally show block limits

 qapi/block-core.json             | 59 ++++++++++++++++++++++++++++
 docs/tools/qemu-img.rst          |  6 ++-
 include/block/qapi.h             |  2 +-
 block/qapi.c                     | 66 ++++++++++++++++++++++++++++++--
 qemu-img.c                       | 15 ++++++--
 qemu-img-cmds.hx                 |  4 +-
 tests/qemu-iotests/184           |  3 +-
 tests/qemu-iotests/184.out       |  8 ----
 tests/qemu-iotests/common.filter |  3 +-
 9 files changed, 145 insertions(+), 21 deletions(-)

-- 
2.51.0


