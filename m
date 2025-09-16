Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49D27CAC598
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 08:02:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyQcZ-0003CO-4t; Tue, 16 Sep 2025 04:01:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkrcmar@ventanamicro.com>)
 id 1uyQcU-0003At-7e
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 04:01:01 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rkrcmar@ventanamicro.com>)
 id 1uyQcQ-0001zJ-FB
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 04:00:57 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-45e05ff0c86so5181045e9.2
 for <qemu-devel@nongnu.org>; Tue, 16 Sep 2025 01:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1758009650; x=1758614450; darn=nongnu.org;
 h=in-reply-to:references:from:to:cc:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AE/MAE2+U2XckKQNt6+5UA9qxiPOCtpECODvz6ek0iQ=;
 b=QG93A5O4mzp0thh++O90T5+zXCaurysEjNAOykIE8mEVEv91VTDrKVLAOAFFLOoIjy
 2AGuUTzkbe9N5UDEdte3PDP1PQGBIkai4lu9IN0cKdrR6diio/Zoe9rD39VJYMlK190w
 b2sL0W1wGlddqt/ynz0nUefZuoLcw/dmK8aS17AtrOd4l079ZT8mt5UJlGcDZr4uW+jX
 ztUw670TVIDSS9/ye6hTAtMtI2Rnq5UCK48jfy/x8tghI/BXe1jJt/hYB2LwZu7qO7Ln
 vx0rZfVWi2O9XBR4rC/riXoy811UnHJNcd+ga+WRrTkc7lSK9HSXa7TXXYcVIbGO7YN7
 vtWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758009650; x=1758614450;
 h=in-reply-to:references:from:to:cc:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=AE/MAE2+U2XckKQNt6+5UA9qxiPOCtpECODvz6ek0iQ=;
 b=jjxYY8eM0uEv7WrUBCKfsg1xzcZLH3YTk/N6fitssRqoTLVVYoVaegQH5M80qBYzsN
 2nRMLVoXaEI9NF8ZBXvSHLuhjLp0OYpXvu94Bd3ixvNa8A56cjC1uuHUDqyqR6s/B/DN
 qbHp6wLbqcRAndmPAPksKnWt9d/cv/eQPV2oNf01fSL+nEnFsnBgKXy0v3yB1jaAUJfA
 iY7A0/MWm9Jb5vV/OAn0uQ5XF+DyrwMQAjOshwkW/vQY8yNEXpZLODNXyFIOgUqKiJN9
 2gtUFRcDEwhTVDBIKm3wXnjYJukM2W10CBeSCSVV01fV4mpXg6UR+W9nQtSDnuH+4mzY
 gyIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQZUW7t6NIWYeXvPuAiWJB/NT52ZxSvs/tawJkYcaIZr9EV5PxAx489o1DiuzryEbAIcNDx54mbt0L@nongnu.org
X-Gm-Message-State: AOJu0YyFmwyxGCP9sVhKZczYIHo79e+FaxF8ZKekNlxMUPJNgkugTAt1
 TojoXxSR1wKuNXYa+iPIyPv/3i258B74bROW6Nj0HeTwGtGwmhqhc0TlBSugewpTxEs=
X-Gm-Gg: ASbGnctvKAkX9gQIokGDSzYiUmTxXav7T3fpmNAbwb90nsanr9JXsZITDkgHogqfMFs
 YE5g7Yo6k2sLXQfx4N5C9pxx/ujTFVzNLvj2FvZ1ROnEk7UkDm+8cZwkZLO0HiGLxnlfGnWhTz4
 UkWOzOHiTd1943bCi5J6qgGIHQ9HuD5NiYydKflBUW32Z0oBOAMbFn+5ojUmNcUF7IdbXYNJu4q
 rJV8Cwinf4C/5c37jVQvqAUKtYM6tTwE+1brjtOGEAvyUMH0lThA86vJ00f3V7GSBrslqgvxKHd
 ywocRkbeuAiPM+rOJxmQ9v0Ix19BVpdoaiMu6MGSzJFI0kRdppzUjHorVaH9f9Vz9XM/b0lPBMg
 JUVpDPWOXqd1C/C85/ZpHQIsxbt068RNwrx++ZFKnxKeEB/NpAgWq8Z9Zxw==
