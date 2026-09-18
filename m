Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09FD9C982DA
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 11:40:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7WwW-0000Q1-8A; Fri, 18 Sep 2026 07:39:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x7WwU-0000Pk-VI
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 07:39:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x7WwS-0001cV-9i
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 07:39:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789731582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=LKSYJJbF1CnOtKRsw6x3RjE3m87irXE7r2mCU0EZIfY=;
 b=O09iGiKqy6dXhqglnQKLNtZnFHHIiIPG7WYWIZfQwyk7YLuyXUwTAvdD54YvBtodG5bAY5
 njHbwoHpms47IvDWn1QnwlUCfYfoFl7SLYZGLEW146sNHfvRH4XSk5rj1jZk+LQAd4LOYu
 1NXPqp0Ufm0k8DF280cEgiCDWVeNGGk=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-VDlAfkyNMmaypGkzhndCsw-1; Fri, 18 Sep 2026 07:39:40 -0400
X-MC-Unique: VDlAfkyNMmaypGkzhndCsw-1
X-Mimecast-MFC-AGG-ID: VDlAfkyNMmaypGkzhndCsw_1789731580
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-5328cdb38bcso12942421cf.3
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2026 04:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789731580; x=1790336380; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=LKSYJJbF1CnOtKRsw6x3RjE3m87irXE7r2mCU0EZIfY=;
 b=OkrwgZOocmML2D/yh0A8iDprOhSIE6rfOqOazcT8H+tmUJ+DVPt1dk5U1Ds/4WsTxu
 iUXhDTK6LRvywVbygiD7Si5Y1ofBBup2GZbpy1VVkGThGKsbFP5EW/2ptcesPKl0/+CB
 nDKeQk55vZXAQi2viFSmqorvVwwIM1v9F7r2MJJJJb8hulHhcOBC0cL+2JXU6HuZosMh
 ElOySGio+NKU8/0+q5DmsG7jCnrVr6VsukYVHxSgtVtU2UzxMy2xBLj1xE8wy64LOYuv
 hwv+G+vHJ74v+3yEf1DjtnNSs1Vw6s0R7gjoq4q8tYOaFCduuPiWuh9tuJNzVHZG5VuJ
 l7tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789731580; x=1790336380;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LKSYJJbF1CnOtKRsw6x3RjE3m87irXE7r2mCU0EZIfY=;
 b=I1WBqQYcqLeYf74TmzP98W9iw6py8XE8vjnZA681SKy7p+pyxF8Pokp/Sx6hOWihf5
 SiNO4MvQ33v0ygScMEg/iLAJi5otOniBf7N3qVpMsKSPJtgGOXEtbZ6yP2TrLtJfJBVC
 jTWnpk10r693oC3s7FJVg97EQIy62c0EnUIpLHBUQnvb5x/PJTE2pV2CuvF5EFxoEB0e
 lA/HsmH+z+m7YL5kc8zIJjIUgDmOzubla/VGsgjTjxOCEHmaTYW/UKGstCvD23it0k+E
 zDQP3mesES1Apq3CB6+7Ty+oItaDLB3UPN611DkpcqCYQVdXSO5uF8jVxP+HChP4GbVH
 7TRQ==
X-Gm-Message-State: AFuF++mvSnFe7lKWdKSfDMhp/oEnfQfg6d+aQmV9jt8eRPYWX76XHf5n
 +qefHCN/TgdUCSuK5YlkuAaCuVQY7YJimaQGtY1FYXSjAff2yu0nyOAn8WYLXV4r6RlTmn5APsK
 8/Eb7Kmm/AgOu2xqN884jtEtGDtN2Pijt7FdoZPijnBiu4+dAqByPMJhfPRq2yq6uY+cZWwYkcI
 bM4tiV57b4JfxeV5zqagL5Pns2TbAcd0/CPlJnbbGd
