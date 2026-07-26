Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4E83C531C9
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2026 21:33:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wo6Pt-0007g2-Vy; Sun, 26 Jul 2026 17:29:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wo6Pj-0007Ws-My
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 17:29:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wo6Pi-0004I4-9z
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 17:29:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785101377;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tBhvi6iK9ugBioYiD5qlfoI4y5iguLdNdfdNzLHaa9U=;
 b=LOZcpX6AG+geHWB1hXE0Rvg+w7gYpLskDqkCpyzjlJFOA6xCV6YpdLGvQ1b/7SHbHbvUaY
 0rvdjd+Gb8le+/H9/D5ATdh4Zb/7Aw4aMziwyajDyX9l0EHapa/sxh8R1JVVttoUjGdY9M
 hLJABowunQ0IbPKP2YcXRrSyhJruFB0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-lFBvKJ1YOtOA7ZmQ_mLKAw-1; Sun, 26 Jul 2026 17:29:36 -0400
X-MC-Unique: lFBvKJ1YOtOA7ZmQ_mLKAw-1
X-Mimecast-MFC-AGG-ID: lFBvKJ1YOtOA7ZmQ_mLKAw_1785101375
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-49561facb1dso17528205e9.3
 for <qemu-devel@nongnu.org>; Sun, 26 Jul 2026 14:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785101375; x=1785706175; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tBhvi6iK9ugBioYiD5qlfoI4y5iguLdNdfdNzLHaa9U=;
 b=Xq9+s9fyWj53DVPx+36rVCqMRd9yqnlF3emGCevcUqblC8UMMSpcb8QWh5zyGMIE8A
 gUcVGxUyzhO5UPLUHVCm9wvcWOlE1YDCO+Upyc7kKkE72FVnLy3ITjAHRxYzvfZIdG+L
 6l0ZOVpmkGiaS4ZTwUjVQNQqySvVOXelY6713QF0b6wmEYp322S2IqyVerhWWzhka8TP
 UNoVqP50qnwfolWHpSVxywseEFY6Ytc5a9zLCw3fNuDcoMLAlNyifCuIKf6Q2vLQ7Ywt
 ocpNQAmB/rCLKgjV6EviaZO5SUrKQ54muye65Jqt+NFXp2Wm9uV9sE/ZqiqKi8h7YLIx
 niPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785101375; x=1785706175;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tBhvi6iK9ugBioYiD5qlfoI4y5iguLdNdfdNzLHaa9U=;
 b=kVEZOf68e+wGQ384qLK3yUHKwiiK3+5kH7WViLT4ppyBrH4Hu0v4X62iMD8vqKj4JX
 KpKj2jPW2wUSsfwKyT+IcEa0wf+pnqwq1YNRn5nhmc6om8oHhJufqSiGupbeBzo7htDr
 0z3sbNhZsM8GYQjBWHP4pu/iGP/F6AbDFgtrHTJPFouzl/GzNO8SY4CUCfQXpy3Sivie
 2FLqFLeM5gaO/29Jz09i9ti7snzRW5lj3jYcRujUd7/2KlaQkR1FeApP7cXA44Yj955O
 SSmqvrBUSI6d5NFuckO7gl1N/iSjzMxgLk0hyr9Jz9Of7TwsiN9e4DY30+Ds2m6z7mAi
 fufQ==
X-Gm-Message-State: AOJu0YxX4gof8YU5ZmS9yM22yxDSEFCgLuiXZDYWDs4EmEJ/RkOx4fP6
 2je0GXU4CsdCtWLdghV7FkQTpuq9Cl5fPUpDAVG8VrDXMkIY4829kYGyBC9MnWrGefigoqCXG7K
 I9EWZo9aXuSVKJ24ZCAmP4tTjgLTIvylRm3U6NTJfUBKe8pTS4DNChJ9b7R7AIS75wMICr793we
 agyTUuB4UjzdREvIulMHbHYzdszFWCOGV6sg==
X-Gm-Gg: AR+sD12ru14eo1H7NtnTv8+Fxrror0cMFg9xLrESrLFvG1IDwD113QK324ucJu64lMV
 LSWqwduokulkrYi6wFQxOSnGV7jkfXr1nb34yKAWpDeKlZB83S0OLdRffLh19AZ+ptI4Zq6nLx6
 ByROCId7SMpiC5NqLfa/iZdyT13NAOVivubllJ/e17zAsR54MA+E4Q1JR+DGPZ4VfoIpyUI2n6j
 fk13oFr0Dk+3vn9HernjLOof+86OWTiQAereKtN0wGvklZ4HCn8QW2NANjYJWY7YNZQlRK8d2yf
 RQO+QI0PqQTrlCV4yNdwhhGLIw4QOUU7hLzBau0DqJPe/Q3bEivk2UAPpAbgKdW7TjicvPHuf+9
 WuvLMU4vcwAP8NH7Z+GTbrg==
X-Received: by 2002:a05:600c:1395:b0:495:6b8f:7e7a with SMTP id
 5b1f17b1804b1-496b564afa3mr71376675e9.0.1785101374605; 
 Sun, 26 Jul 2026 14:29:34 -0700 (PDT)
X-Received: by 2002:a05:600c:1395:b0:495:6b8f:7e7a with SMTP id
 5b1f17b1804b1-496b564afa3mr71376525e9.0.1785101373988; 
 Sun, 26 Jul 2026 14:29:33 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-37-66.inter.net.il. [80.230.37.66])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85bb5a46sm41983877f8f.9.2026.07.26.14.29.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jul 2026 14:29:33 -0700 (PDT)
Date: Sun, 26 Jul 2026 17:29:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
Subject: [PULL 13/30] vhost-user: assert nregions within limit
Message-ID: <98f24e6bf2ad437d779fe36eeec87b89a3cb8c56.1785101237.git.mst@redhat.com>
References: <cover.1785101237.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1785101237.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
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


