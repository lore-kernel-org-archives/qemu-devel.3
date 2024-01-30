Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D87BFC47DDF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 11:57:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUmjw-0000wy-7z; Tue, 30 Jan 2024 06:57:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUmjt-0000wm-5n
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 06:57:17 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUmjk-0001TT-TK
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 06:57:12 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-55eed368b0bso4114284a12.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 03:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706615825; x=1707220625; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iyrmL3Ee8X9twzNGEQu2P2TXFvFP1GT9jYDzL4oZp5c=;
 b=V++nF4ovdBWSjcgjIpqnUXqDUF27tzu9Qa46fpNUrIJu/B7AJjmw9A/oWVDjdY953K
 A0VJgMoeJ4eDv8ZQ3VHAAEJ4Xm1AHQ8sBckhIbNzj4VXzuwnj3A6i3foz21Fg0ryqoPL
 90AIpN/48B8sFPYvTAZ++eh+GQdWK3+BZy859XP8C3yU6vBNeFUO2ynUgN2xuSgCAo+R
 4ipIkq51yzSNh8fk/o6Hy80lrmovkcDkTeQmAvdujMXvYPshoejr79BeEm+DASXFdxMI
 GkuYMUW+RZCnqwPhKVJSXihe4QKceyqUV24jcK03JhPKlpWNF49P8JZE2lkEclag4wru
 bO3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706615825; x=1707220625;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iyrmL3Ee8X9twzNGEQu2P2TXFvFP1GT9jYDzL4oZp5c=;
 b=Wa4bVDhjnc0DFDD2np2qNWnKt7jn2gR5eczHosEKqmAUlNIhE7sZSYiN5NIZuqoN63
 /j1G/oab85637WfhBN9fKiaAKJ4i8pBAln9vUi5Cp2x//VsKMmxEa0wc3WXLDACo3X5h
 JgoNsxSUUXJP4i7lUN1wvYuFOEcDjxtTngeuNcMfwlHFs3LcCGMmJWrq0rsgxt2c2BI0
 OoDy+Vzp+tn/RRaE2H5ibnmwrsEd2vtmUrlDd7lp07irrmRhkqs9S4NCFMjJwWumrxyJ
 HHUqrJuiWvrxnb9hw/clzXB9+XbQQ4JYftxmWMp3Hn6SvbeWSzUYN+9MxcMbY5d2sozk
 +EXg==
X-Gm-Message-State: AOJu0YwIaErBebPw+UAy7C+l31bULhomD6+9YEpRtZwoIu1xwOc7+Idx
 12HSiKFOo4nCVYh0xH/k29uTp8e9kvrFJnoaHp1BwdM44OGuzrpYYZSs+D55EpU=
X-Google-Smtp-Source: AGHT+IGkPdrYJgps/y+Df9aOpS58sbAtArMIO270NmH5dHVkSgcbANau2WLAmnrVVpGzNEAt7lhWCw==
X-Received: by 2002:a05:6402:2073:b0:55e:b30d:d845 with SMTP id
 bd19-20020a056402207300b0055eb30dd845mr1159857edb.17.1706615825215; 
 Tue, 30 Jan 2024 03:57:05 -0800 (PST)
Received: from [192.168.69.100] ([176.187.218.134])
 by smtp.gmail.com with ESMTPSA id
 s4-20020a056402014400b0055f4558c602sm475390edu.67.2024.01.30.03.57.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jan 2024 03:57:04 -0800 (PST)
