Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A92EC61DC6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 14:16:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzas7-0003B0-SW; Thu, 27 Aug 2026 10:14:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wzas5-00031o-Nl
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 10:14:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wzary-0005y0-ET
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 10:14:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787840057;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FVHt4kfMC19ZV7Xknh2WCbGWe9zSwmURX9G6ZKP5uCc=;
 b=Ggb4NHDkRiSel2XPNvSGg2TdLkX0wuuZoievI72KQu+2l/WKPnPuFAfFLweUHSW0tWU+xK
 ev1AzKCtyOIiWgwUt+riZAi0Pm6YX36AIHSHe2iH5HEolHK7ZUVhm8e/LnmGPibNW8uo9n
 1vtzxIxAqzkfJueOSEqcvHcihYV79ME=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-wMDrwhyEMzKa4uknp63mPw-1; Thu, 27 Aug 2026 10:14:15 -0400
X-MC-Unique: wMDrwhyEMzKa4uknp63mPw-1
X-Mimecast-MFC-AGG-ID: wMDrwhyEMzKa4uknp63mPw_1787840055
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-c24ae1a510cso63980866b.3
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 07:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787840054; x=1788444854; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FVHt4kfMC19ZV7Xknh2WCbGWe9zSwmURX9G6ZKP5uCc=;
 b=cIbNVaVCwUm1hSpJ9p8VIaW0jWDaUlMCoF4CDYFXdZRRMFQJD2PBnZD1WeKWZI4KZh
 9Y50h6sBpeLoOnSdMcowdbgaRihf9dwDurqlPKFt118S8zic486mabrWTFlP6Ca5KfIn
 +v1m5ZX921PCbWQVtzxPniUCBj1m9LJNFzsIIw0goMqIeF9Mc4z07nokFiTqoi34J7DB
 8sLhSbSa2VZiDVMCR2sVVUBN/ZVLlm2M2RhSaoH8SNx3IwuxU19jayrDo2jbio80NXEM
 cy6SoAvrHumhkgPy/5QfUqMfiv9oBmK3jZENvGWjDX2C0HZ2nnyA+leCm6X+k0S4aipr
 4oxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787840054; x=1788444854;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=FVHt4kfMC19ZV7Xknh2WCbGWe9zSwmURX9G6ZKP5uCc=;
 b=YW2/N7t4+4d85VYKmrPOb5tquGRQJtiG1loqtGUFwt6jQmhD4jMRTyVV20dHszpWkV
 Xi2vNzyd4WTZFrUbUmoiwKwQRFTAd87YGTFYyAG7rNOZn8wi3YMeHfB9jjf2vnmBEwF8
 fBPqR+sHQmdoxPbosmTCdP4j+AKUi9WuDRI2lo5mRGvg7wFWkd+2nKsFTheu2Kb67XWH
 mm0VsNibPXTTE1uYUiznj2WZ6zjBdigVIZMcSz7wdrY03s71n+18RxC4FYu7FSL8z1Gd
 bJTXGriPm55ZiSIDwJAiYRkIm4ZP/YzZaOD16lA1OyHuMQu3NRBWWEO4JHwRl/f3C+eo
 mkjA==
X-Gm-Message-State: AFuF++l/fMEXEUd88gTp+VSPvFvYej7+XzS4kycgDRimpBAx22DiDbT1
 vZooUdSdJa4lkqvXKoOpEyvkU5ElVdk2PITPIL0PEZV/EsNjOdTRg9VPpI11VOqd49rH09GgvYe
 v93NRlYPMSKnp8GqcetLWhEAKjNRY9GlDntu2vV5bp9hn9+13EVCvl405lFhDexD1+aHH8BYk7Z
 qp96V+w/HHTgYw+gED9jrWSkxkA0ODKHF5BgXnZo2H
X-Gm-Gg: AR+sD11Y8QTzKGDwdrsJzveAHl+xJZEhQDEXXzc+1Vf0+4xkwMbNCFHkTbCDhXJcWe1
 RvAVygqiEOsRNmeAErdtSeyTgtNly47kIUglh0IHCm3TUYwxYl9fMntyvXS55FmmWHFyixCY1Hl
 8mtBamav5GW1zW21dIK0L+eZ+ULsASdNLuvMB77arGCFb18BOoEnZ7kgtF9v7ML7MebWk3xEHx/
 TaAPoZF6vjRJIzvUdsYioXnQUE7yBRXlzG/kgPI2bwd1h+Ly2TXOGzZCc8ZmbCAr7J5KKZj+hWv
 H2+Wr3WnZqf7GVIrWkbCSqP2zznhAz5uyO0LBoGzNI0ZrvDSEp+6iUW1hC2IkwLSWLD9QwMRuJh
 qhDykImqyPnk+kuAMJfkQ/jpb3x1hjlyRLJbo7lIc3Ft4i86V2AkZlWpTvTgTtEXqJw93ZQM234
 mhL9w=
