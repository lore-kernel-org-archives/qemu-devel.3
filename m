Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10802D6ACDD
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 16:09:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWGYH-0000U8-0P; Thu, 18 Dec 2025 11:08:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vWGYC-0000Tn-Fv
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 11:08:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vWGYA-0001vV-LU
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 11:08:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766074101;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=U4w0W1Cm6nylRDgPakdJfKxfgbiA5ZJpp554xzVfch0=;
 b=JrYvaA0TlM5IiAycc8j94Yf/Sm8I44za+zue8VKXnqONmuK5wSiOwp7nPL4EOx+GySYGxw
 LHBf/cTyLCAUCqi4Ok6WDJc/NHy9XqI8qgKDq59Ypybb5zx94nMxnGXe8keN/0+vGd8mh8
 MbcUIKm8LrRBY9QT2bWi7t9njZ/zIMk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-272-i37rnAhjPxq0RdvraJI4_Q-1; Thu, 18 Dec 2025 11:08:19 -0500
X-MC-Unique: i37rnAhjPxq0RdvraJI4_Q-1
X-Mimecast-MFC-AGG-ID: i37rnAhjPxq0RdvraJI4_Q_1766074096
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4788112ec09so8608435e9.3
 for <qemu-devel@nongnu.org>; Thu, 18 Dec 2025 08:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766074096; x=1766678896; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=U4w0W1Cm6nylRDgPakdJfKxfgbiA5ZJpp554xzVfch0=;
 b=YSIly7a8GafYWRNQQlbt97/+aniUFgm2NU/ii8ZVYwyMvxIqSu3jgK/VqcVqezB3nm
 4EREHea/TOqxzmfhNS3NFa1Mp+FYVmqATNRYy9CKPpX0B2fuvJ+FLqefQssbXEDPU3qh
 sx2h6Avmq85AXzHqlsv3/dVGlALcr89QN2UhY0usBqT+JjskUV1XuRcVaoheT761SHJS
 ocUminiKeSSHxzydXkAUo+fFHc267TJiNyldwxLHkoRrO7q8r+NpaUv/vaE5oVsSbWY3
 X0G0rKjR2UPqjyfqqXriHZECvudyZCCMUA2W7TZ4X6s5zF7YM8rmLEP/PQZLo+Ra0/Sx
 VfSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766074096; x=1766678896;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U4w0W1Cm6nylRDgPakdJfKxfgbiA5ZJpp554xzVfch0=;
 b=iQuCiP6UnOX6lgrMar8hw7CXQBlpj7p34RSArilki+ot26UmBZvIUzYjVAqeJRsGIJ
 8v2Ikfccf2Hc8Aet/RSNmjb5UN3pa3/mnz85HlQgR0wPd+BpTJtPahS0s9Ba0NvA4+Gy
 hrQws1OymcwcIUOJdd07c37Qnf3wZxniq+bexF6tc2g9BHdVP5pGIEfn/n4tXVTGPEUv
 duw6iGCzMk3YvgbKPkuT88hkp5/AbKfghPhtWowWTgDvtPSgP0CzB0Iont2B8nGVWHpg
 HG9vIhuRAqvQYf2Q0NZUyeuvXCHGmOwgN/210RBlG/AIsKa7LXeJDCwOjwSwAQnm2Iyi
 hMHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgsAYPpnr6zK17xELRJTnsZ6cVXteyMNRgspCzLD06+ENs4i+0MyhbvS/Be7rshfIWrghhxWpHeLus@nongnu.org
X-Gm-Message-State: AOJu0YxYudmwl4IeZz7OL8krw1cHnDNg5oLnABYH8bzPBH9xfEKWlKH1
 nj1//hgXfxjRxhG/Fk/L592+QervwH1F0aYdxPHPFEpPOC96JPvoXfLh+v02q5leGBBPzn0QFFP
 A6GPkWcqVHFFufOwDQmTmjmNWWu57PzJNZYEE4n4qJDxO9QAi51R1ZlLH
