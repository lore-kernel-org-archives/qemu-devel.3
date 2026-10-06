Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62ACACA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:26:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEMxV-00068P-EV; Wed, 07 Oct 2026 04:25:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xEHPU-0003oN-ND
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 22:29:52 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xEHP6-0000Sh-NM
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 22:29:25 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-6a9a20a5e72so1670834a12.0
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 19:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791339951; x=1791944751; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+qm9RFm9kpcLhP87Ut2zliIvFmj6+EMYEVrRI1a4jgs=;
 b=N+p8FdcyrdVuHtY/38hYtefONo2nYnSplI99zfak/PtlyGr7vW/genlFghQ/FiKXoI
 i6191ck7jGHrAyTvizGYkb1f73thxGlG7TKcZkkvAFSpwYWGW9ZZ+5rn4jIzUS6R9SCS
 O64IE8t0Jfzb7TEX3oao5djK8Yl3lPS39YQJHujvCM20idNdPtrcMEmhT1u9nxAYyIPt
 fEjoKkoul7AbZEZkSGHMyAQ3cGASIXrHdwvyAnXubEpxxaKUyWeIKPbCc1np0tStRhZu
 AunNGC1D3bB6lVG+e/DLhHb5XbZTus1RR9HfRL49QBDfaNvrUSU41cq50rwiqq7bi4O7
 Kxxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791339951; x=1791944751;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+qm9RFm9kpcLhP87Ut2zliIvFmj6+EMYEVrRI1a4jgs=;
 b=M8Py2mNCUDqawd3H+plZIAxHik0xI96IBa87JINZB8/gz3GMETg0s+dAO0LZrU/RsC
 voLBO+K1B5X+hq4RoOC8bs2Hu8mPvXGoIjESH8CpBHzH6VGWSieq/EEY3hjGfTvW7d0D
 FQUwz3sN43ACK0GjFF1qxP6bnq46zNyiVx9g+PKHv8jrg4JQMPx1IRa+DFDlA+i9v84R
 uYYjP39tNUke89x4bhzAhI8zERM4OxoBvDofXe9JV9WByGix0GCoB7lUeZjHP8zOrkKG
 vvarLzPzAUUIhkOazRC5OXhRmcijhIINfNkt7SBoF8+C9+eDbJPywZVCU3pm/19WSx7I
 wH/Q==
X-Gm-Message-State: AFq9FYLbsGCQJzdEQ0RiwFi4b+d0yBQc0lJu9eJ7nd3yRXS7WKrlmgW+
 M/RQFOSZ3e+rMKheQ/cokvAHNpcw+nnf2qLY+A/Yv6VIr1PkHXz5n9SPJXoqSA==
X-Gm-Gg: AYBFou0wEcjRq+pLi8i5Eaeg60kQXEbQLHYg6fuN6mPpsDGw7atGbXHDE/LrwoSddFX
 LFIHnt/YN1RJgE09TaYNdcsDX1UVXoNKi+NlDYg/liQkljFyyK2OmBHPK6Jp/qsEPqOZdVxlR7q
 /d59mzqDbLcm3LIrXAtR3O8TbTSZvAmrkHyiEKmJD+0UpvWbfXXd18bxsRWDeJ47mHCsqjgTGMt
 d8UpaUTniLYlLEdzwHg23AjqXWkzC8PHyOpHqzB3ycdbqCc0SlUpYb0i5WKpp2xmxNXyz9L3it8
 Yy1MEUBI1Cx3ALVMb3DoBXyAAi0g+reiscznLp/BbNypJ0nEQebuH7lwL/gVQ6cPo/rG5WOCb+j
 OvXYE3eT+2G3LI5aEq9WcuQ3ZtAwSmYcLgHCZgRq/73VL89stVpWvngB3gLpWxAZUS3ypv0mUUF
 DowXwIlME2q3XXWU6bxJHAbnFNL2q6XXT9kWvEbZEqhbWkK25kc8MFj/8r5qNHed8cwtqAQnIR1
 vvlP0vY4CTzDdGcwgzX7lhfd5FwlmCf41UPPA==
X-Received: by 2002:a5d:5f85:0:b0:487:2805:6834 with SMTP id
 ffacd0b85a97d-48c6d1e6f2dmr1521384f8f.42.1791279907601; 
 Tue, 06 Oct 2026 02:45:07 -0700 (PDT)
