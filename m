Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91C0CE7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 11:39:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKya3-0004hH-AS; Tue, 10 Dec 2024 06:39:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tKya1-0004gt-9k
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 06:39:05 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tKyZz-0005M5-HL
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 06:39:05 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-435005192d1so11223805e9.3
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 03:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733830741; x=1734435541; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RrOQ3UVTl9AS2HWvdVW44AeevF+Mi2NsHBjwkErHjWk=;
 b=p5wPLCwa06RJNFYkJ6/BoEL2aXMOcUHuoGlghoseNaiMoKquDonPcK9MlckxHhgFQs
 x/KX53OFc39n70UHrqwUTB56Dv9ehNa87zLL8UHyNhFGDxp4fKLIRnZfZoIoeGtCkvRm
 ZnNiI6yAuPIys85nZU1HuG6ZGngf6+kvu6dxLjO+WykOalqNgsp7w+0QjFoa4LPrCSoE
 fQBQqWAdwA5gsuqihcUEQ1A355QfH9tuxXP6rimRBoyqlV8YbBgftJaL4uasUH1EPu/P
 juWYLPbEyVoryVQfdlbzehXVs50TmJPqCxSF+383wV0K/BDB7pW4vSwPmTkrP2zrE7y5
 ocDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733830741; x=1734435541;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RrOQ3UVTl9AS2HWvdVW44AeevF+Mi2NsHBjwkErHjWk=;
 b=Pdr3r6oTOOmWzE1HNnR6A4dPRSkndKSUNxwHrG32dro53f3Igc60M1tP9e/lICkMEc
 RqZTbEA2j2eGErjR6ufkglsVn+dh9hFR+PBGaY7tBlXc9wkHyBDH76LNdenmVq0Hyl3c
 hNcQhRZy27rHFvmSdzo0+Zi7kMcOh+VCTG8InGiEL2nArGxWwBKWU6sZBGq5AXX8fADw
 OVFljs2JqzUjF3ofxg3VRh7cvCd+vbhU2m/wflEGn6ID2DtZC1H9qHJkaTI4h1Z85pYI
 KhrCucVYx7s4uDbf56KzSLeKDsslQaE7N4Ns0OjHbhDLIXffLudQbfAPrLG0flS40XgF
 450A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxW0NWcDxAclO1ywGQNxBDhG0/gPBsU7Fp+xKqa8pAYu1d1iYBaeidpZJgafAu42rvqqc+qLz53H6H@nongnu.org
X-Gm-Message-State: AOJu0YzWuUJhYm4JU9S7DQFizPpel8TAUCAkp/dzoanPfXD18SqIt/aq
 kTKKxExdFBXFQ1/mVSGlBP/x2nYLXOyfiJsE5B2TwejcWYkCuAnPQzSFDi+nArE=
X-Gm-Gg: ASbGnct4ys4F8i5pO0XHCxV/eGRacCu4p/K0yZOiCL8UAO4DhfFORUjel+d5Hk+JMXB
 j/grQ0VzJa3uu6cjXQhegYyFkPHOaSbEidib936KaZLVcJdOpHe7DmK6sx6i2vWRBngGEoEz14Z
 BR7k3vHV9zeL/4YoHsA0R4c1/qbyy9qNz+81Ux78OsKlT+lA8Al7ZKYxli0QNGAATK4obAB+/UQ
 yMSpG8o+3KlEHfH2psHE4b5iuOE68LSnuM24VpInmxaQr/AUTIV
X-Google-Smtp-Source: AGHT+IGobbMz5gXfb38MGNJAVX7sHUpaUyhR8F5aWrpx8c0KbCHGMziYvTrEW1MhCySfHCGov6J1cw==
X-Received: by 2002:a05:600c:1909:b0:434:f586:753c with SMTP id
 5b1f17b1804b1-434f5867ecemr65444495e9.7.1733830741123; 
 Tue, 10 Dec 2024 03:39:01 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434f39653c6sm92772475e9.7.2024.12.10.03.39.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 03:39:00 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7FE025F77C;
 Tue, 10 Dec 2024 11:38:59 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Rowan Hart <rowanbhart@gmail.com>,  qemu-devel@nongnu.org,  Richard
 Henderson <richard.henderson@linaro.org>,  Eduardo Habkost
 <eduardo@habkost.net>,  Alexandre Iooss <erdnaxe@crans.org>,  Mahmoud
 Mandour <ma.mandourr@gmail.com>,  Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Peter Maydell
 <peter.maydell@linaro.org>
