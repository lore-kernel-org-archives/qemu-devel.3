Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B148C3ABDD
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 16:54:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFFND-0004xP-DR; Wed, 14 May 2025 12:54:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uFFNB-0004vI-Oc
 for qemu-devel@nongnu.org; Wed, 14 May 2025 12:54:25 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uFFN5-00064q-5J
 for qemu-devel@nongnu.org; Wed, 14 May 2025 12:54:20 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-b1fd59851baso4670898a12.0
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 09:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747241657; x=1747846457; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SQXUMPZ25qjiXWkGJhr0BnN7diC5Qo56A6LIBjOi6as=;
 b=DKwMrzEjMJPjXzWbYMC7pmYIQxfNWghdtwzyp0vJY9YMI0mc6wMAhBsUgTzyGgIm1I
 PR6xsOBBY6mh7wC6DPLV44bMT2njFxArvH21mt/SPqmbkrgfqZ0+l/IiSMYD4hgRBnSP
 +y+iIL02w2YUDtzW4B4ZAMgGqj2CkweLzn2iBxU6vuykY052fMbZeJ7PcXhraz012VDI
 v9MUlvKcL7u2W1wr9fqVMesRpw4H74f3II27GXYZR0M2oVwKUlNvEEvBoYpKNnaU4l0b
 QlXbq86iBKLj6uDAky281O5D/YEgFUXWwZRB1H/3T6wqn9tubEb/2kndY6KcVgNZRW3j
 bxYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747241657; x=1747846457;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SQXUMPZ25qjiXWkGJhr0BnN7diC5Qo56A6LIBjOi6as=;
 b=Z0RfmtVniWxf1aQBfXeStqf9ilj9buVrCNf35blOem37RmF5fIZ+uEjWZAuqzRtoPL
 3vOiBB8drs73RA4Aqd8g+CxxCHNImWMZ/+4vhNFsiDHygr0UP8940w/fiqUK5zx1K/F8
 z6ZFvEdcyXPx7uZZCzqs/r7nR7N2ld3I98gDoGktorm6OV2uYnOqMv58pXUvhNcE0jUG
 XdL0OztGsM6Cp8zuGHLYNfrCrfJkhpL3WN6AkKb0f+NmiqODnaH1KPCvXV7TOxEyIQQh
 4WdCu/bkNG6IBbjAM95pVlrAbAAPBX3FPewpIESUBnv8eWrA12wyROO/JPXlOcJSq7cM
 5O8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+kCEBRrJQ0MnX3NS8vQ2smRWUVzzyGpPbsS6aUJvQJuzyyvY10FelCmJmNeP8EhRt6Af/8zrpbAM2@nongnu.org
X-Gm-Message-State: AOJu0Yy/u0tPwAHoZQZ6o4G1aBANHrg1dDlJk76/OL/VMNInuRa6OjRR
 Upj0ZK1w4q/p6TvK2YRRi3dPrh0cZZQaTvrFWWADk8LMeeAqXaKt6yNDLVYd4Ak=
X-Gm-Gg: ASbGncsYFieX36YE/DoyYfkGl4zFu4DZiMTv627gUtiydfgO7Wkt0iV3T+7MDiOBfKu
 cTfAHphFoYKAZ4I8W8YJ9sZ2OGX50LiAWBaSKsh48B6xpLpnW+MQ8BMrMxgNmSHp9lb5jQk9F+8
 wG3z+L6OoEglcq/q5RxeQ27qLD4zlfX9oo3Zz+vNwOXkqeDxbmTutsnQ8ft77yg0AlsyYzlkthF
 q6EDVsVcn3ki1AN3QpWo+8+LALvbpYaDK3NpSzAswBdk0+4WtfiF0HXebQyqVZcg5jwo0myKJwh
 UfeWuer5uDy/w6IXqH9/Q//tsajwY1rxnjvSMGJE6eIqVq3wnet2wwF/Wf8SiGONAedFxfnVPF0
 =
X-Google-Smtp-Source: AGHT+IHhCnG4RCY7JSDZ1bFz5StvCx3lPsqnZO7DTHlDYDjby9RmosQ+Vi6UVaxFBAtx02lda2AUYA==
X-Received: by 2002:a17:90b:5404:b0:2ff:7ad4:77b1 with SMTP id
 98e67ed59e1d1-30e2e588680mr6935498a91.2.1747241657466; 
 Wed, 14 May 2025 09:54:17 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30e33233f57sm1948732a91.0.2025.05.14.09.54.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 May 2025 09:54:17 -0700 (PDT)
Message-ID: <93aeb6e7-409b-4264-ac53-9a19ea947df2@linaro.org>
Date: Wed, 14 May 2025 09:54:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/13] qapi: transform target specific 'if' in runtime
 checks
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, alex.bennee@linaro.org, stefanha@redhat.com,
 peter.maydell@linaro.org, richard.henderson@linaro.org, pbonzini@redhat.com,
 jsnow@redhat.com, philmd@linaro.org, thuth@redhat.com,
 Michael Roth <michael.roth@amd.com>
