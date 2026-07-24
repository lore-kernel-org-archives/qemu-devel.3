Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B47CEC531F9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 12:30:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnF2d-0004K0-Ut; Fri, 24 Jul 2026 08:30:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wnF2b-0004En-HI
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 08:30:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wnF2Y-00068W-FG
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 08:30:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784896209;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=TkuP5HCHOoSqszy7XSSKeVYxt42ef3mPNiA1uuPbrr8=;
 b=Bdth+o7I6suyBoPeDSbNhESr0vcp8DE2XyrrSFD+f9qd9V8t0t7kkxYu5PT3yB/n12AnNo
 4tZRoobP3neR5TNCejmO8UPMmc+399cq7gWNLx/NhihMEeI+Vq9vpk3vo6L4GAj7VoDOtM
 xxl7J4K9Ww7+Lfd+GRBqangR8uXI1O0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-378-Ordn8RtKNpad4NPtWW6-zw-1; Fri, 24 Jul 2026 08:30:07 -0400
X-MC-Unique: Ordn8RtKNpad4NPtWW6-zw-1
X-Mimecast-MFC-AGG-ID: Ordn8RtKNpad4NPtWW6-zw_1784896206
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-47f9ae25143so349750f8f.2
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 05:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784896206; x=1785501006; darn=nongnu.org;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=TkuP5HCHOoSqszy7XSSKeVYxt42ef3mPNiA1uuPbrr8=;
 b=rB2uKia0wODtjxhJGyZEtbydbrGMlTeZktUd/NZl/0Ew80Se8TAeyLgnp8aMFDMoLy
 mO3GrJymmjgcKKDpNRHZKuNRtCOy2U7mn2SNwTsDckK1xi5ogEA7soLJXsiUFrKevuB9
 zItKdCa9mOjK5tAg/OJ3M4dLPeNYadEcVXqWmcTsT0e2o1h2tRJeigi5XsVKK9rlBHkp
 MVEK8LZ8pQGfl7nyPagpDIiRc8Q7R8CXEwU1atz4dixE961NvzA8D04YZmS2TdXO131S
 er9gwiGK7NjFalzMMDS4lMu+N0raT7GTmzWhCtCQRH/cpMbGXtcw0oQsPWb0DYcJTExh
 8qWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784896206; x=1785501006;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TkuP5HCHOoSqszy7XSSKeVYxt42ef3mPNiA1uuPbrr8=;
 b=Du9urmAZVITrk1FwF6uc5wYNLUc3FhFBfbzTQkBhqWYwCleEe6xkyv3di9WGPIVwW6
 UHA1UdHUe28ujhypqbcfES96kCHAle7nBIyCYfzQ5dTjlzP5FkM0ijPjGtZBYJEoW7Sf
 499rKqasflCA/7PPhrSoxx4RlexfXeKc4Lfkt0LsPJr1TNLlj1OJMTVfIAhsSGBWtZkd
 Pf5GHmeBrvmjv890ZqDE1YziIOXgpvQ8huw94fr1vuZ/eyz03e5v0iKIBt7chHtYm57p
 zrhGE6ovewGvhNZBG99oqgV9grUcTK1DyXzzr2o9r5RimqbQKuerlSYE6tfA3OIFRQoJ
 GI1g==
X-Gm-Message-State: AOJu0YxMK4WwOB6c0gl/b/+pNJIh4I830gI3oqiU5es4U129iMTZClUq
 5a8FRpfcYtotCpgJGkxr6NutYzaMNVdLrTjpyEyotUocOoPG/qIrHTyoZtVxvFJKN67gNLKvf7Y
 T3cGUJCtH/SkFRfplze4KKQIX0u5hImGs2vnXiCbvdgKG4FCFn+i+GoNq/T1JTr/LH0UTNO945p
 VUrvyi8CcLvK6d1Ve7sq9V+tYOGvXHCtmHHw==
X-Gm-Gg: AR+sD12Qc0W31JyWV3GKbE70jRttOG7K+RcO7wuvB8alQcyMkHm40kjKv/PYW9O65jg
 lA00fViFT4+e2Tzrq8ZCaskLPPzs2r9vyIISkssTgyiChFoVbbScMeWyiIvpgrMrb3VL/gKu7Fp
 DxuLSozLlcLVf7A0eW01ZOctgfTSEecRYaj+W0o0KuBeC1QHdpJ8Aj7aYm7uaRhIXpsfbUTvv/b
 vyPoTjMfDNiags82mhTrUJZtfWmVBoXkXNe1fGB24M1Lr/+8X1AYGfPQH2w3LqcDw0G7EiTrIWe
 2F5QcUjUjH4GvIKYhYprKooHbLqHOf6pyz747HoNCv11mMUxNrbE3Kq1EfvQLIciEZ+hQr9fbnT
 6YIPK6ZmWAQ4yiJyi2cRApg==
X-Received: by 2002:a05:6000:4287:b0:47f:815c:2614 with SMTP id
 ffacd0b85a97d-47f8d756636mr9438572f8f.33.1784896206218; 
 Fri, 24 Jul 2026 05:30:06 -0700 (PDT)
X-Received: by 2002:a05:6000:4287:b0:47f:815c:2614 with SMTP id
 ffacd0b85a97d-47f8d756636mr9438515f8f.33.1784896205558; 
 Fri, 24 Jul 2026 05:30:05 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-37-66.inter.net.il. [80.230.37.66])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c532d4sm23273186f8f.22.2026.07.24.05.30.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 05:30:04 -0700 (PDT)
Date: Fri, 24 Jul 2026 08:30:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefano Garzarella <sgarzare@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
Subject: [PATCH] vhost-user: assert nregions within limit
Message-ID: <48fb8411f67e525872fb19618a886e52b670ab7f.1784896199.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.419,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

scrub_shadow_regions() and vhost_user_add_remove_regions() use
fixed-size stack arrays sized to VHOST_USER_MAX_RAM_SLOTS and index them
with dev->mem->nregions.

nregions is calculated to never overrun these, but let's add an assert
to make sure we don't get a stack overflow if there's a bug.

Fixes: f1aeb14b08 ("Transmit vhost-user memory regions individually")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3910
Cc: Stefano Garzarella <sgarzare@redhat.com>
Cc: Raphael Norwitz <raphael.norwitz@nutanix.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost-user.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 517cc4ca71..2881cec72d 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -946,6 +946,9 @@ static int vhost_user_add_remove_regions(struct vhost_dev *dev,
 
     msg->hdr.size = sizeof(msg->payload.mem_reg);
 
+    /* Ensure nregions fits the fixed-size arrays used below. */
+    assert(dev->mem->nregions <= VHOST_USER_MAX_RAM_SLOTS);
+
     /* Find the regions which need to be removed or added. */
     scrub_shadow_regions(dev, add_reg, &nr_add_reg, rem_reg, &nr_rem_reg,
                          shadow_pcb, track_ramblocks);
-- 
MST


