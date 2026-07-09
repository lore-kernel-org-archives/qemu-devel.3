Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B693C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 11:16:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whmjx-0000un-Aw; Thu, 09 Jul 2026 07:16:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1whmjv-0000p9-Ot
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 07:16:23 -0400
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1whmjt-0000Qh-Ni
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 07:16:23 -0400
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-667a0f55a59so2109159d50.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 04:16:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783595780; cv=none;
 d=google.com; s=arc-20260327;
 b=Edy3AopU3ejJMyLcM7ims26V98Bfmzm5WyxqQB8o6QnnYLleoMuQtWhbrywy2CB9a6
 Jh9aWysacn0lvUppF2GJ1lQysg0jGUcEjWIOBmFjU7S88GEfstwcXnpHhvEMecQ13Ukn
 kWHEoIMC+DroQpBFU2MoEOSS+WdhGk7m+MWSwtw9VhtfL6O045Pr92Eq7xNz8pOJIvqT
 qejfDNkp8Hoz/ZrMXWKg4hFzhmB9NLecld8TVF0THBAJoBLB/dcx8zDK5nYHRqlblE9R
 juMiUhmC3TUhdVx52fcSgNw0UjywTX0/udqRjfCVAqjzAsCGsGE0sBTO7E5DH/pb70nz
 WZ2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=4el3gtjB6P+IfG2AzxxO2fTsHuXSgKHJ/UYCEkQF1UM=;
 fh=0wXEfIayRFbaZlJBXS1m7OitRsYmpW1CQadofollEtw=;
 b=gSBlJUmnsRRl8DwEDI4l0/6iZNIVl3Xp0GWhFX9lPh1ijqYDLQ2IQ6vUNJu27JxyuD
 mIyXm8nEPSMp0ceSoAIYC0qQEaOk5JDM2d931ePGbRP0eyz8oYN4w9+zWTKgbr/FdM12
 +6BBx9VjecgZWAsauOi6DAm+Q7Q7gecWnQkipX80jxBwxpxyIM6LQ726FqPhi21Ui9h8
 UNOWGy2gedgECK36+RUnQef/rNE2LB4VYZq2ysJJ2jCFcnFqHeBeLk49QJRDrw868nrv
 yg/6zuDcUBh1CelqDBVK8RmJPG5mh5BdBQmM0uCrDBVA2THqykediVK+D38S3by1eRkx
 EeiQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783595780; x=1784200580; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=4el3gtjB6P+IfG2AzxxO2fTsHuXSgKHJ/UYCEkQF1UM=;
 b=nt/Z/YO0G6LR6BYtW9Ay2CeCbveS3toE8oAxw9+mRPm8AGou6QNdoi4pdNHgyffTDX
 9Rh6TgRero5qMMWLrzAg7OP7m5qTgq38qbj1LSLCne8T2UdFxEPNXUc8cQ/FvVFul7Xv
 83zXz1QIQSfU3MVFowxN7JP1L++plk3WJutjFaFYtvkUcc9roOUmnefPPFBedQ7N9IR4
 0wq+Oqdjpm8kYficoBMe/lBxLd0hDBsEWsecjO9hmaU0W3mowTHZu60N9YWJ1WybjJ4S
 I6qIS6BnSWFeTQkf+/Bba/XnQqF7lqmSDwtg2obXqUQRRKn4eUTAYYNFRODSVvBQ8l2X
 TQDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783595780; x=1784200580;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=4el3gtjB6P+IfG2AzxxO2fTsHuXSgKHJ/UYCEkQF1UM=;
 b=f8XdXuaspEnCmGAbMMsGMx2zg3ecwAxkvqGMyz02Tp4c1E4KvNvGe8iQWIfKwmQnTy
 6LZvwJShtwY4VeVb7et/UBMp44ZXQs3hblvYBk1gT5tBdoLvZj6G9udxPezVPk57NRXP
 o9qrj2ie4N5E1gbXKxmqs5b1g0Th4QNeuEj0B/5pSr7NHUb+cez05NQqAKiD1IKFw46k
 q4s6/pH60GWrSqrpDfE+57z16g39LWstTyoe8eL4dyQpc3Ugaty77cPARYTGeB7KG+1g
 U7g8myL/F44QCo+ugl5GokwCTVNKXJh+xJblMmvkqKIVQ/qmES2jk+BSJn1B1l6PuRGZ
 jLCw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rriy6G3yenBhE7zqOpRguHgeq3wiyfHD8IYBo6t6Za2kJukT0zLUxK2GcwLwpLoU1IeiqUtb49b7EEQ@nongnu.org
