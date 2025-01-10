Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 603B2E7719C
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 09:21:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWBBs-0007qN-Ib; Fri, 10 Jan 2025 04:20:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tWBBU-0007Qm-TO
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 04:20:10 -0500
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tWBBQ-0007Lv-MY
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 04:20:04 -0500
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2ef70c7efa5so2640775a91.2
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 01:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736500798; x=1737105598;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=w0c1AFi5TL3W0Hcpihtw08ZksvluhCpQSzCqVpdn178=;
 b=ot8z0OzZjy/6Mh6nKS5bJoRXf7HkU+7vQrWLE4vq5cLuixbhmvEInKO+qj2Ry1PO3I
 kJ4c/MBoscYWstnrsBxhLvzWY9j9ut2ZhxJJVA+V+ytOTpTlzEhHf8CBQuwkE+qFMWIx
 xj4i0depCDRTBp0mqjR8U0dVw4OuL4z3oFuBqqXY2afP+Y9YPjxYzrwnnxHhntsLjsk4
 XOO1Uk6oXn1A0RrkS1pEi/jt+RGsy2neDtHpDnh0TfMj9d8gXMMcB2XgpL13y3Co+2Ms
 f3OWKEh1nlgcxRDWsyGn4/aTN4OvQFVjLym/s/FvXAnS838kSlcsJkDqfqwc1Nob19rI
 kEyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736500798; x=1737105598;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w0c1AFi5TL3W0Hcpihtw08ZksvluhCpQSzCqVpdn178=;
 b=rkCpIHj7D9qIQSMJQAqb3mYw6+eIkScPw/BGLk1wrW1EGahXziFoGVQ5vRGWOE4YtO
 63ZSmAtn6Cbgbu7i2gT5O2FXYBK1cw8xqkP/OVOvRFuIxzx4nrCSJ9klJsQQvnQ/aCHi
 6nADSBLULMPquaAweaWU2g7nSTl1cKSS2oKYna+vV5su+cwZrvoElr7YDB3jdUcIKVtH
 m0D494lLplM8Y0yNsvuuZ17vHt5te/EGoBm6RQ4SqmKke296y6YP9udYJeeq5TJLWMO8
 IiCqUTu+xc0EGztLFcmZouQoXv4WPCc6YGyTyDz61E0av76oR/LPJ+QIRS5MaCsY2NM9
 Ojgg==
X-Gm-Message-State: AOJu0YyHziZqlcfuJ2lVvuD+scmwz+NMxVH5Z25XcUEayyulF94Nne8M
 AkcvIG/M2KD3jy2Z9gBRPhAF4bSCSkfd5zqEnIvBBKLVA8Vc1c7JHGlnc8OHX7w=
X-Gm-Gg: ASbGncv8+VZ3wHtcLUvee9ID63/LP//1QbUjyzsOhnRu0FXkBwRVls36KRlH0gUvQ7f
 BW1RmO3o92e2W1cX7VQYaQQKn84fEv9D8ea+JG86iPwt4+/MBF41duWPr+o5/1n91gBYfl3r6Tx
 +0NUfCjL1uJYKOno1FPm7Yk1KcWSZ9E1/Dro0CNLWTYVElwBqzmdqeX43DwgothBbpX9hTUW5+G
 CihQLEGknLCyJ8GoOYR0yahdiXTJMrXu/zIzupDqHWzm2cK3evKvjAKEYM=
X-Google-Smtp-Source: AGHT+IFXHimo5felSC8M9b6T2EXd/1qbmhkpG1zbl8GupIRv5ISM1Wm6z2PKWXuq3gPNORoqKxf8lQ==
X-Received: by 2002:a17:90b:3a0e:b0:2ee:e113:815d with SMTP id
 98e67ed59e1d1-2f548e98373mr15140172a91.8.1736500798461; 
 Fri, 10 Jan 2025 01:19:58 -0800 (PST)
Received: from localhost ([157.82.203.37]) by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-2f559451b3esm2873765a91.37.2025.01.10.01.19.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jan 2025 01:19:58 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 10 Jan 2025 18:19:34 +0900
Subject: [PATCH v8 1/2] memory: Update inline documentation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250110-san-v8-1-57a5a1be1bcf@daynix.com>
References: <20250110-san-v8-0-57a5a1be1bcf@daynix.com>
In-Reply-To: <20250110-san-v8-0-57a5a1be1bcf@daynix.com>
To: Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>, 
 BALATON Zoltan <balaton@eik.bme.hu>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 David Gibson <david@gibson.dropbear.id.au>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Alexey Kardashevskiy <aik@ozlabs.ru>, "Michael S. Tsirkin" <mst@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org, 
 devel@daynix.com, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x102e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Do not refer to "memory region's reference count"
-------------------------------------------------

Now MemoryRegions do have their own reference counts, but they will not
be used when their owners are not themselves. However, the documentation
of memory_region_ref() says it adds "1 to a memory region's reference
count", which is confusing. Avoid referring to "memory region's
reference count" and just say: "Add a reference to a memory region".
Make a similar change to memory_region_unref() too.

