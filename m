Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FB1EC021BE
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 03:34:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnUex-00039S-0U; Wed, 26 Feb 2025 22:34:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tnUeu-00039A-R9; Wed, 26 Feb 2025 22:34:00 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tnUet-0006iS-3e; Wed, 26 Feb 2025 22:34:00 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-223378e2b0dso7099305ad.0; 
 Wed, 26 Feb 2025 19:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740627237; x=1741232037; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jtQqggqFdRim7QPOYzoaU+Nn+5qGO/PWf3+cQvbmSUQ=;
 b=RAEACDmJOOwd4/SlQo6JMGoPDshLOQdhfXbsGdc0TxXjSoVw6Jx0vS8DYChQ0feAp2
 iP8TUAXInldU95/Gn8jhFCtRYqhUbKfXku6BbgsZNAI1fzUi1gPhl/uTVmefm5zFp4ws
 ACu4rUij7Kh6ThcH3p1ZlaOHOIrrU+kSmsch4+e2BrkeRmkZ7hFBCAwWfGlqWc5EmYBU
 8c+s+VCJ/5NrORQG+aH6xqaY7refHaZezoCBunCImP9zfinFJScwgXd5tEBR7iBn6qmD
 uF27QJd8MMGZFq6bJcNppnpfpsTkU/EP8sSLOyrDsTI8FBjhJIogmzOfSbydb72vv6zh
 BI+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740627237; x=1741232037;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=jtQqggqFdRim7QPOYzoaU+Nn+5qGO/PWf3+cQvbmSUQ=;
 b=RwERoMqv3ilwss/Z2ZufFhelkQ0bLotRyaocEY6wvzUMeE84YR1z0H6fvF1Wfv+QYS
 JSIp3/d5uEFtMNyhM+i13m8+wuPC0HIgzvjpZjHpPsMUug0wKdHFERJHE6oNIe5MPgIF
 wHcOF9C/R4aZdRcIPz1cei/ijAymeIXCMB5QcDYXYvkUdUwXcYSalq9ixoo/r+w+bvoS
 odW3xS2wlQlPRSGxiypkaiWezllJmz21OYy25jMdobRzqGGVI0x7zs386o5Eg/ttytvy
 8aPUNE0i9rZVZgNcG6+LpIVqtC7ilNO52ZLZwSmlCdn26fdKgi/bvHFATcXEtdU9CC/O
 CVcg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHYwp0U08a2kqsjJSrULpQgHYYlQwrL5GV3dxMF2iLLv+S6SkmCC862ao9cEh5C8Ug6P45mlaB9XPa@nongnu.org
X-Gm-Message-State: AOJu0Yya6rGkQaul+KLi93YD+PvotOS5VQcoVOai0kqr1l1nSCImAUlr
 fE0Tjd7Qy2naxGYD2Annj7vhWSKsWl0wkwrrO/EoarOOIxp1oEWi
X-Gm-Gg: ASbGncuO0IT+BEZUT6ZBTaZ+U3KYvpxMZmHS9vARFzRqcEzK3SW+vAZRJJR4qNDk8ON
 cWBvPV7wvu8q5eDU3iN1EGZvq2zMdrNIlAsPUTfDC31UzoiWgj1O/My/q85RrWYnB6BNwM7PraW
 c9ERhT99p22CnHVKqUSJQiSgogEaafSoISdNrgTRb+8nPMs4ZJbLY6N9iXJiak5tyXJZhhnbCbe
 N+y17YHuZdntRUoHCbgQK5K8pBytHOrbqW13KVp/iTSUMVZeiQH8IdO+5qOhBvfBI3WRzA2tMzF
 BuWsaEMjTDhzPkSv9g==
X-Google-Smtp-Source: AGHT+IGJSnPCoWVgo3QIpwEsWNDrHgLgx/aE5/2BbCZSNV/JXLx6XwBwcjA/23z15ELTiKYHb2QiDg==
X-Received: by 2002:a05:6a00:c96:b0:730:8d25:4c24 with SMTP id
 d2e1a72fcca58-734790c751emr14423136b3a.10.1740627237202; 
 Wed, 26 Feb 2025 19:33:57 -0800 (PST)
