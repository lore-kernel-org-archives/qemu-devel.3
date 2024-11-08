Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 965D2D64063
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 16:57:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9SIS-0001sB-0n; Fri, 08 Nov 2024 11:57:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t9SIL-0001lR-S8
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 11:57:15 -0500
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t9SIH-0000Xl-HU
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 11:57:11 -0500
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-53a0c160b94so2999476e87.2
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 08:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731085027; x=1731689827; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LUK1qUg8JXmoiLhzbIkRd0D5z6DAijz143AgJszH3Qw=;
 b=h1CCfscOQ8NBu2Hri6xVG9+CnL5KcA3dy2fHIq+s5GpPiJC+gshT3v80PiUfHGZOjV
 7SzPmBc5bz5d6rZp8tGocxZDxDeunsNTkG/yu3XR2Xm7mMVOvSU6tTkxdkF/2K6TT01G
 aM17nzLFs7F9UNlrUbuWtDEE9j4UwykguSyiwwuFdYwhzu45QUv6edLVRPwWvXdGnlWC
 FcpbDjalEIqATZi4yEXTDZdfSV+n9kEBWhjejrhYpFYkBhvVIqKsKl01Mm0zcl9Q/JF3
 kkta+anSOsgF7vIsMsIbx/sVpaUXWz+XRcXoXFfxSMtAvZeVTgNITskczZGTi7PSciaa
 uoyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731085027; x=1731689827;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LUK1qUg8JXmoiLhzbIkRd0D5z6DAijz143AgJszH3Qw=;
 b=ABvg11GDOkMAXfQqhv9cQ2ugtZUTCvpTpmInf9DoM9fSuXNZFc3e1mfj369rhiNO3D
 tED7iWEQ3/PVd5Ef2uNpKSyeCnfQ1K18YBa9DMKWqiYBD67CEftVB4OZ4Xr46ZgMFlJN
 tsW4idfCZDUczAnNUw/EhOlwVyd/4ic4IXziZYg/j+tHujNWmsP6HNltgGuzgt3pJLea
 egpYJIoVW1sHEXJFUyJHJ9WNpTPf7xplLyu+5Igjnes2quHks/8a/0+w9rPJJLjP/NMg
 PdkDc5Gr9I8yqF5XKhV35stU6PlxkWpG5XEB7BDZAKau72+dh3KSJLy+f+QXyEPDZ9Vb
 g7Ow==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwmYenSJ7mu9FWF4dhp5j2pclqVwX5IBHVgTWMszzOM8/zF1EZDGuys7tFWSrwnDT9e9oGcnW5aVWn@nongnu.org
X-Gm-Message-State: AOJu0YxQXkAZk8DzDejvcqjE5XGo3c2tqRvswItdKr2zXgasixB33xUa
 9QKTr9ARRGg8paPryTl5vHQhOwskLMfdJ/t0xH8Wxz9QI+UhnlJSFZM4zhH02eFtZDwFlIJku7o
 cAZpC2M7G9d+Po5Fqq9d8XXdvcbrWfWlKzRJg3u9JoztnGGqn
X-Google-Smtp-Source: AGHT+IGtmwi5SGZIgSL4Xo3avVR9F5r6OWHoA9f1LDLDNofP5MubAYzimjk+8kl3C9pUbrcBz0j3Nd13/Fhs4Ok5BKo=
X-Received: by 2002:a05:6512:1295:b0:53c:7432:93a5 with SMTP id
 2adb3069b0e04-53d862ebfa0mr2274146e87.53.1731085026654; Fri, 08 Nov 2024
 08:57:06 -0800 (PST)
MIME-Version: 1.0
References: <d9aaedd4-80a7-40d1-b5ab-c75afda794e3@eviden.com>
 <Zyjdm6TC7jfa-wlR@redhat.com>
 <CAFEAcA9BzpXdBpWcRbe42TSpUyg8KP+--mvTdqfM8t6Y+t5Knw@mail.gmail.com>
In-Reply-To: <CAFEAcA9BzpXdBpWcRbe42TSpUyg8KP+--mvTdqfM8t6Y+t5Knw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 Nov 2024 16:56:55 +0000
Message-ID: <CAFEAcA-8pfeuBcYgBUvTzafQuXd7VJBWQMCsCL3TQ-XPaNDcTQ@mail.gmail.com>
Subject: Re: [QUESTION/ISSUE] edk2 missing dependency
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x131.google.com
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

On Tue, 5 Nov 2024 at 16:48, Peter Maydell <peter.maydell@linaro.org> wrote=
:
>
> On Mon, 4 Nov 2024 at 14:43, Daniel P. Berrang=C3=A9 <berrange@redhat.com=
> wrote:
> >
> > On Mon, Nov 04, 2024 at 02:32:53PM +0000, CLEMENT MATHIEU--DRIF wrote:
> > > Hi everyone,
> > >
> > > It seems that https://github.com/Zeex/subhook (EDK2 submodule) is not
> > > longer available on github (which makes recursive pull of submodules
> > > fail for a lot of people).
> > > Do you think we should do something on our side?
> >
> > Once EDK2 fix the problem, then QEMU can update its EDK2 submodule to
> > get the fix.
>
> Looks like the "EDK2 fix the problem" part has now happened:
>
> https://github.com/tianocore/edk2/commit/95d8a1c255cfb8e063d679930d08ca64=
26eb5701

And I see also that there is now an EDK2 tag edk2-stable202408.01
which is identical to the edk2-stable202408 tag we're currently
using except for having the submodule reference fixed.

Gerd, could you roll a patch which updates our EDK2 to
edk2-stable202408.01 , please?

(This has now been raised as
https://gitlab.com/qemu-project/qemu/-/issues/2660 --
obviously at least a subset of our users are in the habit
of pulling all submodules recursively, so it would be good
to update our submodule to have the fix.)

thanks
-- PMM

