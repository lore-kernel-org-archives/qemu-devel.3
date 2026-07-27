Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F17B7C53200
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 03:39:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woCAw-0003kc-Dc; Sun, 26 Jul 2026 23:38:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1woCAu-0003k8-Kn
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 23:38:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1woCAs-0007gr-SK
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 23:38:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785123522;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jndRUkDoyH4ei88MUf2FDkYiemr+D9R56UoNodJWPjM=;
 b=P+VRvNMEOu4/2SmrtXAci7QUbOwqJkpeD5SvAxHZe295SFWWHspgj2pvLT6ucyNSTdBBlD
 wpGeqhzR9sCuhC2Dv3KYRtbC5jRrcfB/YR119bebfwc6Lre6BQXcdSM1aFXk+YRHrLCAVo
 RS9vpv1zjPoNprOv3oHeOwTvVykoQho=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-cxhEwmwyMEaEyjflqDeLRQ-1; Sun, 26 Jul 2026 23:38:40 -0400
X-MC-Unique: cxhEwmwyMEaEyjflqDeLRQ-1
X-Mimecast-MFC-AGG-ID: cxhEwmwyMEaEyjflqDeLRQ_1785123520
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2cf6acd760cso27196915ad.3
 for <qemu-devel@nongnu.org>; Sun, 26 Jul 2026 20:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785123519; x=1785728319; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=jndRUkDoyH4ei88MUf2FDkYiemr+D9R56UoNodJWPjM=;
 b=CRVS9gF9U38rL/kYjFPjrelP+XuX/1Fu7lQBHjwEHgAyZAQEc4FcGE5k+/Sbtfnd9+
 p4CTFfyc/BmM0Md+tMOngCTVtGDl/cOKfZMtN8+XH2D40oNGIlkgLIqzMNCKyqQiP4I8
 N6qLb8XhBusHqoeoNrratc1WeSmu4B077Om+TfGHyj41naYIIWfxyr8y62kv/z0++lVe
 xVYqWkSW5iXsTA96QeuJiAz/FWq+4gJQKhvIpiYLh/WRiN1EVhYKR55JeKzj5OX+5+fu
 S7mFzbyw6lY/Lo7FUr+kTytN1II6x3HcjPNYTzGXmVezk6HuoBkysUKGZtNMoo8I8e1M
 YwMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785123519; x=1785728319;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jndRUkDoyH4ei88MUf2FDkYiemr+D9R56UoNodJWPjM=;
 b=C+FAafhadSX/W9+e3VN1w82KnU/X/RI6btCHDYpnfIiqGKDvWOvGCnzuAop9YIePje
 TyifQ4vSe/5D9M2ApMNhn3S0Hzo7snYDjoYGJ6AvqMu/g1qtrF1SwjoRhzlBWliLY79b
 5oLDrypbI2L65VXHDLdLqV+3UASNnu9likszivJKeAWxJWnN9uwNN+SLma1Osf1LQMi6
 jtMygoCV9j+/w+JAFnLCRvCgdXWSY6QrbezFFC1wEUW05rSLwFOcQL5m2pHhRaMhwp0D
 o1CdAoc8nvMya5v9oBcqebWX74BS+tIZv+Z6f1nZfTBHJBieCfZMgCJgPqzZNkNYiFpd
 sdlQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpo6y9P3zifLZARqzT6K3z7k+wK3NR7O9+ucua0Utrm3orWuxZKZnHjFP98jmumtazMZbgUGVWyzSwp@nongnu.org
X-Gm-Message-State: AOJu0YzMwKRdBrfOmR84JQ3ZzddiOB4o0lIoxIEdoNc+qTJA9pQdcKxX
 I+ynCl92cjEdltv/2JFev5/67+vGjYzWnoxSzwq8REABiyOjKmBnrBNSxL6pV/sJ2IuZL5NMbZk
 O4pcGJehxd8tjIda/EVPpWr3khIfD1SJwPq2MP2cZxmYZhXGlMwgiq4WU
