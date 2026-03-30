Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1730710D14A2
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 11:50:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7B8Z-0002wO-MP; Mon, 30 Mar 2026 07:50:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w7B8V-0002qP-78
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 07:50:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w7B8S-0005u8-1P
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 07:50:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774871422;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=AtLFjjmIXc63zaKE/Bi8BHRcLRHQMdA48VRbb4WG0rQ=;
 b=Jug1oaLsADSjup/QqZ0GaJdxPne/rw/5fxYcID1p64KV2UD3zgQee3Oq/64vRU7CqO60YT
 tHoUK7KXuQQiP0Dh5JyJW9TkFey2VwV3eJR4wPgu5DGGWwcwEGkJ4HU7NqLWd0oyOPLz4K
 lPhAeaWCREJ5XV36Gigh9+/LPru5biY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-154--Sx_bifsPgaz1JJJn2gNZQ-1; Mon, 30 Mar 2026 07:50:21 -0400
X-MC-Unique: -Sx_bifsPgaz1JJJn2gNZQ-1
X-Mimecast-MFC-AGG-ID: -Sx_bifsPgaz1JJJn2gNZQ_1774871420
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-43cf5b4dac8so1634041f8f.0
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2026 04:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774871419; x=1775476219; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=AtLFjjmIXc63zaKE/Bi8BHRcLRHQMdA48VRbb4WG0rQ=;
 b=F9iyUd8rhf49wwgXJZmTRswXGjIhAbxu0NC+oblOzfcIltLWhYIFd/rakNCmRA1uQG
 Id5fJbF/N+K04wDdg9u/lbmeC1i80lR6pA8GawHQWtvHZXxbLHT5L3vurzq7Pc7roZx2
 Fjj3EYLq1NeqsDtuz6gfFVnHfBboH24q9o2jGXHpWOov0resp8/zKSs/NHzBgkr8pCOQ
 AatoMvrFaJ3RXJm4ESUuLgX0yEODwGpP0ge+zfBmNCxdcUpzdXw0PsguMCNrrm7RxXBd
 W68zLO0WG//hR+ukBEXK1kbBIH6jBWejHKJ5VdfXQeFKBvX+w1gZHTrC+Tas4VK2SrI2
 zH7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774871419; x=1775476219;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AtLFjjmIXc63zaKE/Bi8BHRcLRHQMdA48VRbb4WG0rQ=;
 b=UAPWcuuYryq7LLrMnkHeR3xi9TXP1bNIBrCrv6VQampypujPh3P436RM0+7VpBEBr+
 UIkRc4YwF7TCfhes58LPCx80z6weXAcXP/Hlk8T7kAE157Bh6haxh/Djw5aWCc8vZjlI
 84qDjeiEcGDiTDvv7haBXqpcpgPxpIDyAbkWJ8PwF+ckpuWp+JWEDXdYR8isnJLEkvCG
 kK6Rh9ywn9Mfr4FixRs+QZHpeB4J0abMvYxHB7DH7EGCcmXcYYJ+G4Px+0OA7WekgXkd
 VHDGJeB6uNK8lEtgOQZ59AKGM/Zun50d08mKyT+JqVvtnd+thTrbArs0wAyE1OoGH3bA
 JikA==
X-Gm-Message-State: AOJu0YwhsWs73ObBp6PENpuC8Y2XBzaxVj/tctuqueGLkR/NRRm59WAx
 L9+aBO+JFpg+B8ddUpv9lBeV9dLT6nTGu+JwI0WvLe+R51qxQojkFy4A6kHp/8T2fH+fRFL0FlS
 hoa3b1pXS9JhgGH9sgOKliTTLzBfIJ9eUMGfiW0TXT9Ty+JfMKanFEhq+DD1YuvuAHUFD6TK6x9
 vgJUckF8kxH6NPOtqSnFFw0oKYWSjdfEcr4MWcpF3l
