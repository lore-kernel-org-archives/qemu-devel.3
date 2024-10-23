Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08E16CF538C
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 13:58:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3bsF-0005U6-UD; Wed, 23 Oct 2024 09:58:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t3bsC-0005To-OX
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 09:58:04 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t3bsA-0000EB-Kk
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 09:58:04 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-539f0f9ee49so7467406e87.1
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2024 06:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729691880; x=1730296680; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CdR1bG7Z1B27PfxPH4Z/IJEOCWYwUtFsl62/kn/AiVo=;
 b=ROam4F846RR7jPHImpD8/IpqKduBhlH+GzQj6ybU0GucIjj7F7UkWMvEC2B+MqIRiC
 YA2SpylYhLEsUsNdvNobKywQtbeS/IRNA3NcO9lrLifklZIPaIO9bEMI2/7K/OwJFT/H
 qqUuWxiaWK8Ds6ravSRe1/QkXRH3LPfBCKQa6J+lcgGVeQAQ/++8/OPjEfiCeyvvanhg
 JbHxi4wY/pI4XwldAk1hWcWRHtY6pfkcG6ivzXW6hG9YrY1a36XQDW815ybkGzg9llsL
 f/2Ja7rPfsg6VL1EI8IFW5Rr8LbIp9IyaxIAmNYpPs6SeokMd7kiTzhuSR/OJshc7rqK
 +KuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729691880; x=1730296680;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CdR1bG7Z1B27PfxPH4Z/IJEOCWYwUtFsl62/kn/AiVo=;
 b=aeJwhN4r3Dbu/kBp1tFYtQuaqLx80l1ACN2Nb2nrrm6J/5MlLbpflaibNsYa1//AK3
 /T2iFVie4sE+u0HBfS5tIXgrm6uHKvizjAoGvpIE+f2w1Gl4iSRO9fJYJkBxqvPZrlrD
 8LfkVSzsRj9G+RL3Drc/GhW2dZkkYfAis2OZlZ9KsFW4wAV3yg3uOh/YlX9+3pGvrSaS
 qsZvaS3jhjz/Imrsl9TneI4g0VjyOZpsq/Vcf0XotiXZ35y4TE2FIgXQ1uAdN5JCYap2
 WFkBMLzzzuPdsbEK4mhG7KCJr2z6Cd8wf9bpnEwPIDlqR7zTcTgz6L6MLNyZwCrIc8Pq
 JdPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVO7WOmKEIA1eJptKMLD+fjZ2H/lYPhI49VYS71kDLtuMZwUCInbAp0rYDjU3CdeudzwlZsEnvB0/aw@nongnu.org
X-Gm-Message-State: AOJu0Yynlad/HeBw5niVFUl/CeTiRhNe4Fsv50jMj7vBxH2JMxGD6npu
 4DTWb2OLu6lIMdHxoRxQ/V3R9ZFZ93CwrKK5fs0odhdxwoS0XjDjfDIj7t4KJvo=
X-Google-Smtp-Source: AGHT+IE/YCalR9wv1zqHUn9pvBbGXsovDwwGUR0UIBhJcASlthEVCNiAuR9Nk/ErMckBlYF5kKzaPQ==
X-Received: by 2002:a05:6512:12cd:b0:533:44e7:1b2a with SMTP id
 2adb3069b0e04-53b1a35503emr1632273e87.40.1729691879926; 
 Wed, 23 Oct 2024 06:57:59 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a912d641esm482666566b.3.2024.10.23.06.57.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2024 06:57:59 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 630145F897;
 Wed, 23 Oct 2024 14:57:58 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: "Julian Ganz" <nenut@skiff.uberspace.de>
Cc: "Pierrick Bouvier" <pierrick.bouvier@linaro.org>,  "Julian Ganz"
 <neither@nut.email>,  qemu-devel@nongnu.org
Subject: Re: [RFC PATCH v2 0/7] tcg-plugins: add hooks for interrupts,
 exceptions and traps