X-Received: by 2002:a17:907:1c8d:b0:c20:af9d:4533 with SMTP id
 a640c23a62f3a-c250c36a8e8mr1447243266b.19.1787840054371; 
 Thu, 27 Aug 2026 07:14:14 -0700 (PDT)
X-Received: by 2002:a17:907:1c8d:b0:c20:af9d:4533 with SMTP id
 a640c23a62f3a-c250c36a8e8mr1447238866b.19.1787840053831; 
 Thu, 27 Aug 2026 07:14:13 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.151.49])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250f99f6bdsm616919966b.0.2026.08.27.07.14.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 07:14:13 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 20/23] scsi-disk: fix out-of-bound read in WRITE SAME
Date: Thu, 27 Aug 2026 16:13:08 +0200
Message-ID: <20260827141314.1099352-21-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260827141314.1099352-1-pbonzini@redhat.com>
References: <20260827141314.1099352-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

A guest with an attached scsi-hd can force QEMU's SCSI disk emulation
to read roughly 60 KiB past the end of a heap buffer, copying that out
of bounds host memory into the guest's own disk image.

WRITE SAME computes the request transfer length at dev->blocksize
when the request is prepared and sets cmd->xfer from dev->blocksize.
scsi_disk_emulate_command() then uses cmd->xfer as the size of the
request buffer.

However, MODE SELECT can race with the WRITE SAME command and guest raise
the logical block size to any value whose low bits fit 0xfe00, up to 65024.
In the presence of this race, scsi_disk_emulate_write_same() will read
from memory as many bytes as indicated by the *new* dev->blocksize,
and write it to disk.

The read length in WRITE SAME must be bounded by the buffer that was
actually allocated, not by the mutable s->qdev.blocksize, so clamp the
length used against inbuf to r->buflen.  Re-validating req->cmd.xfer
against the current block size would not work because the race is
intrinsic in the SCSI protocol.

I am not sure if this is exploitable with virtio-scsi and other SG-capable
HBAs, because it should process the WRITE SAME input immediately,
without letting the MODE SELECT command race with it.

Fixes: 356c4c441ec ("scsi-disk: allow MODE SELECT block descriptor to set the block size", 2022-07-13)
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4365
Cc: qemu-stable@nongnu.org
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/scsi-disk.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 1b0cce128c5..5bb7a974d69 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -1911,6 +1911,7 @@ static void scsi_disk_emulate_write_same(SCSIDiskReq *r, uint8_t *inbuf)
     SCSIRequest *req = &r->req;
     SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, req->dev);
     uint32_t nb_sectors = scsi_data_cdb_xfer(r->req.cmd.buf);
+    uint32_t buflen = MIN(s->qdev.blocksize, r->buflen);
     WriteSameCBData *data;
     uint8_t *buf;
     int i, l;
@@ -1930,7 +1931,7 @@ static void scsi_disk_emulate_write_same(SCSIDiskReq *r, uint8_t *inbuf)
         return;
     }
 
-    if ((req->cmd.buf[1] & 0x1) || buffer_is_zero(inbuf, s->qdev.blocksize)) {
+    if ((req->cmd.buf[1] & 0x1) || buffer_is_zero(inbuf, buflen)) {
         int flags = (req->cmd.buf[1] & 0x8) ? BDRV_REQ_MAY_UNMAP : 0;
 
         /* The request is used as the AIO opaque value, so add a ref.  */
@@ -1956,7 +1957,7 @@ static void scsi_disk_emulate_write_same(SCSIDiskReq *r, uint8_t *inbuf)
     qemu_iovec_init_external(&data->qiov, &data->iov, 1);
 
     for (i = 0; i < data->iov.iov_len; i += l) {
-        l = MIN(s->qdev.blocksize, data->iov.iov_len - i);
+        l = MIN(buflen, data->iov.iov_len - i);
         memcpy(&buf[i], inbuf, l);
     }
 
-- 
2.55.0


