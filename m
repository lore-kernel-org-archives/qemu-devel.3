Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4298D15DB2
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 16:43:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQpwj-0002S1-LZ; Wed, 03 Dec 2025 11:43:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vQpwh-0002Qr-J5
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 11:43:15 -0500
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vQpwf-00038U-T1
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 11:43:15 -0500
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-78aa49cde3dso71040807b3.1
 for <qemu-devel@nongnu.org>; Wed, 03 Dec 2025 08:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764780193; x=1765384993; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EjStxg2vGimEwZJKj+cslyewIsG14DXcZpsoFRzseFQ=;
 b=RE2tgyJPJ24j9TZgsXG6pYlZFcuMuHmmwKCuJhUJKejuFQ7fd6yE2OpQDFkVB00k29
 nWCX8u0LiLBfFwtKNgeuBySFTXBK0MtIFEGDmYcAIY5gxapjzj0Mn2m7ghsRwACV3bcw
 Rn1+0uQ2S/IvD5W4582bUGN48NCD2U28EgUZ4+3hsQzd3UxaCkbaXcrul9U2mysVu0fX
 a+838MQegCfhLYJVyOzrHknvaXysYbvRzJKIGKYK5cp9+E8H6y56JJWn3gorAakx/EoM
 7Y+9OVdzzxkXrggjCLtj9Rxvvn+7/W8jlwDHv8b3BRmLZrmIonOKfDozrjOfxxoU+AJu
 a2cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764780193; x=1765384993;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EjStxg2vGimEwZJKj+cslyewIsG14DXcZpsoFRzseFQ=;
 b=c+U13e6vLk1GP0143eb6OCWnW0iaLiZkoApf4nu37xH7esQdfFjftvDo8KReYouLcG
 Dxw2B36GKKSqOCfIbuZLczUCzmK9Ajo4AwEXg0LG3veZlGp1NTAdor35gpnSr1AcmSv6
 30/KQozamo05UkoyTRJIak+wCq3MxFJvW1sPYhPFQ9MahbJC866KyBWWEdPJ1/y82GMR
 AZOjq3to7B1HUFxQgTlshSfiZNAsW0S6ska42VxkTZ4qKUnyrDIaBV0NP3/4lpMNsqTE
 Z24kqYl8vMx0G+a2O7rTJJrBWqLShIKpAeoBpHlqXiReDGRkxDzPU8cH11YzHnSM2uHv
 ebLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7YIw2QfJ/RoFzHQLoY9KnGKhdKLCxn4PnBj0wmMXkh8VSp/O8BzSmRM6hgR5fw29z18ctDrIgtN23@nongnu.org
X-Gm-Message-State: AOJu0YyV1jI3Rds2rzLxYWG1s+4IooK1PqSeTu3UjIcZJCmpCOlbsAd8
 udRUEo3DLuToMHXqJJ96xWc838T6xz67hqHh/Cq7niZLGolJUYGk0yS3JO6LLDP3toyBC+iMyx5
 nhWRNpOtG4Wk0ZBxAlujGKLhjJ+0wjFmPyV94jkQGyQ==
X-Gm-Gg: ASbGncsAJXTMdWwHomVkdGZIc7o7Y9lE6Hhz35BUKUz39jodN52QLg+3yc8Ev6/Xar9
 xAvB9vO8i+MsvnPxBK/CvfZyKL3V2AcokS0G1xRJCUjQZQaRBW+xe4vf/lmVh63xmKPmYr9pPWd
 /pjatTLgOvtgpFP4qQPF5mRDJodhLiM0MxIQDpJHg1ZZKKWmOoVYHWORJISRPGM7Xs6G7uBuy03
 fs43LYWsxv71ggyvN8XXD/fpFkoUrOcm6dwZSyt6luhiaRmmURuZIhJkeK2r727i4qScw==
X-Google-Smtp-Source: AGHT+IECOp25iMxrCoEtG6XtCVJmujFZ5wijdDkvR3xCKlpr4b+uMfqJIMhHSkhT5EgR3CfKuYkjCSSwl9y5AXOXqF4=
X-Received: by 2002:a05:690c:48c1:b0:786:7797:6d73 with SMTP id
 00721157ae682-78c0c22a1e5mr21308847b3.40.1764780192455; Wed, 03 Dec 2025
 08:43:12 -0800 (PST)
MIME-Version: 1.0
References: <20251203131511.153460-1-dave@treblig.org>
 <87a4zzu230.fsf@draig.linaro.org> <aTBCLbDbpXgkTLHr@gallifrey>
 <CAFEAcA-Uy0UQwGEK+f95BJmDripg1-8vhzPF5qRSY40=duhRUQ@mail.gmail.com>
 <aTBjTzbaX0befChO@gallifrey>
 <CAFEAcA-y5ucBTOgngim5cpuKbFYXajOz0zEeT2S0rC3wnMPSrw@mail.gmail.com>
 <aTBnN6Q72QX3cW55@gallifrey>
In-Reply-To: <aTBnN6Q72QX3cW55@gallifrey>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 3 Dec 2025 16:43:00 +0000
X-Gm-Features: AWmQ_blEUQnM7F3DigD3uppC5hHTEmTM5gRs2Dxk-rbfRh0VPkmrvekxp7APjAU
Message-ID: <CAFEAcA-Gq=MnrfxMq4TqM6T6NYOO28qN1OobPWdNyNAnvS5Y9A@mail.gmail.com>
Subject: Re: [PATCH] qemu-options.hx: Document -M as -machine alias
To: "Dr. David Alan Gilbert" <dave@treblig.org>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 qemu-trivial@nongnu.org, mjt@tls.msk.ru, laurent@vivier.eu, thuth@redhat.com, 
 pbonzini@redhat.com, jak@jak-linux.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1129.google.com
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

On Wed, 3 Dec 2025 at 16:37, Dr. David Alan Gilbert <dave@treblig.org> wrote:
>
> * Peter Maydell (peter.maydell@linaro.org) wrote:
> > On Wed, 3 Dec 2025 at 16:20, Dr. David Alan Gilbert <dave@treblig.org> wrote:
> > >
> > > * Peter Maydell (peter.maydell@linaro.org) wrote:
> > > > Surprisingly, this and -h/--help are our only two options where
> > > > we provide a short synonym. I note that this handling of -M
> > > > is not consistent with how we document -h/--help, where we
> > > > print both on a single line:
> > > > -h or -help     display this help and exit
> > > >
> > > > But it would be trickier to fit that in for -machine and
> > > > perhaps confusing given the suboptions.
> > >
> > > Right, that's one of the two reasons I kept it separate.
> > > The other reason, is that I couldn't figure out how '-help' and '-h'
> > > both got defined - why is the second DEF(...) not needed?
> >
> > A piece of delicious fudge lurking in system/vl.c: we have
> > this hardcoded entry in the qemu_options[] array before
> > the ones that are generated via the macro-magic from
> > qemu-options.hx:
> >
> >     { "h", 0, QEMU_OPTION_h, QEMU_ARCH_ALL },
> >
> > So we recognize -h on the command line and turn it into
> > QEMU_OPTION_h, the same as -help, but it doesn't result in
> > anything in the documentation (we leave that up to the
> > strings and RST in the DEF("help"...) section).
>
> Hah ok!  I guess that fudge could be removed and make it the
> same way -M works.

Yeah, I was pondering that. Also, we don't document --help in
the HTML docs, only -h.

-- PMM