In-Reply-To: <0696c7fc52d1d58002f0a8be7e7502f57fd61d24@skiff.uberspace.de>
 (Julian Ganz's message of "Wed, 23 Oct 2024 12:56:10 +0000")
References: <20231021122502.26746-1-neither@nut.email>
 <cover.1729355735.git.neither@nut.email>
 <fad67d3f-5b8d-45f6-a1aa-666852a0dad4@linaro.org>
 <8929cd79ce653b55e7cb166300782cb13727da3b@skiff.uberspace.de>
 <f7e574bb-a780-4f5b-a511-ab9f0aa86f31@linaro.org>
 <ab29d100610abcc59ce2305a1ace1ac0b53340a3@skiff.uberspace.de>
 <2419ec6e-3d4e-4d6d-a738-7615c99ed60c@linaro.org>
 <0696c7fc52d1d58002f0a8be7e7502f57fd61d24@skiff.uberspace.de>
User-Agent: mu4e 1.12.6; emacs 29.4
Date: Wed, 23 Oct 2024 14:57:58 +0100
Message-ID: <87h692ly55.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x131.google.com
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

"Julian Ganz" <nenut@skiff.uberspace.de> writes:

> Hi, Pierrick,
>
> resent as I was too stupid to hit reply instead of reply-all.
>
> October 22, 2024 at 11:15 PM, "Pierrick Bouvier" wrote:
>>=20
>> On 10/22/24 01:21, Julian Ganz wrote:
>>=20
>> >=20
>> > Hi, Pierrick,
>> >  October 21, 2024 at 11:59 PM, "Pierrick Bouvier" wrote:
>> >
<snip>
>> >  I don't think this is a good idea.
>> >  Traps are just too diverse, imo there is too little overlap between
>> >  different architectures, with the sole exception maybe being the PC
>> >  prior to the trap. "Interrupt id" sounds like a reasonably common
>> >  concept, but then you would need to define a mapping for each and eve=
ry
>> >  architecture. What integer type do you use? In RISC-V, for example,
>> >  exceptions and interrupt "ids" are differentiated via the most
>> >  significant bit. Dou keep that or do you zero it? And then there's
>> >  ring/privilage mode, cause (sometimes for each mode), ...
>> >=20
>> I didn't want to open the per architecture pandora box :).
>> I don't think the plugin API itself should deal with per architecture
>> details like meaning of a given id. I was just thinking to push this
>> "raw" information to the plugin, that may/may not use architecture
>> specific knowledge to do its work. We already have plugins that have
>> similar per architecture knowledge (contrib/plugins/howvec.c) and
>> it's ok in some specific cases.
>
> But how would such an interface look? The last PC aside, what would you
> include, and how? A GArray with named items that are itself just opaque
> blobs?
>
> And what would be the benefit compared to just querying the respective
> target specific registers through qemu_plugin_read_register? Which btw.
> is what we were going to do for our use-case. Even the example you
> brought up (howvec) uses querying functions and doesn't expect to get
> all the info via parameters.

I think the register access probably provides everything you need. Some
targets provide a wider access than other though. I haven't looked at
the Risc V code but certainly the Arm code exposes pretty much all
system registers to the gdbstub (and hence the plugin interface).

If there is example of state that isn't accessible this way then I'd
like to know it.

>> But having something like from/to address seems useful to start. Even if=
 we don't provide it for all events yet, it's ok.
>
> Yes, I certainly see the advantages of having either the last PC or the
> would-be-next PC as they are sufficiently universal. You can usually
> retrieve them from target-specific registers, but that may be more
> complicated in practice. In the case of RISC-V for example, the value
> of the EPC differs between interrupts and exceptions.
>
> That PC value should also be easy enough to obtain at the hook call
> sites. We only need to store the (old) PC before doing the setup. The
> "to-address" is the current PC at the time the callback is invoked.
> Anything else would be a bug. I was going to write that you can
> already query that in a plugin through a dedicated helper function
> but apparently I misremembered.
>
> I'll include this in the next iteration.

There are some dragons with pc/npc as each front-end deals with it its
own way and some targets have delay slots which makes things even
messier.

>
>> > It would also complicate call sites for hooks in target code. You'd
>> >  either need awkwardly long function signitures or setup code for that
>> >  struct. Both are things you don't want, as a hook call site should
>> >  never distract from the actual logic surrounding them. You could
>> >  probably have something reasonable in Rust, using a builder/command
>> >  pattern. But in C this would require too much boiler plate code than
>> >  I'd be comfortable with.
>> >=20
>> We can have one "builder" function per data type, with fixed parameters =
(no varargs), it's reasonable and would scale well with new entries/data in=
formation.
>
> I'm still not on board on preparing a more complex data type. For the
> next iteration I'd rather stick to a simple function receiving the
> "type" of event and the PCs. That may not be extensible, but I don't see
> any benefit in shoehorning inheritelntly target-specifc information into
> a complex struct.
>
> If this is a hard requirement, I'll of course still do so.

No lets keep it simple for the first iteration. We can also expand the
API later and bump the API versions as appropriate.

>
> Regards,
> Julian

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

