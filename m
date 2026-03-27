Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EE4F10AB830
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 14:20:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6821-00069y-N6; Fri, 27 Mar 2026 10:19:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w681w-00067t-Cl
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 10:19:21 -0400
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w681n-0007S9-9J
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 10:19:19 -0400
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-64ee82e853cso1791341d50.3
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 07:19:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774621150; cv=none;
 d=google.com; s=arc-20240605;
 b=HABjXvztc4Aer3Gti+062qw/zZYCHB9QUiXAG/iU1vdziPGF+CgvqDVjFC2Rqf2kTz
 rWRPnRXH8TTsoGH3ME6wD5FLuDArZ6l1UpkGXKqfbMG9Jw1IHASHObh2KL8ucz0nbFgM
 GOYPqaCL2dZ7QQKWbpwWnFC/rEEWhuHDMLq8EdxKD3+i9HVWmeR7RZ91nw9D6KyftgfF
 z7TIglsFvUqddj8etEeAAXtrtUKJJEEeqeVthjMSUadadIdV9OxwU4ECFMuE8hy8nTuU
 dAO2DEcnX0J5QTvMRj4S7RCbjP5FLF2gBTy59bDN8jvY452CZ5XZ/9E5vkDvA6XMKFR/
 M9vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=XHqKNwchX9pcFRNbqu4Pgrl3e/KIoiPTpQ/JU0j/py4=;
 fh=pxAizVm5uWiI8EaK1wwyp29LjLT5ecd+LPJaWPlAHro=;
 b=Gro3+wZ06p7OkOQiw2Ng7s9PC+YD2SEOHre/z1H5zWaU5heumn3k+wHjV+zm+LEJMu
 eV2Jgf1naKy6gGLO/UhvAkU5X2Ss25NST6RltSjQt4WhDYKOyAaj7636O1/NZREmsAxN
 dLuplKn0tnnePOZJV9g0mUOzzPzvYH1yXOCliF7fDkMl5D4KbASWEzu2G5KLL3PkuFf2
 XmfbG9prX6tLzkDVxy2FJO+KkMpAn+kia+71htrxe42c+v51m3iWpmAgeOw5pMsVVuJ4
 oiewTtXJeyHY9a4MIOwzpNLufrT2xFPkn47pZmAGXjmAisrW0ecVEtI92S/5AsB+TT3V
 NVqQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774621150; x=1775225950; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XHqKNwchX9pcFRNbqu4Pgrl3e/KIoiPTpQ/JU0j/py4=;
 b=k5Rg2VuvDSiL7c1RdZDP6+bSx/fem5gKWm9LkNQ5bjjEcB67c0joJht0KxrWc1HTKB
 odU/GG0aEgB+vWXF7DXA5bBKd2HCnNBa60QXzpAMeBNmMDpSVgEKBRdIKxJRpFrMAFIG
 ozj4EMxrfVZMesoZ+9fgPCduCEx+iFaZV6ncM6TBsXsg62qz6hXBJh4utuojIrGP5FD1
 OibhRhvMATcHnVqSc2q/00GrH94J2TADvr6Z+FknmHadmr9cv8WZCILzI+R7w70uCcgr
 Nru6QESKIyL8nWp6iS+AjZVCS67USb/uRm5Jd9x4AJFLYdnXc2/yXyRMzYFOn++jSP5k
 2Rww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774621150; x=1775225950;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XHqKNwchX9pcFRNbqu4Pgrl3e/KIoiPTpQ/JU0j/py4=;
 b=Gj1tVKwMa+l13Kj0JBEbVVcAJ3nc5PE6k9EhIbjHmIoDHpi1+wSF8/QHuYyfBZhC9f
 Ix6D14OiY5O/g7fzqmLaDTLp2eIcWxeiVqJkPC/nKtt9h6SBP5+F38slgaQ/jqqiOcvv
 9GE2GSSNvOJ3W8ng6/VqUB8WRG1/buhtbN0UPaW/36f9D44xYhWMTobDoL0PjTPHRD5J
 FcEqn70CcOADjGzBMZxqhV5NMZDhaUomZIp1R57eXoz6EgrBIapIhJhEYpyIsz35IM/C
 lsJKdhXhJrzRYZP2/ZdYvxobbNfavqnvKlnVTAOb4/oSa9lSrEeJk7msbUp1Ys9XG5Ci
 4FhA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUt4PHQdX1k8tlyzlBBo1w36abCSVe8eEvmAvTro0201dp1czn3V55XvABZg1grcGlRUEbREYv3A+11@nongnu.org
X-Gm-Message-State: AOJu0YzzO/iZP2hUbNPtWzF5ilUJEN9ZFiTk6kyR7Sj6j6cDz458Pb+4
 rHnMWA+ldcNxT2JlCERmjCkD28m9xekwgbrPgRmW+x3Tv/1FbqgDjvg8Z69tPC7IeOakIeHdkl2
 Ks6R8g6c05zUZa08V6Sl7vHNXRJUN+Brh9LXCIruIUg==
X-Gm-Gg: ATEYQzwqfEg+aLzgvRNfpO88qyztzVagCym9n3OrG1rO+jBq8Cm4o3O4x5gKUW8TiBu
 OMG1RdHW7iXLmuVIaTV8U9wNB8k4vCvo4b9yoHVTum+D79V1akCxCgjqh+n9Pg/0jMPoypC03Mi
 PnFzuU26+hxTLTI0p8Xw57vslCyu/xNvch3j9vh5qXOUkwUpHTedWXcik5nYSNni4kvG9Uer76H
 JQv0LjYDeZzKMjoNkNz5Cd2Y74YMG7Uy24xk67k6uw+JAbTdwk6RDwVl+yeaewt48efzGjZC1Aa
 Q4rIzSf/9flusq9EIgDk+uFAQtASopOpj3yBpLauYQ0kig2XivAtZMY22eoOGkpFTFg=
X-Received: by 2002:a05:690e:484d:b0:64e:a215:11de with SMTP id
 956f58d0204a3-64ff71af9ccmr2449912d50.15.1774621150217; Fri, 27 Mar 2026
 07:19:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260327134401.270186-1-kkostiuk@redhat.com>
 <20260327134401.270186-11-kkostiuk@redhat.com>
In-Reply-To: <20260327134401.270186-11-kkostiuk@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Mar 2026 14:18:58 +0000
X-Gm-Features: AQROBzBHLUrurUIL4GpoENhHthPYnPAJkGXERrAC4hbNeIBZKWENmbOHRY_hW5g
Message-ID: <CAFEAcA-v4E0kYu=aebegjaO3wU_en9peLUb5SubLSE1H-EV5TQ@mail.gmail.com>
Subject: Re: [PATCH v2 10/15] hw/ppc: Use glib2 instead of
 strcasecmp/strncasecmp
To: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 qemu-ppc@nongnu.org, kvm@vger.kernel.org, qemu-riscv@nongnu.org, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>, 
 Nicholas Piggin <npiggin@gmail.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12a.google.com
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

On Fri, 27 Mar 2026 at 13:45, Kostiantyn Kostiuk <kkostiuk@redhat.com> wrote:
>
> This is a change in semantics. g_ascii_strcasecmp() doesn't honour
> locale but strcasecmp() does. But this is OK for at least one reason:
>  (1) QEMU always runs with the C locale so there's not an actual
>      behaviour change here
>
> Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

