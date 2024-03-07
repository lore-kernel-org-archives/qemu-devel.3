Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59543C54E4A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 18:11:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riID5-0002TO-KH; Thu, 07 Mar 2024 13:11:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1riID4-0002SV-54
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 13:11:14 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1riID2-0004SJ-4q
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 13:11:13 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-412f62edf25so8876145e9.3
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 10:11:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709835070; x=1710439870; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oL9yBj/gQtPHfe3iZvA3nzS0UYJu6qOXKEO5ee6KSH8=;
 b=u4YfgHelJoWz1Yvc63MUBFgP9eYbwqdo6DB6Up8oI7912MHFzugytCigz0bnGBJIB1
 CxtOZN0U09Mc5hsiM/Wy9TGwO6c3jalcpqg2N9PZqp0KJWkoT7mSPoFh25DtJYqi2x1K
 EAdwICXgGwQlfc2rKBneJP5kuPYFSSMwzCaMadJb2q0DilF+mIWCVw46kXiJyiA6ufMl
 Vl9iPdFeRWZEIKetyYGlguPpSRwxpp3tHW9vd/sDfvPXDl7HvRj5wh6ddzVahB8yTd4J
 t/ubPVsFpkHD58F9Rc2CrLTEcKsGM+QI5pPN3X+vLFDca8oDq0gOcV8YeMFnj+1tRXS9
 7l6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709835070; x=1710439870;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oL9yBj/gQtPHfe3iZvA3nzS0UYJu6qOXKEO5ee6KSH8=;
 b=O7rUp1oUEpJO2cCtPfk+jIt1vVigbHoJM7sydONscI+C/c8WxXnVH6oibebNF6nYRN
 RIMrKtq6XWXLnmDxhbsjLbfNnSv0sDUDohvonWlXvrDaUm5oO/3uin/2sSfYn/b7qogQ
 1vrXCd4j7rnkWiBqG2PbRT8+Db0yOiqJCCSHIHRkXujiqqcIq8Jz+9cEvCk3iEebjPMX
 b8fv9ohaUiVN+mj75xgwXs7gNCf47qm0ghhkWlYO09V3fxqyW3xHg3/0otWxh0DLXa0u
 3SpbrNTZ3FAcfL7x/VGp8igvIpRHYn5faxwKXK2tkus0MobNMgeLNJ4m0EnvT8pf6HdS
 HDvw==
X-Gm-Message-State: AOJu0YxdzHpUzc94wtiCb8ynMA4qa0r910Jajag6HlLLxfpOxASPwRYe
 pi1ri2BQ4NRgMva5cWy8cywk49yvGMTGYoxfe/t1LahsforJUPaZrNLwIWteDXI=
X-Google-Smtp-Source: AGHT+IG3HM/Z2boLhLDttmaJVoSrTwiAH1rBFBSnfEiRM1iYQnLnF7z5gSy9RnZuENob6L9BPASg6w==
X-Received: by 2002:a05:600c:1c84:b0:412:e555:818c with SMTP id
 k4-20020a05600c1c8400b00412e555818cmr8774998wms.26.1709835069608; 
 Thu, 07 Mar 2024 10:11:09 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 l14-20020a7bc44e000000b00412f6c695d1sm3293442wmi.43.2024.03.07.10.11.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Mar 2024 10:11:09 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id DBA785F956;
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
Subject: [PATCH 5/5] docs/devel: mark out defined functions and structures
Date: Thu,  7 Mar 2024 18:11:05 +0000
Message-Id: <20240307181105.4081793-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240307181105.4081793-1-alex.bennee@linaro.org>
References: <20240307181105.4081793-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
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

This allows sphinx to hyperlink the references to their kdoc
definitions for easy navigation.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 docs/devel/memory.rst | 48 +++++++++++++++++++++----------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/docs/devel/memory.rst b/docs/devel/memory.rst
index ed24708fce3..193f31198b0 100644
--- a/docs/devel/memory.rst
+++ b/docs/devel/memory.rst
@@ -16,11 +16,11 @@ The memory model provides support for
 - setting up coalesced memory for kvm
 - setting up ioeventfd regions for kvm
 
-Memory is modelled as an acyclic graph of MemoryRegion objects.  Sinks
+Memory is modelled as an acyclic graph of `MemoryRegion` objects.  Sinks
 (leaves) are RAM and MMIO regions, while other nodes represent
 buses, memory controllers, and memory regions that have been rerouted.
 
-In addition to MemoryRegion objects, the memory API provides AddressSpace
+In addition to `MemoryRegion` objects, the memory API provides `AddressSpace`
 objects for every root and possibly for intermediate MemoryRegions too.
 These represent memory as seen from the CPU or a device's viewpoint.
 
