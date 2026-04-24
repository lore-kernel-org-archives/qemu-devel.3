Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01850FB44C2
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 07:09:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGAeo-0007k5-6C; Fri, 24 Apr 2026 03:08:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wGAel-0007jW-Fz
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 03:08:56 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wGAef-0004RT-Gz
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 03:08:55 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-488a9033b2cso81131065e9.2
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 00:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777014528; x=1777619328; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FqF+LZjzWBu9GOJemZquw+bvJb6uVyfeqWn420hEOWo=;
 b=oQiE+z/4GZyXi7ugiAn9ROKClnPXHUQWK59bwey+LwjtFn5gZ/4zQn+afaO9AQ9E0M
 9MzXx7QNG0TOP2UEpJgpvkPutBIIFjexIpVkRj80hINN7FNhfFfH6uTRaPuX0TAbZYl7
 3QDv9bCtqyNROv1zbYLBOPGUeGkv05wErR62PpzJujOmG3TaS/lozGHgKCql9rYiYE9N
 HFmoNLZvPZiCZIRQ+eYiQ9KL/qGwPxR/Wuz61jo5cT9e5YsNek9YuKmkAXGa+Iha9MiT
 ryy+mbP0BkvYkanu0TXcYP3NMjrtMxWsYbspM3rNNeCeiNUXdaXMxfyBam0AeHYbX1Nf
 qk7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777014528; x=1777619328;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FqF+LZjzWBu9GOJemZquw+bvJb6uVyfeqWn420hEOWo=;
 b=keo06jqLNlwneR13eool6BN2X9jfFVmtdHOnBuk+zBT/IljkCpHZCFQw8Mg0GAbOkW
 VykRnwNM6NkZj23337ve07iWfiHb2a3LI3gxwwj5yx6NVd6+YMtbBK7XrSF3B+oSzdKQ
 EHi6Zonzff6rrEg3BMsORDl/+lstOxM3uxOGLJhOYibgVWEQ6akFHjrAT784MTwvjwNn
 q9DukwPvBs+nb/rBh1EUYgInYxYBqf/iJBsNGw0W5HzNHuCi+xgMqe72WmETjC4CAhhI
 kjz+xCOMqEQXDpPJa+p3fDQroSt2cK+68jRZ4QNciDbalCrJDnneEJhgv7M5vt3F/3ld
 9MoQ==
X-Gm-Message-State: AOJu0YzUDMWUd2MOukZA8//IlTDpi98b73SkKGZTGTw56Hhw+6cUW0UG
 3kp/J/br+dpJyrIvEljkE3Vi5gn57I6f9a61GTvETmT5htRo8udnscyBbxE7kXO/75Tjg1I2TMG
 whYyfJWw=
X-Gm-Gg: AeBDieuvmCbN2xNtsgl2jYe/IT19DUFn8HK230Jww/uVRuhm1ONdK/fbNIxBxWpRROP
 9yPBmM0VIrsufMgu2M8WYKKrDMKDKrF5SHgF+cnWIIhai1nIMv6OwiwwPZYrwxqnw6lPMJHdcqq
 RwF+Yl+M6L4kcEDToOWeoM98gsAT5NRMwL5w/pgJcLa4R6OeSQzpo2jVH6XS9GBeOvF87tqe1Yf
 /whcmKuyt5kxOFe5e7W+bLpwvbWduuA62KfL8tSh15FMpXTgAcCW7gtMJDc7cKKY+tC3MG26//j
 gBDIIjf1lpXBfdMYhbBBX3pppuC1eALq5BuoQ9svt34fH0+WSF1yJzAkQzZg/p95Be39fMakqUv
 NWDH/cbvkctJYly4Lk9+JC5rEbJVFFsqJ9qKxP/cez+/0biJmyLISxKmEj3cC6Kd9zwk8rm5YBB
 g3hEBzxlGRXKBrHLMCRSxhjSQq2uVsT8hGrIxPlgpS6hpnWkHCElPIpZYdvom8+MSXI45OCVFtG
 V187nAaxaS+11A=
X-Received: by 2002:a05:600c:1e09:b0:48a:557e:6b4f with SMTP id
 5b1f17b1804b1-48a557e6c16mr201824435e9.23.1777014527787; 
 Fri, 24 Apr 2026 00:08:47 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fb7ac6aasm180175415e9.25.2026.04.24.00.08.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Apr 2026 00:08:47 -0700 (PDT)
Message-ID: <8ef0c812-0dfe-4972-b68b-2afa570e838d@linaro.org>
Date: Fri, 24 Apr 2026 09:08:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] hvf: map granule abstraction, configurable IPA,
 and MAP_FIXED alignment fix
Content-Language: en-US
To: Lucas Amaral <lucaaamaral@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, agraf@csgraf.de,
 mohamed@unpredictable.fr, alex.bennee@linaro.org
References: <20260317175744.32469-1-lucaaamaral@gmail.com>
 <CAFEAcA9587cZ+oOv2t6No6eBJdR9gxow8RFqy-JN=7OH3xk7HA@mail.gmail.com>
 <20260423172210.51760-1-lucaaamaral@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260423172210.51760-1-lucaaamaral@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

Hi Lucas,

On 23/4/26 19:22, Lucas Amaral wrote:
> Hi Peter,
> 
> Thanks for the review and for asking Mohamed and Alex to take a look.
> 
>> The question that comes to my mind is whether the two places changed
>> in accel/hvf to look at hvf_get_map_granule() really are the only
>> two places in the whole of QEMU where we call
>> qemu_real_host_page_size() and expect it to be also the guest page
>> size. The general idea of 'guest page size might not be the same as
>> the host page size QEMU itself gets' isn't hvf specific -- maybe we
>> should have a qemu_guest_page_size() function?
> 
> Good point. I'll audit the qemu_real_host_page_size() call sites to
> see which ones actually mean "guest page size" and whether a broader
> qemu_guest_page_size() abstraction makes sense. I'd send that as a
> follow-up series once these patches land, so the immediate HVF fix
> isn't blocked on the broader refactor.

If using a generic approach, the property added in the previous patch
should go into AccelState, at a glance registering the QOM property in
accel_ops_class_init() in accel/accel-system.c.

Also HVFState::ipa_granule -> AccelState::guest_page_size?