X-Gm-Gg: AR+sD126bP/XVHqA1UF3bpsY8SeySuydEfZ4HDs1mOrUCVaiiL0S8eMTueueahJGSlI
 z8CvF6faArrVZgtJrJxppCQtyH+im5uDiRyNlDdDYJF9aPO/6uHpMbkTFIXFMdH+XvT50xcIYvQ
 x1VOC089WP0N7uPc6y90Ppt3wSykEuka+Hi07a3dGOON2xXyBID4gukV+qd6ahMZTCT7NgEQr0+
 JwlhOEMZldCAzg61q9s6LwExOfXmI4ekWINU+S/bn9KtpKXGI2TJQp+SMGQOiVd9Bj4//dWvErn
 Te26vmQKUYJjhnoVC0HvTq98PkhehrohxBUInWTQ7v0nPHDyjuCjbYGOuMTOhZJEIh9/dmG2xGv
 jqOreVN7LPLbrarRqApAeLUz1OqRjyMeXr0cRX7TOT/w=
X-Received: by 2002:a17:90b:4d0c:b0:38e:11ba:992c with SMTP id
 98e67ed59e1d1-38f293cd1dbmr6678631a91.12.1785123519549; 
 Sun, 26 Jul 2026 20:38:39 -0700 (PDT)
X-Received: by 2002:a17:90b:4d0c:b0:38e:11ba:992c with SMTP id
 98e67ed59e1d1-38f293cd1dbmr6678618a91.12.1785123519083; 
 Sun, 26 Jul 2026 20:38:39 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-8-244.mrk21.qld.optusnet.com.au.
 [175.34.8.244]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38f0563c369sm2768251a91.0.2026.07.26.20.38.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Jul 2026 20:38:38 -0700 (PDT)
Message-ID: <c69250a2-e461-4484-ae66-80767744e6fb@redhat.com>
Date: Mon, 27 Jul 2026 13:38:29 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] system/memory: Use qemu_ram_{copy, move}() in ram
 device region accessors
To: "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, alex@shazbot.org, richard.henderson@linaro.org,
 berrange@redhat.com, philmd@mailo.com, david@kernel.org, clg@redhat.com,
 pbonzini@redhat.com, phrdina@redhat.com, jugraham@redhat.com,
 liugang24219@sangfor.com.cn, dinghui@sangfor.com.cn, shan.gavin@gmail.com,
 qemu-s390x <qemu-s390x@nongnu.org>
References: <al-eCtxGjG4HHEbl@x1.local>
 <6210e178-a93f-4411-810a-41edb1fb656e@redhat.com>
 <20260722015422-mutt-send-email-mst@kernel.org> <amDyvgR09OJssENX@x1.local>
 <20260723015708-mutt-send-email-mst@kernel.org>
 <71d88d00-5b41-49d2-b649-8a6ea47abc4d@oss.qualcomm.com>
 <20260723045428-mutt-send-email-mst@kernel.org> <amIbUYN3teCLXTh-@x1.local>
 <b05b40b1-fffd-4be5-9289-b5bc92c16cd2@redhat.com> <amNvIMizFp7Au2c3@x1.local>
 <20260724122956-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20260724122956-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
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

On 7/25/26 2:31 AM, Michael S. Tsirkin wrote:
> On Fri, Jul 24, 2026 at 09:56:48AM -0400, Peter Xu wrote:
>> On Fri, Jul 24, 2026 at 11:42:09AM +1000, Gavin Shan wrote:
>>> On 7/23/26 11:46 PM, Peter Xu wrote:
>>>> On Thu, Jul 23, 2026 at 05:05:08AM -0400, Michael S. Tsirkin wrote:

[...]

