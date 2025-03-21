Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 393A8C36001
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 14:53:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvdje-0001Sx-9Y; Fri, 21 Mar 2025 10:52:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tvdjG-0001RO-Re
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 10:52:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tvdjE-0006T6-E6
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 10:52:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742568726;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=SJPoxA9DwjHUj0uT6L4qn7tpp8I19A7vgi2wP15Y35I=;
 b=OPClsG4+FKuw56K2XM1SPKxF5jSNFn7N4MefMDrXNBzMT2CUwG4fcKIwBgfJ6FBNfTcb57
 MSHXdcrsH4xQD6Prle3Z6T4J3tgk1Yna46LEIWK7SAPyMb9kNQu7Kfkxy9EVK2u1uBNX3H
 88ZsteFlyBbkRUH6X6VA4H+G/86SUqU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-251-dcXgGCVLPiyw5nuyj5zYBQ-1; Fri,
 21 Mar 2025 10:52:05 -0400
X-MC-Unique: dcXgGCVLPiyw5nuyj5zYBQ-1
X-Mimecast-MFC-AGG-ID: dcXgGCVLPiyw5nuyj5zYBQ_1742568724
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5EF06196D2D6
 for <qemu-devel@nongnu.org>; Fri, 21 Mar 2025 14:52:04 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.22.74.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C1FBC1800946
 for <qemu-devel@nongnu.org>; Fri, 21 Mar 2025 14:52:03 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C358C21E675E; Fri, 21 Mar 2025 15:51:58 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com
Subject: [PULL 0/8] Error reporting patches for 2025-03-21
Date: Fri, 21 Mar 2025 15:51:50 +0100
Message-ID: <20250321145158.3896812-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
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

The following changes since commit 1dae461a913f9da88df05de6e2020d3134356f2e:

  Update version for v10.0.0-rc0 release (2025-03-18 10:18:14 -0400)

are available in the Git repository at:

  https://repo.or.cz/qemu/armbru.git tags/pull-error-2025-03-21

for you to fetch changes up to a725bc970e3091499be8be52798c21259f91b2cd:

  target/loongarch: Clean up virt_cpu_irq_init() error handling (2025-03-20 07:58:19 +0100)

----------------------------------------------------------------
Error reporting patches for 2025-03-21

----------------------------------------------------------------
Bibo Mao (4):
      target/loongarch: Fix error handling of KVM feature checks
      hw/loongarch/virt: Eliminate error_propagate()
      target/loongarch: Remove unnecessary temporary variable assignment
      target/loongarch: Clean up virt_cpu_irq_init() error handling

Markus Armbruster (4):
      cryptodev: Fix error handling in cryptodev_lkcf_execute_task()
      error: Strip trailing '\n' from an error string argument
      hw/xen: Fix xen_bus_realize() error handling
      hw/xen: Downgrade a xen_bus_realize() non-error to warning

 backends/cryptodev-lkcf.c         |  3 +++
 hw/loongarch/virt.c               | 39 +++++++++++++++------------------------
 hw/xen/xen-bus.c                  |  8 ++++----
 target/loongarch/kvm/kvm.c        |  8 ++++++--
 target/loongarch/tcg/tlb_helper.c |  5 ++---
 net/vmnet-common.m                |  2 +-
 6 files changed, 31 insertions(+), 34 deletions(-)

-- 
2.48.1


