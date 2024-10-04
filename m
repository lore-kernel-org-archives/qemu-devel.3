Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01B09CF8840
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 17:02:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swlgr-00067U-Hy; Fri, 04 Oct 2024 13:02:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1swlgn-00066F-0W
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 13:02:01 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1swlgl-00010M-9q
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 13:02:00 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-5398df2c871so2649094e87.1
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2024 10:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728061316; x=1728666116; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S149EoV0HT286379WFnXfKxIHdjLesfEWLZqIFvC3Mc=;
 b=D9D5JyiUzqQ/0jJZsrFdyhyBTsh030mMG58Qso4RuWSA8d0CQgxLCjQdpi9GCYgo0Y
 3Dujcaqks4Hv7IRYJkP3D5fukpqHl9Mp1mwVCm4iSI0b9mBx5RtzsHBvFudLJdlSuBaD
 wgrmXFN8UuqYh6Rxf3rCScsi+pFZCWbYrvagQd+/2STTcWCFEh/DGjdnS9Kbxw+IKkkO
 W11s2RGjE96cXnUD6B78dDEbhmH4WQPtHUVhkec/I31V9QCxw0uh+UQDRr2co5eUcFLW
 8YLdiUq9DX1aWton4aU588a13dX5Eq8razmYdY4WjKW4UQVNwgn+7OLlaoEh0xBGnCH9
 ugKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728061316; x=1728666116;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S149EoV0HT286379WFnXfKxIHdjLesfEWLZqIFvC3Mc=;
 b=kstWBIVrIUXuKh+UtTAfvBAdOBcbbW+HP8qrb7e9ttQR/jsuoMnTnhSfomhKEsxy3Y
 NyjOY3kmiz8x5yh9QbWkF5PwKryj7h3GnopGGcoSobWg77K0U12DbaKdRkKY+oQy8J80
 SQWo/S/cwAzla3I/E1PrhZF+ZtEVmHSVqg3XzmRLnbHK2DcWP1T9uKvI7mMHvFn2MLAx
 Pnt9bsZ6eq9y/6CZjcctrk7D7yfQ4tPpq/9X0tDkQU9UtuAjjRZZXKLSqUZOd5LuvoIX
 65T0Noa3fbareHR3yj729G7xF48IaoaP4Sstw/l2/Eq0uvjMItSjBzUB7g2A3K6syLVs
 Tp4Q==
X-Gm-Message-State: AOJu0Yy78bMPTNEisTjmO4j42YPwieIooZ+QAZAADBTjMaD2rc847BgP
 +PNE+ARZVtdExHDv+jlAy0/jHEFb9N4U7uo1xLJqQh78XDdieNaiUkcXlZaQtwT+7Mz+Lx9kdl7
 Wn6RB+yUi7/ohrt4/lnewNngd9m2N5HA8KQzM7Q==
X-Google-Smtp-Source: AGHT+IG1wDfGeX+LifF7Jmi0D8uGayvzOQwNn0g8/z3u9TC3fY0+UOGYw4QMiCFNjX8P2I/72UbcrotZycxlVDr/NEY=
X-Received: by 2002:a05:6512:104d:b0:539:95f0:a05d with SMTP id
 2adb3069b0e04-539ab9c7251mr1887804e87.58.1728061315503; Fri, 04 Oct 2024
 10:01:55 -0700 (PDT)
MIME-Version: 1.0
References: <20241004162118.84570-1-philmd@linaro.org>
 <20241004162118.84570-3-philmd@linaro.org>
 <CAFEAcA_X38bhELuwwKLPrbfC+vLnwpUHP5RNCDv1V2r69dbJ7w@mail.gmail.com>
 <bf1c2206-ef63-4dd3-8a15-0323dfa9509c@linaro.org>
In-Reply-To: <bf1c2206-ef63-4dd3-8a15-0323dfa9509c@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Oct 2024 18:01:44 +0100
Message-ID: <CAFEAcA-VjPKyn2wVSydYy=jVniX0H649yz8qu-Dr+L1jn2zd_A@mail.gmail.com>
Subject: Re: [PATCH 2/8] hw/core/cpu: Introduce CPUClass::is_big_endian()
 handler
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, 
 Eduardo Habkost <eduardo@habkost.net>, Yanan Wang <wangyanan55@huawei.com>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-ppc@nongnu.org, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-arm@nongnu.org, 
 Zhao Liu <zhao1.liu@intel.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x132.google.com
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

On Fri, 4 Oct 2024 at 17:54, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> On 4/10/24 18:41, Peter Maydell wrote:
> > On Fri, 4 Oct 2024 at 17:22, Philippe Mathieu-Daud=C3=A9 <philmd@linaro=
.org> wrote:
> >>
> >> Introduce the CPUClass::is_big_endian() handler and its
> >> common default.
> >>
> >> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> >> ---
> >>   include/hw/core/cpu.h | 3 ++-
> >>   hw/core/cpu-common.c  | 7 +++++++
> >>   2 files changed, 9 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> >> index 04e9ad49968..22ef7a44e86 100644
> >> --- a/include/hw/core/cpu.h
> >> +++ b/include/hw/core/cpu.h
> >> @@ -150,6 +150,7 @@ struct CPUClass {
> >>       ObjectClass *(*class_by_name)(const char *cpu_model);
> >>       void (*parse_features)(const char *typename, char *str, Error **=
errp);
> >>
> >> +    bool (*is_big_endian)(CPUState *cpu);
> >>       bool (*has_work)(CPUState *cpu);
> >>       int (*mmu_index)(CPUState *cpu, bool ifetch);
> >>       int (*memory_rw_debug)(CPUState *cpu, vaddr addr,
> >
> > What does this actually mean, though? Arm for instance
> > has multiple different kinds of "big-endian" depending
> > on the CPU: both BE32 and BE8, and data-endianness not
> > necessarily being the same as instruction-endianness.
>
> This is to be used in the data bus (I was wondering whether using 'data'
> in the method name).

That sounds like what you actually want is (a non-compile-time
version of) TARGET_ENDIANNESS, which is not related to the
CPU's dynamic setting.

> > This series doesn't introduce any users of this new API.
> > It's hard to say without seeing what the intended use is,
> > but I would expect that probably they would want to be testing
> > something else, depending on what they're trying to do.
>
> I'm trying to split my branch in "~20 patches series";
> I should post example of API consumers in a few days.
>
> First conversion is the cpu_in/out() API in system/ioport.c,
> I'll try to post it ASAP so we can discuss there.

Yeah, I think we really need to look at the users, because
my current feeling is "we don't want this API at all,
the answer will always be to use something else".

I suspect for cpu_in/out the answer is "this API only
makes sense for x86, and whatever extent it's built
for anything else is accidental". We could probably
define it as always-little-endian.

-- PMM

