Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F027FCAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 21:54:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v44js-0000QL-AV; Wed, 01 Oct 2025 17:51:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v44jm-0000Pc-PP
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 17:51:51 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v44jW-0005Ug-KI
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 17:51:48 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3ee1221ceaaso176118f8f.3
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 14:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759355485; x=1759960285; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1Ur4mhRNtXG8Powdkfb/SpSMh0Nhqn2yaLbXpJbeZDI=;
 b=TCCH/fhjmzAzv3nlc2BhDKBLvCLFzjLe8pJOa9fSHtOL7a/EIcxE4B4wRcYgHC9a7o
 5ws79hrJTP5IzaijhML1ZGBsCYPAsWKESjicLGv0OKBpCocKNCD02jcT4diOYUwyeJOJ
 cOePi+namJq8sncJfpssKVNb163YN2bsinJvzIg68Fwz1GQaV59fKGGqWKvE4zyyYNrc
 /osc63uvDgUDcmzk1AsYFABgJASdNAZDy/5rKVakkPBR++DlZhiCzsYNZdOg5lLXDWvO
 KW754F/9o+37qo+AcwsCB030837ikiOW49Wp7zdDc+kSeEUtVg7pf2bJeMXUkpbfLw22
 sWJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759355485; x=1759960285;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1Ur4mhRNtXG8Powdkfb/SpSMh0Nhqn2yaLbXpJbeZDI=;
 b=CY6VfCPQA0euCQGGdm/sLHn68HL2U/N0X5w202ntxm10N7fa+GB7Vtr3iELYAyKgnY
 fSFF9h763K4VV/DfgtMhr9AB3cyIq3pbdVJdd/2MSezAcY5GY0+iaqDfguc+5Yg7GWAU
 eDA+BYQWQflo91wzCSqsqFcKHyxss1MSFVtnL9Y0P2KNXPZizksON1fty9Dfvc3UcD5J
 qof6OAUid0AQWpRFc1IESmSYHWdJOP7ADQlns4jP4nDacyZdGDVOhJVzmG/3Nzc3YcqM
 SnUmgvRuS4v+BtEko5GXmXbuNCstnmOnF2QGvNU4Wzxa974JYt0jkLftO0J2R3MoX6BZ
 LzXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSAiGpBEYcrKty1n7DdgRnCHTVq+hHgAZ7XaRXzj9GsFwZRHzdSjFZQ5mE7CfVpWoGEVeGElaOwrZ0@nongnu.org
X-Gm-Message-State: AOJu0YwLPzJtPcRDjsNwKFwB5/YWDOsLuaa/qHIHkZdXQI5xtkEVEW++
 SywaDMDBkwOz7W3hVPI2X9/CDsi/yLabGAzRkek6ikQW69eDH4NxQcYFiuYT36vpEjo=
X-Gm-Gg: ASbGncs6vBVGk2SgQb90S4ZE9JxY40OrdbpbMHNE+vR2gbNo0vubwhrJGpjkJngTo9o
 VPGY5U8OY6ybg4wPRvvmuZNWSDs6c+0yH18umth1RmMyc6tqm1ntAl35sxSFVZT52lWo53zN+Xm
 08mOCvo5tKitOnw2dsNA0CZ0RWypneWB2h5sSIQHGGvlOjL7y/f2usnURwK8+dmxysfOBMh0J50
 7Go2mf6WtsuDyu3/b10Tuamfi6XKCJxelf9+LBFZzlYyaSfxPHK7XvqKV74IX1Qn5r3b5f5u4L/
 MFSYolgcZ3WVxtQsxxbVg70ioF1AE6OzZ76KQNyGPrKc0rco35IIAC+zdgixxfhAYro6yMQ/1ze
 y+2HEhK5bORjQYgLmhGYexsre06p6/wjKXZ8WoPfrVMmqiMQ=