X-Google-Smtp-Source: AGHT+IHAl56fKrELTIscO/fJuSw/dTnnz+Li5IxzBhqfeYhSYXDPJNExduTjjkXJRio/17Uw0Ox7lg==
X-Received: by 2002:a05:600c:47d1:b0:45f:2919:5e8d with SMTP id
 5b1f17b1804b1-45f291960acmr33718365e9.1.1758009649793; 
 Tue, 16 Sep 2025 01:00:49 -0700 (PDT)
Received: from localhost (ip-89-103-73-235.bb.vodafone.cz. [89.103.73.235])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-45f3261358bsm11073185e9.7.2025.09.16.01.00.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Sep 2025 01:00:49 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 16 Sep 2025 10:00:48 +0200
Message-Id: <DCU2ER2UIJDS.3CTYAJAJP8NSX@ventanamicro.com>
Subject: Re: [PATCH v9 1/2] Set KVM initial privilege mode and mp_state
Cc: <ajones@ventanamicro.com>, <qemu-riscv@nongnu.org>,
 <alistair23@gmail.com>, <pbonzini@redhat.com>, <anup@brainfault.org>,
 <alistair.francis@wdc.com>, <palmer@dabbelt.com>, <xiamy@ultrarisc.com>,
 <qemu-riscv-bounces+qemu-riscv=archiver.kernel.org@nongnu.org>
To: "Xie Bo" <xb@ultrarisc.com>, <qemu-devel@nongnu.org>
From: =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>
References: <20250915070811.3422578-1-xb@ultrarisc.com>
 <20250915070811.3422578-2-xb@ultrarisc.com>
In-Reply-To: <20250915070811.3422578-2-xb@ultrarisc.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=rkrcmar@ventanamicro.com; helo=mail-wm1-x332.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

2025-09-15T15:08:07+08:00, Xie Bo <xb@ultrarisc.com>:
> For KVM mode, the privilege mode should not include M-mode, and the
> initial value should be set to S-mode. Additionally, a following patch
> adds the implementation of putting the vCPU privilege mode to KVM.
> When the vCPU runs for the first time, QEMU will first put the privilege
> state to KVM. If the initial value is set to M-mode, KVM will encounter
> an error.
>
> In addition, this patch introduces the 'mp_state' field to RISC-V
> vCPUs, following the convention used by KVM on x86. The 'mp_state'
> reflects the multiprocessor state of a vCPU, and is used to control
> whether the vCPU is runnable by KVM. Randomly select one CPU as the
> boot CPU. Since each CPU executes the riscv_cpu_reset_hold() function
> and CPU0 executes first, only CPU0 randomly selects the boot CPU.

This could really be two patches, as changing the boot=20

> Signed-off-by: Xie Bo <xb@ultrarisc.com>
> ---
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> @@ -685,18 +686,32 @@ static void riscv_cpu_reset_hold(Object *obj, Reset=
Type type)
> +    static int boot_cpu_index;
       ^^^^^^
!

> +    if (kvm_enabled()) {
> +        env->priv =3D PRV_S;
> +    } else {
> +        env->priv =3D PRV_M;
> +    }

(I think changing the priv belongs to a separate patch.)

> +    if (cs->cpu_index =3D=3D 0) {
> +        boot_cpu_index =3D g_random_int_range(0, ms->smp.cpus);
> +    }

This adds an assumption that vcpu_index =3D=3D 0 is executed first.
Is that always going to be true?

If we reset the VCPUs in a different order (or in parallel), we might
also online zero or two VCPUs.

Performing the selection just once, in the reset initiator, would allow
us to avoid the dreaded static variable by putting it in machine arch
state.

> +    if (cs->cpu_index =3D=3D boot_cpu_index) {
> +        env->mp_state =3D KVM_MP_STATE_RUNNABLE;
> +    } else {
> +        env->mp_state =3D KVM_MP_STATE_STOPPED;
> +    }

Thanks.

