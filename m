Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D1B0C5B543
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 07:47:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMiq2-0001RD-TD; Wed, 04 Jun 2025 03:47:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uMiq1-0001Qz-9O
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 03:47:05 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uMipz-0002IX-Fl
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 03:47:04 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-450cf0120cdso56118025e9.2
 for <qemu-devel@nongnu.org>; Wed, 04 Jun 2025 00:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749023222; x=1749628022; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Pi0uwkxWYT4uhyCiNcoYuVIwB1gM3EcPZVFRLQ6qyEY=;
 b=XeveuNIIcstCe4jxR0nARGgEYrXMHMUr7zz8B6IWhMj1gHIgyc8771UWD8POFSUCEd
 uZ+Odel8irZ+ysf0+ZypoZtneuN8va2/7HKpHJ1OzotyX+UMAD1CGGH22Mh7+NFRTSQ3
 pJTGEqIUcdB5B3mANmZXqWcVMjr2QiD4wR/4k869JM+ZwxSd3/U2UjvAMLVFgDjLWfNQ
 gSE74huPbUAIcmm+muqZx6IlUdVnOv6d8egr18iPVb//wx7/0ve5DNerUwA+3ftfitXG
 fN3RPK4JNV6oH9URm5dq9QRf4e0xmJMN8c0If28FV/a6NypLqz4pVAIBoG5+wfVsTHmY
 u0GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749023222; x=1749628022;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Pi0uwkxWYT4uhyCiNcoYuVIwB1gM3EcPZVFRLQ6qyEY=;
 b=pNEJD4BulFWtpb+LSvuEDSVr8ReglPuxGrMBTxM3qdNmvSrwPC+vUX9dhtnNCvyBDw
 CPzkPtmA/ZQbtbP+IMEc0qA+5Z27YjCqdrAGQ5IL22N1bt+LPphbXPeCzw8wypKrfzsZ
 MXlN/lGYIQvQG3m1I7H/KpmrermKEE4vnsRBz6K5CBD0tLvS6IikjI4e91P7RS0dezGW
 5aeEmJfh2ktqFjGjQDpYP73ZKhMcSPtF9nnz2m3aMCG0U7I7v7Fzd/+zeSi3SC69alko
 /0ThWOcM2F6a8cnn5F75tmCz4myQJ+nP+5o+UK856Xa/zFv5LliVxM51Az8zTcV5AKiK
 2ddg==
X-Gm-Message-State: AOJu0Yych9aL2lGo7Xz6+5z5/okBWa8Rs73aUugnr7bnyF7Eo4RzAsnU
 4z9LY2kmIkPKTqXnmXrPBXMdDMkxfvXYemta+FcWGHyc2KshtcGslr6V4Dtfdxm32LI=
X-Gm-Gg: ASbGncts0/84A00EHwTG3XfyA7hHasLbkcfT0RmObX5nJROyYOxCgz+Rf/dPuTbakzZ
 EXXdYKz4E7fVfXNK1ZbO9ZidsHoqx1yS9gEm4TjbI3M+prEN1/Ek6fstKeZMH8LmN3oYSn1Qan9
 SOE97SnOQFFtDXt85SzUAed9i4gPSY0EfEyD3drNe4jJC/bq5A18px728cm3JH/1OrT2mRavKok
 +Rr3d01nIqB5dDxh+WSc4WdJZtq6eVF5ymAP7bTOBa6pvqKKgndR1fmJZAkQEEPsm2nX2tUj86I
 5h5KPf1+vz1Yh5qIMr3gXRNeBhk5UMVH6xchGYIkUn13x3zmIix7yjbtzZo7YA8cOGLWKXWtmtW
 0nvwikmpqFplOTiAHYa0=
X-Google-Smtp-Source: AGHT+IEjDyE3ZTaAKsn3EI/MVM3HP4tRhZA3PjnBj27EwNkk97jcceLO5EhToDv5Q0Mf2N24EHJ1qw==
X-Received: by 2002:a05:6000:2283:b0:3a4:fa6a:9174 with SMTP id
 ffacd0b85a97d-3a51d9708d4mr1355581f8f.33.1749023221546; 
 Wed, 04 Jun 2025 00:47:01 -0700 (PDT)
Received: from [192.168.69.138] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4efe5b79asm20403486f8f.2.2025.06.04.00.47.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Jun 2025 00:47:00 -0700 (PDT)
Message-ID: <37b3f3a1-bacb-4682-a9d2-7771e29fe55f@linaro.org>
Date: Wed, 4 Jun 2025 09:46:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] docs: introduce dedicated page about code
 provenance / sign-off
To: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Daniel_P=2EBerrang=C3=A9?=
 <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Alexander Graf <agraf@csgraf.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20250603142524.4043193-1-armbru@redhat.com>
 <20250603142524.4043193-2-armbru@redhat.com>
 <87a56o3gxc.fsf@draig.linaro.org> <87r000ypi0.fsf@pond.sub.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <87r000ypi0.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 4/6/25 08:44, Markus Armbruster wrote:
> Alex Bennée <alex.bennee@linaro.org> writes:
> 
>> Markus Armbruster <armbru@redhat.com> writes:
>>
>>> From: Daniel P. Berrangé <berrange@redhat.com>
>>>
>>> Currently we have a short paragraph saying that patches must include
>>> a Signed-off-by line, and merely link to the kernel documentation.
>>> The linked kernel docs have a lot of content beyond the part about
>>> sign-off an thus are misleading/distracting to QEMU contributors.
>>>
>>> This introduces a dedicated 'code-provenance' page in QEMU talking
>>> about why we require sign-off, explaining the other tags we commonly
>>> use, and what to do in some edge cases.
>>>
>>> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
>>> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>> ---
>>>   docs/devel/code-provenance.rst    | 218 ++++++++++++++++++++++++++++++
>>>   docs/devel/index-process.rst      |   1 +
>>>   docs/devel/submitting-a-patch.rst |  18 +--
>>>   3 files changed, 221 insertions(+), 16 deletions(-)
>>>   create mode 100644 docs/devel/code-provenance.rst


>>> +
>>> +   Signed-off-by: YOUR NAME <YOUR@EMAIL>
>>> +
>>> +using a known identity (sorry, no anonymous contributions.)
>>> +
>>
>> maybe "(contributions cannot be anonymous)" is more direct?
> 
> If we're deviating from the kernel's text (which is *fine*), let's get
> rid of the parenthesis:
> 
>      using a known identity.  Contributions cannot be anonymous.
> 
> or in active voice:
> 
>      using a known identity.  We cannot accept anonymous contributions.

I'd add an anchor in the "commonly known identity" paragraph added in
commit 270c81b7d59 and here link to it.

> 
> I like this one the best.


