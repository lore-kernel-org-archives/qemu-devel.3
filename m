Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CF73D2FFE6
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 10:22:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1k87-0005hh-BN; Fri, 18 Oct 2024 06:22:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t1k85-0005hU-TV
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 06:22:45 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t1k84-0005x7-7S
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 06:22:45 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-37d70df0b1aso1490996f8f.3
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2024 03:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729246962; x=1729851762; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JvdD1zvR7pitmvPu5UIzdTzIQaO+R+2TKdsKCLTLB+w=;
 b=W2pxnp6YN655mqjLfB7XSMWQ4LmzLNtJ3WijlgjDrmXxiE2tR/BiylcpUxOZD7eXz7
 B5hDKJrAfIm2U/ijKAdgde4Czb2hX7dmXEl1W5ER6gGPq2hy05YXvV2APIcy8X0vif24
 KTXkBAgh2Jv+Dhwedkf78RPD6T6RcK8HoN+zCc/L2rm9sAUzx3hLK6X7/Wey0ywbloON
 QJNy2ERO9UN12oSct4Q8w8PQ3drOP9DvgBsMJRcn8QbZMFE57DW964WxrCU8El9JRIB/
 rFAjZB8UIe8IPM14J+gOz4L4rGi189fDYC2Chiz7r/TQYgo/iQJHMYdc8PeAAZrt8500
 2cEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729246962; x=1729851762;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JvdD1zvR7pitmvPu5UIzdTzIQaO+R+2TKdsKCLTLB+w=;
 b=YysMfHTFEw+bPROUsrRxZlP6TTEYMyq6X2SfB96xRjtjI+PmlPfBNQe5Yg5+Ie2kDT
 U1oLQ/rx2CE/Rvpzx3tEVRFUwUxu0W13lh4+4sA5g3+ta8m6+T2stmbmkbFCptrCTpOG
 ndMsGd+OuJoZ2MgeAV6951FRSMxNQYxws6LobS9ZB+5bX6/eancpoDFzmcHdSZMBq1tk
 +F1uBi/jbE5oUv0Rzvbbd3oOgxWXDRPugP3yy/81q2CjoX24HScP+ZucH/pyVy3OzSMM
 7YnHLepTlZuWL4qeeds9TFKQb3ufYrEV0l166fSLAbvscHgGFcmpmUWfr5tPfv/Qeujl
 fnNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMmeVXXuCPV9s+qXP78tnN0HxQ4yuxqAcZ/8emw25Qhqnbsab9T7n7vm6Gky6C0hH/IAWhL/NxE+VJ@nongnu.org
X-Gm-Message-State: AOJu0YzvuG+mFmLHmbiDHlTScAXz7sHRG819yeM+TnxxF/eB+bj5M6sd
 LYe01CMqNCQUFK1C/7YCIUyDaSZfJyaOKxYXgyUKaLpAcK0Wq5txYErbmdlwRUc=
X-Google-Smtp-Source: AGHT+IHCQcQAOeIFmFjqShlV5pLAgzEU9dc7dJq9mnMndfU3VrQtYqTb6xx9TFAcF6AySuy6pyE1wQ==
X-Received: by 2002:a5d:63c8:0:b0:37c:d2ac:dd7d with SMTP id
 ffacd0b85a97d-37eb48937f9mr1160741f8f.30.1729246962430; 
 Fri, 18 Oct 2024 03:22:42 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37ecf0ed5a5sm1543061f8f.74.2024.10.18.03.22.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2024 03:22:41 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 18E825F863;
 Fri, 18 Oct 2024 11:22:41 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>,  open list
 <linux-kernel@vger.kernel.org>,  Linux ARM
 <linux-arm-kernel@lists.infradead.org>,  qemu-devel@nongnu.org,
 lkft-triage@lists.linaro.org,  Linux Regressions
 <regressions@lists.linux.dev>,  Catalin Marinas <catalin.marinas@arm.com>,
 Mark Brown <broonie@kernel.org>,  Anders Roxell
 <anders.roxell@linaro.org>,  Arnd Bergmann <arnd@arndb.de>,  Dan Carpenter
 <dan.carpenter@linaro.org>,  Aishwarya TCV <aishwarya.tcv@arm.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: Qemu v9.0.2: Boot failed qemu-arm64 with Linux next-20241017 tag
