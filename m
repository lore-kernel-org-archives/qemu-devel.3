Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22E4CFF8875
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 20:04:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIB7w-0003Wx-MD; Wed, 29 Apr 2026 16:03:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joshualant@gmail.com>)
 id 1wI5QZ-0008KW-79
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 09:58:12 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joshualant@gmail.com>)
 id 1wI5QX-0007jS-5C
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 09:58:10 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-43eb05b1875so7317933f8f.3
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 06:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777471087; x=1778075887; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1GFfGXV4KJXeG6fIZzHANOu097akFBzGO6N4Zi5g/KA=;
 b=S238nruiuceF4ySqlZ475ESie96grnoaWzat1yanfaV0p6dTLBnb3pGuvCgBH5kkdj
 /WMBhqK2D+XUAfPsb9ex/Dz+91+vZpWQFKQ3I8CZ3GUzrevYTXZ5rsKH+FKVNP/iijCo
 7IiVqr1V9erlOgsI/UGJ703/1CGPyx01u+MS3ikbKnuGsBHDjCvX3tJA7qKSACpNjaKz
 rZkN/TuxkY0oqU1TWHZS2xzl4sMs0O5AklwXefvRRp6L/NYGa5dxtvIbyPvNkjThUVvn
 LRArkBWF+nJTgIWjbJ5MgdBfjR9w31kCCjar8aUMByZi72O0t2gZchHtrbwP87za779K
 2DQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777471087; x=1778075887;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1GFfGXV4KJXeG6fIZzHANOu097akFBzGO6N4Zi5g/KA=;
 b=YoU7N48v0Fb/Hls2wrUiHak1n4VtQR8OeCHDLVzWjCKyr6mHHR+39Zd416s0avrbvx
 Hr8Q97qVdkaGIZf4EKjiE7JnsUtdQP/CLbu3nGyvbGqIKb966cs1y2y3yrTJonPFcmB4
 MIbqMk6cTyI4jLVChrN22v3cZlcqX16cJ9DiRcmYTLx6dIphTsJsMB56VLQoTxMpZROS
 BPH7c2vW4WjGbq/QNjvLe6cWg830PbrgYnFLYLq+rry/hFQ1hBv0EDeTBiOfA9nNqLZu
 khdSlSOZjeQgqLA5k4ZEWZ/9nm2FH1xFHcJh8qvcKaVTSNghNCvd8Wfo/K7m4z+t5nXp
 MF7Q==
X-Gm-Message-State: AOJu0Yzik8EqG4w+8WENdvDKZZguRXCwz2lfBlkW22Rq72XVIPMLBPn8
 ksMXUZ1dl+BtttP+vC7dzdeAycpY9LEWQBJAHguVFveGDXVIFpZEzc1Y
X-Gm-Gg: AeBDieuxQUviJuAb0nO2++HK63kehP1FlndZ7+ycCxuAjfF1UZUgIhfwgFiT966Br6B
 cOgJJTdGR0qanjbhyo2uXqcAsionBpBfblGJL9L2gZItjD8PSubCqD7PetxsX+NkuIsZtT2POTp
 8Z29t1JZxVECWMnqTq3W+hfcS0eC76IuP2qhkezHNCk0xCOSG6FYn4Fb401gZwdZhEoJ5FzLMSr
 REkQ6kpQixW3xSPaMmFg8Jwg4LzgB8AREnrqai5yxA11UTAW0BTXDlpjjcELEy82viK9xIQdMgm
 kTOPvXCZGd9eqkWXrALQl/qqWkojahZoI/be41rmvGWOd0WwOWFv8nAnqU1d0YKFdgErysYqftN
 Ynktr7gXu0RCV8Ab4fcz78O9w3/HxBGxif0rB0mFLp54qsD/dyk7bbcidnbgvxr2S4TyT1oDWe3
 3L/Aq5PJO7q32fNrqH2h1DvH0VanrV46UG3p5RU4aXxyILuCREbf9jCumFsNX1lkFRAfGYyK4Js
 yg9mSIRJRc=
X-Received: by 2002:a05:6000:2584:b0:43c:ff58:35c2 with SMTP id
 ffacd0b85a97d-44648b511c6mr14263882f8f.20.1777471086695; 
 Wed, 29 Apr 2026 06:58:06 -0700 (PDT)
