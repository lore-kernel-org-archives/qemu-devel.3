Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C749C61DBD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 18:18:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzIBz-0005az-SQ; Wed, 26 Aug 2026 14:17:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wzIBs-0005ZE-0n
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 14:17:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wzIBp-0005To-SB
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 14:17:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787768253;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TjEvkvdez1Qq59qc6RfCewem7U8ROFB6pSspVDrwXqM=;
 b=CMLwsp2I3Xbf6BXL5W5arbig7SVHBnrYaOQnukhAVfiaXqepG5LGR89+oYxRvkrRwu620Y
 MTJkBkwsuzst+BJ6Bhod/INmGh969IBOTGhb2N2tsTFrrAZD+cRtAG5gHjhuF0PiLKgmg3
 M64VtHfMYueJxNC6Qw6uTWYFbPxWJXA=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-OXKHjrJDNDys4ddfTYjX4Q-1; Wed, 26 Aug 2026 14:17:31 -0400
X-MC-Unique: OXKHjrJDNDys4ddfTYjX4Q-1
X-Mimecast-MFC-AGG-ID: OXKHjrJDNDys4ddfTYjX4Q_1787768250
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-c15fff01a30so88187866b.1
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 11:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787768250; x=1788373050; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TjEvkvdez1Qq59qc6RfCewem7U8ROFB6pSspVDrwXqM=;
 b=BzbPz4MH6ZawASPIOonpKkyD8/AAeIJAwlHob/SgFvHiN8T2bVy4GFwC0KrkM9/XRt
 lVu4PkytsOq+DrwnKFhcxvMiYHPIBMvcMHdh4hUqzv6h6WD//U9bj1CwXjg0Lk8mRxq9
 TB+0SIMPuI4lXFLW/k876MCF+2yRD8rf2z5x6b2Lht7ePBiO5Mu/33++6itOdNuMF+zr
 JFesRnLiDrPyr5mslJw8ocKLKFvXb/8AXz+009w063phS5HV1yGc6pSMkg3Vpfa2Hkvf
 7wNau8ptOaau425KBkrad1gbsBYqcRcWQ0FEuPXKrdfSlxXW8qhDTUGMhuJWG9n4ZZS8
 Y/3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787768250; x=1788373050;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=TjEvkvdez1Qq59qc6RfCewem7U8ROFB6pSspVDrwXqM=;
 b=M6fQ9BPHI044+tn7fUEhj0765upTHhque4FA/MBLX/wbZU13YldLAFcoKmwjRK4aKa
 99Gr/ysPY6FyHqKv7pBOuk+u5yc9Q2JLs1krXLfFNiQovIHr4nVVYOBpCGdsoXmjc67y
 fyw00oezJuZdIM3+HbqIv8Ge2JBuOkYOmaNnH5omrKPJdbBk4Yy/jvb1YdUrHbU/QvXQ
 SRzlhIAclOFUkKLRRUcOoO6UNXM4bdr5QzingvmULhZta7y64au4DgZiqVWm2rP6SzUI
 6/7wIdTn961Wc9PGDmwUQTkc8k8kpj7toU7MDCAV54TQc1T4oFY5gnPmjdZiQoh3pmyD
 yj6w==
X-Gm-Message-State: AFuF++lTQLI8Rpfc4eEqN7uM9KZM/Hjupx2lS0cJEaqHPKiw1hsOXwl9
 cx1kf0/dsM/au3BA+t7MVJMl70ogleK8JFEQ3gowCHvIVxA4YCEwRGwLGC6EmthkERDjuShVvv6
 y1UbYTWu9eSPN2QleeH+VGlL++KeFWDkdZcktoXutCpjfFHd/qQluD3YNk9UXfesLaK6Rts18rs
 sk/7C+Iw2OsJmZdJ1zuT5w9cj8djJcm70NkwGnqOMQ
X-Gm-Gg: AR+sD11/8sIXZbxDQR85gzoEp0a3yCNJNK5LDQhP6QCuvTD5+5iEMnnWCswS1JN0+RM
 Nu76O/WWyvPKd0xaQUj5x/dx19bbXkn3iKQNDz0KlpU1q1LLQuSuh0oAr9t3bEvVfjn6tEjRbNq
 Wvqv80T5xU0UF2F3kr+CmlgbLsEgc7HBNda4no4OJtC+dARLmg9oLCz/mT7dL1/h23rnJEqiz05
 LcYrR2gUA80BCDI4hnJPXScz70l2Kz5DzUfZ/97ZcMh1fvr2CYuzBNTQCO8AXC0NqOr+zIaiarh
 PkQLycRv6xmIJ7oFO1S8Kjz/36WzRcCXZwfR/gn3Ui/Ck+o1+Cijdqfo/EK0TAO035pGyMlBvwg
 wgGs3m2MBUcnb3/REmC5qTXZJA1Nod80zgnMC83JLi/MYECS1+QbClkn9a0MZU+5KtfhKN3ezJ0
 +ubg==
X-Received: by 2002:a17:906:478c:b0:c24:6505:8f67 with SMTP id
 a640c23a62f3a-c250bb556c2mr1032807866b.10.1787768250242; 
 Wed, 26 Aug 2026 11:17:30 -0700 (PDT)
X-Received: by 2002:a17:906:478c:b0:c24:6505:8f67 with SMTP id
 a640c23a62f3a-c250bb556c2mr1032800866b.10.1787768249568; 
 Wed, 26 Aug 2026 11:17:29 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a88ab59sm551117366b.41.2026.08.26.11.17.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 11:17:29 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
	Mark Cave-Ayland <mark.caveayland@nutanix.com>
Subject: [PATCH 1/2] scsi-disk: fix out-of-bound read in WRITE SAME
Date: Wed, 26 Aug 2026 20:17:24 +0200
Message-ID: <20260826181725.849718-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260826181725.849718-1-pbonzini@redhat.com>
References: <20260826181725.849718-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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
without letting the MODE SELECT command race with it; but probably
it is because s->qdev.blocksize is accessed without a lock.

Fixes: 356c4c441ec ("scsi-disk: allow MODE SELECT block descriptor to set the block size", 2022-07-13)
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4365
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