X-Gm-Gg: ATEYQzxHU1TY4l9Pryw1EJbmNFrbyRz3VWaXJL/07NkVJuvp+rPIM0/qEb0TXlZQYlc
 yHS58gx9rzejFpo77j7Qjh/TUdArPt3ef/HJgM+RTo0zIRxiDrQ517vIKLF/HIk8kDjsE2/2n8R
 gLRxOKsQJAIuPiD8LaiTBW1BGUxxc5rMZNj/AwBJnTH7sBdYUCwPg+PWh62c5Z0VpJfbqA5yAZv
 x8UjSHgbg0K/RDKSu4JNF3L0XdLk0NaKnPgSJ03+yIMevnRW/vEjx3WghRNbdFTYM2HDnlE16EA
 l9hbaa7tWEfBfctjNi9x4sccU2ZMtVH4JNlrIZhlGZkRZw4nxnP9X+jWnib2F6Xu8RKw65fZOex
 IF6s/pp2NjKuLCDbpUuaY3SD+T6S3DP/pHdrPOrdDJEQGGbvPB2IX0ldc1FO40F9wN+eeYw2oBh
 2+owVJJ6VPjLnknjlUNVXtcVkn
X-Received: by 2002:a5d:5d10:0:b0:439:ae2a:755e with SMTP id
 ffacd0b85a97d-43b9e9a9785mr21097650f8f.23.1774871419004; 
 Mon, 30 Mar 2026 04:50:19 -0700 (PDT)
X-Received: by 2002:a5d:5d10:0:b0:439:ae2a:755e with SMTP id
 ffacd0b85a97d-43b9e9a9785mr21097576f8f.23.1774871418306; 
 Mon, 30 Mar 2026 04:50:18 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43cf21eb95fsm20521958f8f.12.2026.03.30.04.50.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 04:50:17 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/12] i386, lsi patches for QEMU 11.0-rc2
Date: Mon, 30 Mar 2026 13:50:04 +0200
Message-ID: <20260330115017.256211-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The following changes since commit 91f6a9cb1b0f11afa74ef7fb20d5579d9dfbe020:

  Merge tag 'qga-pull-2026-03-27' of https://github.com/kostyanf14/qemu into staging (2026-03-27 18:41:05 +0000)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 0f254f70d4fcf668b27bd7c5970761afe13589c7:

  hw/acpi: Do not save/load cpuhp state unconditionally (2026-03-30 12:14:22 +0200)

----------------------------------------------------------------
* more WHPX fixes and documentation
* hpet: fix bounds check for s->timer[]
* hpet: lower HPET_MAX_TIMERS to 24
* lsi53c895a: keep SCSIRequest alive during DMA
* lsi53c895a: keep device alive during SCRIPTS execution
* hw/acpi: fix save/restore for MIPS Malta machine

----------------------------------------------------------------
Mohamed Mediouni (4):
      meson.build: remove i386-softmmu WHPX support
      docs: add WHPX section with initial info
      whpx: i386: trace unsupported MSR accesses
      target/i386: emulate: remove redundant logging for unmapped MMIO access

Paolo Bonzini (7):
      hpet: fix bounds check for s->timer[]
      hpet: lower HPET_MAX_TIMERS to 24
      lsi53c895a: keep a reference to the device while SCRIPTS execute
      lsi53c895a: do not do anything else if a reset is requested by writing ISTAT0
      lsi53c895a: keep lsi_request and SCSIRequest in local variables
      lsi53c895a: keep lsi_request alive as long as the SCSIRequest
      lsi53c895a: keep SCSIRequest alive during DMA

Zhao Liu (1):
      hw/acpi: Do not save/load cpuhp state unconditionally

 MAINTAINERS                      |   1 +
 docs/system/index.rst            |   1 +
 docs/system/whpx.rst             | 144 +++++++++++++++++++++++++++++++++++++++
 meson.build                      |   3 +-
 include/hw/timer/hpet.h          |   2 +-
 target/i386/whpx/trace.h         |   2 +
 hw/acpi/ich9.c                   |   8 +++
 hw/acpi/piix4.c                  |   8 +++
 hw/scsi/lsi53c895a.c             |  71 ++++++++++++-------
 hw/timer/hpet.c                  |  11 +--
 target/i386/emulate/x86_mmu.c    |   3 -
 target/i386/whpx/whpx-all.c      |   5 +-
 rust/hw/timer/hpet/src/device.rs |   2 +-
 target/i386/whpx/trace-events    |   1 +
 14 files changed, 224 insertions(+), 38 deletions(-)
 create mode 100644 docs/system/whpx.rst
 create mode 100644 target/i386/whpx/trace.h
 create mode 100644 target/i386/whpx/trace-events
-- 
2.53.0


