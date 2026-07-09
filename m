Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10312C44501
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 09:53:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whlQl-0001rr-I9; Thu, 09 Jul 2026 05:52:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1whlQj-0001rR-Pe
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 05:52:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1whlQh-0000hI-3f
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 05:52:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783590745;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bXeOb7hJ0tqRu876CsTM2j31wI4Uf6Cso0VF1kbUt8A=;
 b=d/dzlJX8t8Oh7Py45MLaJ0qWA7p+p/uzc2TOAnOH9GSiJayQc3k9UWEPK/3j3dy10qLTfX
 FeV5PjHhX8DehJHwktDNjBfW1xVgwnue3P4rWn/Do+B7N9fozGbhB5AJWJnmlgXywkREK5
 OLSaPALNgE76NDd22Zec7OubIoikc+I=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-KzMUh9TOMCOWww-m_Q75Dw-1; Thu, 09 Jul 2026 05:52:24 -0400
X-MC-Unique: KzMUh9TOMCOWww-m_Q75Dw-1
X-Mimecast-MFC-AGG-ID: KzMUh9TOMCOWww-m_Q75Dw_1783590743
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2caa9a3cf7aso8794735ad.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 02:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783590743; x=1784195543; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=bXeOb7hJ0tqRu876CsTM2j31wI4Uf6Cso0VF1kbUt8A=;
 b=I0zbbDaPnraJdLUA/tMOMjGKQZE0P+6UmvqFhp/xvaiQ6KbMz4vqAr6bikFCWe4Rjk
 RK0UQxVsIjcc6GE1AE38Zl27/xkGfgK0+n88ChfUl1W6P0TycLdocHahVAexPLsh7xhZ
 TX2O5KJWiiaw9+I5kkLxJum0vflRpfytt1unNQtLgGo5dph/462iD1PdCKCCVW7SvtF/
 XhMXbh5mJ4+avaavtbFZ2U/nTy6Tm4CIUMZPYzzaCt/wbDp9c67JT+qWGFH/9jmw12H4
 SEdFwEe7MkiD+4iT/Mvp++/Ly1Q84U5NdI5CjPJ1mGbLsbY11D7F84jXAjDeIp0I9SQi
 yaYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783590743; x=1784195543;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bXeOb7hJ0tqRu876CsTM2j31wI4Uf6Cso0VF1kbUt8A=;
 b=WAWUDdlqYYFP9LiRbXldeIA5uqkHHZmfED8+1NrQPEevQ4QWt5Yq8gVnC2IR2XNcOV
 tY4Ua1H2+9keLgaQDZqyzp3Er3++8kPeVRL2HmVJBhmUgZrpkMRvZzyJTVmB5f4FXOyp
 Jom1Xwi7VfHgY43IStdHv3LhaKpzuwhLFmjQvksO421n1h8ukFdvW92vO0049Gh6KzXa
 /sarbZaBxVLT6T78vW873FGNOazkFZcCrr3hy87c+tbkygq9xF/j0R7RjaT72EqlQjO4
 LN1Tl6Lux9QcZthY7Zp/lXa3/MvkIcuzFSWUEOXUGp9sJeL6+4kbL2T/K4NpgcQdFrFE
 jUOA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoJpgiF8dtbss2njZk2S3cCW3XbgAyHYbyyCp4Xrz5Lo7XxmcWWdnEZBU1tgL4IyJWlgy1g8dj03xF2@nongnu.org
X-Gm-Message-State: AOJu0YxAVzLpuG6PdKW10Ewc44CUg8pqtEwDNLJvPMEH/vjinlDgCBhE
 jT8VM7cQg0W1MxaSWAPjW8vi8q4hcKEZvSJD117MtlF/m5IYdy0w0AhHGwkDsknK6YG6qf0gvZT
 UMhMgn69zTtBtZMiT6lgPj7NKgD4S99wyyuddFGSprATNT/oxyAenvqQI
