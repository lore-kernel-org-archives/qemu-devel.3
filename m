Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DEFACD98F2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 07:01:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZkGt-0000Bi-6m; Wed, 17 Jun 2026 03:01:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1wZkGl-0000As-Bx
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 03:01:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1wZkGj-0003pY-3J
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 03:01:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781679659;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z3BICBUClixQXMJTgMkF5LaWaXjK8I3G91qlMnzL/7c=;
 b=eJxEpLMXXjyImSJnH0nn7e56IkwYoB600EUMny35Q/b8g/hzcc1FPK2DkEnojFBvKoQ9Yf
 oAe4EkB2bDNyeDkRVMDrSpb8KDuXqiyDm1sMnbrX6WXcbM+Bbzk7vmrWnZhnUKSaDRyQ4u
 TXkuBrOFcAHIkF/rXYA8rUhOuzN/kcU=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-IxvJzEh2N9iux3JUj79uJw-1; Wed, 17 Jun 2026 03:00:58 -0400
X-MC-Unique: IxvJzEh2N9iux3JUj79uJw-1
X-Mimecast-MFC-AGG-ID: IxvJzEh2N9iux3JUj79uJw_1781679657
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2c6afd85980so9175785ad.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 00:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781679657; x=1782284457; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Z3BICBUClixQXMJTgMkF5LaWaXjK8I3G91qlMnzL/7c=;
 b=Hs6UibtbNaxOj7qOoeVuruk5r/e9idU/0ivyKGxH/MF29v7Po3UsK/hpDFiVMW9osr
 07liJ0j/RnxmMAJHkxbvCN9OVYGQBM6smFaKX1h8Nduw/nHMGZtWHsYrhZXMfPUPmi6h
 6TTA9lZ1Khq2MTwnFhHTZUa3Wc6EkAupl14dCAChSdo91X9BTg6NMabyaBCQ06T14r1t
 hnVeCmmcU/1ddoJkdMpdmJJBhzJ9MsBmsKirmnYWBd6RMLbtJPdr1MWDBa7cYgXnQBAf
 L2CiUX9GPwf6dkh5RdzrZuQlkZrCqTHoH0w9gIYLJT40+MTEkQ5OFgfoq/i7L/KWXYTa
 TUhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781679657; x=1782284457;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Z3BICBUClixQXMJTgMkF5LaWaXjK8I3G91qlMnzL/7c=;
 b=DAyBqbT9knbkIVJetH9s/z7tRFdEcWAZnlH0LCQIWNg+aLhWXG7JYDU3Lwzsj1OUnj
 3PJXDnseYUH3bCOBukHpgQ2E1xzEAZTeUQuqbPU0+IDb4Yhm+LH/4KJVQ0RGubPkAmfG
 EULSLYx4Ll6ZKWiMdE0UHt3A+OT+XB44SAHoY2hxb5LPjqPnYcuiCx7sTpeFeuJ8CijU
 JFdCcL8tiVEID82adTS7VOy+EkQXuBYS3MhjRyp/BqejK1XamNUUscdzP8NC9c2SGk13
 Q1CDyk5Q7UfsoNf+4wtxjG5Jp2Ohi9TWGW7rZKzx/uwMKD7Ux8m8AsD6dwS/n+6UB8/M
 t4ow==
X-Forwarded-Encrypted: i=1;
 AFNElJ82/yZHSadycY/dUBowpRc8flDnz1uFU83WP1ry6aqA/tBXZkc8USQIzpTd/x38ZyWnSnl1qe/fOasT@nongnu.org
X-Gm-Message-State: AOJu0YzD6ZnFHeCBgsaakoYzhAxyiNu+4XFDVbZ8eZJnDismb3l1/vyS
 f1p/W2iYn+BtNOIfFJeQxxD2jI57sBNWg66xUcM5WpHTRV2n0blQZHqb80dkXSNVypByLibFf4Y
 wAfyY3fgqHsrFguc7Ap93z8SAZW+r1Cer5sm7xZLa/FX5F26VKrQ0+DZC
X-Gm-Gg: AfdE7cmJQ1WPR4CSD+HpHNfZj20q6p7Zl6DUfSNk2u1JRT5Ra3hgxdpdiYm1v6bsGeb
 4hCY/m6r53gUF0PLkal7yissK/wOJkslAFAOlaR/7DgHDL+bYYn57zkqwbvZR4qoYjDeCRReuKv
 ww7OguTlnd5Jc9D5rSA3/jIJXzP9DiSt9Ved5VDMSywedSvfS9gUojBldkheSk8uGv9E3+H8bgw
 2WPHMC3szpHr03q+2wkg4tfpNpnbGNRESF2S4ZVc2Eujp0KvBXJvXsWsx/erO22Iw9w7NNW1R6r
 3zK1yGPun7K4ImYvS9Tqsu6FUGpk8L9S9yKOUuu8YeP/iXn0iow88OSFLyaHXHBkh3ilfRgWRHb
 Jxs33nYNldP11yWg1tgcAj4d4u2xyHZKRAUVEJAPEk6rnyWVKdEWv2Q==
X-Received: by 2002:a17:902:cf0e:b0:2c2:cf20:213 with SMTP id
 d9443c01a7336-2c6bc248243mr23314615ad.29.1781679657006; 
 Wed, 17 Jun 2026 00:00:57 -0700 (PDT)
X-Received: by 2002:a17:902:cf0e:b0:2c2:cf20:213 with SMTP id
 d9443c01a7336-2c6bc248243mr23314115ad.29.1781679656475; 
 Wed, 17 Jun 2026 00:00:56 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-8-244.mrk21.qld.optusnet.com.au.
 [175.34.8.244]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c42f2e5590sm171623735ad.14.2026.06.17.00.00.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jun 2026 00:00:54 -0700 (PDT)
