Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5CFCC53209
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 19:23:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woQrr-00009d-Is; Mon, 27 Jul 2026 15:20:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1woQrp-00008j-Px
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 15:20:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1woQro-0000Mt-7Y
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 15:20:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785179999;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IVtM1kLlRrBmYYke395btEBse7H966kQnPC7NNaA2Xs=;
 b=LpKffoFbWawA+gM8h+mD2XN8/auRLmw+hzivjPIirblIc6VSz3i8gLB6lqAOYi4RoBgc3l
 wu1ZxUoavpEF2xHH0zuVmePg4U/TuA5RMdsEf0jyyQrN/s+zdCvtVTJndX0cOro3Gr5hA6
 kakkJDGgngGbN3yrQii7SW4RQrw7fBU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-HcnD9D_OP1WO-Cljo-rtcA-1; Mon, 27 Jul 2026 15:19:57 -0400
X-MC-Unique: HcnD9D_OP1WO-Cljo-rtcA-1
X-Mimecast-MFC-AGG-ID: HcnD9D_OP1WO-Cljo-rtcA_1785179996
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-49564d4b849so13457825e9.3
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 12:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785179996; x=1785784796; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=IVtM1kLlRrBmYYke395btEBse7H966kQnPC7NNaA2Xs=;
 b=gvI/Zuq+rlunYBd1glxuBCjjF6VUbTqYtvmIOVawc3CiF+oC55CMf0JCDJMqn34kub
 cVQSgeFde/rc7tfM/Fo/g/+xxU2ToFDXafEmFfc36ZL8UXMfGO/iRTLyp3TPNMsRpBbK
 Fh5/+WEjEYI4w7T1Mjq0V1pNFpvJeBLi/+Y36gvVLyDzgU5OjdAB2UFcc+dSWev/hcAW
 bMHzNaRJhSVtvWP8/xFygJ9c/r8ZpxfDXxJzRcArUx97qkNX1kc0bh1544SYim5Dwa/m
 gHyBZuCmLKzGtmimQ2ITH8KTXu3NHtz5NxnLewP4WHU9dI1vSHlr8rnOUNMfBe7KmC4D
 MJvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785179996; x=1785784796;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IVtM1kLlRrBmYYke395btEBse7H966kQnPC7NNaA2Xs=;
 b=sn/4kcA+VGm4YXqD6+4U4bgAl4CmGa6Rya7Hr3aGlRvYvenYKZ6R//NxLQsykh1wKG
 DXgQ80R+ENPMUamHlBYR55I6v8qkDHMPLBeN2F6D+EgfkLSPfnnz3c3RQ7Ww/i7C9uXb
 nBSuHtCfB/e7oGRk6Jzn4sFu2q5F8YMEzByeURwn6wKNy9+yiWgQ7eIwPUbEwAN4g9Pe
 dHau3AJezCwoi+XITtAgf5iyNMSrTkAWzmUf/wzyt3NqZbxaq6imJtQWsS+NWbrhMWuW
 CbnO6u9vFin6Eo1bK5vuRlBOGZ0E+5Im1omMKUcW5sASSSWKxUITdvxu+rg6o3oTzW22
 n/eA==
X-Gm-Message-State: AOJu0YzMzj83+ZVlOaOMr2Q2xwGbeH3MlTRwb0QJHMIlGewiLdZfOq7y
 EcWOsIvP7M1ZdQgNfUqh1M1W7DSca4sID5yA7QmAKXU8KDwO9i49kfIaTnu44vObaSGh4a84GOd
 u+tcfG158nkpGSseWihY5BJdLK+7a1Ebjv2QrOUjMd/jLT/IKh/YsNCfFuihWgYrtkocVMYqQVk
 F2D0Q9r2r/9pBerW/PSefdkV2XyWvrooNfBA==
X-Gm-Gg: AR+sD10kjn0+8zV7gj5dNzfwkfdCLtqRZ0c0KX+7ORegG+gKBZUC4kE1tZTrLw5CMNi
 hISl1H8p7sfA+w8uYLc/GxL5ocGH9lx7EjE47N1HXT9WGpnFcJ4dcI+nUqUjBUsacIp820kJNDg
 3YJkOdxAxH/+Ecli0zxyDHP3lsqXBAeDVzkpUkbS2vHTmDfIvHsJChXqCIu/s2FkkpSpP+f74lB
 DkBwK3Sos/rTRM2WGxKWSDgClPoYQMLpjcAXyYZrusXsiUYK+QWNNjP4js4XIIAhTEz4uHnCLgV
 wYtKmlZP2+Uu3VqippUEZ+7OMj6PouffSQjcvVcvTeDIIp9E7PRFOnNyInQt64Qcei1HuFYLEDo
 Je99Q7IvvRL8kgVDTCI2mGA==
