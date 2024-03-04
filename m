Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66678C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 18:27:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhD1X-0000L2-08; Mon, 04 Mar 2024 13:26:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rhD1U-0000Kg-Ef
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 13:26:48 -0500
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rhD1S-0002Ip-HA
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 13:26:48 -0500
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2d21cdbc85bso58516301fa.2
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 10:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709576804; x=1710181604; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=70RXcQO9jxZlNYt5AT8nNRJeSSZkLLXOYZ2GqhwyGNA=;
 b=ievixOuh8rPrmPFkl6xTtpc/CGveY1WmSF9yeunZsvTsauMJFljY4zNpIA/dQsZ/qh
 AQW7eDteddb3lBhlxGf629xbvnNpPCum3zwxpSz7e//AFVxnzUJcrh/iSmuHRqIrMA0N
 HqRrmM/RH/c3cUHN8jWFLP7MKpUnLoPQSpuMuWjkqKMTrcNF56KCFvOFb8wxHL91XuXQ
 9Jzw9AQUDzJsfJ0eJYObM9qfiQnBzPaz0ni7Y4/AeDv8LG6vAJTvSO4Ucdag6UCwMsZy
 AAGvtxHT8KDzpKtR45B9HZx73oalcWt7lBKHZ6IzrSyC+DzEK/dFO+6UHbta49WmgyOU
 FpuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709576804; x=1710181604;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=70RXcQO9jxZlNYt5AT8nNRJeSSZkLLXOYZ2GqhwyGNA=;
 b=nY9lz+42Cnxl+2SXjGlpLEegRK7WZQ9VcmP9d7WD8P0IPWPJwbj6b8zZ49/1ZArx7D
 y0NT5DrsvC8VCa9xodW2TSXE6P6Qntp2E207JQV0Zm3PSgfjecRQqzq/Fy4h3TOvAlEF
 ortGfGhDAWSeZ/EzMp2GLNIOJ4KWynFZup+njH4C7Q/uR63xPsbRLkyKlHhErfEGnn6E
 kZfN15l4bLlv4YWqpk5YpEiKFpi5rAb3r5JRlCXqVzcmaSXo93FcxbTkQTCKS+iNKPMB
 0D+efFYWKp6Za/m5kwgpZtdLRVlnASLpyJPyRjG6oJM6oFdceo9B93N97XKSAGzWcfZv
 OfEQ==
X-Gm-Message-State: AOJu0YxZeGY3RI0RqrS4KSxVKNM5oPAfOY9ga+y/gOvNl4HD42Pn0nuo
 AjCPjUTZ4WrxToMMeftrTyGGLJZcNyLzqIRrSJMi5F9gsCZ0kCqO1gcklNx3Pwc=
X-Google-Smtp-Source: AGHT+IGIMkzo+sG9gs9AdvOZ4HGHvCSnZZE8o/GqM0HK9iGVOEUIUijXigH/KXhmBvzWc+93tEXnvA==
X-Received: by 2002:a2e:b614:0:b0:2d3:982d:aaee with SMTP id
 r20-20020a2eb614000000b002d3982daaeemr3139261ljn.16.1709576804195; 
 Mon, 04 Mar 2024 10:26:44 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 t16-20020a05600c451000b00412e13bb942sm4819952wmo.19.2024.03.04.10.26.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 10:26:43 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 862F25F888;
 Mon,  4 Mar 2024 18:26:43 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Subject: Re: [PATCH] tests/tcg/multiarch: Give the 'memory' TCG test a
 larger timeout
In-Reply-To: <CAFEAcA9QbbOuzeo+bTRAdTCS2h6gTocbMsgj3k3DNP=H4Bh0Ag@mail.gmail.com>
 (Peter Maydell's message of "Mon, 4 Mar 2024 17:28:46 +0000")
References: <20240227142316.1827154-1-peter.maydell@linaro.org>
 <CAFEAcA9QbbOuzeo+bTRAdTCS2h6gTocbMsgj3k3DNP=H4Bh0Ag@mail.gmail.com>
User-Agent: mu4e 1.12.1; emacs 29.1
Date: Mon, 04 Mar 2024 18:26:43 +0000
Message-ID: <87v861x38c.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x232.google.com
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

> Ping for review?

Ahh we crossed streams because I merged:

  cdb5bfc9f34 (tests/tcg: bump TCG test timeout to 120s)

Do we need even more time?

>
> thanks
> -- PMM
>
> On Tue, 27 Feb 2024 at 14:23, Peter Maydell <peter.maydell@linaro.org> wr=
ote:
>>
>> The 'memory' TCG test times out intermittently on our cross-i686-tci
>> CI job. We expect this to be a slow config (it's using TCI), so it's
>> possible that when the CI runner is heavily loaded it tips past
>> the timeout.
>>
>> Double the timeout for tests.  If this doesn't resolve the
>> intermittents we can assume we're looking at some kind of
>> TCI-specific hang.
>>
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2079
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>> I could not figure out a way to get the timeout to apply to the
>> 'memory' test specifically (including all its variants like
>> running with plugins or the gdbserver or record-replay).
>> ---
>>  tests/tcg/Makefile.target | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/tests/tcg/Makefile.target b/tests/tcg/Makefile.target
>> index 8cf65f68dd8..af1a18cee1b 100644
>> --- a/tests/tcg/Makefile.target
>> +++ b/tests/tcg/Makefile.target
>> @@ -98,7 +98,8 @@ QEMU_OPTS=3D
>>  #   15s    original default
>>  #   60s    with --enable-debug
>>  #   90s    with --enable-tcg-interpreter
>> -TIMEOUT=3D90
>> +# The 'memory' test in particular is very slow under TCI.
>> +TIMEOUT=3D180
>>
>>  ifeq ($(filter %-softmmu, $(TARGET)),)
>>  # The order we include is important. We include multiarch first and
>> --

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