X-Gm-Gg: AY/fxX7acGi7Lu5pSBhE2I1UPFPOzX4PD0NFQd+xI4haE7/12rlmml/XLF97aIs1MmG
 rjbM7A49LsHI2Abtz52qx/hRhExg9wTqHNohBp7EHdivTyUBf+C5fOO2hIkRu/dcAEBuRhhOT6p
 D4DywIRhDD9yKdo8hwqnw6hMxIpYM81CgjW40mNfWj45sJFBDE2rZaQehfXOzYULliDOKgFYGlG
 3h4fmRItGxqXAZM7zhwvig/o2VXf05ZycME/a/enA8hslsMbL9Ks/d0Mo7l8HOuWNdUeDj1141M
 x4juvWwDJ7JSs6m0g+jpue96gssGPMPXTwItPnqZr/Dn+LP0tdYmHGXz9TTUJjaV8wp0/K0MQDy
 jKs2rLwY=
X-Received: by 2002:a05:600c:8286:b0:477:7ab8:aba with SMTP id
 5b1f17b1804b1-47a8f8ab861mr227032465e9.1.1766074096032; 
 Thu, 18 Dec 2025 08:08:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGluLjwzlKCQISJzCUKjvfHCxmqHmjTB2IpXI9YrFwy6IB1+laOxs5w/xR0AX/P5D1/qgVkBg==
X-Received: by 2002:a05:600c:8286:b0:477:7ab8:aba with SMTP id
 5b1f17b1804b1-47a8f8ab861mr227028345e9.1.1766074090846; 
 Thu, 18 Dec 2025 08:08:10 -0800 (PST)
Received: from [192.168.0.5] ([47.64.112.241])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be3a5486dsm16347235e9.9.2025.12.18.08.08.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Dec 2025 08:08:10 -0800 (PST)
Message-ID: <4a47b7bf-422a-4201-a060-0e437f4e4cc3@redhat.com>
Date: Thu, 18 Dec 2025 17:08:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Report on MAINTAINERS coverage
To: Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <87h5toc61n.fsf@pond.sub.org> <aUP5znRDyuBlpGvW@redhat.com>
 <871pkrdi6w.fsf@pond.sub.org> <aUQGWes2pCSWTDfe@redhat.com>
 <288b1dae-68c5-4b48-ab08-62a7b08245ea@redhat.com>
 <87sed7ak35.fsf@pond.sub.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <87sed7ak35.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 18/12/2025 16.25, Markus Armbruster wrote:
> Thomas Huth <thuth@redhat.com> writes:
> 
>> On 18/12/2025 14.49, Daniel P. Berrangé wrote:
>>> On Thu, Dec 18, 2025 at 02:37:43PM +0100, Markus Armbruster wrote:
>>>> Daniel P. Berrangé <berrange@redhat.com> writes:
>>>>
>>>>> On Thu, Dec 18, 2025 at 01:45:24PM +0100, Markus Armbruster wrote:
>>>>>> Which unmaintained files are we still changing?  Unmaintained files
>>>>>> sorted by number of commits in the past year (since v9.2.0):
>>>>>>
>>>>>>       $ for i in `cat unmaintained-files`; do echo -n "$i "; git-rev-list v9.2.0.. $i | wc -l; done | awk '{ printf "%7d %s\n", $2, $1 }' | sort -rn
>>>>>>
>>>>>>       107 tests/functional/meson.build
>>>>>
>>>>> Opps, that's a mistake. It should of course be under the
>>>>> general maint heading "Functional testing framework"
>>>>
>>>> Thanks!  I can patch that.
>>>>
>>>> What about the other uncovered files in tests/functional/?
>>>
>>>> tests/functional/aarch64/meson.build
>>>
>>> [snip many more]
>>>
>>> I'd wildcard   tests/functional/*/meson.build under the
>>> general maint.
>>
>> Either that, or make sure the the architecture maintainers own the whole
>> tests/functional/<arch> folders.
> 
> The former is easy.  Regarding the latter...
> 
> The MAINTAINERS section we use to cover an architecture is often less
> than obvious.
> 
> meson.build under tests/functional/ covered so far:
> 
>      tests/functional/alpha/meson.build      Alpha TCG CPUs
>      tests/functional/avr/meson.build        AVR TCG CPUs
>      tests/functional/hppa/meson.build       HP B160L, HP C3700
>      tests/functional/i386/meson.build       X86 general architecture support
>      tests/functional/riscv32/meson.build    RISC-V TCG CPUs
>      tests/functional/riscv64/meson.build    RISC-V TCG CPUs
>      tests/functional/s390x/meson.build      S390 Virtio-ccw
>      tests/functional/x86_64/meson.build     X86 general architecture support
> 
> We have "$ARCH general architecture support" (obvious enough), "$ARCH
> TCG CPUs" (meh), and even machine sections that happen to be the only
> one of this architecture in MAINTAINERS (meh^2).

