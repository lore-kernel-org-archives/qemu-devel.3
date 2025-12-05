Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11AB9D2F7EE
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 12:49:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRVEf-0000It-Dr; Fri, 05 Dec 2025 07:48:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vRVEc-0000I6-Mz
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 07:48:31 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vRVEb-0008Gn-38
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 07:48:30 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4779cb0a33fso26679885e9.0
 for <qemu-devel@nongnu.org>; Fri, 05 Dec 2025 04:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764938907; x=1765543707; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lpuVh6DG9qvoJ0274flsNCi6sGerVBh2AYKO8Kbw9zU=;
 b=f+a0bh4/+r/20101xNSmFu+6LwgO7f3+mQLBab5r67T/fsqPdG6lifXpSrbInPF5Yx
 zCMV87GKyOA0y+MwxHAW2rDqHHrVbSY4AO5g55GyorYaQwLcTc6osvRX21P1kYwOy0BC
 tYUQnjIlh5nPvhch0LVIbLUlB2YMxSo7nN05k7JcLfUp9S6xeqySkpz2QU3PSpSvha4g
 KCwM8lQtlFG3EOGbTZEsPPpGsFtYbzRfH2jZIhtv5vvrCcbiG2kAy+2+reAXS82tTDUE
 U7UPOq7WGl0zHhYsgvaSThFvlZQ1/pG2rqJnfUbUDDcsxLKxWpNxY9Fqt8HOUNUm/gyR
 MKDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764938907; x=1765543707;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lpuVh6DG9qvoJ0274flsNCi6sGerVBh2AYKO8Kbw9zU=;
 b=iuzIwp9uCrYNfN4L+0Kr8/1bN7toKzRIbA7qGSRecOn2ZfuGKmI/FIDioRV9FG8lt7
 6Bh681g8Gs0xF6W0yezsgMYtlBNkWbsP3crfDU/KvllloHZoMX3hwkMCT+HvXXhzZ2bN
 GArskO8oYCLGO9uyCNQxRzOi9sng3z8TXQcUVByUr+GrIwrnY/OQBX7gJOYz9ln9fmJ7
 u038nh66Q1uJYTpboVq7fmE5pP2FkzTRrFgvKFdYAHsqv1lI3kauJUDMeCIVcD0xZ1DY
 0+sa827eGZcmrGNoNMzcwcR+RJoStjaqkOsbTSR/uX8r/94vTkdHAb4NJozI4o0VB9TF
 ml6Q==
X-Gm-Message-State: AOJu0Yyshs5HPt6P6+/j+8XDqYIwCHsr523MhIadYEUwKp3jd8NaUGeM
 O5Od36/uEKiMn/NiDg1vKAjjw7EhUutM9sOawKI89nHejObRipMhrhStxwQKwfEhRWM=
X-Gm-Gg: ASbGncv2UJ2H1mUDl87xrfL3UttXS2tcjUvPlY3wOTUbI/z9lGDiCTdYmXdqntfdmz+
 gwRkqh38YC64A0C3XHPPEu7p0Sibr3fmXlRcKrxi1L8+GcmtLl5krqC6q5vTSBcgJeCKGoexDT0
 CP43eZFrzdOaBSlcXDF80HCs4/9S2HEsv2g5kGg2a2lxBHNE98iwi5fhK1w7oefEQHlN5dXNuAE
 l/Lv2SeaT7hehHTP4AETSQaJuQ5B1JYpMLncizwUX+CFxJ2euwDgeT3W6Mo0H374ZaY0BEByYuZ
 w2Jfzi+pRRF5frFx1hRczb+i9I8wJJDOSeDFdHKyimUEUS93mIrohM+gtAjETlhtIPHfiGGX1KZ
 yM+DVwFie6GZKjVGuaAqOW6lROOdMFgzOWY2+VKhuzt9KTUR1GzYTGjnZ5EcEZbBn2O5UNfzhKz
 EAok3C8RzAkUM=
X-Google-Smtp-Source: AGHT+IEv99LC8F9/+jU9bybOxDkL/vVwWgU7AB0pQOQTaULGjtEyfp5BI98abejrNQIakonCK0GIHw==
X-Received: by 2002:a05:600c:a0b:b0:471:13fa:1b84 with SMTP id
 5b1f17b1804b1-4792aeeb501mr116614965e9.12.1764938906993; 
 Fri, 05 Dec 2025 04:48:26 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47930920b6dsm94124215e9.1.2025.12.05.04.48.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Dec 2025 04:48:26 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 88FE95F7F6;
 Fri, 05 Dec 2025 12:48:25 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,  Alexandre Iooss <erdnaxe@crans.org>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Markus Armbruster
 <armbru@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,  Pierrick Bouvier
 <pierrick.bouvier@linaro.org>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,  Qemu-block <qemu-block@nongnu.org>,
 Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v2 05/11] tests/lcitool: add nettle to the minimal deps
In-Reply-To: <f077e5e1-53b7-42d8-b457-90fdf775c71b@redhat.com> (Thomas Huth's
 message of "Fri, 5 Dec 2025 07:37:13 +0100")
References: <20251204194902.1340008-1-alex.bennee@linaro.org>
 <20251204194902.1340008-6-alex.bennee@linaro.org>
 <f077e5e1-53b7-42d8-b457-90fdf775c71b@redhat.com>
User-Agent: mu4e 1.12.14-pre3; emacs 30.1
Date: Fri, 05 Dec 2025 12:48:25 +0000
Message-ID: <87a4zxrt5y.fsf@draig.linaro.org>
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

Thomas Huth <thuth@redhat.com> writes:

> On 04/12/2025 20.48, Alex Benn=C3=A9e wrote:
>> Technically we don't need a crypto library to do the base build but
>> I couldn't see an easy way to skip iotests which would otherwise fail.
>> Besides libnettle is a fairly small library even if its not the
>> fastest crypto implementation.
>
> I think we added checks to some of the iotests in the past already to
> skip if the crypto stuff is not available? So I think it might be
> better to fix the related iotests instead.
>
> Which test is failing for you?

I did have 049 qcow failing and two others but I can't remember exactly
which combo it was. The error messages where all about missing crypto
functions stopping the run.

Where are the crypto library tests done? I couldn't find them.

But I'm happy to drop this patch until we find out:

  https://gitlab.com/stsquad/qemu/-/pipelines/2197896632

>
>  Thomas
>
>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>   tests/lcitool/projects/qemu-minimal.yml | 1 +
>>   1 file changed, 1 insertion(+)
>> diff --git a/tests/lcitool/projects/qemu-minimal.yml
>> b/tests/lcitool/projects/qemu-minimal.yml
>> index 2a1ac51d402..eebdc23e682 100644
>> --- a/tests/lcitool/projects/qemu-minimal.yml
>> +++ b/tests/lcitool/projects/qemu-minimal.yml
>> @@ -18,6 +18,7 @@ packages:
>>    - libffi
>>    - make
>>    - meson
>> + - nettle
>>    - ninja
>>    - pixman
>>    - pkg-config

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

