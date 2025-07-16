Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EE9EC83F1B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 12:34:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uc1Jr-0002aD-Kb; Wed, 16 Jul 2025 08:33:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uc14z-0001x0-Fu
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 08:17:52 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uc14m-0004no-Sy
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 08:17:44 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3a531fcaa05so3667154f8f.3
 for <qemu-devel@nongnu.org>; Wed, 16 Jul 2025 05:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752668248; x=1753273048; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pt4151ltd6pu825F+pTiTobrWfgPk6VdhkoM907zbc4=;
 b=Q+5eDbC/v66dKk8P6MhBNshu+Ws2iykLLT1+VVQduWXqWFYNrymCFMSDnpEilqY5Iy
 1Z/JhLbpwG0mHRZ7mgB4gPS5IZooONhscgoIZXWMfEsPJy11fjLfd2CPMW+LXC1bnkLs
 sQi0cu+IP8KenpH+A5Zj1hxr07Ut59ZvUdR1NpQVfeDm4OjzDzCaGlDse0xH++k5wU3I
 i7k3pe1ORiSAHLquWVOVLyZhr63Bhn/xYfSPJwqLGWm4w8F+9tiF6PvFdJyegXhdiKPV
 q7igO35+OcYdJrQ8ZuAk+CDYG7R/yvMx+CZ9qSv+Ns04kE7T0syqHx8oPMwWNUNjQkV8
 ioyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752668248; x=1753273048;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pt4151ltd6pu825F+pTiTobrWfgPk6VdhkoM907zbc4=;
 b=eiUeOp/AIKl/JC9Tu8fGdjHuEWQNjkhjBZobjREXXHD/NlWjfPZwxKqqH1qQ9VFCFN
 7MslCwgJSUZPHXiKl5Yme56C4G8z2kMUHMNK9c0JHY6DCStIQtGJ5Kl3nIJqys9bT6Ml
 p8uJzZli9ATfGHuV90a5oCYFlyfDTO+uPbbDzMS4bcD+vSVQpTv13bkvm/eOCDY0vbYZ
 fiEggkSFEua2FhGr76aSToVte/dFUvXo1cvugk3zn3EkZBJLHALzKA1r6xHwc7HPSJn5
 9lwnmdvtNjzsHL5pd2HZHXvcXXnpdHRAq5r2uJSFeQfx4nnHVe00krNoEn0cv+LFFoNP
 QE/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXcT1EqKhjTvASLo0KfeI7i3xP5MjLaeHvKNOZTbCMpLTCEs3YaClIuXc8gQptPvaNp1GmMtBY40lJL@nongnu.org
X-Gm-Message-State: AOJu0Yxes4/JHEzpXS3i4klhCtKOAcM86+1tOcVoQIf9GX3+rL6qTWhE
 n8ysR8HoPiNVmwijMoRLMu5kxJRlMLWZyHsNzpDuqehZCgIbOy3tUEo7t4LYcAZ08+8=
X-Gm-Gg: ASbGncuxS7HNpvj4nOIbl+iHvQPLjgKcCEJHTisr6AsApf5mO+9gvJx4dFTJJVK9QsD
 LlDcACrfP7cTkjccYe7/dtiD8qDQmC7z31pYFDtqVOgUqC3cr3LUx7BG5N3eUHcS9CDmdi3JPPF
 L4JBkkDEN4TLdK2HcZ4HWVolb2TgX4WZkc5TWFkSsTBswKx6y/gNuvI66YOt1Gdn/Btvwa82jtE
 xp6sXb8DAvbldaevQYhLRInLXr3S6QFftCBcCfJzWVvoP0ICSMJ98NXGly50e9EcC0tDyp37JAy
 /epZbJlOCAn8J7+xk9BI2On4QkPcCdxpbB/ypzwk1vNNfdLIOezvx2pmcsYbKiY52iXBkxVpUgK
 aYu80vZ1Ere0C9hALE5X38DY=
