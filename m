Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9EB4CD4F24
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 07:03:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wN3cN-0004ka-Op; Wed, 13 May 2026 03:02:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wN3cM-0004jv-7n
 for qemu-devel@nongnu.org; Wed, 13 May 2026 03:02:54 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wN3cI-0006jE-E6
 for qemu-devel@nongnu.org; Wed, 13 May 2026 03:02:53 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4891e86fabeso73012305e9.1
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 00:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778655767; x=1779260567; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JLyfJpt5fZy8KahVxLLJdTl0yAHmiF2uwVY0SdChaDU=;
 b=xTuHPZJwKiA4EhJOJAE/tk+VWNP3Z13YVCthCc+AKA+U25U5aDlmt/DhdOwFcV3rDq
 iCEvcFUOSGFajWdeUDrtOSj1opQk9jS5OPf2wUfNocU1iuAMjA6wJPtCz51ScKBxofGL
 iXRZxZCgsZdoDlZs7oRpa/VB6dFsVYnaCTLHkynh+8KiIQLjh/b3g917CJNWjaMZSFKq
 BxPrFgMCOgT9ABsPRHdvv64PK4/68pAl7EAOgsa05aYvzQjkjtnrNBNiYs5IVeInN4ZZ
 HDmPdzI2CKjkLYQBEJnTIrH9dew0mguSMWoXNuRh5j7nvGA41eUjOXZz/4dsWz2rBSOe
 nncA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778655767; x=1779260567;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JLyfJpt5fZy8KahVxLLJdTl0yAHmiF2uwVY0SdChaDU=;
 b=d3V482PlgM8SGBcG2o3hMX+/dO6WuDx9Re8b9Vg0v+Qejea6EYUpDT90XiGDDl8Kcr
 4jQQe2BRp2Ou8SjigsYHmZK1b1Fx0GHejlxrPErk3vTT/gV9Y9DhG4/zQXRgsYImX+cl
 0BrWmNTVE/fFmNi2mp8xc348L5qK5Id6m3zYzSVfAKfgC21L7yY7naGiUoFKHfFbhAxT
 O7m/RY+yeTgc+JvNFHkvlYSRDP5Ybci5WpKEzapCGfw4IVgtN5E4UF6uemrN7+t/M3Ed
 0zVFqDsNAY1Erq184LxHU6y6E6w4kQackc09hk4InesRn5eawM02lMSULF7Y8pEO+v1O
 Oiww==
X-Forwarded-Encrypted: i=1;
 AFNElJ/jmZIYlFWS4RnbzKqVP8suMSFaknnOVy4PCLhtY7p0yMdcg+0+4zbUR6fF40ulSGGpuqVKvZH08yUi@nongnu.org
X-Gm-Message-State: AOJu0YxtwTi4AMa9LOxgD42GqoxZ5jwcr6D7tbrWBR81Vt6SJIux9Sr6
 8dvJIe2NQLHKWt1xOQV6t2si/lPCIwCa3fEkuCY3TqaiRRgFSsYkvO3p3rXIxCDer9k=
X-Gm-Gg: Acq92OHf9VQd0CuvIs28e4OC++OrR/MOSxud7SmfuwX5HifcZ53MGI8Ct/QvAFOB1PO
 eW7aCCSDZhB9nJ7EcX9NF6dV2SKMunnT0mSExLvuXsLcX7y+BZUfmtufHBEx/M1Sz80E7v65dm8
 ED9zXidiiaDPr/LMjKwFExhgggt9xn0eK92uCo65iAMELUw7Zk7W2Q5+Qs8YtVt+RDrrQtlcxix
 TY8k6RMiIEdwjMpNlWul10gHiee3dqMXbNi5DzR9ZRPcm9G565td70teUZ75qwTJGrLa4/i9WhU
 pfMQkhEJ/CZUlZgwfiFFMSu/kSy7s2HxS2G9c5XClG8MdklRh3gnHRAjVEvSTRlBHTdIi+ycwGL
 n75xUBeT7dprJOsrKEsg2ALIiOBhm1CVfvSakaHgJIGPEU9ZMJMbkozcHQJMpzMjviNvy1HVE3k
 OQR9CJ22s1VibtatgIwFAReF/oYIrBlqamxjwfzTwQq0uKxbLJSVBRiUtXKpWRozuy9g==
