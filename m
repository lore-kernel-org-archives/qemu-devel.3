Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CFB2C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:08:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu8gC-00033d-8W; Wed, 12 Aug 2026 09:07:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8fh-0002et-BZ; Wed, 12 Aug 2026 09:07:07 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8ff-00059F-F8; Wed, 12 Aug 2026 09:07:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786539783; bh=X02HZpprj3WdL+dxZSilIZgRWh4yftib1Hb1od/qMHo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=XLXH/eFBHKiVvsibJAIe1loHTxFDAzPURG91X7mghGTdVf/kicby++nUb4hF22teB
 OvwEng10xXhk7uw8OolxymcpFvNGj+I/Bct/Iqcbsic22UEGtikKmGuQOlcMcOPyZd
 szcD3GmfrlMY4lCvH7/zC2hOB38/gsCeMBpp2IF0lROZjZ+aouJc/nZExOlWZGreNS
 Tp+JeI2psyH8RZ3tFfpaJv9pMj/vwdT60o5gxXqtj0C+WEv/mc/6lM/MUJdmfplicZ
 lOY0DqI1QRxBxGRGL+1ZLjDDer6EClmujuegV8mROb+W7LM6fhlBMh3jKoENctVdks
 Es/ZbtvKG63lA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id DC6D41CA4AB;
 Wed, 12 Aug 2026 16:03:03 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 1EC60409B8E;
 Wed, 12 Aug 2026 16:03:15 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 3DD8C2F8EC; Wed, 12 Aug 2026 16:02:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Feifan Qian <bea1e@proton.me>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.13 044/102] vhost-user: assert nregions within limit
Date: Wed, 12 Aug 2026 16:01:19 +0300
Message-ID: <20260812130233.621965-44-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.13-20260812152851@cover.tls.msk.ru>
References: <qemu-stable-10.0.13-20260812152851@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: "Michael S. Tsirkin" <mst@redhat.com>

scrub_shadow_regions() and vhost_user_add_remove_regions() use
fixed-size stack arrays sized to VHOST_USER_MAX_RAM_SLOTS and index them
with dev->mem->nregions.

nregions is calculated to never overrun these, but let's add an assert
to make sure we don't get a stack overflow if there's a bug.

Fixes: f1aeb14b08 ("Transmit vhost-user memory regions individually")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3910
Cc: Stefano Garzarella <sgarzare@redhat.com>
Cc: Raphael Norwitz <raphael.norwitz@nutanix.com>
Reported-by: Feifan Qian <bea1e@proton.me>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <48fb8411f67e525872fb19618a886e52b670ab7f.1784896199.git.mst@redhat.com>
(cherry picked from commit cf89b769cdd1933796099706387d3b2a9a865cae)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 7961e3c9e85..073f6a15b9c 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -838,6 +838,9 @@ static int vhost_user_add_remove_regions(struct vhost_dev *dev,
 
     msg->hdr.size = sizeof(msg->payload.mem_reg);
 
+    /* Ensure nregions fits the fixed-size arrays used below. */
+    assert(dev->mem->nregions <= VHOST_USER_MAX_RAM_SLOTS);
+
     /* Find the regions which need to be removed or added. */
     scrub_shadow_regions(dev, add_reg, &nr_add_reg, rem_reg, &nr_rem_reg,
                          shadow_pcb, track_ramblocks);
-- 
2.47.3