Refer to docs/devel/memory.rst for "owner"
------------------------------------------

memory_region_ref() and memory_region_unref() used to have their own
descriptions of "owner", but they are somewhat out-of-date and
misleading.

In particular, they say "whenever memory regions are accessed outside
the BQL, they need to be preserved against hot-unplug", but protecting
against hot-unplug is not mandatory if it is known that they will never
be hot-unplugged. They also say "MemoryRegions actually do not have
their own reference count", but they actually do. They just will not be
used unless their owners are not themselves.

Refer to docs/devel/memory.rst as the single source of truth instead of
maintaining duplicate descriptions of "owner".

Clarify that owner may be missing

---------------------------------
A memory region may not have an owner, and memory_region_ref() and
memory_region_unref() do nothing for such.

memory: Clarify owner must not call memory_region_ref()
--------------------------------------------------------

The owner must not call this function as it results in a circular
reference.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 include/exec/memory.h | 59 ++++++++++++++++++++++++---------------------------
 1 file changed, 28 insertions(+), 31 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 9458e2801d50..c3a1f106c9bf 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -1210,7 +1210,7 @@ void memory_region_section_free_copy(MemoryRegionSection *s);
  * memory_region_add_subregion() to add subregions.
  *
  * @mr: the #MemoryRegion to be initialized
- * @owner: the object that tracks the region's reference count
+ * @owner: the object that keeps the region alive
  * @name: used for debugging; not visible to the user or ABI
  * @size: size of the region; any subregions beyond this size will be clipped
  */
@@ -1220,29 +1220,26 @@ void memory_region_init(MemoryRegion *mr,
                         uint64_t size);
 
 /**
- * memory_region_ref: Add 1 to a memory region's reference count
+ * memory_region_ref: Add a reference to the owner of a memory region
  *
- * Whenever memory regions are accessed outside the BQL, they need to be
- * preserved against hot-unplug.  MemoryRegions actually do not have their
- * own reference count; they piggyback on a QOM object, their "owner".
- * This function adds a reference to the owner.
- *
- * All MemoryRegions must have an owner if they can disappear, even if the
- * device they belong to operates exclusively under the BQL.  This is because
- * the region could be returned at any time by memory_region_find, and this
- * is usually under guest control.
+ * This function adds a reference to the owner of a memory region to keep the
+ * memory region alive. It does nothing if the owner is not present as a memory
+ * region without owner will never die.
+ * For references internal to the owner, pass the memory region to object_ref()
+ * instead of using this function to avoid a circular reference.
+ * See docs/devel/memory.rst to know about owner.
  *
  * @mr: the #MemoryRegion
  */
 void memory_region_ref(MemoryRegion *mr);
 
 /**
- * memory_region_unref: Remove 1 to a memory region's reference count
+ * memory_region_unref: Remove a reference to the memory region of the owner
  *
- * Whenever memory regions are accessed outside the BQL, they need to be
- * preserved against hot-unplug.  MemoryRegions actually do not have their
- * own reference count; they piggyback on a QOM object, their "owner".
- * This function removes a reference to the owner and possibly destroys it.
+ * This function removes a reference to the owner of a memory region and
+ * possibly destroys the owner along with the memory region. It does nothing if
+ * the owner is not present.
+ * See docs/devel/memory.rst to know about owner.
  *
  * @mr: the #MemoryRegion
  */
@@ -1255,7 +1252,7 @@ void memory_region_unref(MemoryRegion *mr);
  * if @size is nonzero, subregions will be clipped to @size.
  *
  * @mr: the #MemoryRegion to be initialized.
- * @owner: the object that tracks the region's reference count
+ * @owner: the object that keeps the region alive
  * @ops: a structure containing read and write callbacks to be used when
  *       I/O is performed on the region.
  * @opaque: passed to the read and write callbacks of the @ops structure.