X-Gm-Gg: AYBFou3B7JU+HfgVL+tpuiSxIHy3qkyOTQ25tYD4DI5V/7nuM6MgaY0TvBNI7b4xBMs
 GjiP7LRpGYo+F0P/c47DNMuKuO9HREHHw02z830cm7cUsMydpECJ9GCG4PXgqTN8sMSBEx59Bq0
 EZnocNEYmA43xDOOTrUdot3MXkcY/Y2IV7TN5Umd2VXkqo6afzuq/YG47lrJ114TuPqqvpFg1QZ
 UX/R/oKzRrN/zPixwpc/R/nMjuLu+hs+ui1O5wNWrRg8Yy+2jaRZCaO0FS2Ap7m1jGPRL1UAEyj
 K9r6Cyl0smwnOwOZBzBs/grmjzanWd70CQGODsX6XXn7P0Bo3XLDtTHGskjS9vFr4VFW
X-Received: by 2002:ac8:5ac9:0:b0:530:7bd0:72a7 with SMTP id
 d75a77b69052e-5329e258415mr35662881cf.14.1789731579896; 
 Fri, 18 Sep 2026 04:39:39 -0700 (PDT)
X-Received: by 2002:ac8:5ac9:0:b0:530:7bd0:72a7 with SMTP id
 d75a77b69052e-5329e258415mr35662521cf.14.1789731579285; 
 Fri, 18 Sep 2026 04:39:39 -0700 (PDT)
Received: from localhost ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-532a1964d98sm11419631cf.7.2026.09.18.04.39.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 04:39:38 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 00/11] Next patches
Date: Fri, 18 Sep 2026 07:39:15 -0400
Message-ID: <20260918113926.831204-1-peterx@redhat.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit f8296b816fabd370307cd22b0270b610fc0fa279:

  Merge tag 'pull-loongarch-20260917' of https://github.com/bibo-mao/qemu into staging (2026-09-16 18:24:08 -1000)

are available in the Git repository at:

  https://gitlab.com/peterx/qemu.git tags/next-pull-request

for you to fetch changes up to 666dd3c9b10a70eea4aae3c09b0f945175a7cb8e:

  system/ram-discard-manager: fix offset_within_address_space in replay_by_populated_state() (2026-09-18 07:36:52 -0400)

----------------------------------------------------------------
Mem api pull

- Peter's patchset to drop some dead code for 32bit hosts
- Phil/Bin's patch to enhance error message for mem allocations
- Cam's fix to virtio-mem crash in multi-source work

----------------------------------------------------------------

Cam Miller (1):
  system/ram-discard-manager: fix offset_within_address_space in
    replay_by_populated_state()

Peter Xu (9):
  system: Define ram_addr_t to be always uint64_t
  hw/vexpress.c: Remove forced cast to u64
  arm/mps: Remove 32bit define for MPS3_DDR_SIZE
  xen-mapcache: Remove 32bit support
  bsd-user: Remove 32bit host support in thunk_convert|print()
  linux-user: Remove 32bit host support in thunk_convert|print()
  arm/aspeed: Drop ASPEED_RAM_SIZE
  hw/arm/raspi4b: Drop board_rev for 32bit hosts
  machine: Remove 32bit limitation on ram size

Philippe Mathieu-Daudé (1):
  system/physmem: Improve guest memory allocation failure error message

 include/hw/arm/aspeed.h           |  7 -----
 include/system/ram_addr.h         | 16 +++++------
 bsd-user/thunk.c                  | 47 ++-----------------------------
 hw/arm/aspeed_ast2600_anacapa.c   |  2 +-
 hw/arm/aspeed_ast2600_bletchley.c |  2 +-
 hw/arm/aspeed_ast2600_catalina.c  |  2 +-
 hw/arm/aspeed_ast2600_fby35.c     |  2 +-
 hw/arm/aspeed_ast2600_fuji.c      |  2 +-
 hw/arm/aspeed_ast2600_gb200nvl.c  |  2 +-
 hw/arm/aspeed_ast2600_sanmiguel.c |  2 +-
 hw/arm/mps2-tz.c                  |  9 ------
 hw/arm/mps3r.c                    |  8 ------
 hw/arm/raspi4b.c                  |  4 ---
 hw/arm/vexpress.c                 | 13 ++-------
 hw/core/machine.c                 |  8 ------
 hw/xen/xen-mapcache.c             | 12 ++------
 linux-user/thunk.c                | 47 ++-----------------------------
 system/physmem.c                  |  4 ++-
 system/ram-discard-manager.c      | 29 ++++++++++---------
 19 files changed, 43 insertions(+), 175 deletions(-)

-- 
2.55.0


