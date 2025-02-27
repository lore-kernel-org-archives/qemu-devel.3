Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BB61C021BE
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 11:28:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnc3A-0007Jx-EW; Thu, 27 Feb 2025 06:27:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tnc38-0007J7-BY
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 06:27:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tnc35-0003oF-HW
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 06:27:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740655645;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=4Jfi9uXrXsovf/cJf0JOniJxUobQN4VI4wmdABwCwqE=;
 b=M9fGi3ZxNeHwf2EFsk2zgF3SXmYLGIMXgylzsnk7QsC+hY76AuR8JyTorpEmDejVZis6ka
 m2Iy5kA+Cg7ozbHw3VEg9XfsgBA2gQ5XGtg964vC9HtgsbjCgttihqUayh2oE+B7D4Xz5r
 SOBid1PJAxqGlm8vQcpIzGXHYihVAH0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-46-Q9H9gQe1PjaSyp3AUmF3fA-1; Thu, 27 Feb 2025 06:27:22 -0500
X-MC-Unique: Q9H9gQe1PjaSyp3AUmF3fA-1
X-Mimecast-MFC-AGG-ID: Q9H9gQe1PjaSyp3AUmF3fA_1740655642
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-38f2ef5f0dbso319415f8f.2
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 03:27:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740655641; x=1741260441;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=4Jfi9uXrXsovf/cJf0JOniJxUobQN4VI4wmdABwCwqE=;
 b=q2v4/B4J5sESd65qgboPYYG2a3LY9eHk6xiovfBv9MwAHfCYiF0OsO/6tG0/cR12+M
 lB6bvR3JxeJ0UuzuR+qWKznSL2OlXghiHQPmwefgfns3+MVdC7q37IGFc8bK7OyKOv9i
 9UuZP5IEyBxpvspNJlU4QwHqHNnB5iTxBvqxPEpBhGkDHM9z0+lBeV777pPFtv+UvPHG
 204RUaXP1nS0GNiBw0Si+/kANOrVkjyvodQ5sWoA+C2gj5KF9d1zjYLQRghhzXznyy5/
 AJJTCw2yd27Vx7eutjaqwJ+AKnqSsI4ZotlAjyNG9fJ9K1M3EH/H2vFJfhH4KRDwo5gj
 xKTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnZMa2Osm+pUJtXzlyb5oHEgPi+U6hjixgklK4M8FBdr3QmSDmhyOxpX93ro6a2mVzo9tlw6i01u7R@nongnu.org
X-Gm-Message-State: AOJu0Yz2Y4fM8p3vXLpIAx/6X3/k6SwwzFbBuznZ/FIUJBGxiPxWW4A0
 XjolYsYn+PP0nguv4BgwoOE/8g43W8rm1Mm/dlFpeoeWNEJT7ecjMAgfmO8NpLo4aeSV97WO0q4
 5cCQN6SNRscfDDw2/wJ+6Gt0uHim8VtTj8jDwg2PQCh9dHSM8jvCq
X-Gm-Gg: ASbGncuPqwsSNUnI8R/W69frD+NxzVwEkV/f6ZIVXpC+N8b7l4MBLBAE2/4WLVkfOek
 EL3BcyXtwtsSvBmI6U4VrZNtUIMXh0Yr39L3QXSqe+58h6/Cr/B/S62FuvxlTUYxJBkvYDZAgj7
 9Lfi+czrxPUy+/XWOP/fCjYipLqA1ZYeYbmEGeyuuF64sNfg9+6bjSrOstXmr16qrBNbIWoM+6j
 loxoXl8n6DcgFcMJZnUKZNvzflm6Zrpdz28A6NGZ4r18+etMxqus1dT4RoHO1heGoBkubY7yr4w
 ZjHwVbN0OlVySQYTtoOQ6w10bHdOrB663QLXTkl7FWvp
