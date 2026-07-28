Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7903FC53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 10:40:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wofDl-0007Ci-3x; Tue, 28 Jul 2026 06:39:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wofDj-0007B5-Sg
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 06:39:35 -0400
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wofDi-0007sI-7E
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 06:39:35 -0400
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-668296d0ff3so4625669d50.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 03:39:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785235173; cv=none;
 d=google.com; s=arc-20260327;
 b=fE/9lt5M1Bumt/olMMVffL2n0JJjYUf8e5HHHAlEGVm2TZOywMYgEJb9wRaV71cfAl
 CimLXNlt7o604bi5KtN+gt5QVnntoqU8KFLNBp1u3IDKSr8t6RJ9E8IPoMSLk4kqixZ/
 KqIU0dZkRqMC0YFOxPTbHhaJZ6lSbi8Xq3njWkjaVQpKY8Du/2dpUnSISJUVCRh+r9Qo
 LiCSzHekdT59MBnVaERSw7HW9/TDo5qRduOvu2P237V6piPDAWwrouW7GSWHT/i5Xvd0
 fb6hH5QGMe7QAmHRpOJCrkkz7rBHQJjhOPzIN5ci8Yoh5+ZWZVH/92WnCgBR3wL8K+Ch
 /qOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=cHjcYC/KMaXgYVOEQmUvus/3EYXd8abzz0f+0gpH9Kk=;
 fh=aCi15rLjHd0HTcaHHcYIVrp/umzYaBDQjeDtFNkfWDE=;
 b=UUEiK2JXUutIy8rtVtUFRNkePItaZOmEFTTJsPX7YTE1NOeGtpdFfOxlAfUtxxHF2O
 CRebcmUU4/5/GFHmgMTjmbWeCI84N/nJOv6Q36FIHizWjleTBcIlqQOzUiL22JLyDJTB
 Dd+oMmfFKlwrenA63+OmRnZJZE1m05IXbzKG98WcNa/+PtGK+oRaS+SRZ4rpxKx0aD41
 1yR/OIu2TsLg0ZPX+Bk/6SyRBXIurPCVWSV7W7U2cq7FYdm97Z3X6vrNIpR2YZmXmtic
 PWsL80FLzxOJFW9+dyNbRMDL/qtbUS0m9lgVOjMzPrapmq4IfXfmGQAP8CqiHI2fomLb
 JcvA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785235173; x=1785839973; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=cHjcYC/KMaXgYVOEQmUvus/3EYXd8abzz0f+0gpH9Kk=;
 b=lypNCsIWmrOKhLJxI+uTv9SwB34SLmMIhQCqnKYMDiE6zNHz/LtgmJKuIbYNOog98I
 JK1KVcBZ6FTjFRVITjG1xaoCSB6fIB0rFijg+i6dyeMWwBTwoK6N7sJWPEVhRZFZ/C8G
 DCVt5Snb5r4cJIUgpbpfyyw0Qt98Kpar4yXdov0nJHcJ5uPMvQOcm7+oRM53A8Ws7Usp
 KuXIzeTGH0YvUQDkPYgKO9RoXG4v4lGmG9AuOxCYgG+0RqSKoTftehnhuPlqeIKkY0PK
 HfBhc1eu/i1u1miLgq3aS4zHtLSBI1MeXRGGfWtsv4nF9669nsyNF9r70uDPAUpc4HwV
 3JCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785235173; x=1785839973;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cHjcYC/KMaXgYVOEQmUvus/3EYXd8abzz0f+0gpH9Kk=;
 b=BvcqxuYyNN7+MyNh2GLI+C6quwuGUEr5TyS2xLkrxhpqjbh1iCGC4Abk9ui1CbURZa
 Qn5U1OCoCruhw7kgbUS1HXexZYDdNUYgSHrdM3mQJ6/BoupKpF/PrpFY/JKSG+N/UwLb
 63HRkapo4ea1etrY40QIpOeE/2d0DNPe6mfaDiTUTDP9anjIxogL7ZoD3U8FHP9d5sg/
 VY6KjTH+cFLG0aSwQfAbZkMlZvQ+G4Jjok+2ct9hJtW4LLiY/LblPlqOcFppxs0NHimZ
 38Sn1Zcu95bSnSKPr1RmUcEC2FY/3KcADya69zSiGD4lUSSUHUrmZ8F0s2ZmuvMD9cgG
 mjkg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoSlKTaNTXKXVv5Th4nH7O38N3TT6VtLRHfNBstR0QIleIpRvR8RCxESnrCob40Oi4QCsEkbt+DslmY@nongnu.org
