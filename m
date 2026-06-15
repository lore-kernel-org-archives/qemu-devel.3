Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEFD7CD98C5
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 01:18:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYvxe-0007kw-9I; Sun, 14 Jun 2026 21:17:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1wYvxc-0007kf-Kp
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 21:17:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1wYvxa-0002DT-Tz
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 21:17:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781486273;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g64Akl6sLOfYcfMkbLIPU6aC7CTnGwycOcHgRVou1AY=;
 b=QRYyqXvFIX3MAg38Fc/yIQAhpFGzWC8pN5xG5y5FvvL1vZZ+gmmdCVYXqDGkz/lOPGDKR1
 6Ae0at5OxPWU0WPoC2NIIzs4vSzhm3tBYgNs7xLx1HMDZSe9FayxZ0jKmgJg/NVYXQtDHK
 OSN5liqQxH2eBbZdQAYSlxbp8mFDpGw=
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-sr326qvTP9mvSuKyPfuxvQ-1; Sun, 14 Jun 2026 21:17:51 -0400
X-MC-Unique: sr326qvTP9mvSuKyPfuxvQ-1
X-Mimecast-MFC-AGG-ID: sr326qvTP9mvSuKyPfuxvQ_1781486271
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-304ed777a96so1885320eec.1
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 18:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781486271; x=1782091071; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=g64Akl6sLOfYcfMkbLIPU6aC7CTnGwycOcHgRVou1AY=;
 b=S1Yg3qOFN7ZLXtj/Yx34Z02cwRnnSFB8aPsgG/oCio9pcfX+PLvrTZOqtzR7h708VE
 K+Ul2LxXSoyiudDSRrNVDRRcfub9uJ8jWItqsM/GK4/xdplhYgIVGEdHdVEt6g1MdA5z
 AwoWFPsCDVdCoWevUvi2h/L8bJ6V51JYivInLWhOGn33alfKVoV6ciJloByizCl6HM18
 HhmjltG42uVdmZNSNdxLIf77HErv6yHJ36Hzv6hveVl3x4AztN2lbVlMcKAMOrv7eqR7
 sjO6eurd1uSNwRgoWrlGNHQS51D/UwASPiHfxFpfuKC8lIYdB8VdOXPIiawGA48Sj/wF
 bGOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781486271; x=1782091071;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=g64Akl6sLOfYcfMkbLIPU6aC7CTnGwycOcHgRVou1AY=;
 b=GNiaBkdnT9SiiHTBzkzMBKAre2sNCTvVoDRW2tfb2IzsmomqSBAkf6fdQLwepBdar6
 zrg5lajJevB93IKMK9QD4NjUpsQvdgCogatbmCGB/IMynXPX5Nmszc7a4fK0Tcz8DrHq
 pJVkDNsMJgTVEe9Ek3mKqCYIbBUjU/otO95AWuAnDjuSVNO2vuwWomGfgjBPGQGEPrX4
 wSFPZwy7UYVBWXFDoysKl7zsXz20dPiI59moPQUCez/qwNbbVyXsi8GB/M+MnWQIP88d
 icOgixEqvTnSX/2YscJn0YBdQj5jez+1f15WDKIsYKk29C27YGhVqQo8NG+jGtWfKwAt
 EvQw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/CxAbXc0dmFJJqzkLbmVs3qoatl0FYtUcd5luBaUe6KJnBrNga/mSLDAufxY2JjFabsWahhUx2KPNg@nongnu.org
X-Gm-Message-State: AOJu0YySJfYBrZj3twx4a2ILsYCQNRTd9LdShZIdHpKt0cQZK0nIAudw
 fgKmw4hmjfu7MreLkN+FfdWPi3T15bnvppWva2Hy/96T32QstWHIYILJwl7OxtQxXFT4ZLU3FY5
 IeAf9ZEKPJsEpoYG0gKEbbPiDsubCXvxOHwq2nuiCAEY2HEXhkqVICDBC
X-Gm-Gg: Acq92OH1vlSPFpZYhpAgFsL+bbK9qozyLguzPKQiWuSUdMkhZqsGNp/0GYwdQsY5/5t
 pxUefBblWiLIubf8WKwNqmHWZx3qOoosYw5Gwo1O8kRF4XOulaS/8s3jZZqJTzf9l+WrQUqp7vv
 YlOmsJwS6BzHV3IYDN6FunA9a5n/Qgnj+wslV6HZz0MnR3SRotLn1QWR4ZpLidleUp+QDCXLAlD
 LZDWb/22SzZ4FwpZ9gOrt/IZTOnYPdOW48KfKBmZ48spAjCI2CSBacxIqS6ZI+31gJGwNHsF3tZ
 Q1U5zj1WZxnWqMavKTurS8eduPZw76TXoH3XfBeJtNZnnTzg6apRSfJYC3Wkc9ZNmeZPkP4T00X
 78jQ+h1i/CiGJlOuoVKcjh1aF1K809KLKJgRckm161HPu0rSd12elk0VlFBdMZzD6
X-Received: by 2002:a05:7301:4244:b0:2c6:67b6:3acc with SMTP id
 5a478bee46e88-3081e4885f4mr4092381eec.15.1781486270517; 
 Sun, 14 Jun 2026 18:17:50 -0700 (PDT)
X-Received: by 2002:a05:7301:4244:b0:2c6:67b6:3acc with SMTP id
 5a478bee46e88-3081e4885f4mr4092366eec.15.1781486269993; 
 Sun, 14 Jun 2026 18:17:49 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-8-244.mrk21.qld.optusnet.com.au.
 [175.34.8.244]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3081e5d3f20sm12606899eec.9.2026.06.14.18.17.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 14 Jun 2026 18:17:49 -0700 (PDT)
