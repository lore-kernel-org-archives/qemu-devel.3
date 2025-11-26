Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC4BBD10F5A
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 14:26:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOGTA-0000NO-Fm; Wed, 26 Nov 2025 09:26:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vOGT9-0000Mv-HH
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 09:26:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vOGT7-0006YH-GE
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 09:26:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764167164;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=G7crx/ptxNHPtLDkEeafgGia8h4RLkXCOixz50anNAc=;
 b=QRaChPQ+KlMT4QxglO3ltTvBci8acKNb0BH4Hq3/0QmWLl5QMLd0/ecLkIc3SvJ8YAD2YY
 qHu/hZHt9BHAaKq6417D+T2p/WhwthVoqCYi8wmkA1OpVggOdKGoTUQGO9J/j0Y0HwFLMh
 R19otE4NcU+miExfmFT6UAPic1pInu0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-688-hjmwdbceN9aJEt7KG6oIzQ-1; Wed,
 26 Nov 2025 09:26:02 -0500
X-MC-Unique: hjmwdbceN9aJEt7KG6oIzQ-1
X-Mimecast-MFC-AGG-ID: hjmwdbceN9aJEt7KG6oIzQ_1764167162
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 211191800673
 for <qemu-devel@nongnu.org>; Wed, 26 Nov 2025 14:26:02 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.33.126])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B661E1956056; Wed, 26 Nov 2025 14:26:01 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 896421800391; Wed, 26 Nov 2025 15:25:59 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 0/2] hw/uefi: add pcap support
Date: Wed, 26 Nov 2025 15:25:57 +0100
Message-ID: <20251126142559.4081483-1-kraxel@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.224,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



Gerd Hoffmann (2):
  move pcap structs to header file
  hw/uefi: add pcap support

 include/hw/uefi/var-service.h | 10 ++++
 include/qemu/pcap.h           | 27 ++++++++++
 hw/uefi/var-service-core.c    |  7 +++
 hw/uefi/var-service-pcap.c    | 94 +++++++++++++++++++++++++++++++++++
 hw/uefi/var-service-sysbus.c  |  1 +
 hw/usb/pcap.c                 | 24 +--------
 hw/uefi/meson.build           |  1 +
 roms/edk2                     |  2 +-
 8 files changed, 142 insertions(+), 24 deletions(-)
 create mode 100644 include/qemu/pcap.h
 create mode 100644 hw/uefi/var-service-pcap.c

-- 
2.52.0


