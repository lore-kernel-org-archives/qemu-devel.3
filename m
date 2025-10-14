Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B41E5CCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 15:24:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8gsZ-00055v-WE; Tue, 14 Oct 2025 11:24:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v8gsY-00055T-7t
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 11:23:58 -0400
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v8gsV-0007Dl-Dq
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 11:23:57 -0400
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-633b87e7b9fso5095437d50.1
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 08:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760455431; x=1761060231; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=diQY18DOnazfPDHWolIcIHXy+xgSQZWE0WX3F6TuikY=;
 b=bZIu+iaqKtDHFPwxwVsHM+jX5UtIYZmBRcK45vOIQoxFgGd6t0h1Q+TXUXj+kGwFZD
 r75hMqjxXw5+ePCzx0FoUuTbhk9cE4j9Ek2cf1Sy4McuSeYvjQQKme/6mNCDIBzR+TyK
 Mh5SB737A7B+5pDbFORIi3KZVIt6Z5tJksExjmJM7C7KGv4jnvZTRIdH+yqv4hPA/ad/
 mV38Sr2qHny0VT2H4bswRSZS2+mt5LSuDm/cwM/L++b+Vp1TzxJFCGXngb22c13Hioss
 CuW2Z6iZ9KaWbi4ETqYdP/1BAR8MJ2vzbwnHfJA7IswNk9jLcbdEHO1L0ayMuFfL5hwo
 htAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760455431; x=1761060231;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=diQY18DOnazfPDHWolIcIHXy+xgSQZWE0WX3F6TuikY=;
 b=dKsMjbhn4jYCE4zwhe1tij3lpyA4GJOBBJAMz/hYAakIMW5Dvlp18swHlyQwmxRrUO
 Mgpwlu7ozzYngUrnMlMjROCLJVCNR9N8moA49ZC3WCdp5WaQGTURSRxTI+PpYoiSKveT
 5sJ8QqTKCHsR4rgnimHemJDj+r2dmkpL30lqpTC2HktjKmFUziBDYcfelEpv1XTY/yPQ
 9uUs8WGSGTYQ1Gi86z8K9tV1KE+XU5yTYh2Mv3knbu4mFL4xyHFnYiGuR+ooVCeOC/1E
 mEUMNf85CwPZ7CvFF2lNzB/kImLxl9XN090gqFLqaHHkfCgafKAVeTKQwAP3lElnymnC
 Crrw==
X-Gm-Message-State: AOJu0YxIQv5GHUd94m2QN4qKAfLbSV1DOnRShFZjtnsDaQT+x141InHT
 8Oc82NLuQjg+zMuHqtAVBjvtBVXJ3WW5tVYuqToCaThX4jqjeypu/hMMtC01L0LIY2E6GDoO+GA
 d0g16K2oRGbexhwr/vDWkgBJhjEdpx9vIyUeyHiGDyA==
X-Gm-Gg: ASbGnctzXKPbLp0TJs8PWHDrNvkvrkycmzzu13usyTS/GhImfcFQyTG39QSF9g29Yuc
 F31weNOy/yVMsVWik/qWJtRANeq75YyN2zCW+mNw2Z2H8duNgLIQpkgQ6eivBIIhB6utst2Qy/A
 kbfSSJE8LfOqmBJA5gXEsQHINo1k4slrtXK/48DDykZukosjvIP7Z3i8FT8937P8Qn7ogctT5r5
 +rQgKM7f2+1mEb1nQYW5VZ/wQR9vDX2yrcT3NzMIQ==
X-Google-Smtp-Source: AGHT+IHPm4M9WmBSszDmg5m1FNuhOAvixuLLFpFIiS8jK4kpjMWqFVUdRQykZ8ICjVDhjJCYhUdB0PkF2r+TBTpXQpM=
X-Received: by 2002:a53:df0d:0:b0:63d:21ec:cd28 with SMTP id
 956f58d0204a3-63d21ecd1fbmr1438247d50.65.1760455431380; Tue, 14 Oct 2025
 08:23:51 -0700 (PDT)
MIME-Version: 1.0
References: <20251014102439.319915-1-peter.maydell@linaro.org>
 <261d6938fc894b1ca0979aef30fb9e1c@huawei.com>
 <eebfcb04afc2498d8969d96fcbcf0926@huawei.com>
 <CAFEAcA_MZu4stZ4MY4zdpM0zy-gNBA3yj4dkuWL3d-FLFZC6rg@mail.gmail.com>
 <b3f9f1d44d8d4a779dcaae2497b8b71b@huawei.com>
 <CAFEAcA804drHGyTG73bXkqSMgXvKGGaLWvm6QS85FhD+dXDqjw@mail.gmail.com>
 <cb5c762bd24d4cd69aea415d4bc10051@huawei.com>
 <CAFEAcA-g18R03vqpqXr0boOccDqhNP0J7Gx8nZOxUrbQh13pog@mail.gmail.com>
 <599ea0ba89314d28af8b3ae7b590d1a9@huawei.com>
 <CAFEAcA8-QGBGqjw3Eefx_yyz_30azn9Trz-OGSxq7v4N=X+26Q@mail.gmail.com>
 <a630fc58d9f946988bd6c27479543dd1@huawei.com>
In-Reply-To: <a630fc58d9f946988bd6c27479543dd1@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Oct 2025 16:23:40 +0100
X-Gm-Features: AS18NWBgNpqVqgTGQHuSfXoz9C5kHqv4h1cchbf1DnaOpmaXKy2na5k-ghepIZE
Message-ID: <CAFEAcA8GsSDnY8GEJZYNbJ3KZAp9tJ=s_vUBB_XwwGaEwozxzQ@mail.gmail.com>
Subject: Re: [PATCH] hw/intc/arm_gicv3_kvm: Avoid reading ICC_CTLR_EL1 from
 kernel in cpuif reset
To: Salil Mehta <salil.mehta@huawei.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Salil Mehta <salil.mehta@opnsrc.net>, Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12f.google.com
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

On Tue, 14 Oct 2025 at 16:13, Salil Mehta <salil.mehta@huawei.com> wrote:
>
> > From: Peter Maydell <peter.maydell@linaro.org>
> > In what situation do we ever start running a VCPU before the *GIC* has
> > been realized? The GIC should get realized as part of creating the virt board,
> > which must complete before we do anything like running a vcpu.
>
>
> Just after realization of vCPU in the machvirt_init() you can see the default
> power_state is PSCI CPU_ON, which means KVM_MP_STATE_RUNNABLE.
> Since, the thread is up and not doing IO wait in userspace it gets into
> cpu_exec() loop and actually run KVM_RUN IOCTL. Inside the KVM it
> momentarily takes the vCPU mutex but later exit and releases. This keeps
> going on for all of the vCPU threads realized early.

Yikes. We definitely should fix that : letting the vcpu run
before we get to qemu_machine_creation_done() seems like it
would be a massive source of race conditions.

-- PMM

