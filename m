Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05AE2C531C9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 12:16:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnEop-0001EG-4v; Fri, 24 Jul 2026 08:15:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wnEon-0001Cv-Ev
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 08:15:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wnEol-0003g7-L5
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 08:15:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784895354;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HT9jw5pyFVVFl3ov8Dz5ClilRS/MQ/3Xr4JF8FAbFr8=;
 b=Lo8GXlET2D/Fn1z9Xb+QvXh2PF5GIgTtz7ZChxNU/WydTPFd5hVTk+a4Vj5BHD7iPWWk8X
 q0XJZiHMrR/p2ijk/MZhkoggeekL1FVz5W2BvT9Oga52sA8tepPzacOjg+hbCn9fK3r5se
 jPNSrZnsUptkIW3OYOYFG0rU6ifayeY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-404-HpmtpmeCNp-0_Qw7AuuZkw-1; Fri, 24 Jul 2026 08:15:53 -0400
X-MC-Unique: HpmtpmeCNp-0_Qw7AuuZkw-1
X-Mimecast-MFC-AGG-ID: HpmtpmeCNp-0_Qw7AuuZkw_1784895352
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-47f753a0aa0so281567f8f.3
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 05:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784895352; x=1785500152; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HT9jw5pyFVVFl3ov8Dz5ClilRS/MQ/3Xr4JF8FAbFr8=;
 b=NIjzb9I6X/VcfmBC6XTGJszBDooWMP/Y/S+trXfP8v/Joy6QXmnUiLNXhmYTQ388hB
 V2sh0x4HgWXOTViy1OxBiPu8kxUj/J5qGzwPqbcfeegqbZ56PL7octvD3GhGNXWnJKJ8
 Q6Q3ssYgfDQ9qf3Zq1MuVmtB/x5bVqFfCiaAKb/vfwEqy9Ke2l4tufdPK6QrKDpgKZKh
 kBEx4O1Nn3FHdP84pCFyJA+C4Cyx2bgKE0VhAG8MOrEjaJe6T1DRpRoiu5hGwgOwSuTl
 t0XmLEN+Yho6vyQSM/AyMn6uFt6S2O2itBY/XQvNsBqGyZNZUuLE8lCEpHokxvSJCoda
 Sfjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784895352; x=1785500152;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HT9jw5pyFVVFl3ov8Dz5ClilRS/MQ/3Xr4JF8FAbFr8=;
 b=QprJwEKlNlLNkc5k3gqcns9qphtNJFarzF3/y3gDYpMNJR/c1DzbUP1Z2usL6xm8Gc
 BdwdaQrEVugm0lYs9yZ3x+elzpUEkV3H0tRsqX/GFwnStbvswz45pxOEcNgFq/c6/lun
 QCSC8Kh03lxN1YOBN8dNxNR2g9HuMKw4g6emT6h5gQpsbmMDIEpFLYbQLjo3lz3/niue
 Rt8Hbda5qXEC3ljISKfnNvK3HyvoIj2eYY0I9QMRjfC7KvARJGxEWADNNuSUO3BkdHXo
 fmFBcdnikuB/mKZtnIh71ai1NgHt66bdXSaPyjLx/EqK1P0F3NnCfzcpF+aIVhmveite
 zGbg==
X-Gm-Message-State: AOJu0YxIPSBgKYGIq1QaDEYESsWMYmYMybysLKrFu9p48ARElGt1WwOW
 AzlP5yjaErxoCDsFF9EdZfyoViQMJ2rj43PSqLHuV+7BAp8xpwt2ddUjswlBpTxabhRnA9ifumZ
 8XBy/ezEd4g4aYO0336FuHjfTySTd8PL+xHW4sWmIJjbquyVKqQ7ZWE6oEsshhf4qIctstpoSdp
 m41WFih5suLMkIsQYpxnaHkxR+WLVMpEW+Mg==
X-Gm-Gg: AR+sD10BYI1eOhOg6ujaHuf6NGFacc8givTB0BFQhqOuXu7NW41McoA2IgHh4fWEQ4c
 ICh3A5sJYeyD8NnAc2QHgkssKU045JXxbNp62BRWIvgK9iELkfC+/hn7Jhd8gZpZiprz4Ej0TVL
 BZZE5slxepzLM+luM16BZpoz/SVcX2uihV82oMWP268mC7yUd1NwofvdSU9uf84tj0sCaRdJK0j
 aUrW1lWS37jaoGzfI1wlB8iYwS4OLXOKzzgMeFlpTT761UmnAZyfl/CZ4M05jTKJzfz7Fgl3Bkk
 Jwo6zB9J3F0856x1owobKhw2DucVQK7OveQsL2iZrgDlV0mFP0TqvkZAYHOjigB7ZR/R6dbhMtP
 QCcEav7dT170YEX3aQPbtnQ==
X-Received: by 2002:a05:600c:4f52:b0:495:4b56:f127 with SMTP id
 5b1f17b1804b1-49573cf620emr88687565e9.25.1784895352037; 
 Fri, 24 Jul 2026 05:15:52 -0700 (PDT)
