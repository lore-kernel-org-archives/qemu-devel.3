Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6C7DCA6002
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:57:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENDa-0002rV-Uv; Wed, 07 Oct 2026 04:41:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xEInL-0007X3-U1
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 23:58:23 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xEInK-0003pN-5W
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 23:58:19 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-5ba328513b9so1210084e87.1
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 20:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791345496; x=1791950296; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ijBHVO8i4WEMr8/QksZUlHjObyra+9udgmuoDDxE/As=;
 b=Rxqxp6IujxDooASp3aKvRBBDeVqmpMUarOG/UG152UnU+LE2Rcd0PjRYyhNKB4Ih5b
 W5Jl4gmuOnfo633XSYpPAp1cZEUXLlC4Mhv2EZYh1+ln98sN2anc8Yve7zV0hHyE3RoE
 7i5dh3g2QXFfStFvOv2jWVYJg4VbO3VbfjGL1qzve0gSX5GADaIzdGAiRnAWRdCzDifC
 HxCN4DLR/B5+XsKQnm6Qp6JdsPRNmJHZ/qiU+VimUVkjrUWQxOqsxgG/SHsYHSWhvQjA
 Y6rUe4tEV3j9EqXSk0J/CznLBP551i/g5lbuQSJjvx5B4iHJYYuHvDH4Nwfm/5iKsAAQ
 9T4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791345496; x=1791950296;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ijBHVO8i4WEMr8/QksZUlHjObyra+9udgmuoDDxE/As=;
 b=AgF+eG2fNPqAhWtU2gW7K7gx5zV7V/KekL15D4JtBcC+GeL5LjDbHsNRJvXN15dK3m
 OCiCGIxsllKJS5wxP3PYN40CeYmQJv57ke5wtRkUYQUDhs92gSDgo4TGPVf05DmTGqcp
 bANuDJDLM0Q6C7cd1yKcwMUTu7V5+ke2R/eb4V8lNBvBrf0Ay9PGepg0RPfyy5Uze7T1
 cVkXbWlES2hmZAWPxGxnfadddQgG/BaTnnY5ProIEHyLwh7wrq4+o5FKtu3Mi41Ga856
 uKhmM5FdC2S6llysCbQNXeEkVlLLay0RQZJx+RhzDNiH8hlxFPWAr6EZf85IFVKUObSL
 /Waw==
X-Gm-Message-State: AFq9FYKy25y1pL6PbubzeYW2t11S/8EQoziBUDJoSQ+/SbRAevTIKgsc
 JtY/we8+LCGoC7xoUT2Uqr+AtXTQU/RxcUc8OJ6LjAUI9jiApVRbAh2UUdZ88A==
X-Gm-Gg: AYBFou05izDWv7MfBoAR4IZ0oj9OEDqAHMe/G67iJAii5iE3VwsikOdUY1+cQWdegXi
 mqR1k/rTmJd+mgjghj6qI5Rja18JNxkysXyqm2SO2bPUl+3X4Iw5feC1MdAKvqTgKqrxsSKz3ra
 Bn5egUujgcl4xi4e9NfRbhOr4hhv2U+4hjR6wORMfjZ35zcal6OvMwwIomeyDBHBc7nEElSDhOo
 HGu45KKcGN6ZzjPH3k9Y0qhw6ixpuBRe8tmWr/CwxtMxi5VR7xA4+aMW1hsMsKZSqUgrBlRF4oO
 qA1TSykn+tbl263/3uYrXd1XMkyXfSo/i7dlhiQjZuKzUwArBLoV1R/IHQDZaAqueWU9GRsWsuB
 VYc3wmk9su/XvhvLZOwaWRXKIPf0fni+cnskHuj+vgv5pgLaNV47ty/vMQ6B+IsBBdwg5Z/YngW
 X4SxuVy103YZyxoKRU9dbUmKO6+w9Du+KvmdTMSkXrdZYheBzKLoGuXurX8Dq97oUTHlLaZU9WW
 6rMzcdAPJm72KCXSCpb3QXhS3J80xBLaR5a1Q==
X-Received: by 2002:a05:600c:34d5:b0:49d:1fa8:b266 with SMTP id
 5b1f17b1804b1-4a17b55b28bmr15234625e9.26.1791279910595; 
 Tue, 06 Oct 2026 02:45:10 -0700 (PDT)
