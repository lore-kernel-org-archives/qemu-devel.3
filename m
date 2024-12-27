Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DB6EE7718B
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Dec 2024 23:51:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tRK6K-0003EG-T5; Fri, 27 Dec 2024 18:50:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tRK6C-0003Dj-08
 for qemu-devel@nongnu.org; Fri, 27 Dec 2024 18:50:34 -0500
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tRK69-0002Au-QN
 for qemu-devel@nongnu.org; Fri, 27 Dec 2024 18:50:31 -0500
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-aa6b4cc7270so1109957966b.0
 for <qemu-devel@nongnu.org>; Fri, 27 Dec 2024 15:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735343428; x=1735948228; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dF+1ER+/8M5BNCjZEF+X8u8bl/QJ5STyGXKopeSSf/g=;
 b=saGaT466QwmOYMzEpIQQQnVdJuzpiz93ayhlzr1HoZC2hp4dObYZafpNIk4zmqaoRw
 CxDKGyjlLjixuCoRXsrB3TuZ1SeWDylrHMCwXJIzk1JADTb3UEFjNBYZXeVz1DRS8XX3
 djvnxqDQ5mabI0PaUgWLLPOSaKeH9AqzHpsrAsYIsXzdVqIj9bqZldtlbp33RG1h4elR
 Emu3UQe9EqIjiHGGMyvcAObk6I4f7OO+8nwbW/+5st8ORMlwsryRN55IrXCigNc+CGGo
 Nqnyuveg5Q0rcrAGaQbwaRAavisflLndvCRJLQ1JdJoU1PJ3CG3oKcSAvpHswtZsDhZq
 1kyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735343428; x=1735948228;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dF+1ER+/8M5BNCjZEF+X8u8bl/QJ5STyGXKopeSSf/g=;
 b=FEN64Wl+LVwVxmec6ugw85fHJ6OBq75su+UH5p5gRZ0Hfl7B8XklodQ7AEoYjSjXnS
 TNKcgJjE0hhvl2+Nd7hgBc3qq7cgM4qfAR8BSPepJnmmhiHnE+Qt64fGQOzD5T8WQZUA
 OewkyYfjJ6ohNdiFPs/5VyvwY3KP1IOMYZhIxZQnL8lNJ6Cfs1RD30FwsG8873mB2Pai
 FXY0SlQSDZBqklV7iF4jVa/pQDtUsrBnrK41MjH/O8U8jRM1tQI9FQSq2tEbsBO5xBoa
 6dUbQZaHrIg3obujdhDwHoZYDVQbIcGysEBBeVFLYi36fbdn+pPqlEZezw6bX+Mcp384
 pb7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlUxksfNTrYB3hXNg/SWNAaE8eQrlcAZNi8IpGQOwE2Q2sPuqunrQh6JspKwTmkTGic2fp7WwrLRJe@nongnu.org
X-Gm-Message-State: AOJu0YzcPNyPkbiRe2SqPt0+biZh7+fhN65xR+dD9l8PaKyn+hZMDRsH
 Cz4FuSEDNBRbLJBjiAAvLEZRDzUkkgQEOkqcU7yoM2+GI8gTN8UUYuPPM66FswE=
X-Gm-Gg: ASbGnctLRHSMc4dDLCNlv/ifRxeUZ9F2oFf4/qtVODCRHnileOp5zKDvAYzpTCkly+3
 yEABdP21CqqJPkueX8GmP0Jazy7qHJvvPlAaAWBgP45CvuPA1iVwT4pMTY2BYfS/UU7juiaGQSY
 C6EPqj6Gm2vzQlpiFCwbWfeM/pSmaoNu60uQCj05UroYtlPqOOtTzkAqLtMXbAyby033GoMlioq
 zepxOI1gw95540LF3a9juNzTp/5IAuUIJb6ZsMSPWjXeTTHqA+ILeA=
X-Google-Smtp-Source: AGHT+IH024CGNL0vaFGyQxmU2N5OwtSoSA3A+E46Fs3n4bfmwRfkgZo+IorD9Dcl/Ni7I5mH6/dp4Q==
X-Received: by 2002:a05:6402:2790:b0:5d0:e73c:b7f0 with SMTP id
 4fb4d7f45d1cf-5d81de1c241mr69356297a12.28.1735343426438; 
 Fri, 27 Dec 2024 15:50:26 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aac0efe41a6sm1191383266b.102.2024.12.27.15.50.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Dec 2024 15:50:25 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 56C145F792;
 Fri, 27 Dec 2024 23:50:23 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: ckf104 <1900011634@pku.edu.cn>,  qemu-trivial@nongnu.org,  Alexandre
 Iooss <erdnaxe@crans.org>,  Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,  QEMU-Devel
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH] contrib/plugins/bbv.c: Start bb index from 1
In-Reply-To: <514c2c90-4c0f-486e-857d-fa0360c47d38@tls.msk.ru> (Michael
 Tokarev's message of "Sun, 22 Dec 2024 12:11:51 +0300")
References: <20241217142413.148978-1-1900011634@pku.edu.cn>
 <514c2c90-4c0f-486e-857d-fa0360c47d38@tls.msk.ru>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Fri, 27 Dec 2024 23:50:23 +0000
Message-ID: <875xn4lm80.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x633.google.com
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

Michael Tokarev <mjt@tls.msk.ru> writes:

> 17.12.2024 17:24, ckf104 wrote:
>> Standard simpoint tool reqeusts that index of basic block index starts f=
rom 1.
>
> While this patch is a trivial one-liner, but the underlying issue require=
s at least
> a minimal understanding of what it is all about, what *is* bbv to begin w=
ith, what
> `simpoint' is.  I'm not sure it really is a trivial material?
>
>> Signed-off-by: ckf104 <1900011634@pku.edu.cn>
>
> Do we accept such SoBs these days?

The guidance is covered here: https://qemu.readthedocs.io/en/master/devel/s=
ubmitting-a-patch.html#patch-emails-must-include-a-signed-off-by-line

The wording: "It is the identity you choose to be known by in the
community, but should not be anonymous, nor misrepresent whom you are"
implies you should be identifiable to assert you can submit code and
currently this email only shows up for this patch so is functionally
anonymous I think?


>
> Thanks,
>
> /mjt

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

