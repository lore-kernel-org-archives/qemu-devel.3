Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACD32EE01F6
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Dec 2025 21:00:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vagoh-0001vD-FW; Tue, 30 Dec 2025 15:59:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vagog-0001uq-0D
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 15:59:42 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vagoe-0000B8-9e
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 15:59:41 -0500
Received: by mail-wm1-x343.google.com with SMTP id
 5b1f17b1804b1-47d493a9b96so16876375e9.1
 for <qemu-devel@nongnu.org>; Tue, 30 Dec 2025 12:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767128378; x=1767733178; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nVt5x1V/KWyNUwJI9kkoEIitxrf3NRc32OsT9Lq+dPk=;
 b=rNqKRZJj2421ixRuJNZe4mVhRyWU2IdWqBq14HxSPpakqfxaq4g1GNGVGzQUDyL7Lz
 JdDDw6Bx4dymN22Z5ZFE/dRYx52hF6TPg5fPCBPRJojOJDZkw9VesxG3psxb3DJbQGgO
 GvaeARPSGZRW9rjKgKaottZGhRm+giuJdl6v+S3njm9nItlnohFLAEtQBbEGUkv19dlM
 uimaLuriv5ByK9r86b9DamfYO6poQDvERbi4I4sA5uTp0zbeDw61VH0e8oLIPoyLdsDy
 zFEAqJFWTqVeghjbPDlssNjPh1gIuifkLyisIdgmHXv3hhyY3B4TKSsMnujS6b2CB3MY
 X5ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767128378; x=1767733178;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nVt5x1V/KWyNUwJI9kkoEIitxrf3NRc32OsT9Lq+dPk=;
 b=OLAlddw4nJE32wsHoBCA+wfVyKAW0ACyR+DwOl+MQ9usUshOGziRun31QOtcHSQa6U
 9Q0HQ8umt/jFIUcger5RAeqSwLeiOFuVE2lNN68SXKOYDLPTLBigA7eS/zS/2sXs5Z4O
 5srhmLXZhU7e40sFR+Wtbb+BzC3HAzdaVBoGsp/TqqKO9BxngyQef64v2d1wKd5A0+D8
 O1RplHEYCv8/XOoet3n0c7xt65a+mIN6wJSkjs6m9g2DANsH8obGFSRlNVUqGT/3Xh1w
 vJcMAY8Lx2mnrGb40SoMoIG+RP/RCrHI9tZ784Bxomo2mB2G/vcyW5KAyIDaVktWDOQq
 nPug==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhu8PsKbrS2rEdZaDcatflMF7KyFHH+8hSigV1xClihjs0bNs0rbfBMk5z5Thp7Wo8rr1NM5FrD+zI@nongnu.org
X-Gm-Message-State: AOJu0YysmZrobUS8bwzu+NrAqm0+dPSOHIkqMxVtk+t6r0CjkDJ6+E4R
 fmL4IvXujGxpQPyTj3wf7cCcxPclErXSaGyb3ATJi1S0QXHc3jeBzVEyMCMWR2CYi5I=
X-Gm-Gg: AY/fxX4b3HO70ZYaDJ63/vCkyXI5OuNcEHyPKS9OxxJ36MGPcGUz/r2JZvQURh8LLpg
 xdIxVoYQmm98i9bV5NXXr2ANMDUZ+m6ntPqX4OHgChUZFZhbWsOTRhVLoy9WGETbSeqifcMVoMm
 OdfEneihW9gOJbdTqqCj9jHl0L+UvS/uzJBKizPIi0tstchTUEEaF3C3B8pZS5aYuuX/M1HftkJ
 fE63tonuBkb7Llq9JagLVxTV51DZjidnJlBMAcgnsbiIBYN80UkJyPmf06AvVIPL3ssLzsaT0B1
 yutCh3aU+15FkGjws3H24797iy1cp7MA9iAadOQgRICdysESwK7LboSDVdf5EEdFJ40/7wL7/cz
 AR6VOWyONhNe1eS4bD8xTmf6nfp4PpnHCcPQLejNgOYK7vK8FjTLTBSqi5itUdOCqCCMwo7+R5C
 3RDwl5XHYrD7s3TTIksBfMo2YFG1/Bsz4oHTXrRPqQMc7+rZSwJ6h3ng==
X-Google-Smtp-Source: AGHT+IEKhOCOuQe4dfTwOrrVAtOtUHtNWg1vjoWVhrfA5Y2WI1/fTP7lqKHJcImDee7/sQuxyo2eQA==
X-Received: by 2002:a05:600c:468f:b0:45c:4470:271c with SMTP id
 5b1f17b1804b1-47d269c7019mr371408705e9.18.1767128378547; 
 Tue, 30 Dec 2025 12:59:38 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be26a81b6sm686331315e9.0.2025.12.30.12.59.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Dec 2025 12:59:37 -0800 (PST)