X-Received: by 2002:a05:600c:3b86:b0:495:665d:75df with SMTP id
 5b1f17b1804b1-496b5719f90mr132870685e9.23.1785179996445; 
 Mon, 27 Jul 2026 12:19:56 -0700 (PDT)
X-Received: by 2002:a05:600c:3b86:b0:495:665d:75df with SMTP id
 5b1f17b1804b1-496b5719f90mr132870355e9.23.1785179995924; 
 Mon, 27 Jul 2026 12:19:55 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-28-14.inter.net.il. [80.230.28.14])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496c4625161sm14010865e9.14.2026.07.27.12.19.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 12:19:55 -0700 (PDT)
Date: Mon, 27 Jul 2026 15:19:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Greg Kurz <groug@kaod.org>, Feifan Qian <bea1e@proton.me>
Subject: [PULL v2 08/30] virtio-scsi: fix SCSIRequest leak on a bad request
Message-ID: <f404bf0e6504e0412a00ea64708f17d2a5e3f869.1785179875.git.mst@redhat.com>
References: <cover.1785179875.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1785179875.git.mst@redhat.com>
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

When virtio_scsi_handle_cmd_vq() cleans up prepared requests after a
malformed element in the same batch, it drops only one reference even
though virtio_scsi_handle_cmd_req_prepare() leaves each unsubmitted
SCSIRequest with two references. This leaks the request and allows
repeated bad batches to cause unbounded host memory growth.

Add a second scsi_req_unref() and clear hba_private first.

Fixes: CVE-2026-61476
Fixes: 661e32fb3c ("virtio-scsi: convert virtio_scsi_bad_req() to use virtio_error()")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3875
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Fam Zheng <fam@euphon.net>
Cc: Greg Kurz <groug@kaod.org>
Reported-by: Feifan Qian <bea1e@proton.me>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <5092cd4716e08d29731bfe85eea82a732b837ff4.1784895264.git.mst@redhat.com>
---
 include/hw/scsi/scsi.h | 1 +
 hw/scsi/scsi-bus.c     | 7 +++++++
 hw/scsi/virtio-scsi.c  | 2 ++
 3 files changed, 10 insertions(+)

diff --git a/include/hw/scsi/scsi.h b/include/hw/scsi/scsi.h
index 5f83e58d1d..c60c6e8810 100644
--- a/include/hw/scsi/scsi.h
+++ b/include/hw/scsi/scsi.h
@@ -221,6 +221,7 @@ SCSIRequest *scsi_req_new(SCSIDevice *d, uint32_t tag, uint32_t lun,
 int32_t scsi_req_enqueue(SCSIRequest *req);
 SCSIRequest *scsi_req_ref(SCSIRequest *req);
 void scsi_req_unref(SCSIRequest *req);
+void scsi_req_unref_detach_hba(SCSIRequest *req);
 
 int scsi_bus_parse_cdb(SCSIDevice *dev, SCSICommand *cmd, uint8_t *buf,
                        size_t buf_len, void *hba_private);
diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index dccb2f25b2..deb43d5560 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -1513,6 +1513,13 @@ void scsi_req_unref(SCSIRequest *req)
     }
 }
 
+void scsi_req_unref_detach_hba(SCSIRequest *req)
+{
+    /* Unref when the HBA frees hba_private separately (e.g. virtio_scsi_free_req) */
+    req->hba_private = NULL;
+    scsi_req_unref(req);
+}
+
 /* Tell the device that we finished processing this chunk of I/O.  It
    will start the next chunk or complete the command.  */
 void scsi_req_continue(SCSIRequest *req)
diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index 6c73768011..bf64d1231a 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -931,7 +931,9 @@ static void virtio_scsi_handle_cmd_vq(VirtIOSCSI *s, VirtQueue *vq)
                     req = QTAILQ_FIRST(&reqs);
                     QTAILQ_REMOVE(&reqs, req, next);
                     defer_call_end();
+                    /* Drop both the ref from _prepare and the initial ref */
                     scsi_req_unref(req->sreq);
+                    scsi_req_unref_detach_hba(req->sreq);
                     virtqueue_detach_element(req->vq, &req->elem, 0);
                     virtio_scsi_free_req(req);
                 }
-- 
MST


