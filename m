Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3659BFF8875
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 11:10:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIPHT-0002j3-Kr; Thu, 30 Apr 2026 07:10:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wIPHR-0002gY-4J
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 07:10:05 -0400
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wIPHP-0003dv-Ep
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 07:10:04 -0400
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-65492d097acso647954d50.3
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 04:10:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777547402; cv=none;
 d=google.com; s=arc-20240605;
 b=ZKZqxMd9OsQtPhQrCNZwT5ytL74CNMdteoq/pvWNnOYAqSaDzmMiZu5ReojHwSPbCL
 cCDbIcHsYo7N2zevbbEkOCXOplOZss0t/UP8ZoAkhfgAKNMdTV7v0ePPoV8PPZk3rHZ3
 AAFBxIwK5KTnk7kCXqB4OTNrbTe/kGSQA79IgF8ehlm5jtTc9FhXtRND0qCiwthVtTJ2
 t4k21JDdJb7+KJWI9RAQqXfIB+YssnUPEUMht/bIlj3V4awO+4Mxne/t8n7OWb3HuBoB
 Xo+KLbTil5dK65zVx/6I2P1hwi6nGvn26007bfktWb+VrdwX58/U4fOPFm04ko45myA6
 NoKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=aseB9l6GWX4xSCD8Fhc5hWuLuugGOqqC/9kGLYdDHfM=;
 fh=5hpO1k+4pWDxQ9oa5Nh4x0RcpkpENqy649CApJlWSfY=;
 b=ENwtwJjeWl1FroaKyJlPtBbLipZgTY1yEuWtWqEQBcleCTj+0XVE8tmcKPjH9p/9S3
 kBQdfvc+XC0ocpzSnO09bl2Omqre1M/59shiQR8fYkdlC/uAXNvqB6JgixZPTRefOgIw
 ssXatFtkun0Gxf1KPNu5UYVXhptQxVtua9tPZcAZf3FMmq2rHD1xF5EFHHdPuxAniX2f
 iVR9nxcqqgRou8+m2UjiAaEf1f7x9AqNWLyDuRgWwQyJWrWlo+E5IgIVPVowpNrSpl3H
 Yl1VDrINv/qyETxyBSjyDu3C/0YN4UpvlMaNZHUvjBZMq4ZiUQmCEZOY1kmzgGxMbPjU
 Trvg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777547402; x=1778152202; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aseB9l6GWX4xSCD8Fhc5hWuLuugGOqqC/9kGLYdDHfM=;
 b=K5RkJNAIXUoHiAlhMsxOsGvPz98xWvk7v8oYF5nrPy4eTuBIgGISjjN3dcZ39R7/KX
 93Zt5t4wfButThqRnDd8mSupFP6VpKctnEVzc+DeHPJO+FPaVzzgRjrhhubyfZPAOvTV
 f7hfuIGyKD9XFmF2upU2ScGuquQQYLUKre3WhtiGX21GcdDg2cqyANTj5AYunWKQ+luZ
 TKXtkD+pa0j51oJXAG8CFTTLtu12yX80TZ4M1aAAre9d8Ub58DIdQ250NsJoBaahtx4d
 xL+Sq3Pi3+LaffdK/je4LTACI8tCinwD7X/etXfRjITEl0X9KJwU8Ffbz/FSsDrhX6Ov
 jVuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777547402; x=1778152202;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aseB9l6GWX4xSCD8Fhc5hWuLuugGOqqC/9kGLYdDHfM=;
 b=i5xqOQV+eT1+E9u9P7K3e32qbQV3PSdNAGLdibIqakDyXXAUG/cqEuLaz3o12ghwXI
 QakUJCZlonPBDvp7Q5S/SZOF058TqTkG3QEPbHdYF34q2ou9kDS7E9H7GNl0DfCpFT/s
 tKJEm5JUzpM9WApfbArHdNjt1iR/q5wc4oDiuQbjqOMC+GsGXB3tM1nXQgRcdg4COotC
 LTK8MZZnRAj4+irxFbnPutnXLkKPRSLtJlK+D1VBF2FkCQFy+OUcl2/hBD4oHHWfK3qF
 U8wv6sjnS02ZAavTM6WZYmKrWombaOKFquzPXhzzmwelmXQOBheJtU/f8Z3phELjZxoP
 68+g==
