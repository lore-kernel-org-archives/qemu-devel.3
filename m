Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5E27C531F9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 08:49:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnBaB-0000zV-V7; Fri, 24 Jul 2026 04:48:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wnBZx-0000ye-6n
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 04:48:30 -0400
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wnBZp-0004af-4k
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 04:48:18 -0400
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-81ef8255cccso1468697b3.0
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 01:48:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784882894; cv=none;
 d=google.com; s=arc-20260327;
 b=JQ2oGiibmH7+K6/zKeDI0J97xZncGhiwXvurv79jU1oEgac5gP44EFVVGi6pjgoacC
 Yu/XtCKL36qdGl/dJjXcz/XJF1GkF6GOylCT22wmgyvWCW+J+NXF5pb4TJWBzisYO/Mu
 BWJ1MX6qPU+d7drjcNzzQJX5YInFmqTh3CaKh4cG+YKDoGogOnqXuBzrpHjNg5MBVh1t
 tWfCL0mdk9mK8KycCUAXFJYGgy/msq+6RL81raFbRnkMBVNvtsCCSTrCBOYgYjbfTUEn
 7N81Ig/dsoJ0bJvc3hjcnsKDxLuozILwN32hpkgwJvpCPRuzZk/ZkD/+K55IB8t7IOOW
 iktw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=f8K+sMuRVXTl+mZDY7inS/u3c9EF/+foVdav142xtAo=;
 fh=hHQwqgTY7ltwat616CldellfBTSzzr31raK2NubcdK0=;
 b=qYwjOOiTJDsAXTLkXmeTj2HPUahA39F9RhhDf5Fq5nubVG4sWMj9vxU8c6/v2dLCDz
 NCR4iCFFLiWuxkbn+doVS8EEeGRap3sQQk8vSim94B//VOiEiFm/mJtA4MqTUZrrMbxT
 QRP1yYxzIEJcWyHIGsQzWmn5X9gwRgOMLPLD+eviyeFDZKUGxPyzxYU9i9mxj3Mq0zRJ
 Cv9b88c3ZzR9sLFqGI6e6HQhF7wMXdxbQTdZiF+yrfeYvjXx4kC0IdMRTvoObG9vKs74
 Y3XsW0Zz2Ukl4Cwm0ln2NjbDTiNbRqb4Kx4lSa5ThdcG165oItswOKYiJt/ZlidzrHeD
 7gEw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784882894; x=1785487694; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=f8K+sMuRVXTl+mZDY7inS/u3c9EF/+foVdav142xtAo=;
 b=A1VDfe9FzMPbFddVbTtKQUpFJTlPb+M85AN3X9eqqmO3XPJjhj/kSiGu4bkTiMDdww
 LaOa9vx3B7MPC+X9oVMMTDbW9BCAKlpqbfYJDH7cKQHLvUgTR1A1OFCk4jml47E2YIgV
 6byraAwYZ9SIEWuc8AN5qOD9CPJMZN20Bkq8DKevoI/XPWvYSgecBwGdIWeXfhJcDyGH
 S3CCdCy4Sy43Dlb7juvR+QLLkfKCJ+kFZ42IQuPMUhptCuvDhBWmGzwdKSYMMcUywzBT
 3WCCaIg7wCandd9waowiTOS3okjIvhOngQRzgqZCkiMEDg/+F7Qk6hya5GaLcflmfKoh
 gYfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784882894; x=1785487694;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=f8K+sMuRVXTl+mZDY7inS/u3c9EF/+foVdav142xtAo=;
 b=QJVx3yyqQNSm/+bK/UK8UM4VACoXpEGL0A2+Lo6XJ71bhyoyCqySwRCVNa9UUoN+S2
 aVxIZamBrHsxZNvlcknTjJ97L8Qaa4A837qtkmdYqyOypNoejglbACsKPcicu8DQcEKc
 S85FrpsIZ1AeZU+YpEonmWVs6OG0DqkByZ/DAWKNmxLgwUAlqNu/Mts6eblFoeoJHMkJ
 bhrwjyns/diOEk4xzC+Tj33cahv4pgYmQUOd++l+ky3P/xJL4WmOuOTnJ32j4COSsYRP
 DeQGglr/B0o4bmYFM32qt2FdJk4g4Y09uML7DGxkJ34t/w+S+Vyx4HPzDf1qPGcONQ76
 Yr/A==
