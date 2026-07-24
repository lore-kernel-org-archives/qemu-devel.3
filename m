Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C989C531C9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 12:16:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnEom-0001BQ-Vq; Fri, 24 Jul 2026 08:15:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wnEol-00018L-T0
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 08:15:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wnEoj-0003fq-5C
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 08:15:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784895351;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=Ki+rF3MoAlCXwagodKchUnzZ3nK46Zb1d4JpHa8yipw=;
 b=XvHSe9jzY4x+L9k4CC+qOzUwMMw7wFsvdJzfoXUdOGG2umwW/c4HrRTlsR6aYK5arAEVuN
 sTiTq2xnnsMbW3fSi9THJNXKFn7GjfzmrlM1DfgSv02M/8eJHwtMV/8EZ9NazxNh7wVdZX
 FddBARUfTFmPrxvwkAF7lUi6fEbqK7w=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-J098qBZvN4KyzJ0x9wz5lg-1; Fri, 24 Jul 2026 08:15:49 -0400
X-MC-Unique: J098qBZvN4KyzJ0x9wz5lg-1
X-Mimecast-MFC-AGG-ID: J098qBZvN4KyzJ0x9wz5lg_1784895349
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-492714d002cso3183515e9.0
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 05:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784895348; x=1785500148; darn=nongnu.org;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Ki+rF3MoAlCXwagodKchUnzZ3nK46Zb1d4JpHa8yipw=;
 b=Q5Cs0kym/Sa4K/SomVmmmMsZ8jWM8Jtl71K41A9GkUVLd9s22UqQYi90Fpgn/yF1vw
 4Tykjw3K7EYE7tRh2Rw05YyV5vgZYQiTvYnet+B4FfalbnVg/mX1U+5+ha9kJ3e1nwI+
 21nJD05uNX5q69rSLxQEv83bfenMu+gpsyldwJnr53nLep54WyfaapAHocfCWdV8EOsv
 /C3SB1tj6tNTQmFJomKzvYp9P14g4+wTY8hDaSAcRIVM1q0/98H27fx3fVSwa9NM4hON
 tP0q2HWn10gFL3bElLpgPq797fZ55lB98amj9BFu68aPXsVIgPdnq2JwX96nrwmRgNgy
 pcJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784895348; x=1785500148;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ki+rF3MoAlCXwagodKchUnzZ3nK46Zb1d4JpHa8yipw=;
 b=Z1FTzGxUsKgaLjQQfmKq1Fj8GQz42skkNilJIdJYhkYJVRjyOaFTpIpfSQSPxU3Y/U
 48jLjUyCaFnJhzIO6U/TfjUI02Exnlsk0I/ybcetGxdiHTUozqKsaBlWYx2lxWuJxPnv
 Zwqt60tKv/uczr0t9DThjpG3zTvXFly0mP4LKj3VHIP7BC2HiJII4O6D2FMrdPOlYbxK
 /JF/YCNNl4IUwIE3eXqJIzanrYPEe+aw4sc+JJWN6ExP84pGnB2Lxl35XUdJUxczIUOX
 P+yVsHsuZ2ZMODhe012cBhIztE8lfAuRv7sKup+s8Kth3y7Piys4fIt7lSKzi6iaqCNE
 W53A==
X-Gm-Message-State: AOJu0YxvGIKfMqo1pT4dehfGYjczIqUcEB3TtJOo41RvBT01zPj6rFn2
 DkvHUMwNk61t4xYxBCsMxXP+BAS/p3fnKfzAUSKgI2nV0emRN3IF+4KeGRMFYgCnKYQiT/kpDXQ
 DChs8sxX9bAUa8Fxh/11qr+Qg9+Sb+YARcA6ckx65Md+xOOd5uWPAFdztCxr1H1wgRlpE/SZ2O8
 QGta6GaFKkOhwPhubE3Zi9T/MoOglRJUUL7w==
X-Gm-Gg: AR+sD13PjGf5TbR/+GVhgfP92FuH9ZY+miU8YPnCNpEIZSkiHVktw+3YDHUh1T/EVGM
 r1bLBgEbAMVNBTkf1/GfpAg/Upq8UqWPz4U6hal32Q7vIA3EwMUu/BiG/pz0stwdeRdYMGJJ2h7
 ZjOa6nn6odCW7OpRW5pmoUXDCW1XyWpBdVZuZg0aVQoWWK+2PVPA8G4+PJF8GemPLTWeR8xkkT/
 JuYVRJV1NtAaGXfuH7xPiRS4b3xIq29Xx7Om/JMzS90yM4THTgJv32A1q3kIp42n8aUHQC8Fu3C
 IDVAMhUL4baaV1kfa4moalYDtNUXhsjPaZfjEq6Cd2BMs8QHftKvhQ6DGg8eHATnVjtDg1JaDCC
 1JMfcUvpQ0+XEexyblLnepg==
X-Received: by 2002:a05:600c:190e:b0:495:6e68:39bd with SMTP id
 5b1f17b1804b1-49573ce8e2amr77268115e9.28.1784895348576; 
 Fri, 24 Jul 2026 05:15:48 -0700 (PDT)
X-Received: by 2002:a05:600c:190e:b0:495:6e68:39bd with SMTP id
 5b1f17b1804b1-49573ce8e2amr77267625e9.28.1784895348019; 
 Fri, 24 Jul 2026 05:15:48 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-37-66.inter.net.il. [80.230.37.66])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4957af6a14csm64014735e9.5.2026.07.24.05.15.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 05:15:47 -0700 (PDT)
Date: Fri, 24 Jul 2026 08:15:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Greg Kurz <groug@kaod.org>
Subject: [PATCH 1/2] virtio-scsi: fix SCSIRequest leak on a bad request
Message-ID: <5092cd4716e08d29731bfe85eea82a732b837ff4.1784895264.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.419,
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
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
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


