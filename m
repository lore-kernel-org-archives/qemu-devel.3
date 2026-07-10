Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6935FC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 08:57:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi72h-0004Yu-AT; Fri, 10 Jul 2026 04:57:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wi72b-0004YD-1K
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 04:57:01 -0400
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wi72Z-0003hv-IS
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 04:57:00 -0400
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-664d530fcfdso1242469d50.2
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 01:56:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783673818; cv=none;
 d=google.com; s=arc-20260327;
 b=g+Yw9eDzqFuXKu9LbJnAJgF9nr0oyb3l3eu9Zzz9bl/Z/eXXuRP7E3fhvHYTVZjYAF
 3fUZeroY66wept/K9qpG6EcIKdstXc5KISPTQ4zTzy4ZLcoD+UiR+y2Y6aQv6IVZET6X
 0Ox1hEvFwD72B38F80c1x/qOJziaOEyqovsBV4YpCFxtbrSPcnKmQ2JiI0J6USfsxjpJ
 gscnH4/ekNa1/569YgpbF1f+5ntZirtcsh8We2eCUqHZkAMB4AyYYBTEF5b5RLZwYVbr
 ckOyAA+dKzs/khGrPwODvlnVkJtI5+iKwAyVHjoDg/0/5a4ERX0eOJrqhD/jagLd/ZnF
 QV9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=mdSMDbV4T1XlcnF8kdROOut/DuLG6VfDGXEChpD69kA=;
 fh=bMrxbIIdcP3dNETLFknNoaH4segOK4xPdkiRZAq3Dng=;
 b=XfHQVc/RQzkM5pD32ErVQPwO8xcDAggLdi04g4r8788RDBHP3lGlyxfoOjk+KzzC4w
 RxZvpWNtKqKPI8UdiVMIpt5QKobILKbXncAxrBrPmJZ4rtVPyxaSwFITqI5YD6dJsanG
 06FNGj42gyWEHsRDgTB2zylszPsCw693zcDalvbm/C4EhLTuVNZVkQX+d63ipJh4Uo52
 m1bY+fosnO9WPNiZ2HRAo/98IndinnMHWRVNRIWEarAh0xU9i713d8jeVFm2IZXr5VOs
 0HeQf0nGzXitiBuLQ1pKLzthCMNUzXhhpyTXdymayrcbq5/ddrK0Lpo59pGWrMOoIpNO
 2GxA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783673818; x=1784278618; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=mdSMDbV4T1XlcnF8kdROOut/DuLG6VfDGXEChpD69kA=;
 b=UkeBKRcEk3uBp2lo/BTpW5R4F7PVMqnaTUkLPxzUjMAiH0RUtA1SRwLB9Tq4sSk3Jf
 Hj3sW9q0MUT7e9aN++Iw5BhzJ7nPrUtTS0PAplXmignYx8fGTipaBXpN7xHTcMFXjgwd
 syx9Gh/yoFMMOT8800BRDvkxAkBAdMWrcgmD3HLPtvJDeoArszgA8fVNN3ez1z0NyeD9
 hR8hxwVpDBgMUtoitBObqto/qyI5/vZeLS4MaWptjBZq93iwidQTmqgCSYbNLUXzgLOy
 6diJ6qr//1AJ08Yu0i8N9CjAUCRcDEo+1IOwfnHbDlNk6v8y4DXCWorYP5ikAOdC6xrm
 6Tng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783673818; x=1784278618;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=mdSMDbV4T1XlcnF8kdROOut/DuLG6VfDGXEChpD69kA=;
 b=PJos773r+JG9oxT+uq71MHJOABcoNIpKTdWDiY2Z7RdTDYRLPOSyoaOtew6cM9JtVR
 wEI4c7rgQP4MjDGB9lMcld9vJHmJByvhFCz54Hl92HYuH3xM+uveiY1VwifhmbIfSHtw
 nk/yJ2Wwpiin1nt2rbq47t+5EYKNAhZTvEGCrHKtOD9J7+1NmMzS+G4lSrBFhRzubDuQ
 d0dEOGZWzDrYdtfh/OXRjT9JDoP4lwyEcmC76iHmhl0B0Hs8Y2S19BYQOkfvsdX5ZFbt
 gatU9BkM6kr/Cney+RbSJQzsVUvcoZhHHKug/ZfQLYD4VHp7g5SwqMRyOHI1jyqmbKcD
 BDBg==
