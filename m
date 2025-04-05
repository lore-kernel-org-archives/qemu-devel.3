Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81AFBC36010
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Apr 2025 09:15:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0zbv-0000n7-Ay; Sat, 05 Apr 2025 05:14:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u0zbi-0000lV-Cd
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 05:14:31 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u0zbc-0007lf-0v
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 05:14:30 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-7340e6f3ce1so2153686b3a.0
 for <qemu-devel@nongnu.org>; Sat, 05 Apr 2025 02:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1743844460; x=1744449260; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pIj++5BKFWgo8S3pqp+BiF0puuMArL03f81m1ET7Hpk=;
 b=dVte9JOqG5ralQYwqr0+qe6lfsFi93bOPyjpJWKl2yREv+7mgctc+lIeWW184cH3mg
 osSmE8a02XIR/LZG85Ti6vnDFlNXhd37nh6tho0T/HxHxeQgy6wwt/RciUBrVjpQoMky
 fEfKrI9Mk0lrKN99fbeT6vuSDZrp0K334rKuZDRP+jtD3s4GLsvFNGjD+6uJ7Ekbfr1/
 u5RxqyeeJysNzL9gvBK2Umch7oVTTTlh8Jj6zOZqPyag9YXYhyVbSK09xrhknHIlkNOX
 nNzGOTEpsX6bSipi/qiFl0FrgBlJoH4TtTYJW+yfuiD9DsmjiBQuILYRZ3dnyS75JvtR
 Trsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743844460; x=1744449260;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pIj++5BKFWgo8S3pqp+BiF0puuMArL03f81m1ET7Hpk=;
 b=QgShZQ/op9xhWAM/j8BbySkAE1y8jptGUnPDQTNR0VQp62swiHyeChA5FjAaMvtIE2
 X/5YKaQC6TXClUdjnYioVipIkeLn2m9C877E17pZ4FgMUKz415TTvBCHtViqfO0hth4F
 MuWZoz78xfvdWYSVd2GDYUpa1beszSKFjMcC1znSO8nHuvJLjppURgXXDYgm910dxIyB
 rdGpuZIikawcamf8eeteWf70z8wcLJxxJHu0QthiKB7xlJED572SxBzaB9O+Dq1JW5QD
 nJcXSB4vAzEh/QkWKRqQlUaiL+O6HBljZ7UoJwzG1++p2A2zCukjjEarTA6BnuGwNhj1
 TS7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsc4GNXSYoY7LV9PkndCydi1y5Nz4g4m7SKy7TI7RfX/lzz57+IjkVaKZE1zz6m1rKPI6B8dD7X4Vu@nongnu.org
X-Gm-Message-State: AOJu0YyDtVUG55IAacpc1pEtqgbwrFeKSHuh9aUIJEvFCAp5Z0BcX1Qb
 G5PiPMTrTPHgohoQXhMdgUbzweGomDJ5d0yycx9DL8SSO4hnr6d9n1Gg2KrqfL8=
X-Gm-Gg: ASbGncsibH9NnrAhstU+WtMhzfwUkzjFF+rXhAye/kfiD1OxNkPSWZu3TKwChq4a595
 Z9SIT0HT4hfi3jw0imYE0Sykz2mNLwmtUiWYB1G8m4YrUuvl6Wk8AGDojRdBwOGhr0ZA4ScSO6t
 IzUvBDHReCvu6+INe7aTM6FOvVuvVVvAp4V/YJqOdJp6pKHgRftihSPV9o+NGZ1+2pugL134qzc
 GKbOpd0ZLsH0hK7GRVEdyG4/zMMB79gYtbVMa5ojEAtCBVKvKqSrQIWdNACsWwhCebXGUiyDzku
 itPBbPupcvlzkSsyD65oUGZmyZhi/HQEBBko7vEQPMaYnCZbOdGxRlzLTrYRtvyYnGcZSvM=
X-Google-Smtp-Source: AGHT+IElS0KRZVLJpfEHCHus3UbXa7MyqiBAEG1EPvwroEW4bUp8Ubnnej4ROz0sfXKw2K3WS4+M5A==
X-Received: by 2002:a05:6a00:3d12:b0:736:34a2:8a20 with SMTP id
 d2e1a72fcca58-739e4c19f56mr9518059b3a.21.1743844460308; 
 Sat, 05 Apr 2025 02:14:20 -0700 (PDT)
Received: from [192.168.68.110] ([177.170.227.223])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-739d97d1881sm4834066b3a.3.2025.04.05.02.14.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 05 Apr 2025 02:14:19 -0700 (PDT)
Message-ID: <87129ffe-fa62-4e6d-b154-8e61a22ce13a@ventanamicro.com>
Date: Sat, 5 Apr 2025 06:14:15 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/12] target/riscv: rvv: Apply vext_check_input_eew to
 vector register gather instructions
To: Max Chou <max.chou@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 antonb@tenstorrent.com
References: <20250329144446.2619306-1-max.chou@sifive.com>
 <20250329144446.2619306-5-max.chou@sifive.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20250329144446.2619306-5-max.chou@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x430.google.com
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



On 3/29/25 11:44 AM, Max Chou wrote:
> Handle the overlap of source registers with different EEWs.
> The vs1 EEW of vrgatherei16.vv is 16.
> 
> Co-authored-by: Anton Blanchard <antonb@tenstorrent.com>
> Co-authored-by: Max Chou <max.chou@sifive.com>

Since you're marked as Author you don't need this co-authored-by tag
in your name too.

Same thing for patches 5 to 11.

> Signed-off-by: Max Chou <max.chou@sifive.com>
> ---

With the co-authored-by tag removed:

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/insn_trans/trans_rvv.c.inc | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
> index 70c19c49ae4..4a0c9fbeff3 100644
> --- a/target/riscv/insn_trans/trans_rvv.c.inc
> +++ b/target/riscv/insn_trans/trans_rvv.c.inc
> @@ -3478,6 +3478,7 @@ static bool vrgather_vv_check(DisasContext *s, arg_rmrr *a)
>   {
>       return require_rvv(s) &&
>              vext_check_isa_ill(s) &&
> +           vext_check_input_eew(s, a->rs1, s->sew, a->rs2, s->sew, a->vm) &&
>              require_align(a->rd, s->lmul) &&
>              require_align(a->rs1, s->lmul) &&
>              require_align(a->rs2, s->lmul) &&
> @@ -3490,6 +3491,7 @@ static bool vrgatherei16_vv_check(DisasContext *s, arg_rmrr *a)
>       int8_t emul = MO_16 - s->sew + s->lmul;
>       return require_rvv(s) &&
>              vext_check_isa_ill(s) &&
> +           vext_check_input_eew(s, a->rs1, MO_16, a->rs2, s->sew, a->vm) &&
>              (emul >= -3 && emul <= 3) &&
>              require_align(a->rd, s->lmul) &&
>              require_align(a->rs1, emul) &&
> @@ -3509,6 +3511,7 @@ static bool vrgather_vx_check(DisasContext *s, arg_rmrr *a)
>   {
>       return require_rvv(s) &&
>              vext_check_isa_ill(s) &&
> +           vext_check_input_eew(s, -1, MO_64, a->rs2, s->sew, a->vm) &&
>              require_align(a->rd, s->lmul) &&
>              require_align(a->rs2, s->lmul) &&
>              (a->rd != a->rs2) &&


