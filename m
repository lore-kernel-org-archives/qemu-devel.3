Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03646111224A
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 00:46:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w86Bw-00019J-Qd; Wed, 01 Apr 2026 20:45:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w86Br-00016R-I9
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 20:45:46 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w86Bo-0002KI-FO
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 20:45:42 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-b9c3a9fe80fso38605966b.3
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 17:45:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775090739; cv=none;
 d=google.com; s=arc-20240605;
 b=YxpgYjNAjtEh3Sel9Y3yY2JqbxlMR5l9880J+tzHb4IpCneu9ve1+9dAYIgNcCUDtd
 dzo7sUQsigKtYnzpCvXMIZIAo6Qiy8Rqswpl3vze5ljqkyeH56pc8RsOJ5MHLmBZjTmF
 nz+r63vb3ZO+QQb/YykbX45Q6GBXNOFZ8TS7iRPA9dLRGhb+RFXsUwVqq9ZnX58bFP6v
 iiYe4MW6U+eGdtFRAQMX9P1nUPi6Cps3o3WTQNZmcolXyata9U+xKzyvxCZIKQS6fbah
 jXAxQhr/+osoZNsNxgs2PqigCV1pg74zG4PKsEEz5OrDAktPj+PoxYP6Fd++WNuy9Baw
 0jdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=5LdM4uR5mS1ZaeLcLWrAhMvuDpyTdPvmVDGk7/JwB14=;
 fh=/0koH8gEOGDJwB7lyMkOX4zflKNbhvY7bxbNaPOWv2A=;
 b=SCVHJRJt52PW4m6W2ncLMo0oOSTLoaMy4lMGiaaIdTaV/ZJ4G2c/hfBX54dbKoazel
 0ntZZBx3tl1RlMeCDn+MK57F3nLAIUej531CeDHqsa3vh7EqBtIAJ9gQBbFIH0njDuG9
 alKkGGSXAlV95dRABRbhx2UwNtfVNiJS1ZA2VDznjOqKOJc8T9uXozKcnZwUeIK+NPpD
 eJe9vHiVqarwgS7+dy1tsSg73nTzNZ0tKl/rgw03n/VU2u2jSVODbEIM4CWDKADM/TXV
 aInca7njRrCL50Evk/XuORtJh+RgaoIN3FAeRfG3IASTGgnCuvJqkVxqJCb+L1DXktHx
 Bqfw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775090739; x=1775695539; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5LdM4uR5mS1ZaeLcLWrAhMvuDpyTdPvmVDGk7/JwB14=;
 b=GXrdxNnHKp7DSfRhYpb0h3P2u9HDaGcr9iYm/ufUfEr2/VPVAHRJUcFRTMPMNbsHVt
 yy01OM22X5uL7xksqF7yP/7Isqk84oADycbWxEVHoSt1fO34jd/ZybnSIlwpjomsVXWd
 OlK+pDVl5PBPb68sePqip//MdmlCxuuCZMSAb/ffnS96Dh/TPTsgJscKb2AjnSKNKorr
 oTuCMaEkO4tDJQwtUlttG535nCASUN62kP7xwhnTJ3lOvsfRFNRBhdvly8tTY6GmGkmm
 B/14WuGsA2Z1Oztxf1yk58znfSE4zj0gWKzBTkabac4bqg7D5dPZ4e+yyJUcA9gW/B3p
 PAjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775090739; x=1775695539;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5LdM4uR5mS1ZaeLcLWrAhMvuDpyTdPvmVDGk7/JwB14=;
 b=hiLTfKPHPZegKj1br8QSzSUYOzfX2CERTft5VdvVC7McPxGmzJQKqlH/sm5BqqK6ho
 5rflkO2gXwt1U9G2MblLXeGWkZ4vbWO2ZuOHRW/3JA3yVZJDsYpIqsLl4mqvWjw2Hbon
 mbcjetpFofBWprYSL1+zXSeXj3NkYn6/Z+YG1TxF+6PFghEuNpoM53ma1PiDALHdhFyr
 4R+jroDROuqg7Y0Sl7AKxwkp24Wkmu+5YXuow0ecIVK2brNwmNekJH38bQGuAZm912hC
 11eVKzJO/ooPiL9WTPj7BMKfiheIBTGjloaqti04gwC+D3HhBKBgL/RPJFQGSWeaTLQr
 mQVA==
