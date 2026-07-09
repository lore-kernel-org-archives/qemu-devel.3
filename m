Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EB10C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 05:08:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whgz4-0005qQ-EO; Thu, 09 Jul 2026 01:07:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1whgz3-0005qA-Eg
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 01:07:37 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1whgz1-0005UE-Cw
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 01:07:37 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-698a9f11776so2341007a12.1
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 22:07:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783573651; cv=none;
 d=google.com; s=arc-20260327;
 b=VqY/L9Y5+VM5FX5RF4Kv2tw22MhM3E8AvEyGtj2hPq6VzBgHaLuQUdgCOy0O6D/UKj
 1JxgqYKCc1W8zC9wZYd2gRYGXxrKlkq09LqXf5iKKbS2oqUIpZMRyqrXDYf+cxqjK0Ae
 FrKPsaFrSEJzSvDmu0h5/4g0i/7RcZwOPjR5neN07YORv0F6o+yJnLfxoDWMTBCTuXeP
 VKXrdQ5GS2EdBzfz0/jB6x7NSkB7QwQlgDDch68/3G1BlCUBSkwAmThqYwJLhEx7qais
 dRz1s4gNIpHZdLIN9ffePru6KBVjC36iSRqbsUcP+JzL5bCVVRFqlPGLUDXZf9QJCgWu
 o6Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=vK6woC24TZK1Bss3R0rZwM8aF/w+LUWkEQp0JuhMGXE=;
 fh=MmuDaRjNNvuJ5KMd6XbWw50cxQW+AzXOWFxIakTOx54=;
 b=czKSiSsumVTuOtkaX61GbJwwe6hy/5aH/mLTVChz9qVtf/PZdRWRUL80PO/SLQaDtk
 fcL1zA+seArsPu89ko2siXHdAhFF1OOpvhfD3AbqZ86s3ug17/EV1k8LpYYlj5vAT0/9
 o8DOjubREY8GLSoTGUATBdfJbMSetPw9BoEeLP4hpQAuLHtFfEal0H03KKnlWxVUoKpG
 4NfKqopUTtT29CnrcTvTf20Vf+gDDNx8R3AYEt2WFh9ZPXkDn+XP5w//zSwSm6UEb2bJ
 DIoKPo7Uiosq3kQztAtLOUNjZ2vbofBp4SRriUIZrCCO+hrFKO4iKsN52MZLVVR0QSeb
 lGIw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783573651; x=1784178451; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vK6woC24TZK1Bss3R0rZwM8aF/w+LUWkEQp0JuhMGXE=;
 b=TcbiXsoi3WwwnEkWQWj6yz7MGWPLbv6NQpFpOeS4tsiGYhNlD5emC5CT2k+Nr46Fv6
 BnFcIi8ikmiIqIA4LGFZHioJYUagWedzvCT2l60ZRLk+B+D2LYxJx43j3a0B5F3kPTNE
 1GYjgQEiS2buyEwL7CdpfylTx1KZdPkYzU2oXl8PPTGc77sYC3zGx9dq77T/BaXUD7Mn
 Iz+0XVrbJr1l24slLTTZS5CRV7Mxbix7tbs8KKK0x3g7rqIBOtj3ij1mgv9OCThW2/sw
 umWcuQdOBSAwVYAzh7gxdY2svqU4kTE6OZa/R5+g9278JaMY7kHfAZdkwM9W3WoHoDh2
 xZYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783573651; x=1784178451;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vK6woC24TZK1Bss3R0rZwM8aF/w+LUWkEQp0JuhMGXE=;
 b=M/f/e3DSkV36SOz5QZkfrPTc06N5Tl43xskk5h52E/nmBSTmLu+qJca2Vp1fhHcVNE
 477332tyvaLZND+jF2sbnhfD8ZyWQRbKtGK+om1D07q3AmL/pN5lFFIi+9wb84kiPVXN
 vs67p40MJiIeCnSBF/fh2+cro8Nx/Yz3vEj8gtLd73NDjiBVy36rbjIDCS3gyYl4ULWp
 QkTMami8dMC54Xewy0cIRljmKMuPD+DJj1ENc/M7pnfYvSwzLKBii1Nobd8+MOWDE7Eh
 AvSvN+xGqikHuRrw1oebu7aMUlRECdlFcLgVYaayDESwg9VExV0/8g9DtdGjqu7jjfUF
 Fg2Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpj6kjKT27Wgb66Lwb25C7fkplgQCckPWXZ/LiZuj3VZawBXyNRcRngLglI/Qv5e03Qwp5VsTH3GOh+@nongnu.org
X-Gm-Message-State: AOJu0YxWovgtZ7U0gZAt0w6nUuKcl8FTElhON3WH+l4+FvvuaJvQ2cjf
 Zo+LrYcUfKcbvOEB23a4Z53jh/gqKlP2lzYQIZNZ7oJK1Mbrz3hfvXPVdC2MOk6Lhzgm3mdVZa8
 xtpxs/BJo0jVcIeDT3NhS+QRBPFcJ0H0=
X-Gm-Gg: AfdE7cnZSYj8Rdc3Gfq9j6UJlYFbIHIeycSiYsYBc9KpU0TR/dODdVH7emd2MfgZloZ
 IJfatMquoKs1iK6lOEoZVUSYcb6BV/Pe+UQHWIxC0R8M+4LooPQY4YPF1JntT7yPQncXg1o1nM2
 adM9l4Bw5Hkp06xZZEeBnhdbITlYkoZ2504cDe/R22fLfoKnMsX2JSZDRVDj84xiyzL03+08kuZ
 wV/PhUP44UpZ3Wf7gghFWjdaJRNlwwWQwFa1D4Ws2Zkz1W/2/Wq7vmLIeetXbU0PiJly8khb+Pl
 H4M5R09EZ+FSqsjEfBkPSPnF+/4=
