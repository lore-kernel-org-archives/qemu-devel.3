Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5779FD61021
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 15:06:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlTan-0002pY-DN; Thu, 29 Jan 2026 10:05:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlTam-0002oA-27
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 10:05:56 -0500
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlTak-0001Yc-Fu
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 10:05:55 -0500
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-79456d5ebf9so11338857b3.2
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 07:05:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769699153; cv=none;
 d=google.com; s=arc-20240605;
 b=eiii4dkramK+7MwHNrtjlNZ74K689g+Esh+kaNdE5mCnm/mq/+Pt2pCrv/yBrNjlfG
 5yDF2JgETfE4fgZca+Y1mcRoBKdjKI0yp2jcvI6X8xQaf4uo1LubuQe0fK7etXjzO5zi
 ArI0qgRo7VsA9NfFgpCcToVukf0IezStBJa+JNhUVDs2g8GbrHFWAX/E0kkT4rIYcNnw
 3M0lkJGzOtfsa42EpXLvfjAxcO2mtK+jJFpCAXLWfHNA1mq7WlxUiZiGmtG+AQ34WyoL
 97M7swV6041YA5iTutKDCJnG3URtdpBWGipQEs7QUX/fR75kZ2IU1PrZ6UO2IZePM/Nm
 WPgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=oVE1o4D7voep0UOCj4pOdunoE2WIlpwfx9NVsylsdPs=;
 fh=us4lPT8YSvMw3WPWVr1x1zbLMIgA1kHH4DqlCTpJeag=;
 b=VxKLy9U0wKivmxQqeEmW4UUrLUHPA/GfLNobbSWSQvBOQy2r4xEQD7dm5NFIaH2/R7
 /I/+fSgOv43H4RXaRynO0v7tkf3tB6J7fW/+EicYfYCVv8G5yK0Pgp0TkY1XxKTExsMt
 DjWD+5O/sFcn+YT3PPn69fteqZ9kG7gvcW+Xx0CkDFpKwXIA1f8stCeR/zjOSqawuIvW
 hHk8K7AB0KggJR6Xk0Ry+mSS4HUisCIGbg4iHNdrJD14KbTJoEhlCGrjmNu4EaCpGPxy
 ho1D1y2W1VrOwxPS1vQIPMMF3RZLDYzpOEM/STmiJLdA12Uywk5HJFMfxXzz7to3Lw9f
 oAfA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769699153; x=1770303953; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oVE1o4D7voep0UOCj4pOdunoE2WIlpwfx9NVsylsdPs=;
 b=ot7lL9fHQJ7SqizzCCl9Px9chPTZmWEOlJv5EXorf8nusv8FqKUPIPFavuU9bOA/uh
 QaYEWP/SvAqHymaqquQ//pXXaO2CjZWkEPeBb6W4ztnOtGZJKYdTIMvuQmAZtvUL81ly
 5UIwdV6Vko0Y1TNSIO6DT++kjXdO3/LlBtiekkSyNYkSKHAypNmBoqX/tHX6N1LsXbak
 iBS2W+xyJl1SdZKqiHR/KRhM40WR+ncpTt55Xeay9DjUNWEfVEGFY8nZGTEkpysenhN0
 NVUiWAYp+xk9MW2u/FtcMAmtDrwjaUUrR8y/E9lL4PS8DcIn/lRmQLE0Akdz6D3ws3li
 5z6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769699153; x=1770303953;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oVE1o4D7voep0UOCj4pOdunoE2WIlpwfx9NVsylsdPs=;
 b=wSXXGYi1x6KzPeo5UtVVDKHyhrs0PKWdltjQOlXkyrO3hSGtFiXuakat0iJTfqcXoM
 8kRc7eTXvC74igwh3yjl0BRRG7dH98Kuaym28T7cpoEJwXzwAe4/cgW1Lsmab9NSb4kN
 D8URXZVkHztMt8iDDvbo0ud0muotLFiu7x+3fL9GgYuN8b4YkffymYRMd/7iORofC+W3
 s0AY7Ep/iuDQhpumJ36zSwQdGrllgnayRAXKMDHOCdcivuaRafhtdn0aRE19r5Crp32n
 dFI1MAUYw0hivxrAna8V7yEZFIV12YfC1srNZb+5iQuBLyNrMEjJmCyQDQnuL2Uc47NM
 pwuQ==
X-Gm-Message-State: AOJu0YygOLyrE91l/BeiypOPFCCW2Lm6AdzOcmb3Hc9BqOQJEjNfyfQE
 1FX+YNH6IJIkpGX1W63Kc++E71OJI0IS2tzA+JsmXDiVwoNXrENy4thN8/HqP1W0h4ilPvRxo+j
 T3NXJWsCvsP63QPEJ9QysVDbeACXoxVPOphFz8Uf4Jw==
