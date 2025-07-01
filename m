Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41AC3C7EE30
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 12:20:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWZyH-0001nO-Hs; Tue, 01 Jul 2025 08:20:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osteffen@redhat.com>)
 id 1uWZxt-0001VL-BH
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 08:20:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osteffen@redhat.com>)
 id 1uWZxo-00060x-Qb
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 08:19:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751372390;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=/Wh43dlIxiKayUAW/iT//dkdmqOWWGxS0IDlmg4aCHM=;
 b=Q/YeqP5YF2PGf7k4LZBlyTk0HRpiEDXM+GaGJ1vvytlytwB1V57dNiCpSyGq3UyG4358jm
 +6O9vsnubJhXUmBn6Mc66Np6vrppTPpbiFfIPIozg+PszWU6F6RMfNnkOVidtELnN5yq3H
 VCyAjBIwCMt6BkgTULr+PzE/S/6T2Ug=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-554-Gk2YYWlgPjalsOw_ILWMSA-1; Tue,
 01 Jul 2025 08:18:23 -0400
X-MC-Unique: Gk2YYWlgPjalsOw_ILWMSA-1
X-Mimecast-MFC-AGG-ID: Gk2YYWlgPjalsOw_ILWMSA_1751372302
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0820A18011F9; Tue,  1 Jul 2025 12:18:22 +0000 (UTC)
Received: from osteffen-laptop.redhat.com (unknown [10.45.225.251])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 17D3A19560AB; Tue,  1 Jul 2025 12:18:16 +0000 (UTC)
From: Oliver Steffen <osteffen@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Joerg Roedel <joerg.roedel@amd.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Oliver Steffen <osteffen@redhat.com>
Subject: [RFC 0/2] Add SVSM virtio-mmio device slots (q35)
Date: Tue,  1 Jul 2025 14:18:13 +0200
Message-ID: <20250701121815.523896-1-osteffen@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=osteffen@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Coconut SVSM recently gained support for virtio-blk devices using the
virtio-mmio transport [1].  This series adds dedicated virtio-mmio device slots
to the q35 machine type, inteded for use by an SVSM.

The feature is disabled by default and enabled via the new
`-machine q35,x-svsm-virtio-mmio=on` option. The slots are mapped starting at
base address `0xfef00000`, with each slot on a separate page. IRQs are not
wired; the SVSM must use polling mode to drive the devices.

The SVSM discovers the slot base addresses through a
`HARDWARE_INFO_SIMPLE_DEVICE` entry in the `etc/hardware-info` fw_cfg file [2].
This uses a dedicated device ID previously registered in EDK2 [3].

This series depends on the IGVM support series from Roy Hopkins [4]. While
there is no direct code dependency, the IGVM support is required to launch the
SVSM, which is the sole consumer and the only practical means of testing this
feature.

The virtio-mmio transport was chosen for its implementation simplicity. This
approach minimally impacts the guest-visible hardware, reserving only a small
MMIO region.

Any feedback would be greatly appreciated.

- Oliver

[1] https://github.com/coconut-svsm/svsm/pull/635
[2] See commit 8d127aa866
[3] https://github.com/tianocore/edk2/pull/10850
[4] https://lists.gnu.org/archive/html/qemu-devel/2025-06/msg02324.html

Gerd Hoffmann (1):
  q35: add virtio-mmio slots

Oliver Steffen (1):
  hw/uefi: Add hardware-info ID for virtio mmio devices for SVSM

 hw/i386/pc.c                    | 18 +++++++++++++++++-
 hw/i386/pc_q35.c                | 15 +++++++++++++++
 include/hw/i386/pc.h            |  1 +
 include/hw/uefi/hardware-info.h |  1 +
 4 files changed, 34 insertions(+), 1 deletion(-)

-- 
2.50.0


