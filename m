Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C5ACD10380
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 21:32:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t45QK-0005ew-9K; Thu, 24 Oct 2024 17:31:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t45QD-0005dJ-82
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 17:31:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t45Q7-0005Wu-Jm
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 17:31:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729805461;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=waK0SxLlCMZvH2Z6KuwzI6H9OudIUBdj1ATI1NdvFQ4=;
 b=Uu962HiQtJeDmS4yvQREwvlfwfQAdTt/iMqroptFRixRaB+4POegVCYE6v/uqfggW4xlJE
 E5l7xXMVBxsTVtVCKOUkTy7Mvii2nZ1Zx/wayiDcVKHEMHbPyU6qW8hlKRtgmNcyL0zPTz
 FX+uvdojmlV0ivDtxHlpZ338FJPMoPc=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-a8cRkvS2PxmfXfHCtgg1-g-1; Thu, 24 Oct 2024 17:31:00 -0400
X-MC-Unique: a8cRkvS2PxmfXfHCtgg1-g-1
Received: by mail-yb1-f198.google.com with SMTP id
 3f1490d57ef6-e2e3321aae0so2618093276.1
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2024 14:31:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729805459; x=1730410259;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=waK0SxLlCMZvH2Z6KuwzI6H9OudIUBdj1ATI1NdvFQ4=;
 b=OhhUJDXT+5ENKa+vTEyn+2V0geUWMeLAfRInG9fYPOBB/9VQdI6+7Prm4jpkiFeTrL
 XKCxiN/WT9si9vkjx3ZpPX5oPUFM+Su8GzA3Nei6xUYLCKx8OCT0uTsd1oVIs6dKPSAX
 qpnCZ2/M1nohU4flQVe3sWSos8cZfEmd0qPQn/YO0aihV+SEu+V2ipa6AqQ7nLu0ZNbj
 s6Y/Te7cyQUmVaYLfddEJdw+nm36G+USvqPiQL9kRm+ESpD57BkslbCjncLxpaKv2Fmq
 B3JArZd7sYq2ixwVktSoB/1gw8MpRstB/IyyrNNCaMFu4mC8fdkJe2JeVCTSjltOEX72
 4vrQ==
X-Gm-Message-State: AOJu0YyHb9w9poQjPF/47hwHJuIys81K6lCzHrARHfqxGw8ZGAnoCto/
 fXeedxgRJ6RBnM2sc6/TCm7fKLPoVwFxElzdhNR8oJ9HEkETwJFCQNAG1j4LxetNzzM04yiQ7LI
 z9Lj5e49bWYFnH6wQwHDdYvZIndijubks54L/UaKyEMqOn0mLupjX7/2d227UflXw7NeZVMoEXs
 MopjJML+EsAVm0uyGHbI0u59t9xgrQfb3CeA==
X-Received: by 2002:a05:6902:843:b0:e24:9b99:c006 with SMTP id
 3f1490d57ef6-e2e3a601342mr8269532276.3.1729805458835; 
 Thu, 24 Oct 2024 14:30:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFAffsIwdgyRZLUo2z96rekBL01Pjyela9VDnxBhnPuWdmgizaV/OnqMNhsbBkgoIx0x67OLA==
X-Received: by 2002:a05:6902:843:b0:e24:9b99:c006 with SMTP id
 3f1490d57ef6-e2e3a601342mr8269500276.3.1729805458232; 
 Thu, 24 Oct 2024 14:30:58 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-460d3c3a434sm55465091cf.19.2024.10.24.14.30.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2024 14:30:57 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH v3 0/8] Migration: Make misc.h helpers available for whole VM
 lifecycle
Date: Thu, 24 Oct 2024 17:30:48 -0400
Message-ID: <20241024213056.1395400-1-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.263,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.697,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Based-on: <20241024165627.1372621-1-peterx@redhat.com>
CI:       https://gitlab.com/peterx/qemu/-/pipelines/1511349805

This is a follow up of below patch from Avihai as a replacement:

https://lore.kernel.org/qemu-devel/20241020130108.27148-3-avihaih@nvidia.com/

This is v3 of the series, and it happened again: changelog doesn't make
sense to compare to v2 because it's rewritten.  Meanwhile, now this series
is based on the other TYPE_SINGLETON series I posted just now:

https://lore.kernel.org/r/20241024165627.1372621-1-peterx@redhat.com

It turns out I found more things to cleanup, as the versions spin up.

Patch 1:     I found that object_ref() in migration thread is actually also
             racy..  this should fix it.

Patch 2-7:   It turns out I decided to clean things up first, then it'll
             make my last patch easier on adding the mutex protection for
             the current_migration reference

Patch 8:     The fix for NULL-dereference / race for the exported
             functions.  VFIO can hit it only because VFIO's specialty
             in using migration helpers in vmstate handlers, I guess.  I
             found most functions always safe because even if they're used
             outside migration/ they're most likely still invoked with
             migration thread context.  So I found only two functions that
             really need protections, exactly what VFIO is using.

Comments welcomed, thanks.

Peter Xu (8):
  migration: Take migration object refcount earlier for threads
  migration: Unexport dirty_bitmap_mig_init()
  migration: Unexport ram_mig_init()
  migration: Drop migration_is_setup_or_active()
  migration: Drop migration_is_idle()
  migration: Drop migration_is_device()
  migration: Unexport migration_is_active()
  migration: Protect updates to current_migration with a mutex

 include/migration/misc.h |  11 +---
 migration/migration.h    |   8 +++
 migration/ram.h          |   1 +
 hw/vfio/common.c         |   6 +-
 hw/virtio/virtio-mem.c   |   2 +-
 migration/migration.c    | 118 +++++++++++++++++++--------------------
 migration/ram.c          |   7 +--
 net/vhost-vdpa.c         |   3 +-
 system/dirtylimit.c      |   3 +-
 system/qdev-monitor.c    |   4 +-
 10 files changed, 81 insertions(+), 82 deletions(-)

-- 
2.45.0