X-Gm-Gg: AfdE7clxpbVydeTYbfTBS5ZD7YaRZmHTvgPerFWhx99c/8wL2ahDwM279XsxA7USWVI
 3l+qX40GHZRzVhI9NR5uWMGos087R+BuW7qYjuVY9+UhchcMQXLT4VaktW5RTwK2kh0QgM1pAYJ
 897C22ua7T+i4bzRRl3URx0oWx3NsIUbMAUmFEwHOP1L0eW+rX42+tsekGT2LQ2Wa4g4V2qXrSw
 7yidTRtyD2TLoDTw9ohmhgK65QMEZNYs5eWRxmpW5qKttL0v7aQ8wy5QjstjLWRP9KXmUwFc3tu
 9ENIUSW5pbcjdaekatiWnN/By2y2lwvQJuky1474fD0b7BL41zkhaLsK/vbpCvtKRj6RzLkwYXk
 TCHWUp7pqzWpTkjwDhOZECyqm74s56DbZkID80rMl5ybx4WXmQSVdpQ==
X-Received: by 2002:a17:902:d2c1:b0:2c9:b2c1:1401 with SMTP id
 d9443c01a7336-2cdd8a16112mr24344935ad.5.1783590743152; 
 Thu, 09 Jul 2026 02:52:23 -0700 (PDT)
X-Received: by 2002:a17:902:d2c1:b0:2c9:b2c1:1401 with SMTP id
 d9443c01a7336-2cdd8a16112mr24344685ad.5.1783590742660; 
 Thu, 09 Jul 2026 02:52:22 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-8-244.mrk21.qld.optusnet.com.au.
 [175.34.8.244]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9bdb9a3sm41304395ad.13.2026.07.09.02.52.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jul 2026 02:52:21 -0700 (PDT)
Message-ID: <73f79841-8cc7-4ca6-8f6b-fb97b53a6fe8@redhat.com>
Date: Thu, 9 Jul 2026 19:52:12 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] system/memory: Use qemu_ram_{copy, move}() in ram
 device region accessors
From: Gavin Shan <gshan@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, peterx@redhat.com,
 alex@shazbot.org, richard.henderson@linaro.org, berrange@redhat.com,
 philmd@oss.qualcomm.com, philmd@mailo.com, david@kernel.org, clg@redhat.com,
 pbonzini@redhat.com, phrdina@redhat.com, jugraham@redhat.com,
 liugang24219@sangfor.com.cn, dinghui@sangfor.com.cn, shan.gavin@gmail.com
References: <20260616052552.389021-1-gshan@redhat.com>
 <20260616052552.389021-2-gshan@redhat.com>
 <CAFEAcA-mf14=jpRFHarAbN6AbQwvW=Yu6WB1JiNMsECEdaxD3A@mail.gmail.com>
 <20260625070551-mutt-send-email-mst@kernel.org>
 <CAFEAcA8YJZq9TqrUd0zTnewAdVDm5y6UV7BJQZ0C60TZ=RT98Q@mail.gmail.com>
 <20260625091334-mutt-send-email-mst@kernel.org>
 <CAFEAcA8xK+t3-prEphtkq-o9UY2mgS6cowhs880GOaxL9dKSGw@mail.gmail.com>
 <20260625101817-mutt-send-email-mst@kernel.org>
 <CAFEAcA8-Un+Q1yBDqLWCLPRwtgTA_VhJqGobgZChrFhAeVfG8A@mail.gmail.com>
 <20260625123119-mutt-send-email-mst@kernel.org>
 <CAFEAcA8UjtXgmPC27fOKMwbaWs2piwGYudtwCNWQHuu3E_7A-A@mail.gmail.com>
 <5faf04b9-d596-4a1d-9fe3-5e9ad5f0a99a@redhat.com>
Content-Language: en-US
In-Reply-To: <5faf04b9-d596-4a1d-9fe3-5e9ad5f0a99a@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi Michael and Peter,