X-Received: by 2002:a05:6000:18a9:b0:390:e521:463 with SMTP id
 ffacd0b85a97d-390e5210840mr1450468f8f.52.1740655641519; 
 Thu, 27 Feb 2025 03:27:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHsQ3273vbqqY6JaTSuQk/IEl38kZl03Aod5u6l4D66/9EYbZ/WI3OmRTUj4SffgbOlcxA7ZA==
X-Received: by 2002:a05:6000:18a9:b0:390:e521:463 with SMTP id
 ffacd0b85a97d-390e5210840mr1450439f8f.52.1740655641110; 
 Thu, 27 Feb 2025 03:27:21 -0800 (PST)
Received: from [192.168.3.141] (p5b0c6727.dip0.t-ipconnect.de. [91.12.103.39])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e47a66adsm1723757f8f.25.2025.02.27.03.27.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Feb 2025 03:27:20 -0800 (PST)
Message-ID: <812768d7-a02d-4b29-95f3-fb7a125cf54e@redhat.com>
Date: Thu, 27 Feb 2025 12:27:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/2] system/memory: Allow creating IOMMU mappings from RAM
 discard populate notifiers
To: Chenyi Qiang <chenyi.qiang@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, philmd@linaro.org,
 peterx@redhat.com, pbonzini@redhat.com, peter.maydell@linaro.org,
 Alexey Kardashevskiy <aik@amd.com>, Gao Chao <chao.gao@intel.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
References: <20250220161320.518450-2-jean-philippe@linaro.org>
 <20250220161320.518450-3-jean-philippe@linaro.org>
 <0d761daf-174d-487f-80fe-09b04902006f@redhat.com>
 <75d90f78-151f-4169-84f5-cc3c13180518@intel.com>
 <ce2306f9-19a4-4979-80e6-29b1e8a92318@redhat.com>
 <108be3a5-cfc1-4268-a913-3a41d1e4451f@intel.com>
 <16cb9605-ba4c-441e-8709-369a37655b4a@intel.com>
 <4a589056-b331-4dde-aa77-9129106a14c0@redhat.com>
 <b0e11469-775e-45e3-bbcb-319557c20a47@intel.com>
 <39155512-8d71-412e-aa5c-591d7317d210@intel.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <39155512-8d71-412e-aa5c-591d7317d210@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On 27.02.25 04:26, Chenyi Qiang wrote:
