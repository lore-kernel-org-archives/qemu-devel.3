Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3039DC87FCE
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 17:42:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufMPv-0000RJ-9C; Fri, 25 Jul 2025 13:41:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ufMPp-0000Nt-Tq
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 13:41:06 -0400
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ufMPm-0005cK-JM
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 13:41:05 -0400
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-70e75f30452so17088437b3.2
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 10:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753465260; x=1754070060; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6ptGeKefNfVsGvOWbsC6afkNZAVEXj4XDKjGFCrdbOI=;
 b=mXdeAOt68U4lrpbqzEHWDel/YQ/Oudud9FN87XVngWDuVIk41sRs44SdnqbJ+mgBYi
 9KHFVYFNUb4Pq/5uGsIJKN9usxJFxs/dbJ3Z+tOv5pb+VWtvQSII0aTyfIHkx9bkF82n
 Am0itTrTizDDFlvdmx9bTq4fmjQaNDfQRXPKwax6cLQ/iLKSvAwEHh86cjNXbbU0rg8d
 VX2ME4xrmgV8ROmRBZZVrFfuUTXZc9l0ksvAQFTLXJgq6Ymx6jeHxoO0CEtwc4wIUN32
 jGARXzGi/vTtEjGllfApUkob0SoVEKLMwMnfXEv9h4AQZGqGFwhBjmr3nbUZyi9HFwtX
 hOeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753465260; x=1754070060;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6ptGeKefNfVsGvOWbsC6afkNZAVEXj4XDKjGFCrdbOI=;
 b=PLPS0Pap1NEQK3TRsMwifRSeZrQBjjy5K+uy4ZMPmUrN3dM7TLvRaz6w/agTYvyJ6C
 6AN5FkpXccaubKb4RSCGOYbCR50E5EVLXsS+uuPRSx6EoFM2IrQIAD3e3ORglOWBZiCQ
 /kgkSKUjXSIolBwwzEkdhk4+BneXfvqyg+XJzq3lOdifahWwuVe59IAqOsu3p41nIYv7
 vZJDb9I2R0tTuxZql0rVou+mflo4GdApZn1LO4cLYb2pgY4PGAOFr9bEjLy+3jIt5U4q
 F+1pdaWjSVSLbJWVBX+AoXHZbdr74r2QAzZSf/MUAer6FRgIVRSqqK+yX7MV+fGH8Gv2
 sfwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYHdt/XviBVg/xWoFgxOQBoGdmI6dxJ573HJ0qCVqHtbQhUi28a1beX/nUl2iiYxuoRjVfbqmkXLt2@nongnu.org
X-Gm-Message-State: AOJu0YwBOr2ijFyZQs6lAtM9W4uPWYexUu2S8neq542yEAvaOgPfX6si
 oZbbGeEMboLQaP+sUkqXrmcevfyvPwxfslcJxgsrqsWFMM8Hm6OqLrzB4u2NOFWtJO/JWuQRXYV
 pv4tUG3aXbBO9t+QZOA8tPJ9ov70IaG7cY13+J+0TGg==
X-Gm-Gg: ASbGncvtteij7GxytCp06fybrOXYWDIpm/5PTTdf7fMPs3R16jzni6ArDI7gm/fMX0i
 2LasvsX5nVl2YxRjpJcerHMaZBFRuIw9oU+LGkrEA1bnHp2OyT7lzhQXEPD2o1eHrbGqLf4sXWs
 E21Ky0HEkOYDur8M5IPW/nzZu2qnyEvh1ZJwmxQaq48j9RiVN5Amf7ybi5xtTtwhcmLNhVXCI7x
 zasRJSx
X-Google-Smtp-Source: AGHT+IHESCqJn1NoZf6mIydjYRdyvvCbq6mHxkbsJ6RuQt3AbFAtMuX3hjsjmeHAYS8azB/BqiJ0uPalEl3lwwndAls=
X-Received: by 2002:a05:690c:688e:b0:70e:7503:1180 with SMTP id
 00721157ae682-719e329b188mr34111057b3.1.1753465260377; Fri, 25 Jul 2025
 10:41:00 -0700 (PDT)
MIME-Version: 1.0
References: <20250725142240.3760452-1-peter.maydell@linaro.org>
 <20250725142240.3760452-2-peter.maydell@linaro.org>
 <0b0882e6-906e-4a76-98cf-91c9284c4a52@linaro.org>
In-Reply-To: <0b0882e6-906e-4a76-98cf-91c9284c4a52@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 25 Jul 2025 18:40:48 +0100
X-Gm-Features: Ac12FXyVw8GKj3FuuJbg2CNAIghMs0ewFNXOhAsFMRQ9FjKUq8LonAj-_NUMKzM
Message-ID: <CAFEAcA9eH=n+uR2EupfUFNa5TacMHL=8XdSPdQ1nGw5ctuFaQA@mail.gmail.com>
Subject: Re: [PATCH for-10.1 1/3] linux-user/aarch64: Clear TPIDR2_EL0 when
 delivering signals
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1131.google.com
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

On Fri, 25 Jul 2025 at 17:46, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 7/25/25 04:22, Peter Maydell wrote:
> > A recent change to the kernel (Linux commit b376108e1f88
> > "arm64/fpsimd: signal: Clear TPIDR2 when delivering signals") updated
> > the signal-handler entry code to always clear TPIDR2_EL0.
>
> Ah, I missed seeing that.
>
> >       /* Invoke the signal handler with both SM and ZA disabled. */
> >       aarch64_set_svcr(env, 0, R_SVCR_SM_MASK | R_SVCR_ZA_MASK);
> > +    if (cpu_isar_feature(aa64_sme, env_archcpu(env))) {
> > +        env->cp15.tpidr2_el0 = 0;
> > +    }
>
> You can omit the IF and unconditionally clear the memory.
>
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Thanks -- just noticed also that it would be reasonable to
update the comment:

+    /*
+     * Invoke the signal handler with a clean SME state: both SM and ZA
+     * disabled and TPIDR2_EL0 cleared.
+     */

since all three things are SME related.

-- PMM

