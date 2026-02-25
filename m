Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60972FCEE92
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 11:51:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvDPv-0004Kq-Mr; Wed, 25 Feb 2026 06:50:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vvDPp-0004FY-EU
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 06:50:55 -0500
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vvDPn-0001bt-Up
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 06:50:53 -0500
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-64acd19e1dfso5662310d50.0
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 03:50:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772020248; cv=none;
 d=google.com; s=arc-20240605;
 b=TbGNK6HLdk/c583UL45N/UUsAF3FqacL3rA6xfcZGVgw9gdlw947gq0UDUhc7f9lPf
 oEtL5DKpBOANzhViqqklOBVIolEQO2ic7ZB548cBZiOb7T3csjRsolaox9wv4hIez5Kg
 p7OTYXAhe3/oxmnuVhfMxNIfgApb2wmA5OcWaOkNSaETEuRHX8CoMP2NSaMisYcfnFSW
 R8sF2f5tf29934RKjYe4pligrX0a4A920aAV7J41D/nCchS8UTux2jxP7EjjDCbMoFtQ
 uCM5tOpfH+YK4lj9Bi4gZlLi4YMWubdaPnkOcgzr33oTCyF3Z5DYs2yCr/vt66OukfrP
 gbug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=8/XNbwJeKQIwo7t1QhyL97lwvQNgw7U+AJxYLlMiTZ4=;
 fh=qDEitYY2TPRRMZ4OARbMiUT09q8rCCMKzcZWPtML1Tk=;
 b=PxMOEJUAqlxdRbdnLSuvy6LGOuWmEiHzy5JZ54IF+pmX1TD9vMqFK8sf8PYR/6nO/L
 MJ/kck05H7IfYUqM53ZtYIjz2DaAARNXfKHUyMyRU4ZpQIeoWNKKhaHkm/vbZnYBu0aM
 uGOVjUq+tpHC81xOuAi4rHT5zRGHAWKJN29zmbriLJiL276WW30aW2RUkRADeGNK3amC
 M11iDzrTqxUqxCT470wWNL0P/1PVj4MHxH285GGlFRAhPNmx6/SUtCD/WlwBfBxYQrFo
 l/fvY2U2w2SMbU3xI2qpfyH8FisF4mVI14Yah7bblzsTvNpGjrA+DZIgwocO+FJfVmYY
 r1rg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772020248; x=1772625048; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8/XNbwJeKQIwo7t1QhyL97lwvQNgw7U+AJxYLlMiTZ4=;
 b=d9KIQ2rUWorIuNAppVdokwj0cHPaWY3yKbTGYR7MJWQSWlSTpy+T7ygWEUbbqd8tI0
 Ice1L5+PH0r6XZj4G4Mm9voq+szwCzChkLTdnnq9vLzLJGipzxfFc1pGyGMeQUrXcVcf
 gZUTb0jGKI2uS+6+JSkeZniqZz8R+6aCjyzEGF8IwapyB6wcR0CD/Tki8s+PerwSpNVJ
 cC2mmca8DZ3EYl98hv2Gum9zTK0QzA1ca/rxv5ilGEBUv51dQODZ/Ks+VhD7DfIAHUIX
 AsPisDbj8pQM8ce1oescYgOSSmetW/wnNwqCEBGIF3Tw1iPgP3waihWc+TCT9v7i5fv/
 UTIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772020248; x=1772625048;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8/XNbwJeKQIwo7t1QhyL97lwvQNgw7U+AJxYLlMiTZ4=;
 b=RhiuxS4MfAq2gKKVOM6UC8stvv3+QUBxuCm4mUP2HqiQezeBRPw04T0OGY/72FXqZC
 iX+KFjKgU5fZahaML7LUQi0/i1ejFdBpcxzeA9oFPcAZH0MRODJsAl23jRBB9qmHsRuJ
 +AgWVe8AkFmQhzT6O40o0vfQQxmFz/Zd1iL5WxoVxTuyifW+nlYT1OcGRr4BGxp/cTfF
 6a7aCRFZeQk+MgAbunpqQ6cc52iAGjUTbmt2o3np48d0lkybnflfTAXXPyGIdztjyWl1
 m9I9hnduP4TbFCzRqWHwPuz9TkkXJz8usYL8AvaG7v5ezRyNj4vnjQQUmNsqOgCSlXpN
 133g==