> 
> 
> On 2/26/2025 8:43 PM, Chenyi Qiang wrote:
>>
>>
>> On 2/25/2025 5:41 PM, David Hildenbrand wrote:
>>> On 25.02.25 03:00, Chenyi Qiang wrote:
>>>>
>>>>
>>>> On 2/21/2025 6:04 PM, Chenyi Qiang wrote:
>>>>>
>>>>>
>>>>> On 2/21/2025 4:09 PM, David Hildenbrand wrote:
>>>>>> On 21.02.25 03:25, Chenyi Qiang wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 2/21/2025 3:39 AM, David Hildenbrand wrote:
>>>>>>>> On 20.02.25 17:13, Jean-Philippe Brucker wrote:
>>>>>>>>> For Arm CCA we'd like the guest_memfd discard notifier to call the
>>>>>>>>> IOMMU
>>>>>>>>> notifiers and create e.g. VFIO mappings. The default VFIO discard
>>>>>>>>> notifier isn't sufficient for CCA because the DMA addresses need a
>>>>>>>>> translation (even without vIOMMU).
>>>>>>>>>
>>>>>>>>> At the moment:
>>>>>>>>> * guest_memfd_state_change() calls the populate() notifier
>>>>>>>>> * the populate notifier() calls IOMMU notifiers
>>>>>>>>> * the IOMMU notifier handler calls memory_get_xlat_addr() to get
>>>>>>>>> a VA
>>>>>>>>> * it calls ram_discard_manager_is_populated() which fails.
>>>>>>>>>
>>>>>>>>> guest_memfd_state_change() only changes the section's state after
>>>>>>>>> calling the populate() notifier. We can't easily invert the order of
>>>>>>>>> operation because it uses the old state bitmap to know which
>>>>>>>>> pages need
>>>>>>>>> the populate() notifier.
>>>>>>>>
>>>>>>>> I assume we talk about this code: [1]
>>>>>>>>
>>>>>>>> [1] https://lkml.kernel.org/r/20250217081833.21568-1-
>>>>>>>> chenyi.qiang@intel.com
>>>>>>>>
>>>>>>>>
>>>>>>>> +static int memory_attribute_state_change(MemoryAttributeManager
>>>>>>>> *mgr,
>>>>>>>> uint64_t offset,
>>>>>>>> +                                         uint64_t size, bool
>>>>>>>> shared_to_private)
>>>>>>>> +{
>>>>>>>> +    int block_size = memory_attribute_manager_get_block_size(mgr);
>>>>>>>> +    int ret = 0;
>>>>>>>> +
>>>>>>>> +    if (!memory_attribute_is_valid_range(mgr, offset, size)) {
>>>>>>>> +        error_report("%s, invalid range: offset 0x%lx, size 0x%lx",
>>>>>>>> +                     __func__, offset, size);
>>>>>>>> +        return -1;
>>>>>>>> +    }
>>>>>>>> +
>>>>>>>> +    if ((shared_to_private &&
>>>>>>>> memory_attribute_is_range_discarded(mgr,
>>>>>>>> offset, size)) ||
>>>>>>>> +        (!shared_to_private &&
>>>>>>>> memory_attribute_is_range_populated(mgr,
>>>>>>>> offset, size))) {
>>>>>>>> +        return 0;
>>>>>>>> +    }
>>>>>>>> +
>>>>>>>> +    if (shared_to_private) {
>>>>>>>> +        memory_attribute_notify_discard(mgr, offset, size);
>>>>>>>> +    } else {
>>>>>>>> +        ret = memory_attribute_notify_populate(mgr, offset, size);
>>>>>>>> +    }
>>>>>>>> +
>>>>>>>> +    if (!ret) {
>>>>>>>> +        unsigned long first_bit = offset / block_size;
>>>>>>>> +        unsigned long nbits = size / block_size;
>>>>>>>> +
>>>>>>>> +        g_assert((first_bit + nbits) <= mgr->bitmap_size);
>>>>>>>> +
>>>>>>>> +        if (shared_to_private) {
>>>>>>>> +            bitmap_clear(mgr->shared_bitmap, first_bit, nbits);
>>>>>>>> +        } else {
>>>>>>>> +            bitmap_set(mgr->shared_bitmap, first_bit, nbits);
>>>>>>>> +        }
>>>>>>>> +
>>>>>>>> +        return 0;
>>>>>>>> +    }
>>>>>>>> +
>>>>>>>> +    return ret;
>>>>>>>> +}
>>>>>>>>
>>>>>>>> Then, in memory_attribute_notify_populate(), we walk the bitmap
>>>>>>>> again.
>>>>>>>>
>>>>>>>> Why?
>>>>>>>>
>>>>>>>> We just checked that it's all in the expected state, no?
>>>>>>>>
>>>>>>>>
>>>>>>>> virtio-mem doesn't handle it that way, so I'm curious why we would
>>>>>>>> have
>>>>>>>> to do it here?
>>>>>>>
>>>>>>> I was concerned about the case where the guest issues a request that
>>>>>>> only partial of the range is in the desired state.
>>>>>>> I think the main problem is the policy for the guest conversion
>>>>>>> request.
>>>>>>> My current handling is:
>>>>>>>
>>>>>>> 1. When a conversion request is made for a range already in the
>>>>>>> desired
>>>>>>>      state, the helper simply returns success.
>>>>>>
>>>>>> Yes.
>>>>>>
>>>>>>> 2. For requests involving a range partially in the desired state, only
>>>>>>>      the necessary segments are converted, ensuring the entire range
>>>>>>>      complies with the request efficiently.
>>>>>>
>>>>>>
>>>>>> Ah, now I get:
>>>>>>
>>>>>> +    if ((shared_to_private && memory_attribute_is_range_discarded(mgr,
>>>>>> offset, size)) ||
>>>>>> +        (!shared_to_private &&
>>>>>> memory_attribute_is_range_populated(mgr,
>>>>>> offset, size))) {
>>>>>> +        return 0;
>>>>>> +    }
>>>>>> +
>>>>>>
>>>>>> We're not failing if it might already partially be in the other state.
>>>>>>
>>>>>>> 3. In scenarios where a conversion request is declined by other
>>>>>>> systems,
>>>>>>>      such as a failure from VFIO during notify_populate(), the
>>>>>>> helper will
>>>>>>>      roll back the request, maintaining consistency.
>>>>>>>
>>>>>>> And the policy of virtio-mem is to refuse the state change if not all
>>>>>>> blocks are in the opposite state.
>>>>>>
>>>>>> Yes.
>>>>>>
>>>>>>>
>>>>>>> Actually, this part is still a uncertain to me.
>>>>>>>
>>>>>>
>>>>>> IIUC, the problem does not exist if we only convert a single page at a
>>>>>> time.
>>>>>>
>>>>>> Is there a known use case where such partial conversions could happen?
>>>>>
>>>>> I don't see such case yet. Actually, I'm trying to follow the behavior
>>>>> of KVM_SET_MEMORY_ATTRIBUTES ioctl during page conversion. In KVM, it
>>>>> doesn't reject the request if the whole range isn't in the opposite
>>>>> state. It just uses xa_store() to update it. Also, I don't see the spec
>>>>> says how to handle such case. To be robust, I just allow this special
>>>>> case.
>>>>>
>>>>>>
>>>>>>> BTW, per the status/bitmap track, the virtio-mem also changes the
>>>>>>> bitmap
>>>>>>> after the plug/unplug notifier. This is the same, correct?
>>>>>> Right. But because we reject these partial requests, we don't have to
>>>>>> traverse the bitmap and could just adjust the bitmap operations.
>>>>>
>>>>> Yes, If we treat it as a guest error/bug, we can adjust it.
>>>>
>>>> Hi David, do you think which option is better? If prefer to reject the
>>>> partial requests, I'll change it in my next version.
>>>
>>> Hi,
>>>
>>> still scratching my head. Having to work around it as in this patch here is
>>> suboptimal.
>>>
>>> Could we simplify the whole thing while still allowing for (unexpected)
>>> partial
>>> conversions?
>>>
>>> Essentially: If states are mixed, fallback to a "1 block at a time"
>>> handling.
>>>
>>> The only problem is: what to do if we fail halfway through? Well, we can
>>> only have
>>> such partial completions for "populate", not for discard.
>>>
>>> Option a) Just leave it as "partially completed populate" and return the
>>> error. The
>>> bitmap and the notifiers are consistent.
>>>
>>> Option b) Just discard everything: someone tried to convert something
>>> "partial
>>> shared" to "shared". So maybe, if anything goes wrong, we can just have
>>> "all private".
>>>
>>> The question is also, what the expectation from the caller is: can the
>>> caller
>>> even make progress on failure or do we have to retry until it works?
>>
>> Yes, That's the key problem.
>>
>> For core mm side conversion, The caller (guest) handles three case:
>> success, failure and retry. guest can continue on failure but will keep
>> the memory in its original attribute and trigger some calltrace. While
>> in QEMU side, it would cause VM stop if kvm_set_memory_attributes() failed.
>>
>> As for the VFIO conversion, at present, we allow it to fail and don't
>> return error code to guest as long as we undo the conversion. It only
>> causes the device not work in guest.
>>
>> I think if we view the attribute mismatch between core mm and IOMMU as a
>> fatal error, we can call VM stop or let guest retry until it converts
>> successfully.
>>
> 
> Just think more about the options for the failure case handling
> theoretically as we haven't hit such state_change() failure:
> 
> 1. Undo + return invalid error
> Pros: The guest can make progress
> Cons: Complicated undo operations: Option a) is not appliable, because
> it leaves it as partial completed populate, but the guest thinks the
> operation has failed.
> Also need to add the undo for set_memory_attribute() after
> state_change() failed. Maybe also apply the attribute bitmap to
> set_memory_attribute() operation to handle the mixed request case
> 
> 2. Undo in VFIO and no undo for set_memory_attribute() + return success
> (Current approach in my series)
> Pros: The guest can make progress although device doesn't work.
> Cons: the attribute bitmap only tracks the status in iommu.

