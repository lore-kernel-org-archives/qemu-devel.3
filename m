Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 844BFC46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 11:25:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUmEC-0001xC-L1; Tue, 30 Jan 2024 06:24:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUmEB-0001wx-Jr
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 06:24:31 -0500
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUmE9-0003zD-Re
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 06:24:31 -0500
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a359e6fde44so259179566b.3
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 03:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706613867; x=1707218667; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HzFDrGjAkmWTH4L7Sx9Y36q/2WmG83JHBSfck2QHyFg=;
 b=zCsz/e/Olo3ey6lp7LglHBqdMTwMFXqKL28U+ymJMnndlw2z4xeX0Mqhjtx1ZbdaEb
 /Bz9yCSyJDmLVKMhehQQF7viWyN5b78a2qJvjKnCXq/O9UJtc2kkvWeWFTttylJsaeLT
 bX4clbBDEl/YkjQW9D+sW+oxeWoa7GjKiU6tC4UrJc7OPn3PTZnGBPYS1K7QRDiDZah4
 JkOGbJZjRGrkd64EEazWK08ruOoMP7Cbc/domdkWv54SEl++lYa/HsgD4NtJ/qwr1EOE
 vVNnixoHlj2cfQsUt/aNZ3K1zDnCA/CNg163kvpLYmDNTPle0Bw6F3DvIJ3YWcj9ZYFI
 cFZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706613867; x=1707218667;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HzFDrGjAkmWTH4L7Sx9Y36q/2WmG83JHBSfck2QHyFg=;
 b=mDkwPyIAvcQciGWpHmFk9yrQAisUga0m2mDxCLNvR0vhawo6N6/EPOBbPZHd5sBCuT
 rZbHxgD0dE5sNpc/VHGheVhC7gFekKJtrPnnEfSquMPLWyToXNTcFPfKeBCn0timnNx8
 4LvWszov3wpMr0l3Mdwj/3VQt8rq4B3C41j4dEu1uP8fGPNTfEbRssa0Se61WwTglACB
 vsn82VxnhCsl8wAlKh8+OcN+6ZsBSIEddN/SiTUI7wTw8JACHEqktgjaszE6V8TY8PO1
 SmwTDPe/Bt9Pp18J+FFd206wpc2s6CYJe0I4iJ+ufQ7dKRkHxQs3AnSOGVyhBTeiv8jO
 r0QQ==
X-Gm-Message-State: AOJu0YxghPzplZjJmz35NLmtiyXNHNlVD1stWDP9YXoZ+yaOILKOdPId
 yc1s9ObNVbfev4NQ3Ml1D/0Ou1LXdzv4khZu3uMTP/HgPhrHD10sn6w3Ipzt6yk=
X-Google-Smtp-Source: AGHT+IGjh5R688mu/fGIvhBeuabgFNpZoNRBqpRHIWhN4ya/6JCZtjyi4HeGVp+vDGLuHjaTCeHrgA==
X-Received: by 2002:a17:906:1453:b0:a31:8320:cebc with SMTP id
 q19-20020a170906145300b00a318320cebcmr6922407ejc.54.1706613867612; 
 Tue, 30 Jan 2024 03:24:27 -0800 (PST)
Received: from [192.168.69.100] ([176.187.218.134])
 by smtp.gmail.com with ESMTPSA id
 j17-20020a170906279100b00a3644862078sm96032ejc.156.2024.01.30.03.24.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jan 2024 03:24:27 -0800 (PST)
Message-ID: <a353c5db-4583-4662-bf28-4332d51e9d30@linaro.org>
Date: Tue, 30 Jan 2024 12:24:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] scripts/checkpatch.pl: check for placeholders in cover
 letter patches
Content-Language: en-US
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
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
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAAjaMXZYLCaXK5otq9iC=-D4RrjkcLDrgjhWhWnJDqwJwwfWhw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x629.google.com
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

Hi Manos,

On 30/1/24 12:02, Manos Pitsidianakis wrote:
> On Tue, 30 Jan 2024 at 12:57, Peter Maydell <peter.maydell@linaro.org> wrote:
>>
>> On Tue, 30 Jan 2024 at 10:51, Manos Pitsidianakis
>> <manos.pitsidianakis@linaro.org> wrote:
>>>
>>> On Tue, 30 Jan 2024 at 12:42, Peter Maydell <peter.maydell@linaro.org> wrote:
>>>>
>>>> On Tue, 30 Jan 2024 at 10:39, Manos Pitsidianakis
>>>> <manos.pitsidianakis@linaro.org> wrote:
>>>>>
>>>>> On Tue, 30 Jan 2024 at 12:34, Peter Maydell <peter.maydell@linaro.org> wrote:
>>>>>>
>>>>>> On Tue, 30 Jan 2024 at 10:11, Manos Pitsidianakis
>>>>>> <manos.pitsidianakis@linaro.org> wrote:
>>>>>>>
>>>>>>> Check if a file argument is a cover letter patch produced by
>>>>>>> git-format-patch --cover-letter; It is initialized with subject suffix "
>>>>>>> *** SUBJECT HERE ***" and body prefix " *** BLURB HERE ***". If they
>>>>>>> exist, warn the user.
>>>>>>
>>>>>> FWIW, as far as I can see from my email archive, this particular
>>>>>> mistake has been made by contributors to qemu-devel perhaps
>>>>>> half a dozen times at most in the last decade...
>>>>>>
>>>>>> thanks
>>>>>> -- PMM
>>>>>
>>>>> Peter, searching for `b:"BLURB HERE"` in lore.kernel.org yields about
>>>>> 170 results including these patches.
>>>>>
>>>>> https://lore.kernel.org/qemu-devel/?q=b%3A%22BLURB+HERE%22

This comment is the default --blurb-template from git-publish:
https://github.com/stefanha/git-publish/blob/master/git-publish#L742
As the tool is also used to post patches to other projects, I'd
recommend fixing it there at the source.

Somewhere between the pre-publish-send-email and git_send_email()
calls you could check cover_letter_path doesn't contain the default
blurb.

>>>> Yes, there's a few more 'blurb here' results than 'subject here'
>>>> results, but they're almost always just where the submitter did
>>>> provide a proper blurb but then forgot to delete the 'BLURB HERE'
>>>> line, rather than where there's no blurb at all.
>>>
>>> Though you said half a dozen times at most.
>>
>> Yes, because I was counting 'subject here'.
>>
>> My question here is really "how much do we care about having
>> checkpatch point out this error?".
>>
>> thanks
>> -- PMM
> 
> I do, because it gives some peace of mind. But I do not care so much
> that I'd want to continue this conversation further.
> 


