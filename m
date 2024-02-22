Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E9B1C54798
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 11:33:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rd7Ka-00038z-HD; Thu, 22 Feb 2024 06:33:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rd7KM-0002m6-9H
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 06:33:25 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rd7KK-0006I5-IM
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 06:33:22 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-55a8fd60af0so11221979a12.1
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 03:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708601598; x=1709206398; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dMZZBh4sMI3aAcjqDCSMbFulUd/vNUuPcQEHc9cqAVg=;
 b=G6qj0Qp2D7g16GqdzKQKAC84TDbuCVXUaen9ZHZkaYI3JjzDh6M6MU3vOvvmrxnn/r
 +bdq1h0HeVaSOYqReQodmuuqQvqoWOZdvjvexgTHzp30AKGjMRxo5Gn2K9B48XmhBS8Q
 v4OnkCP6ziE5HX5v9ApPsU9dGaP/JSig2GL0Kb1cIgBHYX3SleOE8CAV7yhaQN+hANOM
 3ZX8u/YPUC3ncbRVnsBKjb22I0T99nkXcB/Ib0zCWHXUewju4S21Dwy4hguaXODZ3hk0
 s3bMdtmTMCc2umQ1QIbtDmjAcLYzrpDlUk4WJY2r/VogLjoMpUDdV/tj5S5+nf8J/x8K
 xCIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708601598; x=1709206398;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dMZZBh4sMI3aAcjqDCSMbFulUd/vNUuPcQEHc9cqAVg=;
 b=Fu3MyB/jUh64B2zIoD24iBzljmtE1qoqbRyOdM2tok3RQaE6jyzsGuq4I785eiKa3z
 sHMHftVzvxDRvQhq1Ra1NO1YtkcJEimSfE6VPymLgaG+bn9k2KyaIqjkENXrzGHvD2iY
 0Be1KsU4gmkh03Yc+As7goX+pVljrs1DIbzExWqVgtZioVxuq1Kc+6264nP+xNvXXpaL
 18Cz0KgOTjpCWY41dKJFC1mGinHm5EcP4NG3BvmDYgN6hxx9R2cmY9mGWXmTT/GC0CKi
 z77F1ULZzg5fTldsRPkpymfAfLxCD4AgVieP2TTFRJ8vE5Vf1fbJxZws1csGBCEo6F04
 aNyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBPFnTyuYZkHD9u4F4ttSN8SNN/qWVWSdDj9YlJBZYhygHyX0sW3A2b4cudbm9OPWsNgI/B0K2Th2tbhu0c5NxOmb9xmg=
X-Gm-Message-State: AOJu0Yy9xFfHXeAS8yGeODngBhSHiF+K8MEVhWRcDFFg4PCdL0AR0uQV
 Lvv4+ypzFpv1rS2LI2hUpdPpTFe6C1kuF3mYIOPrbGIdxo1wUv2MkHd8DmzVSeplRfpDljegrbP
 17G0JAqVrNPVQPPTDFGBUzfDRqnaTAzgOtRAwlA==
X-Google-Smtp-Source: AGHT+IElirwwxEKCvptMfNsdxPTLX7tpIZXrt1ZREnCDvXgQUwUHgTyzD8sclPVGhE5RLsWQPOugKlntA8dUzb9thuA=
X-Received: by 2002:a50:ec95:0:b0:564:caed:75a4 with SMTP id
 e21-20020a50ec95000000b00564caed75a4mr2215751edr.41.1708601598532; Thu, 22
 Feb 2024 03:33:18 -0800 (PST)
MIME-Version: 1.0
References: <20240220174412.155885-1-peter.maydell@linaro.org>
 <20240220174412.155885-4-peter.maydell@linaro.org>
 <ZdTqNmZvM_S9SwDB@redhat.com>
 <ceb828d1-9283-4ad0-9833-2316b024d00e@redhat.com>
In-Reply-To: <ceb828d1-9283-4ad0-9833-2316b024d00e@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Feb 2024 11:33:07 +0000
Message-ID: <CAFEAcA_bZmed8tYEAZ+rbMB2d1H_36TjSkfek65AAR7KCywXzg@mail.gmail.com>
Subject: Re: [PATCH 3/3] .gitlab-ci.d/windows.yml: Remove shared-msys2
 abstraction
To: Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, Yonggang Luo <luoyonggang@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, 21 Feb 2024 at 07:16, Thomas Huth <thuth@redhat.com> wrote:
>
> On 20/02/2024 19.06, Daniel P. Berrang=C3=A9 wrote:
> > On Tue, Feb 20, 2024 at 05:44:12PM +0000, Peter Maydell wrote:
> >> Now we don't build msys2-32bit we don't need the abstraction out of th=
e
> >> common msys2 handling from the 32-vs-64-bit specifics. Collapse it
> >> down into the msys2-64bit job definition.
> >>
> >> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> >> ---
> >>   .gitlab-ci.d/windows.yml | 84 +++++++++++++++++++-------------------=
--
> >>   1 file changed, 40 insertions(+), 44 deletions(-)
> >>
> >> diff --git a/.gitlab-ci.d/windows.yml b/.gitlab-ci.d/windows.yml
> >> index 8fc08218d28..e784d5a68cd 100644
> >> --- a/.gitlab-ci.d/windows.yml
> >> +++ b/.gitlab-ci.d/windows.yml
> >> @@ -1,4 +1,4 @@
> >> -.shared_msys2_builder:
> >> +msys2-64bit:
> >>     extends: .base_job_template
> >>     tags:
> >>     - shared-windows
> >> @@ -14,9 +14,19 @@
> >>     stage: build
> >>     timeout: 100m
> >>     variables:
> >> +    MINGW_TARGET: mingw-w64-x86_64
> >
> > This var isn't needed since you remove the only usage of it.
> >
> >> +    MSYSTEM: MINGW64
> >
> > I'm fuzzy on whether this is needed or not ?   We don't use it,
> > but perhaps it is something MSys wants set ?
>
> We've had this in the very first version of this file already:
>
>   - $env:MSYSTEM =3D 'MINGW64'     # Start a 64 bit Mingw environment
>
> So I think this is required by MSYS.

Yes; it selects the compiler and C library to build with:
https://www.msys2.org/docs/environments/

-- PMM

