Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 463E5C369A2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 14:17:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u29lF-0006K8-GN; Tue, 08 Apr 2025 10:17:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1u29l4-0006JH-QD
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 10:17:00 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1u29l1-0006gl-8E
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 10:16:58 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43d04ea9d9aso27349045e9.3
 for <qemu-devel@nongnu.org>; Tue, 08 Apr 2025 07:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744121812; x=1744726612; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/v1qt7Xe6ZVln/Jx1Y2btazm+i2QCPq+Nd/CHGgnIFU=;
 b=DRxTdCcGwxbJhB6T8sxY5s0gPhTzREwczEAtORHqGD/Y7oIWlP9lISSwUAj2zVwLPh
 t2I03pKRu7PHvmcKSmEwNmqJsRkK9WbqGgp/eWrtqoA/7C3A5fJxXMrHora6KaD8EXwW
 w+mPWTBLKI4at1PeYEn4N82HF7lctrreLiVQ6DNVpDUxlSB1mkiNmK4vkz1qLpxgHVC+
 qVEEzkKZnx1Hm9tkbVJuzWfw6o3mC9b8f3KTZWrzHSRhb01BeaavixBpGEGuRv6MQBr0
 yA/uE+TaqNInGSdxwKIlhdaydYLddcSAtAn2+MGFlLoWttJJHXyNpqrUWcaSg2V2YWXd
 ieiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744121812; x=1744726612;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/v1qt7Xe6ZVln/Jx1Y2btazm+i2QCPq+Nd/CHGgnIFU=;
 b=DGtPN6oTXcZ6u1EJa4pPFZ/WAcLT4RznNhwLmn+ftexJyuKXgOIpycbPKVr22oZVhh
 6NTterXKTnzyQprCnrlh4Jup5BYXwNrkIeq7hozvotpMLe2a1wNrNOFvff6ZRP/WN3bk
 FLq3fTm5xj+7ySQH5FGfSPlrueRJjm0gETCWQS5bgA3ZHHE0k4F4MUxh6ccf3KpRlJhJ
 7C5+bSoAF1titzMqd7PbIgbcBeQG/jMtzV34CTBysUbIdOaL2qiWS9X8FHuCmXswkJiG
 ocQDtrC8v8UTVZgf3x9kTH4JWF3s6WxmJ5VLJhyKtPZ17U1btbJJpLs0NOfU71FXfnAP
 4fVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhO7lsHoXoUpMofj/oOy1+IJ9V+7Vl0m5O+K6sUmqUGAbgkPvK50rpBk9z6FrN5ek152+ryIClor+J@nongnu.org
X-Gm-Message-State: AOJu0Yzr/SlHVUAmjfPxZ/rpvmGePvk61BjaU3yW38hTEWTZCzHm52mH
 b/ineTM5ORPhaQME7oz2V6SaprmzjyaOiE0mOubm+5+e69NaXMtxu8LbzZupc44=
X-Gm-Gg: ASbGncuyE/mGJekzKWo3N32GjrTB6T8FhXSeWYqEN+EyQYZlwvSTFQAdU2UUiSC/vk9
 q1I0nPjawcEY1MsNSs8J8FsfdiS+2xemCQGkpnnFu1sKinwggIqyuiA3mPI6mGs7dU283Ij2vaT
 LsZs2aLvoCEkPkchOC+I3lkZAt/2qv6LwM73dowQqbMdvcISLMyliQ18uaXLTo15MU3nUOqjGDU
 YMomPHD34vB9NkzdLN7sOvIbOFFDSXpk6ta/qFRe68NL7UDjpdPl4jhhPneyY4xYzG63VJyDBXc
 2X7cnqZWEBT5bmpCG6G4iluf+/2FHjc8ib7sDAtvDIzpBIc=
X-Google-Smtp-Source: AGHT+IELo05wFg5oVzlyGoH5/NRLdJmhfZTd54jhPoHfVqIobpc7erwb3pnTA5S1PjMM+ySHRsSTUA==
X-Received: by 2002:a05:600c:3487:b0:43c:f3e4:d6f6 with SMTP id
 5b1f17b1804b1-43ecfa19260mr174062225e9.31.1744121812170; 
 Tue, 08 Apr 2025 07:16:52 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec17b46bbsm165215995e9.36.2025.04.08.07.16.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Apr 2025 07:16:51 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 06E4B5F8D1;
 Tue,  8 Apr 2025 15:16:51 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Markus Armbruster <armbru@redhat.com>
Cc: Mario Fleischmann <mario.fleischmann@lauterbach.com>,
 qemu-devel@nongnu.org,  philmd@linaro.org, christian.boenig@lauterbach.com
Subject: Re: [PATCH 00/16] Add Multi-Core Debug (MCD) API support
In-Reply-To: <87ldsakgp9.fsf@pond.sub.org> (Markus Armbruster's message of
 "Tue, 08 Apr 2025 13:58:42 +0200")
References: <20250310150510.200607-1-mario.fleischmann@lauterbach.com>
 <87semkw3qx.fsf@pond.sub.org>
 <ea767dfa-d52b-44fc-baec-deea0223094f@lauterbach.com>
 <87semjp286.fsf@pond.sub.org>
 <0736943f-443b-4bfc-8d69-f30f42029d07@lauterbach.com>
 <87r023m422.fsf@pond.sub.org> <87a58qj3ay.fsf@draig.linaro.org>
 <87ldsakgp9.fsf@pond.sub.org>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Tue, 08 Apr 2025 15:16:50 +0100
Message-ID: <87y0wahh65.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Markus Armbruster <armbru@redhat.com> writes:

> Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:
>
>> Markus Armbruster <armbru@redhat.com> writes:
>>
>>> Mario Fleischmann <mario.fleischmann@lauterbach.com> writes:
>>>
>>>> Apologies for the line wrapping in yesterday's answer. Should be fixed=
 now.
>>>>
>>>> On 08.04.2025 09:00, Markus Armbruster wrote:
>
> [...]
>
>>>>> What about providing the MCD interface as a separate QMP-like protoco=
l?
>>>>> It gets its own QAPI schema, just like for qemu-ga.  Simplifies
>>>>> compiling it out when not needed.
>>>>>
>>>>> It gets its own socket, just like the GDB stub.  Might reduce
>>>>> interference between debugging and QMP.
>>>>>=20
>>>>> Thoughts?  Alex, Philippe, care to chime in?
>>>>
>>>> Sound reasonable to me. Keeping in mind the size of generated QAPI cod=
e,
>>>> an option to `./configure [...] --enable-mcd` is definitely advisable.
>>>
>>> Alex, Philippe?
>>
>> When I spoke to Mario at DVCon last year I liked the idea of re-using
>> QMP instead of inventing yet another RPC interface for QEMU. QMP
>> certainly has nicer properties than the gdbstub which has a very
>> "organic" and "serial" feel to it.
>>
>> Are you suggesting we re-use the machinery but use an entirely separate
>> socket with just the MCD namespace in it? I don't see that being a
>> problem as long as we can test it properly in the CI.
>
> Yes.
>
> "Keep them separate" is only a gut feeling, though.  While I pay
> attention to my gut feelings, I know they can be wrong.  I am soliciting
> opinions.

I forgot to add isn't the flexibility of the QMP API something we need
to handle for single binary anyway?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

