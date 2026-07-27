Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15053C53209
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 19:23:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woQs1-0000BZ-3u; Mon, 27 Jul 2026 15:20:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1woQs0-0000BC-5t
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 15:20:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1woQry-0000Pi-KE
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 15:20:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785180009;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XtAeMdvTIJtWG8IGUOglMiMwR5LzmhVQBRNo6kKVl5s=;
 b=Tajm+Ut3UBQKrgapZaIfH2k7hbvC089lXb6/mKcx1BolIY0qzGdO/H4vLP0Kh4CXPFG9+I
 LHDB/x7mz1bi4XnEqm+4puQutc4bVooJlG+GlwFvE95Vq6Oa/I/HCtlNeVfqPowANgSxmR
 s2x2Z4HxMN+mRXp6ahJpBp5JDCWRyQc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-35-JoE9lUaBMpq9DO8hnYsgcA-1; Mon, 27 Jul 2026 15:20:08 -0400
X-MC-Unique: JoE9lUaBMpq9DO8hnYsgcA-1
X-Mimecast-MFC-AGG-ID: JoE9lUaBMpq9DO8hnYsgcA_1785180007
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-493fa6e28a7so37481405e9.1
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 12:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785180007; x=1785784807; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XtAeMdvTIJtWG8IGUOglMiMwR5LzmhVQBRNo6kKVl5s=;
 b=BTCYmSnd6F+IknvS3VE0epuNpNJJbw7L3zMpbNdyCTD69TcD9mjd+r3DDrwdfgsY9w
 kpeYk5ZcOG22bB+3IynWY9VBgsql7JwTo1M4gMdgEfmXcFSvDjaD/VM+w47y4BfI+daA
 B5V3P9mCwMmuCuv7S+tNON5U/omF8CQdKrpXS24w0PkkB/SNi2fUJo8k363SQ3jD+Hsa
 Of+CQrkNO16msEOaY6A8fAEXW2INFXp6fh7k1GBgzT6q66fDDQWDZweHmequRzdBVoYC
 vxq4EQASBWHBFz/COi/9UmsEzX46qcUpqtAvZiY8/6yuvEvGoVICowo9B/CSPR9Zbxg5
 IbMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785180007; x=1785784807;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XtAeMdvTIJtWG8IGUOglMiMwR5LzmhVQBRNo6kKVl5s=;
 b=A1L1p95gzAiGmEVjgpUw/RUWJHvLMO+PQcBhiy33hLiNMY6sni8/UIrmi9ITkjzjGo
 QzDG5GaoiYyG0SZI/JQZ1HzswSJ2Aj5fyKr9TYk0AaddiEjoajbx5gIE27y1kpPGvYx5
 smw4pov0BK0AJcPiFbGj41RYMdualj5yb/sItCxS5AY3MNX41FyvSp3e3zJU4fRPSv7g
 GHI4wbH3/RyEOrmeZ9sGxVm9pnlEKIbqZtXBAVmOY3Wot35XV5LMtChhuX/gveQd8/kJ
 WKcGiHYyYdnnDe46KUY2w0AyYF6yG59tjU/OzPMBizB0qhUD7kE/Bw3tzXd1UuQ1/EFZ
 I17g==
X-Gm-Message-State: AOJu0YzVU/3tQHWnJpkbBH1QdxpnkTVaHvTxiE8ALaIJ8QAEeolfBjn4
 AsuHd5nJVk+j4ioutORYQ8Ehl8Z6/o8NlEIIpJGaWWE4JeWWu2L7jiLxVcn7Jbbu5Q+DUhm7jhm
 f6jhLwZanw+GIhx+xzDRxTtsrsOgBlyBuv2dIecPzqAY88unYyB4lSLZFhJ7jNWOTF516TPVkWL
 s5aJanZyhO0QYs6lzfBCTLUI+AhssZtfQeJA==
X-Gm-Gg: AR+sD13nlE0ZkvpBg1MP2wQngr5ur52x2PjKbwoU8ydamhB0hH3uI3ZjJG6A7wHXn2K
 uEFkg1tyzZN8D7oPkTnJO1acHzq7DZpxCc2BmoC70w1nOZmOwiVKSGoukpgFz42/1CDo4NCBXAh
 Ig92M0p31aoXhOg/T5pZS3ADvtRejkmyk2bvnmqJV480IHwCmQqBSZkT2Jk0JuO49fUtJ7ka80E
 gTZluep5opJmz84k1VrGRIyHE10vsYIPH0FO1v2aJxYvMdErVcQ8g++FcoIV+atcaQS8JvJM6dk
 MJw5KQlSNnGzULOIVo7uDaPR0nVEVfLbMLQqw1GQzmQ4H45iO4A2hnrveJnjIxEMQDXHMOWtgUm
 BB11FxMnL7QBeUpIlnmKXOg==
X-Received: by 2002:a05:600c:210c:b0:495:4a27:483f with SMTP id
 5b1f17b1804b1-496b5700419mr80573275e9.29.1785180006997; 
 Mon, 27 Jul 2026 12:20:06 -0700 (PDT)
X-Received: by 2002:a05:600c:210c:b0:495:4a27:483f with SMTP id
 5b1f17b1804b1-496b5700419mr80572935e9.29.1785180006458; 
 Mon, 27 Jul 2026 12:20:06 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-28-14.inter.net.il. [80.230.28.14])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496c44afaecsm17031125e9.2.2026.07.27.12.20.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 12:20:06 -0700 (PDT)
Date: Mon, 27 Jul 2026 15:20:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Feifan Qian <bea1e@proton.me>
Subject: [PULL v2 13/30] vhost-user: assert nregions within limit
Message-ID: <cf89b769cdd1933796099706387d3b2a9a865cae.1785179875.git.mst@redhat.com>
References: <cover.1785179875.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1785179875.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
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


