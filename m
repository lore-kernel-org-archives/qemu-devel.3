Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E85CEE7719C
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 11:55:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWDbU-0006CC-15; Fri, 10 Jan 2025 06:55:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tWDbQ-0006Bw-2Q
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 06:55:00 -0500
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tWDbO-0008QV-Ic
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 06:54:59 -0500
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-aa69107179cso392171566b.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 03:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736510097; x=1737114897; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g8fAIRRo0+6zPrMEvvHB1BY6adWi/YL+xrnwVZIMSaE=;
 b=ZKyGInQMbJX6RDDj7H0ruu0t4/fbeU1+NgjQyJpFMT/vLbj+H+ouDvQFxl4tVzpa/Y
 auHbEOEo/ovDt0Wp8SgrzUByEZ3RNj9BEeVlMKdsiHjLmZS1Gl8zmDvqrKOtBFkLH2C0
 hoz4vINmpWDbM0gCWvN/pvabmNeoMBcciG35wMuu9RSFjhUXadktGc0K3gHQnWvoqYfB
 AHMHGuoGlvhexmkoLPwkUtk77IHXM5z4fF21FIbQFevskiSW7rJmzOaQ0KQs9OEFQwVs
 hAA8mXmjNnG7AbP0BSkb8Ldj45fVdGi0HQXqlNBpw/+U+x0FMep3Y7TzhGOLsiMZtNtd
 6Hfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736510097; x=1737114897;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=g8fAIRRo0+6zPrMEvvHB1BY6adWi/YL+xrnwVZIMSaE=;
 b=meuoxHJBUTyYwwDrG9MM1oEEsUb62zMfzYnrofsgNTsxPYqVnRuoRQcngea+Q6RYY1
 it1P8IsuiFlIpnaxxcrtOZt15Xgr5B0MheJ/PZZ5z/TFWgA/c+KEKq7fdsd4S183zVd7
 w6gMX/figF/vzQQZ8acJVq0ISZN16g/n7mNC2K87raPv+UEEUNK+e+Sp/SrGhpGprc5y
 hRuIE0nYpsK2CXs+if6aR/PyHKTc2ny22lpO1q6wkqPwyCwNhbt+16LjuVwGXxDtHvDW
 nn54uKK2UUKZw1clnJb0nn/PSN9ClDjNvnVU8iZE/IWpsOsxEMt6ARamQynTnZ5lm3sx
 j11w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzc5SwXpZmvPUYP8HDDiYDPG3A0sdIWduloraEsMXMzKdwRR2NxMK0actuPSGG39n/vpdEvZ+dohTb@nongnu.org
X-Gm-Message-State: AOJu0YwBmoV/Uwy2bodYPjnz77gP9XaJ1jINOK/7KkmAbRZ6S1V73IOe
 2DFvcSGwz4cACWs7AuWl9bd/KsDCs9sn8fHSLMO6dtIYkvSlpBJYa3ndm4hpCds=
X-Gm-Gg: ASbGncth4txqFeu9Jdfv+ogvH6aD/IPsyUuPn6X11w5tSdLRKEMivvMvvYVvtgw3IyJ
 Bb29IjKj4EoRv5yMadk9SGwrHsbQJgRkvoKIernWHc6Tnz9G9I7j4d0zmb1tju4cMSeW1iMuviK
 Em1q+0y05JVEGOF68s5JXiFYKztztEWOu9mT0i04Uy8zbgN91v/QbUqZQYbvl+AoNMaoZtZqtYs
 1te0RLNYfiiNVk0YrJwccsony93FJHe4O86RQIiPEbZg0Az8TmAILU=
X-Google-Smtp-Source: AGHT+IFoPFYO98Z6L+ygMRlmRNKED15lSyeyEmSyoQLJR9Zo1/guz4QcsE4e5poXuitF4Puebp/ccg==
X-Received: by 2002:a17:906:c156:b0:aa6:2704:4840 with SMTP id
 a640c23a62f3a-ab2abc8f108mr925228866b.51.1736510096811; 
 Fri, 10 Jan 2025 03:54:56 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c90dacf1sm161739366b.63.2025.01.10.03.54.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 03:54:56 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 728935F8C8;
 Fri, 10 Jan 2025 11:54:55 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,  qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dave@treblig.org>,  Thomas Huth
 <thuth@redhat.com>,  Mahmoud Mandour <ma.mandourr@gmail.com>,  Alexandre
 Iooss <erdnaxe@crans.org>,  Richard Henderson
 <richard.henderson@linaro.org>,  Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,  Ilya Leoshkevich <iii@linux.ibm.com>
Subject: Re: [PATCH 10/22] system: propagate Error to gdbserver_start (and
 other device setups)
In-Reply-To: <b46d7d01-ae4d-4c47-a3df-93ad46ff6a1d@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Thu, 9 Jan 2025 23:27:33
 +0100")
References: <20250109170619.2271193-1-alex.bennee@linaro.org>
 <20250109170619.2271193-11-alex.bennee@linaro.org>
 <da769717-0823-45b4-8b1c-9fd2611d0092@linaro.org>
 <87bjwf6abf.fsf@draig.linaro.org>
 <b46d7d01-ae4d-4c47-a3df-93ad46ff6a1d@linaro.org>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Fri, 10 Jan 2025 11:54:55 +0000
Message-ID: <87tta651f4.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x635.google.com
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> On 9/1/25 20:45, Alex Benn=C3=A9e wrote:
>> Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:
>>=20
>>> On 1/9/25 09:06, Alex Benn=C3=A9e wrote:
>>>> This started as a clean-up to properly pass a Error handler to the
>>>> gdbserver_start so we could do the right thing for command line and
>>>> HMP invocations.
>>>> Now that we have cleaned up foreach_device_config_or_exit() in
>>>> earlier
>>>> patches we can further simplify by it by passing &error_fatal instead
>>>> of checking the return value. Having a return value is still useful
>>>> for HMP though so tweak the return to use a simple bool instead.
>>>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>>> Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>
>>>>
>>>
>>> <snip>
>>>
>>>> -static int gdbserver_open_port(int port)
>>>> +static int gdbserver_open_port(int port, Error **errp)
>>>
>>> Did you mean:
>>> static bool gdbserver_open_port...?
>> yes, yes I did. Will fix.
>
> This is returning a socket file descriptor, why bool?

Doh - misread - I thought this was gdbserver_start... let me check.

>
>>=20
>>>
>>> With that,
>>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>=20

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