@@ -28,17 +28,17 @@ Types of regions
 ----------------
 
 There are multiple types of memory regions (all represented by a single C type
-MemoryRegion):
+`MemoryRegion`):
 
 - RAM: a RAM region is simply a range of host memory that can be made available
   to the guest.
-  You typically initialize these with memory_region_init_ram().  Some special
-  purposes require the variants memory_region_init_resizeable_ram(),
-  memory_region_init_ram_from_file(), or memory_region_init_ram_ptr().
+  You typically initialize these with `memory_region_init_ram()`.  Some special
+  purposes require the variants `memory_region_init_resizeable_ram()`,
+  `memory_region_init_ram_from_file()`, or `memory_region_init_ram_ptr()`.
 
 - MMIO: a range of guest memory that is implemented by host callbacks;
   each read or write causes a callback to be called on the host.
-  You initialize these with memory_region_init_io(), passing it a
+  You initialize these with `memory_region_init_io()`, passing it a
   MemoryRegionOps structure describing the callbacks.
 
 - ROM: a ROM memory region works like RAM for reads (directly accessing
@@ -53,7 +53,7 @@ MemoryRegion):
 - IOMMU region: an IOMMU region translates addresses of accesses made to it
   and forwards them to some other target memory region.  As the name suggests,
   these are only needed for modelling an IOMMU, not for simple devices.
-  You initialize these with memory_region_init_iommu().
+  You initialize these with `memory_region_init_iommu()`.
 
 - container: a container simply includes other memory regions, each at
   a different offset.  Containers are useful for grouping several regions
@@ -65,7 +65,7 @@ MemoryRegion):
   can overlay a subregion of RAM with MMIO or ROM, or a PCI controller
   that does not prevent card from claiming overlapping BARs.
 
-  You initialize a pure container with memory_region_init().
+  You initialize a pure container with `memory_region_init()`.
 
 - alias: a subsection of another region. Aliases allow a region to be
   split apart into discontiguous regions. Examples of uses are memory
@@ -83,7 +83,7 @@ MemoryRegion):
   It claims I/O space that is not supposed to be handled by QEMU itself.
   The typical use is to track parts of the address space which will be
   handled by the host kernel when KVM is enabled.  You initialize these
-  by passing a NULL callback parameter to memory_region_init_io().
+  by passing a NULL callback parameter to `memory_region_init_io()`.
 
 It is valid to add subregions to a region which is not a pure container
 (that is, to an MMIO, RAM or ROM region). This means that the region
@@ -104,28 +104,28 @@ copied to the destination on migration. These APIs which allocate
 the host memory for you will also register the memory so it is
 migrated:
 
-- memory_region_init_ram()
-- memory_region_init_rom()
-- memory_region_init_rom_device()
+- `memory_region_init_ram()`
+- `memory_region_init_rom()`
+- `memory_region_init_rom_device()`
 
 For most devices and boards this is the correct thing. If you
 have a special case where you need to manage the migration of
 the backing memory yourself, you can call the functions:
 
-- memory_region_init_ram_nomigrate()
-- memory_region_init_rom_nomigrate()
-- memory_region_init_rom_device_nomigrate()
+- `memory_region_init_ram_nomigrate()`
+- `memory_region_init_rom_nomigrate()`
+- `memory_region_init_rom_device_nomigrate()`
 
 which only initialize the MemoryRegion and leave handling
 migration to the caller.
 
 The functions:
 
-- memory_region_init_resizeable_ram()
-- memory_region_init_ram_from_file()
-- memory_region_init_ram_from_fd()
-- memory_region_init_ram_ptr()
-- memory_region_init_ram_device_ptr()
+- `memory_region_init_resizeable_ram()`
+- `memory_region_init_ram_from_file()`
+- `memory_region_init_ram_from_fd()`
+- `memory_region_init_ram_ptr()`
+- `memory_region_init_ram_device_ptr()`
 
 are for special cases only, and so they do not automatically
 register the backing memory for migration; the caller must
@@ -150,8 +150,8 @@ device.  For example, the owner object will not die between an
 address_space_map operation and the corresponding address_space_unmap.
 
 After creation, a region can be added to an address space or a
-container with memory_region_add_subregion(), and removed using
-memory_region_del_subregion().
+container with `memory_region_add_subregion()`, and removed using
+`memory_region_del_subregion()`.
 
 Various region attributes (read-only, dirty logging, coalesced mmio,
 ioeventfd) can be changed during the region lifecycle.  They take effect
@@ -213,7 +213,7 @@ allows the region to overlap any other region in the same container, and
 specifies a priority that allows the core to decide which of two regions at
 the same address are visible (highest wins).
 Priority values are signed, and the default value is zero. This means that
-you can use memory_region_add_subregion_overlap() both to specify a region
+you can use `memory_region_add_subregion_overlap()` both to specify a region
 that must sit 'above' any others (with a positive priority) and also a
 background region that sits 'below' others (with a negative priority).
 
-- 
2.39.2