Received: from archlinux (pd95eda80.dip0.t-ipconnect.de. [217.94.218.128])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c6faa93fbsm433426f8f.16.2026.10.06.02.45.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 02:45:07 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Christian Speich <c.speich@avm.de>, Bin Meng <bmeng.cn@gmail.com>,
 qemu-block@nongnu.org, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v5 3/8] hw/sd/sd: Use multi-byte/block writes for block path
Date: Tue,  6 Oct 2026 11:44:42 +0200
Message-ID: <20261006094447.43491-4-shentey@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261006094447.43491-1-shentey@gmail.com>
References: <20261006094447.43491-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x530.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

When writing/reading blocks via WRITE/READ_MULTIPLE_BLOCK we try to
directly pass this request down to the block layer. This can only be
done for properly sized and aligned accesses, other access still use a
bounce buffer but still benefit from copying as much data in one memcpy
as possible.

RPMB is limited to the slow path using a bounce buffer.

Signed-off-by: Christian Speich <c.speich@avm.de>

Original patch has been split into multiple ones to help review.

Further changes:
* Drive limits and write protect groups are preserved to be checked on
block boundaries only since these checks are redundant in case the SD
host transfers one byte at a time.
* WP_VIOLATION is only raised once the first protected block shall be
written, rather than immediately at the beginning of a multiple block
write which starts with allowed blocks.
* An off-by-one error has been fixed in the same case where one bye too
less had been written if a write protected block had been detected.
* There are only two rather than three code paths each handling the
multiple block optimization.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/sd/sd.c | 147 +++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 114 insertions(+), 33 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index bccb839ce6..6e2bb8ff2d 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -2702,36 +2702,84 @@ static size_t sd_write_data(SDState *sd, const void *buf, size_t length)
                                   sd->data_start, sd->blk_len)) {
                 break;
             }
+
+            /* Limit writing data to our device size */
+            length = MIN(sd->size - sd->data_start, length);
+
             if (sd->size <= SDSC_MAX_CAPACITY) {
                 if (sd_wp_addr(sd, sd->data_start)) {
                     sd->card_status |= WP_VIOLATION;
                     break;
                 }
+
+                /*
+                 * Check if any covered address violates WP. If so, limit our
+                 * write up to the allowed address.
+                 */
+                for (uint64_t addr = ROUND_UP(sd->data_start + 1, WPGROUP_SIZE);
+                     addr < sd->data_start + length;
+                     addr += WPGROUP_SIZE) {
+                    if (sd_wp_addr(sd, addr)) {
+                        length = addr - sd->data_start;
+                        break;
+                    }
+                }
             }
         }
 
-        length = MIN(sd->blk_len - sd->data_offset, length);
-        memcpy(sd->data + sd->data_offset, buf, length);
-        sd->data_offset += length;
+        partition_access = sd->ext_csd[EXT_CSD_PART_CONFIG]
+                            & EXT_CSD_PART_CONFIG_ACC_MASK;
 
