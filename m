Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ECABC5DF87
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 12:41:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx250-00016P-Is; Thu, 20 Aug 2026 08:41:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bernard.ladenthin@gmail.com>)
 id 1wx1rS-0003Ni-7w
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 08:27:10 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bernard.ladenthin@gmail.com>)
 id 1wx1rP-0003IQ-2e
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 08:27:09 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-4799b3f7c83so1512604f8f.2
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 05:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787228825; x=1787833625; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7O1SDwJPhyM/cxU16CBQbBz7mUsV9rM5wrJOKeWl8xI=;
 b=iWPlVjB9929+0rpelW6kzlkaKatfrj6SCLo1wxfVW5Bf/vLOT2UpTL81dRIHiGP6eM
 I4gLEIDqzHVRNkv6V9OCaaAP0XQgseDoJL9J0zjb4Hk8784P8wWBK8O45wQpEn9vcyNe
 bvkTrPXplY1xc63HkPVqAw9EXSjMFxKc2BWALTke7MFyJyRFCas3fsXNiMFDfrRvXQlU
 OCc/22qXPQ197yvLTdK/Z2CvZqhU3hEnwVHh4cyx0NhuNLhL/PGHgzGnCpMrJCwGeHT+
 4zFTvoaI34fhkn8NfKHIw118r8jeMDoQjKDwJ8r79l11s72BMk3CgBCDQxYdwLUOCQvL
 YvAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787228825; x=1787833625;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=7O1SDwJPhyM/cxU16CBQbBz7mUsV9rM5wrJOKeWl8xI=;
 b=Xv9InypqkI+NurFFh7DR4JsECfWuYnx3d2CWqayBQZDmt92VonXSGKRkGNOmoulSiO
 aj/b5KTCqaWah1Vs8QcnKL1RRmjaZojNl/NtpBzaHmMSZNjyRvVKqagQrdhfR6IAzkC2
 xYZKD3sy3uNN2Xjjf7v3uo8BT7xVpj1tBTZDlGh/Yw3oSAReqy4NUUAJreoTqcJzsc+z
 fsJRGRgMmJIj4jExaWOaUYnNuDbzuLZaGRari/Da36FPDJaTaPfWIvEuSZA6+1iyBMIw
 wJxUQA1Z0jQcAP/ZnU3GVrIlOdwXSJwl/3WAH5wjsnBROIRgoXfHqi+gxTaUpPnRdspX
 SABQ==
X-Gm-Message-State: AFuF++kBupAMeF+nM9EJlPQDQoTFGUYk1FV0lETfAGoiq7aaqliC4KPB
 vsb60gSHQbDnpYxWTLLNI6hOThLAarHTgIGPpmlz/s0knyx+p3a3Z4W9w1ZQT56p
X-Gm-Gg: AR+sD10m7G5ZrQEj7Ih2/Pp/f+rXH/hYebPznY4V2nDU2c1mUwMtjwZVHx9FbJUPuJs
 sc8Oc6v7Xat+H1y+x5udZEEPFe5wX3p0DgBcLnfd/KDExJdojLVe3/y9QiOifLmFkcBqmTCh8bu
 ahhCkqtVBrh46FeC8vwmI2jBv9LOdKJjxZLb4I8cyN3Zpk5IjpYSTJmOc0zchu2fL4aYJVewF3i
 EzibqKeITiaiah8XEGpvVzXj7yknfBynIgoyWJC6WaDzor1+ZYdKam4RoP1Locv+L+mB0Yo4RC3
 vYC0Kloh6hthYgEhaNXsnZEaMwOWJMGybK+MtdqmKHQXrd7L2SxCamcVSg7NrCuF0WRCmwQb5X5
 XMUWWdbGOPO6jkfrVwxhnmVO+hYl4J5nQFHu5ulX4IItccNhvungzncIIcWjZ+BMuxsA3uyTtzU
 1SklniV1oRaQKu/w40+TMucOA3b/LjrS3sH27Vu9bbTx0h9kaiXFfjpoSII/DWuaTf/9XDJb2n5
 1MwvTwPRGN3j3NnOIAUlqwj/Z60awEQZDTucIYHVqdrrXnDM+xNPC9qAoJTbB5IR0FDTUErOG5m
 XI90UcQER1leQHh4I2oqWIQ0jSdLZj7K+a9zB39Z1jV0cxxpALm+TJBZg7Il2LrRjTJeaZ8lOi1
 LNIo=
X-Received: by 2002:a05:6000:41f6:b0:47d:eedb:ee62 with SMTP id
 ffacd0b85a97d-482b1fd3b69mr24471727f8f.14.1787228825204; 
 Thu, 20 Aug 2026 05:27:05 -0700 (PDT)
