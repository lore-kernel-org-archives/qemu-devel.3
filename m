Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B287606A324
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 07:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YKQcT9fj
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTwVv-0003RH-4D; Thu, 19 Nov 2026 02:24:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eashurov@redhat.com>)
 id 1xTwVt-0003Qp-7m
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 02:24:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eashurov@redhat.com>)
 id 1xTwVq-0007HL-NQ
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 02:24:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795073092;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=H6qJ4RYXkVExHzeUgLkLcZv4mUOaqHgyuCf/VXNO7j8=;
 b=YKQcT9fj9IkfU+c3UDvJ6wvmb+NLsxXSB4nHzcW44ZzBo1DiKDj+A4FHJI+MhI5qVjDPt8
 Md27PA1LZMxw0TzDeyYaR6QrbvSCnVR9qXaEvDFv/Jc0eJZlam1YVEhivkC/1+/FA+dRzy
 MhIpQyuq2YRrn30MV3LldZN23yZJtQE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-353-LlVJQ4tNNJCo_S8iUA2O2g-1; Thu,
 19 Nov 2026 02:24:51 -0500
X-MC-Unique: LlVJQ4tNNJCo_S8iUA2O2g-1
X-Mimecast-MFC-AGG-ID: LlVJQ4tNNJCo_S8iUA2O2g_1795073090
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 890EC1954B25; Thu, 19 Nov 2026 07:24:49 +0000 (UTC)
Received: from eashurov-thinkpadx1carbongen12.raanaii.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 665FA195604E; Thu, 19 Nov 2026 07:24:45 +0000 (UTC)
From: Elizabeth Ashurov <eashurov@redhat.com>
To: qemu-devel@nongnu.org
Cc: kkostiuk@redhat.com, michael.roth@amd.com, dholler@redhat.com,
 armbru@redhat.com, fdeutsch@redhat.com, yvugenfi@redhat.com,
 kramdoss@redhat.com, Elizabeth Ashurov <eashurov@redhat.com>
Subject: [PATCH v5 0/2] qga: Add Windows driver information commands
Date: Thu, 19 Nov 2026 09:24:35 +0200
Message-ID: <20261119072437.1418565-1-eashurov@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eashurov@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series introduces two new QGA commands for Windows:
* guest-get-driver-packages: retrieve out-of-box driver packages
  from the Windows Driver Store.
* guest-get-driver-services: retrieve registered driver services
  and their metadata from the Service Control Manager and driver binaries.

Changes in v5:
Rebase onto current master.

Elizabeth Ashurov (2):
  qga: Add guest-get-driver-packages command for Windows
  qga: Add guest-get-driver-services command for Windows

 qga/commands-win32.c | 656 +++++++++++++++++++++++++++++++++++++++++++
 qga/meson.build      |   5 +-
 qga/qapi-schema.json |  87 ++++++
 3 files changed, 746 insertions(+), 2 deletions(-)


base-commit: 08c9bbb825148dec9669f5184ecf18823bb6d631
-- 
2.55.0


