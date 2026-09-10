Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAC8DC88E41
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 20:58:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4lph-0002mj-1n; Thu, 10 Sep 2026 16:57:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lJp-0002Nl-NZ
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:24:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lJc-0008F7-UD
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:24:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789071663;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n9ZmjCxLo+pq7wNUdqZBErRHKHAn5SxcOItc3qcLCnY=;
 b=g28hXxEVkrWemqki2ydL0W8dH8N8YAwJjFXDnRD0vcxxi4Z7oYhjcp9tUowYOEbIHnHVHn
 5x8gb98cIU8/YIBj3s20PbUt82aMctLg9PKzgqvqngGzj9HNNUHXinmMEmCRElzFYmYxoG
 eWDXKh0uz+0W9o6gjTl330ZV5Jachec=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-ICpaDwDqNzaan2RtauthBQ-1; Thu, 10 Sep 2026 16:14:18 -0400
X-MC-Unique: ICpaDwDqNzaan2RtauthBQ-1
X-Mimecast-MFC-AGG-ID: ICpaDwDqNzaan2RtauthBQ_1789071257
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-482e05af072so99899f8f.3
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 13:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789071257; x=1789676057; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=n9ZmjCxLo+pq7wNUdqZBErRHKHAn5SxcOItc3qcLCnY=;
 b=nNb12Ud/YdVbK+ZBsgAh8UODPTE0239Rs0t5yNAt78c6I0PRc053V5gmZsmDBMSAoy
 YY/kEqYUjaNwAA573KqFnUR8I3iAHMVScwVOmZ5bfOQdFirvowMVJi2FVJ+26Dk6C/hm
 CK9Ldkaohw6b9oWKqhIY4w2zWQQyYV8N24mGLJrrA9qzBU8r9LZC+CjkSO9ZdwXRFVIK
 mihn0nkO4XsyETCPU+gwOrvAwI2n6nb5W3tnV+mMgwIEO1/xmb647gwnDIczi+CRfTBS
 C2nZ9npYh4rXFVNo9yesG9GcLcZxVMLQ5woTD7sIsLlBjVwkvNZCA/9pNvGCPDJP2SWq
 bRHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789071257; x=1789676057;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=n9ZmjCxLo+pq7wNUdqZBErRHKHAn5SxcOItc3qcLCnY=;
 b=nrV3vaBLGaSM2lx/nzLVMQfR1iN7cosB2P0icLe0oWEtGh2XZ98PuGJ6x4TLIdvKip
 z1SIuRSV3ejxe5Gy0itiHEUiMSWDxeHmonlgxzqCj9HXUOZ/hM9fgEmUc9lcbLg2ePny
 U21rRJOCO8dsn6r8CEg0nsNP84rj/ULpSOuAVM2+fICma78l2C8APOuA/BrzAAr0LtGz
 3X2fnyqlJcorMMKRTMxa5xG1HYLP0IfIKuEYP1Qsx3FrVnufGFAIHiy5AJeqqT+1rwzz
 rELpqiKj/yQ9yRfO8p7WtbLuGv6i/4tIN4lipsitqlSGGmFqhaDuVaU5hdBXyPmTENGr
 Ipcw==
X-Gm-Message-State: AFuF++nTa2tNz6u0VZFlI4Fn7CQoJ6uAnt2/OA0e+kkfmOw9G4xRo7hw
 HaPnti9YxwyUTNVzMpxNs/P3jaeoGLMYxaxluP3OUI0vrR0WtyxGPFdkyjh6eyWhk+AxyUOvJLF
 bXReey51WGEE4l4e6rohjeGZ4r1t5CYnlL5X2nu5DXQ0W/VUdgG1kDiIHztgIgdxlwTpk2fkHwH
 mKDcd4xu97Mv7/dV7Tum9jhGK5PrAvy4QBYA==
X-Gm-Gg: AYBFou1bW5CSeD8DfTAD8SVUOjWukksXwoq6/9UfPjfrjQV/0oHa86Wo8wz0uyL795n
 uwmsD82uBzjPd2zJaetGUprat3r510kwkYeCgbiV8KZ25Ds+kVIibqKDaP7dYhdFpVyuLLFRTPk
 iUhVfpztWvcs/VBhLpA/7zdEzp99mvITCLjgqkKum1R3L81eUNxywiBGTDBkenTq0Dut8XvSuxj
 o09rRjZ56CseYFliY8tC5MoU4lI9vHWpgv5HpkljuK6ttXL8oRfaAHcPJKkvWApU3RSaYHQR/7O
 BNea4ttTKjK+ZemviEmiwOXGafQOi7CY8J1E4hQmTbkdNOmrLpf+udERtUHvrpXYcXwrW0M4Ww5
 nh7tzsreU2cQhl7tiCSfmQmQ=
X-Received: by 2002:a05:6000:46c4:b0:485:8c17:976b with SMTP id
 ffacd0b85a97d-486eb3164bdmr336811f8f.45.1789071257145; 
 Thu, 10 Sep 2026 13:14:17 -0700 (PDT)
X-Received: by 2002:a05:6000:46c4:b0:485:8c17:976b with SMTP id
 ffacd0b85a97d-486eb3164bdmr336785f8f.45.1789071256588; 
 Thu, 10 Sep 2026 13:14:16 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb32e6f1sm816155f8f.6.2026.09.10.13.14.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 13:14:16 -0700 (PDT)
Date: Thu, 10 Sep 2026 16:14:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bin Guo <guobin@linux.alibaba.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PULL 66/90] libvhost-user: accept the postcopy client base ack in
 vu_add_mem_reg()
Message-ID: <dfc67f6de3d10cd313dcd6c317fcd905ca62ddb0.1789071043.git.mst@redhat.com>
References: <cover.1789071042.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789071042.git.mst@redhat.com>
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


