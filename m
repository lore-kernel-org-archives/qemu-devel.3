Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53F65C25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 17:52:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sACZW-0006sZ-BE; Thu, 23 May 2024 13:49:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1sACYx-000655-33
 for qemu-devel@nongnu.org; Thu, 23 May 2024 13:49:11 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1sACYo-0003h0-9Z
 for qemu-devel@nongnu.org; Thu, 23 May 2024 13:49:05 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1ee954e0aa6so22523655ad.3
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 10:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716486539; x=1717091339; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D139+frhgjL58RCnIBHCYwz5taylsc59BAUfUMuPBhQ=;
 b=XcWFeygSeTEpnnwFWEEUUuc1K3fnBx9IcOq7dwd4pTx4tbNATnwQRq9xNGAeKE7lJ9
 COXTOhUPfjbKpAGlyxpQAK/DDUhWWd7snUvfrvV1kGonxv5rN56Cnolegf3QJ5GUSX7v
 cRcXjcmvuB2pqPpXvlS9MhONhw7aeekhT6ogddHhgEGAoWzvNbP3+Tz/rp4Um7UjC4+e
 Xb9ea0G4MuqnWXNI21n9paedfYDxz0zajIXVovr2WkiNAPmAV9GS5UE9EToh9KyHgFXu
 Nt/IiE++iz1lxua8JSsP+0F3SXdi8q/OHwEZKfTqNTdFezQnl5nPVKT2UbeUNingRgsF
 VtCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716486539; x=1717091339;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D139+frhgjL58RCnIBHCYwz5taylsc59BAUfUMuPBhQ=;
 b=v6cNfHvMuemFCKnw+BrRCeaSRsD7GobKKWZD2wSw3sVtY4ZRqvXbtqk1q43Y0vc9BC
 eGbLkAZgGZj5oMycLRHhyVuTbuBkoLctrLyvR4+cPYs+IDYEcF7uAIfTORLyAflDj8ZY
 dwVxyUplrmojZQ41X0gJdBJNFJSKcJPJkOniU4V4tHoDoQQz/DfoEcsoSPMvJkU+wE5O
 k0sI6ILqwM/JV6etg/fRA44/qloTMYHObyLm4EZM6ccn1aaJ5PaNOdxQX/3HqyicGE0M
 rFpOo8kGUluYWWZmJab1wJMY078ss7UK/aP+XvURwhcg2ZsJ2Wja+pibnMJLHxi6oqgL
 Tvag==
X-Gm-Message-State: AOJu0Ywd8FspcaPg6TyodF9oZ6C7mJfcIucVlrppyJzBwetchyF2z2XM
 +iGTiIoMVBDWodhpJ3bpZ1xqBLQ8NvNWfyGyy3d5NwCESqYndIR76h0tOw==
X-Google-Smtp-Source: AGHT+IHiNCVNxjjampo2HbEfeyUB2Cd/CBAs9YMqeP8IBwx0S3SCvP90fhFvR7g+v85vjkr5piZi6g==
X-Received: by 2002:a17:902:dac7:b0:1f3:51f3:9d74 with SMTP id
 d9443c01a7336-1f4486bd915mr775795ad.11.1716486538793; 
 Thu, 23 May 2024 10:48:58 -0700 (PDT)
Received: from localhost.localdomain ([2601:646:8f03:9fee:4f9e:216e:ed5a:642d])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ef0c137e7esm253436265ad.257.2024.05.23.10.48.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 10:48:58 -0700 (PDT)
From: nifan.cxl@gmail.com
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
 gregory.price@memverge.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 a.manzanares@samsung.com, dave@stgolabs.net, nmtadam.samsung@gmail.com,
 nifan.cxl@gmail.com, jim.harris@samsung.com, Jorgen.Hansen@wdc.com,
 wj28.lee@gmail.com, armbru@redhat.com, mst@redhat.com,
 Fan Ni <fan.ni@samsung.com>, Svetly Todorov <svetly.todorov@memverge.com>
Subject: [PATCH v8 13/14] hw/cxl/cxl-mailbox-utils: Add superset extent
 release mailbox support
Date: Thu, 23 May 2024 10:44:53 -0700
Message-ID: <20240523174651.1089554-14-nifan.cxl@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240523174651.1089554-1-nifan.cxl@gmail.com>
References: <20240523174651.1089554-1-nifan.cxl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Fan Ni <fan.ni@samsung.com>

With the change, we extend the extent release mailbox command processing
to allow more flexible release. As long as the DPA range of the extent to
release is covered by accepted extent(s) in the device, the release can be
performed.

Tested-by: Svetly Todorov <svetly.todorov@memverge.com>
Reviewed-by: Gregory Price <gregory.price@memverge.com>
Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 045bce8f74..ec8949ce7b 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -1704,6 +1704,13 @@ static CXLRetCode cxl_dc_extent_release_dry_run(CXLType3Dev *ct3d,
         dpa = in->updated_entries[i].start_dpa;
         len = in->updated_entries[i].len;
 
+        /* Check if the DPA range is not fully backed with valid extents */
+        if (!ct3_test_region_block_backed(ct3d, dpa, len)) {
+            ret = CXL_MBOX_INVALID_PA;
+            goto free_and_exit;
+        }
+
+        /* After this point, extent overflow is the only error can happen */
         while (len > 0) {
             QTAILQ_FOREACH(ent, updated_list, node) {
                 range_init_nofail(&range, ent->start_dpa, ent->len);
@@ -1718,14 +1725,7 @@ static CXLRetCode cxl_dc_extent_release_dry_run(CXLType3Dev *ct3d,
                     if (range_contains(&range, dpa + len - 1)) {
                         len2 = ent_start_dpa + ent_len - dpa - len;
                     } else {
-                        /*
-                         * TODO: we reject the attempt to remove an extent
-                         * that overlaps with multiple extents in the device
-                         * for now. We will allow it once superset release
-                         * support is added.
-                         */
-                        ret = CXL_MBOX_INVALID_PA;
-                        goto free_and_exit;
+                        dpa = ent_start_dpa + ent_len;
                     }
                     len_done = ent_len - len1 - len2;
 
@@ -1752,14 +1752,9 @@ static CXLRetCode cxl_dc_extent_release_dry_run(CXLType3Dev *ct3d,
                     }
 
                     len -= len_done;
-                    /* len == 0 here until superset release is added */
                     break;
                 }
             }
-            if (len) {
-                ret = CXL_MBOX_INVALID_PA;
-                goto free_and_exit;
-            }
         }
     }
 free_and_exit:
-- 
2.43.0


