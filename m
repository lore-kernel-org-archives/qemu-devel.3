Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1566CC021B8
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 19:04:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnMgx-0000V1-AD; Wed, 26 Feb 2025 14:03:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tnMgu-0000UT-Ho
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 14:03:32 -0500
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tnMgs-0006uk-Jz
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 14:03:32 -0500
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2f9b9c0088fso395036a91.0
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 11:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740596609; x=1741201409; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cMn4a8nyJ6yi+Vap1pbdQF6+GDXZEQnoN32oZDsRlPg=;
 b=b54lC6b1w2Luaa/6pSUv5/DiFXjEq4jkvIe9pcYkfjNtwfVgeqgwdSi5GG/fJSINRA
 nHW2F0b9oN81YpIDjGnjSPH93mBMw3YTcqI4KLN72tvk50v61+V+n69K0qrVopdLtd10
 EEea3Kv6yrAXaeShMgdSPt7/JrotOEcbUWiReew1ECk0Dk9b7HGe0CmekYzrJo8xQJhd
 kjz+83ATDd7vOyPAuuSmKCRg1G61lKBib2yBbdhMcfQ1ePaFqbnY3f7Uf9iNaaMVoLcj
 8OL5Tuhy/DkDdWs0tFitqFbGcVKIsvEAhTGNbtz10DRYmSE58XcpYOT7JWYTRc89+qwd
 Fvwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740596609; x=1741201409;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cMn4a8nyJ6yi+Vap1pbdQF6+GDXZEQnoN32oZDsRlPg=;
 b=NN45c8599lpxz0b9YY/Bma5aEI+4jZAuRYRoL7C3xFXwVlktRiglxwF5y/YpFxeqrf
 PjZ560VJQ3QqXLCd0/CXdYkNSTefZssPf8C6AI5oa48vl6QobKKkc8CA3YY9YxQS29yS
 oc/JTjuw33N9XFtAO+2/jEHxadcLFkxgTuravUy44uElHn4BeEMDK3iiQr1WtoXwdxAm
 FYnJ+maq9JWF8IWl1L3rXhPAbJFXLKzuyzcqBRmUKoReQA8aw/2svMQ0R3sSWkmtnNRg
 64ywC8bN7c10QW3maROLRN7r+MpbuQ7hoMERJUM4ortCTSdk9al5OwzKqXCFra5PARL7
 t3IA==
X-Gm-Message-State: AOJu0YzvAK9lHMYJzWCr7jrVjDKXWyKRTilkJxGrw+4FwnEa2zeEaN0P
 yOaydbc0Clipsug5Bd6cnI8QTvAM5yaxhulVf2e0vaUznlRNCIwUICUHVOi5B6c=
X-Gm-Gg: ASbGncsMGLETYupGNVyQGi1WlSSWSaSLvP+2h8BTQPSwQeHT0dRtmky9+DSWC/fZiEQ
 s//vvjhQbzEiItBe3Oj+qGUSIqQzwUs+0+775CAoEn/Of2My645DU40QC/+D5hXGgaF25njN7ig
 vLc7hDhQbjI2GytIUUPpBp9R9e7NFQ5dhI7fJ2ntM8i8q8N5IYYQ8yOUBDpfrgqaRr1y2Mx0eCv
 x9zHN4dm7TYFFSz057MW0PfmtQqP/ajnWDr+QU2dTQxNj0Kzzp7RHNgjjZVdbCundwz3+sctqYp
 KT5vXFjV6tFifrLr8lnYmrtXT4qxMaIq6CTHHVk=
X-Google-Smtp-Source: AGHT+IFwVGdc1McwF8C72hRXtLMskdWZ6ySkhkg9SKB6LRdpWv/JJK1QWq6+juAdREnBMzDiSHjK/w==
X-Received: by 2002:a17:90a:d408:b0:2fa:603e:905c with SMTP id
 98e67ed59e1d1-2fea12683b9mr797904a91.2.1740596608738; 
 Wed, 26 Feb 2025 11:03:28 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2230a09d819sm36563495ad.163.2025.02.26.11.03.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Feb 2025 11:03:28 -0800 (PST)
