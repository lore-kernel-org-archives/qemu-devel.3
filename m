Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65302C531D0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 03:03:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woY5n-0001LB-9k; Mon, 27 Jul 2026 23:02:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1woY5h-0001Kd-HH
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 23:02:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1woY5f-0003zs-FK
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 23:02:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785207765;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PSPxUej5xZYljWLt4ciZfqgjE0ZCAlOwrXUm9TDZ0Oc=;
 b=SBde3G1dcyF7eBx0LGj2gwesTcR/YxSOWIqjgc7YDPPUX8YFD2JEgPd0mZ8lBV8CFj8Szm
 gKdyE5fu/niolzZmsp3WUbWwylmMdt/EEgQ8nduh2AJ4rB6V/m+XyqLfn76/mTbbzb+U93
 rJ8m9fMqKKr9YdBMvYniRmMy1u7NFDU=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-qiy-CHh9M1a5Dt3KJK_A_g-1; Mon, 27 Jul 2026 23:02:43 -0400
X-MC-Unique: qiy-CHh9M1a5Dt3KJK_A_g-1
X-Mimecast-MFC-AGG-ID: qiy-CHh9M1a5Dt3KJK_A_g_1785207762
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-8485d853b08so8890282b3a.1
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 20:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785207762; x=1785812562; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=PSPxUej5xZYljWLt4ciZfqgjE0ZCAlOwrXUm9TDZ0Oc=;
 b=r30eQwrDzgG8v+LyJ5a8md/2XqGQErDsbZfjmx3bi7LcShsZsQYq9q1UC0XbGCWiMF
 lOXPL9tbASjVsy63UO23HgQ836MJZr+5Q69KQrDUF2Pqd/D+B1KmzwL8IQAIHVrmhiuE
 N8foWEvi3txEMIW0taNkaKkFu20tYWmV+j4dAMvUnHgw0Lnx5XogNnq1ge6C1UgYXiiW
 VOrO9CuiLZKTiVNDC/w2t0wLKjvfClRpDmdrL/f6Ruc5wb0Qu6Kuv5fN0xWpQxcJBtA0
 IKciQ/z9QnD6kV7rdtxliE4X62fvd9CRK3ggpI1wTKKA5XPs+bAq8RC+9McNYVyISgye
 I1yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785207762; x=1785812562;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PSPxUej5xZYljWLt4ciZfqgjE0ZCAlOwrXUm9TDZ0Oc=;
 b=fBzMAXBKweT0iCLMKp0uu3k7Mwoe5b3l++U5y3rJjmjeVHyci+FHyoKWH6vPR6TJOq
 wFax8enl6nM2ldf/XsFZvm/W/5FvSN9edZmlhITadw0izwBXVv7BHAXVHCbG9CaBqwja
 Dbeog1b3vZj93ldh9Ic+yqCi0h9OkXh1f+7/oaor03IY35LPO0KPe+0sbYqQvUKKkQBv
 vsj3947kA6WAP1wJ1Y/cfSpG46itHQQJyzyRacc/tT39+Je8nKwumivuD6wBow31tWd0
 9crA+t1DQzM941YtiLA6nx2Ek1m+Q65fG2dcEe/NMuDhZqIgD82jJute6K5fOaR2NfSP
 ERAQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr1Z83GiCywmMOPhpSZLRMuIanFrhA3CUo58pU/SBgoevFkCqa7cgM+6DVPG594iVW3IsL6gk23984j@nongnu.org
X-Gm-Message-State: AOJu0YyBGAARUvrv2zUl+DveaFgNxcwPQOeTuWZcU5G7P7PdGZ96KdEc
 yZi0DFeYq9IKfXMkMHDke9jS6zFtF7lyPI8uDxvNqIPJCfXYFI53AScicuE77nO3VAZzftythgC
 FJ3C92VADYVXuTcdLr56xVCBEF8XPTLH+o0auTpGXtVX1FhwbP+5ygQco
