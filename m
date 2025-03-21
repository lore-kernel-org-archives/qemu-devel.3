Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58093C36000
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 13:03:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvc1B-0003eH-50; Fri, 21 Mar 2025 09:02:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tvc18-0003da-D5
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 09:02:30 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tvc16-0003fD-C4
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 09:02:30 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43cf034d4abso20377885e9.3
 for <qemu-devel@nongnu.org>; Fri, 21 Mar 2025 06:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742562146; x=1743166946; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rOQY0mwllj5i8RTosE04J3iSbsdpuVSa1ndX5Jja/7U=;
 b=SsbHFryGPAPhcWyetz1yD3NBFRcPVASOJNca8RJxmmko7lha+sF5JmPIKRPgDlj+SX
 3GF9a6XRWDebP43xykEGqT+AK8wpdJT4VN+OlrgifgDFDDkZXvXBDPaTsCMczd8/J1Xy
 7PkOGJkVmO2wqR6/vAWk4ngArlDNu9xpkIW0xcDK92EBhpnoPQkklMktPQp/qEUMQEv9
 awdcs99LwJbUnnE3t5JO9QaQnjoC+CPPRBZqgI23gUMqFDsC5shh0R0xNdXCZFXetAy2
 g3cxcDc+pD9vfdRsmuGNshGUey/EM+ujfpO1H7wNOjpgQTRrG/Xda3n7ZelOSPpUWN8A
 /w2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742562146; x=1743166946;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rOQY0mwllj5i8RTosE04J3iSbsdpuVSa1ndX5Jja/7U=;
 b=gfAj9Phh5hKcGXSVjj/sVv0GBQQBEqQwOOSub1sO6829J3p7uMWiVOuKQjjM2Q9R1I
 aF+KN+jXwhLIBNrrKFN77hf+B2V+RGOwkm/tMdEXpV27BA4WVlAEOzN29WfukeoqEbyg
 qA+IwICDpv54MyJudtsbvUKoF4bl2J58C3J7AuR1k96SXVOKDHXGKsTjDZtabDvzDxs6
 Crc1ebxyqW2JsyxswgSrBycW1Q91NfwY6pc5GIZJJ1rz1DWyuQhPL0NEeaAoxg2KrJIZ
 RL0nR1qQmTDGs2oaQQtdM+wB6aV1siaI2SkdPoCBosHa6vIWH+8j6JD7iQBm/pLMdNGv
 FS6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdkFTnPrHoBxp6zYxsCJxljX0BD4E8HK7c8orhS38Qu7EsYwX2G7v80AVlVkkrpQZ/IDTzxttXoA7L@nongnu.org
X-Gm-Message-State: AOJu0YwaXynymQDQJQQqdPSKrcdCc2H/lefQ0v3QyGGJ8FH/Z5Jc9fkO
 FSbKhVvoiRwbTQFgKqjP6pE5qYmW8iryNiLVQLPqTzmQAZ9hzZNJ66m3NFQQsP8=
X-Gm-Gg: ASbGncvkcnn+5uhuVmw0rqLNPLb8EI3o4gniqVqWIWKCqFevXpUzGZQc/T8BdDdLeNX
 C1jeCmp50bAwukqiMGASSfcZW7lIeZdDAmSOC2v49frX+++dsW3eSgat19AELQrUe02Q6OiBnoy
 nG7vDfEc9H8bq4qQBkpYpda0xCurUnXDaDgNhY1xn7CeZTvqFDYjswgEW80MfMCQmt6gqDIPFGu
 03jug0Wo4w+RuFswl/5q46xLKERdIMRpkSpP5359DOrbBFC4evS+l7rv3Tn30YNJRVt/qk4e4xP
 HX3DO66GRVJjXtoSt1Bm1vSzsPoJ38ioU+FxqlsDaWgN+IZXN1P7J82txKSPekmfwJnghPXFp5T
 8LSwbO/j6VeO/wXulp+1i5gc=
X-Google-Smtp-Source: AGHT+IHnk77zwPbsxTNTKPiSccs0oz5sqwsmlcTJCpwZ02ySfHzpG4jf+yPpGjlvs6SYd/LBarHIDw==
X-Received: by 2002:a05:600c:6006:b0:43c:f8fc:f6a6 with SMTP id
 5b1f17b1804b1-43d555b4613mr9689385e9.9.1742562146390; 
 Fri, 21 Mar 2025 06:02:26 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d4453227dsm79351205e9.40.2025.03.21.06.02.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Mar 2025 06:02:25 -0700 (PDT)
Message-ID: <fd9ecec4-cfa9-4605-aa14-264284f6afb6@linaro.org>
Date: Fri, 21 Mar 2025 14:02:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] gdbstub: conversion to runtime endianess helpers
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Juan Quintela <quintela@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Akihiko Odaki <akihiko.odaki@daynix.com>,
 qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>,
 qemu-s390x@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Beraldo Leal <bleal@redhat.com>, qemu-arm@nongnu.org,
 Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <20250319182255.3096731-1-alex.bennee@linaro.org>
 <0bc36324-4fb7-41ee-a9f1-3a7de4ad7fa4@linaro.org>
 <7444c007-d8f1-4c55-ab4a-15becdf1c932@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <7444c007-d8f1-4c55-ab4a-15becdf1c932@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 20/3/25 21:16, Pierrick Bouvier wrote:
> On 3/20/25 12:52, Pierrick Bouvier wrote:
>> On 3/19/25 11:22, Alex Bennée wrote:
>>> The aim of this work is to get rid of the endian aware helpers in
>>> gdbstub/helpers.h which due to their use of tswap() mean target
>>> gdbstubs need to be built multiple times. While this series doesn't
>>> actually build each stub once it introduces a new helper -
>>> gdb_get_register_value() which takes a MemOp which can describe the
>>> current endian state of the system. This will be a lot easier to
>>> dynamically feed from a helper function.
>>>
>>> The most complex example is PPC which has a helper called
>>> ppc_maybe_bswap_register() which was doing this.
>>>
>>> This is still an RFC so I'm interested in feedback:
>>>
>>>     - is the API sane
>>>     - can we avoid lots of (uint8_t *) casting?
>>
>> Even though the series has a good intent, the fact we make everything
>> "generic" makes that we lose all guarantees we could get by relying on
>> static typing, and that we had possibility of mistakes when passing size
>> (which happened in patch 4 if I'm correct). And explicit casting comes
>> as a *strong* warning about that.
>>
>> By patch 7, I was really feeling it's not a win vs explicit functions
>> per size.
>>
>> If the goal of the series is to get rid of endian aware helpers, well,
>> this can be fixed in the helpers themselves, without needing to
>> introduce a "generic" size helper. Maybe we are trying to solve two
>> different problems here?
>>
>>>     - should we have a reverse helper for setting registers
>>>
>>> If this seems like the right approach I can have a go at more of the
>>> frontends later.
>>>
> 
> Looking at include/gdbstub/helpers.h, gdb_get_reg128 can be solved by 
> using target_words_bigendian() instead of TARGET_BIG_ENDIAN, which is 
> already what tswap primitives are doing.

We'll need to eventually remove target_words_bigendian(), so that'd just
be postponing that.


