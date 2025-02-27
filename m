Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17227C19F2E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 10:11:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnaqb-0002PU-78; Thu, 27 Feb 2025 05:10:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tnaqX-0002P0-E4
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 05:10:26 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tnaqV-0006lX-G3
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 05:10:25 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43948021a45so6809955e9.1
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 02:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740651020; x=1741255820; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZlKvtGXTBu0xUJ0Wh3yYLlHmh6pQ8oJ5/KLtZo1trzQ=;
 b=kMYfQmrfRu1d6JT7cj5YVRMLWYckvdDaegSucrfK/ihufdIlHErEHpfymuO0DMPz3Y
 5vdNEmJ/aqrYxhgs1PlhoHEq2vWmXO64G83mxFgnL90fyjp/gs6JUh1lwxUkgX7wMwb2
 qM/geRSKN5qH1cUSaGIceixHzhor4Jr8nfK+AFHehqkZ+zw4sXl6BlqCXTS1piKkuDCi
 HcbUQhmMoWSGmg7vtRaqQAfPTwAktVhX0U70XI22Swa8X8QPISPRVPWxtLLF+o+3WkKk
 VavY1w//xHtxhyVMP8wEWczZ8SgeTX7eaEeRp+6zMx/KlZ8CUNxCAlchSFmEtHWTiAQT
 NgeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740651020; x=1741255820;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZlKvtGXTBu0xUJ0Wh3yYLlHmh6pQ8oJ5/KLtZo1trzQ=;
 b=etXgD9ShzjhQ0ulb+y4QwOeBV5UzlgQ03zgKPbI/rKmkvnb5kVoPNkTtBEQuXm8BUW
 oZ/An7LTxjxAJzUbvuHVHIccNbngbpL5ALmezGwAqbPO/8ZflOXmaWN51bv8qeP+AtNw
 XF9LFWI7PbmYxGwZ6cKRGIgbDw6QDDuxb1/WrcxPi3nC5UvHru0xyLS6+92jjlQPzI9D
 Bf5F+pDCOi/c2p5PHw4YvhqUAXlfltXdoClFyUYpCZ2qldjGQKoXEnM6J2OLVr3btLa5
 McSU2QaMMZHozkdm72yqNh67OW6lnaVkjrRNiZ6uZqojz5nJ25GqjgWxkr8ltwDbI62w
 6zMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7qMeM2/qXkBGZuXVQdnAax9rGpCINEYkt1TLPMBFb5j4H/aJd/uLJ4cnh8uUGK2OyWSZFuhvm7KVc@nongnu.org
X-Gm-Message-State: AOJu0YyzR/jFeUzK6s+XAvPhC/wQFIEJ5XMDEuQqz8N9uzenmVri4FqY
 H8/RIBET7QrfCSO+Tzx9p0zS3HziY6M7AtftEu+oDUN+fWivTv8XgcuxagODXF4=
X-Gm-Gg: ASbGncsmIm8mAxhNQhI7RJXpb6YhMdDDvW2K1xBWpkcu7G72FaN6PkCx2scuY9dLRZh
 Rqz8nKz+SNAvdhPC3biIiHm5jE0+NeY0aM5D2JGEwMdzCxIbBnQIGuup+ymCe3QdQkA651gtdHB
 TXJ5EVMmAcEdtkJfpZ+gK7hcAkqIAxAbtbTANrtqZmC8TC44/IKH3Yt2bQqceVOCF/ucGxqpEMp
 P8QsgeLcDahZ+epQAlTMipY+gSq+mn0WYKg3TIIriNV0I6TzmmnAgidswhPLu/JWuitjuDf/BsJ
 RAnYOi1RJ9i8L8jnGyq27chr/YzG
X-Google-Smtp-Source: AGHT+IFIlmYQfaHaKTF5nf08hnELExkEF6goxoJE+gk4sx9l+Qgq9lIyDdOTbuX8BPzFFy7OrQ6ItA==
X-Received: by 2002:a05:600c:3588:b0:439:6304:e28a with SMTP id
 5b1f17b1804b1-43ab8f6fe56mr62314135e9.0.1740651020288; 
 Thu, 27 Feb 2025 02:10:20 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43b7a27abd6sm17209855e9.26.2025.02.27.02.10.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 02:10:19 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E2ABD5F8AB;
 Thu, 27 Feb 2025 10:10:18 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: "Nicholas Piggin" <npiggin@gmail.com>
Cc: "Richard Henderson" <richard.henderson@linaro.org>,
 <qemu-devel@nongnu.org>,  "Daniel Henrique Barboza"
 <danielhb413@gmail.com>,  "Igor Mammedov" <imammedo@redhat.com>,  "Helge
 Deller" <deller@gmx.de>,  "Paolo Bonzini" <pbonzini@redhat.com>,
 <qemu-ppc@nongnu.org>,  "Zhao Liu" <zhao1.liu@intel.com>
Subject: Re: [PATCH 2/4] target/hppa: defer hppa_ptlbe until CPU starts running
In-Reply-To: <D833X0DADOYN.29O3TB1R6KTUI@gmail.com> (Nicholas Piggin's message
 of "Thu, 27 Feb 2025 19:05:47 +1000")
References: <20250225184628.3590671-1-alex.bennee@linaro.org>
 <20250225184628.3590671-3-alex.bennee@linaro.org>
 <ecce2fe8-f2c0-48fb-a3dd-99a1c4720dd5@linaro.org>
 <c2e62cce-65f4-417e-bd57-85b64e78102c@linaro.org>
 <D833X0DADOYN.29O3TB1R6KTUI@gmail.com>
User-Agent: mu4e 1.12.9; emacs 29.4
Date: Thu, 27 Feb 2025 10:10:18 +0000
Message-ID: <87senzwved.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
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

"Nicholas Piggin" <npiggin@gmail.com> writes:

> On Wed Feb 26, 2025 at 5:38 AM AEST, Richard Henderson wrote:
>> On 2/25/25 11:33, Richard Henderson wrote:
>>> On 2/25/25 10:46, Alex Benn=C3=A9e wrote:
>>>> @@ -191,7 +199,7 @@ static void hppa_cpu_realizefn(DeviceState *dev, E=
rror **errp)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cpu->alarm_time=
r =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 hppa_cpu_alarm_timer, cpu);
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hppa_ptlbe(&cpu->env);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 async_run_on_cpu(cs, hppa_=
clear_ptlbe, RUN_ON_CPU_HOST_PTR(&cpu->env));
>>>=20
>>> Nack, this is emulation of hardware, not softmmu.
>>
>> Hmm.  I see what you're thinking about though: this function, after rese=
tting the data=20
>> structures associated with the hardware emulation, also calls the softmm=
u flush.
>>
>> If we absolutely need to do so, I suppose delaying the hardware emulatio=
n flush to the=20
>> work queue isn't the worst solution.  This is where the hppa patch is mo=
re correct than=20
>> the ppc patch which completely eliminated the hardware emulation flush.
>
> Could we expose a function that performs the hardware state reset,
> and leave the TCG flushing to the TCG CPU reset?

I did consider that - but the function is also called from helpers at
which point you also do need to flush the softmmu TLB. However someone
with better knowledge of the architecture might be able to do a slightly
more refined flush (individual pages or mmuidxs) in those cases.

>
> Thanks,
> Nick

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