X-Gm-Message-State: AOJu0Yxfm5exf15qAyzYoe4JHWeK2VWwaxHjRa3ruhL+mkkmZ2XkszQ/
 70v/K3jQfAFCQqp4tB67/UxaqPCUNw/sVgLc7LHynxxgyqdarnaAHvYRNge7Qx/ZHk3qLX/W5TP
 SyI0J7auM9HN2qN0IbB4TZirqGgmPM1d8LAWZEaZ38Q==
X-Gm-Gg: AfdE7cnp9OAUCQ2jhjodiBnGYfAx4Fz67EGziYKQC0XC3LNC3SZHGYgap7Ruifzqu3y
 PHIQ/ITzKAKSAFlKlq8gv5dfAhhKcgO+wkKakTOBJhwo5BRMU7vvEX7ZOV4O9+uUAbkFJBvH8sL
 KfA2sf8VfGcvUc4rg91MYpr+ge7WKel+V8H+nJSMRJValnHgdmB/PGcnZsc3csQWw+zIsFH+pBH
 aDhwa0iT2+hSK6iwXJWQxQV2nfbiCZbTyxxMiqpcrfyUF1t/ihRJ7w1iMsk073aGw23WXPzfBxw
 9opUUgA5bDYCMzHVkVeEsU8TiBfSxEbJT15axmwEkNo1mktoQY11x8P+
X-Received: by 2002:a05:690e:248b:b0:667:8b91:2421 with SMTP id
 956f58d0204a3-6679f26e3f6mr3814978d50.104.1783595779979; Thu, 09 Jul 2026
 04:16:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260706230056.1888992-1-titusr@google.com>
 <20260706230056.1888992-2-titusr@google.com>
 <CAFEAcA9kmrEFCiWLfL1FSLv7W34hSqvFaY7=BpcT+h-WnpKC_Q@mail.gmail.com>
In-Reply-To: <CAFEAcA9kmrEFCiWLfL1FSLv7W34hSqvFaY7=BpcT+h-WnpKC_Q@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 Jul 2026 12:16:07 +0100
X-Gm-Features: AUfX_mweGC0joxUaIudHt3HnwiQK6HUoIDrmKvE3qFLxazyet5U7_JsS9DV4ypk
Message-ID: <CAFEAcA9kDtqU9pi13uWUBoUdrhriUWieCaw0AK3HnUZC1dKtvw@mail.gmail.com>
Subject: Re: [PATCH 1/5] osdep: add DIV_ROUND_CLOSEST
To: Titus Rwantare <titusr@google.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kfting@nuvoton.com, 
 imaginos32@gmail.com, wuhaotsh@google.com, philmd@mailo.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12d.google.com
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

On Thu, 9 Jul 2026 at 12:09, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Tue, 7 Jul 2026 at 00:01, Titus Rwantare <titusr@google.com> wrote:
> >
> > This is taken from linux/include/uapi/linux/const.h to match the driver
> > behaviour when reading sensor values.
> >
> > Signed-off-by: Titus Rwantare <titusr@google.com>
> > ---
> >  include/qemu/osdep.h | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> > index 1ec5b42230..a6a40ab8df 100644
> > --- a/include/qemu/osdep.h
> > +++ b/include/qemu/osdep.h
> > @@ -522,6 +522,20 @@ void QEMU_ERROR("code path is reachable")
> >  #define DIV_ROUND_UP(n, d) (((n) + (d) - 1) / (d))
> >  #endif
> >
> > +#ifndef DIV_ROUND_CLOSEST
> > +#define DIV_ROUND_CLOSEST(n, d) \
> > +({ \
> > +    typeof(n) __n = n; \
> > +    typeof(d) __d = d; \
> > +    (((typeof(n))-1) > 0 || \
> > +     ((typeof(d))-1) > 0 || \
> > +     (((__n) > 0) == ((__d) > 0))) ? \
> > +        (((__n) + ((__d) / 2)) / (__d)) : \
> > +        (((__n) - ((__d) / 2)) / (__d)); \
> > +})
> > +#endif
>
> Can we also have the comment from the kernel header that
> tells us what it does, please?

Also, the only use of this macro is the unused functions
in patch 2 and 5, as far as I can tell.

-- PMM

