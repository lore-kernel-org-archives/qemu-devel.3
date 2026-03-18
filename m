Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E30710775EB
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 17:39:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2urn-0007rS-Tr; Wed, 18 Mar 2026 13:39:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w2ure-0007r1-AS
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 13:39:26 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w2urc-0003ek-Gn
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 13:39:26 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-82985f42664so152000b3a.0
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 10:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773855562; x=1774460362; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nVwEkADz5nsARFrPsqKVQXnvqp4qHPPvZEZBdKH/L60=;
 b=wKzF9NUrLRXp1y2ulb2tpLDIvLmuvWaiCV+uE2PClOYK31qtNA6jG5eyOU95UMBIV2
 BXbKIpNsIQXiH4Cp6ViTHDt0q8GKBNUxbA31OC/l2LJ+ITQmujd5wLK3M4n/2GK4NMx7
 v6tJfUu6wMvesLXCi/2SY87ZCJm9ZGdL342XUCJ0p5pu148Zhzj2XbxGIPQNNZ/mMNCl
 ziGNgRgLx7pN4KlwLWGhEx9fi2JBJi+ncI9RSxeNazBZ+aNF5dhrvFeedb1z2wWz7GxG
 v82wKoupVDVsk4iWvMFaVuqxQvf7spGbFwKTVOGZkP9Ze2/nFCJy5ss6twLngGRmliud
 mVww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773855562; x=1774460362;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nVwEkADz5nsARFrPsqKVQXnvqp4qHPPvZEZBdKH/L60=;
 b=Tr8D+PYIz+q5nKaWTcrR7GEm93/5Tjp9sDEzcamM+M8d0P0wFoUl6KGPf5l6vtmjCS
 hScDReCqNL53LovnnK5dIKRzc2C4shm0LaGvAJALol/VY5IKN1RTqfZ2xzv8aY5VdF4r
 dMDt7D0/EkwJfXoRUIXZwpJ5PypIJew/ra/iZUugdDq29URxyxOglLymgOqhXxyTeG1S
 2ylFo4GF9WiH3IJ5HynS4Xd8sjof2SbfK55oJ1hVjQ0dVuswWYh4ORSimAnvCwfVJi7/
 OoJGVJTnZYwtFKZ49x5lpch9CZ/ydO0ZqOq3pdzY+BmABWHK5JNyBPvx4NOjS/zhWMOg
 a7OA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHMz4dFksKAWJeBCV4MYcduvzsNIpqCdD52OTsuSOmbCOjbB/HvEJ3uP7NtDa7cSpIXCtcbVJEChNt@nongnu.org
X-Gm-Message-State: AOJu0YyCW52lBGKiUF6xA3f9RmQaCc0lYg5pl7m6A+VOCeCyzCrBsX9o
 CCvOtJuPK3/uziJ7Bm4TGfjf1mf6HVWA1NYRNEKexdhvPsrkWKCwvNuU34vY2pe4kJ0=
X-Gm-Gg: ATEYQzycsxtTQGMIgPY8j7FIe075OSqQN03yGzAYfrjeAO0ETCasiwf0OUArwPjr0D/
 aswfHmRkPcHQ8PkD9SMVJYtf6gbp6UYKsjKBDYty8s4gTa/niuIHXsP7v2wYFjoE3WtYDQRORrd
 AWFbw+vyVMMnsQKY7Nu34Ht5bBFm0CEHesai/e8Jx5WtEHbF/XaJwPPm4IKupJDfXm5j1U1gGjf
 E9kDmv6OGwMyAHjX5zG6Hn9tj1YrTKabw0UdPjNE8GQqO1Az9I+SaU6yfqHuVIn2DlcvZgFgCAl
 P/5q9Nqk0Ulk1UHigDLfzMv5tcQty/ouCTlQ6cAh2CGNljz3i6m1Qg4TgAbhnuE4rdb6zGGFJnT
 GTSf1K3Tw54hToVh2u2IK6XEO+BCIrsjDns90SJVHb5h6hZ2MgJY4vsn0c5CDKpyA7TKUphWe2v
 aL5dFW1T++dQ6joUMc2dEh3wwzXSlUI30Go2AJZiN/faDPG2Ep5XlDgXngOv3gQQOCdmow
