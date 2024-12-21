Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADB44E7718B
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Dec 2024 14:56:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tP0tY-0008Q3-Dq; Sat, 21 Dec 2024 09:55:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tP0tW-0008PV-Ms
 for qemu-devel@nongnu.org; Sat, 21 Dec 2024 09:55:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tP0tU-00082h-Ql
 for qemu-devel@nongnu.org; Sat, 21 Dec 2024 09:55:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734792951;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=KTGGNLDq+ZHblqIhwoQbSqXCXhFjok28uRZn9fHpyfI=;
 b=MW9YN2L+d1afjsvcINgb/FHzTB+l6w7EaDC1eVQFd+YxFjBaZLYC7Cy1DRz7Ybxiz4Vqlt
 4I9su6T33wpv80lSxIc2r/1/SdP4nJxtrmw2ZSzAZi+EfyxTrhZdnuv3S77CcSnRuVDCtw
 DCIG1c7jEMaTASjSGXCIpauPRqNFtC8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-OxZqBELfPBW42x9E2WLISA-1; Sat, 21 Dec 2024 09:55:49 -0500
X-MC-Unique: OxZqBELfPBW42x9E2WLISA-1
X-Mimecast-MFC-AGG-ID: OxZqBELfPBW42x9E2WLISA
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-436328fcfeeso21680385e9.1
 for <qemu-devel@nongnu.org>; Sat, 21 Dec 2024 06:55:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734792948; x=1735397748;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=KTGGNLDq+ZHblqIhwoQbSqXCXhFjok28uRZn9fHpyfI=;
 b=VNcn7EPCCyMKHnoNnomL91dViusH37keimDybAPqnMkDRSnOu2IK/OzG+Do4h34tpa
 pe3FCTvX433WITaudEIHbp1r+2JaOWO/lm4ObCHFDMQTragy/BFzfblGhg0Wd9zqUS/N
 MElBxG2C7a7TvyQjFUaS4FkfEqxWWFOkiWsJzA2LETHA39RTUxWHCpNemdSlhLUOzdab
 6AxGEzJX73hM3lJVl9RyH9UiQ3ey+Q9XTLvE1bMhTNzPY4bUdTSSqxsPACPR1K8K6O8O
 IiqUf25VowF12P94gGEBxo8FuYSNaIUpuP7FCe7jAQjgyAgeUYw4TtliErJwo3Tbxiqr
 5qUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqRFKETEjVzX3CfePzvebXK81RXNNLBxm4uBzF14xCSBiGDlOO4oWsQUVTJKzITQ8/INXo4Uay/dTe@nongnu.org
X-Gm-Message-State: AOJu0YzR4+RT65t3pUalNTkiaR4qxGAonXdf+j+QEGqEWAQZz9ysIeSm
 L0dZyQiRJbWqKcrNbj+aZv0IR+iS5ntoWTM3X2sLF+0yhMBiniXp2CklMSLTaFemxEgBB+rbLff
 qNT9ejlUCvO2JOxNfwFuHbstZ6epvFH8oYgyWRhe3jHu3odfpqGC3
X-Gm-Gg: ASbGncvbkLgpuxACRrbP+wSBsI0LLIPpz6bRe89j0kgCMbECYtD8kWF/H6rv8moua25
 I7V6+a01qRWiOAWnxesc9YTWRO9qg1RW46ldkI1ZsKu0KMK8RiTPuDAtA3zhDXQcbZZCAjGxc3D
 tNeKG2AAf6rmRG8TXZwYVMNWaXh5VizU07aa8v40aF7co8wcNrIcX97nNRWmYiMy99EaPET8ArQ
 PP4TJ9tv7z54EabznGWKfsgFhBrmVS1Ip77ak3Dp/mj9IjPvAsR7uUOg7U54Gfw9jENVwPwJ4ls
 /+NjEgmhPrkmugQuAGy2opVoDiPoJWaZuVaPvacYnJnPKsMZmx25vFPVcrqWhOj6xW5gNmwnARN
 Pm5TI+8YW
X-Received: by 2002:a05:600c:3550:b0:436:30e4:459b with SMTP id
 5b1f17b1804b1-43668646a71mr63501255e9.18.1734792948192; 
 Sat, 21 Dec 2024 06:55:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHB+hMEaIU+55DR+M8c/dSz4+gS7USh8bg+zXOLcN4W7FUGcIunEneSqfV1cvvHPVjyoMdXHQ==