X-Gm-Message-State: AOJu0YyChrXD2zWR05E6ROYBJOV5V3WkF1BEP0IIvRZmZW2id2P2eg+J
 4nVhGDWGUUEZHqKvwzM7ZOXyVUiL5ZQuVK7PUG5e6FDE1Gl0+JYztbRXFk+B8vofEirC4sywO84
 HDI1OCF1F2JOtyXdv5Te+aPw5KrcRnaU6hvYRbmOzNg==
X-Gm-Gg: AfdE7clupRz7XUft1z3auAwbQl/lqj8knA1yiwHrOYT8Q/xcFJyzgryZb/fiMkWD9Kz
 tY08/d3nnZraXymeuV4lXM+bP419lZWw7+seYRtyZ0UJvVxloyJ22nAukJ1pOQuceD7PDg5JJ6H
 q6Qi2M/GInJ+8uEDkgM1/DKDAnmdl9X+oLQorz0Gog+3hxFi7D0xrHsdklQ+bs8MJaztRK08qpM
 yGICv9ZTwwsIjpSV4IXxjbyqb4HUy/YvbgybGB2YctqIOHMq4ZDKSiIoe21lfmkyk+PUEmOFFMa
 pBaMaonkSQMgntB3b31cD3183MiLDanBJQ3KAaKkUtnz05oBv1h5qqhI
X-Received: by 2002:a05:690e:d48:b0:664:9306:fc50 with SMTP id
 956f58d0204a3-6679f10de58mr6711243d50.48.1783673817392; Fri, 10 Jul 2026
 01:56:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260707150933.1410507-1-peter.maydell@linaro.org>
 <dd2048ff-9521-7f3d-313d-be2b2ff9c278@eik.bme.hu>
In-Reply-To: <dd2048ff-9521-7f3d-313d-be2b2ff9c278@eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Jul 2026 09:56:46 +0100
X-Gm-Features: AVVi8Ceqy5BqkKJNiWOrYajLr76r9iA5yFd8xb0kFW6m5jtucWdbPD6FHN1xeBw
Message-ID: <CAFEAcA83Un_7=YLHXgwUfK=kyW4LP0dptDAWZRHadsOydN8vrA@mail.gmail.com>
Subject: Re: [PATCH 0/3] hw/display/sm501: Fix various error-checks
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12c.google.com
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

On Thu, 9 Jul 2026 at 21:35, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>
> On Tue, 7 Jul 2026, Peter Maydell wrote:
> > This set of patches fixes three bugs discovered recently in the sm501
> > device. They're all of the form "guest can misprogram registers in a
> > way that defeats the bounds-checks on the 2D graphics ops".
> >
> > thanks
> > -- PMM
> >
> > Peter Maydell (3):
> >  hw/display/sm501: Catch bad coordinates for RTL operations
> >  hw/display/sm501: Avoid overflow problems in bounds check calculations
> >  hw/display/sm501: Don't allow guest to set ram size larger than it is
> >
> > hw/display/sm501.c | 64 +++++++++++++++++++++++++++++++++++++++-------
> > 1 file changed, 55 insertions(+), 9 deletions(-)
>
> Thank you for fixing these.
>
> Series:
> Tested-by: BALATON Zoltan <balaton@eik.bme.hu>
> Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
>
> I think patch 2 should have:
> "Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3584" instead
> of work_items/3920.

Yes, thanks for that catch and for the testing; I cut and pasted
the wrong URL there.

-- PMM