Message-ID: <f176c36a-c325-458b-b443-7eaa9fcf1dfb@redhat.com>
Date: Mon, 15 Jun 2026 11:17:41 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] system/memory: Use __builtin_mem{cpy, move} in
 accessors of ram device region
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, peterx@redhat.com, berrange@redhat.com,
 david@kernel.org, alex@shazbot.org, clg@redhat.com, pbonzini@redhat.com,
 philmd@mailo.com, phrdina@redhat.com, jugraham@redhat.com,
 shan.gavin@gmail.com
References: <20260612110307.1264798-1-gshan@redhat.com>
 <20260612110307.1264798-2-gshan@redhat.com>
 <223f5f94-b9b7-46b0-8466-5be655203a0e@linaro.org>
 <CAFEAcA-TgP_BM0WQo3rysZmvhNN17Gc_nrSYB6pXn-mvs5w13g@mail.gmail.com>
 <123d9e80-d731-42c7-81cc-71de47bb13d3@linaro.org>
 <20260614084004-mutt-send-email-mst@kernel.org>
 <02d809b0-6396-40dd-a2c5-866028b7cc4d@linaro.org>
 <20260614131704-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20260614131704-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 6/15/26 3:22 AM, Michael S. Tsirkin wrote:
> On Sun, Jun 14, 2026 at 09:45:51AM -0700, Richard Henderson wrote:
>> On 6/14/26 08:13, Michael S. Tsirkin wrote:
>>> Yes, I think it does work because we use -fno-strict-aliasing.
>>> For bigger sizes we'll need packed because the addresses
>>> could be unaligned.
>> ...
>>> For most host/guest pairs things simply work even for unaligned.
>>>
>>> And yes, guest drivers do do this.
>>>
>>> On classical pci, there are no transactions as such and
>>> an unaligned access will be split anyway.
>>
>> I'm saying, if you're talking about pass-through to real devices, that won't
>> work. For instance, AArch64 will trap unaligned accesses to Device memory.
> 
> Presumably, AArch64 drivers don't do unaligned at all then?
> 

I think Michael is correct because the unaligned access isn't a concern to
ram device region. MemroyRegionOPs::impl::unaligned is true for ram device
region, which means no unaligned access concerns.

static const MemoryRegionOps ram_device_mem_ops = {
     .read = memory_region_ram_device_read,
     .write = memory_region_ram_device_write,
     .endianness = HOST_BIG_ENDIAN ? DEVICE_BIG_ENDIAN : DEVICE_LITTLE_ENDIAN,
     .valid = {
         .min_access_size = 1,
         .max_access_size = 8,
         .unaligned = true,
     },
     .impl = {
         .min_access_size = 1,
         .max_access_size = 8,
         .unaligned = true,
     },
};

system/physmem.c::memory_access_size
====================================
int memory_access_size(MemoryRegion *mr, unsigned l, hwaddr addr)
{
         :
     /* Bound the maximum access by the alignment of the address.  */
     if (!mr->ops->impl.unaligned) {
         unsigned align_size_max = addr & -addr;
         if (align_size_max != 0 && align_size_max < access_size_max) {
             access_size_max = align_size_max;
         }
     }
}

Please help to confirm if we really want to cover the unaligned access for
all architectures. After it's confirmed, I can send (v2) for further review.

>> You need to actually handle unaligned.  Perhaps something like
>>
>>      /* Find unit to fit size and alignment of dst */
>>      uintptr_t test = (uintptr_t)dst | size;
>>      uintptr_t lsb = test & -test;
>>
>>      switch (lsb) {
>>      case 1:   // loop over uint8_t
>>      case 2:   // loop over uint16_t
>>      case 4:   // loop over uint32_t
>>      default:  // loop over uint64_t
>>      }
>>
>> with the expectation that normally we'll have aligned addresses and size
>> such that the loop will iterate once.
>>

Thanks, Richard. I think it should work if we really want to cover the unaligned
access. I tried the following snippet based on yours, my issue can be fixed and
no other issues are seen in my environment.

-----> system/physmem.c

+/*
+ * qemu_ram_copy - copy data from ram block
+ *
+ * @dest: destination into which data is copied
+ * @src: source of the data
+ * @n: length of the data to be copied
+ *
+ * This function is friendly to unaligned access.
+ */
+void qemu_ram_copy(void *dest, const void *src, size_t n)
+{
+    uintptr_t test, lsb;
+
+    do {
+        test = (uintptr_t)dest | n;
+        lsb = test & -test;
+        switch (lsb) {
+        case 1:
+            *(uint8_t *)dest = *(uint8_t *)src;
+            src += 1;
+            dest += 1;
+            n -= 1;
+            break;
+        case 2:
+            *(uint16_t *)dest = *(uint16_t *)src;
+            src += 2;
+            dest += 2;
+            n -= 2;
+            break;
+        case 4:
+            *(uint32_t *)dest = *(uint32_t *)src;
+            src += 4;
+            dest += 4;
+            n -= 4;
+            break;
+        default:
+            *(uint64_t *)dest = *(uint64_t *)src;
+            src += 8;
+            dest += 8;
+            n -= 8;
+        }
+    } while (n != 0);
+}

-----> include/system/memory.h

+void qemu_ram_copy(void *dest, const void *src, size_t n);
+static inline void qemu_ram_move(void *dest, const void *src, size_t n)
+{
+    qemu_ram_copy(dest, src, n);
+}

>>
>> r~
> 
> And ifdef for arches without unaligned support?
> 

I guess we probably support unaligned access for all architectures or none of
them. It will depend on guest if the unaligned access will be triggered :-)

Thanks,
Gavin