X-Received: by 2002:a05:600c:3550:b0:436:30e4:459b with SMTP id
 5b1f17b1804b1-43668646a71mr63501135e9.18.1734792947803; 
 Sat, 21 Dec 2024 06:55:47 -0800 (PST)
Received: from ?IPV6:2003:cb:c70e:d000:4622:73e7:6184:8f0d?
 (p200300cbc70ed000462273e761848f0d.dip0.t-ipconnect.de.
 [2003:cb:c70e:d000:4622:73e7:6184:8f0d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4364b1516bbsm97289815e9.1.2024.12.21.06.55.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Dec 2024 06:55:47 -0800 (PST)
Message-ID: <b36f85c4-4f1b-4721-bab5-56e89550f421@redhat.com>
Date: Sat, 21 Dec 2024 15:55:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] physmem: allow cpu_memory_rw_debug to write to MMIO
 devices
To: vringar <git@zabka.it>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20241220195923.314208-1-git@zabka.it>
 <a9313931-a41e-46e1-b8b9-d2cc83cd663c@redhat.com>
 <44f99f89-edb6-4007-a367-f7f3b9e10b7b@zabka.it>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <44f99f89-edb6-4007-a367-f7f3b9e10b7b@zabka.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.177,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 20.12.24 23:22, vringar wrote:
> On 20/12/2024 21:59, David Hildenbrand wrote:
>> Good point, I suspect that will be problematic.
> 
> Looking at flatview_write_continue I see no early exit, so maybe it
> would still try to get through everything and work as we are hoping,
> but that's why I'd like to write a test for it.

I thought flatview_write()->flatview_access_allowed() would reject it, but I think that does not apply here.

address_space_write_rom() can write to memory_region_ram() and memory_region_is_romd(), independent of read-only protection.

> I'm just not sure if it should be a unit test or a QTest and
> what examples I could look to copy.
> 
>> Maybe address_space_write() should be taught to be able "force write" to
>> ROM instead, so it can just handle everything as part of a single loop.
>> But that's a bit more churn ...
> 
> Tbh I'm not sure whether I understand the intricacies of this code well
> enough to write such a patch without significant guidance.

In flatview_write_continue_step(), we call memory_access_is_direct(). That would
have to be taught to behave just like address_space_write_rom(): allow direct
access if memory_region_ram() || memory_region_is_romd().

Maybe something like the following could work (some more memory_access_is_direct()
callers have to be fixed to make it compile):


diff --git a/include/exec/memattrs.h b/include/exec/memattrs.h
index e27c18f3dc..89a5e75f6f 100644
--- a/include/exec/memattrs.h
+++ b/include/exec/memattrs.h
@@ -50,6 +50,8 @@ typedef struct MemTxAttrs {
       * (see MEMTX_ACCESS_ERROR).
       */
      unsigned int memory:1;
+    /* Debug access that can even write to ROM. */
+    unsigned int debug:1;
      /* Requester ID (for MSI for example) */
      unsigned int requester_id:16;
  
diff --git a/include/exec/memory.h b/include/exec/memory.h
index 9458e2801d..78d014aa59 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -2986,9 +2986,13 @@ MemTxResult address_space_write_cached_slow(MemoryRegionCache *cache,
  int memory_access_size(MemoryRegion *mr, unsigned l, hwaddr addr);
  bool prepare_mmio_access(MemoryRegion *mr);
  
-static inline bool memory_access_is_direct(MemoryRegion *mr, bool is_write)
+static inline bool memory_access_is_direct(MemoryRegion *mr, bool is_write,
+                                           bool is_debug)
  {
      if (is_write) {
+        if (is_debug) {
+            return memory_region_is_ram(mr) || memory_region_is_romd(mr);
+        }
          return memory_region_is_ram(mr) && !mr->readonly &&
                 !mr->rom_device && !memory_region_is_ram_device(mr);
      } else {
@@ -3027,7 +3031,7 @@ MemTxResult address_space_read(AddressSpace *as, hwaddr addr,
              fv = address_space_to_flatview(as);
              l = len;
              mr = flatview_translate(fv, addr, &addr1, &l, false, attrs);
-            if (len == l && memory_access_is_direct(mr, false)) {
+            if (len == l && memory_access_is_direct(mr, false, false)) {
                  ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
                  memcpy(buf, ptr, len);
              } else {
diff --git a/system/physmem.c b/system/physmem.c
index dc1db3a384..deb56395b7 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -571,7 +571,7 @@ MemoryRegion *flatview_translate(FlatView *fv, hwaddr addr, hwaddr *xlat,
                                      is_write, true, &as, attrs);
      mr = section.mr;
  
-    if (xen_enabled() && memory_access_is_direct(mr, is_write)) {
+    if (xen_enabled() && memory_access_is_direct(mr, is_write, attrs.debug)) {
          hwaddr page = ((addr & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE) - addr;
          *plen = MIN(page, *plen);
      }
@@ -2761,7 +2761,7 @@ static MemTxResult flatview_write_continue_step(MemTxAttrs attrs,
          return MEMTX_ACCESS_ERROR;
      }
  
-    if (!memory_access_is_direct(mr, true)) {
+    if (!memory_access_is_direct(mr, true, attrs.debug)) {
          uint64_t val;
          MemTxResult result;
          bool release_lock = prepare_mmio_access(mr);
@@ -2857,7 +2857,7 @@ static MemTxResult flatview_read_continue_step(MemTxAttrs attrs, uint8_t *buf,
          return MEMTX_ACCESS_ERROR;
      }
  
-    if (!memory_access_is_direct(mr, false)) {
+    if (!memory_access_is_direct(mr, false, attrs.debug)) {
          /* I/O case */
          uint64_t val;
          MemTxResult result;
@@ -3011,7 +3011,7 @@ enum write_rom_type {
      FLUSH_CACHE,
  };
  
-static inline MemTxResult address_space_write_rom_internal(AddressSpace *as,
+static /inline MemTxResult address_space_write_rom_internal(AddressSpace *as,
                                                             hwaddr addr,
                                                             MemTxAttrs attrs,
                                                             const void *ptr,
@@ -3167,7 +3167,7 @@ static bool flatview_access_valid(FlatView *fv, hwaddr addr, hwaddr len,
      while (len > 0) {
          l = len;
          mr = flatview_translate(fv, addr, &xlat, &l, is_write, attrs);
-        if (!memory_access_is_direct(mr, is_write)) {
+        if (!memory_access_is_direct(mr, is_write, attrs.debug)) {
              l = memory_access_size(mr, l, addr);
              if (!memory_region_access_valid(mr, xlat, l, is_write, attrs)) {
                  return false;
@@ -3247,7 +3247,7 @@ void *address_space_map(AddressSpace *as,
      fv = address_space_to_flatview(as);
      mr = flatview_translate(fv, addr, &xlat, &l, is_write, attrs);
  
-    if (!memory_access_is_direct(mr, is_write)) {
+    if (!memory_access_is_direct(mr, is_write, attrs.debug)) {
          size_t used = qatomic_read(&as->bounce_buffer_size);
          for (;;) {
              hwaddr alloc = MIN(as->max_bounce_buffer_size - used, l);
@@ -3380,7 +3380,7 @@ int64_t address_space_cache_init(MemoryRegionCache *cache,
  
      mr = cache->mrs.mr;
      memory_region_ref(mr);
-    if (memory_access_is_direct(mr, is_write)) {
+    if (memory_access_is_direct(mr, is_write, false)) {
          /* We don't care about the memory attributes here as we're only
           * doing this if we found actual RAM, which behaves the same
           * regardless of attributes; so UNSPECIFIED is fine.
@@ -3565,6 +3565,7 @@ int cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
  
          page = addr & TARGET_PAGE_MASK;
          phys_addr = cpu_get_phys_page_attrs_debug(cpu, page, &attrs);
+        attrs.debug = 1;
          asidx = cpu_asidx_from_attrs(cpu, attrs);
          /* if no physical page mapped, return an error */
          if (phys_addr == -1)
@@ -3573,13 +3574,8 @@ int cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
          if (l > len)
              l = len;
          phys_addr += (addr & ~TARGET_PAGE_MASK);
-        if (is_write) {
-            res = address_space_write_rom(cpu->cpu_ases[asidx].as, phys_addr,
-                                          attrs, buf, l);
-        } else {
-            res = address_space_read(cpu->cpu_ases[asidx].as, phys_addr,
-                                     attrs, buf, l);
-        }
+        res = address_space_rw(cpu->cpu_ases[asidx].as, phys_addr, attrs, buf,
+                               l);
          if (res != MEMTX_OK) {
              return -1;
          }
-- 
2.47.1


Completely uncompiled/untested, just to share what I have in mind.


> 
>> Building another loop around address_space_write_rom+address_space_write
>> looks a bit suboptimal, but maybe it really is the low-hanging fruit here.
> 
> I don't understand what you mean by this
> Do you mean keeping the current patch or going back to v1 or a different
> third approach?

Yes, but I would actually prefer something that doesn't require that.
Let's wait for opinions from others first.

-- 
Cheers,

David / dhildenb


