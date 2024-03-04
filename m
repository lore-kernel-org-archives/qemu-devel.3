Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8297FC48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 10:45:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh5ny-0006M1-1k; Mon, 04 Mar 2024 05:44:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rh5nx-0006LU-AA
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 05:44:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rh5ns-00046f-5W
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 05:44:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709549055;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=rfpY65jHzYurDFLA1Sz6Q9SQeY2XmDz92nV1gwZMc0A=;
 b=KGvT4BCyX6+vytLVRXWJrdv9B8c2M8Yu6/mi/F8PsS/BI7oNy8tHSxTOxVPrAiTu7gFdCE
 GEl+Vu2LL2lBXtRIJQb4rK2789zgSfBuUJ6v0GeS2Yh93rfdTgbgl6mMjaFljsyw5Z+eN7
 qq/q4rl2A7gbdDfrJnl6ZzbYgCuTAAU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-671-A60IAeEvPmCF1kwCgQ3Whw-1; Mon,
 04 Mar 2024 05:44:10 -0500
X-MC-Unique: A60IAeEvPmCF1kwCgQ3Whw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7472A1C0BA47;
 Mon,  4 Mar 2024 10:44:10 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.70])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 077DE1C060AF;
 Mon,  4 Mar 2024 10:44:07 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>,
	qemu-devel@nongnu.org
Cc: Fan Ni <fan.ni@samsung.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-trivial@nongnu.org
Subject: [PATCH 0/3] cxl: Fix issues with g_steal_pointer()
Date: Mon,  4 Mar 2024 11:44:03 +0100
Message-ID: <20240304104406.59855-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.589,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

When setting GLIB_VERSION_MAX_ALLOWED to GLIB_VERSION_2_58 or higher
(which we'll certainly do in the not too distant future), glib adds
type safety checks to the g_steal_pointer() macro. This triggers
errors in the cxl code since the pointer types do not always match
here. Let's fix those errors now so we can switch to a newer version
of the glib in a future version of QEMU.

Thomas Huth (3):
  hw/cxl/cxl-cdat: Fix type of buf in ct3_load_cdat()
  hw/pci-bridge/cxl_upstream: Fix problem with g_steal_pointer()
  hw/mem/cxl_type3: Fix problem with g_steal_pointer()

 include/hw/cxl/cxl_cdat.h    | 17 +++++++++++------
 hw/cxl/cxl-cdat.c            |  4 ++--
 hw/mem/cxl_type3.c           | 24 ++++++++++++------------
 hw/pci-bridge/cxl_upstream.c |  8 ++++----
 4 files changed, 29 insertions(+), 24 deletions(-)

-- 
2.44.0


