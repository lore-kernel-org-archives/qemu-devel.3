Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74E37E7718A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 11:15:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOay9-0002RW-B0; Fri, 20 Dec 2024 06:14:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1tOay5-0002RB-FX
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 06:14:53 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1tOay2-0007qn-CY
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 06:14:52 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5d0d32cd31aso2476551a12.0
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 03:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734693288; x=1735298088; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TRttimciKNWbOBQbDSLGgef5Dm3DNalqU4XVfSoEJWo=;
 b=aTlAQ1N8rms57TfRYKoPGvE1gi9xkqM9XlZP3lfNq29v0xRvbLNX9kBQ1Q8MQRa9pU
 bWmbNbjUM7DCG0DPP41QiOd/R4Y5/V+KNfzFuMg3L3y+7C/L4tQY/MX+4iHTPo9incqN
 9vYKvIls8z7+gHr3RgaPC2KORhyakXYxuxciYqZTHMKBnkA3jEYyFL1RYx9ZvFMRe1Xd
 2KJFaCeSY1vDq7aP75DjLgy0ajPoH0T039EQeqq/RRvapVtI8XwIRScXiCzsiMEkuMaK
 aw7eKeDvxJz0DJeUHVnMkXeZ2VnWGa1r9FKckeVjsXA2EmQwyVt1oaWWO13tenRQvfwP
 yE7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734693288; x=1735298088;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TRttimciKNWbOBQbDSLGgef5Dm3DNalqU4XVfSoEJWo=;
 b=L+N6UiaxspfFwjOuJsR65e0WrRjcba14ocG3AtCBt2qZDZqRnF9kI0pCTrx79+kQ4R
 G1BF6l1HG8fexjNfBMAkFT2z8zhhQ4plPCusOHFyf4wdJw5L+3mMZFZ5AvQBpQKH2aVE
 ckoyykdjFziorvxtzITPgvjbDZ3LSx1Wq47G1qf8tCn33OD60axngxwYVEzqa1dFPmol
 hpVpCNglpDgx5S7CCUCCHAXdKa/n2swkMaEmrcd/rVI7t822j5BAlSCo9F8gYXPcHgmB
 X72JSCdkUdZ1Cz8L5DGoe7MAip3nFPj79NMr1yDfDmF4ZOa/OpHNzIeiXRmTimaiaDZk
 /cgw==
X-Gm-Message-State: AOJu0Yyvt8g48bzmXyQHgXoYynU1wsMbjv6No3NXCq4ILwWed1OMp2mh
 t/0MZQQR7Ypz/rl0hdMZ6dUa/b7j4Sozege39qEsbF6GQZnfRnitccNUGQ==
X-Gm-Gg: ASbGnct66faKyNfV3nDWJtILfRPMnPqHaQ0Kz2d+5Job7zZLpN7CGRDgJeAZbq3P4QF
 ieOmFQqTvuzMUDpqDgqsUdTw//gaqpO1Q/l6ODVGgnxFEBGHikyNVlh7XmceG1YRdNK2qFKDBMI
 N8COTGai7iJyqU3KtDwt9I+BaGh9bRh37LQS2z8d+Yq9dHJa3ZVY7Fnq+vXCGuZF7O5NL5sobrI
 6n3VRYW/ULMLLSBGJR5D5UChgPNzPLO5EaMhQepgcj64a+LFuuD6ziEksGmW/zhslvjoFBMbgcS
 3kKsH7d3aZsbFwf5m0Wey3K+hKpOJg==
X-Google-Smtp-Source: AGHT+IGZ5ifh67+bU122AvUEAlyDVGZg8fV5tRM/CbsPg/15IqbQeUbaeC6X5ofJHt+NAj+1wW9CXQ==
X-Received: by 2002:a05:6402:350b:b0:5d0:c7a7:ac13 with SMTP id
 4fb4d7f45d1cf-5d81de33ee2mr4709444a12.34.1734693287892; 
 Fri, 20 Dec 2024 03:14:47 -0800 (PST)
Received: from [127.0.0.1] (dynamic-002-242-092-209.2.242.pool.telefonica.de.
 [2.242.92.209]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aac0efe4e5csm165596666b.115.2024.12.20.03.14.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Dec 2024 03:14:47 -0800 (PST)
Date: Fri, 20 Dec 2024 11:14:46 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org, Davidson Francis <davidsondfgl@gmail.com>,
 Warner Losh <imp@bsdimp.com>
CC: QEMU Development <qemu-devel@nongnu.org>
Subject: Re: Ideas to Improve GDB Stub in Qemu for i8086
In-Reply-To: <20241220003426.GA2475@darkstar>
References: <20241219013535.GB4298@darkstar>
 <CANCZdfodkH0Mf8jkxs3Gybh8-nOAm79X+QXrbAvo0RHR9tBfXg@mail.gmail.com>
 <20241220003426.GA2475@darkstar>
Message-ID: <0F6191A1-9CBA-4415-B7F6-608B3ADBF870@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



Am 20=2E Dezember 2024 00:34:26 UTC schrieb Davidson Francis <davidsondfgl=
@gmail=2Ecom>:
>On Thu, Dec 19, 2024 at 09:51:13AM -0700, Warner Losh wrote:
>> I might be interested in debugging some i8086 stuff for my Venix/86
>> emulation
>> project=2E
>>=20
>> I'm curious, though=2E I see special cases just for EIP being returned =
as (CS
>> << 4):EIP
>> and similar for ESP being just (SS << 4):SP=2E What does the debugger d=
o,
>> though,
>> for other cases where you need segment:offset addresses? Does it transl=
ate
>> properly
>> behind the scenes in ways it doesn't do for ESP/EIP or do you have to
>> examine those
>> addresses by hand as well? If I'm chasing a linked list with 16-bit
>> addresses that assume
>> a particular DS, how does that work?
>>
>
>You've brought up a very interesting point=2E Indeed, in the case of=20
>linked lists and similar structures, there=E2=80=99s no way for GDB or QE=
MU to=20
>reliably determine which segment an address might belong to=E2=80=94perha=
ps=20
>only guesses, which are far from ideal=2E =20
>
>That said, the approach I'm proposing doesn=E2=80=99t solve all problems =
and=20
>still requires users to handle these conversions manually or through GDB=
=20
>scripts=2E =20
>
>The main goal of my idea is simply to reduce the initial effort required=
=20
>to debug i8086 code, avoiding workarounds with architecture XML files,=20
>and proper instruction disassembly and stack dumps out-of-the-box=2E

I suggest to submit a patch with a descriptive commit message to see where=
 it is going=2E To me, your changes seem reasonable and I could have benefi=
ted from them already in my VIA Apollo Pro 133T project [1] where I made so=
me real-world bioses run in QEMU=2E

Best regards,
Bernhard

[1] https://github=2Ecom/shentok/qemu/tree/via-apollo-pro-133t

>
>Kind regards,
>Davidson Francis=2E
>
>