On 6/26/26 10:07 AM, Gavin Shan wrote:
> On 6/26/26 4:40 AM, Peter Maydell wrote:
>> On Thu, 25 Jun 2026 at 17:47, Michael S. Tsirkin <mst@redhat.com> wrote:
>>>
>>> On Thu, Jun 25, 2026 at 04:23:47PM +0100, Peter Maydell wrote:
>>>> On Thu, 25 Jun 2026 at 15:52, Michael S. Tsirkin <mst@redhat.com> wrote:
>>>>> I think there is exactly 1 kinda reasonable case. A 2 byte read/write at
>>>>> offset 0x1 within a dword. This maps nicely to even classical PCI byte
>>>>> enable mechanism and so yes it works if your CPU can initiate these
>>>>> things, and it's atomic.
>>>>>
>>>>> I tried reading LEDCTL on e1000e:
>>>>>
>>>>>         byte  @ 0xe00: 0x64
>>>>>         byte  @ 0xe01: 0x2a
>>>>>         byte  @ 0xe02: 0x00
>>>>>         byte  @ 0xe03: 0x00
>>>>>         word  @ 0xe00: 0x2a64
>>>>>         word  @ 0xe01: 0x002a
>>>>>
>>>>> Works fine.
>>>>
>>>> The e1000e datasheet actually documents what it does in this
>>>> case (slightly surprising, since hardware engineers love to
>>>> leave this kind of corner case undocumented):
>>>>
>>>> # For registers that should be accessed as 32-bit double words,
>>>> # partial writes (less than a 32-bit double word) does not take
>>>> # effect (such as, the write is ignored).
>>>> # Partial reads
>>>> # return all 32 bits of data regardless of the byte enables.
>>>> #
>>>> # Note: Partial reads to clear-by-read registers (such as, ICR)
>>>> # can have unexpected results since all 32 bits are actually read
>>>> # regardless of the byte enables. Partial reads should not be done.
>>>>
>>>> So for this specific device that access is out-of-spec.
>>>
>>> You mean that access to clear by read should not be done, right?
>>
>> The datasheet is ambiguous about whether "Partial reads should
>> not be done" is meant to apply generally or only to clear-by-read
>> registers.
>>
> 
> I think the document intends to say: the partial reads shouldn't be issued to
> the clear-by-read registers. Those partial reads on no-read-side-affect registers
> would be fine.
> 
>>>> I guess what I'm wondering is: can we just have code
>>>> that does an aligned exact-width access in the 1/2/4/8
>>>> byte aligned case, and the host's best approximation to
>>>> an unaligned exact-width access for the 2/4/8 byte
>>>> unaligned case?
>>>
>>> That's my idea, too.
>>>
> 
> I assume this the conclusion of our discussions? If so, we just need to have
> unified function where __builtin_{memcpy, memmove}() are used for 1/2/4/8 bytes
> access no matter if the address is aligned, and fall back to {memcpy, memmove}()
> for other cases?
> 

Could you help to confirm if the conclusion is to have unified qemu_ram_{copy, move}()
for all architectures? In qemu_ram_{copy, move}(), the fixed sized accesses like
1/2/4/8 bytes are handled by __builtin_{memcpy, memmove}() and fall back to
memcpy/memmove() for other sized accesses. It's basically what was proposed by
Michael :-)

Something like below.

-----> include/system/memory.h

+/**
+ * qemu_ram_copy: copy data to ramblock
+ *
+ * @dst: destination where the data is copied to
+ * @src: source where the data is copied from
+ * @n: length of data to be copied
+ *
+ *
+ * Copy @n bytes from @src to @dst with the assumption that @src and @dst
+ * do not overlap. The fixed sized accesses like 1/2/4/8 bytes are handled
+ * by __builtin_memcpy() to avoid the optimizations applied to memcpy(),
+ * which can be unsafe to DMA/VCPU IO. Fall back to memcpy() for other
+ * sized accesses and the safety is ensured by users.
+ */
+void qemu_ram_copy(void *dest, const void *src, size_t n);
+
+/**
+ * qemu_ram_move: move data to ramblock
+ *
+ * @dst: destination where the data is moved to
+ * @src: source where the data is moved from
+ * @n: length of data to be moved
+ *
+ * Move @n bytes from @src to @dst with the assumption that @src and @dst
+ * can overlap. The fixed sized accesses like 1/2/4/8 bytes are handled
+ * by __builtin_memmove() to avoid the optimizations applied to memmove(),
+ * which can be unsafe to DMA/VCPU IO. Fall back to memmove() for other
+ * sized accesses and the safety is ensured by users.
+ */
+void qemu_ram_move(void *dest, const void *src, size_t n);
+

