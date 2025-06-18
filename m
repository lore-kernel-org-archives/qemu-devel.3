Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3DA3C7115B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Jun 2025 07:54:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRnbt-0008Sm-Tp; Wed, 18 Jun 2025 03:53:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uRnbm-0008S7-T5
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 03:53:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uRnbj-0002je-CP
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 03:53:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750233197;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=1I4fDVF+EBeVQxWIO3b+eQ3mAzjAquOaxyCQPVLmBuI=;
 b=gwQoeSNfxz85NNHpnI8vo6JQUSctKajUfoH3BifWiQh4iNXzTn0JqPdKtbmuYI/58U/PXQ
 JfeDfauc6SgIHRptGBvX5JBt43fguvN7fnKTkuyuo0ruF5rG0HfX3phXPDvVQ4ecETG+ij
 8B70uwFC15uiGA48ZQABNgQOfbXogMM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-_FVZCVzxMLidhp5Bgt2ItQ-1; Wed, 18 Jun 2025 03:53:15 -0400
X-MC-Unique: _FVZCVzxMLidhp5Bgt2ItQ-1
X-Mimecast-MFC-AGG-ID: _FVZCVzxMLidhp5Bgt2ItQ_1750233194
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a50816ccc6so3618797f8f.1
 for <qemu-devel@nongnu.org>; Wed, 18 Jun 2025 00:53:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750233194; x=1750837994;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1I4fDVF+EBeVQxWIO3b+eQ3mAzjAquOaxyCQPVLmBuI=;
 b=B7k2nc3iZXGN98CbQRabxvSLE0jOyRt0g/SaV3ExlgRsA1TPKsQ76qwQp/K1EpuUGt
 KR2etafeCOzWckZYMfLqfFbSp3OfRQfojOIaIl68EdnXkvRC9R9T5cfNWNICPedlQAWb
 K74aav3qHqLYWYEOyxvrcSoLRxFv+Vc8epLIOSKAkh8ZhUjbJavJ2CxR30SA6TUt6s7n
 XwzB1QPToAsGkhbpW+5oReIcMAUWOi8ALRZgY2efERTRu5hartaYfVRQU5WeZX4NdwhS
 Zv/4CxYvTZzLaYxQTXFX8NlkuNspL08XzBYqNWYEp6p3Bun6+CqPQmH1qosyazmWH18E
 v/cg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3JyNQE+6qv9wayVieJ4GYLa605nf6B5UpPi9hUBc1zyHdx1ftn8KThb0QtjYGc7bcwVLhnTWxsQv0@nongnu.org
X-Gm-Message-State: AOJu0YzrOWlQgmie7C1JH7kWz0hFSdFQCR/wFykVJh45ybk57qZ9aPop
 vgGLbqfQGfS5UJ28+2ihftF2iDM4tBt1rQxBwSJtrVW5guILPUjn1J15jf1aNEsI3dHkje6uQ+G
 NHHE8pii0ZA1dPmgdL53XGoItbMRpFxdrVCyBqRdD1DsesoGoe0V8Bvk8
X-Gm-Gg: ASbGncvYzX86lWJKK08b1h/Tgsxz3LT0ZgH/TRk6HUrOiyBqGIZhBvtOND9NRG097hb
 htOLOhgy8wIot0/4k7ZaTDxvZIigOneAlZG9CFiWV29aSr1WOEFk7P2bHkvsFuhofJnbFKkjb4V
 fRwbtG5GRUKFP4kVFLdXqNsAP3LpeGlkAKdllUYp30V6P+Q0lryn2myEhd+951ybmq3dXHaLLqx
 Goj/DgInOln1vXI6ATTygH7wtLeUg0BNwTqhBTPZE5fOynHplpsY0XMu5Yfo4HYsJjPRqg3G3WY
 eV/t61FYJ1vkqzSYmEVXMxIzKhs=