@@ -1275,7 +1272,7 @@ void memory_region_init_io(MemoryRegion *mr,
  *                                    directly.
  *
  * @mr: the #MemoryRegion to be initialized.
- * @owner: the object that tracks the region's reference count
+ * @owner: the object that keeps the region alive
  * @name: Region name, becomes part of RAMBlock name used in migration stream
  *        must be unique within any device
  * @size: size of the region.
@@ -1298,7 +1295,7 @@ bool memory_region_init_ram_nomigrate(MemoryRegion *mr,
  *                                          modify memory directly.
  *
  * @mr: the #MemoryRegion to be initialized.
- * @owner: the object that tracks the region's reference count
+ * @owner: the object that keeps the region alive
  * @name: Region name, becomes part of RAMBlock name used in migration stream
  *        must be unique within any device
  * @size: size of the region.
@@ -1328,7 +1325,7 @@ bool memory_region_init_ram_flags_nomigrate(MemoryRegion *mr,
  *                                     canceled.
  *
  * @mr: the #MemoryRegion to be initialized.
- * @owner: the object that tracks the region's reference count
+ * @owner: the object that keeps the region alive
  * @name: Region name, becomes part of RAMBlock name used in migration stream
  *        must be unique within any device
  * @size: used size of the region.
@@ -1357,7 +1354,7 @@ bool memory_region_init_resizeable_ram(MemoryRegion *mr,
  *                                    mmap-ed backend.
  *
  * @mr: the #MemoryRegion to be initialized.
- * @owner: the object that tracks the region's reference count
+ * @owner: the object that keeps the region alive
  * @name: Region name, becomes part of RAMBlock name used in migration stream
  *        must be unique within any device
  * @size: size of the region.
@@ -1390,7 +1387,7 @@ bool memory_region_init_ram_from_file(MemoryRegion *mr,
  *                                  mmap-ed backend.
  *
  * @mr: the #MemoryRegion to be initialized.
- * @owner: the object that tracks the region's reference count
+ * @owner: the object that keeps the region alive
  * @name: the name of the region.
  * @size: size of the region.
  * @ram_flags: RamBlock flags. Supported flags: RAM_SHARED, RAM_PMEM,
@@ -1421,7 +1418,7 @@ bool memory_region_init_ram_from_fd(MemoryRegion *mr,
  *                              region will modify memory directly.
  *
  * @mr: the #MemoryRegion to be initialized.
- * @owner: the object that tracks the region's reference count
+ * @owner: the object that keeps the region alive
  * @name: Region name, becomes part of RAMBlock name used in migration stream
  *        must be unique within any device
  * @size: size of the region.
@@ -1449,7 +1446,7 @@ void memory_region_init_ram_ptr(MemoryRegion *mr,
  * skip_dump flag.
  *
  * @mr: the #MemoryRegion to be initialized.
- * @owner: the object that tracks the region's reference count
+ * @owner: the object that keeps the region alive
  * @name: the name of the region.
  * @size: size of the region.
  * @ptr: memory to be mapped; must contain at least @size bytes.
@@ -1469,7 +1466,7 @@ void memory_region_init_ram_device_ptr(MemoryRegion *mr,
  *                           part of another memory region.
  *
  * @mr: the #MemoryRegion to be initialized.
- * @owner: the object that tracks the region's reference count
+ * @owner: the object that keeps the region alive
  * @name: used for debugging; not visible to the user or ABI
  * @orig: the region to be referenced; @mr will be equivalent to
  *        @orig between @offset and @offset + @size - 1.
@@ -1495,7 +1492,7 @@ void memory_region_init_alias(MemoryRegion *mr,
  * of the caller.
  *
  * @mr: the #MemoryRegion to be initialized.
- * @owner: the object that tracks the region's reference count
+ * @owner: the object that keeps the region alive
  * @name: Region name, becomes part of RAMBlock name used in migration stream
  *        must be unique within any device
  * @size: size of the region.
@@ -1518,7 +1515,7 @@ bool memory_region_init_rom_nomigrate(MemoryRegion *mr,
  * of the caller.
  *
  * @mr: the #MemoryRegion to be initialized.
- * @owner: the object that tracks the region's reference count
+ * @owner: the object that keeps the region alive
  * @ops: callbacks for write access handling (must not be NULL).
  * @opaque: passed to the read and write callbacks of the @ops structure.
  * @name: Region name, becomes part of RAMBlock name used in migration stream
@@ -1554,7 +1551,7 @@ bool memory_region_init_rom_device_nomigrate(MemoryRegion *mr,
  * @_iommu_mr: the #IOMMUMemoryRegion to be initialized
  * @instance_size: the IOMMUMemoryRegion subclass instance size
  * @mrtypename: the type name of the #IOMMUMemoryRegion
- * @owner: the object that tracks the region's reference count
+ * @owner: the object that keeps the region alive
  * @name: used for debugging; not visible to the user or ABI
  * @size: size of the region.
  */
@@ -1570,7 +1567,7 @@ void memory_region_init_iommu(void *_iommu_mr,
  *                          region will modify memory directly.
  *
  * @mr: the #MemoryRegion to be initialized
- * @owner: the object that tracks the region's reference count (must be
+ * @owner: the object that keeps the region alive (must be
  *         TYPE_DEVICE or a subclass of TYPE_DEVICE, or NULL)
  * @name: name of the memory region
  * @size: size of the region in bytes
@@ -1616,7 +1613,7 @@ bool memory_region_init_ram_guest_memfd(MemoryRegion *mr,
  * If you pass a non-NULL non-device @owner then we will assert.
  *
  * @mr: the #MemoryRegion to be initialized.
- * @owner: the object that tracks the region's reference count
+ * @owner: the object that keeps the region alive
  * @name: Region name, becomes part of RAMBlock name used in migration stream
  *        must be unique within any device
  * @size: size of the region.
@@ -1647,7 +1644,7 @@ bool memory_region_init_rom(MemoryRegion *mr,
  * If you pass a non-NULL non-device @owner then we will assert.
  *
  * @mr: the #MemoryRegion to be initialized.
- * @owner: the object that tracks the region's reference count
+ * @owner: the object that keeps the region alive
  * @ops: callbacks for write access handling (must not be NULL).
  * @opaque: passed to the read and write callbacks of the @ops structure.
  * @name: Region name, becomes part of RAMBlock name used in migration stream

-- 
2.47.1


