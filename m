Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D830AC531DC
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 07:31:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1serPh-0007TD-4P; Fri, 16 Aug 2024 03:30:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1serPe-0007LW-T5
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 03:30:19 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1serPc-0005DJ-FE
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 03:30:18 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2d3bc043e81so1259453a91.2
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2024 00:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1723793415; x=1724398215;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9D4xG+r+4PMx3BVbBD/GW9ey5w78mYgZ2hIBJnOx0oA=;
 b=zwBTGJV6KJz9TXAoOQCf4TTPVLKpM00yRo7L1u+QW2nHZKOqk6P1PHFE1zgENYokWD
 SWL0qy+KWhNtXDJ2VTy81t2jguDRBngg3RCBt5oiGH+qNpMdl0q2HD0iP8wLp1+b4p9R
 9M9FmvdMau/OZM//WGOba8bqnoc9qIiJrxkTmKGjSkBeg2SC2PXgUokP+eajc9zVc2Cx
 DH2cV9bW3diO/59y5y/ncmu2QH5tbRiMddpQSzCEI6xVxuLEfTTPd73VZtAK3eC+SqzQ
 umGOrftTlBrXVIZ2rH+An12NaAoxtW57cYjqrf4Z2TVABwOqhrwL+QnXwP0IAPwiZts9
 dJ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723793415; x=1724398215;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9D4xG+r+4PMx3BVbBD/GW9ey5w78mYgZ2hIBJnOx0oA=;
 b=f3TbYcp/JxWDWTf5gqx6hPp1csKbG4xOFmXTyB+Mn3lPKMrXJLV+Dqa7CrmtT6O0K8
 krV1L6Pzpc6ilHZw0qDuqsJzbfRK6um+sP/MqXH/F5XLwsvFeYo817srwfjDSvnXrpQj
 fJIq/dGrw/OozVC5GiBOJX/iUyq9KFw70d/VXeQQXbXqYCogJI/ZLQ/1m8rCamCQYpQv
 mI59UuB5Hl43H3Kl5I8mJNX/GSfr209SdSQPXrBqDbV98uZJCl/a2CstRI2yyxBkB5ze
 TMOVhkM2KmJLBjFDCZHRXpXAa3x3jdC4Uzzlr/685/ULe34VUPUsEOW2stGktdqq+Hn3
 GL7g==
X-Gm-Message-State: AOJu0Yy90KZtD9MP0tz7F7J6Qaca9nFXr9upB07YwiLLO9smi19+tlIa
 /xMEDf+IwJtagR1W6zcEPosfhU1Nh/ysEMrk+4n8mjSvkyDNpYpRT29Z1MgNHY4=
X-Google-Smtp-Source: AGHT+IF0nUhhwwWhBgHOtYNtjn0oylybpdf1hgrvTi169v63sLfJjlF9gKdJZcx0jCC5FCpK3i+pkg==
X-Received: by 2002:a17:90b:4f85:b0:2d3:d7f4:8ace with SMTP id
 98e67ed59e1d1-2d3dfc2aca8mr2387903a91.8.1723793414776; 
 Fri, 16 Aug 2024 00:30:14 -0700 (PDT)
Received: from [157.82.207.214] ([157.82.207.214])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d3ac7f35a3sm4866483a91.25.2024.08.16.00.30.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Aug 2024 00:30:14 -0700 (PDT)
Message-ID: <6d1949bc-a0c2-487c-8b6c-21db12f6a0af@daynix.com>
Date: Fri, 16 Aug 2024 16:30:10 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] meson: Use -fno-sanitize=function when available
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20240816-function-v3-1-32ff225e550e@daynix.com>
 <3d417232-ba66-4781-8278-a6a31987b54c@redhat.com>
 <337e647e-3edf-475c-8e37-de3d28b30340@daynix.com>
 <bfd436ad-f76d-4bc3-b92f-cf9aaca9c7f5@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <bfd436ad-f76d-4bc3-b92f-cf9aaca9c7f5@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::102c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x102c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2024/08/16 16:27, Thomas Huth wrote:
> On 16/08/2024 09.12, Akihiko Odaki wrote:
>> On 2024/08/16 16:03, Thomas Huth wrote:
>>> On 16/08/2024 08.22, Akihiko Odaki wrote:
>>>> Commit 23ef50ae2d0c (".gitlab-ci.d/buildtest.yml: Use
>>>> -fno-sanitize=function in the clang-system job") adds
>>>> -fno-sanitize=function for the CI but doesn't add the flag in the
>>>> other context. Add it to meson.build for such. It is not removed from
>>>> .gitlab-ci.d/buildtest.yml because -fno-sanitize=function in 
>>>> meson.build
>>>> does not affect --extra-cflags due to argument ordering.
>>>>
>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>> ---
>>>> Changes in v3:
>>>> - I was not properly dropping the change of .gitlab-ci.d/buildtest.yml
>>>>    but only updated the message. v3 fixes this. (Thomas Huth)
>>>> - Link to v2: 
>>>> https://lore.kernel.org/r/20240729-function-v2-1-2401ab18b30b@daynix.com
>>>>
>>>> Changes in v2:
>>>> - Dropped the change of: .gitlab-ci.d/buildtest.yml
>>>> - Link to v1: 
>>>> https://lore.kernel.org/r/20240714-function-v1-1-cc2acb4171ba@daynix.com
>>>> ---
>>>>   meson.build | 1 +
>>>>   1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/meson.build b/meson.build
>>>> index 5613b62a4f42..a4169c572ba9 100644
>>>> --- a/meson.build
>>>> +++ b/meson.build
>>>> @@ -609,6 +609,7 @@ if host_os != 'openbsd' and \
>>>>   endif
>>>>   qemu_common_flags += cc.get_supported_arguments(hardening_flags)
>>>> +qemu_common_flags += 
>>>> cc.get_supported_arguments('-fno-sanitize=function')
>>>
>>> As I mentioned in my last mail: I think it would make sense to move 
>>> this at the end of the "if get_option('tsan')" block in meson.build, 
>>> since this apparently only fixes the use of "--enable-sanitizers", 
>>> and cannot fix the "--extra-cflags" that a user might have specified?
>>
>> Sorry, I missed it. It cannot fix --extra-cflags, but it should be 
>> able to fix compiler flags specified by compiler distributor.
> 
> Oh, you mean that there are distros that enable -fsanitize=function by 
> default? Can you name one? If so, I think that information should go 
> into the patch description...?

No, it is just a precaution.

Regards,
Akihiko Odaki