Received: from localhost ([1.146.90.134]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7349fe487b6sm408507b3a.47.2025.02.26.19.33.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Feb 2025 19:33:56 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 27 Feb 2025 13:33:51 +1000
Message-Id: <D82WUV05QWZP.10KAOOHN6YFFP@gmail.com>
Cc: <qemu-ppc@nongnu.org>, "Daniel Henrique Barboza"
 <danielhb413@gmail.com>, "Harsh Prateek Bora" <harshpb@linux.ibm.com>,
 "Sourabh Jain" <sourabhjain@linux.ibm.com>, "Mahesh J Salgaonkar"
 <mahesh@linux.ibm.com>, "Hari Bathini" <hbathini@linux.ibm.com>
Subject: Re: [PATCH 6/6] hw/ppc: Enable Fadump for PSeries
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Aditya Gupta" <adityag@linux.ibm.com>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.19.0
References: <20250217071711.83735-1-adityag@linux.ibm.com>
 <20250217071711.83735-7-adityag@linux.ibm.com>
In-Reply-To: <20250217071711.83735-7-adityag@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x629.google.com
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
> With all support in place, enable fadump by exporting the
> "ibm,configure-kernel-dump" RTAS call in the device tree.
>
> Presence of "ibm,configure-kernel-dump" tells the kernel that the
> platform (QEMU) supports fadump.
>
> Pass "fadump=3Don" to enable Linux to use firmware assisted dump.
>
> Logs of a linux boot with firmware assisted dump:
>
>     ./build/qemu-system-ppc64 -M pseries,x-vof=3Don --cpu power10 --smp 4=
 -m 4G -kernel some-vmlinux -initrd some-initrd -append "debug fadump=3Don =
crashkernel=3D1G" -nographic
>     [    0.000000] random: crng init done
>     [    0.000000] fadump: Reserved 1024MB of memory at 0x00000040000000 =
(System RAM: 4096MB)
>     ...
>     [    1.084686] rtas fadump: Registration is successful!
>     ...
>     # cat /sys/kernel/debug/powerpc/fadump_region
>     CPU :[0x00000040000000-0x000000400013d3] 0x13d4 bytes, Dumped: 0x0
>     HPTE:[0x000000400013d4-0x000000400013d3] 0x0 bytes, Dumped: 0x0
>     DUMP: Src: 0x00000000000000, Dest: 0x00000040010000, Size: 0x40000000=
, Dumped: 0x0 bytes
>
>     [0x000000fffff800-0x000000ffffffff]: cmdline append: ''
>     # echo c > /proc/sysrq-trigger
>
> The fadump boot after crash:
>
>     [    0.000000] rtas fadump: Firmware-assisted dump is active.
>     [    0.000000] fadump: Updated cmdline: debug fadump=3Don crashkernel=
=3D1G
>     [    0.000000] fadump: Firmware-assisted dump is active.
>     [    0.000000] fadump: Reserving 3072MB of memory at 0x00000040000000=
 for preserving crash data
>     ....
>     # file /proc/vmcore
>     /proc/vmcore: ELF 64-bit LSB core file, 64-bit PowerPC or cisco 7500,=
 OpenPOWER ELF V2 ABI, version 1 (SYSV), SVR4-style
>
> Analysing the vmcore with crash-utility:
>
>           KERNEL: vmlinux-6.14-rc2
>         DUMPFILE: vmcore-a64dcfb451e2-nocma
>             CPUS: 4
>             DATE: Thu Jan  1 05:30:00 IST 1970
>           UPTIME: 00:00:30
>     LOAD AVERAGE: 0.74, 0.21, 0.07
>            TASKS: 94
>         NODENAME: buildroot
>          RELEASE: 6.14.0-rc2+
>          VERSION: #1 SMP Wed Feb 12 06:49:59 CST 2025
>          MACHINE: ppc64le  (1000 Mhz)
>           MEMORY: 4 GB
>            PANIC: "Kernel panic - not syncing: sysrq triggered crash"
>              PID: 270
>          COMMAND: "sh"
>             TASK: c000000009e7cc00  [THREAD_INFO: c000000009e7cc00]
>              CPU: 3
>            STATE: TASK_RUNNING (PANIC)
>
> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>

This is very cool, nice work. Does it work with KVM? I think... probably
it could?

Are you able to add a functional test case for it? This is something
that people (including me) will forget to test...

Thanks,
Nick

> ---
>  hw/ppc/spapr_rtas.c    | 6 +++++-
>  include/hw/ppc/spapr.h | 3 ++-
>  2 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> index 0aca4270aee8..bd2ed16a46e3 100644
> --- a/hw/ppc/spapr_rtas.c
> +++ b/hw/ppc/spapr_rtas.c
> @@ -692,7 +692,7 @@ static void trigger_fadump_boot(target_ulong spapr_re=
tcode)
>  }
> =20
>  /* Papr Section 7.4.9 ibm,configure-kernel-dump RTAS call */
> -static __attribute((unused)) void rtas_configure_kernel_dump(PowerPCCPU =
*cpu,
> +static void rtas_configure_kernel_dump(PowerPCCPU *cpu,
>                                     SpaprMachineState *spapr,
>                                     uint32_t token, uint32_t nargs,
>                                     target_ulong args,
> @@ -1109,6 +1109,10 @@ static void core_rtas_register_types(void)
>      spapr_rtas_register(RTAS_IBM_NMI_INTERLOCK, "ibm,nmi-interlock",
>                          rtas_ibm_nmi_interlock);
> =20
> +    /* Register Fadump rtas call */
> +    spapr_rtas_register(RTAS_CONFIGURE_KERNEL_DUMP, "ibm,configure-kerne=
l-dump",
> +                        rtas_configure_kernel_dump);
> +
>      qtest_set_command_cb(spapr_qtest_callback);
>  }
> =20
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index fa63008e57ec..bde3bdc4b80c 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -768,8 +768,9 @@ void push_sregs_to_kvm_pr(SpaprMachineState *spapr);
>  #define RTAS_IBM_SUSPEND_ME                     (RTAS_TOKEN_BASE + 0x2A)
>  #define RTAS_IBM_NMI_REGISTER                   (RTAS_TOKEN_BASE + 0x2B)
>  #define RTAS_IBM_NMI_INTERLOCK                  (RTAS_TOKEN_BASE + 0x2C)
> +#define RTAS_CONFIGURE_KERNEL_DUMP              (RTAS_TOKEN_BASE + 0x2D)
> =20
> -#define RTAS_TOKEN_MAX                          (RTAS_TOKEN_BASE + 0x2D)
> +#define RTAS_TOKEN_MAX                          (RTAS_TOKEN_BASE + 0x2E)
> =20
>  /* Fadump commands */
>  #define FADUMP_CMD_REGISTER            1


