Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AF36C88E41
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 00:29:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4ot5-0001RI-OL; Thu, 10 Sep 2026 20:13:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4ljt-0001gR-Mf
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:51:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4ljn-0006RD-P8
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:51:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789073471;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4QZ/6VEOC+lNsRJAeXv7eh5vh8Fz3+qeKO3RjOtexo4=;
 b=cz7YQzQh/AKYEUrhTwxeRllVeWt9vqUc+AbdiZ1UxqUSUET1lX8LW+/xzPLvnUzxpopBhf
 5oCQXrczyQ87fmi+E+kM7GN/qHgpILlTXHn2sp8GjEMTSOHUE5GXx+MsLLNPBAe8bD9z22
 Bh/9BW73OaoNC3oC3Adm5gPHzuck2Ps=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-K_7fcvUQNrCoVx0nOmM74w-1; Thu, 10 Sep 2026 16:12:58 -0400
X-MC-Unique: K_7fcvUQNrCoVx0nOmM74w-1
X-Mimecast-MFC-AGG-ID: K_7fcvUQNrCoVx0nOmM74w_1789071177
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-48437090e74so60883f8f.2
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 13:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789071177; x=1789675977; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=4QZ/6VEOC+lNsRJAeXv7eh5vh8Fz3+qeKO3RjOtexo4=;
 b=mgX2vOFuYcnc/O1I29dUYTSx8fO317lq1+dQ9ReijE+omc/v02TKSNTWIDSRhlfebh
 iNypOFyBz4NTpXSYhKlD6Ca4UnZ/T2EW4/jDiQ1kPtJxCt3ARSLB84HEDYjYU7rxE5kD
 fsp+xbB1o2iTAQ7Ok2Q9z8m7bucm7u0HqqZBjUxrRLUfNdYspAiWg/FedLHcId2bIHaI
 Mt423EvKVhQSzzj9IEL2HwtzUESpYvgOkpxlQtzsAGxFzRDmzcpCisU8eQ+JhL36pq5X
 1rq6bqAz/SoCWR+m5TDsKQHsvOw62SeN4ngO1jxr8NOXxUV35GnGBAnX6xjJiqlNW09Y
 X3Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789071177; x=1789675977;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=4QZ/6VEOC+lNsRJAeXv7eh5vh8Fz3+qeKO3RjOtexo4=;
 b=Bp9CBD+NVumF7IL64TLqVS+oLJoFCtn0nabRWltXSxFfrdWza/Q5S99HqWSkP+VdqX
 BSBikrjo6U2wF37O9I2bZRFrkXoNDDv30YbE61EZfll+oCkLyos6JfavmBii3aidPydx
 P2m/Is+DnIvvvjtMK1aI/zS1Es+YlmhWKPEchph8joFqInB8pj3nyLCvLNGDFtU3Qkzs
 Ay1yAR+BdkbiQrdSe8uNRqPAE4j+gA5BPKVsusvauF3mnNgU3bqpYZG35k8V9FZryca9
 1mWgZgVEvxABeL52VL+3v0K+IlrPmmo4bEs4rh/NCCzTMRCPF1XZtcR15yA2D4L4PJ/G
 m9nA==
X-Gm-Message-State: AFuF++lQNttzu23Rmoi+uSqpYvDZKbGxaZ0Ylr1wzI/vocoPPRMas9Ig
 8rvl5rX3Ew8oOyw8PwFAAVZ3Rw00Q0C+wr8/DUeZfbaeuSRn8svWiKftYEOiVmM5l1kpFfdzH6W
 kdhhtJIVyFhUFcA+VbBv2hfAlcEPl8IWBkfQWUC0/9E6J5V9Z6eXM7AhN2/QOSPtJ09qvnNLZCI
 LnLQ40M88eyaGMJNWlbDjvV+yjUHQJ1q5HDw==
