Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D434C4451C
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2026 05:31:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkxdR-0007F6-1e; Sat, 18 Jul 2026 01:30:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wkxdJ-0007Ej-QV
 for qemu-devel@nongnu.org; Sat, 18 Jul 2026 01:30:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wkxdH-0004Ip-GG
 for qemu-devel@nongnu.org; Sat, 18 Jul 2026 01:30:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784352637;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=we5HquAj09G4Y/1jpx5ufkjtNsZqBpAd8omupF1j9So=;
 b=eWw9iQBCTXysRygz7ktYYq0kJu8pywBmhUj6RA5syr/ma7ira5EdQ3caIwLomwQPSa17kO
 wY/OG0n/DFxFf/VIyVazODLbrAxBNPZ2w5Q2SVzB7Wk4V1/8HOJE5ufrfKoTKXqrroEjcb
 c+0qHVmZ0NmN8DrFe4dvyK4Q3hKl6OU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333-adp8eqrnOMu06sR5Em7r5A-1; Sat, 18 Jul 2026 01:30:35 -0400
X-MC-Unique: adp8eqrnOMu06sR5Em7r5A-1
X-Mimecast-MFC-AGG-ID: adp8eqrnOMu06sR5Em7r5A_1784352635
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-46fb9079a04so4155042f8f.3
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 22:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784352635; x=1784957435; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=we5HquAj09G4Y/1jpx5ufkjtNsZqBpAd8omupF1j9So=;
 b=fB8FrWpZ9sRFMW1ydLOMlict4W0bB96iEJyd/csrjkH2VrZYXsEyidbJQHPmvZpx6U
 29uJAHcbYt4TfFps1rLSgzIfeEzQTHH3h6bchrmVd+HQXA3V75gGIiPmgBELs9rCfKR+
 QgJaPr7PdkvZE5WMKtUD1DHSJ61mNiZ6l7bv88sdj8k/HSsBaDbKcmIXL0CukIakhSyU
 Xfirf6LCgrB8PcDvLpLvoVcYP6cSdtxzD0GDK6p3C0fNOVwbh6X5Pi6HoJL1tdQuGIgQ
 dR5u6vm0ebzJ40hxsHnqRqq6/bVKbxtO5XBZvjr1eoBFAuP1ENDgsG2H0433d7tr6/iU
 XOJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784352635; x=1784957435;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=we5HquAj09G4Y/1jpx5ufkjtNsZqBpAd8omupF1j9So=;
 b=LGRGSGRiQWJuCoFQWLaqB42F6MbKF3lmbnefHa661b4QVtHMT4ZdBAWm8RO6O3cVJ/
 GPRjbyCffykSpiT16q3iAwqUAtB76WSSDAo0JR0YLiaXLrEwn1cEZWmu9Ecb6q+9Vf91
 6Y8DRorUDX+Ya8nn3o3c/U7CmdnzdT0QI4d58jiFVia4elF+MEiBF2fUhu6Tra796bCG
 Z3qWKLQpq5zACSTPmxxt5LUSEGRpNfsq3J1v0/SVUOPOJkoPeAUh7dZwmPex3TmZCMw+
 XHWcg6axtX/CZS4YuiZSWE/DEpZE3uWP1/iTjByK43ovSzzT3t3vul8+wqUQHo2P+uxJ
 8J3A==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq27YROnuYlDWhMMx7BUf0mPTKKnyt+NUxZNysDbZ7dWZo+ciiyJCGLBeyCje4mZjIy835ETBGoCARI@nongnu.org
X-Gm-Message-State: AOJu0YwJ1oSwPLJKGNcgM0aPN9rOi+l/fcVn4smjw/VdqTzK2QE3bL5y
 Uw5b/ExjcacZjGVI1ri8Cky7ytBsJ91s8SV9DhPK7cxa7butLSPR4jHgNKug8XWHSyojbLZQUJH
 0cCoWhsVOQJz84jmQ/MAO/G7xusViZiUAwD8jroOm2JxyELhy2wB+YqcI
