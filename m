Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A1EBFCA187
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 20:41:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzhPE-0004hj-5v; Mon, 09 Mar 2026 16:40:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vzhP2-0004eR-40
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 16:40:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vzhOl-0007gL-Uv
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 16:40:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773088817;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=9YX58P0SmrR/s5nkf1YmH956fxr9ZlSayKiY+oD0FrY=;
 b=R5uhhCsst7Rm7W+3gnLJU9e8+TL4FBZ26pfE13v4j1ZxajR00MBv5WvJKHzmpXfe7d8wig
 8jGF9eXMPA386ktbRLNx3ffruBdtac+8zsM8jitJZeuU1hKbNIX4p/AXZDAQoFGlGERkfk
 zwiusiJwj+1FOGmFCvSBQgrg1i/N0IM=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-uYSmySbWM8GSmU-fHyOwIQ-1; Mon, 09 Mar 2026 16:40:16 -0400
X-MC-Unique: uYSmySbWM8GSmU-fHyOwIQ-1
X-Mimecast-MFC-AGG-ID: uYSmySbWM8GSmU-fHyOwIQ_1773088816
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8cd81ce6fdcso1750705385a.3
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 13:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773088815; x=1773693615; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9YX58P0SmrR/s5nkf1YmH956fxr9ZlSayKiY+oD0FrY=;
 b=SXBBzOw/JaLszlWy/jcV7qXuGhGPu/JhMb++MuxsHjV3MntbCaEo/cJPE+geoh1Sx6
 Zlp73PYACB4KQjBtPb1o4pYDcblDh3+w6668UzCbqovdmeJAFOXz02B+meobePB5JSfq
 zi51zG1j9T/FuHfrXs6geY9nw2twUnD81Efg97vFxZGyjOAIrZsoIqAtqYOLZSXQeGzT
 +6rHxqdYMft1rkvQ6rt94Wc0VG3hEm3zTCldUDwXx/iGB9RIpqzkxVI+zlDr6ukK+P5h
 wMAgkDarlD78LxTWvG2ceFlUMG9Q1k9JC+5DmRLCJSd6fMBpbDYSAYWhIUD3XpOSuy3s
 s7AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773088815; x=1773693615;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9YX58P0SmrR/s5nkf1YmH956fxr9ZlSayKiY+oD0FrY=;
 b=sKSIfaxHMoMBujp0VSfb3Bavlamdftp53iceRT4Q+kc9MnulbVg5Rga22yMsWUw6K4
 KXZBTWGDD/YBn4O9TBi3GzX7SR6opwUb4vcH8fcT26ODZJy63de2NZhWCwnnUDCYgXb/
 k0ab/dLiVgEntd6QbdDQvHeMK1JUvy0UQpfXZseON3x6EMxcpJLbCIzvjT7DIXYzpXSL
 m36wUl+4hrVF/G7wt8/cg7rdCxmf7oT/Fu/Qb0/QYePeSmUnDamENBxhT4zTC0uSvZM9
 iWUwzXGt0RJD0xwu78oxfaEmGe9nxNbZth5vjfUylmh4xevgSebSKDmVx9JVeiNRStvJ
 CW+A==
X-Gm-Message-State: AOJu0YwYaV0fesAq7PYi+mO147h7J9BW+0dAhGIeBhSwqK+fOAzXR7oC
 fkJ2/01LS5HsfKd3MWxupWMnTw+F5EKHy+V4GR46lrKbQb2Q3HPJFuses5CsitlIPUu4ESeemfQ
 7GCnrDDDiEXTq++hndxSSmH5RZ4cg3TiuTxEZOYYKZgWd7/xEKt6O/HTlD/WKL9g4BrIeUluR/z
 DbJkU/9VJA2tFBqmVFpwvnwHAFmECFbvCy4dhGGw==
X-Gm-Gg: ATEYQzxhj37cDtRpk/Dg8Irf66Acz7KUdoR6VF/AkAkHR/6cSYmM6yE/uHAeGXcDDbE
 tBoFQR4WA7Z8gnboqtYaf5SFJU+2o2UW8S1qMj9w2hTUQXRyEHxXql1XecCgE/upQZrmgN2pI9o
 h6rDfPdUsVeJ0mjmCwe9Iw3QN6tN6bv2cGs6MVeMCftiYKCp1gP/4sgcbv4h8cqgAaj3LlkJ5IF
 TRYHqV6n09nMQ4IKhUGSqRfZPJiN9CKaTK27s2iTQH8mraNYEYapkJ97/4ni0oROUdjw4W48pFV
 s/set8Z908zI4aZJOxIeMWIiLFcsy3IUs0yrSFLnZ9wyTtzEImGNL8TewI70HLiUYfGPHvBaiCT
 UEq8gDeBlHVpbbq0VwGQ4btGcCdMmus3AdP2LSs9HFCCSJyyu22NIiPNrQQU5RcVGPdrhHZQkHx
 pY+3o48g==
