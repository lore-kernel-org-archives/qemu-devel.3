Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 060EEC88E50
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 09:12:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4xB1-0006MZ-3w; Fri, 11 Sep 2026 05:04:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4xAU-0004Pg-W9
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:03:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4xAR-0008JK-VQ
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:03:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789117406;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OCozH6Xs5QSeR+YEhmbXShw4rBZnSCVZ1vH0Ur9vXBU=;
 b=TuI4wDzkL7BCW/Ocqlanw/EUlFmm8RBI2u767H1ZeoZ6k87tpIlcJoXDHTyao8o9LZzyXQ
 1vY6TaaGD/hKSt5NFpLqvxVV9tBWev/HvKBBiYS5Bp/c1+aYIqmVaJGQn2LRX+yOgWj9gv
 Al3rukDlIyXBepnv4asP5X0yHIXh3/8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-7XImqNN6OZycb7GEpxKf3w-1; Fri, 11 Sep 2026 05:03:25 -0400
X-MC-Unique: 7XImqNN6OZycb7GEpxKf3w-1
X-Mimecast-MFC-AGG-ID: 7XImqNN6OZycb7GEpxKf3w_1789117404
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-49b8c651ac0so9063575e9.2
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 02:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789117404; x=1789722204; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=OCozH6Xs5QSeR+YEhmbXShw4rBZnSCVZ1vH0Ur9vXBU=;
 b=Gnk6uy/FXjBxPnGNhmBChUQz4S6USiyxmP2f8mN+VVc5TashQV44GTSLXSbzBhR6M5
 WfsrvxA3w0ImDi3V48tyfBaNdn1UeHAxMeHBzkn6hwBAuMXE4qyTyEJGRvT7JdT13mKH
 lk8wnQ53sn9UGCkI7A4JnsKPAP1NOF5hfx+C463dsTt+25kfpX48huqvTrRabCTVKBPk
 YgLmZU3I/o8vP7fq+rVMs1fghRFUG4Io9wxjGvWEiUnLJQ8Sky4Sv4/mkADYg+AYGEvG
 9yNjq2SWkLe9qLwZGaxC92Es0fasUfKkKdHMpuHVJmmhxaeEO53aDSWSfgrSBz5HpxCT
 wV1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789117404; x=1789722204;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OCozH6Xs5QSeR+YEhmbXShw4rBZnSCVZ1vH0Ur9vXBU=;
 b=jToAlMR/5Fj2dqh2IfW7gDOD1uZyIlAnzIADOvU1yQWlZK8g3P1LedhSLtC8VhgsGI
 3NHx82FuggEleAiHMTfczuUCOFFJQjX+Pp0NBWmnj9GNaHgQ9luj+NUqG7Bnuqx415gG
 YhqxUUYU26GEsBjngPQ7AJhWM1p7/Wp7956V22O+n8vEPAZjjtEZELCBqmH0jsDDG4wL
 jRLUkR7iE6yEzyqMi/n73/Q2o3qwSvHlzH6JQoEM68i/eq8AVSQNxpHtBLk9f1ODSh0a
 VuxgVdGn9L6cfLH/le1zlKxCWf8cbJrp545hx5aqoe7NXNi9Y1lyEbuCIGGEApV9qwGs
 u9ew==
X-Gm-Message-State: AFuF++kjzeHRI2QJRCLpJJVkYOD5IkMfwlwqF7jwKpXS9l7Rr/Fl+3R4
 3SSmRKzYQ2uiCGFcpQIyVYGQ+x5Cc5TO/EpCpcVyuUpClkmSeEzgQWIYV+ZUn+rSLw9c0PmXtTm
 Xzr41qfJdJ24xDMfVwxx7OizqfhEc/E9aMZc31+qBbJN6p0wTDjXx4uSmVyhwTXtYzNbY3jcr2l
 uAtDMoMsjlSiOpjvxPRfcDYIswcU+NupUcGg==