Right, we should avoid that. Bitmap + notifiers should stay in sync.

> 
> 3. No undo + return retry
> Pros: It keeps the attribute bitmap aligned in core mm and iommu.
> Cons: The guest doesn't know how to handle the retry. It would cause
> infinite loop.
> 
> 4. No undo + no return. Just VM stop.
> Pros: simple
> Cons: maybe overkill.
> 
> Maybe option 1 or 4 is better?

Well, we can proper undo working using a temporary bitmap when
converting to shared and we run into this "mixed" scenario.

Something like this on top of your work:


 From f36e3916596ed5952f15233eb7747c65a6424949 Mon Sep 17 00:00:00 2001
From: David Hildenbrand <david@redhat.com>
Date: Tue, 25 Feb 2025 09:55:38 +0100
Subject: [PATCH] tmp

Signed-off-by: David Hildenbrand <david@redhat.com>
---
  system/memory-attribute-manager.c | 95 +++++++++++++++++++++----------
  1 file changed, 65 insertions(+), 30 deletions(-)

diff --git a/system/memory-attribute-manager.c b/system/memory-attribute-manager.c
index 17c70cf677..e98e7367c1 100644
--- a/system/memory-attribute-manager.c
+++ b/system/memory-attribute-manager.c
@@ -274,9 +274,7 @@ static void memory_attribute_notify_discard(MemoryAttributeManager *mgr,
          if (!memory_region_section_intersect_range(&tmp, offset, size)) {
              continue;
          }
-
-        memory_attribute_for_each_populated_section(mgr, &tmp, rdl,
-                                                    memory_attribute_notify_discard_cb);
+        rdl->notify_discard(rdl, &tmp);
      }
  }
  