X-Gm-Message-State: AOJu0YyxMH4Wx4OVWGuXewPfb/BAxNoqYZeIs3h8IIGknEF+S2gEMZLN
 JYLDjDl3FKxzLent+HzFiDQnmwZBFTlIg0407kSkSG1Dq13Ru8k1qY7CAj9LaGcYlSXPQri1VDP
 KXtDPZMVohNzouzf0pr218jZDGqoCxT0Y8luGzH7GFw==
X-Gm-Gg: ATEYQzzY/zgMbzAUwVbC3g4bbklPyPm6WH5m9gR3NXSQkqpEMrv+sUTROBTS3zmd8sL
 G0r5mH0AGv3jULoTeVn8L+Rw5Nw3qi+rTswC3BswmyFZPCogNyehp2xGvgNkrHkzarHrtWMET/Y
 Q3RIRQT//8dNxcB8mVPILwz/vKYe1QlHMLJl34bX9RnXOxAHR9FrXf5UFIUAlvrFfMKIXyd06j0
 LoB8LrzK87pzZ2RUsSbhgYars2Y88abTkwPp94WipLn48bHIhPuIBP/IpGoyE9x3mSheZw88Gyi
 2Uo7clm92X1HM2paXt/ACZTjo65m/n45Ut52LwB/FT22BsXyZKx2uGPVia2cTzkaBxo=
X-Received: by 2002:a53:d014:0:b0:649:45c2:6d62 with SMTP id
 956f58d0204a3-64c787d512fmr11859925d50.5.1772020248437; Wed, 25 Feb 2026
 03:50:48 -0800 (PST)
MIME-Version: 1.0
References: <20260224121014.279248-1-alex.bennee@linaro.org>
 <20260224121014.279248-6-alex.bennee@linaro.org>
 <CAFEAcA--YmCZ2+BBy1kM_VjeER4vbX8VMBbSA1aqUQ9-jWp5tQ@mail.gmail.com>
 <87pl5t130f.fsf@draig.linaro.org>
In-Reply-To: <87pl5t130f.fsf@draig.linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 25 Feb 2026 11:50:37 +0000
X-Gm-Features: AaiRm53GhKc5smmSp8HXA-t5xPP_5ljN99Y8dDIIxoq5Itzm3qbAcj3pVShiRnA
Message-ID: <CAFEAcA9fg-yikxCoX5HWHh77Sk_5APXAgNrwZWPQMRQFLad6-Q@mail.gmail.com>
Subject: Re: [PATCH 5/8] target/arm: extend WFX support for A-profile
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12a.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, 25 Feb 2026 at 11:22, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
> > Also, this doesn't change any of the places that it needs to
> > change to implement the places that architecturally set the
> > event register (see R_XRZRK in the Arm ARM),
>
> I was having trouble finding that but searching for just XRZRK finds the
> subscript text:
>
>   The Event Register for a PE is set by any of the following:
>     - A Send Event instruction, SEV, executed by any PE in the system.
>     - A Send Event Local instruction, SEVL, executed by the PE
>     - An exception return.
>
> These seem easy enough
>
>     - The clearing of the global monitor for the PE
>
> Is this the LSTREX monitor?

Yes (see Arm ARM section B2.12.2). Note that as "global" implies,
this is cross-CPU, not just internal to this one.

>   - An event from a Generic Timer event stream, see Event streams.
>
> So this looks like sub-timer events that trigger events but aren't timer
> expiry events? I shall have a look to see if the kernel uses this.

It will both use it internally and also exposes it to userspace
(in the sense of providing a hwcap that says "we generate an
event stream so you can rely on WFE waking up after a while").
The kernel config symbol is ARM_ARCH_TIMER_EVTSTREAM.
For internal use, see for instance arch/arm64/lib/delay.c :
if the CPU has event streams but not WFIT/WFET then it will
use the event stream to implement the delay.

>   - An event sent by some IMPLEMENTATION DEFINED mechanism.
>
> I assume we don't need to care about IMPDEF cases for our current CPU mod=
els?

Yes, we don't need to worry about this part.

-- PMM