X-Gm-Gg: AYBFou0eLGfpBPMTyZofFq+vifjiPBHgBZJKi87azWO87s+4QMduEL77SMIfuYnJIs8
 VLh8kyLRmpYOSJXbfOYcXFa5B6BuiqflDQQQJiKkPXPBhDsR3TYJxC0orHwIoJXNe4Rx0B8vaNb
 8KO/VPe506mj4E9eMAOdp8dxc+w/9d5UZY40faHfFTLBiYQGTfH2nou/nZEb22NCXq0bOIWUloy
 5hEXqAuAsVW/Am0p+AQSslXenrfQD5QcS/TGYnRLWuDaM4NcKHzON2IPZO4YEwJ6R6QpKA9cT+2
 VPMyMmmehKcvYjD6rIQYOl3fIeVBTotzRFgBi4QiLuAUybSEw0rS8hnFTbW5HrUvDCcOx7g9gWl
 9vkqtt0IA8gKCn8yp2bt8pPE=
X-Received: by 2002:a5d:5f4f:0:b0:484:4769:18a4 with SMTP id
 ffacd0b85a97d-486eb2fa4fcmr675569f8f.14.1789071176874; 
 Thu, 10 Sep 2026 13:12:56 -0700 (PDT)
X-Received: by 2002:a5d:5f4f:0:b0:484:4769:18a4 with SMTP id
 ffacd0b85a97d-486eb2fa4fcmr675523f8f.14.1789071176310; 
 Thu, 10 Sep 2026 13:12:56 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb357288sm789158f8f.29.2026.09.10.13.12.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 13:12:55 -0700 (PDT)
Date: Thu, 10 Sep 2026 16:12:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 admin@fluentlogic.org, Stefano Garzarella <sgarzare@redhat.com>
Subject: [PULL 35/90] vhost-user-gpu: validate command buffer size in submit_3d
Message-ID: <67f10fb88d3c75da3ba7fa5a37f7d6bcfcf3ce9e.1789071042.git.mst@redhat.com>
References: <cover.1789071042.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

virgl_cmd_submit_3d() passes the guest-controlled cs.size directly to
g_malloc() without any bounds check. A malicious guest can set this
field to an arbitrarily large value (up to 4GB), causing an OOM abort
that crashes the vhost-user-gpu daemon.

Validate cs.size against the actual descriptor payload size before
allocating, rejecting values that exceed what the virtqueue entry
can carry.

Fixes: d52c454aadc ("contrib: add vhost-user-gpu")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3776
Reported-by: admin@fluentlogic.org
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260713125431.107278-1-marcandre.lureau@redhat.com>
---
 contrib/vhost-user-gpu/virgl.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/contrib/vhost-user-gpu/virgl.c b/contrib/vhost-user-gpu/virgl.c
index 20bae57d0f..c95c4afc5c 100644
--- a/contrib/vhost-user-gpu/virgl.c
+++ b/contrib/vhost-user-gpu/virgl.c
@@ -197,20 +197,24 @@ virgl_cmd_submit_3d(VuGpu *g,
                     struct virtio_gpu_ctrl_command *cmd)
 {
     struct virtio_gpu_cmd_submit cs;
+    size_t iov_len;
     void *buf;
     size_t s;
 
     VUGPU_FILL_CMD(cs);
 
-    if (cs.size > VIRTIO_GPU_MAX_CMD_SUBMIT_SIZE) {
-        g_critical("%s: command buffer too large (%u)",
-                   __func__, cs.size);
+    iov_len = iov_size(cmd->elem.out_sg, cmd->elem.out_num);
+    if (cs.size == 0 || iov_len < sizeof(cs) ||
+        cs.size > iov_len - sizeof(cs) ||
+        cs.size > VIRTIO_GPU_MAX_CMD_SUBMIT_SIZE) {
+        g_critical("%s: size out of range (%u/%zu)",
+                   __func__, cs.size, iov_len);
         cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
         return;
     }
 
     buf = g_try_malloc(cs.size);
-    if (!buf && cs.size) {
+    if (!buf) {
         cmd->error = VIRTIO_GPU_RESP_ERR_OUT_OF_MEMORY;
         return;
     }
-- 
MST


