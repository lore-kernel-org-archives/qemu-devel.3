Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 595FDEC1433
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 12:00:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxOPM-000492-3b; Tue, 03 Mar 2026 06:59:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vxOPL-00048p-8y
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 06:59:23 -0500
Received: from mail-yx1-xb134.google.com ([2607:f8b0:4864:20::b134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vxOPJ-0005oV-Ro
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 06:59:23 -0500
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-64ad46a44easo4664520d50.0
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 03:59:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772539160; cv=none;
 d=google.com; s=arc-20240605;
 b=Zih1p3NMIQCURStrtGaqULXSMQK70dpHvUsLaDh5XodKLiJGPo/yndMkdiCginsZTy
 AVsZFY40zw2jiAWA6A8aeGjAjHo14An9sEJ2dx46+QxcIkoGFnLffv0LrBUPvXkgBBPM
 3XrddlitzAx3cHofVoNdSPVdOm4J/uhG3UPbAuc86HnIje149Y64U/np2pimQpRzvSsy
 btR9tKYbTE9uFy2iaCmFvUupzsyUDExO0i7SYWN0wUKsjr8yOn+rNv0895Xf9h1i4AGi
 54GcBBgEvAc21BLGZWnAbibzMkec2KOcFXG843DqFa8fFJsYbeHoAOvCojvLQ1s+xOeb
 G/rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ATAAqADWLhJcucYMVp5poYOpEFDYD4X1liaqVziC9RA=;
 fh=PqFuXL6Ce1Ktr6kc1O4esZAMZmD6Wd2919GeAUYfHBA=;
 b=QlYdahnCB+OiL8tysuflCu/yDQm7+enZNsXMqbyqX55830CsLFn8yPckmS+9CD8ORU
 5PHeSGg4CQlirZI4DR6TIMC4ZLKgAFx2HpAk8gJsrcE+BWPzcv0bCNKpGGQMTFl4AxR/
 Y/zy6L3erUAZaQo793zsB+jcWgYCTfAD4wExLUO4vWjDItwL6H/NuBoJgFatXQq2ctAI
 DerW/LEfrhDEolk/IvY5YNnBEkXHxnSlgFSRchwkPYPe5bH8F4GLOv4m/rwXGRR3a67n
 ZRmj9aeaeWHGWH3mD1cWGwGFarXMrtZR6jDsYO6jPEjFHH4SoFtEKuFGQX2iGwFpDTBv
 Zxjw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772539160; x=1773143960; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ATAAqADWLhJcucYMVp5poYOpEFDYD4X1liaqVziC9RA=;
 b=sXRom3A83n8CIiEQ9/UbyL+l7NPL4bHEvICmbzEt90GLUhtlqUO8Nyu+M8qSndoHqi
 mVzj6jRyFt9Widhz3PVm67KaLgzzvqLLJRYbS6RTwJD+Cveav7K2uXJSDadbBe16vFwc
 /LTiIP+f2dzl8aF2DNJCPsfyEqlo3cjhHK8H+J1xjlNGKCu+JcYoLhaGB5hnzfilkG1h
 ieOOduyv0GDQ9nVv8p+aP4TuQxBIhajYPcIKZyt8iBKS7OKjYI63bUNZCP2h7t+NzJuD
 5zkaJpTEShiBxIA6+RbiglgkfnjrQ5n6nCMSfnE9ByVIydvaXMGEOM0bRYC+p3mPXEEC
 cQyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772539160; x=1773143960;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ATAAqADWLhJcucYMVp5poYOpEFDYD4X1liaqVziC9RA=;
 b=vTTVsfn5XI22YxLP6n2/X2fnjfVVph/hZgBAcGvZPmWxlvs4OcVw6vtF2dW6ZS5e/0
 rl/YAseE/CryPkFF84YgXcquxth9qUiRxg1b8lZE5XfHtCY4QGBdQFlBA2CTHNLBFdXH
 rSx8pr21fo+a3NPPwEvG4fFKW7dtDoNLtvScXZHrTaQ4QQKV9dzmaTu3a2RkfRghi9Sy
 QcPkShoe5Wr8qaIOvugsQ3R6fhLiXspPu7PqjKpJ0U4PZo3tJchp2/kfc29OEPCNKyIa
 yn8bw9rOHYQ0HzMb8qVJu0JNI4I8V7CNxyYZ9e+exjJhKa6e/kbux0XrG0RgcgI3iz3E
 MVVg==
X-Gm-Message-State: AOJu0YxMTnj0fnjkO8F3jMWnmtbBWYWciuam/P57GlE4lLoHTrdN6I9E
 TCuDdexJ8w0uXTXb9CCZoY3dBMX9KQasldmww6K25KFL+PaK6VkvIMTAP0fxhf/H44LltZKKuSv
 5r86vgED0as7vh73L9QAx94tnjrT6KsB8J1UzmEduunSFJNivuRlO
X-Gm-Gg: ATEYQzzSROWoKCaqktRVBGm6YoNdI5InwudEKq0SswMYh+bGKcTSdY6k8uXVxXXgjnC
 ajQj5nATQ1QgWj6Z4cgRn/DJ/WrQ/zQpUezxbspSCDqhiGyP1XbJoYrLXQu/YpFOcelxEioQm3O
 +tUFHAC7E8tvFTT2sUUikwVoh4BbEm7lioL+4W1cPkGxYe0W+IlBVGYCczuDyhf90rcGHp9CWqP
 sFRi4M6URCgkaP+v122Dch30PYjDxmqYZbN6mo589Rckf9yfgxYC5npE00TTX5Ff6XjVATp0xSA
 vF/m1qkC3PqWGVr2j7iTO4plTvshLHg9osRJHB5KBL8a5nTrgrlfcQuaCDqx0bNOxeM=
X-Received: by 2002:a05:690e:14c6:b0:646:b1f3:aeb2 with SMTP id
 956f58d0204a3-64cc2027c56mr13059681d50.3.1772539160610; Tue, 03 Mar 2026
 03:59:20 -0800 (PST)
MIME-Version: 1.0
References: <20260226175700.1319767-1-peter.maydell@linaro.org>
 <02977c5c-0ec3-4686-9030-7023e183ed04@linaro.org>
In-Reply-To: <02977c5c-0ec3-4686-9030-7023e183ed04@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Mar 2026 11:59:08 +0000
X-Gm-Features: AaiRm53mK8EPCA65bFlRWJ-0KnSN6g_VU_XWc93icIRK_5oRDMX_C6VQNjmZ194
Message-ID: <CAFEAcA9rnKmydncCNz12anii0mHvassKBN4kq2zzYrQJqfSc5w@mail.gmail.com>
Subject: Re: [PATCH] system/qtest: Support comments in input commands
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb134.google.com
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

On Thu, 26 Feb 2026 at 21:47, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> On 26/2/26 18:57, Peter Maydell wrote:
> > Allow the qtest input to include comment lines, which start with '#'.
> > This allows writing an input file for qtest which includes commentary,
> > like this:
> >
> >    # set up TCR in bank 0
> >    write 0x1001000e 2 0
> >    # TCR TXEN
> >    write 0x10010000 2 1
> >
> > which can make hand-writing or annotating reproduce cases a bit
> > more convenient.
>
> Great idea!
>
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >   system/qtest.c | 5 +++--
> >   1 file changed, 3 insertions(+), 2 deletions(-)
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Thanks; I'll take this through target-arm.next unless anybody
wants to do something else with it.

-- PMM