X-Received: by 2002:a05:600c:3588:b0:489:e696:836f with SMTP id
 5b1f17b1804b1-48fce9aab17mr20139215e9.10.1778655766684; 
 Wed, 13 May 2026 00:02:46 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fc8d27667sm43973215e9.7.2026.05.13.00.02.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 May 2026 00:02:46 -0700 (PDT)
Message-ID: <de911fb1-17c1-4013-a332-18da8f11906f@linaro.org>
Date: Wed, 13 May 2026 09:02:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] virtio-net: validate RSS indirections_len in post_load
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>, Junjie Cao <junjie.cao@intel.com>,
 qemu-devel@nongnu.org
Cc: jasowang@redhat.com, mst@redhat.com, yuri.benditovich@daynix.com,
 berrange@redhat.com, peter.maydell@linaro.org, qemu-stable@nongnu.org
References: <20260324060100.1997-1-junjie.cao@intel.com>
 <f4e8921d-d1fb-4ff6-95d2-de6b44a5941e@tls.msk.ru>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <f4e8921d-d1fb-4ff6-95d2-de6b44a5941e@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 13/5/26 08:42, Michael Tokarev wrote:
> On 24.03.2026 09:01, Junjie Cao wrote:
>> virtio_net_handle_rss() enforces that indirections_len is a non-zero
>> power of two no larger than VIRTIO_NET_RSS_MAX_TABLE_LEN, but
>> virtio_net_rss_post_load() applies none of these checks to values
>> restored from the migration stream.
>>
>> A corrupted save file or crafted migration stream can set
>> indirections_len to 0.  Even if it also clears redirect,
>> virtio_load() calls set_features_nocheck() after the device vmstate
>> (including the RSS subsection and its post_load) has already been
>> loaded, re-deriving redirect from the negotiated guest features.
>> When VIRTIO_NET_F_RSS was negotiated, redirect is set back to true
>> regardless of the migration stream value.  The receive path then
>> computes
>>
>>      hash & (indirections_len - 1)   /* wraps to 0xFFFFFFFF via int 
>> promotion */
>>
>> and uses the result to index into indirections_table, which was not
>> allocated by the VMState loader when the element count is zero (see
>> vmstate_handle_alloc()), resulting in a NULL pointer dereference that
>> crashes QEMU:
>>
>>    #0  virtio_net_process_rss    ../hw/net/virtio-net.c:1901
>>    #1  virtio_net_receive_rcu    ../hw/net/virtio-net.c:1921
>>    #2  virtio_net_do_receive     ../hw/net/virtio-net.c:2061
>>    #3  nc_sendv_compat           ../net/net.c:823
>>    #4  qemu_deliver_packet_iov   ../net/net.c:870
>>
>> The RSS subsection is only loaded when rss_data.enabled is true (via
>> virtio_net_rss_needed()), and the command path always produces
>> indirections_len in {1, 2, 4, …, 128}, so an unconditional check
>> cannot reject a legitimate migration stream.
>>
>> Factor the validation into virtio_net_rss_indirections_len_valid()
>> and call it from both virtio_net_handle_rss() and
>> virtio_net_rss_post_load().
>>
>> Fixes: e41b711485e5 ("virtio-net: add migration support for RSS and 
>> hash report")
>> Cc: qemu-stable@nongnu.org
>> Signed-off-by: Junjie Cao <junjie.cao@intel.com>
> 
> Hi!
> 
> Has this patch been forgotten, or is it not needed anymore?

Jason went AWOL regarding net/ and hw/net/ related patches
(while net/ is 'Maintained', hw/net/ only supports 'Odd Fixes').

BTW eBPF is also listed as 'Maintained' by Jason.

I'm trying to help with hw/net/ when it isn't too specific.
This particular one is VirtIO so I'll let Michael have a look,
as per MAINTAINERS:

  virtio
  M: Michael S. Tsirkin <mst@redhat.com>
  S: Supported
  F: hw/*/virtio*

> I'm preparing next set of the stable qemu releases, if it's needed,
> it would be nice if it lands in the master branch in the next 10
> days.
> 
> Thanks,
> 
> /mjt
> 


