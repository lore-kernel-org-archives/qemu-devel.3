Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 554D9C71136
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Jun 2025 15:40:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPk2F-0007aB-JY; Thu, 12 Jun 2025 11:40:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uPk2B-0007Uy-Q9
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 11:40:07 -0400
Received: from mail-yb1-xb2b.google.com ([2607:f8b0:4864:20::b2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uPk28-0001O4-H7
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 11:40:05 -0400
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-e81f311a86fso1047882276.3
 for <qemu-devel@nongnu.org>; Thu, 12 Jun 2025 08:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749742803; x=1750347603; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0GCneGgfExrxwfR8Ui0kwChdEvpsbQ0IMrzfOgR23iA=;
 b=cUCEY637f2ckAKFWQ1eRXC5MjDAtjd1i0FP32FGi9H0ciQQNVDmBLMMfyIsmRgHou6
 A8EjzZFChIkv9Otk4v8BVC2XbMZOO6dJSFxVcZnEJ80TQpzatAWc6YpTc0RJY5lqZwQ8
 Esh4Jbv88IUvZuONMikuQGBz/L8f+Sl/fIBhpmYaxXCdbFV31U5vibHPfPME67ZRlayf
 /MU55uPulGs2X8hOmJwDX0vwnYTSUipY3hS1bkPIqSTCBcoB294G0s+Y/pom+g5/BPXS
 0m0yk6QoEGlavDxxJ3iAl6MerrSbI4d5iILvejD6vG5x9lbu7zoZZ0/G8BbH5s+3GMd7
 pthw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749742803; x=1750347603;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0GCneGgfExrxwfR8Ui0kwChdEvpsbQ0IMrzfOgR23iA=;
 b=oL1vCr17HaJYjrXPIBTHZB8hW1qF/C7BKpfGp6XorrwkMaU58GjCsi0o3QCA7iLpQu
 /31vn3XcsdhcBnBi2T2LEtOPdY0UH439076wfGpTag1cnfreCYM0Oj2XRgg+WlScfMOV
 JTt+CV3xfofXsCEPJGljdawc57QD3HZ1pdTJkf5tDERvROhguUz2iRFDnOZNYolptqcA
 b7U0LdbrYDl3F1PFyuk4qr2lSgd86Ke9h8syDiaormnuZyBcgfO/QpJ83OjUstk3OVls
 43PGb9EmLLSKSAP2lNk/0j7Y2nL9mTPWuAPjML+NMCxmWMiSXYaIrh75p3xun8/E0omp
 xaSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVSr6WcQOH0heGfT7WUIxOKvZlmsF3knvaRUOM5ebLQEgb/I7uMGjFau1Spf6y9XxVXxI1Y6WhBqfG@nongnu.org
X-Gm-Message-State: AOJu0YxtJtW8/QsA/tIOkSU4tPdEuWyGkn2xH1rOaPfRrI6+pkFUt32k
 znozd8h7qsouwDm5DDkV1JdRngMjEYYT20m0KprhjE7EdSJlC36zoGrh1BXrDESBaA3C8zo+4tj
 eRLXXkmfCOpQELuDE/iP0bVoTszprT1gtHDto61mBOg==
X-Gm-Gg: ASbGncvgDhG05avZHGuX09gpoqOMVc468yyPgAUsNbaMna2HMHgyWG4EVgnSc5Ecww9
 o/f/k/OR9rLKG93AN2HvQUOHMVxV18qY+7AqoCbyHeBH3N9H/jwYzHBtglLvrTYS2bZFw5JnetY
 VLI8UbdpEPFqRw18x2ti8c0haCSrJx227nYYkmD81ZGbtT8W/PDNGONt0=
X-Google-Smtp-Source: AGHT+IHBHeJeONG3H7FZDZ2gzpluKSyc9U5d3tSDDj9TAvFgb1FASvHR12UGnIXjylLAo97HcqblKFJamwURpnJdu+I=
X-Received: by 2002:a05:690c:3584:b0:70c:a57c:94ba with SMTP id
 00721157ae682-71140ab7fe8mr120867917b3.17.1749742803370; Thu, 12 Jun 2025
 08:40:03 -0700 (PDT)
MIME-Version: 1.0
References: <20250515153907.151174-1-cohuck@redhat.com>
 <20250515153907.151174-3-cohuck@redhat.com>
 <CAFEAcA8y_wwZPoqkyPrNscRNTEwiOQm5Or9C=aiSNMGcZmq8CQ@mail.gmail.com>
 <87cyb99doe.fsf@redhat.com>
In-Reply-To: <87cyb99doe.fsf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Jun 2025 16:39:51 +0100
X-Gm-Features: AX0GCFsSzIs_NzMxA8HzPGOMVkRaS0W_5TAvxGj8ZsUFrqoq2Opm_C-WeWiw9RI
Message-ID: <CAFEAcA9P9W3jVzX6T6X3CW0zVwDbxdo1aeiG4ogGzpnHmQ8xgQ@mail.gmail.com>
Subject: Re: [PATCH v7 02/14] arm/cpu: Store aa64isar0/aa64zfr0 into the
 idregs arrays
To: Cornelia Huck <cohuck@redhat.com>
Cc: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev, richard.henderson@linaro.org, 
 alex.bennee@linaro.org, maz@kernel.org, oliver.upton@linux.dev, 
 sebott@redhat.com, shameerali.kolothum.thodi@huawei.com, armbru@redhat.com, 
 berrange@redhat.com, abologna@redhat.com, jdenemar@redhat.com, 
 agraf@csgraf.de, shahuang@redhat.com, mark.rutland@arm.com, philmd@linaro.org, 
 pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2b.google.com
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

On Thu, 12 Jun 2025 at 16:34, Cornelia Huck <cohuck@redhat.com> wrote:
>
> On Thu, Jun 12 2025, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> > On Thu, 15 May 2025 at 16:39, Cornelia Huck <cohuck@redhat.com> wrote:
> >>
> >> From: Eric Auger <eric.auger@redhat.com>
> >>
> >> Also add kvm accessors for storing host features into idregs.
> >>
> >> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> >> Reviewed-by: Sebastian Ott <sebott@redhat.com>
> >> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> >> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> >
> >
> >>      if (!cpu->has_neon && !cpu->has_vfp) {
> >> -        uint64_t t;
> >> +        unit64_t t;
> >
> > This doesn't compile :-)

> Hum... weird that my compile didn't hit it.

Patch 3 changes it back to uint64_t, so unless you do a
test build after each patch you won't see it.

-- PMM

