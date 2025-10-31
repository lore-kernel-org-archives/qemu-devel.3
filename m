Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B52B4CCF9FA
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 11:45:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEnYx-0003LW-Fr; Fri, 31 Oct 2025 07:44:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vEnYs-0003LE-FB
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 07:44:55 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vEnYf-0004LB-EA
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 07:44:51 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-640860f97b5so202033a12.2
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 04:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761911073; x=1762515873; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2SSn6TYA/zHmdkTjkJcOYtvvDbE6Tz+f0OH6grPyz8k=;
 b=OY9htsO+Zzd5HP/kTN4QN8tDyngEleJNhe9PPGS+iGVJklMV5HKdd6yqrg1mzkxoSd
 E2a6Lmya/bP+lu8cJiQ89H48bC68H47Y/uEaIwsYRjiL6MCdTfdBiAPE5U5s++7WPeFg
 B3YfeBLz8VPJKSBLWEtlpV+G10KfVZAF0y364/oLTu57IPXgsUVEdfUeRcXS6il/fikc
 0hZPJ4dDI42A9fjy1n2gCKwSinS6h+X5DoScYCSH+J3E12uYURXENLY532P+8BdGtoLw
 XNU54q6cuVX1wNGZWmroV/pGeD3W+/CBZn46pgooDhhcoD5HOz0bVpLhvXBeYG3TJy7e
 rHJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761911073; x=1762515873;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2SSn6TYA/zHmdkTjkJcOYtvvDbE6Tz+f0OH6grPyz8k=;
 b=ajHetPVPmLktRWoGoxZYbhgRfPzlLCH5afNM7XlQc1lYmtovG60MhiOH4ew/m/Oe8q
 zQAefOcjfw7caKVPe3ilK7pcWvFhHdFWvE/vB3AAlAh/8IWVXzoTRolYoQCA8XnWlN66
 m5mMnLeecYa2O7RCxwf2/pEsinWKIeI3qSkCPJLggRb6pGGIyZ1DOcAeUSIiE4vgDwZX
 CtGR7YAzFlV5nIrA5P29AkITBOVvwOR7aZHarTfw63Yf+fy4ckFUfInvg1K+3j5VssZx
 krHBPrUA0ag2JutmmhtbTqLW/rXsyK1Pdv6AwhF6Id0OWq3zeZ1sg3VfHlaPLVIqMkEq
 Oskw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIfzDziijEDxW0OvXXwH3nwGUxlGS+v4Pea3nHgm25NwoCGm0IlEiN4L0QZ0zT9FbUrR+n2g0aR47j@nongnu.org
X-Gm-Message-State: AOJu0YzmjChyvlimI3U6LmVrGVipW76FjemzdU/E73IsLdMTlZ5P2T28
 4OK5Bd+/ZB/FZO9+7HqdyzM9LDdH92YKUEUUlpCfQo0rrW3Yu0kBXXAqxj7oueQUGhk=
X-Gm-Gg: ASbGncsFGZV3nHGdrp+WcBAzbSsF1f14jeKNjzKMvxuynUxKUpKRa/afqhN4JVvgQbl
 Lrkf+rTD1fe37BgTExrk50MSMrX2MhdzVB3DWa/NOxyrzP8jIGFceo84xE6X8di5iPcDI0y8PPR
 1Bu29zHI3e7etyuxghmC74fDCNL38FivWmbpOpK/Ul6661u3C9edl4OWICXXTVQtpoEGp7z8K+s
 TL0SycANJLIhR2Diu/h7wV1isqhP0OGgSHEoC1rrBaBHFhRzvpvuE5C9S6BM+1+/Uh14zkzyfbr
 O6JOmBuTh8f2GNgubkWunTce63sKKdt+JNAWVx/3Aa+ZGShhfkqR/jeWe86bSPUykQ0fmHSbi9N
 SppeT9jCqdl/X65FYXjQvtqwU/C15ilq6okPOi5HbU5/djDChJXr0wuWbKFzg4gT3i9wsJyPh54
 dSlfeF73tsLPY=
X-Google-Smtp-Source: AGHT+IFIetxn/iUoBGZ1/oAWWw0CNsRI5Xyv4SShoXScKAJogO4N11ZIsa+7VVylhZ9iySh05KB8Kg==
X-Received: by 2002:a05:6402:1e90:b0:639:fca4:c471 with SMTP id
 4fb4d7f45d1cf-6407704da9fmr2007564a12.28.1761911073307; 
 Fri, 31 Oct 2025 04:44:33 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6407b428102sm1368394a12.20.2025.10.31.04.44.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Oct 2025 04:44:32 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B71F45F7F7;
 Fri, 31 Oct 2025 11:44:31 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Sean Anderson <sean.anderson@linux.dev>,  Philippe =?utf-8?Q?Mathieu-D?=
 =?utf-8?Q?aud=C3=A9?=
 <philmd@linaro.org>,  qemu-devel@nongnu.org,  Richard Henderson
 <richard.henderson@linaro.org>,  Luc Michel <lmichel@kalray.eu>,
 qemu-stable <qemu-stable@nongnu.org>
Subject: Re: [PATCH 0/3] semihosting: Fix a few semihosting bugs
In-Reply-To: <b22ec1f4-78f0-4947-a46a-3ff6c54f8be2@tls.msk.ru> (Michael
 Tokarev's message of "Fri, 31 Oct 2025 13:31:29 +0300")
References: <20251017213529.998267-1-sean.anderson@linux.dev>
 <b22ec1f4-78f0-4947-a46a-3ff6c54f8be2@tls.msk.ru>
User-Agent: mu4e 1.12.14-dev2; emacs 30.1
Date: Fri, 31 Oct 2025 11:44:31 +0000
Message-ID: <87ecqjthwg.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

> On 10/18/25 00:35, Sean Anderson wrote:
>> While discussing [1], it came to my attention that QEMU does not
>> properly truncate/error SYS_FLEN on 32-bit systems. Fix this, and some
>> other bugs with GDB File I/O that I found while working on this series.
>> That said, GDB File I/O has been substantially broken for two years now,
>> so it makes me wonder if anyone actually uses it! It would certainly
>> simplify the implementation if we didn't have to support it.
>> [1]
>> https://lore.kernel.org/u-boot/20251017195322.GF6688@bill-the-cat/T/#m49=
3c42570d3103b8c606c5f50faeb78d27719de6
>> Sean Anderson (3):
>>    gdbstub: Fix %s formatting
>>    semihosting: Fix GDB File-I/O FLEN
>
> Is this qemu-stable material (for 10.0 & 10.1)?

Yeah they are simple fixes and should backport easily.

> Please let me know if it isn't.
>
> Thanks,
>
> /mjt

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