@@ -292,9 +290,7 @@ static int memory_attribute_notify_populate(MemoryAttributeManager *mgr,
          if (!memory_region_section_intersect_range(&tmp, offset, size)) {
              continue;
          }
-
-        ret = memory_attribute_for_each_discarded_section(mgr, &tmp, rdl,
-                                                          memory_attribute_notify_populate_cb);
+        ret = rdl->notify_populate(rdl, &tmp);
          if (ret) {
              break;
          }
@@ -311,9 +307,7 @@ static int memory_attribute_notify_populate(MemoryAttributeManager *mgr,
              if (!memory_region_section_intersect_range(&tmp, offset, size)) {
                  continue;
              }
-
-            memory_attribute_for_each_discarded_section(mgr, &tmp, rdl2,
-                                                        memory_attribute_notify_discard_cb);
+            rdl2->notify_discard(rdl2, &tmp);
          }
      }
      return ret;
@@ -348,7 +342,12 @@ static bool memory_attribute_is_range_discarded(MemoryAttributeManager *mgr,
  static int memory_attribute_state_change(MemoryAttributeManager *mgr, uint64_t offset,
                                           uint64_t size, bool shared_to_private)
  {
-    int block_size = memory_attribute_manager_get_block_size(mgr);
+    const int block_size = memory_attribute_manager_get_block_size(mgr);
+    const unsigned long first_bit = offset / block_size;
+    const unsigned long nbits = size / block_size;
+    const uint64_t end = offset + size;
+    unsigned long bit;
+    uint64_t cur;
      int ret = 0;
  
      if (!memory_attribute_is_valid_range(mgr, offset, size)) {
@@ -357,32 +356,68 @@ static int memory_attribute_state_change(MemoryAttributeManager *mgr, uint64_t o
          return -1;
      }
  
-    if ((shared_to_private && memory_attribute_is_range_discarded(mgr, offset, size)) ||
-        (!shared_to_private && memory_attribute_is_range_populated(mgr, offset, size))) {
-        return 0;
-    }
-
      if (shared_to_private) {
-        memory_attribute_notify_discard(mgr, offset, size);
-    } else {
-        ret = memory_attribute_notify_populate(mgr, offset, size);
-    }
-
-    if (!ret) {
-        unsigned long first_bit = offset / block_size;
-        unsigned long nbits = size / block_size;
-
-        g_assert((first_bit + nbits) <= mgr->bitmap_size);
-
-        if (shared_to_private) {
+        if (memory_attribute_is_range_discarded(mgr, offset, size)) {
+            /* Already private. */
+        } else if (!memory_attribute_is_range_populated(mgr, offset, size)) {
+            /* Unexpected mixture: process individual blocks. */
+            for (cur = offset; cur < end; cur += block_size) {
+                bit = cur / block_size;
+                if (!test_bit(bit, mgr->shared_bitmap))
+                    continue;
+                clear_bit(bit, mgr->shared_bitmap);
+                memory_attribute_notify_discard(mgr, cur, block_size);
+            }
+        } else {
+            /* Completely shared. */
              bitmap_clear(mgr->shared_bitmap, first_bit, nbits);
+            memory_attribute_notify_discard(mgr, offset, size);
+        }
+    } else {
+        if (memory_attribute_is_range_populated(mgr, offset, size)) {
+            /* Already shared. */
+        } else if (!memory_attribute_is_range_discarded(mgr, offset, size)) {
+            /* Unexpected mixture: process individual blocks. */
+            unsigned long *modified_bitmap = bitmap_new(nbits);
+
+            for (cur = offset; cur < end; cur += block_size) {
+                bit = cur / block_size;
+                if (test_bit(bit, mgr->shared_bitmap))
+                    continue;
+                set_bit(bit, mgr->shared_bitmap);
+                ret = memory_attribute_notify_populate(mgr, cur, block_size);
+                if (!ret) {
+                    set_bit(bit - first_bit, modified_bitmap);
+                    continue;
+                }
+                clear_bit(bit, mgr->shared_bitmap);
+                break;
+            }
+            if (ret) {
+                /*
+                 * Very unexpected: something went wrong. Revert to the old
+                 * state, marking only the blocks as private that we converted
+                 * to shared.
+                 */
+                for (cur = offset; cur < end; cur += block_size) {
+                    bit = cur / block_size;
+                    if (!test_bit(bit - first_bit, modified_bitmap))
+                        continue;
+                    assert(test_bit(bit, mgr->shared_bitmap));
+                    clear_bit(bit, mgr->shared_bitmap);
+                    memory_attribute_notify_discard(mgr, offset, block_size);
+                }
+            }
+            g_free(modified_bitmap);
          } else {
+            /* Completely private. */
              bitmap_set(mgr->shared_bitmap, first_bit, nbits);
+            ret = memory_attribute_notify_populate(mgr, offset, size);
+            if (ret) {
+                bitmap_clear(mgr->shared_bitmap, first_bit, nbits);
+            }
          }
-
-        return 0;
      }
-
      return ret;
  }
  
-- 
2.48.1


-- 
Cheers,

David / dhildenb