X-Gm-Gg: AfdE7cn/eJTtbueMTy7+udr5+bLkRq433V5fCS+bWQaEoEhYa1/hQU2yGcG5AWXPuCz
 FUP9WJ4Q7E8vPwsDKyIawaphm/mKhyR1q05P2WkfnpTajPIG7CQ9FNZAqmFeKy32j5JAznolZ0L
 IrD7LCQePHh97mFZrm7ZU69LTO3RfGB5sBfxBKCTGC1AFsStJeDvRCMgdih3fuFs1TQiz+loaIZ
 fbNZPzop7VkKenRPgi8xwQ+bt/7Ot2SMTmDaznxAZzb7fNldW7KZSNUoArYD9F+7adXzK9icP75
 faMw1ZrkKhmlLtG/EIb0/1uMfk9ecqNoYRbVclMnxBoTRBMxKPy0srkkUTyEunl6qyFauryAorJ
 DGv/EBwnINGB6SlVdgflhUXTpcF1cvA7f69mixAUoSA==
X-Received: by 2002:a05:6000:60f:b0:47f:6d75:7a52 with SMTP id
 ffacd0b85a97d-47f6d757ac4mr871786f8f.31.1784352634667; 
 Fri, 17 Jul 2026 22:30:34 -0700 (PDT)
X-Received: by 2002:a05:6000:60f:b0:47f:6d75:7a52 with SMTP id
 ffacd0b85a97d-47f6d757ac4mr871754f8f.31.1784352634304; 
 Fri, 17 Jul 2026 22:30:34 -0700 (PDT)
Received: from ?IPV6:2a01:cb19:8426:ae00:d05a:4cf1:6011:33e?
 ([2a01:cb19:8426:ae00:d05a:4cf1:6011:33e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63eea8afsm10229610f8f.33.2026.07.17.22.30.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jul 2026 22:30:33 -0700 (PDT)
Message-ID: <f1a78cc4-a660-4d20-85ad-84431d5a5c13@redhat.com>
Date: Sat, 18 Jul 2026 07:30:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] hw/vfio/listener.c: remove CONFIG_KVM
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 eric.auger@redhat.com
References: <20260312224449.1605071-1-pierrick.bouvier@linaro.org>
 <20260312224449.1605071-2-pierrick.bouvier@linaro.org>
 <c3a7cd83-7666-40c5-9baa-ebe64edacab6@tls.msk.ru>
 <3f98fbb6-16be-4de1-b9ae-6108f8f33b57@oss.qualcomm.com>
 <d3f85639-e6a4-4917-8300-d48a7852662f@oss.qualcomm.com>
 <5dc9f2fc-3bd6-4df3-8496-44e6037b51ad@tls.msk.ru>
 <73d87f66-6907-4e02-8026-b89c49912aeb@oss.qualcomm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <73d87f66-6907-4e02-8026-b89c49912aeb@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: permerror client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

On 7/18/26 06:52, Pierrick Bouvier wrote:
> On 7/17/2026 9:14 PM, Michael Tokarev wrote:
>> On 7/17/26 22:40, Pierrick Bouvier wrote:
>>
>>> https://gitlab.com/qemu-project/qemu/-/blob/master/hw/vfio/Kconfig?
>>> ref_type=heads#L5
>>>
>>> ```
>>> config VFIO
>>>       bool
>>>       depends on LINUX
>>> ```
>>>
>>> Incorrect, and it should exclude Linux hosts not supporting VFIO.
>>> At least sparc64 to fix the current issue.
>>
>> Shouldn't there be "depends on LINUX & KVM" ?  At least, this
>> way we can do --disable-kvm and it will work.
>>
> 
> I think it's a safe choice, but not sure if we are supposed to be able
> to use the exotic combination of vfio with tcg also. Maybe it doesn't
> make any sense technically though, I don't know the arcane of vfio.

VFIO works in some heterogeneous configurations, aarch64 TCG running
on an x86 host for instance. The opposite doesn't. ppc64 TCG on an x86
used to work. The limitations primarily stem from architectural
differences in the host/guest memory mode, CPU/IOMMU address spaces,
assumptions, etc.

> @Cédric, Any idea of which matrix of host/target is supposed to be
> supported?

Overall, heterogeneous TCG configurations happen to work by accident.
I would not consider them supported.

With KVM, the supported architectures are x86, aarch64, s390x, ppc64.
  C.


