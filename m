Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86DF2CFB44E
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 17:02:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxr6k-0000HG-5e; Mon, 07 Oct 2024 13:01:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sxr6h-0000Gi-Vd
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 13:01:16 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sxr6f-00033Q-EW
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 13:01:15 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a9951fba3b4so200571866b.1
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 10:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728320472; x=1728925272; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0Nh3rLqnlCA81yxEORMYBruRYvHPRurbBeEmdjQpaxs=;
 b=hMiD7vSV6WenZrzGdNR5v5hUmMIN6JxSS262EZ+NDyruxBjtrt/FVqzh7Ir4In1OOL
 ur9bWXbMMaAN28SIxMrtl91g9cgSc1JfhhYs3gqgCwAOLdSEb4FrnhSqfw+a0jopvn14
 LLJbpbiACloswyKlgBbkQIiTtoxGwUsbzhfNrX3bFuEoJ6LibKkDTiEuo++OZI0XP9Bm
 Cu30vESurWeTDstwkEGlqZKI4gDs43PCdqlyGnksTf3mJEqLhgFXidf2gTy6Q7QEIL/K
 CXj3+OePfv8bM/YLqbhwk8aO+kB3Wo4z1zRzeziz/zzWDaeD/uqcytVcdwUjp4ljCIAH
 edYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728320472; x=1728925272;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0Nh3rLqnlCA81yxEORMYBruRYvHPRurbBeEmdjQpaxs=;
 b=N4/Cb21Sb0bA8wS1FfzOuG65dAhd6/BdLzrJlNrMyLG0+4H8QRAGqQiqLkxYrj2f8W
 pH8DHAwoxT6WJsWzMzlGKepRptTwyzaSljwgEhfhqkgRi+lJDr10em6U0t5xSvs2qaNE
 YcSeC/S/TRsUAVl2IfPXwJZGUFxM6KYQ4tIIVBcerFoFsJBzEHEihUmM0eL0VBI6MbAr
 tkuAz8jkVvlgbvl89qr69Xh8H0dkJnguDL1KY4CwpQsH1qEh2XFPBv5xIXUBySqoE+d3
 sAPeUVRR5KMhj2NeB7CTpcQlU699SBeXRECJJhPCGX9MCv5hmf3E45Of+f2I8/uZYgjK
 Nvog==
X-Forwarded-Encrypted: i=1;
 AJvYcCXssAhPoTj+y92APn5RD4fmmWL09iqrKtDzJ6+tc2Gh2ARvZNBiU7A+e97576UHPhfpxSER07IE8CIQ@nongnu.org
X-Gm-Message-State: AOJu0Ywhsf8b8qiKisBJ4vKo8HJLj08dIGJS1/uQ9ctdCZIcc43FCDUg
 UfyR7tuvLPgTGVP5FJHMGJwc3qGzAygU3RvNOccuRDkQ0AuRoexno/Rp7J6d2as=
X-Google-Smtp-Source: AGHT+IFYx6T2YNMD/X/resq8EcNFNDn0bBKGrY2FusC4YZ9ZQZ5pWR5rcrdo/7fKF27jyPbFgD2qDg==
X-Received: by 2002:a17:907:9490:b0:a99:63d8:a1bd with SMTP id
 a640c23a62f3a-a9963d8a2c9mr77863966b.16.1728320471678; 
 Mon, 07 Oct 2024 10:01:11 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a992e78498fsm397906066b.107.2024.10.07.10.01.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Oct 2024 10:01:11 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2BB705F796;
 Mon,  7 Oct 2024 18:01:10 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org,  qemu-devel@nongnu.org,  Zheyu Ma
 <zheyuma97@gmail.com>,  qemu-stable@nongnu.org
Subject: Re: [PATCH] hw/char/pl011: Use correct masks for IBRD and FBRD
In-Reply-To: <20241007144732.2491331-1-peter.maydell@linaro.org> (Peter
 Maydell's message of "Mon, 7 Oct 2024 15:47:32 +0100")
References: <20241007144732.2491331-1-peter.maydell@linaro.org>
User-Agent: mu4e 1.12.6; emacs 29.4
Date: Mon, 07 Oct 2024 18:01:10 +0100
Message-ID: <87wmijvodl.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62f.google.com
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

> In commit b88cfee90268cad we defined masks for the IBRD and FBRD
> integer and fractional baud rate divider registers, to prevent the
> guest from writing invalid values which could cause division-by-zero.
> Unfortunately we got the mask values the wrong way around: the FBRD
> register is six bits and the IBRD register is 16 bits, not
> vice-versa.
>
> You would only run into this bug if you programmed the UART to a baud
> rate of less than 9600, because for 9600 baud and above the IBRD
> value will fit into 6 bits, as per the table in
>  https://developer.arm.com/documentation/ddi0183/g/programmers-model/regi=
ster-descriptions/fractional-baud-rate-register--uartfbrd
>
> The only visible effects would be that the value read back from
> the register by the guest would be truncated, and we would
> print an incorrect baud rate in the debug logs.
>
> Cc: qemu-stable@nongnu.org
> Fixes: b88cfee90268 ("hw/char/pl011: Avoid division-by-zero in pl011_get_=
baudrate()")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2610
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