>>>> We should have another option that is not arch-dependent but keep the
>>>> unaligned behavior.
>>>>
>>>> For current master, AFAIU we do unaligned access for both ram_device and
>>>> rest. Say, even with ram_device_mem_ops, it has both .unaligned=true for
>>>> both .valid & .impl.  I think it means indeed we have unaligned behavior
>>>> even for ram_device.  It also means what matters in regards to the Realtek
>>>> bug was only about aligned access (with subpage presence).
>>>>
>>>> I think it means we can always keep unaligned to stick with
>>>> memcpy()/memmove(), but only use atomic ops for the aligned cases of
>>>> 1/2/4/8.  With that, I think we can also remove ram_device_mem_ops and fix
>>>> the bounce buffer issue.
>>>>
>>>> I think it means we'll stick with memcpy()/memmove() for all archs for
>>>> unaligned, which is again not safe... but that can be an existing but
>>>> separate problem to solve too.
>>>>
>>>
>>> Lets see if Peter Maydell and Michael are happy with this option. At least,
>>> we will have unified qemu_ram_move() for all architectures with this option.
>>> Note that qemu_ram_copy() won't be needed.
>>>
>>> I'm putting note on what's to be done in (v4) if this option is to be picked
>>> up. Let me know if there are missed points. It's basically combing what's done
>>> by ram_device_mem_ops to upper layer (e.g. in qemu_ram_move()).
>>>
>>>    address_space_write
>>>      address_space_to_flatview
>>>      flatview_write
>>>        flatview_translate
>>>        flatview_write_continue
>>>          flatview_write_continue_step
>>>            memmove                     // (A) to replace it with qemu_ram_move()
>>>
>>> /**
>>>   * qemu_ram_move: move data to ramblock
>>>   *
>>>   * @dst: destination where the data is moved to
>>>   * @src: source where the data is moved from
>>>   * @n: length of data to be moved
>>>   *
>>>   * Move @n bytes from @src to @dst with the assumption that @src and @dst
>>>   * can overlap. The access is atomic if the source and destination buffer
>>>   * aren't overlapped for a well aligned and small-sized access. Otherwise,
>>>   * fall back to the standard memmove().
>>>   */
>>> static void qemu_ram_move(void *dst, const void *src, size_t n)
>>> {
>>>      uintptr_t test, len;
>>>
>>>      if (src == dst || n == 0) {
>>>          return;
>>>      }
>>>
>>>      /* Overlapped buffers */
> 
> 
> overlapping
> 

Corrected in v4.

https://lore.kernel.org/qemu-arm/20260727032649.145381-1-gshan@redhat.com/

>>>      if (src < (dst + n) && dst < (src + n)) {
>>
>> s/&&/||/?
>>
>> It's a bit weird to request memmove() for overlapped, e.g. I don't know if
>> P2P can overlap too when some fuzzer fills in some MMIO address shifted for
>> src/dst.. but I think I get what you want to simplify and it looks fine.
>>
>> Otherwise it looks good.
> 
> Why do we bother special casing overlapping buffers though?
> I do not get it, looks like rest of logic works exactly
> the same for overlapping and non.
> 

Indeed. The explicit check if src/dst are overlapping has been dropped in v4.

>>>          memmove(dst, src, n);
>>>          return;
>>>      }
>>>
>>>      test = (uintptr_t)src | (uintptr_t)dst | n;
>>>      len = test & -test;
>>>
>>>      /* Unaligned or oversized access */
>>>      if (n > 8 || len != n) {
>>>          memmove(dst, src, n);
>>>          return;
>>>      }
>>>
>>>      switch (len) {
>>>      case 1:
>>>          qatomic_set((uint8_t *)dst, qatomic_read((uint8_t *)src));
>>>          break;
>>>      case 2:
>>>          qatomic_set((uint16_t *)dst, qatomic_read((uint16_t *)src));
>>>          break;
>>>      case 4:
>>>          qatomic_set((uint32_t *)dst, qatomic_read((uint32_t *)src));
>>>          break;
>>>      case 8:
>>>          qatomic_set((uint64_t *)dst, qatomic_read((uint64_t *)src));
>>>          break;
>>>      default:
>>>          g_assert_not_reached();
>>>      }
>>> }
>>

[...]

Thanks,
Gavin


