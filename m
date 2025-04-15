Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3DD4C369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 08:04:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4bH7-0007nx-O3; Tue, 15 Apr 2025 04:04:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u4bH4-0007ih-3h
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 04:04:06 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u4bH2-0000nM-3H
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 04:04:05 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-39c14016868so4777628f8f.1
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 01:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744704241; x=1745309041; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IAxnsRq03PT4ZoJ+07nIHoTPDD+5r/mXool7rJj1TA8=;
 b=GgOQGFciRfRbXygm7uEP4Tw4o8DKNQwPvwbOEmfvMrpVtc1uGHUW59rFNqKLjh34Tp
 ZlgiIWXWjWtGbe4zujZwrgQeAinfobq29Tw6vFjsW7moU8TIDBGrmo+N4TbVbOLbAfGM
 l8g1G9q2TNkPKTHEuDXawoLNr+1KlQ9Qz4wOmhbe6Z881E+UfrGqhWC4uXWncNcS/0tU
 9eebiu5UZn8mtzJxt8Puj2b4qAVV1AUelUu3dHBxac0pS8iXYyvjQkkVe+5qrwpeICGU
 Oo1DU75zCAraqLtclRgDq2gogVthwoD1U5CpBOTwMyDcb6HPLwYIfEM9ZW4ZDG5WXwun
 TvwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744704241; x=1745309041;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IAxnsRq03PT4ZoJ+07nIHoTPDD+5r/mXool7rJj1TA8=;
 b=TZKJa1zdCblMBuU84s73I2/3RHCEQvxfCExYavEidHmPj5K/9BLz8ks9KOvODQLFuF
 vxcmdvUVJEowlr2OJkExUp3BgjeBET0AEBv1gnW+5K6dEl1TI8RuqtExX4EZq5NFFmHV
 xguQxZPdQM7xUijXf9hpBTwAsDoZr3n3vuZLps4DvSAoqTwf94GzSH/mpvFVnFeSZAQF
 fgoF5mP0pa5RG5624OdDAawaqU9cU+RNuQe36x89loKRsQXNNwgy6+NjM/h3VBxP5uoh
 vIHD2vYQ+baiFz4t2Blo9KLttUPH6/EC3DWfhCh9j7RUKPAOua3D9gFGOmUAXpXUlbhZ
 xUwg==
X-Gm-Message-State: AOJu0YyW1krguBqzLQ5b93N1rZNDIHYxqeDpAwLJPRC5BTipaCdvfIZc
 QQnh+3IIPpk7h2N0ZFfxaCfM1SiGtNkUaCo02IdeZjA6vsGJNe4jx+IrHOB2VcY=
X-Gm-Gg: ASbGncsabW1n1oxcuIoH96KdlYqZLSE+kMfK6Jn6j/ojQTXONHbAOZr+KopbzdCTDR5
 YCk3h/pV+4YIeeYDYaJozM4TcjHeFwelJGcK9wZCiF/weY6ULW7kOaxuL8786nAF5IbMMjzFNF7
 Ciij6oVLe6Fr7xWme2fa4SvdbY7MfTjCMyEEqdh7fimiGHeEGDkQF1a1FjW9GZ03BcMdqTyMqZO
 QWFwqQh5WciX7I4SfEOBZq8M28jFjIJbFbtDPasPv0M/ZvoFOCdXx0FBgOeXOvqkDZbDYFQ0tEI
 X7GT6qDzYNGVgPY7pcDraT97v9Y62tRvhxGLHEl2+ART3LvkEZStpxgnj/52Ct0S1bGApFljp3u
 KZA9ezMHriNhgrA==
X-Google-Smtp-Source: AGHT+IFw1QyG+Qh9Bv6fL0hipgJ2/CeESHwa7Jswb1ZN4BQhEERobxbtjY443y7/+dlf0DBtf6mMhA==
X-Received: by 2002:a5d:5f42:0:b0:38f:39e5:6b5d with SMTP id
 ffacd0b85a97d-39eaaed20d3mr12297368f8f.44.1744704241495; 
 Tue, 15 Apr 2025 01:04:01 -0700 (PDT)
Received: from [192.168.69.238] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39eaf43ccd8sm13568173f8f.72.2025.04.15.01.04.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Apr 2025 01:04:00 -0700 (PDT)
Message-ID: <b0a898ef-93cf-4ce9-8737-cac94ed4f731@linaro.org>
Date: Tue, 15 Apr 2025 10:03:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] intel_iommu: Take the bql before registering a new
 address space
To: "Michael S. Tsirkin" <mst@redhat.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 "peterx@redhat.com" <peterx@redhat.com>
References: <20250415061353.185589-1-clement.mathieu--drif@eviden.com>
 <23c9f066-f30c-4e35-8629-504eeb9cd7a8@linaro.org>
 <f3b38c07-f099-4422-87fa-32c78c7630a4@eviden.com>
 <20250415034112-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250415034112-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 15/4/25 09:42, Michael S. Tsirkin wrote:
> On Tue, Apr 15, 2025 at 07:28:34AM +0000, CLEMENT MATHIEU--DRIF wrote:
>>
>>
>> On 15/04/2025 8:53 am, Philippe Mathieu-Daudé wrote:
>>> Caution: External email. Do not open attachments or click links, unless
>>> this email comes from a known sender and you know the content is safe.
>>>
>>>
>>> On 15/4/25 08:18, CLEMENT MATHIEU--DRIF wrote:
>>>> Address space creation might end up being called without holding the
>>>> bql as it is exposed through the IOMMU ops.
>>>>
>>>> Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
>>>> ---
>>>>    hw/i386/intel_iommu.c | 10 ++++++++++
>>>>    1 file changed, 10 insertions(+)
>>>>
>>>> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>>>> index dffd7ee885..fea2220013 100644
>>>> --- a/hw/i386/intel_iommu.c
>>>> +++ b/hw/i386/intel_iommu.c
>>>> @@ -4216,6 +4216,7 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState
>>>> *s, PCIBus *bus,
>>>>        vtd_dev_as = g_hash_table_lookup(s->vtd_address_spaces, &key);
>>>>        if (!vtd_dev_as) {
>>>>            struct vtd_as_key *new_key = g_malloc(sizeof(*new_key));
>>>> +        bool take_bql = !bql_locked();
>>>>
>>>>            new_key->bus = bus;
>>>>            new_key->devfn = devfn;
>>>> @@ -4238,6 +4239,11 @@ VTDAddressSpace
>>>> *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus,
>>>>            vtd_dev_as->context_cache_entry.context_cache_gen = 0;
>>>>            vtd_dev_as->iova_tree = iova_tree_new();
>>>>
>>>> +        /* Some functions in this branch require the bql, make sure
>>>> we own it */
>>>> +        if (take_bql) {
>>>> +            bql_lock();
>>>> +        }
>>>> +
>>>>            memory_region_init(&vtd_dev_as->root, OBJECT(s), name,
>>>> UINT64_MAX);
>>>>            address_space_init(&vtd_dev_as->as, &vtd_dev_as->root, "vtd-
>>>> root");
>>>>
>>>> @@ -4305,6 +4311,10 @@ VTDAddressSpace
>>>> *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus,
>>>>
>>>>            vtd_switch_address_space(vtd_dev_as);
>>>
>>> Would it help clarifying to propagate this argument down?
>>> vtd_switch_address_space(VTDAddressSpace *as, bool need_lock);
>>
>> Hi phil, vtd_switch_address_space already does the same kind of check
>>
>>>
>>>>
>>>> +        if (take_bql) {
>>>> +            bql_unlock();
>>>> +        }
>>>> +
>>>>            g_hash_table_insert(s->vtd_address_spaces, new_key,
>>>> vtd_dev_as);
>>>>        }
>>>>        return vtd_dev_as;
>>>
> 
> 
> As an apropos, I think any caller of bql_lock really should call
> bql_lock_impl so we know who took BQL. Or just use BQL_LOCK_GUARD.
> But, that's an unrelated cleanup.
> 

Yeah unrelated cleanup. Although I don't understand why these
code paths don't use memory_region_transaction_begin/commit and
have to access BQL.

Some untested idea to investigate:
-- >8 --
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index fea22200135..b2a809cb3db 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -1726,3 +1726,6 @@ static bool vtd_as_pt_enabled(VTDAddressSpace *as)

-/* Return whether the device is using IOMMU translation. */
+/*
+ * Return whether the device is using IOMMU translation.
+ * Called with BQL locked.
+ */
  static bool vtd_switch_address_space(VTDAddressSpace *as)
@@ -1730,4 +1733,2 @@ static bool 
vtd_switch_address_space(VTDAddressSpace *as)
      bool use_iommu, pt;
-    /* Whether we need to take the BQL on our own */
-    bool take_bql = !bql_locked();

@@ -1743,10 +1744,3 @@ static bool 
vtd_switch_address_space(VTDAddressSpace *as)

-    /*
-     * It's possible that we reach here without BQL, e.g., when called
-     * from vtd_pt_enable_fast_path(). However the memory APIs need
-     * it. We'd better make sure we have had it already, or, take it.
-     */
-    if (take_bql) {
-        bql_lock();
-    }
+    memory_region_transaction_begin();

@@ -1803,5 +1797,3 @@ static bool 
vtd_switch_address_space(VTDAddressSpace *as)

-    if (take_bql) {
-        bql_unlock();
-    }
+    memory_region_transaction_commit();

@@ -1905,2 +1897,4 @@ static void 
vtd_pt_enable_fast_path(IntelIOMMUState *s, uint16_t source_id)

+    BQL_LOCK_GUARD();
+
      if (vtd_switch_address_space(vtd_as) == false) {
@@ -4241,6 +4235,3 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState 
*s, PCIBus *bus,

-        /* Some functions in this branch require the bql, make sure we 
own it */
-        if (take_bql) {
-            bql_lock();
-        }
+        memory_region_transaction_begin();

@@ -4313,5 +4304,3 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState 
*s, PCIBus *bus,

-        if (take_bql) {
-            bql_unlock();
-        }
+        memory_region_transaction_commit();

---


