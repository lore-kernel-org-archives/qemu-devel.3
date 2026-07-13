Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72A9CC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 12:39:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjFwB-0007PH-3x; Mon, 13 Jul 2026 08:39:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jianghaotian.sunday@gmail.com>)
 id 1wjB1T-00031b-3D
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 03:24:16 -0400
Received: from mail-pz2-x01.google.com ([2607:f8b0:4864:3b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jianghaotian.sunday@gmail.com>)
 id 1wjB1G-0000YL-C8
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 03:24:03 -0400
Received: by mail-pz2-x01.google.com with SMTP id
 41be03b00d2f7-caf5fee4196so260369a12.0
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 00:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783927441; x=1784532241; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=U377PjbcCXoZWc+3EuDN1mi9AZSmdy6wOFV7gOgTSkQ=;
 b=eEejI7S3VLNT34CxurmMSGgZ4R8O/jpghZX8G3NfvC1eB3HK2dbgrfIRBJWhtXzP7h
 xl8ZkBA4zYtsoLQnJZpVYK3gfqw3Bx9mfr2i1bAh9VJHg8ng68DA26CjT21acuHpCP/i
 VG1g7SVpbKIHGWTP1KOIV9Q/XgY6WM6QCSm3rJz9V0rRijGxbYi7I0tAXVjecRldlbxf
 /5svYjPWF/Amlj0f109uUhToi6cxpffKJX3w/QbsrvMLgU4lfHVh/kWYgpSTf0UU1ATS
 YH7itm2WQldW7IuGkE2w2/KhUzg6eXClTTBGjGCbMuFLHh8kEybgULKGLE0Zwr4YrbBm
 XNbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783927441; x=1784532241;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=U377PjbcCXoZWc+3EuDN1mi9AZSmdy6wOFV7gOgTSkQ=;
 b=UvJkgSiQYNPIs3BI3rzZ07HzuK24yAXqyPn1nyKfy0VmNVtx7IxK8DB++keSs/oKnM
 pHjQtCD5Ng64XBKhxPzUShANQKRMlncVPp+5JtsgId94IwltECT7n90k/PSnY9bCR4T+
 2vD8gKRiX9H1LrtH41FBnV6uSyeAtdwDfQlaJhambI94P26w1biNBAR+ukjnajbV8yvI
 NwNgBBlj7nyYM8wUUGaTryOYANe8x2YYK/6sgO+7h24k/KOk+rCSpCa36xbHugj5A83y
 aN8m7eGkGXBVgffgW+JWx6hsNiqcZLscrE8RGZ6x6sKkFwwjN1gxkpsIgqrFfSgWClg3
 +ptA==
X-Gm-Message-State: AOJu0Yxz89xiwBCrg8UwTJxfnK+B3Ck1MtQs5z0KXnsQvx6vfcWT3dgC
 /+0h4jZGX9n43Z01hogO/kJx3OxvYYhXHckCJZM5PHa0/T7WPWSfR0qnY9KK/qzfpntJZ/B0CPs
 =
X-Gm-Gg: AfdE7ckbVtgKw+xMB1DVt2xcXdDaNmOyzlRi4QiwFnqNlBPNx7+BEI97aPGNOSSTc+g
 syzIIaJB9Hc/LIzbzYNkgjHjbAR9zzDOUe0NjHUHG3QFRc/jAlcHHcW0hhKFNxVzLLXo94WDCb4
 xKCKdmzn48C+Oyth+DfOrtR4YVIvxo+FhT3UfjXDME/FQ5qTCk9Z9WAiJG0sCn8JISOqcrSiHnn
 zRh3veHq2qD/tRjO7Qe+Ss/ngmvqO3lk0a5acx96pmU1JXzy/VwAeKCvjoNAtfTXSETDSHQ1pmc
 ntLUoIRcrbU5bz6HEq5ZsOGOOnnPaLovzdE2+BsStVQbsbC7dbWCu/6ada1PwfxCl+/domqXnaM
 jGk+j4slEXfsMLpZRP4d3Msgiy9Ro62p6uH6JSG1Z1WsmgvOXqaqyf4Gq7HCo7EDt0ppfNrp+gk
 hXP5EXoyWthz/nmrymo/unARpYfrBEHS+ISkgji/YlzYc+X4cHJPBBQX40T1XEx6Hisgaz+ebEq
 Z4HC3MMU5ck6asBPm9WsLyv+D4yEfpdWaerpTA=
X-Received: by 2002:a05:6a00:a117:b0:848:824d:aff4 with SMTP id
 d2e1a72fcca58-848896fee6fmr6810738b3a.56.1783927440952; 
 Mon, 13 Jul 2026 00:24:00 -0700 (PDT)
Received: from VM-210-252-ubuntu.. ([14.22.11.167])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8480da8bab0sm12070765b3a.8.2026.07.13.00.23.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 00:24:00 -0700 (PDT)
From: jianghaotian.sunday@gmail.com
To: qemu-devel@nongnu.org
Cc: jic23@kernel.org, mst@redhat.com, linux-cxl@vger.kernel.org,
 qemu-stable@nongnu.org, Haotian Jiang <jianghaotian.sunday@gmail.com>
Subject: [PATCH 1/1] hw/cxl: fix OOB access in cxl_doe_cdat_rsp via
 entry_handle
Date: Mon, 13 Jul 2026 15:23:36 +0800
Message-Id: <20260713072336.623604-2-jianghaotian.sunday@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260713072336.623604-1-jianghaotian.sunday@gmail.com>
References: <20260713072336.623604-1-jianghaotian.sunday@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::1;
 envelope-from=jianghaotian.sunday@gmail.com; helo=mail-pz2-x01.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 13 Jul 2026 08:39:04 -0400
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

From: Haotian Jiang <jianghaotian.sunday@gmail.com>

cxl_doe_cdat_rsp() takes ent = req->entry_handle (uint16_t, fully
guest-controlled, 0..0xFFFF) and directly indexes cdat->entry[ent]
without checking ent < cdat->entry_len. For a default cxl-type3 with
one volatile memory region, entry_len = 1 + CT3_CDAT_NUM_ENTRIES = 7,
so any entry_handle >= 7 reads past the CDATEntry array into host heap.

The OOB-read base/length are then used in
memcpy(read_mbox + offset, base, len) at cxl_type3.c:298-299, leaking
host heap memory to the guest via PCI_EXP_DOE_RD_DATA_MBOX, and
potentially overflowing the 1 MiB read_mbox heap buffer when the OOB
length field is large.

The same bug exists in the cxl-upstream implementation.

Existing checks do not bound ent: assert(cdat->entry_len) only ensures
the table is loaded; the minimum-length check only guards against a
truncated CDATReq; the entry_handle ternary at line 293 only decides
the next-handle echo, not the current access; pcie_doe_get_obj_len
reads header.length, not entry_handle.

Reproduce: build QEMU with CONFIG_CXL, boot
  -M q35,cxl=on -device pxb-cxl,bus_nr=52 ... -device cxl-type3,...
then send a CDATReq with entry_handle=0xFFFF via the DOE mailbox at
config offset 0x190. Under ASAN this reports SEGV in cxl_doe_cdat_rsp
at cxl_type3.c:281.

Fixes: f5ee7413d5 ("hw/mem/cxl-type3: Add CXL CDAT Data Object Exchange")
Fixes: 882877fc35 ("hw/pci-bridge/cxl-upstream: Add a CDAT table access DOE")
Signed-off-by: Haotian Jiang <jianghaotian.sunday@gmail.com>
Cc: qemu-stable@nongnu.org
---
 hw/mem/cxl_type3.c           | 3 +++
 hw/pci-bridge/cxl_upstream.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index cba05ec57d..28f41fa623 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -278,6 +278,9 @@ static bool cxl_doe_cdat_rsp(DOECap *doe_cap)
     }
 
     ent = req->entry_handle;
+    if (ent >= cdat->entry_len) {
+        return false;
+    }
     base = cdat->entry[ent].base;
     len = cdat->entry[ent].length;
 
diff --git a/hw/pci-bridge/cxl_upstream.c b/hw/pci-bridge/cxl_upstream.c
index b6281cbd4c..69773ff163 100644
--- a/hw/pci-bridge/cxl_upstream.c
+++ b/hw/pci-bridge/cxl_upstream.c
@@ -158,6 +158,9 @@ static bool cxl_doe_cdat_rsp(DOECap *doe_cap)
     }
 
     ent = req->entry_handle;
+    if (ent >= cdat->entry_len) {
+        return false;
+    }
     base = cdat->entry[ent].base;
     len = cdat->entry[ent].length;
 
-- 
2.34.1


