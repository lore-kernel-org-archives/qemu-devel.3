Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60546D116F5
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Nov 2025 09:22:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOYCK-0000z5-1e; Thu, 27 Nov 2025 04:21:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vOYCG-0000xk-KT
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 04:21:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vOYCE-00044j-99
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 04:21:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764235307;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=DR0efulhCr1l7jS7n3IiNcNF8U4gciw58X/zY8uBQys=;
 b=gDoEOQSThVh384VRao4r2zooMmrZLop6MRTAhrniFznQM9cTm195ARR+3gHh9jtVPQq3LX
 YFMTIQV2DbVnBoU3yUt77gjMGUuJIUWJItKGlQnfcgwVxY8DM75w4tDEav3MiWJUJN5NF2
 kaZLj93FS/PftpR0NFGpqnhr7HcY0yE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-219-cUE-iAQ1Muq8SQ3fImumDA-1; Thu,
 27 Nov 2025 04:21:45 -0500
X-MC-Unique: cUE-iAQ1Muq8SQ3fImumDA-1
X-Mimecast-MFC-AGG-ID: cUE-iAQ1Muq8SQ3fImumDA_1764235305
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1832718007F2
 for <qemu-devel@nongnu.org>; Thu, 27 Nov 2025 09:21:45 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.32.104])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 85B281800346; Thu, 27 Nov 2025 09:21:44 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 0D50318009B4; Thu, 27 Nov 2025 10:21:42 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v2 0/2] hw/uefi: add pcap support
Date: Thu, 27 Nov 2025 10:21:39 +0100
Message-ID: <20251127092142.204471-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.224,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

v2:
 - add missing licence tag to new header file
 - use qemu_create()
 - tag a fixed struct as 'static const'.
 - pick up reviews tags.

Gerd Hoffmann (2):
  move pcap structs to header file
  hw/uefi: add pcap support

 include/hw/uefi/var-service.h | 10 ++++
 include/qemu/pcap.h           | 30 +++++++++++
 hw/uefi/var-service-core.c    |  7 +++
 hw/uefi/var-service-pcap.c    | 94 +++++++++++++++++++++++++++++++++++
 hw/uefi/var-service-sysbus.c  |  1 +
 hw/usb/pcap.c                 | 24 +--------
 hw/uefi/meson.build           |  1 +
 7 files changed, 144 insertions(+), 23 deletions(-)
 create mode 100644 include/qemu/pcap.h
 create mode 100644 hw/uefi/var-service-pcap.c

-- 
2.52.0


