Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BCA7C54E58
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 18:11:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riID7-0002U4-9p; Thu, 07 Mar 2024 13:11:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1riID2-0002Rp-IL
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 13:11:12 -0500
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1riICy-0004Rs-Q6
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 13:11:12 -0500
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-51336ab1fb7so34595e87.1
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 10:11:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709835067; x=1710439867; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mZ/K3PBuLzDgapFrWwRRkSM6VPt2uSmyXpXI8zQY5GY=;
 b=Df+asfrAa+JCIwaLmhJZx67qTcFJ/1ZLqlUfcKKmTJ3x9BcWMHFd7nR0i0Yangw+4v
 cio2PAW4lnJFWoUguZ2pY2uGpf0Ac8BjyFYDFj0oINBUNrFsi676jIg3rrq4iIdpKx1Q
 FPd7B8OE9W749wfX9MC5oRx2/HSEeKeh52rwdAx2IwFWLo6ld8lpeO2tEqHLNS7dwkPh
 G7bwgI0qcEFSyzdjo13211cHFHY9SrWOUydW00YoHGd4wJMzXjOOyoeXyLGcLf+y+nS4
 7BmzGA2cKPh6nHeLVjK+lLPs1RedCSQTU3eBNN73lCa1NBNOCrbqE2Wtz9OVJDHqQ0ga
 cehg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709835067; x=1710439867;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mZ/K3PBuLzDgapFrWwRRkSM6VPt2uSmyXpXI8zQY5GY=;
 b=AURzWtTPMBhl4A9jb37ir1r4tQs97nnlwnM4/zrKT7yuleA8XM01Y24b7MTZvyN3wF
 vKbiNtsGZtVCwTegaf2t1iDuq9U1NkhTT0KIM4ycuTHGjiQR6mQXsau4P+vuyC4RSpFf
 YR9xdthxPwfVz8ml/OG1FVkBxhWrverZEbIZrt9cnQw2WbwSmcIMqo0SCuyvwlbVjHKH
 MWQf6NkbsngYtfCFOqglE8oa6/bXUrNaJiVTmizqTUWHsCSGfS7AvvuxJmOi2URiH/FQ
 AQYZZS9cMcKOCGgBiiSisURBGtt8aySHGnP5L/u572o+Cahwbl2xRvsGPRnI1M0XpT4H
 X3vw==
X-Gm-Message-State: AOJu0YzzbmUUbBMHvP4acwz5sEMPxv/qAVDg2vkEHtxlQEuCmtxs37QH
 1g74RV2YoFdfUy1tm/wWX7qlPhtGm+9W604xfX3xtC2jCLwtYm3FaXEGDZ2O+CA=
X-Google-Smtp-Source: AGHT+IG5wz9hIRUpzgy3sMHaOG8O1jpbPGx9KIW4VTVk32PdhZ5SkNsNiyq2yXdRlMSxBfxriIWTFg==
X-Received: by 2002:a19:ca4c:0:b0:512:b696:e312 with SMTP id
 h12-20020a19ca4c000000b00512b696e312mr1839900lfj.46.1709835066664; 
 Thu, 07 Mar 2024 10:11:06 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 fs23-20020a05600c3f9700b00412f195426dsm3343613wmb.15.2024.03.07.10.11.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Mar 2024 10:11:06 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C8A745F954;
 Thu,  7 Mar 2024 18:11:05 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 John G Johnson <john.g.johnson@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Peter Xu <peterx@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Juan Quintela <quintela@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, peter.maydell@linaro.org,
 David Hildenbrand <david@redhat.com>
Subject: [PATCH 4/5] include/exec: annotate all the MemoryRegion fields
Date: Thu,  7 Mar 2024 18:11:04 +0000
Message-Id: <20240307181105.4081793-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240307181105.4081793-1-alex.bennee@linaro.org>
References: <20240307181105.4081793-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x129.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/exec/memory.h | 47 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 43 insertions(+), 4 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 17b741bc4f5..312ed564dbe 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -778,9 +778,48 @@ bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
 typedef struct CoalescedMemoryRange CoalescedMemoryRange;
 typedef struct MemoryRegionIoeventfd MemoryRegionIoeventfd;
 
-/** MemoryRegion:
- *
- * A struct representing a memory region.
+/**
+ * struct MemoryRegion - represents a memory region
+ * @parent_obj: parent QOM object for the region
+ * @romd_mode: if true ROM devices accessed directly rather than with @ops
+ * @ram: true if a RAM-type device with a @ram_block
+ * @subpage: true if region covers a subpage
+ * @readonly: true for RAM-type devices that are readonly
+ * @nonvolatile: true for nonvolatile RAM-type devices (e.g. NVDIMM)
+ * @rom_device: true for a ROM device, see also @romd_mode
+ * @flush_coalesced_mmio: true to flush any queued coalesced MMIO
+ * operations before access
+ * @unmergeable: this section should not get merged with adjacent
+ * sections
+ * @dirty_log_mask: dirty events region cares about (see DIRTY_ flags)
+ * @is_iommu: true if part of an IOMMU device
+ * @ram_block: backing @RamBlock if @ram is true
+ * @owner: base QOM object that owns this region
+ * @dev: base Device that owns this region
+ * @ops: access operations for MMIO or @romd_mode devices
+ * @opaque: @dev specific data, passed with @ops
+ * @container: parent `MemoryRegion`
+ * @mapped_via_alias: number of times mapped via @alias, container
+ * might be NULL
+ * @size: size of @MemoryRegion
+ * @addr: physical hwaddr of @MemoryRegion
+ * @destructor: cleanup function when @MemoryRegion finalized
+ * @align: alignment requirements for any physical backing store
+ * @terminates: true if this @MemoryRegion is a leaf node
+ * @ram_device: true if @ram device should use @ops to access
+ * @enabled: true once initialised, false once finalized
+ * @vga_logging_count: count of memory logging clients
+ * @alias: link to aliased @MemoryRegion
+ * @alias_offset: offset into aliased region
+ * @priority: priority when resolving overlapping regions
+ * @subregions: list of subregions in this region
+ * @subregions_link: next subregion in the chain
+ * @coalesced: list of coalesced memory ranges
+ * @name: name of memory region
+ * @ioeventfd_nb: count of @ioeventfds for region
+ * @ioeventfds: ioevent notifiers for region
+ * @rdm: if exists see #RamDiscardManager
+ * @disable_reentrancy_guard: if true don't error if device accesses itself
  */
 struct MemoryRegion {
     Object parent_obj;
@@ -806,7 +845,7 @@ struct MemoryRegion {
     const MemoryRegionOps *ops;
     void *opaque;
     MemoryRegion *container;
-    int mapped_via_alias; /* Mapped via an alias, container might be NULL */
+    int mapped_via_alias;
     Int128 size;
     hwaddr addr;
     void (*destructor)(MemoryRegion *mr);
-- 
2.39.2


