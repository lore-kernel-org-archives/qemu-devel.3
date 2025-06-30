Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6156C83029
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 15:23:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWGLw-00071z-5A; Mon, 30 Jun 2025 11:23:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uWGLo-00070t-Mq
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 11:23:21 -0400
Received: from mail-yb1-xb32.google.com ([2607:f8b0:4864:20::b32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uWGLi-0007f6-I0
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 11:23:20 -0400
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-e81cf6103a6so2127529276.3
 for <qemu-devel@nongnu.org>; Mon, 30 Jun 2025 08:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751296992; x=1751901792; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=m40CaCvXv6dQ/Kik62QOQVVIz2NlJXmaGa9e5MrI4kA=;
 b=sTICE9mMHwNdoqy7bYN2FxwyD10W2RJk6cm+/iBUdl+wfvjR1QMtwuF3RaZfp1O3Km
 RrVBj12FCQrgj+WhyknA1duJ55Q8rHn6KypOOgs8z47baEXAWuEM2C2veDFw20YQ/9gL
 T30bOCqDkwbZo4UFUurTNWqUVI0E9Zca4GmZnsBC4Vv7SHHyax/pZ+Ep26b/MxLWY+M5
 LIr9yAC7C7LvgShUMBACJT2LR7dl4NjvdJEPbc2nKE4YNd1nhJ8gIk3F9FYbqcK9xPXQ
 q14lex7lYC8zREQw7pRg31svwwY+TSZ3aSO9yhTf6YLmXRI5dgL17REFO5TpuwPHogJK
 To6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751296992; x=1751901792;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=m40CaCvXv6dQ/Kik62QOQVVIz2NlJXmaGa9e5MrI4kA=;
 b=wIKcFknI4QOL+VhsUd3xOiHDJHA4ub7YcGg+e78xc5Y0RPSv4OCHH/ynKS2EJRwOKZ
 OsEI0gCsnnsE5vIKjv2slnv9slUD7DVTmREkf8EjceEPoB+aU8U+A0sDQxWrKfkKRqWQ
 S9sPX7BrvUTsfn5tVi1PFuoIEyJFY8DmjefmKEWEYkMsFFtJ+gc4TGDbd3TfV7odC9/C
 WTZIJ6suOzic3jWuynQd0fJaQM2plmDCeFh/5tu8DnRNa3tCqvKUjrwQqR17hYCNKe2Y
 axCLAiIu56DCzMPSfzEQSfBJ1twcRQuZhX+i/NkxGmp2sqrk0bpr3OPseeYup4dwq2zf
 fW5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBLKddwboUcZSKPrOEZHcieQX+APdIT2Dd2kFHFXf8drHUk+05DezxE41PIncjGrIHcQBYqeSy3Qcl@nongnu.org
X-Gm-Message-State: AOJu0YymJbohgwgS21cqZmmeZM0q1SYv6wzDrL/RX2hzBm13fcAi88sO
 5vlO7sVas6tsQwVgpzxRXuljTt13NiLickU9P+H8qXUVI20XT/MCw7zmlxxm0nxsO2HFzwMJdM3
 eGF9afb+iIXTEs1rOhyHdGQ6Rc5wlwFsTh8bHR4ILwQ==
X-Gm-Gg: ASbGncurqtu0Dsezh5Ci8okMj3jMM+tj+2xp2B1Ql+zp6S26fkRbfWTtbbd5GyJtOkn
 TaLhBtbt+Gb78zHGdDU9HYcRUtwejIa04vOznryB892tPu8i1Qlo0csA/Gu4CvOPioaUklCUC+c
 9VwScy53KvFIqoNEtXHq5oq9O7RlQdSQgI4lQvVNGcbSYv
X-Google-Smtp-Source: AGHT+IFLey3gbDO7x3IaACwxZKzj8qTloEuvMAvkPa8CTVEMIeapmV9N19RDAtE8dOmUNYaIULXNoTjX4myy8R9g/Lc=
X-Received: by 2002:a05:690c:d85:b0:702:52af:7168 with SMTP id
 00721157ae682-7151713694bmr204905857b3.2.1751296991584; Mon, 30 Jun 2025
 08:23:11 -0700 (PDT)
MIME-Version: 1.0
References: <20250617153931.1330449-1-cohuck@redhat.com>
 <20250617153931.1330449-14-cohuck@redhat.com>
In-Reply-To: <20250617153931.1330449-14-cohuck@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Jun 2025 16:23:00 +0100
X-Gm-Features: Ac12FXx_QA1CfRyIPMvH1-pew-Ema3cEXUdffZUdmGWz7Wrn2y7JuUohVq0azp4
Message-ID: <CAFEAcA9OXi4v+hdBMamQv85HYp2EqxOA5=nfsdZ5E3nf8RP_pw@mail.gmail.com>
Subject: Re: [PATCH v8 13/14] arm/cpu: switch to a generated cpu-sysregs.h.inc
To: Cornelia Huck <cohuck@redhat.com>
Cc: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev, richard.henderson@linaro.org, 
 alex.bennee@linaro.org, maz@kernel.org, oliver.upton@linux.dev, 
 sebott@redhat.com, shameerali.kolothum.thodi@huawei.com, armbru@redhat.com, 
 berrange@redhat.com, abologna@redhat.com, jdenemar@redhat.com, 
 agraf@csgraf.de, shahuang@redhat.com, mark.rutland@arm.com, philmd@linaro.org, 
 pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b32;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb32.google.com
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

On Tue, 17 Jun 2025 at 16:41, Cornelia Huck <cohuck@redhat.com> wrote:
>
> Generated against Linux 6.15.
>
> Reviewed-by: Sebastian Ott <sebott@redhat.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>

Stripping out all the lines that just moved around,
here are the additions:

> +DEF(ID_AFR0_EL1, 3, 0, 0, 1, 3)

This is ARMCPU::id_afr0. If we want to store this in
the idregs[] array that's fine but we ought to move it.

> +DEF(ID_AA64PFR2_EL1, 3, 0, 0, 4, 2)

> +DEF(ID_AA64FPFR0_EL1, 3, 0, 0, 4, 7)

> +DEF(ID_AA64DFR2_EL1, 3, 0, 0, 5, 2)

These are all ID registers we don't implement yet
because we don't implement any features that are
described in them (i.e. our implementation is RAZ/WI).
I guess it's OK to list them here, though we won't
do anything with the array entry.

> +DEF(ID_AA64AFR0_EL1, 3, 0, 0, 5, 4)

ARMCPU::id_aa64afr0

> +DEF(ID_AA64AFR1_EL1, 3, 0, 0, 5, 5)

ARMCPU::id_aa64afr1

> +DEF(ID_AA64ISAR3_EL1, 3, 0, 0, 6, 3)

> +DEF(ID_AA64MMFR4_EL1, 3, 0, 0, 7, 4)

More ID regs for features we don't implement yet.

> +DEF(CCSIDR_EL1, 3, 1, 0, 0, 0)

CCSIDR_EL1 isn't a single ID register, it's an array
of them (indexed by CCSELR_EL1). We keep them in
ARMCPU::ccsidr[]. I don't think it makes sense to
have an entry in isar.idregs[] for this.

> +DEF(CLIDR_EL1, 3, 1, 0, 0, 1)

ARMCPU::clidr

> +DEF(CCSIDR2_EL1, 3, 1, 0, 0, 2)

This is an array too.

> +DEF(GMID_EL1, 3, 1, 0, 0, 4)

Another ID register for a feature we don't yet implement
(and a slightly oddball one in that it should UNDEF
until we do implement FEAT_MTE2).

> +DEF(SMIDR_EL1, 3, 1, 0, 0, 6)

We implement this as a fixed zero in helper.c.

> +DEF(DCZID_EL0, 3, 3, 0, 0, 7)

We construct the value of this one in aa64_dczid_read()
based on ARMCPU::dcz_blocksize plus some runtime info.

-- PMM