Yes, it's ugly, but that's basically what we currently have in MAINTAINERS, 
I think.

> Thomas, should tests/functional/s390x/meson.build move to "S390 general
> architecture support"?

It doesn't matter much since there is currently only one single machine for 
s390x, and that's this S390 virtio-ccw machine.

> Not covered:
> 
>      tests/functional/aarch64/meson.build
>      tests/functional/arm/meson.build
> 
>          There is no ARM general architecture support section.  Add these
>          to ARM TCG CPUs?

That's the best solution, I think.

>      tests/functional/generic/meson.build
> 
>          Functional testing framework?

Yes, please.

>      tests/functional/loongarch64/meson.build
> 
>          LoongArch TCG CPUs?

Yes.

>      tests/functional/m68k/meson.build
> 
>          M68K TCG CPUs?

Yes.

>      tests/functional/meson.build
> 
>          Functional testing framework, as discussed above.

Yes.

>      tests/functional/microblaze/meson.build
>      tests/functional/microblazeel/meson.build
> 
>          MicroBlaze TCG CPUs?

Yes.

>      tests/functional/mips/meson.build
>      tests/functional/mips64/meson.build
>      tests/functional/mips64el/meson.build
>      tests/functional/mipsel/meson.build
> 
>          We have MIPS general architecture support.  I guess we can add
>          them there.

Sounds right.

>      tests/functional/or1k/meson.build
> 
>          OpenRISC TCG CPUs?

Yes.

>      tests/functional/ppc/meson.build
>      tests/functional/ppc64/meson.build
> 
>          PowerPC TCG CPUs?

Yes.

>      tests/functional/rx/meson.build
> 
>          RENESAS RX CPUs?

Yes, though it's orphan, so it won't help much.

>      tests/functional/sh4/meson.build
>      tests/functional/sh4eb/meson.build
> 
>          SH4 TCG CPUs?

Yes.

>      tests/functional/sparc/meson.build
>      tests/functional/sparc64/meson.build
> 
>          SPARC TCG CPUs?

Yes.

>      tests/functional/xtensa/meson.build
> 
>          Xtensa TCG CPUs?

Yes.

>>>> tests/functional/arm/test_max78000fthr.py
>>>
>>> Added by Thomas but not sure what maintainers category it should go
>>> under.
>>
>> No, I just moved the file around. This belongs to the "max78000fthr" arm
>> machine - we need a complete new entry in MAINTAINERS for that one if I get
>> this right.
> 
> Which files?  My best guess based on git history:
> 
>      docs/system/arm/max78000.rst
>      hw/misc/max78000_aes.c
>      hw/misc/max78000_gcr.c
>      hw/misc/max78000_icc.c
>      hw/misc/max78000_trng.c
>      include/hw/arm/max78000_soc.h
>      include/hw/misc/max78000_aes.h
>      include/hw/misc/max78000_gcr.h
>      include/hw/misc/max78000_icc.h
>      include/hw/misc/max78000_trng.h
>      tests/functional/arm/test_max78000fthr.py

You missed:

     hw/arm/max78000fthr.c
     hw/arm/max78000_soc.c

Maybe simply use hw/*/max78000* and include/hw/*/max78000* to cover most of 
the files?

  Thomas