Message-ID: <ee0280dc-0c21-44df-a1cb-94c580140491@redhat.com>
Date: Wed, 17 Jun 2026 17:00:45 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] system/memory: Make ram device region directly
 accessible
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, peterx@redhat.com,
 alex@shazbot.org, richard.henderson@linaro.org, peter.maydell@linaro.org,
 berrange@redhat.com, philmd@oss.qualcomm.com, philmd@mailo.com,
 david@kernel.org, clg@redhat.com, pbonzini@redhat.com, phrdina@redhat.com,
 jugraham@redhat.com, liugang24219@sangfor.com.cn, dinghui@sangfor.com.cn,
 shan.gavin@gmail.com
References: <20260616052552.389021-1-gshan@redhat.com>
 <ae17b5a6-eed8-4d4c-a798-cb92ffa6c915@redhat.com>
 <20260616014419-mutt-send-email-mst@kernel.org>
 <2015405e-7839-4ab9-b5a0-712b644da3c8@redhat.com>
 <20260617013709-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20260617013709-mutt-send-email-mst@kernel.org>
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

Hi Michael,

On 6/17/26 3:52 PM, Michael S. Tsirkin wrote:
> On Wed, Jun 17, 2026 at 12:35:00PM +1000, Gavin Shan wrote:
>> On 6/16/26 3:44 PM, Michael S. Tsirkin wrote:
>>> On Tue, Jun 16, 2026 at 03:40:34PM +1000, Gavin Shan wrote:
>>>> On 6/16/26 3:25 PM, Gavin Shan wrote:
>>>>> All ram device regions was turned to be indirectly accessible by commit
>>>>> 4a2e242bbb ("memory: Don't use memcpy for ram_device regions"). This leads
>>>>> to a hanged guest where a NVidia GH100 GPU is passed from host. The memory
>>>>> in its PCI BAR#4 can be allocated as DMA target buffer. qemu has to take
>>>>> DMA bounce buffer in address_space_map() to cover the DMA request. However,
>>>>> the bounce buffer size is 4096 bytes and we're overrunning it easily when
>>>>> the guest has significant disk activities on compiling 'cuda-samples'.
>>>>> The full log and problem description can be found from PATCH[1/2]'s commit
>>>>> log.
>>>>>
>>>>> Try to fix the issue handled in commit 4a2e242bbb by replacing memcopy()/
>>>>> memmove() with newly added helpers qemu_ram_{copy, move}() that works on
>>>>> top of __builtin_{memcpy, memmove} or unaligned access friendly memory
>>>>> movement in the accessors to the ram device regions. With this, we can
>>>>> basically revert that commit to make ram device region directly accessible
>>>>> again and bypass the bounce buffer in address_space_map() where the guest
>>>>> hang is caused.
>>>>>
>>>>> PATCH[1] uses qemu_ram_{copy, move}() in ram device region accessors
>>>>> PATCH[2] makes ram device region directly accessible again
>>>>>
>>>> Michael asked to include below context in the cover letter in v3, but I
>>>> didn't noticed that before I sent v3 series, appended with them.
>>>>
>>
>> Looking at the list of issues (questions) raised by Michael, I don't understand
>> every one
> 
> Gavin, I doubt one should make memory.c changes without understanding the issues
> it is trying to address.
> 
> What is unclear? Ask away.
> 

Yeah, absolutely. I need some time to understand all questions or suggestions
by digging the code a bit, before I'm able to come back to you, but not very
soon though :-)

> 
>> before I'm able to put more time to dig, but I feel this series has
>> too ambitious goal to cover accesses to all the directly accessible regions
>> with the newly introduced qemu_ram_{copy, move}. It causes too many behavior
>> changes and concerns, making this series impossible to land.
>>
>> I would suggest to break down the goal and step back to apply the newly introduced
>> qemu_ram_{copy, move} to the ram device regions only? It's actually something
>> proposed by Peter Xu in the earlier replies. Taking address_space_write() as an
>> example, the indirectly accessible regions are covered by memory_region_dispatch_write()
>> in (1), the ram device region is covered by qemu_ram_move() in (2), and all other
>> directly accessible regions are covered by memmove() in (3).
>>
>>    address_space_write
>>      flatview_write
>>        flatview_write_continue
>>          flatview_write_continue_step
>>            memory_access_size             // (1) indirectly accessible region
>>            memory_region_dispatch_write
>>              access_with_adjusted_size
>>                memory_region_write_accessor
>>                  mr->ops->write
>>            qemu_ram_move                  // (2) ram device region
>>            memmove                        // (3) all other directly accessible regions
>>
>> With the limitation, only the ram device regions in (2) are affected. We're
>> basically moving the accesses to the ram device region from (1) to (2). No
>> changes introduced to other types of regions. The goal is to make the ram device
>> region accessible so that the bounce buffer can be bypassed in DMA path.
> 
> Esthetics aside - ram device regions have all the same issues.
> 
> Maybe you can limit the scope of the changes,
> but I doubt you can get out understanding)
> 

Yes. Limited to the scope of VFIO and PCI BARs, it depends on how the PCI BARs
are mapped, pgprot_noncached or pgprot_writecombine. The listed problems and
concerns are existing on the ram device region exposed with pgprot_noncached.
However, everything should be just fine if the region is exposed with pgprot_writecombine.
Am I understanding this correctly?

[...]

Thanks,
Gavin


