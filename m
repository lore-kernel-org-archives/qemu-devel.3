Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76BE4E77199
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 05:51:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVlRQ-00021E-Jy; Thu, 09 Jan 2025 00:50:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tVlRO-00020m-9s
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 00:50:46 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tVlRJ-0002iT-GW
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 00:50:45 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2164b662090so7267715ad.1
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 21:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736401839; x=1737006639;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=laJx2oZUeMFp7Udc5AZjUwhJ0i1AyvoQsAIKFS8Mock=;
 b=wLHEK//2YEhZrb5cXGHZQ9GwhALioRuqEqMcbYO50aE0Y/KlUC6Fl9DDyQwxgk79+s
 HifHEODhgq2F4BMcz1OiBxcBXrvOwXzQhBcE/4oDi/CbtFzzoKkfdVaOOoGn1d+P9hJX
 UZ+6WbRHfEJzCRUCDiW+8ry5ZqEef91oBYN0x2MjN0aF6zHR9hexcXiamvbZdAocLhxd
 XOjE2Jk64Kws07vCtXFGfSqeaAAQWAZq5pOBQMxO6b3YuvUUlpIR9Dt2ZfsWIU6djiYP
 K4P8yNiesWkw9mF533sATPGyO1yC5p3YUixbrqssaO8UyilG9W6bszvaHKHMgxWps8S5
 YJPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736401839; x=1737006639;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=laJx2oZUeMFp7Udc5AZjUwhJ0i1AyvoQsAIKFS8Mock=;
 b=U/hazRjgqKnV2KpCWf192d6iH1aQmd9I/bGmeeFXhzroTtG3GxNdJ0ziZncf8qaePK
 hoTE1YMj0PB0i9utv38YPUTrWp+pwYEB1gDt3fyBtTqVTAwzJ0EjcCNf5T5ny7h/ChiR
 goc/tO5slA8h2z36MfFmR0n6lkqat3+2jYKx/BUh6kr4CF6BZTKrbHIg8HtqsDNZayda
 uaLTeknRC6Qaw/UI+j6nM/wJCNvUxTDQa0lUWrE0IXxed3mmGT3KaGKB+LPq6+3qnHux
 LBB8lFYLWeEdSq3zALO8NgrlSrXA6OyUofZ7mhaDAfa+cP6k1fVtU6bN5HSiHDrcVsSf
 y3Cg==
X-Gm-Message-State: AOJu0YxgwLZaY4OsMfbURW414Xogpfgx1oOQV5Me/WadHtXrWIHjFzTR
 fYqrEMdoDx1iYyB6z9kXeXLr9Rq8I4WCCVcIALHjnRW9Oh6OAbFs4P3YvPf+1ZE=
X-Gm-Gg: ASbGncvk/OK+OgJ1HTOjRnsoBgbUcgcXB/E6apiE4OuMVljfXuhJgYkEvBjp4bV0ycx
 8D+ZSvdpbHil//s3G/+gpfNA+ZYOR6F5q512zWuh1pExDdKMvsekGz7YM13Leo8Zv2UmL1dwfeG
 IGil7TFTceel99EhnoMJwbzxhTXEAW4RTSNt7aejVs2CSXmeqs9BMtJsoobjz19ftICbzBdz0bx
 eS9vzHhj9oyKy4/RQYonCZC2kWkQaELgZWa5qz8z6R37HMvCAw0eCK6R2s=
X-Google-Smtp-Source: AGHT+IFK/kXR64lSMK6S4khJ/DIIFg+qnqfHMM7+DI6Yis5/MutZQeJkXPjnIOzU8hrEvVZqV6hv3g==
X-Received: by 2002:a05:6a20:c792:b0:1e1:b35b:5132 with SMTP id
 adf61e73a8af0-1e88cfd2470mr10338679637.20.1736401838472; 
 Wed, 08 Jan 2025 21:50:38 -0800 (PST)
Received: from localhost ([157.82.203.37]) by smtp.gmail.com with UTF8SMTPSA id
 41be03b00d2f7-a317a07cccbsm453625a12.11.2025.01.08.21.50.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jan 2025 21:50:38 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 09 Jan 2025 14:50:20 +0900
Subject: [PATCH v7 1/2] memory: Update inline documentation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250109-san-v7-1-93c432a73024@daynix.com>
References: <20250109-san-v7-0-93c432a73024@daynix.com>
In-Reply-To: <20250109-san-v7-0-93c432a73024@daynix.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
index 9458e2801d50..ca247343f433 100644
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
+ * For references internal to the owner, use object_ref() instead to avoid a
+ * circular reference.
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