X-Gm-Message-State: AOJu0YyPgSx0sCOp68fQEjq9zPuIE1UQg2buMdVEfEFQPR5bYrnrMQgE
 rT4r8QWIhkDH47e07yp3ZAgLH/gSUfmkjU0B67tqT/9vjGr5T2Ux8TZr+RrCqnYvb5qobnPdjg7
 BTBZyrUDT3mXomlDKKI9fGcqBTnKv3DNgPL0U0Gc8qA==
X-Gm-Gg: AR+sD127XgwwaXFZoIUpdSNoCHkNEVV6x0Ecyx00nZzKYG3rLdAiCqHtbrP3u7n3VrO
 gJ9Mn0x34Xc+9CvPlpiO7VEDJLBLTd0N1nqnscISZOjC1Xx6rb06+nrnH3YwvxiR30O0t8X/f2z
 czGAuNwfstDVMzuqIwfGdFAInm8oy8N7xriiRrh/oNEK1THgHotKD6BF6Zxi0jmui910f3sX2es
 zAOMdjCQDq5SWqi+maAcxwepSlSA1Kn1MaQRDsaQcd86wQfGCG17V0pcD+lqxfQ1Ayp1GHLMCtW
 n2gpUNjlquuYIpsX7c5cSH2lmvmu8ZclrPt4NUh2GAaziw==
X-Received: by 2002:a05:690e:b47:b0:668:ae76:b4c1 with SMTP id
 956f58d0204a3-668ae76b9c6mr1174268d50.12.1784882894373; Fri, 24 Jul 2026
 01:48:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260313170938.449538-1-peter.maydell@linaro.org>
 <48fdece2-5b98-4785-9b47-9eb2528803e2@ilande.co.uk>
 <CAFEAcA_zf5joZKeiU=c5qP+PzbkrPEVOBZ0nMrOhidiywi_s8w@mail.gmail.com>
 <CAFEAcA-MQ8tObH=9j-O-bqfGMLc2oTwaM1xEzv__GU2qrncmgw@mail.gmail.com>
 <CAFEAcA_boBOkNAaUgX=QEQvm3Mgy2ewkSNtx8zR9e=P58aWmmQ@mail.gmail.com>
 <CAFEAcA-VF47TGkRQBh_phZVvZ36tN5OJepbb1z=t=O=R3CwZDg@mail.gmail.com>
 <db7478f3-3cfa-43bc-901c-01842f180a92@ilande.co.uk>
In-Reply-To: <db7478f3-3cfa-43bc-901c-01842f180a92@ilande.co.uk>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Jul 2026 09:48:00 +0100
X-Gm-Features: AUfX_mzBwqWpAew9oMFRFUSZXVNJBirotjR2Vbo8CClY_bwZxiWAc-CrFFOECbs
Message-ID: <CAFEAcA8j+W7eqJqBj-3Rq5ZBkOTapOKHSZFf+7ds4==5kKk-Tg@mail.gmail.com>
Subject: Re: [PATCH] target/sparc: Set reg window data structures currently
 after vmstate load
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, Artyom Tarasenko <atar4qemu@gmail.com>,
 qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1134.google.com
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

On Tue, 21 Jul 2026 at 22:01, Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
>
> On 18/07/2026 09:46, Peter Maydell wrote:
> >>>> Are you OK with this patch as it stands, or would you like me to
> >>>> change it?
>
> Sorry about the long delay getting to this one. Looking through the migration code,
> the current approach uses get/put handlers for registers that need to do more than
> just update value in the state. Longer term that code could do with an update to use
> .post_load, but for now I think it makes sense to use the existing pattern,
> particularly as it keeps the separation between 32-bit and 64-bit.
>
> The following diff gives the same output in analyze-migration.py and I think should
> solve the issue based upon your analysis:

Yes, that should also work. There's a minor bug in it, though:

> +static int put_cwp(QEMUFile *f, void *opaque, size_t size,
> +                   const VMStateField *field, JSONWriter *vmdesc)
> +{
> +    SPARCCPU *cpu = opaque;
> +    CPUSPARCState *env = &cpu->env;
> +    uint32_t val = cpu_get_cwp64(env);

This should be "val = env->cwp;" (cpu_get_cwp64() returns
"env->nwindows - 1 - env->cwp", but we just want the plain env->cwp
value because that's what we used to migrate and what the get_cwp()
function wants to see.)

With that change, the sanitizer is happy with the migration-test.

Do you plan to send your version as a proper patch?

thanks
-- PMM