X-Received: by 2002:a05:6a00:114c:b0:829:809e:8978 with SMTP id
 d2e1a72fcca58-82a6ae7056fmr3766454b3a.31.1773855562110; 
 Wed, 18 Mar 2026 10:39:22 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82a6b56ac50sm4306898b3a.16.2026.03.18.10.39.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Mar 2026 10:39:21 -0700 (PDT)
Message-ID: <cfadb291-159e-4f57-830e-c1b0054c8547@linaro.org>
Date: Wed, 18 Mar 2026 10:39:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/8] hw/vfio/pci-quirks.c: remove CONFIG_VFIO_IGD
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, eric.auger@redhat.com,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20260317194241.869568-1-pierrick.bouvier@linaro.org>
 <20260317194241.869568-4-pierrick.bouvier@linaro.org>
 <40924489-a8bb-4f6f-b85e-6f53cf475304@redhat.com>
 <b57f120e-dc8e-4d58-861a-01c2112b7d8a@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <b57f120e-dc8e-4d58-861a-01c2112b7d8a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x431.google.com
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

On 3/18/26 2:46 AM, Philippe Mathieu-Daudé wrote:
> On 18/3/26 09:11, Cédric Le Goater wrote:
>> On 3/17/26 20:42, Pierrick Bouvier wrote:
>>> Add stubs for needed functions.
>>>
> 
> --->
> 
>>> As well, we need to add pixman to qemuutil library dependencies since
>>> pixman is transitively included from pci.h header, which is needed to be
>>> able to include prototypes for stubs we declared.
>>> In file included from include/ui/console.h:4,
>>>                    from ../hw/vfio/vfio-display.h:12,
>>>                    from ../hw/vfio/pci.h:25,
>>>                    from ../hw/vfio/igd-stubs.c:9:
>>> include/ui/qemu-pixman.h:10:10: fatal error: pixman.h: No such file or
>>> directory
>>>      10 | #include <pixman.h>
>>>         |          ^~~~~~~~~~
>>>
>>> On OpenBSD, opengl headers are not available in default include path,
>>> and thus we need to add opengl to list of qemuutil dependencies.
>>> In file included from /home/root/qemu/include/ui/console.h:9:
>>> /home/root/qemu/include/ui/surface.h:11:11: fatal error: 'epoxy/gl.h'
>>> file not found
>>>
>>> Finally,
> 
> <---
> 
>>> vfio_pci_hot_reset_info must be forwarded declared on non linux
>>> platforms:
>>> In file included from ../hw/vfio/igd-stubs.c:9:
>>> ../hw/vfio/pci.h:265:44: error: 'struct vfio_pci_hot_reset_info'
>>> declared inside parameter list will not be visible outside of this
>>> definition or declaration [-Werror]
>>>     265 |                                     struct
>>> vfio_pci_hot_reset_info **info_p);
>>>         |
>>>
>>> Reviewed-by: Cédric Le Goater <clg@redhat.com>
>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>>
>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>
>> Duplicated Signed-off-by. I can fix when applying.
> 
> Actually you can also cut description marked betwwen --->
> and <--- because already mentioned in future commit 988499515da:
> https://lore.kernel.org/qemu-devel/20260317190250.70506-3-philmd@linaro.org/
> which removes [*] below (should disappear on rebase).
> 
> (Sorry for that hiccups, I was expecting Pierrick series to
> be posted after my PR was merged).
>

No problem, I'll change it and fix the extra signed-off by, so Cedric 
can have a clean v5 to apply.

Thanks!

> Regards,
> 
> Phil.
> 
>>
>> Thanks,
>>
>> C.
>>
>>> ---
>>>    meson.build          |  2 +-
>>>    hw/vfio/pci.h        |  2 ++
>>>    hw/vfio/igd-stubs.c  | 20 ++++++++++++++++++++
>>>    hw/vfio/pci-quirks.c |  5 -----
>>>    hw/vfio/meson.build  |  1 +
>>>    5 files changed, 24 insertions(+), 6 deletions(-)
>>>    create mode 100644 hw/vfio/igd-stubs.c
>>>

