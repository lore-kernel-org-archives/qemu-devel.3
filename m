Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF7E7C88E53
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 07:26:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6NYJ-000798-0P; Tue, 15 Sep 2026 03:26:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x6NXk-0006uh-Lm
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 03:25:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x6NXi-0003nD-Lo
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 03:25:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789457125;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=7ugxBK0SzDzBMt31HU5DjxPmTLMVZtQFDlR+dPfgeKU=;
 b=D193EZUAz/wlVWTXelX3c5WyWzZ2fswht4VWxeVI9o9SmjZDP1Ob4UERcceJW7rUuexYyZ
 AwI8HeN3vT1NYLxqNl03oU9tzkYuJqSHVFQRLSGllaorUw7DHxi9oXq34aQuPmVmnCjrlj
 miIghof3anDYtCyi3YB9fPrkwdXXI4Q=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-106-V8u2OfESPxeU5hLcpJ_KnA-1; Tue,
 15 Sep 2026 03:25:21 -0400
X-MC-Unique: V8u2OfESPxeU5hLcpJ_KnA-1
X-Mimecast-MFC-AGG-ID: V8u2OfESPxeU5hLcpJ_KnA_1789457120
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AB34C1955F1C; Tue, 15 Sep 2026 07:25:19 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.23])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 22FE1418; Tue, 15 Sep 2026 07:25:15 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH 0/2] hw/pci-bridge: Add x-speed and x-width properties to
 xio3130 ports
Date: Tue, 15 Sep 2026 09:25:05 +0200
Message-ID: <20260915072507.1230187-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hello,

The xio3130-downstream and x3130-upstream devices lacks x-speed and
x-width device properties, making it impossible to configure PCIe link
speed/width when building PIX switch topologies for GPU/NIC passthrough.

Fix that and preserve migration compatibility with a 2.5GT/s x1 default.

Thanks,

C. 

Cédric Le Goater (2):
  hw/pci-bridge: Add x-speed and x-width properties to
    xio3130-downstream
  hw/pci-bridge: Add x-speed and x-width properties to x3130-upstream

 hw/core/machine.c                  |  4 ++++
 hw/pci-bridge/xio3130_downstream.c |  5 +++++
 hw/pci-bridge/xio3130_upstream.c   | 28 +++++++++++++++++++++++++++-
 3 files changed, 36 insertions(+), 1 deletion(-)

-- 
2.55.0


