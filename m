Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8672CD5BD0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 15:01:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSFkh-0005z1-4X; Wed, 27 May 2026 11:00:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSFjn-0005NS-C0
 for qemu-devel@nongnu.org; Wed, 27 May 2026 11:00:12 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSFjT-0000PC-M9
 for qemu-devel@nongnu.org; Wed, 27 May 2026 10:59:45 -0400
Received: by mail-wm1-x343.google.com with SMTP id
 5b1f17b1804b1-4904fd4f6aeso41182785e9.2
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 07:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779893981; x=1780498781; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Q/aGvATVycJ+d66t6qR7MI4KqiSFLswIHaDW5skm5tc=;
 b=DipNi8hsTwuaI2ftSnX7n9YXJZ3VQHCzdHTgSW85FLTKQ3qpKjDkCY7bsos8deIEmk
 Jexy3+G3J3XiOHLxl/O1KCi9RV9Rm0rFYj6doCgvkClf+ODs5TrJJYtKm+5Rj9aQndrN
 8iVkfBw7dunm2bcW2hdXmDJBCzJKS2Yo16NHngoLfBbSJmFzPZnbNJfOpvZEdipQwFYo
 Kn4yUwH9CADawxphIBECxQdKYgnjIfJLyYMEAyEbOY2n2RbxfpgptZoHjjWIS8bx0fd1
 Z+/chfa/oR/AVNMCBCK6lxxqsValWQDydow7bMaXQ2ycVdr3ND+woHFlvobRpr9k8TRB
 ozKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779893981; x=1780498781;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Q/aGvATVycJ+d66t6qR7MI4KqiSFLswIHaDW5skm5tc=;
 b=MEJBPDwAHegBH2SmEbUYg5yOBFmGN6YYKdle4Ml0DMISxmGE81NtMxh6+2kcR+O/HI
 yN1fEK5oMnvxpX8v859K10+ZL25dHEN/Sn2eoHP2HWYF6vRrx+UcELP75FYTf3k4B2mt
 W4TkSS0vRn/v0B1aIy+/BFfmfgKmoFg+s8Q7kcgf2VZq2d4g+dedcaFyAv6usTAx98RM
 vpC9jDthL1w9wtVTvwfrFlRB6r3BW496tzLexTCm5vChke0GBpHOYzoRgt/EsmFUTU+z
 UeuvmxMH78xfbSD7JTMOTFOGPk8qbUPwhIExmCpgYb8DLNQHsMNN0zL210mzetKaDI0g
 lVmA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8g9LatZiJS+1ns5XKvV9kV626cTQXBu9zwUL9+gRpvsXDBFPcWigSNGfRf2t6bxURsnAwcQJTrnZtm@nongnu.org
X-Gm-Message-State: AOJu0YyqHKOW6nMntF1j51841i5ezoqH7HrJIFnv/3IJOZmjsFnoqtC+
 80Pmi26NbhdMnrvK5ZeOY6zcYOJC9lHFK3vRWIId6S8A0l1LFxB92gyqH3FAjw6cG3w=
X-Gm-Gg: Acq92OGasLMT3hRt9HZqoQkbBes9zVJOnFxq296PTBCadI0CzucnEuumfYJ+DyOt/OA
 GJPDrOS5eh+nJqXn5M2jOemj6KAjoUC02YHkANaRBhX13YSWEIogvbUWP3VKg8gIjTpMr3dFxBP
 i83vcuvC/O/fNS2A5WggbXvOIvSVNgs6l5MNUdLYEtoLThGe7xr9pKyd4ZVp4X6+XsYJNWEzdzf
 3FkAmm+iwvKIjkdgkpbK+BfIzb/uqCQQv2Lst0IaZrKtzTn3n2TJqL+gY73PwJFXcOPyS92BRIq
 uWtz02plPr7RJYNFMz4Ep3Ts1XTmL2X/i4/QKx2BfwOEtU7Hd3BzqN1inQebdlNEajKFYSrQRm4
 UKkrYv9rWj40swgrzXi9HncLRNgRk/tP7DHwpfuLsdLYBCGAT+CnKZFl0SxQ7vTjSjOktndFVdU
 /IFSrUbqENuLDornQptPiMDi8fl/h2HUThlIjgv8DYoQYslGjj74PBxAKXLnOfZHHZgFg4kmmR/
 j+t
X-Received: by 2002:a05:600c:4594:b0:490:601f:d784 with SMTP id
 5b1f17b1804b1-490601fd8d6mr243371935e9.2.1779893981337; 
 Wed, 27 May 2026 07:59:41 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490809d563asm17944255e9.35.2026.05.27.07.59.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 May 2026 07:59:40 -0700 (PDT)
Message-ID: <ce1ce1bf-c983-4993-9873-11dc3d17b68e@linaro.org>
Date: Wed, 27 May 2026 16:59:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 14/17] error: Use error_setg_errno() to improve error
 messages
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, qemu-riscv <qemu-riscv@nongnu.org>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
References: <20260108070625.1586474-1-armbru@redhat.com>
 <20260108070625.1586474-15-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260108070625.1586474-15-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x343.google.com
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

On 8/1/26 08:06, Markus Armbruster wrote:
> A few error messages show numeric errno codes.  Use error_setg_errno()
> to show human-readable text instead.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Message-ID: <20251121121438.1249498-13-armbru@redhat.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> [Trivial fixup to riscv_kvm_cpu_finalize_features()]
> ---
>   backends/cryptodev-lkcf.c   |  2 +-
>   hw/ppc/spapr.c              |  6 +++---
>   hw/vfio/migration-multifd.c |  5 +++--
>   migration/rdma.c            |  3 +--
>   net/l2tpv3.c                |  6 ++----
>   target/riscv/kvm/kvm-cpu.c  | 10 +++++-----
>   6 files changed, 15 insertions(+), 17 deletions(-)


> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index 5d792563b9..b047ffa9c0 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -1996,8 +1996,8 @@ static bool kvm_cpu_realize(CPUState *cs, Error **errp)
>       if (riscv_has_ext(&cpu->env, RVV)) {
>           ret = prctl(PR_RISCV_V_SET_CONTROL, PR_RISCV_V_VSTATE_CTRL_ON);
>           if (ret) {
> -            error_setg(errp, "Error in prctl PR_RISCV_V_SET_CONTROL, code: %s",
> -                       strerrorname_np(errno));
> +            error_setg_errno(errp, errno,
> +                             "Error in prctl PR_RISCV_V_SET_CONTROL");
>               return false;
>           }
>       }
I thought we had removed this one with ce1992d45c8...

Author: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Date:   Wed Apr 24 17:24:25 2024 -0300

     checkpatch.pl: forbid strerrorname_np()

     Commit d424db2354 removed an instance of strerrorname_np() because
     it was breaking building with musl libc. A recent RISC-V patch ended
     up re-introducing it again by accident.

     Put this function in the baddies list in checkpatch.pl to avoid this
     situation again. This is what it will look like next time:

      $ ./scripts/checkpatch.pl 0001-temp-test.patch
      ERROR: use strerror() instead of strerrorname_np()
      #22: FILE: target/riscv/kvm/kvm-cpu.c:1058:
      +                         strerrorname_np(errno));

      total: 1 errors, 0 warnings, 10 lines checked

     Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
     Reviewed-by: Thomas Huth <thuth@redhat.com>
     Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
     Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
     Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
     Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

Just curious, was 
https://lore.kernel.org/qemu-devel/20240424094700.453356-2-dbarboza@ventanamicro.com/
never merged?

Anyway we are good now.