Message-ID: <f9e9af2e-260c-4ac6-8ecd-65c636edb277@linaro.org>
Date: Tue, 30 Jan 2024 12:57:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] scripts/checkpatch.pl: check for placeholders in cover
 letter patches
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
References: <20240130101107.214872-1-manos.pitsidianakis@linaro.org>
 <CAFEAcA8P-8rRRQJLEFzwVJiKqdd-cu5DgiBdxBXYhq=2Oov9Fg@mail.gmail.com>
 <CAAjaMXYbm4ANhMEXOc35mJkq7Zr+A_vz8wBY+tPv4rk=dCQEaA@mail.gmail.com>
 <CAFEAcA_XX07ND82_ZrokBhVDbTot16_SNJNQDQeNnBvRZ4MHkw@mail.gmail.com>
 <CAAjaMXZsAHQYSotdn0f_3iao=sW3XRiA5iMQO1MMFnVj0cft_w@mail.gmail.com>
 <CAFEAcA-qa729wTz99fW6ur+FYjkmUjTkjd8eG_dNo7fSzYh_rw@mail.gmail.com>
 <CAAjaMXZYLCaXK5otq9iC=-D4RrjkcLDrgjhWhWnJDqwJwwfWhw@mail.gmail.com>
 <a353c5db-4583-4662-bf28-4332d51e9d30@linaro.org>
 <CAFEAcA907EzOaPEhs_ZTpmBZeCHiY2n6ncgzbixhcK4VMnQ30g@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA907EzOaPEhs_ZTpmBZeCHiY2n6ncgzbixhcK4VMnQ30g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 30/1/24 12:30, Peter Maydell wrote:
> On Tue, 30 Jan 2024 at 11:24, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> Hi Manos,
>>
>> On 30/1/24 12:02, Manos Pitsidianakis wrote:
>>> On Tue, 30 Jan 2024 at 12:57, Peter Maydell <peter.maydell@linaro.org> wrote:
>>>>
>>>> On Tue, 30 Jan 2024 at 10:51, Manos Pitsidianakis
>>>> <manos.pitsidianakis@linaro.org> wrote:
>>>>>
>>>>> On Tue, 30 Jan 2024 at 12:42, Peter Maydell <peter.maydell@linaro.org> wrote:
>>>>>>
>>>>>> On Tue, 30 Jan 2024 at 10:39, Manos Pitsidianakis
>>>>>> <manos.pitsidianakis@linaro.org> wrote:
>>>>>>>
>>>>>>> On Tue, 30 Jan 2024 at 12:34, Peter Maydell <peter.maydell@linaro.org> wrote:
>>>>>>>>
>>>>>>>> On Tue, 30 Jan 2024 at 10:11, Manos Pitsidianakis
>>>>>>>> <manos.pitsidianakis@linaro.org> wrote:
>>>>>>>>>
>>>>>>>>> Check if a file argument is a cover letter patch produced by
>>>>>>>>> git-format-patch --cover-letter; It is initialized with subject suffix "
>>>>>>>>> *** SUBJECT HERE ***" and body prefix " *** BLURB HERE ***". If they
>>>>>>>>> exist, warn the user.
>>>>>>>>
>>>>>>>> FWIW, as far as I can see from my email archive, this particular
>>>>>>>> mistake has been made by contributors to qemu-devel perhaps
>>>>>>>> half a dozen times at most in the last decade...
>>>>>>>>
>>>>>>>> thanks
>>>>>>>> -- PMM
>>>>>>>
>>>>>>> Peter, searching for `b:"BLURB HERE"` in lore.kernel.org yields about
>>>>>>> 170 results including these patches.
>>>>>>>
>>>>>>> https://lore.kernel.org/qemu-devel/?q=b%3A%22BLURB+HERE%22
>>
>> This comment is the default --blurb-template from git-publish:
>> https://github.com/stefanha/git-publish/blob/master/git-publish#L742
>> As the tool is also used to post patches to other projects, I'd
>> recommend fixing it there at the source.
> 
> It's also in the general 'git format-patch' cover letter template,
> where the workflow is supposed to be "produce cover letter template,
> manually edit it, send it". Stray template markers generally are
> the result of (a) a new contributor not knowing about the 'edit'
> step or (b) remembering to add the subject and blurb but forgetting
> to delete the 'blurb' template line so it gets left in at the
> bottom of the cover letter. So I think it is a check that is within
> checkpatch.pl's remit.

Oh, it is so long since the last time I used git-format-patch
manually that I thought this template was a git-publish feature :)

