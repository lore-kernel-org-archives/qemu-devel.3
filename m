Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3F89D711A9
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 17:32:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEB1X-0006Qz-3g; Thu, 21 Nov 2024 12:31:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tEB1S-0006PU-Rb
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 12:31:18 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tEB1Q-0007Wg-Vx
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 12:31:18 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5ced377447bso1570912a12.1
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 09:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732210274; x=1732815074; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Praqqp8I6dsHQwEKDhTNHWs+pCPsa5IputlrmSf0uL8=;
 b=FGjN7jhERIexKg9sEK+ArOmfPpBYLkL3RvT96a4O9huYoYLGXBjleGWhh+Tp+nfIbI
 ijXf0qmXN1zyG8vVFVq+53unTuhPv0eFn40xAu0pwYNdMAK0BCO/BEQ6doifBQTSHOUo
 cCtAlX6gWEX+hlkV6GfZPxTG3P27YcqxXrIixStd/6bBGtIfpgNjWY2Q63eWvVGUB1ZQ
 fEYn7YzJc3+chuz+4MWOy33fq5daxuL3J1odVhIGNbNy2ytxuLZzpFf6JIDTUKofjjBT
 BqUcELhQAC+H89UjvMaFw4SnQsao44sr4BajmGy/Fc59ta0dPm19bLHvuI9quWC6tyRU
 GbBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732210274; x=1732815074;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Praqqp8I6dsHQwEKDhTNHWs+pCPsa5IputlrmSf0uL8=;
 b=f3stEElbftsBIYl52h7C9uutq9WC35KeF3F7LwvQkjDhG6beYUJ389y3z9irGBiApA
 BUaKs6kzDGGAq5S02RRSG66x4wCAphAbOTZKQnMh3IZ7SLvDl50zQ1c0XgaHDPPFtvV6
 rbvEbdbWNG0aFQoaLK7GIi333uSVuQf3+khQVNLbCFeEShn631LEizTQuT5Gb0RXZjmv
 pxdTKN7WCLoSaiyotTCpcSdf+UnMIMDNpR0H/yCbD5AzODAAuGdJWuvpo+rUe0sUiB18
 7UaPEIuV93aMuSGYY65T3Q1UHQfFVYSM87VqwE+QX84EUFbmACD+fC73Fepcpala9fWb
 qIVw==
X-Gm-Message-State: AOJu0YxJcLFQXVvlY1LKqZxfXBy2fX40+M+ZbWsCzpfNec6WXWtkz/lh
 CKeP6p12Z38lAeFjrceSJkAFSG1Ye4pcvz/xzXAUWDQyWexxrYP6ZdWWwNA2fYg=
X-Gm-Gg: ASbGnctKeR4ACcs+KMzoxADbXlycoKbSIJfdDZKEuy1GpE3VWGKozou2pqWgK0Sfn3u
 ifciPxW8J/9HYKV8Oc8DLL+yYb6LaI8JiXdjzcPMilM2ZnKuVXUlYiy+/YjBN3uEoH0XLOBNXJy
 d0cZWQZCmaLkRpMfV62Dm42c6kh/K10G82vQsHEffgZ3xcEvYeVzNC3g4IRncqPoN8e1fEkeDfd
 LrtCWZ6lhs/uLUHhyegsaI2VvVcS2Uokiy1yU7xf1h8R1pv
X-Google-Smtp-Source: AGHT+IGRuAuZcXQvPIEASF/8dOyz5NS9R81xG3bES5h2L9RK0NeIU0mTvBbgfiYUjXbBg2SteTtuOA==
X-Received: by 2002:a17:907:3f95:b0:a9f:508:5f5a with SMTP id
 a640c23a62f3a-aa4dd72bdaamr774723566b.40.1732210274212; 
 Thu, 21 Nov 2024 09:31:14 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa4f41530d9sm104785466b.29.2024.11.21.09.31.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2024 09:31:13 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A781D5F7B1;
 Thu, 21 Nov 2024 17:31:12 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,  Daniel Henrique Barboza
 <danielhb413@gmail.com>,  Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,  Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>,  Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Halil Pasic <pasic@linux.ibm.com>,  Christian Borntraeger
 <borntraeger@linux.ibm.com>,  qemu-ppc@nongnu.org,  Daniel Henrique
 Barboza <dbarboza@ventanamicro.com>,  Alexandre Iooss <erdnaxe@crans.org>,
 qemu-riscv@nongnu.org,  Thomas Huth <huth@tuxfamily.org>,  Bernhard
 Beschow <shentey@gmail.com>,  Thomas Huth <thuth@redhat.com>,  Eric Farman
 <farman@linux.ibm.com>,  Bin Meng <bmeng.cn@gmail.com>,
 qemu-s390x@nongnu.org,  Niek Linnenbank <nieklinnenbank@gmail.com>,
 qemu-arm@nongnu.org,  John Snow <jsnow@redhat.com>,  Wainer dos Santos
 Moschetta <wainersm@redhat.com>,  Cleber Rosa <crosa@redhat.com>,
 qemu-rust@nongnu.org,  Nicholas Piggin <npiggin@gmail.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Palmer Dabbelt
 <palmer@dabbelt.com>,
 Markus Armbruster <armbru@redhat.com>,  Weiwei Li <liwei1518@gmail.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,  Mark Cave-Ayland
 <mark.cave-ayland@ilande.co.uk>,  Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>,  Aurelien Jarno <aurelien@aurel32.net>,
 Ani Sinha <anisinha@redhat.com>,  Alistair Francis
 <alistair.francis@wdc.com>
Subject: Re: [PATCH 00/39] maintainer updates for -rc2 pre-PR
In-Reply-To: <CAFEAcA8KD4qxY18pJakSeziTioNYDQkd3VYcxYfq9y2KAON4Wg@mail.gmail.com>
 (Peter Maydell's message of "Thu, 21 Nov 2024 17:19:38 +0000")
References: <20241121165806.476008-1-alex.bennee@linaro.org>
 <CAFEAcA8KD4qxY18pJakSeziTioNYDQkd3VYcxYfq9y2KAON4Wg@mail.gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Thu, 21 Nov 2024 17:31:12 +0000
Message-ID: <875xoglcin.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52d.google.com
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

Peter Maydell <peter.maydell@linaro.org> writes:

> On Thu, 21 Nov 2024 at 16:58, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>>
>> This is a mostly testing focused set of patches but a few bug fixes as
>> well. I plan to send the PR in on Monday. I can drop any patches that
>> are objected to but I think its pretty safe.
>>
>> Contains:
>>
>>   - Daniel's clean-up of functional tests
>>   - Another avocado->function conversion from Thomas
>>   - Update the tuxrun baseline images
>>   - Minor fix to the rust pl011 device
>>   - Documentation clarification on identity
>
> Should we really be updating the tuxrun baseline images
> in the middle of a release freeze period? Unless the old images
> are going to go away and break the tests, I think it would
> be better to stick with what we're currently testing.

Well the arm64be fixed a real problem and while I was at it I figured
might as well keep the rest in sync. I have tested them so they all pass
(although I'm waiting on the CI run now).

>
> thanks
> -- PMM

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

