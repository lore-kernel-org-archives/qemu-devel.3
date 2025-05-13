Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39189C3ABC3
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 00:37:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEddg-0003CY-Vd; Mon, 12 May 2025 20:36:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEdde-0003CL-PZ
 for qemu-devel@nongnu.org; Mon, 12 May 2025 20:36:54 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEddc-0004Ai-Qs
 for qemu-devel@nongnu.org; Mon, 12 May 2025 20:36:54 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-74019695377so3711178b3a.3
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 17:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747096611; x=1747701411; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KP8yhavj11z9MvwKCTXrbQykHbt7sJFJB4x4mmZVorM=;
 b=mUuEp5E7NL7WRbOgFOjZ4xA5nrJaSS/81My7pNbsl8PWZojggzjXic0eYy7f8lQsub
 0qQoxCucwpUTHAdQPu5krSGlgkpGxDZniKRWi3qSSm5ysvmYgiDWNvzfHMgPDbNRMGfl
 icetmqoKM7DEGAtZoVGusk7BmEZzcQHTeYRb6PAIxI4xtbaKB45hG5PHy4DGH3vPufPI
 qI+gx/L66LPcr1lEvbQzP3XcCQ4rHSBTXJxk0QlZ/PnTpQRG76t7+Y+whgXj5+frIkN2
 DvM13L1u2Tqk7jpywGhKVSb4P1SPaG0BR0Lt2V8N0vUYSPAFjcb/Ln9iX/CZtuWZr7xA
 FB3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747096611; x=1747701411;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KP8yhavj11z9MvwKCTXrbQykHbt7sJFJB4x4mmZVorM=;
 b=QHtgw0bIf5yeFVo28F/Rx8OFzMjsAa7ZO/usAhhL4XYJX41h2lsgDOL2i0br4ZOAf0
 IfZu2CyzYjk+gPNYP+ixKZJaYzqqoHUXx8SEUqwcCqYEeeKaytgDMNTc3q/OvkTF3qhP
 4biIARovDmhMWfif5v1F8Um9XOfcTAFaF+NaY3IC0WOMGHeiWNWvLJW8RhAgYSpBrJir
 lwxGRl5puCAPqDsk3fn5jQxLY3W7kIEZFMzgfrfaqEi6l/Q7feoFR9wUedi+1XAOn1jI
 7xWQi16OT38ZzqdRMF+4yxkJddJ3MWPZ7drA/6cW0wXWYSSybo6tFSswjPPr1mRmoJH4
 8jiA==
X-Gm-Message-State: AOJu0Yx7WLZ3YeztTx0bQRuO1a21HYZxfxE4SDK/JZm6uJch8ILtU/OJ
 QWRoMAau+KXHVd9lUIDSjkwvuPJVJNc46j0NQWLNrZ+0QuPadfPu3hLwZH79GQ0=
X-Gm-Gg: ASbGncuUCPlidIK2E3M1Os1agFq1wdeK0jp9p9/c72QpECf8K94+kCeLD6H6cKPsSEj
 csPUl5NiC6bd3ZQ2piJT6Q61e3q6S8d8bl4XXq7mz/Hv6A1LwwGbhIAfKtsYICIdVT/qezX4gWR
 YmdT+Tjnr993AWUxcn6ODMIakXB+4ISBMmEVlQBv/fc0uxg9Z5NFxDwo4ehKC7/rQooj0GNI9sl
 cZg1WDsAmgZWV1LIubXVru/xLJecR8i6J9lz5IuEnlBm5cVvuf8S7yerFYaOVGFq6dd1QLUyCg+
 RDUKCEB3tLnYzqTlYQ2BBCUlPPHbnL8F/yoZrl4lKh2kV7lVvYlpCkauUAKwlGc9zg4wBo3vRbI
 =
X-Google-Smtp-Source: AGHT+IFBdsZ0APSrMmAw0PB6A5mec6/cQx9Xepi7usdGHlYJi3pK5DeocCURCS1Af4MAj/PoX2jkHQ==
X-Received: by 2002:a05:6a00:1491:b0:736:4ebd:e5a with SMTP id
 d2e1a72fcca58-7423c054173mr21431573b3a.20.1747096610985; 
 Mon, 12 May 2025 17:36:50 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74237a8f4ffsm6578276b3a.162.2025.05.12.17.36.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 May 2025 17:36:50 -0700 (PDT)
Message-ID: <cb2adbec-d098-4211-8781-c3027de59e69@linaro.org>
Date: Mon, 12 May 2025 17:36:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/13] qapi: transform target specific 'if' in runtime
 checks
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org, stefanha@redhat.com,
 peter.maydell@linaro.org, richard.henderson@linaro.org, pbonzini@redhat.com,
 jsnow@redhat.com, philmd@linaro.org, thuth@redhat.com,
 Michael Roth <michael.roth@amd.com>
References: <20250507231442.879619-1-pierrick.bouvier@linaro.org>
 <20250507231442.879619-10-pierrick.bouvier@linaro.org>
 <aBzCXNTebh8B5sQ_@redhat.com> <87msbl0x7f.fsf@pond.sub.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <87msbl0x7f.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x435.google.com
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

On 5/9/25 11:57 PM, Markus Armbruster wrote:
>> The build system would need generate an input document for the
>> QAPI visitor that defines whether each constant is set to true
>> or false, based on suitable CONFIG/TARGET conditions from meson.
> 
> I think the conditions that are evaluated at build time in handwritten C
> code (with #if) should also be evaluated at build time in generated C
> code.
> 
> Certain conditions are evaluated at build time in target-specific code,
> and at runtime in target-independent code.  Again, I think handwritten
> and generated code should work the same way.
> 
> Thus, to eliminate target-specific QAPI-generated code, we either
> evaluate them at runtime, or simply eliminate them.  Elsewhere, we've
> come to the conclusion (I think) that the latter should do at least for
> now, likely forever, so we should try that first.
>

I'm not sure if you mean you'd prefer to eradicate #if completely.

We have to keep in mind that some config host #if have to stay there, or 
they expose things that the rest of QEMU code is not supposed to see 
(hidden under those same CONFIG_ ifdef also).
So we would need both if and runtime_if.

>> With this QAPI schemas would have remained fully self-contained.
> 
> Fortunately, this is merely a matter of filling a gap we left, not a
> matter of replacing a fundamentally flawed design.
> 
>> Anyway, this is a long way of saying that having 'runtime_if'
>> conditions directly referencing the names of internal C
>> functions makes me even more uncomfortable than I already am
>> with the 'if' conditions.
>>
>> The meaning of the QAPI schema now varies based on both the build
>> system, and an arbitrary amount of C, and is thus (conceptually)
>> even more opaque, even if you could infer some meaning from the
>> 'target_s390x()' function name you've used. I think this is a very
>> undesirable characteristic for what is our public API definition.
> 
> I don't see much of a difference, to be honest.
> Both kinds of conditionals have the exact same argument structure:> expression tree where the leaves are identifiers.
> 
> The meaning of these identifiers is not documented in the QAPI schema
> now, and barely documented in the code.
>

I agree on that, and I'm not sure that introducing another level of 
symbolic names (target-s390x vs target_s390x()) to match the same C 
function name really adds any value to the QAPI definition.
As mentioned before, it's easy to guarantee that the function is named 
the same in any language, and ban any use of C complex expression 
(through code review), so the argument about generating bindings in 
other languages does not really matter IMHO.

> This defect could be remedied the exact same way whether the identifiers
> are preprocessor macros or function names.
> 
> I actually find another argument of yours (not repeated above) more
> compelling: that certain aspects of the external interface should not
> vary at runtime.
> 