X-Received: by 2002:a05:6402:11d4:b0:698:81ab:c506 with SMTP id
 4fb4d7f45d1cf-69ab44b509cmr2307680a12.39.1783573650904; Wed, 08 Jul 2026
 22:07:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260706161716.29488-1-bin.meng@processmission.com>
 <30d89c41-c290-4eee-8e38-df1924e26281@oss.qualcomm.com>
 <57f674f1-3587-433a-9962-ca0ed0b37f4c@oss.qualcomm.com>
In-Reply-To: <57f674f1-3587-433a-9962-ca0ed0b37f4c@oss.qualcomm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 9 Jul 2026 15:07:04 +1000
X-Gm-Features: AVVi8Cc1wVXFiWryGSWdgg_RirYLVu9OsoczzCIbTGSkQkC1_TZPz966z7wSP7A
Message-ID: <CAKmqyKN8zR0Q_BzRv1fp_Knx3kKEEiKKD-AvWsR6G9qwttG_mw@mail.gmail.com>
Subject: Re: [PATCH] gitlab-ci: Remove job building OpenSBI firmware binaries
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Bin Meng <bin.meng@processmission.com>, QEMU <qemu-devel@nongnu.org>, 
 Alistair Francis <alistair.francis@wdc.com>, Thomas Huth <thuth@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Tue, Jul 7, 2026 at 11:08=E2=80=AFAM Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
>
>
> On 7/6/2026 6:08 PM, Pierrick Bouvier wrote:
> > On 7/6/2026 9:17 AM, Bin Meng wrote:
> >> The OpenSBI firmware build job follows the same pattern as the EDK2 jo=
b
> >> [1] that was removed earlier [2]: it exists to produce firmware binari=
es
> >> from CI artifacts, but those outputs are not consumed by the tree.
> >>
> >> Remove the job definition and its project include to avoid maintaining
> >> bitrotting container and firmware build logic.
> >>
> >> [1] 71920809ceab ("gitlab-ci.yml: Add jobs to build EDK2 firmware bina=
ries")
> >> [2] 690ceb71936f ("gitlab-ci: Remove job building EDK2 firmware binari=
es")
> >>
> >> Signed-off-by: Bin Meng <bin.meng@processmission.com>
> >>
> >> ---
> >>
> >>   MAINTAINERS                     |  2 -
> >>   .gitlab-ci.d/opensbi.yml        | 88 -------------------------------=
--
> >>   .gitlab-ci.d/opensbi/Dockerfile | 34 -------------
> >>   .gitlab-ci.d/qemu-project.yml   |  1 -
> >>   4 files changed, 125 deletions(-)
> >>   delete mode 100644 .gitlab-ci.d/opensbi.yml
> >>   delete mode 100644 .gitlab-ci.d/opensbi/Dockerfile
> >>
> >
> > All good on my side, but let's check with official maintainer and
> > reviewer for this file to make sure it's ok.
> >
> > @Alistair, @Daniel, are you ok with this removal?
>
> Checking the git log for opensbi.yml this is the most recent commit:
>
> commit 83aa1baa069c8f77aa9f7d9adfdeb11d90bdf78d
> Author: Paolo Bonzini <pbonzini@redhat.com>
> Date:   Mon Mar 4 13:16:50 2024 -0500
>
>      gitlab-ci: add manual job to run Coverity
>
>      Add a job that can be run, either manually or on a schedule, to uplo=
ad
>      a build to Coverity Scan.  The job uses the run-coverity-scan script
>      in multiple phases of check, download tools and upload, in order to
>      avoid both wasting time (skip everything if you are above the upload
>      quota) and avoid filling the log with the progress of downloading
>      the tools.
>
>      The job is intended to run on a scheduled pipeline run, and schedule=
d
>      runs will not get any other job.  It requires two variables to be in
>      GitLab CI, COVERITY_TOKEN and COVERITY_EMAIL.  Those are already set=
 up
>      in qemu-project's configuration as protected and masked variables.
>
>
> I'm not sure what's the actual impact of removing the OpenSBI job would h=
ave with
> this Coverity usage.  Maybe we don't really care about Coverity downloadi=
ng and using
> opensbi for whatever Coverity must do and we can remove the job anyway.  =
I would like
> to hear from Alistair and the others about the possible impact first thou=
gh.

I don't have any insight. I didn't even realise we were doing this as
part of the CI.

>
>
> Also, this opensbi job has been around since 2020 and Phil's commit that =
removed
> the EDK2 job is dated 2023.  I'd think that Phil would remove this opensb=
i job along
> the EDK2 job if the criteria was the same, and yet this job is still here=
.  Maybe
> there's some lore behind it ... Phil, do you remember this stuff?

Phil reviewed this change, and the commit that removed EDK2 support says:

commit 690ceb71936f9037f6e11580709e26b62d83c17c
Author: Philippe Mathieu-Daud=C3=A9 <philmd@mailo.com>
Date:   Fri Mar 10 14:32:47 2023 +0100

   gitlab-ci: Remove job building EDK2 firmware binaries

   When we introduced this Gitlab-CI job in commit 71920809ce
   ("gitlab-ci.yml: Add jobs to build EDK2 firmware binaries"),
   the naive plan was to have reproducible binaries by downloading
   what this job would build, testing it and eventually committing
   it. With retrospective, nothing happened 3 years later and this
   job is just bitrotting:


So I think we are ok to remove this:

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

