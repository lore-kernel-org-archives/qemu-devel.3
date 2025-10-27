Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53C4FCCF9EB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 07:44:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDHts-0004cW-7b; Mon, 27 Oct 2025 03:44:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vDHtq-0004cG-W8
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 03:44:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vDHto-0001Gh-N3
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 03:44:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761551054;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=FM0Ge5vcuFaqPh8h784CYid8IRzhhNJIZw7cznxOgFQ=;
 b=AzrBicKUs4WY0WbY/ukudSN9pr9C6tc/lZfA2aAykjK8TN7Pdex+LUlOxXKOgkkqaU38/t
 pIvBmCR7IlEVDoqGYZrj7N8ATXwFKKais+xap39l3EAs2gct6d5UvodgAdEeTmN70W0/Yc
 WOlkjHPTm9hjxm5CJq3y6Oq5vr36LYc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-637-oq_mIqxRMU-s3Xh8e7lG4g-1; Mon,
 27 Oct 2025 03:44:10 -0400
X-MC-Unique: oq_mIqxRMU-s3Xh8e7lG4g-1
X-Mimecast-MFC-AGG-ID: oq_mIqxRMU-s3Xh8e7lG4g_1761551049
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3104319540D6; Mon, 27 Oct 2025 07:44:09 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.57])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 896A919560AD; Mon, 27 Oct 2025 07:44:06 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Harsh Prateek Bora <harshpb@linux.ibm.com>,
	qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: [PULL SUBSYSTEM qemu-pseries 0/1] pseries: Update SLOF firmware image
 to 20251026
Date: Mon, 27 Oct 2025 08:44:03 +0100
Message-ID: <20251027074404.25758-1-thuth@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

 Hi Harsh, hi Nicholas,

Alexey currently seems to be away from keyboard, so I took care of tagging a
SLOF release this time. Please merge this into your next ppc pull request,
thanks!

(Richard, please note: this is not for master, this is for pseries)

The following changes since commit 88b1716a407459c8189473e4667653cb8e4c3df7:

  Merge tag 'pull-target-arm-20251023' of https://gitlab.com/pm215/qemu into staging (2025-10-23 13:17:27 -0500)

are available in the Git repository at:

  https://gitlab.com/thuth/qemu.git tags/qemu-slof-2025-10-27

for you to fetch changes up to 371c87b3ef298b0a2b6333943134779337d3a7cd:

  pseries: Update SLOF firmware image to release 20251027 (2025-10-27 08:09:51 +0100)

----------------------------------------------------------------
- Fix some measurements in the TPM code
- Fix for compiling with GCC in C23 mode
- Silence some initializer-string warnings with recent GCC

----------------------------------------------------------------
Thomas Huth (1):
      pseries: Update SLOF firmware image to release 20251027

 pc-bios/README   |   2 +-
 pc-bios/slof.bin | Bin 996184 -> 994176 bytes
 roms/SLOF        |   2 +-
 3 files changed, 2 insertions(+), 2 deletions(-)