X-Received: by 2002:a05:600c:4f52:b0:495:4b56:f127 with SMTP id
 5b1f17b1804b1-49573cf620emr88687025e9.25.1784895351484; 
 Fri, 24 Jul 2026 05:15:51 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-37-66.inter.net.il. [80.230.37.66])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4957af5d3c2sm77596715e9.1.2026.07.24.05.15.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 05:15:50 -0700 (PDT)
Date: Fri, 24 Jul 2026 08:15:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Greg Kurz <groug@kaod.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Jeuk Kim <jeuk20.kim@samsung.com>,
 qemu-block@nongnu.org
Subject: [PATCH 2/2] scsi: use scsi_req_unref_detach_hba() in HBA drivers
Message-ID: <96456424e8055e6a1b78895709b97cc38fec4987.1784895264.git.mst@redhat.com>
References: <5092cd4716e08d29731bfe85eea82a732b837ff4.1784895264.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5092cd4716e08d29731bfe85eea82a732b837ff4.1784895264.git.mst@redhat.com>
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
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Convert all open-coded hba_private = NULL + scsi_req_unref() pairs
to scsi_req_unref_detach_hba().

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/scsi/megasas.c     | 3 +--
 hw/scsi/mptsas.c      | 3 +--
 hw/scsi/ncr53c710.c   | 6 ++----
 hw/scsi/virtio-scsi.c | 3 +--
 hw/ufs/lu.c           | 3 +--
 5 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
index 9e712721f8..d64d39706b 100644
--- a/hw/scsi/megasas.c
+++ b/hw/scsi/megasas.c
@@ -599,8 +599,7 @@ static void megasas_complete_command(MegasasCmd *cmd)
     cmd->iov_size = 0;
     cmd->iov_offset = 0;
 
-    cmd->req->hba_private = NULL;
-    scsi_req_unref(cmd->req);
+    scsi_req_unref_detach_hba(cmd->req);
     cmd->req = NULL;
 
     megasas_unmap_frame(cmd->state, cmd);
diff --git a/hw/scsi/mptsas.c b/hw/scsi/mptsas.c
index 5df124c0ce..6da8a740f3 100644
--- a/hw/scsi/mptsas.c
+++ b/hw/scsi/mptsas.c
@@ -260,8 +260,7 @@ static int mptsas_build_sgl(MPTSASState *s, MPTSASRequest *req, hwaddr req_addr)
 static void mptsas_free_request(MPTSASRequest *req)
 {
     if (req->sreq != NULL) {
-        req->sreq->hba_private = NULL;
-        scsi_req_unref(req->sreq);
+        scsi_req_unref_detach_hba(req->sreq);
         req->sreq = NULL;
     }
     qemu_sglist_destroy(&req->qsg);
diff --git a/hw/scsi/ncr53c710.c b/hw/scsi/ncr53c710.c
index 57967e7a84..b3345a43c2 100644
--- a/hw/scsi/ncr53c710.c
+++ b/hw/scsi/ncr53c710.c
@@ -756,11 +756,10 @@ void ncr710_request_cancelled(SCSIRequest *req)
     NCR710State *s = ncr710_from_scsi_bus(req->bus);
     NCR710Request *p = (NCR710Request *)req->hba_private;
     if (p) {
-        req->hba_private = NULL;
         p->req = NULL;
         ncr710_request_free(s, p);
     }
-    scsi_req_unref(req);
+    scsi_req_unref_detach_hba(req);
 }
 
 static int ncr710_queue_req(NCR710State *s, SCSIRequest *req, uint32_t len)
@@ -801,13 +800,12 @@ void ncr710_command_complete(SCSIRequest *req, size_t resid)
     ncr710_set_phase(s, PHASE_ST);
 
     if (p) {
-        req->hba_private = NULL;
         if (p == s->current) {
             p->req = NULL;
         } else {
             ncr710_request_free(s, p);
         }
-        scsi_req_unref(req);
+        scsi_req_unref_detach_hba(req);
     }
 
     if (s->waiting == NCR710_WAIT_RESELECT || s->waiting == NCR710_WAIT_DMA) {
diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index bf64d1231a..53c3c88460 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -123,8 +123,7 @@ static void virtio_scsi_complete_req(VirtIOSCSIReq *req, QemuMutex *vq_lock)
     }
 
     if (req->sreq) {
-        req->sreq->hba_private = NULL;
-        scsi_req_unref(req->sreq);
+        scsi_req_unref_detach_hba(req->sreq);
     }
     virtio_scsi_free_req(req);
 }
diff --git a/hw/ufs/lu.c b/hw/ufs/lu.c
index 13f4a90145..b2c2cadf7e 100644
--- a/hw/ufs/lu.c
+++ b/hw/ufs/lu.c
@@ -184,8 +184,7 @@ static void ufs_scsi_command_complete(SCSIRequest *scsi_req, size_t resid)
 
     ufs_complete_req(req, UFS_REQUEST_SUCCESS);
 
-    scsi_req->hba_private = NULL;
-    scsi_req_unref(scsi_req);
+    scsi_req_unref_detach_hba(scsi_req);
 }
 
 static QEMUSGList *ufs_get_sg_list(SCSIRequest *scsi_req)
-- 
MST