Received: from archlinux (pd95eda80.dip0.t-ipconnect.de. [217.94.218.128])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c6faa93fbsm433426f8f.16.2026.10.06.02.45.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 02:45:10 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Christian Speich <c.speich@avm.de>, Bin Meng <bmeng.cn@gmail.com>,
 qemu-block@nongnu.org, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v5 6/8] hw/sd/sd: Optimize erase blocks as zero.
Date: Tue,  6 Oct 2026 11:44:45 +0200
Message-ID: <20261006094447.43491-7-shentey@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261006094447.43491-1-shentey@gmail.com>
References: <20261006094447.43491-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=shentey@gmail.com; helo=mail-lf1-x12a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Christian Speich <c.speich@avm.de>

When erasing blocks as zero, we can use optimized block functions to
achieve this.

These allow us to request a large rage to be zeroed, possible optimizing
this operation and freeing disk space for sparsesly stored images.

This only is possible when erase-blocks-as-zero=true is used and can
provide a significant performance boost. The case where 0xFF is used
during erase is as slow as before.

Signed-off-by: Christian Speich <c.speich@avm.de>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/sd/sd.c | 43 +++++++++++++++++++++++++++++++++----------
 1 file changed, 33 insertions(+), 10 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index c40097924c..03c51b0291 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1322,6 +1322,26 @@ exit:
     trace_sdcard_rpmb_write_block(req, lduw_be_p(&sd->rpmb.result.result));
 }
 
+/* Requires sd->data to be filled with 0xFF */
+static void sd_erase_ff(SDState *sd, uint64_t addr, size_t len)
+{
+    int erase_len = 1 << HWBLOCK_SHIFT;
+    uint64_t erase_addr;
+
+    for (erase_addr = addr; erase_addr < addr + len; erase_addr += erase_len) {
+        sd_blk_write(sd, sd->data, erase_addr, erase_len);
+    }
+}
+
+static void sd_blk_erase(SDState *sd, uint64_t addr, size_t len)
+{
+    if (sd->erase_blocks_as_zero) {
+        blk_pwrite_zeroes(sd->blk, addr + sd_part_offset(sd), len, 0);
+    } else {
+        sd_erase_ff(sd, addr, len);
+    }
+}
+
 static void sd_erase(SDState *sd)
 {
     uint64_t erase_start = sd->erase_start;
@@ -1329,7 +1349,6 @@ static void sd_erase(SDState *sd)
     bool sdsc = true;
     uint64_t wpnum;
     uint64_t erase_addr;
-    int erase_len = 1 << HWBLOCK_SHIFT;
 
     trace_sdcard_erase(sd->erase_start, sd->erase_end);
     if (sd->erase_start == INVALID_ADDRESS
@@ -1358,24 +1377,28 @@ static void sd_erase(SDState *sd)
     sd->erase_end = INVALID_ADDRESS;
     sd->csd[14] |= 0x40;
 
-    if (sd->erase_blocks_as_zero) {
-        memset(sd->data, 0x0, erase_len);
-    } else {
-        memset(sd->data, 0xFF, erase_len);
+    if (!sd->erase_blocks_as_zero) {
+        memset(sd->data, 0xFF, 1 << HWBLOCK_SHIFT);
     }
 
-    for (erase_addr = erase_start; erase_addr <= erase_end;
-         erase_addr += erase_len) {
-        if (sdsc) {
-            /* Only SDSC cards support write protect groups */
+    /* Only SDSC cards support write protect groups */
+    if (sdsc) {
+        for (erase_addr = erase_start; erase_addr <= erase_end;
+             erase_addr = ROUND_UP(erase_addr + 1, WPGROUP_SIZE)) {
+            uint64_t wp_group_end = ROUND_UP(erase_addr + 1, WPGROUP_SIZE) - 1;
+            size_t erase_len = MIN(erase_end, wp_group_end) - erase_addr;
+
             wpnum = sd_addr_to_wpnum(erase_addr);
             assert(wpnum < sd->wp_group_bits);
             if (test_bit(wpnum, sd->wp_group_bmap)) {
                 sd->card_status |= WP_ERASE_SKIP;
                 continue;
             }
+
+            sd_blk_erase(sd, erase_addr, erase_len);
         }
-        sd_blk_write(sd, sd->data, erase_addr, erase_len);
+    } else {
+        sd_blk_erase(sd, erase_start, erase_end - erase_start);
     }
 }
 
-- 
2.56.0


