Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FDE9C88E5A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 09:11:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4xB0-0006K8-FC; Fri, 11 Sep 2026 05:04:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4xAU-0004Pf-Kw
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:03:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4xAN-0008J7-Ld
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:03:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789117405;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n9ZmjCxLo+pq7wNUdqZBErRHKHAn5SxcOItc3qcLCnY=;
 b=BkXMnNattpH/aJNFGeOAJwX3rRanHZdqSKx/thb5c2Ghiw01l2B3x3WzN4njMVMjSD/mO/
 ZQHsTvRDzu5jQBKT9bDUNswUmtpBaiKrhHLsQ4t9lICyIokkanFxAQCWoBzN3UlrHBZ7Qg
 8NUuMZNGKKbo8B+A7xMidQkPhvL2Anc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-4R1MyDJVOoO_jBrScxhh3A-1; Fri, 11 Sep 2026 05:03:24 -0400
X-MC-Unique: 4R1MyDJVOoO_jBrScxhh3A-1
X-Mimecast-MFC-AGG-ID: 4R1MyDJVOoO_jBrScxhh3A_1789117403
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-49cdc4080ddso3444725e9.1
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 02:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789117403; x=1789722203; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=n9ZmjCxLo+pq7wNUdqZBErRHKHAn5SxcOItc3qcLCnY=;
 b=Ko9NYH5yBAJutCEu6BIf31HysYXEFTqOvVujYpc2sowm+YZIb/m+kldQyPgj+4rsve
 44cmn50EI41UjTLjTPup9bg3ILhLanoEwZCoEP5Qhg44oalS+LS6f3sgXJur+VHLNVXD
 jxZJV4vCN2DCBn9hcy9eVE8BG0Ceaj5DNGG0jFWQWAS/O/mjXlAQ4c0UuTjTIK0pQfG9
 ZyknrzcOD75CwyHS5+GBMrc2jyP4OH7AcmKBH70oZQYvYVlYuM1CkQFcYWT9521sAjNT
 q5315gWeTn3PadaM2Y2s2cK1NmoYe/KL+/lNwFrQpsVVxeZMIemGTrCIiA6rOviDAIe1
 cLaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789117403; x=1789722203;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=n9ZmjCxLo+pq7wNUdqZBErRHKHAn5SxcOItc3qcLCnY=;
 b=M0adsCn1R65BTY6mXPYDcwkHJko6NIzYc39a7GexdxNQnRouzM2TjP4gh5KL8QtX8u
 d9QRkKQjNtPyaSQQABqin3eaCl4LGurQwLAE1nemBhTAVI5ZR56kdUvxTNnFLFNET0wd
 VkipAUbJo2wrtJYT6jt2I7AliNPDhX7HgwF7ytxF8S08BtyPUe4ID8TPS6oWjahEGGbq
 7gUmeHqoGoyRpUe1LVU+FAJd3tSpOYTxlESwaNNnUK78fzjEqrTs0OmUWLakfpBviCCx
 bbFhYOBZ7eabuERHUlJ4ukwvRGVvLK6X1YjYcWjdzYu2LkWauhFZAx4hnOl6y8BCA+F0
 Tcpw==
X-Gm-Message-State: AFuF++kFVUzZAe+lhTSLt5j1f1JGSOJHYLkcJdIczvVyrF8X8fE0U1fl
 Dto6FuCElhysHoYrEpSp6D6rsjwcNVItWm4B5BzLZNfoFYU+GP8TvdTDe1Sn/4W7TGTPT4cQzNR
 cMsFLvynIsP4OrjHSKOg6DQnRlUhbb1bK7gqGfySGwaohsbXe4SNBkZ79LzejAeTV0T6sk7m36M
 BlRRHcclP2la1VOVqNtzM9FN05N26k+rC+qw==