Message-ID: <0e2a98d1-e088-4d46-b49a-3f07b13dea2d@linaro.org>
Date: Tue, 30 Dec 2025 21:59:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional: Fix URL of gb200nvl-bmc image
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, Ed Tanous <etanous@nvidia.com>,
 Patrick Williams <patrick@stwcx.xyz>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20251222073351.166720-1-clg@redhat.com>
 <100505ae-4d33-4bd4-800b-6ab21b99738a@redhat.com>
 <589ced7e-0ad5-45cc-984a-102552cc8b5e@linaro.org>
 <b97c1b53-4f57-4b98-b1a9-c8c7b5367f87@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <b97c1b53-4f57-4b98-b1a9-c8c7b5367f87@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x343.google.com
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

Hi,

On 24/12/25 12:27, Cédric Le Goater wrote:
> On 12/24/25 11:51, Philippe Mathieu-Daudé wrote:
>> On 22/12/25 13:52, Cédric Le Goater wrote:
>>> On 12/22/25 08:33, Cédric Le Goater wrote:
>>>> Commit [1] moved the FW image of the gb200nvl-bmc machine and broke
>>>> the associated functional test. Fix that.
>>>>
>>>> [1] https://github.com/legoater/qemu-aspeed-boot/ 
>>>> commit/52451b2472eeb40aa97e131aeea327e9d4a8a78a
>>>>
>>>> Cc: Ed Tanous <etanous@nvidia.com>
>>>> Cc: Patrick Williams <patrick@stwcx.xyz>
>>>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>>>> ---
>>>>   tests/functional/arm/test_aspeed_gb200nvl_bmc.py | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/tests/functional/arm/test_aspeed_gb200nvl_bmc.py b/ 
>>>> tests/ functional/arm/test_aspeed_gb200nvl_bmc.py
>>>> index 8e8e3f05c1b2..e5f2dce0f569 100755
>>>> --- a/tests/functional/arm/test_aspeed_gb200nvl_bmc.py
>>>> +++ b/tests/functional/arm/test_aspeed_gb200nvl_bmc.py
>>>> @@ -11,7 +11,7 @@
>>>>   class GB200Machine(AspeedTest):
>>>>       ASSET_GB200_FLASH = Asset(
>>>> -        'https://github.com/legoater/qemu-aspeed-boot/raw/refs/ 
>>>> heads/ master/images/gb200nvl-obmc/obmc-phosphor-image-gb200nvl- 
>>>> obmc-20250702182348.static.mtd.xz',
>>>> +        'https://github.com/legoater/qemu-aspeed-boot/raw/refs/ 
>>>> heads/ master/images/gb200nvl-bmc/openbmc-20250702182348/obmc- 
>>>> phosphor-image- gb200nvl-obmc-20250702182348.static.mtd.xz',
>>>> 'b84819317cb3dc762895ad507705978ef000bfc77c50c33a63bdd37921db0dbc')
>>>>       def test_arm_aspeed_gb200_openbmc(self):
>>>
>>> Applied to aspeed-next.
>>
>> Thanks, this is part of the 2 build failures blocking current pull
>> requests (other one being
>> https://lore.kernel.org/qemu-devel/20251224085714.83169-1- 
>> philmd@linaro.org/).
> 
> Thanks, I was going to send an aspeed PR yesterday and then, I saw
> the tests failing because of the missing v5.0.0 machines.
> 
> C.
> 
>> If we really want to consider our CI as source of truth (and blocking
>> when not green), then please consider applying it directly on master
>> as a build fix (maintainers Cc'ed).

One week passed, some PR got merged, I'm surprised the mainstream CI
isn't blocked by this issue... Ah, the cache is being hit:
https://gitlab.com/qemu-project/qemu/-/jobs/12556022118

2025-12-29 01:26:43,960 - qemu-test - DEBUG - Using cached asset 
/builds/qemu-project/qemu/functional-cache/download/b84819317cb3dc762895ad507705978ef000bfc77c50c33a63bdd37921db0dbc 
for 
https://github.com/legoater/qemu-aspeed-boot/raw/refs/heads/master/images/gb200nvl-obmc/obmc-phosphor-image-gb200nvl-obmc-20250702182348.static.mtd.xz

=> Non reproducible builds. Acceptable?

OK I'm not going to hold my pull request any further and just post
it ignoring the build issue.

Regards,

Phil.