Received: from localhost.localdomain
 (p2003010827046e07f1219fbed82e562c.dip0.t-ipconnect.de.
 [2003:108:2704:6e07:f121:9fbe:d82e:562c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b14b8022sm10536183f8f.18.2026.08.20.05.27.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 05:27:04 -0700 (PDT)
From: Bernard Ladenthin <bernard.ladenthin@gmail.com>
To: qemu-devel@nongnu.org
Cc: npiggin@gmail.com, harshpb@linux.ibm.com, qemu-ppc@nongnu.org,
 Bernard Ladenthin <bernard.ladenthin@gmail.com>, qemu-stable@nongnu.org
Subject: [PATCH 1/2] spapr_vscsi: fix data corruption on transfers above 128
 KiB
Date: Thu, 20 Aug 2026 14:26:43 +0200
Message-ID: <20260820122644.19691-2-bernard.ladenthin@gmail.com>
X-Mailer: git-send-email 2.49.0.windows.1
In-Reply-To: <20260820122644.19691-1-bernard.ladenthin@gmail.com>
References: <20260820122644.19691-1-bernard.ladenthin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=bernard.ladenthin@gmail.com; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 20 Aug 2026 08:41:08 -0400
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

scsi-disk hands the HBA at most SCSI_DMA_BUF_SIZE (128 KiB) per
vscsi_transfer_data() callback, so a single SCSI command carrying more
than that arrives in several chunks.  vscsi_srp_direct_data() remembers
how far into the descriptor it already is in req->cur_desc_offset -- but
that field is uint16_t, so the very first 128 KiB chunk does

    req->cur_desc_offset += 0x20000;      /* 0x20000 & 0xFFFF == 0 */

and wraps straight back to zero.  Every following chunk of the same
command is then fetched with buf_offset 0 and DMA'd over the START of
the guest buffer: the tail of the transfer overwrites the head, and the
rest of the buffer is never written at all.  The command still completes
with status 0 and no sense data, so the guest cannot notice.

Linux never hits this.  Its ibmvscsi initiator uses INDIRECT descriptors
for anything multi-page, and the indirect path resets cur_desc_offset to
0 at every descriptor boundary, so the counter never reaches 65536.  A
guest that describes the whole transfer with a single DIRECT descriptor
and issues 256 KiB commands does hit it on the first command.

Measured with a READ_10 of 2098 sectors, traced with
spapr_vscsi_transfer_data and spapr_vscsi_fetch_desc_done:

    queue_cmd      tag 0x2 CMD 0x28=READ_10 LUN 0 ret: 262144
    transfer_data  tag=0x2 len=0x20000
    fetch_desc     cur=0 offs=0x0 ret { va=0x84d28 len=0x40000 }
    transfer_data  tag=0x2 len=0x20000
    fetch_desc     cur=0 offs=0x0 ret { va=0x84d28 len=0x40000 }
    cmd_complete   tag=0x2 status=0x0

Same tag, same request, same target address twice.  The guest buffer
ends up holding the second half of the transfer at offset 0 and zeroes
above it.

struct srp_direct_buf.len is already uint32_t and vscsi_fetch_desc()
already takes buf_offset as unsigned, so widening the field is all that
is required.  The VMSTATE entries for cur_desc_num/cur_desc_offset are
commented out upstream, so the migration format is unaffected.

Fixes: 8ca8a17c9a16 ("pseries: rework PAPR virtual SCSI")
Cc: qemu-stable@nongnu.org
Signed-off-by: Bernard Ladenthin <bernard.ladenthin@gmail.com>
---
This is my first QEMU submission. Corrections on anything I got wrong in
the process are welcome.

diff --git a/hw/scsi/spapr_vscsi.c b/hw/scsi/spapr_vscsi.c
index 978eb856d7..1f0c2a3b64 100644
--- a/hw/scsi/spapr_vscsi.c
+++ b/hw/scsi/spapr_vscsi.c
@@ -86,7 +86,14 @@ typedef struct vscsi_req {
     uint16_t                total_desc;
     uint16_t                cdb_offset;
     uint16_t                cur_desc_num;
-    uint16_t                cur_desc_offset;
+    /*
+     * Byte offset reached inside the current descriptor.  Must be at
+     * least 32 bit: scsi-disk delivers a command in SCSI_DMA_BUF_SIZE
+     * (128 KiB) chunks, so a DIRECT descriptor larger than 64 KiB would
+     * wrap a uint16_t back to zero and make every chunk after the first
+     * overwrite the head of the guest buffer.
+     */
+    uint32_t                cur_desc_offset;
 } vscsi_req;
 
 #define TYPE_VIO_SPAPR_VSCSI_DEVICE "spapr-vscsi"