X-Received: by 2002:a05:6000:2913:b0:3a4:e706:530f with SMTP id
 ffacd0b85a97d-3a572e795f9mr12604888f8f.42.1750233193954; 
 Wed, 18 Jun 2025 00:53:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPfuX6A+GKShBwdML5xjelg6Q9xSNRZxMqylDqPRMK8WaAo364gkINfOCg+udiYcXFKOAq9g==
X-Received: by 2002:a05:6000:2913:b0:3a4:e706:530f with SMTP id
 ffacd0b85a97d-3a572e795f9mr12604870f8f.42.1750233193508; 
 Wed, 18 Jun 2025 00:53:13 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.88.147])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-3a568b7431esm16465614f8f.97.2025.06.18.00.53.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Jun 2025 00:53:12 -0700 (PDT)
Message-ID: <23559c8d-149a-4ec6-adaa-fe0a8f8533f1@redhat.com>
Date: Wed, 18 Jun 2025 09:53:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Build platform guarantees, docs, tests, and snakes in the garden
To: John Snow <jsnow@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Daniel_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
References: <CAFn=p-YuqzXvWF-cGLUc0LVVMe2Rinx9+LOjvpHRY-vRrPyJow@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <CAFn=p-YuqzXvWF-cGLUc0LVVMe2Rinx9+LOjvpHRY-vRrPyJow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.89,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 6/5/25 21:35, John Snow wrote:
> However, if we take as iron-clad our commitment to the build platform 
> promise -- *and* guarantee offline/tarball builds as well -- then Debian 
> 12 (as an example) only offers Sphinx 5.3.0 and not newer unless we 
> allow internet access to fetch Sphinx 6.2.1. This is not a problem for 
> developer workstations at all, but I am unclear on what problems this 
> may cause for tarball releases and downstream offline/isolated/ 
> reproducible builds, if any.
> 
> In this case, we can (probably) "fix" the issue by continuing to allow 
> older Sphinx while preferring a newer Sphinx version when it is missing, 
> but then we lose the ability to make code cleanups and drop a lot of 
> back-compat crud. If memory serves, there were other issues recently 
> where older versions of Sphinx behaved differently from newer versions, 
> causing intermittent failures that were hard to track down.

The *ideal* solution would be to:

- accept: 4.3.2 or newer, which is what Ubuntu 22.04 has

- install: 6.2.1, which is what supports Python 3.13

This lets all supported distros build documentation if they use the 
default Python runtime.  It would still require a couple hacks in 
compat.py: SOURCE_LOCATION_FIX and nested_parse_with_titles().

I am not sure however whether to count the latter, for two reasons. 
First, it has this:

     # necessary so that the child nodes get the right source/line set
     content_node.document = directive.state.document

so it is not a pure compatibility hack.  Second, and opposite, currently 
none of the uses of nested_parse_with_titles() go through compat.py's 
version, therefore it probably can be removed altogether.

That leaves only SOURCE_LOCATION_FIX.

As an aside, if the compat.py hacks survive, I would add comments to 
document which distros need the hacks.

> What I'd like to know is: what precisely are our options in this 
> scenario? Do we consider it acceptable for some platforms to be unable 
> to build docs offline?

Certainly for platforms not using the default Python runtime, which 
right now is only SLES.  For others...

> How highly do we value the ability to locally 
> build docs for any given release?

... I think I value this a bit higher than Markus, but not really 
because of offline builds.  Rather, keeping the "accepted" key lower 
(i.e. supporting the packaged sphinx on a wide range of distros) makes 
it easier to bump the "installed" key when needed, as in this failure to 
run 5.3.0 under Python 3.13.

This time there was a version that works on both the oldest and newest 
Python that we support, but there may not always be one because sphinx 
is all too happy at dropping support for EOL'd versions of Python.

Paolo

> Before I throw my weight behind any given option, I just want to know 
> what we consider our non-negotiable obligations to be.
> 
> Thanks,
> --js
> 


