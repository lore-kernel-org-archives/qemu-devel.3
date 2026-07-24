Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 468B5C531F9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 13:19:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnFo6-0000Hp-7z; Fri, 24 Jul 2026 09:19:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wnFny-00006w-IY
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 09:19:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wnFnw-00054v-QB
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 09:19:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784899148;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=gbjiMjNIDI6DRF92WLkFrVuZmZ+VtU+ejaH28Rr8Nes=;
 b=SjGEfqqOdfdR6MhjhEYVHkl4O4C73/awTxeGXyeUBLnTLWmG/IWQ5bKkzP1KdVB9WXsmqP
 BVZpVDKkvOf5oM8iP+J8v+IpnqMODlv4IvhBvjSY1frIuRZdo2WKlOqWXLTUe0Sd2/mpKV
 cokqwDOOBoeKl0l4/1dzY39ihSzrWoc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-iGTmqT5xPpmhqVD5C6Ncqg-1; Fri, 24 Jul 2026 09:19:06 -0400
X-MC-Unique: iGTmqT5xPpmhqVD5C6Ncqg-1
X-Mimecast-MFC-AGG-ID: iGTmqT5xPpmhqVD5C6Ncqg_1784899145
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-47f753a0aa0so316755f8f.3
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 06:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784899145; x=1785503945; darn=nongnu.org;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=gbjiMjNIDI6DRF92WLkFrVuZmZ+VtU+ejaH28Rr8Nes=;
 b=f+bLjDp1llucgE/UJQFTqXWO+8bFYqk0Mh0NEZ75mV6UDjs09U/VAKKdUVCIzJeg2S
 EYSfPOvfyEP3Q6q+vxEztbVYYEPRrduwAFbLBTcnanPakcYftsepdQYF1TDxpxaKV6ns
 RNOcxGN/Bn/5DTdMTozMBrWc+G+ShWu7sy28j3AUl6H+oHnn8gVzmM0VFWeT+tdFZ6w/
 5Dr7wWcu+Y+sSfvullXvV6iObXKQtoijJf3ed24S45XdcQLdFpTuuDUyKmyqmNBG5icO
 SyyOjvNqPFkaaNR3TCWoYtcfU+QqeCryYw4R4Fozvsobd9X+mEQwaQYBrNkx6d4HgILM
 5RLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784899145; x=1785503945;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gbjiMjNIDI6DRF92WLkFrVuZmZ+VtU+ejaH28Rr8Nes=;
 b=jINw6Lf6VbXyA46hjMKYZhEbjy9cbb/5Ubag6JLDEzun1X0qlZuXUwWxgs9AkdxUkd
 mm5nJbT6y/DeyxriU+yi1ZV3ruM+0XfwyzPmcic2Ij/ktMpq7ZvSVkNqp18KJYLCUdci
 cUwO+RrVNgbG0sUVZGeK8zP8HTuprKYFWLbSzpo1GhtFUjaoaS8lPKofFE2JUNFTKW0V
 e9bJC9lHkmLRL5EbLkdipJ1aEuA4904ZY7+zSBtrTayR6jKMF4l3AcamBmWpnxhSm8P3
 IPoc9zaaOg0a222nUw7RIGNdBebUoFqp076DA2mCvqFFAzbOCHpYI/dNanlLxL6GWqgm
 nkEw==
X-Gm-Message-State: AOJu0YwA8Dn8zf3hB55nnk2zSx22BUFuRrjHxXSRSpgxOU/oRY2wg/ij
 jWTvzQ9lSBqNNVrCudB/oCYoV2zWJjb8D7ezYQehQoH1+YWjU+PYbI11PG/pNf1E/OwYeeRJkTQ
 2fvqlrUXwoYmHB7k7vxFaIf6ZBN76vMzFc6QjSh2PLDxN1iEq++5z7YzVqycZD0UYWjrxB87Rq3
 zoBFRi9JnIrciZAIm+B9dS4RrGG3TfNI1MoA==
X-Gm-Gg: AR+sD11aoSeYK6teEOW25HXJvvUzQxObJTyXtaHSgKhm0v4M1hsKGtbu99vLEX6fagS
 zTPPgLqIvlFSGOEvo4KzlPFv5iV5P3Y3ONGvtn7cVI0AbUtI0uZv0dqd3NEqFgBqFxw4CcHaH+z
 3Fm5PtzeRD0aMi/ETY5G9e17335hoRKAMDqcsy69HVmPQVlf+/RPib75TY3C1t5sPhtkWnf4B9T
 l/wxFG62cyPlUwhkCmYme7Yg8pShAGMsljGp1FjkPxjxAeawi07aIQVrxXR3am1su96UoymnFXc
 KMObB9WyMTs5AAEzrGIclOAaPeum7TWXpRAF2DToqFu2DN6j7oDcu1N66sTNBWHv5soAKKPRhzx
 Y8d4zX5jBbCLwmPe2hL5FiA==
X-Received: by 2002:a05:600c:1914:b0:495:5e86:4e59 with SMTP id
 5b1f17b1804b1-49573cf6226mr87809755e9.22.1784899145155; 
 Fri, 24 Jul 2026 06:19:05 -0700 (PDT)
X-Received: by 2002:a05:600c:1914:b0:495:5e86:4e59 with SMTP id
 5b1f17b1804b1-49573cf6226mr87809195e9.22.1784899144520; 
 Fri, 24 Jul 2026 06:19:04 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-37-66.inter.net.il. [80.230.37.66])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4957af9128fsm66572425e9.13.2026.07.24.06.19.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 06:19:04 -0700 (PDT)
Date: Fri, 24 Jul 2026 09:19:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH] libvhost-user: protect against OOB writes in
 vu_set_inflight_fd
Message-ID: <23b3f12388c1035f208550df9de9944c22d8d534.1784899127.git.mst@redhat.com>
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


