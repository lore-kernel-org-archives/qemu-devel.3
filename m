Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88155C54E60
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 15:01:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk3cz-0003OA-IO; Tue, 12 Mar 2024 11:01:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rk3cw-0003N2-VT
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 11:01:15 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rk3cu-0003e0-Tt
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 11:01:14 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5683247fd0fso5974010a12.3
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 08:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710255670; x=1710860470; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JvR2A/gItphqab++xjLVt3cm1Cmp3KRosxRE1fr952g=;
 b=FR7bykdJ7EcG3PewtvAgZu0eewSCXPFe0B3gCwmSmhKJB9lUy6vw6qQoNwerMwCa+c
 LV8GmQfxkYiyJduHAyy+7xTczxBz9d7DxgxEWQqhEKQDkLeH0igtf/XSrrhaBWpHeSaY
 NeMUJgu+WTX5l3oQMgt8aLKyeAVB8SKiKQcqu26Jg2lkaVF9xoSNQwStTCPmhE7ET2A9
 2rQXPehgiUUYwi0YpcAaYGqkpSVm1/Z1UdnYbN+04ut5SPaai7qk7S9obhQGkjVGwara
 tXeMmVcJnxHEOZwEhDNPgiUiHumSUjFvYA9Atw12aBujwEG+lQ77DoIs5h3MYtM0j+UN
 XAdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710255670; x=1710860470;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JvR2A/gItphqab++xjLVt3cm1Cmp3KRosxRE1fr952g=;
 b=tvkPeewDegeurxKext5TQPj5TSyaNXarR18iBKjwEAk+6s7dmq7fj74L9oLQKFLX/T
 NXx4YEQoMytogYRWpnNGkjHDvEE+D3a6PaAPg79lZ/uMe2Xf/DpzJK6zJg43nOTZSsKI
 js/s3NXXAMnBZypzohCqaomuwCv/tN2kbUbSAZGuh2XCStwpyl+3GSfa0BkNC9z05zpd
 sMksCd6amYBmieCzGAdnBYKuDqZBPnT8sOQrbKqHRPBr+zAOfFx7u5ruCiIw5zBYCGEh
 18yLv2stE6nfL9y3L9SQPC9s9u3CpUIT08dk7nP6eZ2qKnEnLM1PVxcpncZoLUz7fIGw
 88fA==
X-Gm-Message-State: AOJu0YxWnecZGb8Pz4BEQ8Ob87yxljPHq7GbbTwVfeeqSrB568ovD0E5
 0X0xm0tmVDP+4Pd0tgq/YOMc3j4B+7Xtr+RHp3ENAJcvtJ8rBzvS6TGwyhJQIMhGgnlz71Img23
 j
X-Google-Smtp-Source: AGHT+IGt13b2Pm3oC/08L2C5fOnz3ud9miltBb+UmgoYlzdCpQ25BfxOzX86wFnWJwJfrWYNpCdRPQ==
X-Received: by 2002:a50:bac6:0:b0:567:ff9a:d5e0 with SMTP id
 x64-20020a50bac6000000b00567ff9ad5e0mr7396213ede.29.1710255669878; 
 Tue, 12 Mar 2024 08:01:09 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ij12-20020a056402158c00b00562d908daf4sm3999829edb.84.2024.03.12.08.01.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 08:01:09 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E06E45F756;
 Tue, 12 Mar 2024 15:01:08 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL for 9.0 0/8] final maintainer updates (testing, gdbstub)
In-Reply-To: <CAFEAcA_Vok6GcphdFv_NZv7iCeLpebS9JWZW5yHeRx1w9EY00g@mail.gmail.com>
 (Peter Maydell's message of "Tue, 12 Mar 2024 13:42:32 +0000")
References: <20240312112532.1558319-1-alex.bennee@linaro.org>
 <CAFEAcA_Vok6GcphdFv_NZv7iCeLpebS9JWZW5yHeRx1w9EY00g@mail.gmail.com>
User-Agent: mu4e 1.12.1; emacs 29.1
Date: Tue, 12 Mar 2024 15:01:08 +0000
Message-ID: <87jzm7o5or.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

> On Tue, 12 Mar 2024 at 11:26, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>>
>> The following changes since commit 7489f7f3f81dcb776df8c1b9a9db281fc21bf=
05f:
>>
>>   Merge tag 'hw-misc-20240309' of https://github.com/philmd/qemu into st=
aging (2024-03-09 20:12:21 +0000)
>>
>> are available in the Git repository at:
>>
>>   https://gitlab.com/stsquad/qemu.git tags/pull-maintainer-final-120324-1
>>
>> for you to fetch changes up to 0532045e8112c13a8a949e696576672e64c6fa14:
>>
>>   gdbstub: Fix double close() of the follow-fork-mode socket (2024-03-12=
 10:48:35 +0000)
>>
>> ----------------------------------------------------------------
>> final updates for 9.0 (testing, gdbstub):
>>
>>   - avoid transferring pointless git data
>>   - fix the over rebuilding of test VMs
>>   - support Xfer:siginfo:read in gdbstub
>>   - fix double close() in gdbstub
>>
>
> This makes the s390 CI jobs fail:
>
> https://gitlab.com/qemu-project/qemu/-/jobs/6374182015
> https://gitlab.com/qemu-project/qemu/-/jobs/6374182020
>
> fatal: --filter can only be used when extensions.partialClone is set

That's annoying - I thought I had the s390 jobs in my matrix but it
seems they don't appear anymore. That said I see:

  root@qemu01 ~# cat /etc/lsb-release=20
  DISTRIB_ID=3DUbuntu
  DISTRIB_RELEASE=3D20.04
  DISTRIB_CODENAME=3Dfocal
  DISTRIB_DESCRIPTION=3D"Ubuntu 20.04.6 LTS"

And as 24.04 is just round the corner maybe its time I update the system
to a more recent ubuntu (with I assume a more recent git)?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