Message-ID: <5c25f67a-2677-4162-9477-f51f230403b0@linaro.org>
Date: Wed, 26 Feb 2025 11:03:27 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/misc/npcm_clk: fix buffer-overflow
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, titusr@google.com, hskinnemoen@google.com,
 wuhaotsh@google.com, qemu-arm@nongnu.org, Tyrone Ting <kfting@nuvoton.com>
References: <20250224205053.104959-1-pierrick.bouvier@linaro.org>
 <CAFEAcA_sz-_6WGCQ=4kC2vtK2RUBXbAtMVzh3iZsp0xmNbgaxQ@mail.gmail.com>
 <829e9fd0-2d0f-45e6-ab89-d933d344cfe2@linaro.org>
 <CAFEAcA8BHzA_P7yX+cDMb1WiyGTzkh6xjvam4RHs5aoM1X6mkw@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
In-Reply-To: <CAFEAcA8BHzA_P7yX+cDMb1WiyGTzkh6xjvam4RHs5aoM1X6mkw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1029.google.com
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

On 2/26/25 03:50, Peter Maydell wrote:
> On Tue, 25 Feb 2025 at 20:57, Pierrick Bouvier
> <pierrick.bouvier@linaro.org> wrote:
>>
>> On 2/25/25 05:41, Peter Maydell wrote:
>>> (Looking more closely at the cold_reset_values handling
>>> in npcm_gcr.c, that looks not quite right in a different
>>> way; I'll send a reply to that patch email about that.)
>>>
>>
>> It may be a hole in our CI right now.
>> Would that be interesting for CI to run all tests (check-functional +
>> check w/o functional) with both ubsan and asan?
> 
> We do have at least some ubsan tests in our CI right now
> (eg the "clang-system" job). The problem with ubsan coverage
> is the usual one that we already have too much CI going on,
> and it takes forever and we don't have that much headroom
> for adding more jobs.

I understand the problem behind spending more minutes on this.

However, looking at our CI, we already duplicate functional testing a lot:
buildtest.yml:functional-system-alpine:
buildtest.yml:functional-system-ubuntu:
buildtest.yml:functional-system-debian:
buildtest.yml:functional-system-fedora:
buildtest.yml:functional-system-centos:
buildtest.yml:functional-system-opensuse:

Would that hurt so much to have one configuration enabled with ubsan and 
asan, which catches *real* bugs, and potential security issues?
Yes, it adds overhead, but it should not be x10. Around x2 to x3.

On github running, running -j2, running all functional tests with 
sanitizers takes less than 1 hour, and the build takes the same amount 
in time (-j2 as well). Hopefully we have more cores available on our own 
runners.

> 
> On the asan front, also, yes, coverage would be a good idea.
> Here I think we will probably have to gradually ratchet
> up the coverage because I'm pretty sure that at the moment
> we will find we don't get a clean pass (mostly for "uninteresting"
> memory leaks).
> 

Yes, I run with ASAN_OPTIONS=detect_leaks=0, and I deactivate any test 
that is flaky.

Two of them related to asan are tcg tests:
- munmap-pthread
- follow-fork-mode
I didn't have time to investigate, so I just removed them in my tree.

At this point, this whole list of tests concerned is:
https://github.com/search?q=repo%3Apbo-linaro%2Fqemu-ci+%22ci+fix%22+author%3Apbo-linaro&type=commits

> (I do also usually run a local
> ubsan test build when doing my acculumation of patches in
> target-arm, but since that's a manual step it is fallible :-))
>

It's always said that "Maintainer time is precious", shouldn't that be 
CI job to catch this?
I guess CI minutes are cheaper than engineer ones those days.

> -- PMM