References: <20250507231442.879619-1-pierrick.bouvier@linaro.org>
 <20250507231442.879619-10-pierrick.bouvier@linaro.org>
 <aBzCXNTebh8B5sQ_@redhat.com> <87msbl0x7f.fsf@pond.sub.org>
 <cb2adbec-d098-4211-8781-c3027de59e69@linaro.org>
 <87h61phttb.fsf@pond.sub.org>
 <e33c5751-6db2-4ca7-9a6e-b992a399e696@linaro.org>
 <87cycbacmr.fsf@pond.sub.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <87cycbacmr.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x536.google.com
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

On 5/14/25 12:13 AM, Markus Armbruster wrote:
> Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:
> 
>> On 5/13/25 12:08 AM, Markus Armbruster wrote:
>>> Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:
>>>
>>>> On 5/9/25 11:57 PM, Markus Armbruster wrote:
>>>>>> The build system would need generate an input document for the
>>>>>> QAPI visitor that defines whether each constant is set to true
>>>>>> or false, based on suitable CONFIG/TARGET conditions from meson.
>>>>>
>>>>> I think the conditions that are evaluated at build time in handwritten C
>>>>> code (with #if) should also be evaluated at build time in generated C
>>>>> code.
>>>>>
>>>>> Certain conditions are evaluated at build time in target-specific code,
>>>>> and at runtime in target-independent code.  Again, I think handwritten
>>>>> and generated code should work the same way.
>>>>>
>>>>> Thus, to eliminate target-specific QAPI-generated code, we either
>>>>> evaluate them at runtime, or simply eliminate them.  Elsewhere, we've
>>>>> come to the conclusion (I think) that the latter should do at least for
>>>>> now, likely forever, so we should try that first.
>>>>>
>>>>
>>>> I'm not sure if you mean you'd prefer to eradicate #if completely.
>>>
>>> I do not!
>>>
>>>> We have to keep in mind that some config host #if have to stay there, or
>>>> they expose things that the rest of QEMU code is not supposed to see
>>>> (hidden under those same CONFIG_ ifdef also).
>>>
>>> Letting people configure their QEMU build is useful and must stay.
>>>
>>> We provide this via conditional compilation, of complete source files
>>> (done in meson), as well as within source files (#if in C and 'if' in
>>> QAPI).
>>>
>>>> So we would need both if and runtime_if.
>>>
>>> I don't understand the need for runtime_if.  Can you give an example?
>>>
>>
>> That is the point of this whole series, which explores introducing a
>> 'runtime' if in the schema, to keep it as it is today, while removing
>> target specific compile time defines.
> 
> Ah, I lost the wider context, sorry!
>

No worries, I was not sure if you missed information or simply waited 
for more feedback, so I did well to ask you directly.

> We identified three ways to deal with target-specific conditionals in a
> single binary, and 'runtime_if' is one of them:
> 
> (1) Drop target-specific conditionals.
> 
> (2) Replace them by run-time checks.
> 
> (3) Have target-specific QAPI-generated code for multiple targets
>      coexist in the single binary.
> 
> Both (2) and (3) keep the QAPI schema work as it does now.  None of us
> likes (3) due to bloat and complexity.
> 
> The other two look both workable to me.  (2) keeps the QAPI schema work
> exactly as it does now.  (1) is simpler, but the external interface
> changes somewhat.  Its users seem to be okay with it.
> 
> So let's go with (1).
>

Sounds good to me. I agree that Daniel approach is simpler and better as 
well, as long as we accept the resulting changes in the schema, which 
seems ok for users.

Thus, I'll drop current series, and focus on respinning Daniel series 
and adding the changes requested.

>> It is another approach that one Daniel followed on his series.
>>
>> I invite you to give a quick read to this series, especially the related
>> commit introducing 'runtime_if'
>> (20250507231442.879619-2-pierrick.bouvier@linaro.org).
> 
> I can't afford a thorough review now, but I'll have a look, and I will
> hold onto your series just in case.
> 
>> As well, I would appreciate if you could state clearly where we are
>> going with all this (or at least, where you *don't* want this to go), so
>> we can avoid spending time in the wrong direction.
> 
> The discussion was spread over multiple threads, which makes it hard to
> follow.  I hope the conclusion is clear now.  If not, please ask for
> further clarification.
>

Yes, I agree. At least we are all on the same page right now, I'll 
pursue Daniel's approach.

>> I am ok to pursue Daniel's approach, or continue the approach in the
>> current series, no strong opinion in my side, I am just trying to move
>> QAPI generated code out of the way for the single binary goal.
> 
> Understood!
> 

Thanks Markus!

Pierrick