-----> system/physmem.c

+void qemu_ram_copy(void *dst, const void *src, size_t n)
+{
+    switch (n) {
+    case 1:
+        __builtin_memcpy(dst, src, 1);
+        break;
+    case 2:
+        __builtin_memcpy(dst, src, 2);
+        break;
+    case 4:
+        __builtin_memcpy(dst, src, 4);
+        break;
+    case 8:
+        __builtin_memcpy(dst, src, 8);
+        break;
+    default:
+        memcpy(dst, src, n);
+    }
+}
+
+void qemu_ram_move(void *dst, const void *src, size_t n)
+{
+    switch (n) {
+    case 1:
+        __builtin_memmove(dst, src, 1);
+        break;
+    case 2:
+        __builtin_memmove(dst, src, 2);
+        break;
+    case 4:
+        __builtin_memmove(dst, src, 4);
+        break;
+    case 8:
+        __builtin_memmove(dst, src, 8);
+        break;
+    default:
+        memmove(dst, src, n);
+    }
+}
+


>>>> (so on sparc you get multiple smaller
>>>> accesses, and on most archs including x86 and arm you
>>>> get an unaligned load).
>>>
>>> I thought unaligned load from uncacheable on arm is
>>> also a fault?
>>
>> For Arm the distinction is not cacheable/uncacheable
>> but Normal vs Device. (Device is essentially for things
>> which are not RAM; Normal is for RAM and RAM-like things,
>> and includes all of Normal Non-cacheable, Normal WT-Cacheable
>> and Normal WB-Cacheable.) Things mapped as Normal memory
>> don't generate unaligned faults (unless the guest turned them
>> on deliberately). For Device memory, it is IMPLEMENTATION
>> DEFINED whether you get an alignment fault or not if you
>> map something as Device that could have handled unaligned
>> accesses if you had mapped it as Normal.
>>
>>>> That would mean the guest could
>>>> potentially provoke a fault on the load/store on an
>>>> access to a passthrough device, but if you give the
>>>> guest passthrough access it can very likely provoke
>>>> a fault anyway, depending on exactly what the device is.
>>>>
>>>> I think the most likely reason for an unaligned access
>>>> in this codepath is "it's actually RAM, either really
>>>> host RAM or else something memory-like in a BAR", and
>>>> either way if the guest does a 4-byte unaligned access
>>>> then doing a 4-byte unaligned access seems better than
>>>> second-guessing it, even on non-x86.
>>
>>> Right though remember: whether it's RAM doesn't matter. What matters is
>>> how we map it.  qemu might fault because it maps NC but guest maps
>>> cacheable and it's ok.
>>
>> If QEMU and the guest disagree about the memory attributes
>> on Arm then we have already lost, because the architecture
>> says that memory attribute mismatches result in a variety of
>> undesirable effects including things like loss of cache coherency
>> (i.e. read and writes via QEMU's NC mapping disagree with ones
>> via the guest's cacheable mapping because the latter are hitting
>> in the cache and the former are bypassing it).
>>
>>> But, all this in theory. At a high level, I personally think going with
>>> what you propose as a 1st approximation is entirely reasonable, except
>>> for one thing: we really should not crash qemu, since access can be from
>>> guest userspace.
>>
>> You can't prevent faults entirely, though -- if the device
>> being mapped has e.g. behaviour that says "unaligned accesses
>> will fault" and then the x86 guest does an unaligned access,
>> then the device will trigger a fault, and the fault is what
>> you want because it's what the guest would see on real h/w.
>> Unfortunately we don't have a convenient way to feed the
>> fault back to the guest. At some level if you pass through
>> host hardware you're relying on the guest to not do totally
>> stupid things.
>>
>> thanks
>> -- PMM
>>

Thanks,
Gavin


