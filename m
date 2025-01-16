Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D271C02180
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 11:59:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYOWP-00025e-PT; Thu, 16 Jan 2025 06:58:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tYOWH-00024d-KT
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 06:58:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tYOWG-0002hz-7K
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 06:58:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737028719;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=NJIykBqPtz0yisBP/d4e/xMrl1W/4fF/Afa1IYPrb9s=;
 b=earGGLHMACNxzp+0FAflMe0yiPJuAccdK1h/mJ0kGhS8zKjuIQF5Ipv81w5eb7EpeFw5Fx
 rbEVtoEpUqlaaFmNYjqwSXnJ15mvPD3hSxKpNRUnAKXNp0b1/4RAAClroSIzn+/KLNNM4n
 9Efe9UJ/pCBOWuU306Zf/dCD4ahqo7Y=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-592-6YwOodMoNaS-XOuXwk2h6w-1; Thu,
 16 Jan 2025 06:58:33 -0500
X-MC-Unique: 6YwOodMoNaS-XOuXwk2h6w-1
X-Mimecast-MFC-AGG-ID: 6YwOodMoNaS-XOuXwk2h6w
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6C7B219560B0; Thu, 16 Jan 2025 11:58:31 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.129])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3AFA930001BE; Thu, 16 Jan 2025 11:58:27 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Jared Rossi <jrossi@linux.ibm.com>
Cc: qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>
Subject: [PATCH 0/3] pc-bios/s390-ccw: Fix problems related to network booting
Date: Thu, 16 Jan 2025 12:58:23 +0100
Message-ID: <20250116115826.192047-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.093,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.797,
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

The boot can currently fail after the s390-ccw bios used a network
device since we do not properly shut down the device afterwards, so
that incoming network packets can corrupt the memory. We have to make
sure to put the virtio-net device into a sane state again afterwards.

The third patch is unrelated, but I spotted this rather cosmetic
problem while working on the code in netmain.c, so I included it here,
too.

Thomas Huth (3):
  pc-bios/s390-ccw/virtio: Add a function to reset a virtio device
  pc-bios/s390-ccw: Fix boot problem with virtio-net devices
  pc-bios/s390-ccw/netmain: Fix error messages with regards to the TFTP
    server

 pc-bios/s390-ccw/virtio.h     |  2 ++
 pc-bios/s390-ccw/netmain.c    | 52 +++++++++++++++++++++--------------
 pc-bios/s390-ccw/virtio-net.c |  5 ++++
 pc-bios/s390-ccw/virtio.c     |  7 ++++-
 4 files changed, 44 insertions(+), 22 deletions(-)

-- 
2.47.1