X-Gm-Gg: AR+sD10pmtXzG3UF9FEBBHIcQn/H7M6nIhakX2j1FFiIIcuO0twvbx8YBx/Kbso45OK
 VJxBQgKwLjlL5LFhWrSuA1OBVffwjdm2KKKCh2HOG0vX2CnjPnakvqs5yp59m5167s6l6JD2dPF
 g3wo1e8r2VDevirLSemjcdOSjAfp9szIGLSR00tViZYr/q12L/JazcfmyM3iWmdoOAzWoNFL1er
 KkDp4HNBRLD7xxtCV291PeeYv71crMxXvQWWxhwdKpxuX102zzr0XB6LrriyRg+DnzX4Qd3+mpn
 Gwvxm3nMSo/w66KSYvO3SroT+4O9dDfaomj1yN/4NCWQAX/Uck5QdVYrXpDcPG9nSTlu1gExHhi
 iy9FvbYL/FIzqzZe3wuybBhVSR11Y+2bCUF3CsGoQECo=
X-Received: by 2002:a05:6a00:a83:b0:84a:2fff:ceed with SMTP id
 d2e1a72fcca58-84e9311ad79mr553751b3a.3.1785207761756; 
 Mon, 27 Jul 2026 20:02:41 -0700 (PDT)
X-Received: by 2002:a05:6a00:a83:b0:84a:2fff:ceed with SMTP id
 d2e1a72fcca58-84e9311ad79mr553708b3a.3.1785207761222; 
 Mon, 27 Jul 2026 20:02:41 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-8-244.mrk21.qld.optusnet.com.au.
 [175.34.8.244]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbbb660daf6sm3872349a12.2.2026.07.27.20.02.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jul 2026 20:02:40 -0700 (PDT)
Message-ID: <b80db46c-525b-4f02-ae96-c602c3f6b557@redhat.com>
Date: Tue, 28 Jul 2026 13:02:31 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] system/memory: Use qemu_ram_move() for directly
 accessible regions
To: Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, mst@redhat.com,
 philmd@oss.qualcomm.com, richard.henderson@linaro.org, alex@shazbot.org,
 berrange@redhat.com, philmd@mailo.com, david@kernel.org, clg@redhat.com,
 pbonzini@redhat.com, phrdina@redhat.com, jugraham@redhat.com,
 liugang24219@sangfor.com.cn, dinghui@sangfor.com.cn, shan.gavin@gmail.com
References: <20260727032649.145381-1-gshan@redhat.com>
 <20260727032649.145381-3-gshan@redhat.com>
 <CAFEAcA9_tDRAd97z4UtNhFPK+fMbq37LJhWTSmD5cueo61hvvg@mail.gmail.com>
 <amdlD1kjhPPMLic3@x1.local>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <amdlD1kjhPPMLic3@x1.local>
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
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 7/28/26 12:02 AM, Peter Xu wrote:
> On Mon, Jul 27, 2026 at 01:51:45PM +0100, Peter Maydell wrote:
>> I think we could usefully expand this comment, because the reasons
>> we need it are not immediately obvious. How about:
>>
>> ===begin===
>> Move @n bytes from @src to @dst; the memory areas may overlap.
>> This provides the same semantics as memmove(), plus an additional
>> stronger guarantee: if @n is 1, 2 or 4 or 8 bytes, and @src
>> and @dst are both naturally aligned for that access size, and
>> the memory areas do not overlap, then both the load and the store
>> will be done as a single atomic access (with the semantics of
>> qatomic_read() and qatomic_set()).
>>
>> This is the underlying function that we use to implement accesses
>> by a guest vCPU or a device DMA operation to a ram block. The
>> atomic guarantee is needed for two major cases:
>>   - when the ram block is backed by a PCI BAR passed through
>>     from a host device (and so it might be hardware registers
>>     that must be accessed exactly once at the right width)
>>   - when an emulated device updates a data structure shared in
>>     guest memory with guest software (e.g. a network device's
>>     set of tx and rx descriptor blocks), if a write to memory
>>     is accidentally performed multiple times then it can break
>>     the guest code.
> 
> Maybe also append it with "the guest code when it busy polls the guest
> memory"; I just found that the polling model isn't something obvious too
> when reading it first.
> 

The extended context has been included for (v5).

>>
>> We don't attempt to perform the exact access when it would
>> be unaligned, because this can't necessarily be done on
>> all host architectures; although this is strictly speaking
>> not doing what would happen on real hardware, we don't think
>> there are going to be situations where that matters in practice.
> 
> Oh yes, mentioning the unaligned part of discussion would also be nice, I
> forgot it when replying.
> 

+1. The context has been included for (v5) either.

Thanks,
Gavin