Received: from node1.manccluster.local (revolution.cs.man.ac.uk.
 [130.88.198.135]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-447b3d48517sm5205950f8f.5.2026.04.29.06.58.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 06:58:06 -0700 (PDT)
From: Joshua Lant <joshualant@gmail.com>
To: linux-cxl@vger.kernel.org
Cc: qemu-devel@nongnu.org, Jonathan.Cameron@huawei.com,
 arpit1.kumar@samsung.com, Joshua Lant <joshualant@gmail.com>
Subject: [RFC QEMU PATCH 10/10] cxl-mailbox-utils: Add support for VCS Get
 Virtual CXL Switch Info command.
Date: Wed, 29 Apr 2026 14:48:44 +0100
Message-ID: <20260429135717.3048713-11-joshualant@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260429135717.3048713-1-joshualant@gmail.com>
References: <20260429135717.3048713-1-joshualant@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=joshualant@gmail.com; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 29 Apr 2026 16:03:16 -0400
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

Adds support for FMAPI command 0x5200, for more
information see CXL Specification v3.2 (7.6.7.2.1).

Signed-off-by: Joshua Lant <joshualant@gmail.com>
---
 hw/cxl/cxl-mailbox-utils.c | 84 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index cf6cb65eb6..825ef35179 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -123,6 +123,7 @@ enum {
         #define GET_PHYSICAL_PORT_STATE     0x1
         #define PHYSICAL_PORT_CONTROL       0x2
     VIRTUAL_SWITCH = 0x52,
+        #define GET_VIRTUAL_SWITCH_INFO      0x0
         #define BIND_VPPB     0x1
         #define UNBIND_VPPB       0x2
     TUNNEL = 0x53,
@@ -825,6 +826,87 @@ static CXLRetCode cmd_physical_port_control(const struct cxl_cmd *cmd,
     }
 }
 
+/* CXL r3.2 Section 7.6.7.2.1: Get Virtual CXL Switch Info (Opcode 5200h) */
+static CXLRetCode cmd_get_virtual_switch_info(const struct cxl_cmd *cmd,
+                                            uint8_t *payload_in,
+                                            size_t len_in,
+                                            uint8_t *payload_out,
+                                            size_t *len_out,
+                                            CXLCCI *cci)
+{
+    struct cxl_fmapi_get_virtual_switch_info_req_pl {
+        uint8_t start_vppb;
+        uint8_t vppb_list_limit;
+        uint8_t number_of_vcs;
+        uint8_t vcs_id_list[];
+    } QEMU_PACKED *in = (void *)payload_in;
+    struct vppb_info {
+            uint8_t binding_status;
+            uint8_t bound_port_id;
+            uint8_t bound_ld_id;
+            uint8_t rsv1;
+    } QEMU_PACKED;
+    struct vcs_info_block {
+            uint8_t vcs_id;
+            uint8_t vcs_state;
+            uint8_t usp_id;
+            uint8_t num_vppbs;
+            struct vppb_info vppbs[];
+    } QEMU_PACKED;
+    struct cxl_fmapi_get_virtual_switch_info_rsp_pl {
+            uint8_t num_vcs;
+            uint8_t rsv1[3];
+            struct vcs_info_block vcs_info_list[];
+    } QEMU_PACKED *out = (void *)payload_out;
+
+    uint8_t num_vcs_ret = cci->vcs->num_usp_ppbs;
+    uint8_t num_vppbs_ret;
+    ssize_t len_out_tmp = *len_out;
+    len_out_tmp = sizeof(struct cxl_fmapi_get_virtual_switch_info_rsp_pl) +
+        (num_vcs_ret * sizeof(*out->vcs_info_list));
+    for(int i = 0; i < num_vcs_ret; i++) {
+        //num_vppbs_ret = get_num_vppbs_in_vcs(cci->d, i);
+        num_vppbs_ret = cci->vcs->usp_ppbs[i]->info->num_vppbs;
+        //vPPB List Entry Count=min(vPPB List Limit, Number of vPPBs).
+        len_out_tmp = (num_vppbs_ret <= VPPB_LIST_LIMIT) ?
+                len_out_tmp + (num_vppbs_ret * sizeof(struct vppb_info)) :
+                len_out_tmp + (VPPB_LIST_LIMIT * sizeof(struct vppb_info));
+    }
+    *len_out = len_out_tmp;
+
+    out->num_vcs = num_vcs_ret;
+    out->rsv1[0] = 0;
+    out->rsv1[1] = 0;
+    out->rsv1[2] = 0;
+
+    uint8_t *ptr = (uint8_t *)out->vcs_info_list;
+
+    for (int i = 0; i < num_vcs_ret; i++) {
+        CXLVCSInfoBlock *info = cci->vcs->usp_ppbs[i]->info;
+        uint8_t num_vppbs = info->num_vppbs;
+        uint8_t vppb_count = MIN(num_vppbs - in->start_vppb,
+                                 in->vppb_list_limit);
+
+        /* write fixed vcs_info_block header (4 bytes) */
+        *ptr++ = info->vcs_id;
+        *ptr++ = info->vcs_state;
+        *ptr++ = info->usp_id;
+        *ptr++ = num_vppbs;
+
+        /* write vppb entries for current vcs */
+        for (int j = in->start_vppb; j < in->start_vppb + vppb_count; j++) {
+            struct vppb_info *v = (struct vppb_info *)ptr;
+            v->binding_status = info->vppbs[j]->binding_status;
+            v->bound_port_id  = info->vppbs[j]->bound_port_id;
+            v->bound_ld_id    = info->vppbs[j]->bound_ld_id;
+            v->rsv1           = 0;
+            ptr += sizeof(struct vppb_info);
+        }
+    }
+
+    return CXL_MBOX_SUCCESS;
+}
+
 /* CXL r3.2 Section 7.6.7.2.2: Bind vPPB (Opcode 5201h) */
 static CXLRetCode cmd_bind_vppb(const struct cxl_cmd *cmd,
                                             uint8_t *payload_in,
@@ -4974,6 +5056,8 @@ static const struct cxl_cmd cxl_cmd_set_vcs_mctp[256][256] = {
         cmd_get_physical_port_state, ~0, 0 },
     [PHYSICAL_SWITCH][PHYSICAL_PORT_CONTROL] = { "SWITCH_PHYSICAL_PORT_CONTROL",
         cmd_physical_port_control, 2, 0 },
+    [VIRTUAL_SWITCH][GET_VIRTUAL_SWITCH_INFO] = { "GET_VIRTUAL_SWITCH_INFO",
+        cmd_get_virtual_switch_info, ~0, 0 },
     [VIRTUAL_SWITCH][BIND_VPPB] = { "BIND_VPPB",
         cmd_bind_vppb, ~0, 0 },
     [VIRTUAL_SWITCH][UNBIND_VPPB] = { "UNBIND_VPPB",
-- 
2.47.3