X-Google-Smtp-Source: AGHT+IEk43coNmJvYrMRL+Dr+vULtgyIWQFEOK6MH0iZYiQRV6g9qeX9Riug3W44Izhek1rWj0uReA==
X-Received: by 2002:a05:6000:40de:b0:3b6:1e6:c9fb with SMTP id
 ffacd0b85a97d-3b60e4c510dmr2188871f8f.11.1752668248256; 
 Wed, 16 Jul 2025 05:17:28 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4562e80246asm19489535e9.10.2025.07.16.05.17.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jul 2025 05:17:27 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3893D5F885;
 Wed, 16 Jul 2025 13:17:26 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Danny Canter <danny_canter@apple.com>
Cc: Joelle van Dyne <j@getutm.app>,  Marc Zyngier <maz@kernel.org>,
 qemu-devel <qemu-devel@nongnu.org>,  Alexander Graf <agraf@csgraf.de>,
 Ynddal <mads@ynddal.dk>,  Cameron Esfahani <dirty@apple.com>,  Roman
 Bolshakov <rbolshakov@ddn.com>,  Phil Dennis-Jordan <phil@philjordan.eu>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Richard
 Henderson
 <richard.henderson@linaro.org>,  Peter Maydell <peter.maydell@linaro.org>,
 Mark Burton <mburton@qti.qualcomm.com>
Subject: Re: HVF EL2 support in QEMU (aka FEAT_NV/FEAT_NV2) for MacOS
In-Reply-To: <03A3BBBF-6A01-4ECB-BE50-8103B9201528@apple.com> (Danny Canter's
 message of "Wed, 16 Jul 2025 00:27:00 -0700")
References: <87zfd5zouv.fsf@draig.linaro.org> <86wm898yf4.wl-maz@kernel.org>
 <CA+E+eSASz9Tx76-8PxMNF30f3L9DfPNYf_Zgf=ENozXapc3gyw@mail.gmail.com>
 <03A3BBBF-6A01-4ECB-BE50-8103B9201528@apple.com>
User-Agent: mu4e 1.12.11; emacs 30.1
Date: Wed, 16 Jul 2025 13:17:26 +0100
Message-ID: <87a554z5wp.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x435.google.com
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

Danny Canter <danny_canter@apple.com> writes:

> Joelle is correct, M3 and newer SoCs have support for the EL2 APIs.

Thanks for the confirmation. I'm looking at getting a M4 Mini for my
team so we can help review and test patches for HVF going forward.

Are you aware of any work that needs doing in the wider QEMU to support
nested virt or should it just be a case of doing the plumbing in
accel/hvf to turn it on?

>
> -Danny
>
>> On Jul 15, 2025, at 8:53=E2=80=AFAM, Joelle van Dyne <j@getutm.app> wrot=
e:
>>=20
>> UTM currently supports NV only with the Apple Virtualization backend,
>> not QEMU HVF. While M2 supports NV, it is not enabled by XNU kernel
>> and `hv_vm_config_get_el2_supported` returns false. I heard there was
>> some compatibility issue in the hardware. M3 and newer generations
>> fully support NV in hardware and by XNU.
>>=20
>> On Tue, Jul 15, 2025 at 4:51=E2=80=AFAM Marc Zyngier <maz@kernel.org> wr=
ote:
>>>=20
>>> On Tue, 15 Jul 2025 12:15:52 +0100,
>>> Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
>>>=20
>>>>  - do we know which Apple silicon supports FEAT_NV2?
>>>=20
>>> M2 and latter definitely support FEAT_NV2. That's how KVM NV support
>>> has been developed for two years until I was given better HW.
>>>=20
>>> Whether Apple supports NV on M2 in HVF, I have no idea. The rumour
>>> mill says "no", but I don't have a way to check. The M3 I use at $WORK
>>> is definitely able to give me EL2 without VHE with UTM. I haven't
>>> played with M4, but I have it on the record that it behaves like M3
>>> with UTM.
>>>=20
>>>        M.
>>>=20
>>> --
>>> Without deviation from the norm, progress is not possible.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