In-Reply-To: <CAFEAcA-39GRpvy5LOZSJL3=9FMspAq9c8GUtHv9CP4jU2uFi1w@mail.gmail.com>
 (Peter Maydell's message of "Fri, 18 Oct 2024 10:48:02 +0100")
References: <CA+G9fYvx05D7TfRjvdPtKM9iWS6i7b-EHuBAbHEQghvMEg221g@mail.gmail.com>
 <871q0daglh.fsf@draig.linaro.org>
 <CAFEAcA-39GRpvy5LOZSJL3=9FMspAq9c8GUtHv9CP4jU2uFi1w@mail.gmail.com>
User-Agent: mu4e 1.12.6; emacs 29.4
Date: Fri, 18 Oct 2024 11:22:41 +0100
Message-ID: <87jze590cu.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42e.google.com
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

Peter Maydell <peter.maydell@linaro.org> writes:

> On Fri, 18 Oct 2024 at 10:46, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>>
>> Naresh Kamboju <naresh.kamboju@linaro.org> writes:
>>
>> > The QEMU-arm64 boot has failed with the Linux next-20241017 tag.
>> > The boot log is incomplete, and no kernel crash was detected.
>> > However, the system did not proceed far enough to reach the login prom=
pt.
>> >
>> > Please find the incomplete boot log links below for your reference.
>> > The Qemu version is 9.0.2.
>> > The arm64 devices boot pass.
>>
>> Can confirm it also fails on the current master of QEMU:
>>
>>   #0  __pthread_kill_implementation (threadid=3D<optimized out>, signo=
=3Dsigno@entry=3D6, no_tid=3Dno_tid@entry=3D0) at ./nptl/pthread_kill.c:44
>>   #1  0x00007ffff4a3ae9f in __pthread_kill_internal (signo=3D6, threadid=
=3D<optimized out>) at ./nptl/pthread_kill.c:78
>>   #2  0x00007ffff49ebfb2 in __GI_raise (sig=3Dsig@entry=3D6) at ../sysde=
ps/posix/raise.c:26
>>   #3  0x00007ffff49d6472 in __GI_abort () at ./stdlib/abort.c:79
>>   #4  0x00007ffff6e47ec8 in  () at /lib/x86_64-linux-gnu/libglib-2.0.so.0
>>   #5  0x00007ffff6ea7e1a in g_assertion_message_expr () at /lib/x86_64-l=
inux-gnu/libglib-2.0.so.0
>>   #6  0x0000555555f45732 in regime_is_user (env=3D0x555557f805f0, mmu_id=
x=3DARMMMUIdx_E10_0) at ../../target/arm/internals.h:978
>>   #7  0x0000555555f5b0f1 in aa64_va_parameters (env=3D0x555557f805f0, va=
=3D18446744073709551615, mmu_idx=3DARMMMUIdx_E10_0, data=3Dtrue, el1_is_aa3=
2=3Dfalse)
>>       at ../../target/arm/helper.c:12048
>>   #8  0x0000555555f4e3e5 in tlbi_aa64_get_range (env=3D0x555557f805f0, m=
muidx=3DARMMMUIdx_E10_0, value=3D107271103184929) at ../../target/arm/helpe=
r.c:5214
>
> I investigated this yesterday when Catalin reported it
> and sent a patch:
> https://patchew.org/QEMU/20241017172331.822587-1-peter.maydell@linaro.org/

And here was I thinking I was being efficient ;-)

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