Subject: Re: [PATCH v2 0/3] Add additional plugin API functions to read and
 write memory and registers
In-Reply-To: <5b798177-c48f-4f69-8b7b-2b63c74c3505@linaro.org> (Pierrick
 Bouvier's message of "Mon, 9 Dec 2024 10:45:15 -0800")
References: <20241206102605.961658-1-rowanbhart@gmail.com>
 <55c95bd1-a1bc-460c-b4fe-1f52f8af2c2e@linaro.org>
 <2c0893fa-9d84-4003-861b-91a923f9439f@gmail.com>
 <5b798177-c48f-4f69-8b7b-2b63c74c3505@linaro.org>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Tue, 10 Dec 2024 11:38:59 +0000
Message-ID: <87o71ju5rg.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> On 12/6/24 16:57, Rowan Hart wrote:
>>> I am personally in favor to adding such features in upstream QEMU,
>>> but we should discuss it with the maintainers, because it would
>>> allow to change the state of execution, which is something qemu
>>> plugins actively didn't try to do. It's a real paradigm shift for
>>> plugins.
>>>
>>> By writing to memory/registers, we can start replacing instructions and=
 control flow, and there is a whole set of consequences to that.
>>>
>> Totally agree! As much as I really want this functionality for
>> plugins, I think
>> alignment on it is quite important. I can see very cool use cases for be=
ing
>> able to replace instructions and control flow to allow hooking functions,
>> hotpatching, and so forth.

I think currently that makes quite a lot of demands on the translator to
make sure things are kept consistent.

We have been talking about maybe enabling hypercalls of some sort to
allow for hooking explicit function boundaries in linux-user. A natural
extension of that would be for host library bypass functions. I'm unsure
of how that would apply in system emulation mode though where things are
handled on a lot more granular level.

>> I don't really know the edge cases here so your expertise will be
>> helpful. In
>> the worst case I can imagine: what would happen if a callback overwrote =
the
>> next insn? I'm not sure what behavior I would expect if that insn has al=
ready
>> been translated as part of the same tb. That said, the plugin is aware o=
f which
>> insns have already been translated, so maybe it is not unreasonable to j=
ust
>> document this as a "don't do that". Let me know what you think.
>>=20
>
> In the end, if we implement something to modify running code, we
> should make sure it works as expected (flushing the related tb). I am
> not sure about the current status, and all the changes that would be
> needed, but it's something we should discuss before implementing.

If the right access helpers are used we eventually end up in cputlb and
the code modification detection code will kick in. But that detection
mechanism relies on the guest controlled page tables marking executable
code and honouring rw permissions. If plugins don't honour those
permissions you'll become unstuck quite quickly.

> More globally, let's wait to hear feedback from maintainers to see if
> they are open to the idea or not. A "hard" no would end it there.

It's not a hard no - but I think any such patching ability would need a
quite a bit of thought to make sure edge cases are covered. However I do
expect there will be downstream forks that go further than the upstream
is currently comfortable with and if the code is structured in the right
way we can minimise the pain of re-basing.

>>> The hypercall functionality would be useful for plugins as a whole. And=
 I think it definitely deserves to be worked on, if maintainers are open to=
 that as well.
>> Sure, I'd be happy to work on this some more. At least on the
>> fuzzing side of
>> things, the way hypercalls are done across hypervisors (QEMU, Bochs, etc=
) is
>> pretty consistent so I think we could provide a useful common set of
>> functionality. The reason I did the bare minimum here is I'm not familia=
r with
>> every architecture, and a good NOP needs to be chosen for each one along=
 with a
>> reasonable way to pass some arguments -- I don't know if I'm the right p=
erson
>> to make that call.
>>=20
>
> We have been discussing something like that for system mode recently,
> so it would definitely be useful.
>
> IMHO, it's open for anyone to contribute this, the plugins area is not
> a private garden where only chosen ones can change things. Just be
> prepared for change requests, and multiple versions before the final
> one.
>
> Same on this one, we'll see if maintainers are ok with the idea.
>
>> Glad to hear you're for this idea!
>> -Rowan
>
> Thanks,
> Pierrick

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

