Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A13E5C54E71
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 10:57:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnca4-00024S-AK; Fri, 22 Mar 2024 06:57:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rnca2-000244-KV
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 06:56:58 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rnca0-0006BX-Ks
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 06:56:58 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-56be4efb63fso504824a12.1
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 03:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711105015; x=1711709815; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=83Wh1TAIllHiFRSTsiBmuzx5iyrrRJxfmDnBiDGpJlU=;
 b=KYOl40JhDdkv4a9FjgZLLu91tPODA1z/ETdWENnUXjOdF6aGpBvH9x85O8LLIxJkIP
 ecjBmvOExJqYnxyDbB6iMKwgMAI4xFe8Eh/RHzbHk9ub0ke1RJUjLNlY3wkXQrF15gYa
 lxs0+HCt+hobrcoLCsmeyJkyvgRFaPDPRpfQgKrN5lOcjiXpgwCKwPmPHG92eOBcgE3l
 WKwMRxOYU9/NYpffZax8OCcpBNdBgoV4ffm+N9xlQquT91N+Pnqb8AvTwvN5jtTzbYJ+
 Nm/Z7JZhplSxb1MuTjLIZmU2HHrLcQLEDwnQI+GqBYwtsJe7FUM8Uob+TXkkYolRa1VT
 TlWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711105015; x=1711709815;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=83Wh1TAIllHiFRSTsiBmuzx5iyrrRJxfmDnBiDGpJlU=;
 b=dm5NdeIJevVsqAsrGkZRFnNf5bDjGP6Ayzmz/12Lf7OzYlJkK4nb10bFpL1toB35Vn
 +AGyH7KOHsut5ynWtWFZn5WcBb2hdGHv4zqYHe9K//oeSLpk2CuDW6Pl2n0EBOMfbqWJ
 sL4ZxsrSQK0tO/PQgeHQZkkSmZLZzWot58zwguAhvVTFxKz0B2Epsg+8TQwTU+plhhel
 86Yh0EM4f+Kro0hAXOp9EHc0q1TWY0xBwbj9K76x1j+CzDOWHR78qBCUwsoeW1oXwBCu
 MVjCJOAkjJeowhQurVR3jIeK4+7+Op9YaIKCWyGyEZCTM8kBHwsgcWBSSwXf6GWgBEcL
 +YCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+7HRJMmQHZ6lt2T1an5jMEsankB8mgg6bKu7O7C7XrKn1ifGc/1Kq4lAU5k/MeZTYIYHeVwP/17mKhfoqkTPK6R7W+LU=
X-Gm-Message-State: AOJu0YyEfDjwqHtOiA/1V46/raRhceTApf0AHDxbEd9jCJ0gbiVXOweP
 cQkDGq2VlV24CS7nPkmPvKKXQKjNMeliSOFLnWnbru7PZCss6VZkBBNSOzl9vmXY5ZyDWJzWMH3
 LJ/MLVG3jHcSoktJDxKkd+2yXUWRPXzhJhv2/Ew==
X-Google-Smtp-Source: AGHT+IFKg5Bkngp5Vtb8nF88xXWSv+6PDrw7vWHtzNsfkdczbMZpV49LJ3dOXbYhZ7hDBlknVxuPejCF87E5YAnUcUc=
X-Received: by 2002:a50:9992:0:b0:568:32f7:6c53 with SMTP id
 m18-20020a509992000000b0056832f76c53mr1243243edb.3.1711105014767; Fri, 22 Mar
 2024 03:56:54 -0700 (PDT)
MIME-Version: 1.0
References: <20240321130812.2983113-1-ruanjinjie@huawei.com>
 <20240321130812.2983113-7-ruanjinjie@huawei.com>
 <CAFEAcA-SO3akirm+jgKGRvKH1bcsf1bLJE2uOCOoXi1h78WwFA@mail.gmail.com>
 <1b4f0b6a-f1b1-8531-e117-fb85aedfa440@huawei.com>
In-Reply-To: <1b4f0b6a-f1b1-8531-e117-fb85aedfa440@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Mar 2024 10:56:43 +0000
Message-ID: <CAFEAcA8qSq0x_tu7zDfpghzZNSJtoHE4fZ7Hhu5nMJbUKviUtA@mail.gmail.com>
Subject: Re: [RFC PATCH v9 06/23] target/arm: Add support for Non-maskable
 Interrupt
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org, 
 wangyanan55@huawei.com, richard.henderson@linaro.org, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
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

On Fri, 22 Mar 2024 at 03:56, Jinjie Ruan <ruanjinjie@huawei.com> wrote:
>
>
>
> On 2024/3/21 23:46, Peter Maydell wrote:
> > Something somewhere needs to implement "if SCTLR_ELx.NMI is 0 then
> > we don't take EXCP_VINMI etc but instead (maybe) EXCP_VIRQ etc".
> > At the moment nothing does that:
> >  * arm_cpu_update_vinmi() doesn't look at the NMI bit before
> >    deciding whether to set CPU_INTERRUPT_VINMI
> >  * in arm_excp_unmasked() if NMI is 0 then allIntMask takes its
> >    default value of false and so arm_excp_unmasked() returns true,
> >    so VINMI is not masked
> >  * arm_cpu_exec_interrupt() doesn't look at the NMI bit before
> >    deciding whether to check the CPU_INTERRUPT_VINMI bit in interrupt_request
> >
> > So even if SCTLR_ELx.NMI is 0 we'll still try to take a VINMI
> > if it's set up in the HCR_EL2 bits.
> >
> > However we do this the required behaviour is that if NMI is 0
> > then it is as if the interrupt doesn't have superpriority and
> > it falls back to being handled as an ordinary IRQ, VIRQ, VFIQ etc.
> > I think the best place to do this is probably here in
> > arm_cpu_exec_interrupt() -- if SCTLR_ELx.NMI isn't set then
> > treat the VFNMI bit like VFIQ, the VINMI bit like VIRQ, and
> > the NMI bit like IRQ.
>
> A PE that implements FEAT_NMI and FEAT_GICv3 also implements
> FEAT_GICv3_NMI. A PE that does not implement FEAT_NMI, does not
> implement FEAT_GICv3_NMI.
>
> As the GIC side has checked the FEAT_GICv3_NMI is implemented or Not. So
> if cpu_isar_feature(aa64_nmi, env_archcpu(env)) is false, the
> FEAT_GICv3_NMI will also not implemented,the CPU_INTERRUPT_NMI/VINMI can
> not come from GIC, so we only need to check cpu_isar_feature(aa64_nmi,
> env_archcpu(env)) and SCTLR_ELx.NMI is set in hcr_write() and
> hcrx_write() for CPU side.

If the CPU implements FEAT_NMI then the guest is allowed to
write to HCRX_EL2.VINMI even if SCTLR_ELx.NMI is 0. (It
might for example choose to set up HCRX_EL2.VINMI first
and then set NMI = 1 afterwards.) So you can't fix this
by checking for NMI in hcr_write/hcrx_write.

If you wanted you could not set the VINMI etc bits in
arm_cpu_update_vinmi() and friends if SCTLR_ELx.NMI is 0,
as long as you ensure that the update functions all get
called again when the NMI bit is written and on exception
handling change.

-- PMM

