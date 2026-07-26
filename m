Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB6D6C531C9
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2026 21:29:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wo6PP-0007Oe-Jf; Sun, 26 Jul 2026 17:29:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wo6PN-0007Nr-G2
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 17:29:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wo6PL-0004E5-Sv
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 17:29:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785101355;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=r45wChfey+YMaGkZvIj2En9JXXbAk4e6Oy0sdusJVLQ=;
 b=BMuZ4AinRMyjrlL5gw4fRv5xdP9D/Cg61T8UsOTrohHZXxglESl6TH3jDqyybjmPcx87bn
 416t16X3NTVFpRuE2BziAQsVrPQFlIS/v45EliDPrAYoOhL2I7NytoZobV1RCIshO8cil5
 5Tvhcf/cke7jhjgjlwxGpHTfZ0hVWGE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-VVJ-yFwDPaqOwaJudO4Vqg-1; Sun, 26 Jul 2026 17:29:13 -0400
X-MC-Unique: VVJ-yFwDPaqOwaJudO4Vqg-1
X-Mimecast-MFC-AGG-ID: VVJ-yFwDPaqOwaJudO4Vqg_1785101352
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-47407691804so1422234f8f.1
 for <qemu-devel@nongnu.org>; Sun, 26 Jul 2026 14:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785101352; x=1785706152; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=r45wChfey+YMaGkZvIj2En9JXXbAk4e6Oy0sdusJVLQ=;
 b=jgqokeEZmuqzoWFRjKVFLg6jjPWgyJZ5x1OfnlxLHH3TbxvaL76QFrZygfqauAS4AD
 iz+n5ixYamnEEzQD05raMfLGIr19whossumag4IV6dKARn6X3IPOxYhN20Kjano/F2H/
 2UhQqRrNgJQ2yAu1ANvHZQV0SZLlXynTVom+cZRNfWNaW9PsmkUd0D1pXCmSkwI7FxIq
 KDArL46lego5h76lYifVNULeZTfs71DymzKYU8laEeE9fcn5Fm3NsOKoN7R4LjEDWPj1
 Edf3IUvOQaJjD4rgUyjdrNZ7KyqbqBl9vtN6TYDegqQeH9FwXgrlQ46SFVJNtGQuwyP0
 SkKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785101352; x=1785706152;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=r45wChfey+YMaGkZvIj2En9JXXbAk4e6Oy0sdusJVLQ=;
 b=eMX2Mj/9xueeKm3Z8KoGIIlgzXa+pLhLLvWLeXQZnVzOrJAjHJFkqyuy8fjwL/0G82
 3kL3vHg4U8O2Hmbzzxo9Wma/uceTOKGxkJ6tDJkBWajbqtsqYFmI8AFFHQbVOslkp9dX
 JFsjPAMV2cPOmyvF6Ecw3lJRm/1lL20IBfQf59C/FTssOCC+Stj9mmGPUDr1fCnaBrHQ
 SiW0iF1pLOPGIxD3uJSVZHoa4bluLL3frS6Q5hL+RJsmNdY2ldJlbAyyIRHewUUaHp7+
 au1snJy5jQURwyqRqB2bsU1k2WfeN43tWlypUjuhIc1s1rqJaBN+7jxWOJ5v4h0aitxe
 w+JA==
X-Gm-Message-State: AOJu0YzClzfeFZ90mmuviu6ezXaGW4CwXPAFhtcxlkeFLNe532n7bpI8
 xCopClwRgd/u5S+LcVcaBBCXw2rLKEedbwWfd+u0mQ/hxnsBX62XrhuWp6pCJC+Avp7RmOmZfqS
 ns9p78k4NblSPMRiVEnpTd+ZDuinrMtKDDAXzcr3acA//cQhzBIE2yYpXqS+00PSBxIzty2Jw3k
 cfk5Wm37Z/G10iMI6n5uRtlyJ0mYREhUeVuA==
X-Gm-Gg: AR+sD12FtnZfCG+26l3Hw5m/GEfSny6C3ADYUFf85d69Re4P+atvSK4M9mo29RyT/eB
 mekKhd7BffEPpb8fsx+Tl1CxZ2shxQ9QWgMeH9YS9yQFBfv3Ubq60ABcdJ+ITABddGoT3DILD+m
 jsPISsEFq2pk4VkAKbJUdxu8AG5lFWyib5w2lX8ouVaDRP6PQcNmbZWqwgtCxh5/TgBFvYHhWRp
 taGfbXgttaefpT7jtWLye/+YbahHfj5EBU8PnpnVpMrr5qGDx4tFVZL+nsb8fyWumpaTON+ORcl
 eHvEE5yMfPSarlJvwwYiWwAVsz9c62ewSzvEAlNW8yA9LBolEytM6hYVQ3Yavly/Kv+CMacmbBW
 UquctO/RXwBFmcmEC6vIbWg==