X-Gm-Gg: AYBFou2yums/y1fzSHSXGu4e7JCmTELaCYyKZlS7fM0MeeM6ksitqp8UCqsNQPsjKzv
 QdTHPvSCsdrxa3pD0asVonNfWsMcrv2m1kAHb7cSpVTm2D+ymd2fKmY46KRpOf4rN+pcjVFSvj2
 dkDqgU0RPjh6BFnSNKc3i2ZoYuRQXeTjDyZVQpOSs7PBisFisTiT0vyAlQ03cItwQX/w0Zjx/3v
 Qir5k3b5n3xfG6vSrgcORvWjHhNwKiIoXFelKQvtgw4+8ZqU62CaAKx50gqLnqSfZ3Z/EKjnBkd
 ePtZRPgOdEZXxoLzYdthZ4hc1B9o4IcnyxeskcyKaR3q9hN0h6RsJ9d1/KkzzuKztoyG8pZ4W5X
 73Scc3o8m9DV35D41OxygAuM=
X-Received: by 2002:a05:600c:1c29:b0:49d:15f8:2bdb with SMTP id
 5b1f17b1804b1-49e619806cemr34665305e9.7.1789117403943; 
 Fri, 11 Sep 2026 02:03:23 -0700 (PDT)
X-Received: by 2002:a05:600c:1c29:b0:49d:15f8:2bdb with SMTP id
 5b1f17b1804b1-49e619806cemr34664575e9.7.1789117403366; 
 Fri, 11 Sep 2026 02:03:23 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb32e6f1sm4465156f8f.6.2026.09.11.02.03.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 02:03:22 -0700 (PDT)
Date: Fri, 11 Sep 2026 05:03:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bin Guo <guobin@linux.alibaba.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PULL v2 52/75] libvhost-user: return the backend mapping address
 for added regions
Message-ID: <710889c97f919b2ef11cb3b837d7a33d2264148a.1789117222.git.mst@redhat.com>
References: <cover.1789117222.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789117222.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

From: Bin Guo <guobin@linux.alibaba.com>

In postcopy mode the backend must tell QEMU where it mapped a region, so
that QEMU can translate the backend's fault addresses back into a RAMBlock
and offset.  vu_add_mem_reg() works on a copy of the region and lets
_vu_add_mem_reg() fill the mapping address into that copy, but never writes
it back into the reply payload.  QEMU then stores its own address as the
postcopy client base, so fault resolution fails:

  vhost_user_postcopy_fault_handler: Failed to find region for fault ...

The VHOST_USER_SET_MEM_TABLE path is unaffected, it fills the payload
directly.  Put the updated region back into the payload before replying; a
pointer into the payload cannot be used instead, as VhostUserMsg is packed.

Fixes: ec94c8e621 ("Support adding individual regions in libvhost-user")
Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260813095501.20282-3-guobin@linux.alibaba.com>
---
 subprojects/libvhost-user/libvhost-user.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvhost-user/libvhost-user.c
index 248550aae1..2fed792e85 100644
--- a/subprojects/libvhost-user/libvhost-user.c
+++ b/subprojects/libvhost-user/libvhost-user.c
@@ -989,7 +989,13 @@ vu_add_mem_reg(VuDev *dev, VhostUserMsg *vmsg) {
     close(vmsg->fds[0]);
 
     if (dev->postcopy_listening) {
-        /* Send the message back to qemu with the addresses filled in. */
+        /*
+         * Send the message back to qemu with the addresses filled in.
+         * _vu_add_mem_reg() worked on our copy of the region, so it has to be
+         * put back into the message payload.  A pointer into the payload
+         * cannot be handed out instead, VhostUserMsg is packed.
+         */
+        vmsg->payload.memreg.region = m;
         vmsg->fd_num = 0;
         DPRINT("Successfully added new region in postcopy\n");
         return true;
-- 
MST


