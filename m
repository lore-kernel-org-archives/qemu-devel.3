Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A51C3CAC587
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 20:51:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwoFD-0001mR-OT; Thu, 11 Sep 2025 16:50:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uwoFB-0001mE-NI
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 16:50:13 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uwoF9-00039d-Ub
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 16:50:13 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-61feb87fe26so1258062a12.1
 for <qemu-devel@nongnu.org>; Thu, 11 Sep 2025 13:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757623810; x=1758228610; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ug82rWd3PrNdeT7rbYF0Tz12bbfVWttmU5VcZtkn9hA=;
 b=Vh4vUwhTUmg9poy1LrRxTn6wkKnGVwThiOVIexmeFD+7DppqMDt10jKXNkHo/8f/x0
 O6OUewYTEIi2pdQnu0awNXXZvX/baSpmuK8nH23Yy+OIBs3DTbaDn8C0RpAGpSZ0N4U2
 ZMcd5G/8fLlDLX3NaPU9szclzCtrJEDbuutcFAuQC+sF9KQ1HSXsJKkM705YH2z+0Crn
 Eu49OFrUaS4z3sqkSiFEWFsUiGByL+MZUCucZJw/5+K4U1s8T1tbzdqNcP62XPnD7mwA
 M0e2W/w9PWB3Emc1AsIEB4B0M/7GdkFCQxktR49PKJr7XXydphTRE8O2oYzTF1Xe6FaB
 1ptw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757623810; x=1758228610;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ug82rWd3PrNdeT7rbYF0Tz12bbfVWttmU5VcZtkn9hA=;
 b=kvmzLMPQ1GyL23HhpAfzBMpuCWq/I1cqj+sZAjQciGvf4HLAZtG2of/WZ7XnNg6SuW
 NqaC/emAvoxh7S19vVthy+XdUSxmHKRB61DML+dAPJeX6uSTyLUc9LfnRqLYJzDwldvg
 u/V+YMjoprehi4vr4kBRnkt2D2cO91fCFPrpMWsa2X6puvNMSrZ5wkHq3Ja5xx6tZikI
 bQxk+s9gLM9hBtTgEt+gHr6btauyuLd6zDg2MLKyzZBiVloC0OO0vypDOB5mxnONFvDQ
 CJaaogiKoV4wV3uVrVPaQLy6/XQiPzqYjZYWi8L5MToct4GLlcswpu5u4in4Ibq/lugK
 d4Jw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpDGtLqAKVD/hU5AEukNXnzNAnr+zzQzZx9NoLcVl2Vt/5+obT7/Sin2vg2gI3OVvYQ/iEpU7LFuoL@nongnu.org
X-Gm-Message-State: AOJu0YwxPfqRkSAeIa/4+n+63bNb2x4n8VuhAk5vZ0BCZThmTcerIDSJ
 qV38RbSFdMyYR+J5SmirL/HKqIBGjaEbxEEoiFDulMtUJ+la5sqYbM4j+ctX6BJvWZ9a0BDcaHo
 PQeYDD34wKQmxw7MxpZ1Q6ruZGWkuWdI=
X-Gm-Gg: ASbGnctEURq/lOVcJYXvqS98Yw+jiw7lBMtrUK2bBQA5/rpdV13Ni9mXTn8Y+g54psk
 rEbkzVkmWt8RpZCDrtJHgWY5mXslxJva0IT8sLlsEIvjE4GXz0Ea9UBuMqstRHFsAuultEwoZKL
 nlBPpqhSPR93zR2gXH5hXEkEdvALU+C/XCTOPbta8auauBukalowaeup0Xp4ZPGqwr4s8cD007y
 zOf6qWRBmScVPyJ
X-Google-Smtp-Source: AGHT+IEpEyTGQaTWXSmXmSXyZmIZC5I4hqTM+UvVwGJ02nUv3nm4a0pCqUNFmgC7sFAe2xNQTix/5iP7zO9oJ26seIs=
X-Received: by 2002:a05:6402:34ce:b0:62d:e044:4a5a with SMTP id
 4fb4d7f45d1cf-62ed69e0208mr915154a12.0.1757623810066; Thu, 11 Sep 2025
 13:50:10 -0700 (PDT)
MIME-Version: 1.0
References: <20250908140653.170707-1-stefanha@redhat.com>
 <CAFEAcA_jB-5wmRXUijcr_+hpto3huMZQnKzZA5rHFwS5ZWDSkw@mail.gmail.com>
In-Reply-To: <CAFEAcA_jB-5wmRXUijcr_+hpto3huMZQnKzZA5rHFwS5ZWDSkw@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 11 Sep 2025 16:49:57 -0400
X-Gm-Features: AS18NWAU7iqWbLaFrMV2Z49T9J1NGby2SEun8LMlHVejOK4_NXboBiCy9K059gQ
Message-ID: <CAJSP0QWumdKVQWknYQkXw_G18RJ93q_jrmPoUsDD-CN_B=PU-g@mail.gmail.com>
Subject: Re: [PULL 0/8] Tracing patches
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Mads Ynddal <mads@ynddal.dk>, 
 Michael Roth <michael.roth@amd.com>, Thomas Huth <thuth@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Richard Henderson <rth@twiddle.net>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Thu, Sep 11, 2025 at 7:40=E2=80=AFAM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> On Mon, 8 Sept 2025 at 15:10, Stefan Hajnoczi <stefanha@redhat.com> wrote=
:
> >
> > The following changes since commit 6a9fa5ef3230a7d51e0d953a59ee9ef10af7=
05b8:
> >
> >   Merge tag 'pull-tcg-20250905' of https://gitlab.com/rth7680/qemu into=
 staging (2025-09-05 09:51:27 +0200)
> >
> > are available in the Git repository at:
> >
> >   https://gitlab.com/stefanha/qemu.git tags/tracing-pull-request
> >
> > for you to fetch changes up to b91cbf4e691b397510584b04fd6197284f55b52c=
:
> >
> >   tracetool-test: allow to run in parallel (2025-09-08 09:48:10 -0400)
> >
> > ----------------------------------------------------------------
> > Pull request
> >
> > Daniel Berrang=C3=A9's tracetool test suite and Marc-Andr=C3=A9 Lureau'=
s test suite fix.
> >
> > ----------------------------------------------------------------
>
> I ran this as a combined merge test with a couple of other
> pullreqs, but I'm assuming this one is the cause of this
> msys2-64bit job failure:
>
> https://gitlab.com/qemu-project/qemu/-/jobs/11318561687
>
> # [WinError 2] The system cannot find the file specified:
> 'C:/GitLab-Runner/builds/qemu-project/qemu/build/tests/tracetooldmg99xan/=
dtrace.c'
> not ok 1 - dtrace.c (set QEMU_TEST_REGENERATE=3D1 to recreate reference
> output if tracetool generator was intentionally changed)
> # [WinError 2] The system cannot find the file specified:
> 'C:/GitLab-Runner/builds/qemu-project/qemu/build/tests/tracetooldmg99xan/=
dtrace.h'
>
> and other similar errors.

Hi Daniel,
Looks like Windows is not happy with the new tracetool test suite.
Please take a look at
https://gitlab.com/qemu-project/qemu/-/jobs/11318561687.

Stefan

>
> thanks
> -- PMM
>

