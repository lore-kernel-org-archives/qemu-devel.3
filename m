Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC8ADC021BE
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 10:39:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnbHn-0007GN-AS; Thu, 27 Feb 2025 05:38:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tnbHf-0007Fv-4V
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 05:38:27 -0500
Received: from mail-yb1-xb32.google.com ([2607:f8b0:4864:20::b32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tnbHc-0002w2-Li
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 05:38:26 -0500
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-e608e260563so789685276.0
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 02:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740652703; x=1741257503; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FA7KO17KL5FtFzsu8jkNlBne316D6NclL3zjm7CyMh0=;
 b=A4ZCvmd+7ei4p7pCupu4AkczsGwNPDrGzk29u0hj34sDnaeJqP6lS2Wa1EyYZ38vcW
 Sh2P079orJ8jB74cMHmGCaFh+qkT2XoMFRJ1uwGaz89Mbt9tuHnsSqMIhIXgpj9YhP8V
 LExdrNeKUkNirbf51D0fJaQ63Xla5s5vpB5VMnyvWzH4rykZOFtHl5yFkVUKLwH5k6G4
 QLzGKr75Q7n9U27WdvaAJCImKD7gJYfhyCLrRFX4iC+prIdFsgv14oQ924ZH62F713rx
 5tN5sFVcosQhLAhGmOXRFJ4K2QiVZvt/6cYx5uoiMMNTD98SumzvNqrBzSIXzmEEfrwS
 oE7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740652703; x=1741257503;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FA7KO17KL5FtFzsu8jkNlBne316D6NclL3zjm7CyMh0=;
 b=rbQAJNk49baPHlHiuRPny6WcO1j/MrnMHwshQCbtYz4SpZ6r8KC7ti2+FpLtolItUB
 ACH7ij/TSzuk17Q/b8RQeZ8Tw06Wh/wPUVVXiguPPWw3YWJHsV07A8K7GaJdkq9Txgx1
 bK60yw2HXFaUx506/fL8HYHMMiWjgkZtJDUFJd6dmqLNY0rBPTuQrEF/XxWyo19HP8+v
 X4bKfJLVut+HTL4O2cVPOtO0c1nIxrCetLytLboeU2RzkLD4lWGpVeS+7BP9Md7a22rS
 Xip2QKnsfjPccKp7MoJWhE5D9FxWyucWkxHrfSZFAIY9g2S94+1/dx5YlLyCHcEFZlLV
 ionQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4V3RGt7KrvdFtGhwY9F5GYnSGxUWvrHgDZ78GVVCt8EmSPccR3KltlVd0D0q8Rf2bvvs2rjIHlIWf@nongnu.org
X-Gm-Message-State: AOJu0YyUHptd46Y+wQGu50970KNvGxBYEAnoHqUkHykfbnxQ0DntcdST
 pUivq0goXNqZ15Lu7jvsNqp9p0cK9xJtiNOfR2VF95ZGjz/Tyttsy/WdG+oii6Xv17YOra7p1Tb
 +AGM10xljlsbVi1UdQjxqnOWDEo+seKQVR4qo9A==
X-Gm-Gg: ASbGncs0hgqY9e+5Mufix6pqZK0TXsAyQaEQuQ+nhELoEcMh3RqfMFqGwiaf0iqg6aT
 KmdqPaUWWDi4wqbU1Rnn+g9MysUc0cXS42yLUyHHgQnwyCRWa90ExuhAC51y+Mo0pvMirat+5Fg
 84prtGBUgB
X-Google-Smtp-Source: AGHT+IGdRElJp01KTdRqyGiYO4n0o1J+cE/u2RSOnvVB1QnyT2yazRH7g1bLIUPziLOPYBc1XqRL/T6AORFeYT8N1OI=
X-Received: by 2002:a05:6902:2e0b:b0:e5b:44f2:e2c9 with SMTP id
 3f1490d57ef6-e5e244ffdf3mr19358847276.0.1740652702857; Thu, 27 Feb 2025
 02:38:22 -0800 (PST)
MIME-Version: 1.0
References: <20250204-jag-fix_meson-v1-1-ecb6bdb1db51@kernel.org>
 <5ea3a240-1805-40f8-9c5d-af12794ea34c@redhat.com>
 <opabljxycyh2huu4yicopg5dkur56pntyehozkrp2tai5orgnz@frubtj4drvma>
 <d788bb12-0d69-43eb-bf09-a94ead71c9e4@redhat.com>
In-Reply-To: <d788bb12-0d69-43eb-bf09-a94ead71c9e4@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 27 Feb 2025 10:38:11 +0000
X-Gm-Features: AQ5f1JpOgmkY-n_CaWIVEsmY4_PglQU4GV7SQ3QhBel_FJh-e_tIksTg-Dz8Qbc
Message-ID: <CAFEAcA-zfLLwT206J7WFXW_ft-OJARv=UPgY7K54zTgDSPcK8A@mail.gmail.com>
Subject: Re: [PATCH] build: Replace meson introspection argument with a
 builddir
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Joel Granados <joel.granados@kernel.org>, qemu-devel@nongnu.org, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b32;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb32.google.com
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

On Thu, 27 Feb 2025 at 10:20, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 2/27/25 11:07, Joel Granados wrote:
> > Here is the error I see:
> > cmd:
> >    meson introspect --buildoptions /home/joel/src/qemu/meson.build
> >
> > output:
> >    meson.build:88:12: ERROR: Unknown compiler(s): [['rustc']]
> >    The following exception(s) were encountered:
> >    Running `rustc --version` gave "[Errno 2] No such file or directory: 'rustc'"
>
> Thanks, this helps.
>
> > When I pass it a builddir it actually gives me all the buildoptions
> > (which is what I expect)
> > cmd:
> >    meson introspect --buildoptions /home/joel/src/qemu/bdir
>
> Yes, the difference is that the builddir version uses the results of
> actually executing meson.build, whereas the srcdir version only does
> some cursory parsing and always looks at both branches of "if" statements.
>
> This is actually not a bug, and in fact now I remember why it is using
> the srcdir version...  Looking at the required languages is needed in
> order to figure out language-dependent build options, and the srcdir
> version includes the options for all languages that QEMU could use.
>
> None of the language-dependent options (for example c_std) are surfaced
> in meson-buildoptions.sh, which is why your patch works in the first
> place.  But I think it's a better fix for you to install rustc, since it
> will anyway become mandatory sooner or later.

It's not mandatory *now*, though. So I think it would be better
to fix whatever this problem is rather than papering over it...

-- PMM

