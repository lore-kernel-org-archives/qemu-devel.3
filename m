Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C43AEC53219
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2026 21:29:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wo6PY-0007SI-RT; Sun, 26 Jul 2026 17:29:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wo6PX-0007S1-Bf
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 17:29:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wo6PV-0004Fs-LI
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 17:29:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785101364;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WdSec36BDLH9Gy0oNCLm0aOkohBfV5HZSgkei1K1dVc=;
 b=cT50MFyZtExhGyytxnEZeG+VOZ9+P0uZpGg7eEK7tJQFQ7cDKiSafrcYuiSSyxvriEaIUu
 feAhO2hZau719Elru8uPw1blnSdQFrk2qUpPYHxE+mDQWJeQXNg/wFd2Zw83Kq1OQUBCEd
 n6rYN9gZ6rGPEjFRh8CJKCObgLdKeio=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-vXgyOLHrMAqecHL3y0pMWg-1; Sun, 26 Jul 2026 17:29:23 -0400
X-MC-Unique: vXgyOLHrMAqecHL3y0pMWg-1
X-Mimecast-MFC-AGG-ID: vXgyOLHrMAqecHL3y0pMWg_1785101362
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-49560dddaa4so11504215e9.3
 for <qemu-devel@nongnu.org>; Sun, 26 Jul 2026 14:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785101362; x=1785706162; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=WdSec36BDLH9Gy0oNCLm0aOkohBfV5HZSgkei1K1dVc=;
 b=JA27wOLabV9r9kQ4VZeg1uwjkrAvPB0ueluehf/rx7GJrnK36faQEPMFRlaVCCuHz9
 oK0qWshZJwnjwo4JG1Vk67402RdtSd4N/8u6+ii/4u6G6dHutn+Zfbm8BGL2u54nSPqU
 LNEwQ7EYAe1lLawlwZyFz/m+kXgDQkvnfNFQhGrmGDyk4Aa9JFe6qPr+Oglm9wK44aHW
 ux5yLtfkp/IIWToBRW+2Kpao1QhWuXhYg8PyWGmyTIYVqjiVgN+NgT/fKV9ipIkADrhz
 9wVpy2BEu8adbrtVzanR8EyAk0th0o3RoH9iCf2yNS7bnXLzz9hJTYQTSesIRekJcyua
 b0xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785101362; x=1785706162;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WdSec36BDLH9Gy0oNCLm0aOkohBfV5HZSgkei1K1dVc=;
 b=BlH0SEfcyscowWHqqi78RDOqmuQF66WFQ3qmxUEwThoMqh9BEqC9Kz7S7VDXdZlPjY
 TY5osWQdHksDytLokv9zMw98WWzeq9Vm0wZ1RqYdmB9W+cbxYu2RBaQ38ukAK6mmbHLc
 U7286dHlV7mIb326hfONEEFKDuTf9W/hnf1g/cGGL+P/9AnwsuuIhrbWPTFU8U0925jV
 fN7yIe/n9E66r3Ia8jIK1A9y7vB0AU0CJMrC0MFizQanLo+iPFFyuqtV6K4K57/EwdgE
 LFyt1PhelfHUrUmn2aON4sFcnyxF7yZF2FsXJ/gb1RqmaeIQaRWq0708rNMYgs4jaM5c
 dqPw==
X-Gm-Message-State: AOJu0YyC+T3L9ktA3WaUB3ppZnAfwf3SooF/wPrreBt1Z2gUF3Z1cl7j
 Iu5zJ4dMmajnSOLVY9F1grogJ0aQbG+ah3i7vtj08mPZW3GvneFaysi46mZrTfYptBBaplUKgXQ
 NLts+asa9ylM2feLq02sXok5ItmmQecYcjfbbERavH7TOF3vm4quEhwft8ERekRB7wf5gRfqMcU
 Cr0v0XUEO9OkDv4GdZxhnAIngiHXi12+CL4w==
X-Gm-Gg: AR+sD134jEFtpQT8uIHBpxLjBbsXODG2YWobkVC/Zs27J1jtRoYjydia+0d9agbhQsz
 DG01dKDD7UTJw/jj4Z/E7SdPiQQvxKmbEKdXY1zEj9dgp6GzASJfo9LJshYG5njymCNXgsT2Yl/
 jWwIlsAoZbT9JoJbVFIn7lj87txZXbNQrGKr0DxgEbS/HAwYTt+eoeTwSeX3dHbn0vGBSmBMQDR
 vrxcLR89na8qqrbuCaKjQaAefcumbamGRF4gXSWnZa+uQ5Ge4BYf1hKvjknX/cHVaANPwOF0NtG
 AXnf6mrJuRRd4eSD9XHbGog7/6hFt+jOZK2xZ+/1JFDapEaNN3jMN2ckcRf5mRf+rZrCefEHEsi
 5fMw5UO2jtB8hHt/2MoefDA==
X-Received: by 2002:a05:600c:500d:b0:493:e583:7053 with SMTP id
 5b1f17b1804b1-496b5728b27mr77586885e9.35.1785101362207; 
 Sun, 26 Jul 2026 14:29:22 -0700 (PDT)
X-Received: by 2002:a05:600c:500d:b0:493:e583:7053 with SMTP id
 5b1f17b1804b1-496b5728b27mr77586735e9.35.1785101361577; 
 Sun, 26 Jul 2026 14:29:21 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-37-66.inter.net.il. [80.230.37.66])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496b4f24a93sm193530135e9.11.2026.07.26.14.29.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jul 2026 14:29:21 -0700 (PDT)
Date: Sun, 26 Jul 2026 17:29:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Greg Kurz <groug@kaod.org>
Subject: [PULL 08/30] virtio-scsi: fix SCSIRequest leak on a bad request
Message-ID: <219bdfa113a75868d038b0b10abaeafad90c1704.1785101237.git.mst@redhat.com>
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


