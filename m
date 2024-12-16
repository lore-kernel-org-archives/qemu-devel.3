Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D71F8E7717F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 10:51:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tN8h3-0004Kf-7o; Mon, 16 Dec 2024 05:51:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tN8gv-0004GT-GN
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 05:51:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tN8gq-0005Of-7G
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 05:51:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734346262;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=3M/YbKUMGrx8WZAVoiQ3C0yOsLDE0q8Y9tIYuX/z+Bc=;
 b=BJcEgdafjwH2hD2ux6Z02wWE1PQK3dmLgmtlP2ihS4fIoTInHlAVns1tbLF/HoLwhZvvIH
 WAVzJjAGmMnNhzwUodD48erxJDpo9hiClhIEe4iRnggeeLPEDgZvP+zleJaSkoiaUkYeQH
 WpSdGiSboagfAtNAOnpXIoIFitmpd0s=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-310-Vr-Pg84-PyugRgo3YWYZTg-1; Mon,
 16 Dec 2024 05:50:58 -0500
X-MC-Unique: Vr-Pg84-PyugRgo3YWYZTg-1
X-Mimecast-MFC-AGG-ID: Vr-Pg84-PyugRgo3YWYZTg
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C0BFC19560AE; Mon, 16 Dec 2024 10:50:56 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.88])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0730630044C1; Mon, 16 Dec 2024 10:50:56 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id AD1D018000A9; Mon, 16 Dec 2024 11:50:53 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 0/7] Firmware 20241216 patches
Date: Mon, 16 Dec 2024 11:50:46 +0100
Message-ID: <20241216105053.246204-1-kraxel@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.168,
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

The following changes since commit ca80a5d026a280762e0772615f1988db542b3ade:

  Merge tag 'hw-misc-20241214' of https://github.com/philmd/qemu into staging (2024-12-14 08:42:53 -0500)

are available in the Git repository at:

  https://gitlab.com/kraxel/qemu.git tags/firmware-20241216-pull-request

for you to fetch changes up to 0f5715e4b5706b31b3550d8e6b88871e029c7823:

  roms: re-add edk2-basetools target (2024-12-16 07:31:28 +0100)

----------------------------------------------------------------
x86/loader: fix efi binary loading
x86/loader: support secure boot with direct kernel load
firmware: json descriptor updates
roms: re-add edk2-basetools target

----------------------------------------------------------------

Gerd Hoffmann (5):
  x86/loader: only patch linux kernels
  x86/loader: read complete kernel
  x86/loader: expose unpatched kernel
  x86/loader: add -shim option
  roms: re-add edk2-basetools target

Heinrich Schuchardt (1):
  pc-bios: add missing riscv64 descriptor

Pratik R. Sampat (1):
  pc-bios: Add amd-sev-es to edk2 json

 include/hw/boards.h                      |  1 +
 hw/core/machine.c                        | 20 +++++++++++++++
 hw/i386/x86-common.c                     | 32 +++++++++++++++++++-----
 system/vl.c                              |  9 +++++++
 pc-bios/descriptors/60-edk2-riscv64.json | 31 +++++++++++++++++++++++
 pc-bios/descriptors/60-edk2-x86_64.json  |  1 +
 pc-bios/descriptors/meson.build          |  3 ++-
 qemu-options.hx                          |  7 ++++++
 roms/Makefile                            |  5 ++++
 9 files changed, 102 insertions(+), 7 deletions(-)
 create mode 100644 pc-bios/descriptors/60-edk2-riscv64.json

-- 
2.47.1