X-Received: by 2002:a5d:6f0e:0:b0:47f:97ee:f1d4 with SMTP id
 ffacd0b85a97d-47f9fc9d186mr6853251f8f.9.1785101352427; 
 Sun, 26 Jul 2026 14:29:12 -0700 (PDT)
X-Received: by 2002:a5d:6f0e:0:b0:47f:97ee:f1d4 with SMTP id
 ffacd0b85a97d-47f9fc9d186mr6853236f8f.9.1785101351927; 
 Sun, 26 Jul 2026 14:29:11 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-37-66.inter.net.il. [80.230.37.66])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85bc62basm45447168f8f.13.2026.07.26.14.29.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jul 2026 14:29:11 -0700 (PDT)
Date: Sun, 26 Jul 2026 17:29:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PULL 04/30] libvhost-user: protect against OOB writes in
 vu_set_inflight_fd
Message-ID: <d5e3ec5f7dc5bd9979874d174778f42355f34222.1785101237.git.mst@redhat.com>
References: <cover.1785101237.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1785101237.git.mst@redhat.com>
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

vu_set_inflight_fd() trusts the num_queues value from the
VHOST_USER_SET_INFLIGHT_FD message without checking it against
dev->max_queues, so an oversized value causes out-of-bounds writes to
dev->vq.

Front end is generally trusted so not a security problem, but OOB isn't
a nice way to handle frontend bugs.  Let's harden this a bit:
check num_queues and panic if it's invalid.

Fixes: 5f9ff1eff3 ("libvhost-user: Support tracking inflight I/O in shared memory")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3740
Cc: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <23b3f12388c1035f208550df9de9944c22d8d534.1784899127.git.mst@redhat.com>
---
 subprojects/libvhost-user/libvhost-user.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvhost-user/libvhost-user.c
index 2c35bddd6f..8208265588 100644
--- a/subprojects/libvhost-user/libvhost-user.c
+++ b/subprojects/libvhost-user/libvhost-user.c
@@ -1998,6 +1998,8 @@ vu_get_inflight_fd(VuDev *dev, VhostUserMsg *vmsg)
 
     if (vmsg->size != sizeof(vmsg->payload.inflight)) {
         vu_panic(dev, "Invalid get_inflight_fd message:%d", vmsg->size);
+        vmsg_close_fds(vmsg);
+        vmsg->fd_num = 0;
         vmsg->payload.inflight.mmap_size = 0;
         return true;
     }
@@ -2005,6 +2007,15 @@ vu_get_inflight_fd(VuDev *dev, VhostUserMsg *vmsg)
     num_queues = vmsg->payload.inflight.num_queues;
     queue_size = vmsg->payload.inflight.queue_size;
 
+    if (num_queues > dev->max_queues) {
+        vu_panic(dev, "Invalid get_inflight_fd num_queues: %"PRId16,
+                 num_queues);
+        vmsg_close_fds(vmsg);
+        vmsg->fd_num = 0;
+        vmsg->payload.inflight.mmap_size = 0;
+        return true;
+    }
+
     DPRINT("set_inflight_fd num_queues: %"PRId16"\n", num_queues);
     DPRINT("set_inflight_fd queue_size: %"PRId16"\n", queue_size);
 
@@ -2052,6 +2063,7 @@ vu_set_inflight_fd(VuDev *dev, VhostUserMsg *vmsg)
         vmsg->size != sizeof(vmsg->payload.inflight)) {
         vu_panic(dev, "Invalid set_inflight_fd message size:%d fds:%d",
                  vmsg->size, vmsg->fd_num);
+        vmsg_close_fds(vmsg);
         return false;
     }
 
@@ -2061,6 +2073,13 @@ vu_set_inflight_fd(VuDev *dev, VhostUserMsg *vmsg)
     num_queues = vmsg->payload.inflight.num_queues;
     queue_size = vmsg->payload.inflight.queue_size;
 
+    if (num_queues > dev->max_queues) {
+        vu_panic(dev, "Invalid set_inflight_fd num_queues: %"PRId16,
+                 num_queues);
+        close(fd);
+        return false;
+    }
+
     DPRINT("set_inflight_fd mmap_size: %"PRId64"\n", mmap_size);
     DPRINT("set_inflight_fd mmap_offset: %"PRId64"\n", mmap_offset);
     DPRINT("set_inflight_fd num_queues: %"PRId16"\n", num_queues);
@@ -2071,6 +2090,7 @@ vu_set_inflight_fd(VuDev *dev, VhostUserMsg *vmsg)
 
     if (rc == MAP_FAILED) {
         vu_panic(dev, "set_inflight_fd mmap error: %s", strerror(errno));
+        close(fd);
         return false;
     }
 
-- 
MST