X-Gm-Message-State: AOJu0YyVCG4MqOyk8vGtor64CgzEmCJc0dh+Sky5UbUv/tfkylL4cs3F
 +P/8gSpK8wCo2mTY/28CmdZVgtgHKGdj83Hg3cWYWKNmqLAlzxsWOv/AwVU2BgaDkJaPHFiTimF
 UGydeaxxzyWyAo4Tp6JKBUa3UttVBCtY=
X-Gm-Gg: ATEYQzzlGIh9lLOMSOuN5hBJQ7dB5kzzkhJDQs6kU9dXtaktWrqX4JUdOGfJKoxDDPM
 ++8fBNAuQun+9jmsOaHK9WUcLS/moQqWaM0GBIywPEuubAPHAI5tlf54xm3s5EpQDEV/iKdy/cP
 8f1oz1HPg02DlEAcwy6UuSJjZ/AYgoyFt8NLAvL0NCn4uAdlfbiSQrVOECsl2/UPHyklEtND1Ev
 Hafl23Gx3KrF1Qb2/a8iAtatc+nrKwrnZL+c6kIB0YzyMn+3h4dyTkMtmiYmTIqgKbt3GfL+zul
 UFwDprAYITb5BgXMNGjFjEKWY5HlCdaJsZUKWw==
X-Received: by 2002:a17:906:a50:b0:b98:8d3a:7d26 with SMTP id
 a640c23a62f3a-b9c138fa8bemr271649866b.15.1775090738694; Wed, 01 Apr 2026
 17:45:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260401201753.92290-1-philmd@linaro.org>
 <20260401201753.92290-2-philmd@linaro.org>
In-Reply-To: <20260401201753.92290-2-philmd@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 2 Apr 2026 10:45:12 +1000
X-Gm-Features: AQROBzCgjpsbOMdvqO6Me5z7QKdDwVgBMzoXedFW2J4bujABd0nif11HRMEEc1A
Message-ID: <CAKmqyKM0aBzpg2E8h+HziPDTL2sDQSNdu2aZfhPfhRiFw1gf+g@mail.gmail.com>
Subject: Re: [PATCH-for-11.1 1/8] accel/kvm: Include missing 'exec/vaddr.h'
 header
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Eric Farman <farman@linux.ibm.com>, 
 Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, kvm@vger.kernel.org, 
 Peter Maydell <peter.maydell@linaro.org>, Huacai Chen <chenhuacai@kernel.org>,
 qemu-riscv@nongnu.org, 
 Alexander Graf <agraf@csgraf.de>, Pedro Barbuda <pbarbuda@microsoft.com>,
 Anton Johansson <anjo@rev.ng>, 
 Song Gao <gaosong@loongson.cn>, Weiwei Li <liwei1518@gmail.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org, 
 Chao Liu <chao.liu.zevorn@gmail.com>, Bibo Mao <maobibo@loongson.cn>,
 qemu-arm@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, 
 Zhao Liu <zhao1.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Apr 2, 2026 at 6:18=E2=80=AFAM Philippe Mathieu-Daud=C3=A9 <philmd@=
linaro.org> wrote:
>
> Commit b67be03e3ac ("accel/kvm: Widen pc/saved_insn for
> kvm_sw_breakpoint") used the vaddr type in the kvm_sw_breakpoint
> structure but forgot to include the header defining it. Do it
> now in order to avoid when refactoring unrelated headers:
>
>   include/system/kvm.h:404:5: error: unknown type name 'vaddr'
>     404 |     vaddr pc;
>         |     ^~~~~
>   include/system/kvm.h:405:5: error: unknown type name 'vaddr'
>     405 |     vaddr saved_insn;
>         |     ^~~~~
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  include/system/kvm.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/system/kvm.h b/include/system/kvm.h
> index 5fa33eddda3..12f7fc8fb58 100644
> --- a/include/system/kvm.h
> +++ b/include/system/kvm.h
> @@ -17,6 +17,7 @@
>  #define QEMU_KVM_H
>
>  #include "exec/memattrs.h"
> +#include "exec/vaddr.h"
>  #include "qemu/accel.h"
>  #include "qom/object.h"
>
> --
> 2.53.0
>
>

