Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A24F6C021BE
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 03:15:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnUMp-0004F4-40; Wed, 26 Feb 2025 22:15:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tnUMe-00047u-H6; Wed, 26 Feb 2025 22:15:09 -0500
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tnUMc-000393-O3; Wed, 26 Feb 2025 22:15:08 -0500
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2f83a8afcbbso882946a91.1; 
 Wed, 26 Feb 2025 19:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740626105; x=1741230905; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pKb/1mhs6YtLMdSV4u1XYywcQEBjKPL4216ITqkyehk=;
 b=XxFjwOxeYmUbg+qezKD+ij4For8XTDs0vWm73yrxCJJoSRdtvQf7NyqyWS2APCqufY
 TKG/jSm7kBBjaFhrakBuxehqfV6S1LFomjmWUCL5f46B63ER2+p/jv3Ii4ZFm8NLzuyj
 FoI8O0I+JCZEdmNAt1Ge/+Lpc99MfWt4Nh3yL5F4+jNzHQBWUZvdCsSfS3JZbEgC0b4r
 LUJcWX8Vbj/qHtSrQ+aahFTty3tw7F7J3RfXHTbOWCsn+SVk4Sq5wjlwlCZPgXs0/W9M
 scDw+p6/qYvI/ca+arOjIWtXhhwiXi2lWyD9uDqtPfLDoVRIN0xdWNpqPLNM3/Jnhqwz
 iLmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740626105; x=1741230905;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=pKb/1mhs6YtLMdSV4u1XYywcQEBjKPL4216ITqkyehk=;
 b=F2hJXTxq/cz/j/vT552oKk82obRd8lKVgwqNsh4g1sNButCN3KYoIsYE3o/zRec+lY
 Z/zVRe0oTWfy6oYMj/dkUd/NQqstohuDkcB72vh47qRpB6801GeSIiGB8CZEJCPChRN5
 uiiJGy9uhA7xj8RytZp/23Si+SJQs5XvBH/9QkS60oPSwgvfxQeinh1S0hwWDjF0/yT4
 0cK/u+YtGwpJpGVGUwLtN/F1cH5xgyQUkjA0/62HYvbzzWbFR6k0Ln8+8K1/oyK2o+Wg
 GWSHBW0IWqEyIq7ze8T5/7f6dpZB10qosqKqfacgnp+OrKCelu19x6OQlXFXmW/i4N9F
 0mjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZRckNTjAHOEquTOT2C+Znl6eQkGzu3JtDLbf3e2/wASySPMRexNnXJZpIwF2DSRzwCLaYRGXdQZSb@nongnu.org
X-Gm-Message-State: AOJu0Yy90KJmCn+qzPzjiHtqbnnB2z9l3cf2CspZnNX3jRZgElqeo9X+
 GB11MwYg4jKEh90zyJB+HdeYDKsTtxtmV9MIs/rR5tCghTGJRCc1
X-Gm-Gg: ASbGnctLe9wCeyiYDwtrg58X7RO6y9y00r0J+GXEG0M4PFrESvzin530EVvJ4bFMMkd
 e9NPGvPqzx6cBxyuM2P9ldnrCE1JNVa25xyLlPIJ3Jyl2PsyLJlCQll8JF5wXDJl5ecEhsSopiD
 XMXRPMI0iq9RLVuXMhCBBhRs1RqLOhEWGqVmU1q1qy5fZwME6RofmttK/aSGxmVz7RZSTIjwK1d
 zkl4uOdANqTvpsi3PtDdRvmk052K5GkOhPJrmXsLEw1pBUPYRPAChcOgfvYCCZgH4o1oTQR97sn
 +ROLvNrkFSlAijpUIQ==
X-Google-Smtp-Source: AGHT+IHI+ZpVZMEX92JC6sHM8oemfDluHibAtWkunByKmE4HJ59ioyXgdgt3YHhk+7ImwiPZerzf7A==
X-Received: by 2002:a17:90b:3f46:b0:2fa:9c9:20a3 with SMTP id
 98e67ed59e1d1-2fea0e6d51emr2982736a91.0.1740626104679; 
 Wed, 26 Feb 2025 19:15:04 -0800 (PST)
