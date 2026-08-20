Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB6E7C5DF85
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 03:57:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwtj7-0000aq-Bm; Wed, 19 Aug 2026 23:46:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtj5-0000Xv-9w
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:45:59 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtj3-00040l-Ng
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:45:59 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-38759bcd877so2221129a91.2
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 20:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787197556; x=1787802356; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iD2tMtkECcQrx2RUBOvv3hC8c/xLCnyFp2Y8KlrwhSY=;
 b=ZjbqO0/I9WkW70crMvSTduMjMkdmGDDn2yntDp0513JZz71CCXAT9/wBJypfWkws/a
 oTetGR3r91040VUb2Btc9ZGMQ0tVAr8oc8uGxONSxsDNHkfoVEIgapeLEFUNxZ8SRnDm
 LLE92xEsss3/IAmkbPdSAva33GRkSaMbipyrqxk0R2R8AZUXOzURpEZcbPVtqehF0d+v
 +UBmW8OntMXcZT7INliHKgwbmiGWuMcTL0ybJpk0ZA8GReQxuurh22vrXUxwYaHX1Efa
 Vpbt1RqCxVv8kpzBfEGwzTxt1VDl3l/sWwljRQYlEx1HIikIucbvkTGxiJBgJrY+IM1M
 MX7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787197556; x=1787802356;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=iD2tMtkECcQrx2RUBOvv3hC8c/xLCnyFp2Y8KlrwhSY=;
 b=mspi29DVZK548yrTEHOo9cA3NB1SZM3AvWfU98dqkUNVJQC4jvCmtf5ip87cUrtNZC
 J4gpPX+7MY0SASAirbMcrc9JCa5X5ypF0YusvL4w3lpcMTVsA0aUeiRVs5dkKmF404j4
 RyGgTSyZgWdf8G3qEeu7yTDuvs+ayQleGP7kLFO763fXv8DKXrnZC00cFgGG30/Tu/vm
 peKBUnhYhCWbx+gy0Cfp1YYoSgANGhvwxWtBSPRGzHqX2Ff5du5F9UQs0WX21IsQZb3i
 ZCRsk17ZzqVPxLf4nSTbCbGCz8xfk9GE7HGhoJ9LqNFBTZ/lYHCVP1nsZw/Hj21qc0Mw
 0lLQ==
X-Gm-Message-State: AFuF++ngbxYG4q2o++ZidbmpXZ0uYoQe5MBMREKsW32d3lMzLpBzYYMD
 YiDYAN2cYD8NCD+Kvz9vQMEyY9ah7E9WGXfpWv4sChYzNrbUan7S/iaI/b6+FA==
X-Gm-Gg: AR+sD12xiJbEO/azz9iLPxchjIYFoHA2rYMjaMe/QRDLuWa5XC3LBWJi20zmkSpcWR+
 3KBobtAPQEoRjKbi7ZqSQzeACdVZsW+k+PAHrtLUpkf+9rCFpHJ1K2PicmYoDqIcgLMXvp56N0G
 SjXG8Kfj6vHOQ52ZTTwjfOYSWQh+HEw3nOlt6Lqo9yDRObfF1bYsXcergzbe6lWzFU9lAkIqh7q
 Ua0y1zBEqHVRYQ/+zjnr0jQklI1mr4HN4Lko0laAVQyKaZjdrIRZAaj2SKqf33DJlZqS+sEWNwG
 oOo5DeozZyLi25qPYtdNQMppABi+zwM/fzqSLkRXlh0zkOZ3cAb9thrx8OGlAdl6WflGjUOrAy7
 wVRgYsoal8O/SdMFVhAUr/+hDeVrnr03YK/ZgB1YBiJ30OpS2Bxp6K/C1QsepwQqv0jixBUZYhF
 EYAmIFRYJEEEZjWyZvpiIxJUzxiFt89IZL287g2w0JTm9/51UeqUAd4o2/dfPZLR+OTZbYxrXL+
 vT6/vuNFK7h0HFw
X-Received: by 2002:a17:90b:164c:b0:393:19a3:4e5 with SMTP id
 98e67ed59e1d1-395812c6e07mr14933291a91.16.1787197556270; 
 Wed, 19 Aug 2026 20:45:56 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1416ad6060asm19506735c88.6.2026.08.19.20.45.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 20:45:55 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Flavien Solt <flavien.solt97@gmail.com>, qemu-stable@nongnu.org,
 Andrew Jones <andrew.jones@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Nutty Liu <nutty.liu@hotmail.com>, Chao Liu <chao.liu@processmission.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 24/93] hw/riscv/riscv-iommu.c: always send MRIF notice MSI
Date: Thu, 20 Aug 2026 13:43:21 +1000
Message-ID: <20260820034430.1186695-25-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260820034430.1186695-1-alistair.francis@wdc.com>
References: <20260820034430.1186695-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Flavien Solt <flavien.solt97@gmail.com>

The AIA specification requires an IOMMU to send the configured notice
MSI after storing an MSI to an MRIF, even when the corresponding
interrupt-enable bit is clear.

riscv_iommu_msi_write() currently reads the MRIF interrupt-enable
doubleword and suppresses the notice MSI when the matching bit is zero.
This makes notice delivery depend on a bit that AIA requires the IOMMU
to ignore.

Remove the enable-word read and send the notice MSI unconditionally
after updating the MRIF pending bit.

Fixes: 0c54acb8243d ("hw/riscv: add RISC-V IOMMU base emulation")
Cc: qemu-stable@nongnu.org
Reviewed-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
Signed-off-by: Flavien Solt <flavien.solt97@gmail.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>
Tested-by: Chao Liu <chao.liu@processmission.com>
Message-ID: <20260727-qemu-mrif-v4-v4-2-73e0890ad395@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/riscv-iommu.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index f6865d1e16..2bbac30cfa 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -788,19 +788,6 @@ static MemTxResult riscv_iommu_msi_write(RISCVIOMMUState *s,
         goto err;
     }
 
-    /* Get MRIF enable bits */
-    addr = addr + sizeof(intn);
-    res = dma_memory_read(s->target_as, addr, &intn, sizeof(intn), attrs);
-    if (res != MEMTX_OK) {
-        cause = RISCV_IOMMU_FQ_CAUSE_MSI_LOAD_FAULT;
-        goto err;
-    }
-
-    if (!(intn & data)) {
-        /* notification disabled, MRIF update completed. */
-        return MEMTX_OK;
-    }
-
     /* Send notification message */
     addr = PPN_PHYS(get_field(pte[1], RISCV_IOMMU_MSI_MRIF_NPPN));
     n190 = get_field(pte[1], RISCV_IOMMU_MSI_MRIF_NID) |
-- 
2.54.0


