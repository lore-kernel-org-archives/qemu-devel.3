Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5FDED43FEE
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 08:38:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tCxH5-0001dj-6n; Mon, 18 Nov 2024 03:38:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tCxGX-0001XL-Ge
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 03:37:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tCxGV-00045S-LD
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 03:37:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731919064;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Uw0RyoLnVp8kUNHEjkGEoyOGFMTjtAKoeSe0/DvGg9Y=;
 b=J3HQ6uNH8PFORq3iA8i2odhlhRNHswMu5KfSIIFXb99W6RBqWgfhr3hc93+ZTh2mIoUgek
 GUVB+6S7BB9C5lyC8PYaEzmxsBggx/Mnfcu1/m6zHrv9PpU5cwRNWhJE5YXH/UOtzmRV12
 eF0+zM7afi7mS5hn+8172ErV6bN0i4I=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-32-2SVg5i63MFm_9FCww29y3A-1; Mon,
 18 Nov 2024 03:37:43 -0500
X-MC-Unique: 2SVg5i63MFm_9FCww29y3A-1
X-Mimecast-MFC-AGG-ID: 2SVg5i63MFm_9FCww29y3A
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 74D381955DC1
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2024 08:37:41 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.9])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 00DB51956054; Mon, 18 Nov 2024 08:37:39 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 0/3] vfio queue
Date: Mon, 18 Nov 2024 09:37:34 +0100
Message-ID: <20241118083737.174219-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

The following changes since commit abb1565d3d863cf210f18f70c4a42b0f39b8ccdb:

  Merge tag 'pull-tcg-20241116' of https://gitlab.com/rth7680/qemu into staging (2024-11-16 18:16:46 +0000)

are available in the Git repository at:

  https://github.com/legoater/qemu/ tags/pull-vfio-20241118

for you to fetch changes up to ebbf7c60bbd1ceedf9faf962e428ceda2388c248:

  vfio/container: Fix container object destruction (2024-11-18 08:40:06 +0100)

----------------------------------------------------------------
vfio queue:

* Fixed IGD support
* Fixed QEMU crash when passing through devices in SEV-SNP guests

----------------------------------------------------------------
Corvin Köhne (2):
      vfio/igd: add pci id for Coffee Lake
      vfio/igd: fix calculation of graphics stolen memory

Cédric Le Goater (1):
      vfio/container: Fix container object destruction

 hw/vfio/container-base.c | 2 +-
 hw/vfio/igd.c            | 5 ++++-
 2 files changed, 5 insertions(+), 2 deletions(-)


