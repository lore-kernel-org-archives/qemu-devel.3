Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B86BC282D6
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 14:29:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpTGi-0003Rq-MO; Tue, 04 Mar 2025 09:29:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tpTGg-0003RE-GW
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 09:29:11 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tpTGe-0007rF-Oh
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 09:29:10 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-439ac3216dcso39166665e9.1
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 06:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741098546; x=1741703346; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=elP41wlHNqCAVJg4NGIsWGEULwjwXGqzZz/fGSmPX44=;
 b=H5PtduZkAWvWKNCyQw4rSAmesyZ428YoKsC5Y7WgbOJSflUk8oiKD2C+a32OtoE2D8
 feZibySraZ7Vtjl/O/ryt2QAI2Km1aOpBdUJ4OCU+/PJKSaXtyLrpAuMCNjQe+e8NFrQ
 odz6MzKo6IiBChXXzD7cDasz3EXE7EdQRE1iy5QPLXpvGaKYrnnBCxssrZ8pmm63RZfi
 id+VlIlp/z7BMWg0RSCBZxa2BZ2nnlID1pwdrJ0WOF0PhRCzoICFdht9W28dj2XdhwVH
 qggmuWkFADMNCroHWnj5JEIELZpn1jIGrxjIw3+OzIdyYIj8FuUnWvca6Afu+tLmUL1l
 t+jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741098546; x=1741703346;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=elP41wlHNqCAVJg4NGIsWGEULwjwXGqzZz/fGSmPX44=;
 b=HuAF8cWQUfZGuJSTszyGzajGlZpguIwkixQ3uGRDXqkrNOOEWhm6molfWzSQ2TO+vZ
 NcGZIOqQQmELzxvr1vVwPari8WqY3LYLquuHth450BHJ3nPGG993W6l8HvnsG39GSLM5
 OgHfs4THNB8fJWF7LY1CEC76rrBN9dVQUxRAL3coQc2mYrTgblz+jAe++lTaRykkLv62
 frEUjovLNoBx//6m7K7UqKbiRYR/rECDV6/JzOxdtmuvVNcZJ5iu7DuN6+ijlXleZScf
 Zwh7kvR1jc067Ju+6Gc1ZAqaVmj4HMED3wQwvAw+wUhxRrMF63ijuDx2WyynDrCO/+IC
 0Xtg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrnzRqKpAkYkqycV8N3oElV+/x4rfBVS9/qI9ipr+Ox6hGN/3esaDrGrLe0LC6BXmi0wARqJlsRDp9@nongnu.org
X-Gm-Message-State: AOJu0Yxm6qKzueviQ8aKufbLeBG6jprW2xXKvFvpQWQQHfYJTauPSgFY
 MUqUyxlwAAdbExGU8LthSPd7iNCq+woWItbDZCTPSRlMFbhmlm8s0JwBtTajY9k=
X-Gm-Gg: ASbGnct1Q6PAZsfHLZGYH5y+qXdYF+WIhJVq3tt/tiImPBUFfdmxKDA/KUBSp9hZ/C/
 AKgE2lt6ocYzr7NDUxTVr6a/hTSYArc34h5WNYiVaOx+tO6iaVF05W4JpJOkaq/KtV/b1MQ0VYB
 LLFQRm6CIB2HKE1J6pFDo55VtJgoSJ5P6JAj005VqchFTLb3de/kBaOwLZqF0lhsMgSQnYld5Yi
 KJFcU4u66HCWM4VdiqtqLQcsp3XNDik+qI5SY7RI+yYmjcXTqc0LdzggBXmTu56CRmJRDxj2fg8
 d6c6q52DCQ/MO5YThMmV0hNHmmgTH7M0zKu+G9plRQT4VHI=
X-Google-Smtp-Source: AGHT+IFu34qyCxNmfkGN+Oyqn9DySJehxukiAx8Ssq1WFhaGandz3paomX14N/FfEuOHW1VB4kJNJw==
X-Received: by 2002:a7b:cd96:0:b0:43b:bf6f:6ef8 with SMTP id
 5b1f17b1804b1-43bbf6f70c3mr77126225e9.0.1741098545795; 
 Tue, 04 Mar 2025 06:29:05 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e484452asm18015310f8f.61.2025.03.04.06.29.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 06:29:05 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 48E735F93C;
 Tue,  4 Mar 2025 14:29:04 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org,  qemu-devel@nongnu.org,  Brian Cain
 <brian.cain@oss.qualcomm.com>
Subject: Re: [PATCH] tests/tcg: Suppress compiler false-positive warning on
 sha1.c
In-Reply-To: <CAFEAcA9mFHo=U=F+7on-9m+VWh_b2rQXtEJovU3fuj3MZxHTyw@mail.gmail.com>
 (Peter Maydell's message of "Tue, 4 Mar 2025 13:53:28 +0000")
References: <20250227141343.1675415-1-peter.maydell@linaro.org>
 <87o6yh57r2.fsf@draig.linaro.org>
 <CAFEAcA9VDtWKoQ09dOt+ZxJ2MhdRTFY_X1ON58pEjYTM_NtZ-A@mail.gmail.com>
 <87ikoo6hbm.fsf@draig.linaro.org>
 <CAFEAcA9mFHo=U=F+7on-9m+VWh_b2rQXtEJovU3fuj3MZxHTyw@mail.gmail.com>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Tue, 04 Mar 2025 14:29:04 +0000
Message-ID: <877c546f9r.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
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

Peter Maydell <peter.maydell@linaro.org> writes:

> On Tue, 4 Mar 2025 at 13:44, Alex Benn=C3=A9e <alex.bennee@linaro.org> wr=
ote:
>>
>> Peter Maydell <peter.maydell@linaro.org> writes:
>> > I think it's new-ish (gcc 11?). On the other hand
>> > -Wno-unknown-warning-option is quite old, and would suppress
>> > this error. If we do
>> >  CFLAGS+=3D-Wno-unknown-warning-option -Wno-stringop-overread
>> >
>> > does that work?
>>
>> Yes, I did:
>>
>> modified   tests/tcg/hexagon/Makefile.target
>> @@ -18,7 +18,7 @@
>>  # Hexagon doesn't support gdb, so skip the EXTRA_RUNS
>>  EXTRA_RUNS =3D
>>
>> -CFLAGS +=3D -Wno-incompatible-pointer-types -Wno-undefined-internal
>> +CFLAGS +=3D -Wno-incompatible-pointer-types -Wno-undefined-internal -Wn=
o-unknown-warning-option
>>  CFLAGS +=3D -fno-unroll-loops -fno-stack-protector
>
> I think we should do this where we add -Wno-stringop-overread,
> not just for the hexagon tests -- or are the tcg tests
> guaranteed to be run with a fixed compiler from a container
> regardless of the local dev environment?

I can move it, but hexagon is unusual in being clang based. However the
oldest compilers we use are 10.2 in the qemu/debian-legacy-test-cross
container.


>
> -- PMm

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

