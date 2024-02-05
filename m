Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4514BC4828D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 08:06:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWtzN-00071I-Av; Mon, 05 Feb 2024 03:06:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rWtyy-00070A-E7; Mon, 05 Feb 2024 03:05:38 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rWtyv-0001Gz-4W; Mon, 05 Feb 2024 03:05:35 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1d95d67ff45so25665215ad.2; 
 Mon, 05 Feb 2024 00:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707120329; x=1707725129; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gbNXvlJCZvgEuCX97AJZzoXCygWa3lIONoGZkCzBtMQ=;
 b=nXJYO67l4K64jvth04hFVYpTthctvXCbOvsJSd+G/V689u5UEWYAN4ijzX52h1bo71
 nGatmkcHiCExZuVPPMscZ8K01hap3jaxGecIaHInAqobOU5RYs7OxnuXWTjrxKBEDIFk
 vJSCnWI/Fzt2Hjqq3AY+oDiop/U5DK7BDPUiq0rq2KVxBP5zVPAfBGtn0HLbNHT8/j2Q
 eFy6iP/g5t/3CJO3hT5gtmYi+OMUb3j48FJom7lp7Rzg/IFwVr6RdAD+86AdoElyTD+3
 sAktMLsCw4k+Ry8ftZZYCe++877YJLMjghGVszp/TljTvbCWItWc2WuACw63UryMRopV
 cBgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707120329; x=1707725129;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=gbNXvlJCZvgEuCX97AJZzoXCygWa3lIONoGZkCzBtMQ=;
 b=Mav0W3U02MXKO3Vkr+1rox3HS3bt38MqpgaSJ8zlSdcFyFf9tFa1lt0xnslUNATYri
 ZngB7AHytpoLSi//XEO+Y1D0ce9opqj06nPa6U6hSMCYiiED5q9QWcOId+d+WrpHG3Oy
 RbTP5tGemWM0azX3dR9UC8UEmgzFRgZcgahALn1PZf7AjZtLppANTu2uShaeOZtNNIni
 n3s6vpmi0X5svkb0+3vFDiswn75v4hlH0/vvVHbF/7eh3PkFlQyWBlOoiz/v2I7StDS+
 5al5cxkRx3bAKxfxsP2N9FjhAYGiQ9y1qQTIPmQJVh8dqxb4tloW14A11Bp7ccZ3I4km
 9d/A==
X-Gm-Message-State: AOJu0YzQhgRScm1qKIkg95BEoivnAjl216Y5COugZRTdO4vfxwC3Vdkk
 wttnKEpQJg7MCToTUcCRrZRIgnojsubUYMTLIrJkF9T7RPgOKhtW
X-Google-Smtp-Source: AGHT+IEAu4ngfAZtoVxdtK90cGmbYLf8SXpRB2a2M3KJzVKi0GZCABi6ElEeZwoc67dQD8N/u8Am5g==
X-Received: by 2002:a17:902:e882:b0:1d9:7095:7e1f with SMTP id
 w2-20020a170902e88200b001d970957e1fmr11705328plg.67.1707120329286; 
 Mon, 05 Feb 2024 00:05:29 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCXv4qYBn+klaTpW7jSk9SM9E9xfXTWnFfIVow8MDNsWfGUVjeTsDTtqUT4GHKXMOUsapxJd8trpezBYTfoJ9ithXTzXA/qoGV6PwMKjmswofValvNVmDmoxBriIcnbz+4+A76Pv2H3bfyLpRhJ6dHRH7EuZ1LxS0JYRk2VfaSGp/b2Htfac
Received: from localhost ([1.146.86.248]) by smtp.gmail.com with ESMTPSA id
 ml12-20020a17090334cc00b001d8f6ae51aasm5713276plb.64.2024.02.05.00.05.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Feb 2024 00:05:28 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 05 Feb 2024 18:05:22 +1000
Message-Id: <CYWZNDQFGVHZ.24ZEW4NNLI1BK@wheely>
Cc: <qemu-devel@nongnu.org>, "Daniel Henrique Barboza"
 <danielhb413@gmail.com>, =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 "David Gibson" <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v3 0/4] Add BHRB Facility Support
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Glenn Miles" <milesg@linux.vnet.ibm.com>, <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.15.2
References: <20230925174351.617891-1-milesg@linux.vnet.ibm.com>
In-Reply-To: <20230925174351.617891-1-milesg@linux.vnet.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue Sep 26, 2023 at 3:43 AM AEST, Glenn Miles wrote:
> This is a series of patches for adding support for the Branch History
> Rolling Buffer (BHRB) facility.  This was added to the Power ISA
> starting with version 2.07.  Changes were subsequently made in version
> 3.1 to limit BHRB recording to instructions run in problem state only
> and to add a control bit to disable recording (MMCRA[BHRBRD]).
>
> Version 3 of this series disables branch recording on P8 and P9 due
> to a drop in performance caused by recording branches outside of
> problem state.

For this series,

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

I finally got around to adding powerpc MMU support to kvm unit tests,
so userspace and basic BHRB tests weren't much more work. Easier than
testing it with perf in Linux!

https://gitlab.com/npiggin/kvm-unit-tests.git powerpc

Thanks,
Nick

>
> Glenn Miles (4):
>   target/ppc: Add new hflags to support BHRB
>   target/ppc: Add recording of taken branches to BHRB
>   target/ppc: Add clrbhrb and mfbhrbe instructions
>   target/ppc: Add migration support for BHRB
>
>  target/ppc/cpu.h                       |  24 ++++++
>  target/ppc/cpu_init.c                  |  39 +++++++++-
>  target/ppc/helper.h                    |   5 ++
>  target/ppc/helper_regs.c               |  35 +++++++++
>  target/ppc/insn32.decode               |   8 ++
>  target/ppc/machine.c                   |  23 +++++-
>  target/ppc/misc_helper.c               |  46 +++++++++++
>  target/ppc/power8-pmu-regs.c.inc       |   5 ++
>  target/ppc/power8-pmu.c                |  48 +++++++++++-
>  target/ppc/power8-pmu.h                |  11 ++-
>  target/ppc/spr_common.h                |   1 +
>  target/ppc/translate.c                 | 101 +++++++++++++++++++++++--
>  target/ppc/translate/bhrb-impl.c.inc   |  43 +++++++++++
>  target/ppc/translate/branch-impl.c.inc |   2 +-
>  14 files changed, 374 insertions(+), 17 deletions(-)
>  create mode 100644 target/ppc/translate/bhrb-impl.c.inc