X-Gm-Message-State: AOJu0Yxppwwo+oWCegM6Zc3R3NjPwBDoYUpylkSUrNFN1UKQYj4TA0/J
 rv4Jwqlj7R2Ee371q3t9FF1YKaudcxyR0VQHinJonZm5uTPcICkxEnOt4oDJG6dI40CWeZQp2F8
 CPQhnIg8EzD2fdCUWVbp++jcvBI5c6+uRbM+/Wwa7kw==
X-Gm-Gg: AeBDiesluGz89ODcG8ND71uCNJ4KNmDMvC3ihczXlVEztW9G4gGihjAyi91vZzZbzzD
 BftEWyoaOo/f5qOoBThN5S8ubOTWdx7NDJHep6Pwgl+xG+mdSRZQTMkRp8oKRZhQqFEzLdkqBZg
 M2vVEungqTqMhkGJmOgO4+4BUzj2ttYwPtTcMN7DSSR6yMUxyTMtOZssc19CrnDQf0RAoJ4Vb4W
 FaA69YFOaEW4n1hfX7+r+S1jeBe8WzkQidBjpL3zNOuKmDgrWv7979xu1a5wCnouwmPSl2kxWf4
 51DFG6F43aH/252rgNAL+lD67uVZsyA/B+YRcy8q7rvIzW9zu3+/eCKSzy7bEAyoJ5Vq2DsUTN2
 Ljg==
X-Received: by 2002:a05:690e:b45:b0:654:c28:598 with SMTP id
 956f58d0204a3-65c18aec741mr1748735d50.9.1777547401885; Thu, 30 Apr 2026
 04:10:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260409035015.132370-1-richard.henderson@linaro.org>
 <CAFEAcA-mEC7feX5r=W_bvawe-sFdO=8neP8V4-hvYHFYkugeZg@mail.gmail.com>
In-Reply-To: <CAFEAcA-mEC7feX5r=W_bvawe-sFdO=8neP8V4-hvYHFYkugeZg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 Apr 2026 12:09:49 +0100
X-Gm-Features: AVHnY4LKwsPdXgUmz_WXlFwOzC0pGFxmLJX8iv9KEVmGRnL7tUhlqZ63dX5BI9s
Message-ID: <CAFEAcA9aDCCWzQ_zKnwPa7kwOMXramGT+SSeDv4YCECKfCWG9g@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] target/arm: Remove bswap_code
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, pierrick.bouvier@linaro.org, 
 philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12d.google.com
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

On Thu, 30 Apr 2026 at 11:45, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Thu, 9 Apr 2026 at 04:50, Richard Henderson
> <richard.henderson@linaro.org> wrote:
> >
> > Based-on: 20260407222208.271838-1-pierrick.bouvier@linaro.org
> > ("[PATCH v11 00/21] target/arm: single-binary")
> >
> > Version 2 here should probably be RFC.  This time around, all
> > instruction loading, and more decode, is done by translate.
> > A new CPUARMState field is added for passing data to EXCP_SWI
> > and EXCP_NWFPE.
> >
> >
> > r~
> >
> >
> > Richard Henderson (7):
> >   linux-user/arm: Restrict regpairs_aligned
> >   target/arm: Only define aarch64_untagged_addr for aarch64
> >   target/arm: Segregate target-specific user-only fields
>
> I've applied these first 3 patches to target-arm.next, as
> they're good cleanups independent of the bswap_code parts.

...the target/arm patches don't build; I guess they clash with
some of the single-binary work that's landed since:

../../target/arm/cpu.c:2422:15: error: attempt to use a poisoned identifier
 2422 | #elif defined(TARGET_AARCH64)

../../target/arm/cpu.h:815:15: error: attempt to use a poisoned identifier
  815 | #elif defined(TARGET_AARCH64)
      |               ^

So I've dropped those, and just kept the regpairs_aligned one.

thanks
-- PMM