X-Gm-Gg: AZuq6aKULmCZUpFmkvAwPntY8jCE4PTj50fdeo38GkVAI/q6AaCqXrWIKiQual0OIPu
 NqUS4BkCSm1NRJLGoZqbY7U7U2npE+hfz90QDcfHSvJIlhcPQLAruOyd9SLetm+HRNRzZeb+gLP
 6kcWyCoybI+yaz18uCzM7T7Puu2AG7vavN99iRdi0rCAyrm6MK2sQc5QomrlDFR7docQXpSK013
 d29HkqEQnnzMjrD6IdQXvkKzFJG2znTWXo7KToOyI8SbI+rz2iAl3s+kMLgM7CAyHJS2Q==
X-Received: by 2002:a05:690c:e3c2:b0:788:1b67:d741 with SMTP id
 00721157ae682-7947ab12873mr82537367b3.3.1769699152757; Thu, 29 Jan 2026
 07:05:52 -0800 (PST)
MIME-Version: 1.0
References: <20260127182805.73212-1-mohamed@unpredictable.fr>
 <20260127182805.73212-6-mohamed@unpredictable.fr>
 <CAFEAcA9qtLv1wOKkEmtNO5UsGTAM0x7YD+y8Fsu8hCQRAD_o5A@mail.gmail.com>
 <7CDB1385-1197-4D36-A46C-80A8F71DA9C1@unpredictable.fr>
In-Reply-To: <7CDB1385-1197-4D36-A46C-80A8F71DA9C1@unpredictable.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 29 Jan 2026 15:05:40 +0000
X-Gm-Features: AZwV_QgLUSyk8ByUG_iGviQ9jpofwmkYLtayXeIUV3rA1ZqFjI-MmiKkoRY7y1c
Message-ID: <CAFEAcA_ES6ZyoDFbMu_98NmbLTGTXuWPuuM-QwvS7NTpwvWv5g@mail.gmail.com>
Subject: Re: [PATCH v18 05/22] tests: data: update AArch64 ACPI tables
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 qemu-arm@nongnu.org, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Shannon Zhao <shannon.zhaosl@gmail.com>, Igor Mammedov <imammedo@redhat.com>, 
 Cameron Esfahani <dirty@apple.com>, Alexander Graf <agraf@csgraf.de>,
 Eduardo Habkost <eduardo@habkost.net>, 
 Phil Dennis-Jordan <phil@philjordan.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112c.google.com
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

On Thu, 29 Jan 2026 at 14:34, Mohamed Mediouni <mohamed@unpredictable.fr> w=
rote:
>
>
>
> > On 29. Jan 2026, at 14:36, Peter Maydell <peter.maydell@linaro.org> wro=
te:
> >
> > On Tue, 27 Jan 2026 at 18:28, Mohamed Mediouni <mohamed@unpredictable.f=
r> wrote:
> >>
> >> After the previous commit introducing GICv3 + GICv2m configurations,
> >> update the AArch64 ACPI tables for the GICv2 case.
> >>
> >> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> >> ---
> >> tests/data/acpi/aarch64/virt/IORT               | Bin 128 -> 84 bytes
> >> tests/data/acpi/aarch64/virt/IORT.smmuv3-dev    | Bin 364 -> 260 bytes
> >> tests/data/acpi/aarch64/virt/IORT.smmuv3-legacy | Bin 276 -> 192 bytes
> >> tests/qtest/bios-tables-test-allowed-diff.h     |   3 ---
> >> 4 files changed, 3 deletions(-)
> >
> > The process documented in tests/qtest/bios-tables-test.c says
> > that this commit is supposed to have the diff of the disassembled
> > table data in the commit message, so that human reviewers can
> > confirm that the changes are as expected. (If you git log
> > tests/data/acpi you can see how this looks.)
> >
> > Can you provide the ASL diff, please? (If this is going to be the
> > only fix needed to this version of the series, which I hope it
> > will be, then I can update the commit message as I apply the
> > series, so you don't need to respin, just reply with the updated
> > commit message with the diff in it.)
> >
> > thanks
> > =E2=80=94 PMM
> Hi,
>
> Here=E2=80=99s the expected asl diff:
>
> diff otp/tests/data/acpi/aarch64/virt/IORT.dsl otp2/tests/data/acpi/aarch=
64/virt/IORT.dsl

diff -u, please. But you're going to need to rebase this so
I'll let you redo the commit message at that point.

-- PMM

