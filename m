Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DECF2D2E010
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 03:39:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3SDf-0005bo-0g; Tue, 22 Oct 2024 23:39:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t3SDd-0005bf-Hz
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 23:39:33 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t3SDb-0000Oy-Jb
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 23:39:33 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-539e63c8678so7666463e87.0
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 20:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729654769; x=1730259569; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=coxadzSGY7dDOklSM2+vwyj+QajFVN0GwZwnAfDskDg=;
 b=bkQJWjW6KwUvrrBSD8n4qhuV/vkqupPns5Z7kew+H7nqQmXMFAnXS+OWCcmiZiJESb
 1EkMJlc9KkaH/s8L/B0oaQsGEB0Atfn1PSbGNNRf+zZByWAcjB59x6TUc9sD+5XK1uGO
 j6vbzYHCUe6itPwRlqUNdHWVjrOmfYOrA1H912Euk6iu2VJavaY8CoCst4WanPcz3Unh
 FKcprYqGRMcbuDcWYQjh0a2+a9HtO6rbrlDPy5bCaAijdwExnU29PShlz6TUvFdWaII7
 WR0b6seXX4e580iPhg+T2+I4rVZ0239JTjpXTpis95/uu+hzMIzU1lcMBdg5N53/nO3n
 whbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729654769; x=1730259569;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=coxadzSGY7dDOklSM2+vwyj+QajFVN0GwZwnAfDskDg=;
 b=pqBsGDzSxcI+4HChcJHkASW87C05R0Fj1ClTd0ehPJg9mfCEcB6V3xMP6QpwlMEwBv
 pENVe1HZ2CXZsSBT3Rc0AhxMompQIdyza92rkGIHsKcQ8wCV/+sgrLuYEGRxUbgq0l2I
 tuoT2ieFFDAfJE1a0zEnCqlGc1TDUhYp6nXhVhMskKofi2WAeDiKTxCn4+BCUCKk7S0l
 9DuT4cZw9p3mUboJcd910/TrS8TSWsTSo6JRBr/p3Idz2pt/3tuQNF5++9acfC5brW0b
 q/9RFOzlaotLfMBCRzM8KUb/uygSc5fmowOwQM7kHmznS34JCZEEAuOLgmNjGjf3AE0f
 hsCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTwwLDONTFZ+nwijnijIE43rCnJ2rjJRDIV16IVwrzIFIJxqNNm079T1X7uAzu2gr7T3B1YMIRRIwW@nongnu.org
X-Gm-Message-State: AOJu0YyCwA11MNjRJDbwcaHPu2y0jkAwdxXSmfOmj8g0W7GglEYyGTmP
 SRAIuCZsyshx0OoldrhCzcvSpNh+vOXuPR6pPhxAI2ISjZ1pZijT4kNmvh+SX+0=
X-Google-Smtp-Source: AGHT+IG4b5ksSyhE4pjO4vxB51vos9/KuELx10DCOW9+1Nh8PR5goQ97WDDUiic8qo/e2ezIuGkEYw==
X-Received: by 2002:a05:6512:1583:b0:52e:9762:2ba4 with SMTP id
 2adb3069b0e04-53b1a315eeemr358488e87.25.1729654769070; 
 Tue, 22 Oct 2024 20:39:29 -0700 (PDT)
Received: from [192.168.122.226] ([91.223.100.209])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53a22431c1bsm949404e87.221.2024.10.22.20.39.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Oct 2024 20:39:27 -0700 (PDT)
Message-ID: <f011fa40-7d81-4eea-98a7-6546b9155ac2@linaro.org>
Date: Wed, 23 Oct 2024 00:39:10 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 20/24] audio: Add sndio backend
To: Alexandre Ratchov <alex@caoua.org>, Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Qiuhao Li <Qiuhao.Li@outlook.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi
 <stefanha@redhat.com>, Eric Blake <eblake@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>, Bandan Das <bsd@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, Akihiko Odaki <akihiko.odaki@gmail.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Brad Smith <brad@comstyle.com>,
 =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>
References: <20220927081912.180983-1-kraxel@redhat.com>
 <20220927081912.180983-21-kraxel@redhat.com>
 <fc493743-5ab0-49eb-98ed-dd260f0f60d6@linaro.org>
 <ZuBXqSoohgbS-rF6@redhat.com> <ZuBeYjju389c8MoI@vm1.arverb.com>
 <87frq42d4i.fsf@pond.sub.org> <ZxdrH5Prk2bC2fw5@vm1.arverb.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <ZxdrH5Prk2bC2fw5@vm1.arverb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x133.google.com
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

Hi Alexandre,

On 22/10/24 06:06, Alexandre Ratchov wrote:
> On Fri, Sep 13, 2024 at 10:04:29AM +0200, Markus Armbruster wrote:
>> Alexandre Ratchov <alex@caoua.org> writes:
>>
>>> On Tue, Sep 10, 2024 at 03:28:57PM +0100, Daniel P. Berrangé wrote:
>>>>>
>>>>> This is the single use of the ISC license in the more than 10k
>>>>> files in the repository. Just checking IIUC this document:
>>>>> https://www.gnu.org/licenses/quick-guide-gplv3.en.html
>>>>>
>>>>> ISC -> LGPLv2.1 -> GPLv2 -> GPLv3
>>>>>
>>>>> So ISC is compatible with GPLv2-or-later. Is that correct?
>>>>
>>>> ISC is a permissive license that's semantically pretty much equivalent
>>>> to either MIT or BSD 2 clause licenses and thus is broadly compatible
>>>> with most other licenses, including the various GPL variants/versions.
>>>>
>>>> None the less, since sndioaudio.c was a new file, it should have been
>>>> submitted using the GPLv2+, unless there was a reason it needed to
>>>> diverge and use ISC.
>>>>
>>>> An example justification for divering is if the new code is derived
>>>> from some non-QEMU source that was already ISC.
>>>>
>>>
>>> The ISC license is more permissive than GPLv2+ and compatible with it.
>>> The file uses this license for history reasons: initial versions of it
>>> used to be part of the OpenBSD ports repository, which uses ISC.
>>>
>>> If ISC is not appropriate for qemu, I agree to use GPLv2+ instead (I'm
>>> the author this file).
>>
>> Let's adjust the license then.  Alexandre, care to post the patch?
>>
> 
> Almost all audio backends (in the audio/ directory) have the same
> header with a copy of the MIT license. So here's a patch to make
> audiosndio.c also use this header. The "QEMU <insert_api_here> audio
> driver" comment was also missing, so I've added it as well.
> 
> OK? better suggestions?
> 
> diff --git a/audio/sndioaudio.c b/audio/sndioaudio.c
> index 8eb35e1e53..3922b73045 100644
> --- a/audio/sndioaudio.c
> +++ b/audio/sndioaudio.c
> @@ -1,7 +1,25 @@
>   /*
> - * SPDX-License-Identifier: ISC
> + * QEMU sndio audio driver
>    *
>    * Copyright (c) 2019 Alexandre Ratchov <alex@caoua.org>
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a copy
> + * of this software and associated documentation files (the "Software"), to deal
> + * in the Software without restriction, including without limitation the rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> + * THE SOFTWARE.

Thanks! We'll soon require a SPDX tag, see:
https://lore.kernel.org/qemu-devel/20241007154548.1144961-1-berrange@redhat.com/

The boilerplate license you used can be simplified as:

   SPDX-License-Identifier: MIT

Otherwise the change you suggested LGTM!

Regards,

Phil.

>    */
>   
>   /*


