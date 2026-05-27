Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 313A7CD5BD0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 18:13:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSIkH-0001dq-Ox; Wed, 27 May 2026 14:12:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wSIjy-0001aJ-Je
 for qemu-devel@nongnu.org; Wed, 27 May 2026 14:12:27 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wSIjs-0008F5-JE
 for qemu-devel@nongnu.org; Wed, 27 May 2026 14:12:25 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-36974217d4eso7932230a91.2
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 11:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779905537; x=1780510337; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Yjc4zRVTqjvfw3B2vmefcl+mtHeKUz7dIGmVTZ9WeIQ=;
 b=tgY+DcuK9QF6d7k4OTYAAQ3OgLrlS7dhc8pemjFRS+uyapzuBTZw30tceaKS3Pa4UU
 xc72xui/JOh66x1RQfNDalDprShPl/W0MwXMqYCBBmZW4qaq7tJeGFTNESdV8JUjzIXY
 KLg/W6QhYTGTlNnP2bn5XbDVNbzIMeopGksATG1UtRPjegX+jYsS+mdi/oJ7bwodrHBE
 hrhDd4JN7Y98q9f8w2cazwZUvc4cIH3GGL73qymGJH+FMQOdQqQyNvzUS+7c6+pYDFMF
 c3bJKvt+MU0VQ34jnfbskF12RQ0xYFtR8NqxrHHZ8l2UitXhEjGcFPg3/ybWGkn0RF6e
 VC2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779905537; x=1780510337;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Yjc4zRVTqjvfw3B2vmefcl+mtHeKUz7dIGmVTZ9WeIQ=;
 b=ZQQx2zqWcfv13QeAt6om1Tbhwxphh9yv5J5QWx8BWC0+pbeTN82988y2SdrmkKqmXE
 Wy5v4UBYXavdSmEuGUfvvBcMlF6hbD+QlM+cxzaImXEATDDtqwEKp4irNXV2wTEhdrVH
 k8Jf8PtSy9xHd0oYnFX0uUOlVf7L6Xg4n7tDBp7AVqC/ZYBAQNL476PAhiUmWAxMb1Ky
 sUvNbhkK9WrEVBdrkRKdLPMvdxY1y4DAwwA5s4Olg6afrdDE9iW5SdizvPlJdxr262pt
 Vf7EtqADTMO08LjojvrMye7T8vbW7ZxfGoLtA2iKN1Yu2ahV8JFwKx03Wdd+mXm3qmrQ
 W4bA==
X-Gm-Message-State: AOJu0Yw+AQF8IrMvXrW+cS3UrQmRTgbY7f32ABB15RuF54Bx0t7INujX
 mpurtzRaGAD7Oo0MgfcCEyHqNrAsW6Yby65VSEU7vvw/O8U/znh3z6KsWxr34/CoTrE=
X-Gm-Gg: Acq92OHpKMEvbnosaKMPK4V+JH93b/prefamNsLg5/nr7/IeUawnGStlfOl1d84DV84
 o2SRnsAKOv0JeL5h/y+b/GxXrm9K/BW2lJmGOm/DIbqIDRodN5xEFTEiRk32ccPATNJkAO01nBD
 ZQVx6H2Ohb64vPs+DuMzgxdQVW/Ky7AhLBIGW/rqmj+pd4CpTkiwhTzozmKnXnJpwkzQY1s0jr6
 dA345k3v/sQvxU5hkc+z4s6xHu6HPFlG7G4D2fvtRb3s2hogyQ3U2KKu6jQFJQ1kaC+YZlICnBK
 k7Pqgct7N3F/hQpNCWmB4Vk28H3W5k0pG3C2aTKnI4voTS7wJDcyKYXLnIQLjfuQDIToQPHehsy
 p9rPt26Zo85o4+LbJpzuZQuL3otg2LEKR1T6LLHFhvdtK392uY/7GZXzoHFQxutE91w0Of6AA1F
 5lflLX/FIGFNUJ/rK+uR8hC8W7YIzhf/yyTIYw8lRQ22Z1uBI=
X-Received: by 2002:a17:90b:2e86:b0:369:e217:d110 with SMTP id
 98e67ed59e1d1-36a678b86a9mr22554745a91.27.1779905536636; 
 Wed, 27 May 2026 11:12:16 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a723dfa2dsm15937295a91.16.2026.05.27.11.12.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 May 2026 11:12:15 -0700 (PDT)
Message-ID: <0a61c0ac-1147-4983-8d60-8fec0ef8025a@linaro.org>
Date: Wed, 27 May 2026 11:12:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: Fix loading static ARM cortex-m55 binaries
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20260525230308.137009-1-deller@kernel.org>
 <00cbde94-39fa-44d3-9db0-1ddafd66656c@linaro.org>
 <CAFEAcA-h20EQWNyWrQxX=WVMuT=kj-XzunuwE6bqyw_ivtw-AQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <CAFEAcA-h20EQWNyWrQxX=WVMuT=kj-XzunuwE6bqyw_ivtw-AQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
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

On 5/27/26 09:40, Peter Maydell wrote:
> On Wed, 27 May 2026 at 16:42, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> On 5/25/26 16:03, Helge Deller wrote:
>>> From: Helge Deller <deller@gmx.de>
>>>
>>> Static built ARM binaries for Cortex-m55 may have been linked to have
>>> their load address at address 0.
>>
>> This is a problem.  We also use 0 for "unassigned" a-la ET_DYN.
>>
>> Perhaps ideally we'd pass around a separate flag for ET_EXEC vs ET_DYN, but ET_EXEC with 0
>> is not a valid binary precisely because it attempts to map at the zero page.
>>
>> Honestly, I think this is user error.  While we support some m-profile binaries in
>> linux-user mode which the Linux kernel does not, for the explicit benefit of the GCC
>> testsuite, there are limits.
> 
> But if the user explicitly passes a guest-base address on their
> QEMU command line, we run the binary happily. If we refused
> to run the binary at all that would be one thing (and not
> unreasonable, as you say). But it does seem to me like a
> problem in our "pick a guest-base" logic that we fail to
> identify one that would work fine for this particular binary.

Then we need to do the work to track PIE separately, without overloading 0.


r~