X-Received: by 2002:a05:620a:3d09:b0:8cd:7e1d:8243 with SMTP id
 af79cd13be357-8cd7e1d8678mr668181885a.36.1773088815354; 
 Mon, 09 Mar 2026 13:40:15 -0700 (PDT)
X-Received: by 2002:a05:620a:3d09:b0:8cd:7e1d:8243 with SMTP id
 af79cd13be357-8cd7e1d8678mr668178685a.36.1773088814759; 
 Mon, 09 Mar 2026 13:40:14 -0700 (PDT)
Received: from x1.local
 (bras-vprn-aurron9134w-lp130-03-174-91-117-149.dsl.bell.ca. [174.91.117.149])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cd8576db0esm332951885a.47.2026.03.09.13.40.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 13:40:14 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Peter Xu <peterx@redhat.com>
Subject: [PULL 00/18] Staging patches
Date: Mon,  9 Mar 2026 16:39:49 -0400
Message-ID: <20260309204007.1709441-1-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

The following changes since commit 7608a95d2e0bd8c8d069ab77824d02586dd94648:

  Merge tag 'pull-xen-20260309' of https://xenbits.xen.org/git-http/people/aperard/qemu-dm into staging (2026-03-09 12:15:42 +0000)

are available in the Git repository at:

  https://gitlab.com/peterx/qemu.git tags/staging-pull-request

for you to fetch changes up to 40aa899d030e957f815beab33e997a1970914580:

  system/memory: Have memory_region_type() correctly describe containers (2026-03-09 15:27:26 -0400)

----------------------------------------------------------------
Memory pull for 11.0 softfreeze

- BALATON's memory cleanups on _nomigrate MRs and else
- Phil's small constify series and else
- Marc-André's initial cleanup patches around ram discard manager

----------------------------------------------------------------

BALATON Zoltan (9):
  hw/display/{cg3.tcx}: Do not use memory_region_init_rom_nomigrate()
  memory: Remove memory_region_init_rom_nomigrate()
  sun4m,sun4u,tcx: Do not use memory_region_init_ram_nomigrate()
  hw/xtensa/xtfpga: Do not use memory_region_init_ram_nomigrate()
  memory: Remove memory_region_init_ram_nomigrate()
  memory: Shorten memory_region_init_ram_device_ptr and
    memory_region_init_rom_device
  memory: Add internal memory_region_register_ram function
  memory: Factor out common ram region initialization
  memory: Factor out common ram ptr initialization

Marc-André Lureau (5):
  system/rba: use DIV_ROUND_UP
  memory: drop RamDiscardListener::double_discard_supported
  virtio-mem: use warn_report_err_once()
  system/memory: minor doc fix
  kvm: replace RamDicardManager by the RamBlockAttribute

Philippe Mathieu-Daudé (4):
  system/ramblock: Constify various RAMBlock arguments
  system/memory: Constify various MemoryRegion arguments
  system/xen: Constify various MemoryRegion arguments
  system/memory: Have memory_region_type() correctly describe containers

 docs/devel/memory.rst                         |   9 +-
 .../memory-region-housekeeping.cocci          |  47 ---
 include/system/memory.h                       | 101 ++----
 include/system/ramblock.h                     |  28 +-
 include/system/xen-mapcache.h                 |   2 +-
 include/system/xen.h                          |   6 +-
 accel/kvm/kvm-all.c                           |   2 +-
 hw/display/cg3.c                              |   5 +-
 hw/display/tcx.c                              |   8 +-
 hw/display/vga.c                              |   4 +-
 hw/sparc/sun4m.c                              |  19 +-
 hw/sparc64/sun4u.c                            |  10 +-
 hw/vfio/listener.c                            |   2 +-
 hw/virtio/virtio-mem.c                        |  35 +-
 hw/xen/xen-hvm-common.c                       |   8 +-
 hw/xen/xen-mapcache.c                         |   2 +-
 hw/xen/xen_stubs.c                            |   6 +-
 hw/xtensa/xtfpga.c                            |   4 +-
 stubs/physmem.c                               |   2 +-
 stubs/ram-block.c                             |   6 +-
 system/memory.c                               | 322 ++++++------------
 system/physmem.c                              |  30 +-
 system/ram-block-attributes.c                 |  26 +-
 23 files changed, 203 insertions(+), 481 deletions(-)

-- 
2.50.1


