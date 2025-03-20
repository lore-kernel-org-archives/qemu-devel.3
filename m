Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDA15C28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 20:10:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvMDM-0004oS-02; Thu, 20 Mar 2025 16:10:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tvMDJ-0004ng-Jr
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 16:10:01 -0400
Received: from mail-yb1-xb36.google.com ([2607:f8b0:4864:20::b36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tvMDH-0001CL-QW
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 16:10:01 -0400
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-e3978c00a5aso1046009276.1
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 13:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742501398; x=1743106198; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sn6xZJZXCeYfbos5kYHuILiMc+3WeL8xmIB+K8NqT1E=;
 b=PnEmof1iJP67Nh6Q+MfA/A7anKV8Ty2b1IGIkN5P1xL/EkiFK3pQGmYb0RksJvfQVw
 ZoFKnX2i8XrdKgYDDQ3crATPfxvfiFmnfdl8I0px7whqjrCO6BY1lm51Paev34uoIPOq
 Y3EuILXr/ZrO1i71tz2zdcAOD+53OEi1voGrBNPmXxgqgT/knXNtHehIbl6BgkQpdxR0
 WKloNTvpZC5yXfdjdqVUwptpHQSHz8WDm7b7VCDzrfQClhYZvY4MPcH77I2+ME8mtg2h
 nhoYpTPBH7qZJG5J+PJJOcjpA2Qmkc3RjpeqZGbOCHnZquOvYxncJua+T/z+yLP1QYTc
 NZBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742501398; x=1743106198;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Sn6xZJZXCeYfbos5kYHuILiMc+3WeL8xmIB+K8NqT1E=;
 b=uovivdnHd9XbNq/EG00xwIGnZ5Yi7qbB0w9GUz2Mt6YSM0MHKzpEW/vp+7rJbGcsnb
 pqwAy1ht79GNSAX2lBD50rqKwoQ/xqWCibmKqDWUdqB5LZyqPGLMGLOEJLj8TxmMGaOK
 q+4jnzFNM5wlqGBtXzsxzkSz9yySo8tKmukesB9EMMo/loQIXVhA9XKscbzVmu5H/Cjl
 FrJx9mHjFCMOU7rmvzlhSHohtFCpM4EoiTPfgiGYCXlNhl9sMVMm8O2xsqaYkp7vY/Bk
 TKvoOSBi59ysA17/0DY3m076xuwvTQ2uFEiEWWSsddxyBezQaFgAdv8m/tSuRxJxkz5i
 +/Gg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU22aE+wISKNuJpy83xZ/DoELVn2DByd9VriWJC0YpmwBM9EmULn0CflEs4N3J6KhCKN7Z1R8tbJvyk@nongnu.org
X-Gm-Message-State: AOJu0Yw+6MQdbINYmKCc5z6VdqH4+zFGzF1cp0G5hwvgGaFvXZ+SmccR
 SVIuGJylsnAgzOpFGfUO0JMokK0KntE3Tz4uOf/geI7Y0KOuHhO1IK4++3A9j3RrwzMIiHgb8gf
 mWKe8aVTCI3WvnrTfP8T+kqzf6TgOXe/7J9TUXg==
X-Gm-Gg: ASbGncve+Q+HMtOSEQHHp+tY5TfKraUHTHlRfh0s352Fsd5OeGS+P/9oRpqLyj/Bgqc
 dvFFr0WCHUtZ6P7GeZckWekxz5NoZ2evo0zXSKzf5ZNGwubbbscJSJeEVi/OvMD7zIGSFUgYotD
 DUBS5K/SA9UWXfGF0owvzFUnFP0mhV9Uczvayq1g==
X-Google-Smtp-Source: AGHT+IHMROrlKey1WQVGD4/Yrvw5n9hWfAMlb4VVNqh4kXHl9ngfoq7+dNAW0/NFNb4O8njcPEkToIwMWzuEfdxzr3M=
X-Received: by 2002:a05:6902:2292:b0:e60:9dd3:38c9 with SMTP id
 3f1490d57ef6-e66a4d2e233mr642489276.7.1742501398177; Thu, 20 Mar 2025
 13:09:58 -0700 (PDT)
MIME-Version: 1.0
References: <CABsFrshLGcmBEBXCMrOdDv213c1q6GB6pDs4JDLQGKrTzqvkYQ@mail.gmail.com>
 <87ecytm2ru.fsf@draig.linaro.org>
 <4545005.21021813.1742490863752.JavaMail.zimbra@univ-tlse3.fr>
In-Reply-To: <4545005.21021813.1742490863752.JavaMail.zimbra@univ-tlse3.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Mar 2025 20:09:46 +0000
X-Gm-Features: AQ5f1JrV5PGf0qwW4jf9VZzeHIVUO9s0ukXcr_C5pDhOmWvJGrptzTQQ9OkLG2s
Message-ID: <CAFEAcA8rBnTD3pqiraQvgLLyOWMCj=2cftgDkZp5h8N7F8nq6g@mail.gmail.com>
Subject: Re: Raspberry Pi 3B energy consumption
To: clement.aldebert@univ-tlse3.fr
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 qemu-devel@nongnu.org, "millian.poquet" <millian.poquet@univ-tlse3.fr>, 
 laurent polzin <laurent.polzin@univ-tlse3.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b36;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb36.google.com
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

On Thu, 20 Mar 2025 at 19:30, <clement.aldebert@univ-tlse3.fr> wrote:
> To clarify, when we refer to energy consumption, we are specifically look=
ing at CPU core utilization. Our goal is to ensure that when we turn off CP=
U cores on the emulated Raspberry Pi 3B, the host machine does not keep its=
 corresponding cores running at 100% utilization.
>
> This is particularly relevant for our use case, as our supervisor, M. Poq=
uet, intends to use this project for teaching operating system development.=
 Students using QEMU to emulate a Raspberry Pi 3B may have different host m=
achines, so our objective is to implement a general approach that ensures C=
PU core deactivation works properly regardless of the host system.
>
> So far, our measurements indicate that even after turning off cores in th=
e emulated system, all CPU cores on the host remain at 100% utilization. We=
 are exploring ways to improve this behavior.
>
> We have looked into using -icount, but we would like to find a more viabl=
e solution, particularly for the Cortex-A53 CPU used in the Raspberry Pi 3B=
. Ideally, we would like to be able to use -smp 1 without being constrained=
 by QEMU=E2=80=99s limitations and to implement proper CPU core shutdown, s=
imilar to what is available on x86-64 architectures.
>
> Would you have any recommendations or insights on achieving better power =
management in this scenario?

You should check what mechanism you're trying to use to "turn off the cores=
";
there are several possibilities, some of which are "this ought to
work, so if it isn't doing the right thing that's a bug to investigate",
and some of which are "this is a feature that's not implemented at
all right now":

In the "should work" category:
 * if the CPU executes a WFI instruction we will stop executing code
   (until the next interrupt)
 * If you are using QEMU's PSCI implementation and you power the CPU
   down with e.g. PSCI CPU_OFF we should also stop executing code.
   (NB this is different from if you're running real guest firmware and
   the firmware is handling PSCI calls)

In the "not implemented" category:
 * If you are trying to stop the CPU with a WFE instruction, we do not
   stop executing code (we emulate it as a NOP, which is architecturally
   permitted).
 * If you are trying to stop the CPU with some raspi-SoC-specific power
   controller, we don't currently have a model of that, I think

If you need a working raspi SoC power controller device, the answer
is that that power controller needs to be modelled so that when the
guest uses it to turn off a CPU it makes the appropriate calls to
arm_set_cpu_off() etc.  This should be straightforward assuming that
you have the appropriate datasheets/specs/etc describing the hardware
behaviour.

If you need WFE to work, that's certainly feasible and something it would
be nice to see, but potentially quite a bit of work in the guts of QEMU's
arm emulation. (Basically going to sleep on WFE is easy but then making
sure that all the events  and situations that need to wake up a WFE is
tedious. We implement sleep-on-WFI but not sleep-on-WFI because the set
of WFI-wakeup events is rather smaller than the WFE-wakeup events.) It's
been in the "we really should implement this but since the only downside
is the host CPUs spinning, we've never got round to it" bucket for years.

(In the cases where we do stop executing code that means that that
vCPU thread should no longer be doing a lot of work; obviously
if your system has more vCPUs than host CPUs then the host CPUs
will still all be busy.)

Your other option here is "stop trying to use the raspberry pi
machine types". The "virt" board, because it doesn't need to try
to implement the same behaviour as an exact machine type, has a
much easier job, and it already supports "you can have just one
CPU with -smp 1" and "you can have an SMP system where you power
off some of the CPUs while running". Basically "virt" is actively
maintained, whereas the raspi machines are in the "Odd Fixes" state,
which means we'll try to review patches but nobody is actively
working on trying to make them better.

thanks
-- PMM