X-Gm-Message-State: AOJu0Yx0D8KfEn9vA0aEnLy9IVtXXYvpPHHtODxgJoCigKUNxw/R6Mrn
 4mTyEoETSJ8Mbr4nIbt9NtvZLlbK0vQ38crfSNECo2GwznNN8bzhgE+weuUfWQZjXlvP7IKfK4r
 TU0wq6+RUXQeWHIQZlcYqrdIXEvZjSKmkHwFrTf+v3Q==
X-Gm-Gg: AR+sD13c6jg8byxv2wHT1w6rJ0HeppAkvOe1ZQ4a3mWw+tR+EWBHddHa+2E1VKLTxQ6
 NarjkiL2KGvULIcEs/SuQIAF+1A87913Zp47gd+QJg3hF5jxV+bQ34AtcZ1oFcq8LnQQXi4XBCr
 wG7qhvnDXj1Dip7YJ3At5Yy9e1Nbh9tAkXDW8dodSZ1yZ0GZTQ1Si6c4GMHsbX2cq5o5nQJBVBY
 La79WKI4RysJu8VzxSbMPolV1Oq/Va6tvyO0SwrlUZzf/Wy+DqgbxuI6FftpIkcQ07N2TyTGTs7
 jgvpr3jYieQEbHKuii8ze2KMsLy7XWL/olOu5jHXq05mYw==
X-Received: by 2002:a53:c742:0:b0:667:bd13:2f63 with SMTP id
 956f58d0204a3-669057fe562mr495189d50.59.1785235172649; Tue, 28 Jul 2026
 03:39:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260706173324.804340-1-peter.maydell@linaro.org>
 <CAJ+F1C+TO_-ktDqJnbeXuaCdAsomQMTvWZ8aAFndn=JPF1+2sw@mail.gmail.com>
In-Reply-To: <CAJ+F1C+TO_-ktDqJnbeXuaCdAsomQMTvWZ8aAFndn=JPF1+2sw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Jul 2026 11:39:21 +0100
X-Gm-Features: AUfX_myDmz51gbMcofEJm5InBMjAOqEF5SuOnjW3GQVWoLXjHuRazBs2K-6MfwQ
Message-ID: <CAFEAcA8krc1OoZOxfhjcBVW-pY8MVX1e0gQGa=YGRVAtOLU_GA@mail.gmail.com>
Subject: Re: [PATCH 0/3] hw/display/exynos4210_find: Clamp windows to screen
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb131.google.com
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

On Tue, 28 Jul 2026 at 11:08, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@gmail.com> wrote:
>
> On Mon, Jul 6, 2026 at 9:33=E2=80=AFPM Peter Maydell <peter.maydell@linar=
o.org> wrote:
> >
> > The exynos4210_fimd device has a setup where the guest can program
> > both the overall size of the LCD screen and also the corners of
> > "windows" that define where the guest memory should appear on that
> > screen. The current code assumes that the guest is sensible and
> > puts the corners of windows inside the overall screen. If it doesn't
> > then we will try to copy data to an address that is outside the
> > interfal framebuffer memory that we allocate to be the size of the
> > screen.
> >
> > This patchset clamps the window coordinates to be within the screen
> > size. Patches 1 and 2 are simple refactorings to make the third
> > patch easier to read.
> >
> > This fixes https://gitlab.com/qemu-project/qemu/-/work_items/3795
>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Thanks for the review; I've applied this series to target-arm.next.

-- PMM