Received: from localhost ([1.146.90.134]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fe825baa4csm2502395a91.17.2025.02.26.19.15.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Feb 2025 19:15:04 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 27 Feb 2025 13:14:58 +1000
Message-Id: <D82WGEF9P3MM.10IKXK3R6Q13M@gmail.com>
Cc: <qemu-ppc@nongnu.org>, "Daniel Henrique Barboza"
 <danielhb413@gmail.com>, "Harsh Prateek Bora" <harshpb@linux.ibm.com>,
 "Sourabh Jain" <sourabhjain@linux.ibm.com>, "Mahesh J Salgaonkar"
 <mahesh@linux.ibm.com>, "Hari Bathini" <hbathini@linux.ibm.com>
Subject: Re: [PATCH 2/6] hw/ppc: Trigger Fadump boot if fadump is registered
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Aditya Gupta" <adityag@linux.ibm.com>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.19.0
References: <20250217071711.83735-1-adityag@linux.ibm.com>
 <20250217071711.83735-3-adityag@linux.ibm.com>
In-Reply-To: <20250217071711.83735-3-adityag@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x102a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Mon Feb 17, 2025 at 5:17 PM AEST, Aditya Gupta wrote:
> According to PAPR:
>
>     R1=E2=80=937.3.30=E2=80=933. When the platform receives an ibm,os-ter=
m RTAS call, or
>     on a system reset without an ibm,nmi-interlock RTAS call, if the
>     platform has a dump structure registered through the
>     ibm,configure-kernel-dump call, the platform must process each
>     registered kernel dump section as required and, when available,
>     present the dump structure information to the operating system
>     through the =E2=80=9Cibm,kernel-dump=E2=80=9D property, updated with =
status for each
>     dump section, until the dump has been invalidated through the
>     ibm,configure-kernel-dump RTAS call.
>
> If Fadump has been registered, trigger an Fadump boot (memory preserving
> boot), if QEMU recieves a 'ibm,os-term' rtas call.
>
> Implementing the fadump boot as:
>     * pause all vcpus (will save registers later)
>     * preserve memory regions specified by fadump
>     * do a memory preserving reboot (GUEST_RESET in QEMU doesn't clear
>       the memory)
>
> Memory regions registered by fadump will be handled in a later patch.
>
> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> ---
>  hw/ppc/spapr_rtas.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
>
> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> index eebdf13b1552..01c82375f03d 100644
> --- a/hw/ppc/spapr_rtas.c
> +++ b/hw/ppc/spapr_rtas.c
> @@ -342,6 +342,43 @@ static void rtas_ibm_set_system_parameter(PowerPCCPU=
 *cpu,
>  }
> =20
>  struct fadump_metadata fadump_metadata;
> +bool is_next_boot_fadump;

Here's another one for spapr state.

> +
> +static void trigger_fadump_boot(target_ulong spapr_retcode)
> +{
> +    /*
> +     * In PowerNV, SBE stops all clocks for cores, do similar to it
> +     * QEMU's nearest equivalent is 'pause_all_vcpus'
> +     * See 'stopClocksS0' in SBE source code for more info on SBE part
> +     */

Can probably remove this comment here.

> +    pause_all_vcpus();
> +
> +    if (true /* TODO: Preserve memory registered for fadump */) {

If you're adding half the code to preserve memory but never actually
calling it anyway, you don't need the pause_all_vcpus() call either.

Again I would rather not adding unused code to the patches if possible.
If you're really not able to find a nice way to split and add
incrementally then okay, but try to take another look if possible.


> +        /* Failed to preserve the registered memory regions */
> +        rtas_st(spapr_retcode, 0, RTAS_OUT_HW_ERROR);
> +
> +        /* Cause a reboot */
> +        qemu_system_guest_panicked(NULL);
> +        return;
> +    }
> +
> +    /* Mark next boot as fadump boot */
> +    is_next_boot_fadump =3D true;
> +
> +    /* Reset fadump_registered for next boot */
> +    fadump_metadata.fadump_registered =3D false;
> +    fadump_metadata.fadump_dump_active =3D true;
> +
> +    /* Then do a guest reset */
> +    /*
> +     * Requirement:
> +     * This guest reset should not clear the memory (which is
> +     * the case when this is merged)
> +     */
> +    qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);

Seems reasonable. What is the actual mechanism that clears the machine
RAM anyway? I'm not able to find it...

Thanks,
Nick

> +
> +    rtas_st(spapr_retcode, 0, RTAS_OUT_SUCCESS);
> +}
> =20
>  /* Papr Section 7.4.9 ibm,configure-kernel-dump RTAS call */
>  static __attribute((unused)) void rtas_configure_kernel_dump(PowerPCCPU =
*cpu,
> @@ -449,6 +486,11 @@ static void rtas_ibm_os_term(PowerPCCPU *cpu,
>      target_ulong msgaddr =3D rtas_ld(args, 0);
>      char msg[512];
> =20
> +    if (fadump_metadata.fadump_registered) {
> +        /* If fadump boot works, control won't come back here */
> +        return trigger_fadump_boot(rets);
> +    }
> +
>      cpu_physical_memory_read(msgaddr, msg, sizeof(msg) - 1);
>      msg[sizeof(msg) - 1] =3D 0;
> =20


