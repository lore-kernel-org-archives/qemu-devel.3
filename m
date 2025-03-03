Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49902C282CD
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 17:33:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp9fC-00016m-EP; Mon, 03 Mar 2025 12:33:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tp9f1-00016O-Dx
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 12:32:59 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tp9eu-00053U-3n
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 12:32:58 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43bbb440520so16057535e9.2
 for <qemu-devel@nongnu.org>; Mon, 03 Mar 2025 09:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741023168; x=1741627968; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sP6Fmz9at94Oqru6d05T0A/TLrybV4AA0+aTVojORWw=;
 b=e++rDvK99m2+r42yttFuUQ3fp/3Nfog2SoQNrvNV/ZNrBx6i22ZQ6x9t69L9Cj/wB7
 o9nt8X95JN+W0lSyzrBcPY8jLqrrJDweIUvNOLVqmbML1Nq7mIhMv6quexHToVyrVsr6
 NtD6J4vFdDxakKd8MVFAeLdjNw5E/5++bPeLW2QjdjmTufcni37RZ8+GnV6HotW2XACs
 jWCSGhwIC53hj6mSDAH+mffazODow7vbonlw1nwFgQIOsgS7lgu0jDKdq7jYVVwq305p
 yQsI1WdadN7NTQhrylPy8rtcXJx0FGV3CkuMWo0ogf9SExKt2hDi/BmjvKdfBViGLhZg
 19PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741023168; x=1741627968;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sP6Fmz9at94Oqru6d05T0A/TLrybV4AA0+aTVojORWw=;
 b=GVjXEI+tQbkgoWdFTROClcA58dIHGTAZqf0w2WuKzY4zBgSpFpZ3RcANwQEUSoXQ3L
 UPkLR2eCq1duEgAPnneovI/FXByJ7gCnVeoXHPScZTPoEs7LHhbLa0fCw8JND4cUT47Z
 Rn3IdtG22O9mOuVc/vhVxw20kINr+1IYMrk+rit6eIFC0mMpOITPCiHVI0XJUT1/AkLf
 nDTgMSpdMJY9d495LUt7PJ2dncvI7zZZqRWvSitHVOxmnb7v3ckvwg3VqVgHYDppf6Wa
 9BKN4TkTUComlrvEUMLKKRMeZYopoMQfSWYau0Yd9fFr9rS0G/QXl6FMJEzvZdG03X+c
 nd1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/RuSEX0fId1+J1QZjKnCJum8rYytvfSt2fB4rmbJD22lGNby2/mr6JWg/QoHtZpaZLFD33yv9FxB6@nongnu.org
X-Gm-Message-State: AOJu0YzEbwWglUzTEGj2urbTOcL/U/0RGRIPyBvCmbh4gz0AuCCdztrU
 NY98O6G/GXDjSOeYzckHbdJ13hzCEXrrXHtmpzwBjjKMOGL5N54iMXrdWoC46bQ=
X-Gm-Gg: ASbGncuojYoKEKU3Wx4FTx36L/peLykRMMJsorIABbUOZa0r2fE4QYbIrkOWtQ4Nm9L
 yJIM9nK7TriyJOZvqcoxwBT1sH+tybspI/0NLSOXJaEHWqpp3HHIdp9UBYo5mxM/4rkj/FZG7wj
 dW9K/5D8Np/OoqU88Qt5bblPqckRoBK9eoq7E0ME8Nj+TimQo0P6w1q6dnoEvQwBACPEnAI8oaK
 +S353/xAEmuIuzPs48YI7S4qTtNq3n4e5Gsro9unP4G2u3PbX876chsWAJIzN4UWHefQz4nFQNu
 pA6eHu0waqAtgVwcS8rWQx5hcw5Lr59C4LUHriDOG9SqZiZN+LdVw96w0C8zmUSOA9p5DdjX0Ak
 VC+4/uzvnuqm8
X-Google-Smtp-Source: AGHT+IHT2EzOWYceNeEG+mz8xuI8YB05eTv2iPa5pWqBo1i7CRnZ66qrsA0OpYS5p6w6kT26USiS6w==
X-Received: by 2002:a05:6000:4021:b0:391:a74:d7d7 with SMTP id
 ffacd0b85a97d-3910a74d8e6mr5211285f8f.8.1741023168261; 
 Mon, 03 Mar 2025 09:32:48 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e4796051sm15377461f8f.12.2025.03.03.09.32.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Mar 2025 09:32:47 -0800 (PST)
Message-ID: <2ccd4a87-68f3-4eb1-bc2a-dbc424bc8d34@linaro.org>
Date: Mon, 3 Mar 2025 18:32:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] vfio: Make vfio-pci available on 64-bit host
 platforms only
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Paolo Bonzini <pbonzini@redhat.com>, 
 qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Eric Auger <eric.auger@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250226084721.232703-1-clg@redhat.com>
 <20250226084721.232703-2-clg@redhat.com>
 <a39e97c2-c6fd-34e4-f91b-b3491185b789@eik.bme.hu>
 <c60b7780-5b3f-43a0-a7f1-30820d4e6fb8@redhat.com>
 <bb7c2adf-f146-50c7-7716-c1ee7b606b01@eik.bme.hu>
 <aa01f3dd-e3ac-4ee5-87b4-8133103bd000@linaro.org>
 <270cc189-e3b2-4bf4-b32b-8655be51bcb4@redhat.com>
 <b2075e91-79ca-4d5f-b13b-151f2a59181d@redhat.com>
 <8e3a5810-accf-1f77-8692-4e077c3ce327@eik.bme.hu>
 <b0b56480-0b5a-4f32-af27-13394795b58e@redhat.com>
 <CAFEAcA8FRyuuPxZQhLM8Jq4iD6TEMqN+E=iTNfNOeafTzTBeNg@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA8FRyuuPxZQhLM8Jq4iD6TEMqN+E=iTNfNOeafTzTBeNg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 3/3/25 17:57, Peter Maydell wrote:
> On Mon, 3 Mar 2025 at 15:49, Cédric Le Goater <clg@redhat.com> wrote:
>> Why are we keeping qemu-system-ppc and qemu-system-i386, and arm,
>> since qemu-system-ppc64 and qemu-system-x86_64 should be able to
>> run the same machines ?
> 
> They're not identical -- for example "-cpu max" on
> qemu-system-arm is a 32-bit CPU but on qemu-system-aarch64
> it is a 64-bit CPU.
> 
> There's definitely a lot of overlap but we can't just drop
> the -arm executable until/unless we figure out what to do
> about the corner cases where they are different. Plus there's
> a lot of users out there with existing command lines and
> configs that assume the existence of a qemu-system-arm
> executable.

Thomas and myself have been trying to sort that out. Now with the
single-binary effort, it gained new interest. This hasn't be a trivial
task so far, due to as you mentioned the legacy CLI uses and migration.

This is however in my priority list and Alex asked to have a single
qemu-system-aarch64 binary for ARM/Aarch64 for the 11.0 release.

