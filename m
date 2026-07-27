Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D80EC53209
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 19:22:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woQt3-0001Wm-BF; Mon, 27 Jul 2026 15:21:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1woQsP-0000i1-UM
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 15:20:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1woQsO-0000eZ-Cg
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 15:20:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785180035;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SmGEwUN6ZoBQwWGEsj9lWjkAqkITIK5CY/izBuC1F/k=;
 b=ZFE08BzVp2CfOJ1XLPSiVVd0pB1OFJO0fhGT8ATchi4ftb1M4CWuXRzrPoEu/IsbLCri2j
 aHIldtJWjeCy0VJtr2gFCqELXnYUCH3Aee9VeHbDYmdBOpTw8z94MrvKL0gy0GknIFxx1w
 7Pp/OpXj09Nrbaw9sEo1/e2fPWGl/MA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-6zX6PCLVOrO7_Zxb_CyT1g-1; Mon, 27 Jul 2026 15:20:34 -0400
X-MC-Unique: 6zX6PCLVOrO7_Zxb_CyT1g-1
X-Mimecast-MFC-AGG-ID: 6zX6PCLVOrO7_Zxb_CyT1g_1785180033
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-47f7700ffdeso1225023f8f.2
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 12:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785180033; x=1785784833; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=SmGEwUN6ZoBQwWGEsj9lWjkAqkITIK5CY/izBuC1F/k=;
 b=fDPaqcbw4JWivkFJI7s9S3y+xAv03vKC0DiiUUu3wC2DQ5ZkWO27TVUQ9Q6rYCAGbN
 CnFjdmfl8H8l+rx4SG084EVQP8GRer4XgwtFAcl6RI//VZPLLj6wrmsYc+96egwgPHE5
 rwb5wnsAvqitmGIdsIAuU3SpOaG2d6nnj48k0GreUT6dtrPxWp4ywyYm6FlVBKOebWyf
 N3apRf3YqbxnPClQty4mzz1LOztOXIJCdka3iQJh0FH+A5Sr4peBHWPJX3Ata4DDyCH6
 9KmWR221aQ4QwQ0qIFsv44R0FqykLb8vIRJPFWgL3CrloM/E4Aos2tHqjKwZtzc0uJby
 jZyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785180033; x=1785784833;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SmGEwUN6ZoBQwWGEsj9lWjkAqkITIK5CY/izBuC1F/k=;
 b=RnmMMVQwtn18ulsoCoDrbRFncLFMbh+OG7goKWrjJ/Ecvs48Rq23gYBOcoqUxsqsXU
 xllcKKvODGNNRUXb4hrW6ixUsQrm0zZM4xydTkj3qOfUf9nSx6HMZLzSi+xkYRzN/Q2y
 e9ddjYffFNYrSHAnR2hwTAVZmUe5Pmr6hQdG8AVtPgosHn5FmCLZQnzy8tZ39Ya4LLuQ
 gUDgUhKKx78GfNAzaLunKY2hFcbJhSyk/nj+0aGPK3qx8bx1awB9TWj+LRjCy8nqj4NS
 plJjydQYzBvwjWuKfIdAAJ1pwR9X3IgCvHX3zAmMsFrn9WERL5/dPYp1dmKr0n4TO5g6
 fJQg==
X-Gm-Message-State: AOJu0Yxgrlf0xNNHLh5Q/bTu5IihY5Nxoo94328yDWLTS016iPornmUm
 M3fhiuO8rGCSMxnBFiru+TeJTsuTzdXxJljft6/3D0ij2m5tBaH6cqFHrFRZmvp1lPQIbZ5e1l1
 s6qzJIAHSbLHW4xWf/3rrrVJPA0G4pUc6uobAsVLfpChMRCgXPNKtaRleWn4ezjEpF/HPCpDMaq
 bkkNoKMoB2BBbfpLagU6w9oRVtB+ZlDqMlmg==
X-Gm-Gg: AR+sD12iLW7kk38iukg/CGNVfbeqCJ7l9zCMLBwtlNphtwy+pHDIdVd9uAr5qVp5cCK
 sskgHPk13f0EkdCRvng4+Wyp33yehj5yxD+6tYwATI3jPNW4lrPsZBi1nrYswqCPLPuGlsaoVwr
 GonAVkQH+gD7zTS/aeslZ0KzOy33vHB2V35+eQBxQReEpPRPlpm79Uj8RshuZha+TTBiP7hsP01
 3SMSwfGI5hP4x0bUUO2Ue+QwRXXBp6nKi+xPtw1uXJbMbKG7TZpE66tWzzcN6kCMdKdIx/Pu9SN
 MRLq+MOV033l+AYBLZa0EFtGq4K/tm1E7o5xPi4T1ZVIUtcJKFM4CcOf/tfjY9EZ4ZL6Ku+P1no
 8ISQ7GFvVaf6Gm16W5jV96Q==
X-Received: by 2002:a05:600c:5487:b0:495:503f:cf9a with SMTP id
 5b1f17b1804b1-496b57170aamr112105255e9.9.1785180032841; 
 Mon, 27 Jul 2026 12:20:32 -0700 (PDT)
X-Received: by 2002:a05:600c:5487:b0:495:503f:cf9a with SMTP id
 5b1f17b1804b1-496b57170aamr112105055e9.9.1785180032344; 
 Mon, 27 Jul 2026 12:20:32 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-28-14.inter.net.il. [80.230.28.14])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496c45ba4b0sm15597205e9.6.2026.07.27.12.20.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 12:20:31 -0700 (PDT)
Date: Mon, 27 Jul 2026 15:20:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Haotian Jiang <jianghaotian.sunday@gmail.com>,
 qemu-stable@nongnu.org, Jonathan Cameron <jic23@kernel.org>,
 linux-cxl@vger.kernel.org
Subject: [PULL v2 25/30] hw/cxl: fix OOB access in cxl_doe_cdat_rsp via
 entry_handle
Message-ID: <292902ae4e93dcf33414ec3c6951e02d497cc850.1785179875.git.mst@redhat.com>
References: <cover.1785179875.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1785179875.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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
Reviewed-by: Jonathan Cameron <jic23@kernel.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260713072336.623604-2-jianghaotian.sunday@gmail.com>
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
MST