X-Gm-Gg: AYBFou05w/LQN8Vmtd18auHYvACLTeumUgZ0bIbOxEhh+gxA1SlvXU+Vq17A42G9JB5
 2mo4SukOzVJ/zNjk2G0PcdBONRo9reBb9kMA+ws7jXmV8AuzBJ2pE1tpFmhfZRFKI2/Xomh3nrq
 KvJrLaH+jgXY979Vvov8wfpJyqlWlnIn4kSUCACJo2T8MjtbV9xONC3ZYwpEOlEvjZkstYqJk39
 d4/Xbgu1lEcaAWl7vGFARPkYE9Uakg5a68bHSGB5u/I/TgOEChnI+jlxEd7roPqgDuOU7kH32df
 ghLo8O8ZYMTItxjbX8T5IODiO96t2G4dXmY+OG8bufON7eZZkci9pqd6QFSOOPvvXU3kANsa4XD
 S4zdoOoc++UG0SLJu8O5pWb8=
X-Received: by 2002:a05:600d:849b:20b0:49d:257c:a735 with SMTP id
 5b1f17b1804b1-49e61082867mr29086925e9.11.1789117401939; 
 Fri, 11 Sep 2026 02:03:21 -0700 (PDT)
X-Received: by 2002:a05:600d:849b:20b0:49d:257c:a735 with SMTP id
 5b1f17b1804b1-49e61082867mr29086285e9.11.1789117401209; 
 Fri, 11 Sep 2026 02:03:21 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e62121747sm37573605e9.2.2026.09.11.02.03.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 02:03:20 -0700 (PDT)
Date: Fri, 11 Sep 2026 05:03:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bin Guo <guobin@linux.alibaba.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PULL v2 51/75] libvhost-user: accept the postcopy client base ack
 in vu_add_mem_reg()
Message-ID: <1504232c523264cb49f54fda1171dd34f71528a6.1789117222.git.mst@redhat.com>
References: <cover.1789117222.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789117222.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Bin Guo <guobin@linux.alibaba.com>

In postcopy mode QEMU signals that it has collected all the postcopy client
bases by sending a VHOST_USER_ADD_MEM_REG message with a u64 payload of 0
and no file descriptor (see vhost_user_add_remove_regions()).
vu_add_mem_reg() has a case for that message, but only reaches it after
validating the fd count of a regular region, so the ack is rejected first:

  VHOST_USER_ADD_MEM_REG received 0 fds - only 1 fd should be sent for
  this message type

This kills the backend during memory table setup, making postcopy unusable
for any libvhost-user backend that negotiates
VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS.

Recognise the ack before validating the fd count.

Fixes: 9f4e63491b ("libvhost-user: Add vu_add_mem_reg input validation")
Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260813095501.20282-2-guobin@linux.alibaba.com>
---
 subprojects/libvhost-user/libvhost-user.c | 26 ++++++++++++-----------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvhost-user/libvhost-user.c
index a74d814bb4..248550aae1 100644
--- a/subprojects/libvhost-user/libvhost-user.c
+++ b/subprojects/libvhost-user/libvhost-user.c
@@ -948,6 +948,20 @@ static bool
 vu_add_mem_reg(VuDev *dev, VhostUserMsg *vmsg) {
     VhostUserMemoryRegion m = vmsg->payload.memreg.region, *msg_region = &m;
 
+    /*
+     * If we are in postcopy mode and we receive a u64 payload with a 0 value
+     * we know all the postcopy client bases have been received, and we
+     * should start generating faults.  This message carries no file
+     * descriptor, so it has to be recognised before the fd count of a real
+     * region is validated below.
+     */
+    if (dev->postcopy_listening &&
+        vmsg->size == sizeof(vmsg->payload.u64) &&
+        vmsg->payload.u64 == 0) {
+        (void)generate_faults(dev);
+        return false;
+    }
+
     if (vmsg->fd_num != 1) {
         vmsg_close_fds(vmsg);
         vu_panic(dev, "VHOST_USER_ADD_MEM_REG received %d fds - only 1 fd "
@@ -971,18 +985,6 @@ vu_add_mem_reg(VuDev *dev, VhostUserMsg *vmsg) {
         return false;
     }
 
-    /*
-     * If we are in postcopy mode and we receive a u64 payload with a 0 value
-     * we know all the postcopy client bases have been received, and we
-     * should start generating faults.
-     */
-    if (dev->postcopy_listening &&
-        vmsg->size == sizeof(vmsg->payload.u64) &&
-        vmsg->payload.u64 == 0) {
-        (void)generate_faults(dev);
-        return false;
-    }
-
     _vu_add_mem_reg(dev, msg_region, vmsg->fds[0]);
     close(vmsg->fds[0]);
 
-- 
MST


