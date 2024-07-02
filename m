Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C3CDC2BD09
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 02:01:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOSpY-00046a-3t; Mon, 01 Jul 2024 22:01:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1sOSp9-000450-VI
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 22:00:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1sOSp5-0007Uk-97
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 22:00:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719885645;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=It0W5IM7wJeGIjsVsxKbTO44vJZih+D6WlwuqDpaMcE=;
 b=eVGAvP6lCJ0qf/CmODqejeJGc8u0nV3lwmob9OgXeirSFnwuOhPl0tUa1lBpI7UuZIpeak
 9OEInSPc6z/MuxWx5naEYu0xXXLRA72GlYH72nSC/sRwXMgPErNcSeiGmKg2nRWIDgkm2H
 +F//5oAPHPncXJD+Fv6pzqDK0xjdnQI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-634-Qmua3bY1MQW4wU4Bw2ez2A-1; Mon,
 01 Jul 2024 22:00:42 -0400
X-MC-Unique: Qmua3bY1MQW4wU4Bw2ez2A-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5DDE11956096; Tue,  2 Jul 2024 02:00:41 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.30])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A48EF19560A3; Tue,  2 Jul 2024 02:00:37 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com, mst@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
Subject: [PATCH v4 0/2] virtio-pci: Fix the use of an uninitialized irqfd
Date: Tue,  2 Jul 2024 09:59:35 +0800
Message-ID: <20240702020033.139261-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The crash was reported in MAC OS and NixOS, here is the link for this bug
https://gitlab.com/qemu-project/qemu/-/issues/2334
https://gitlab.com/qemu-project/qemu/-/issues/2321

changelog v4 -> v3
 - Address the comments in V3
 - sperate the return check in kvm_virtio_pci_vector_use_one()
   in different patch
changelog v3 -> v2
 - Move the vector_irqfd check to virtio_pci_get_notifier().
   This function can also be used while vdev->status is not VIRTIO_CONFIG_S_DRIVER_OK.
   In that case, the vector_irqfd could be NULL, so also add the status check here.
 - Add the return value check for kvm_virtio_pci_vector_use_one().
   Since the return value of function virtio_pci_set_vector() is void,
   just add the error message here.

Cindy Lu (2):
  virtio-pci: Fix the use of an uninitialized irqfd
  virtio-pci: Add check the return of kvm_virtio_pci_vector_use_one

 hw/virtio/virtio-pci.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

-- 
2.45.0