-        if (sd->data_offset >= sd->blk_len) {
-            /* TODO: Check CRC before committing */
-            sd->state = sd_programming_state;
-            partition_access = sd->ext_csd[EXT_CSD_PART_CONFIG]
-                    & EXT_CSD_PART_CONFIG_ACC_MASK;
-            if (partition_access == EXT_CSD_PART_CONFIG_ACC_RPMB) {
-                emmc_rpmb_blk_write(sd, sd->data_start, sd->data_offset);
-            } else {
-                sd_blk_write(sd, sd->data, sd->data_start, sd->data_offset);
+        if (length < sd->blk_len || sd->data_offset > 0
+            || partition_access == EXT_CSD_PART_CONFIG_ACC_RPMB) {
+            /* Partial write or RPMB (single block only for now) */
+            length = MIN(sd->blk_len - sd->data_offset, length);
+
+            memcpy(sd->data + sd->data_offset, buf, length);
+            sd->data_offset += length;
+
+            if (sd->data_offset >= sd->blk_len) {
+                sd->state = sd_programming_state;
+                if (partition_access == EXT_CSD_PART_CONFIG_ACC_RPMB) {
+                    emmc_rpmb_blk_write(sd, sd->data_start, sd->data_offset);
+                } else {
+                    sd_blk_write(sd, sd->data, sd->data_start, sd->data_offset);
+                }
+                sd->blk_written++;
+                sd->data_start += sd->blk_len;
+                sd->data_offset = 0;
+                sd->csd[14] |= 0x40;
+
+                /* Bzzzzzzztt .... Operation complete.  */
+                if (sd->multi_blk_cnt != 0) {
+                    if (--sd->multi_blk_cnt == 0) {
+                        /* Stop! */
+                        sd->state = sd_transfer_state;
+                        break;
+                    }
+                }
+
+                sd->state = sd_receivingdata_state;
             }
-            sd->blk_written++;
-            sd->data_start += sd->blk_len;
-            sd->data_offset = 0;
+        } else {
+            /* Write multiple of block sizes */
+            length = QEMU_ALIGN_DOWN(length, sd->blk_len);
+
+            /* For limited writes, only write the requested block count. */
+            if (sd->multi_blk_cnt != 0) {
+                length = MIN(length, sd->multi_blk_cnt * sd->blk_len);
+            }
+
+            sd->state = sd_programming_state;
+            sd_blk_write(sd, buf, sd->data_start, length);
+            sd->blk_written += length / sd->blk_len;
+            sd->data_start += length;
             sd->csd[14] |= 0x40;
 
-            /* Bzzzzzzztt .... Operation complete.  */
             if (sd->multi_blk_cnt != 0) {
-                if (--sd->multi_blk_cnt == 0) {
+                sd->multi_blk_cnt -= length / sd->blk_len;
+
+                if (sd->multi_blk_cnt == 0) {
                     /* Stop! */
                     sd->state = sd_transfer_state;
                     break;
@@ -2740,6 +2788,7 @@ static size_t sd_write_data(SDState *sd, const void *buf, size_t length)
 
             sd->state = sd_receivingdata_state;
         }
+
         break;
 
     case 26:  /* CMD26:  PROGRAM_CID */
@@ -2855,28 +2904,60 @@ static size_t sd_read_data(SDState *sd, void *buf, size_t length)
                 memset(buf, dummy_byte, length);
                 return length;
             }
-            partition_access = sd->ext_csd[EXT_CSD_PART_CONFIG]
-                    & EXT_CSD_PART_CONFIG_ACC_MASK;
-            if (partition_access == EXT_CSD_PART_CONFIG_ACC_RPMB) {
-                emmc_rpmb_blk_read(sd, sd->data_start, io_len);
-            } else {
-                sd_blk_read(sd, sd->data, sd->data_start, io_len);
-            }
         }
 
-        length = MIN(io_len - sd->data_offset, length);
-        memcpy(buf, sd->data + sd->data_offset, length);
-        sd->data_offset += length;
+        /* Limit reading data to our device size */
+        length = MIN(sd->size - sd->data_start, length);
+
+        partition_access = sd->ext_csd[EXT_CSD_PART_CONFIG]
+                & EXT_CSD_PART_CONFIG_ACC_MASK;
+
+        if (length < io_len || sd->data_offset > 0
+            || partition_access == EXT_CSD_PART_CONFIG_ACC_RPMB) {
+            /* Partial read or RPMB (single block only for now) */
+            if (sd->data_offset == 0) {
+                /* Fill the buffer */
+                if (partition_access == EXT_CSD_PART_CONFIG_ACC_RPMB) {
+                    emmc_rpmb_blk_read(sd, sd->data_start, io_len);
+                } else {
+                    sd_blk_read(sd, sd->data, sd->data_start, io_len);
+                }
+            }
+
+            length = MIN(io_len - sd->data_offset, length);
+            memcpy(buf, sd->data + sd->data_offset, length);
+            sd->data_offset += length;
 
-        if (sd->data_offset >= io_len) {
-            sd->data_start += io_len;
-            sd->data_offset = 0;
+            if (sd->data_offset >= io_len) {
+                sd->data_start += io_len;
+                sd->data_offset = 0;
 
+                if (sd->multi_blk_cnt != 0) {
+                    if (--sd->multi_blk_cnt == 0) {
+                        /* Stop! */
+                        sd->state = sd_transfer_state;
+                        break;
+                    }
+                }
+            }
+        } else {
+            /* Read multiple of block sizes */
+            length = QEMU_ALIGN_DOWN(length, io_len);
+
+            /* For limited reads, only read the requested block count. */
             if (sd->multi_blk_cnt != 0) {
-                if (--sd->multi_blk_cnt == 0) {
-                    /* Stop! */
+                length = MIN(length, sd->multi_blk_cnt * io_len);
+            }
+
+            sd_blk_read(sd, buf, sd->data_start, length);
+
+            sd->data_start += length;
+
+            if (sd->multi_blk_cnt != 0) {
+                sd->multi_blk_cnt -= length / io_len;
+
+                if (sd->multi_blk_cnt == 0) {
                     sd->state = sd_transfer_state;
-                    break;
                 }
             }
         }
-- 
2.56.0