X-Google-Smtp-Source: AGHT+IHIJnCpMDYRNa3Homtuufr4MvWIMp9SG7sA9UQGXUwCyPgE/UHgzyVcjIm5Dwh50mr1WznPOQ==
X-Received: by 2002:a05:6000:2002:b0:415:7a6c:6a38 with SMTP id
 ffacd0b85a97d-42557821a1bmr3763742f8f.59.1759355484862; 
 Wed, 01 Oct 2025 14:51:24 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8e97fbsm752151f8f.34.2025.10.01.14.51.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Oct 2025 14:51:24 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3B6735F7A7;
 Wed, 01 Oct 2025 22:51:22 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org,  Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,  Philippe =?utf-8?Q?Mathieu-?=
 =?utf-8?Q?Daud=C3=A9?=
 <philmd@linaro.org>,  Thomas Huth <thuth@redhat.com>,  qemu-arm@nongnu.org
Subject: Re: [PATCH 0/7] testing and misc updates (docker, ansible, .git*,
 gitlab)
In-Reply-To: <1a86ebf2-161e-975c-1808-d8d960c4f7e6@eik.bme.hu> (BALATON
 Zoltan's message of "Wed, 1 Oct 2025 21:31:05 +0200 (CEST)")
References: <20251001170947.2769296-1-alex.bennee@linaro.org>
 <4188260c-e8ac-9bea-5e05-6cd34c3e986d@eik.bme.hu>
 <aN102hEBf6vny20l@redhat.com>
 <1a86ebf2-161e-975c-1808-d8d960c4f7e6@eik.bme.hu>
User-Agent: mu4e 1.12.14-dev1; emacs 30.1
Date: Wed, 01 Oct 2025 22:51:22 +0100
Message-ID: <873482i945.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

BALATON Zoltan <balaton@eik.bme.hu> writes:

> On Wed, 1 Oct 2025, Daniel P. Berrang=C3=A9 wrote:
>> On Wed, Oct 01, 2025 at 07:56:21PM +0200, BALATON Zoltan wrote:
>>> On Wed, 1 Oct 2025, Alex Benn=C3=A9e wrote:
>>>> My first set of patches for the development tree. Should be mostly
>>>> self-explanatory. We still need to apply the upstream COPYING patch
>>>> the u-boot-sam460ex code but we should decide if its worth mirroring
>>>> or should we just treat the copy as fully "ours".
>>>
>>> Which COPYING patch do you refer to? I have the upstream because when I
>>> submitted this I was told to do it this way instead of adding the u-boot
>>> sources to the QEMU tree. It can't be merged with the official u-boot u=
sed
>>> for e500 because it has sam460ex specific patches from the machine vend=
or
>>> which only supports this u-boot version. There are some updates from the
>>> vendor for real machine which I plan to add eventually but it's still b=
ased
>>> on an older u-boot version. With mirroring I can update upstream and se=
nd
>>> one patch to update the binary once it's mirrored, otherwise I'd need to
>>> send patches for each update and rely on somebody to merge them.
>>
>> I opened this:
>>
>>  https://gitlab.com/qemu-project/u-boot-sam460ex/-/merge_requests/1
>>
>> but then learnt u-boot-sam460ex is actually a mirror of your github
>> repo, and haven't got around to opening a new MR for your repo.
>>
>> If you can pull the commits from that MR that'd be great, or I can
>> open a new MR, as you prefer.
>
> I can get the patches from the gitlab pull request above and apply
> them the my github repo, no need to send a pull request there. I just
> don't get notified about what happens on gitlab so I have not seen
> this.
>
> I'm not sure what Alex Benn=C3=A9e refers to as fixing up the mirror. Is =
it
> not mirroring now?

It was mirroring from github.com/qemu/u-boot-sam460ex - I thought I
might have to re-create it to get it to mirror from the right place but
it looks like you can tweak it in the config.
>
> Regards,
> BALATON Zoltan
>
>> With regards,
>> Daniel
>>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

