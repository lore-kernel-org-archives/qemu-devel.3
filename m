Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44EE4CCF9E3
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 01:59:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEePE-0002S8-4x; Thu, 30 Oct 2025 21:58:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vEePC-0002Ru-5a
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 21:58:18 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vEeP4-0003mq-92
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 21:58:16 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-64071184811so2024131a12.0
 for <qemu-devel@nongnu.org>; Thu, 30 Oct 2025 18:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761875883; x=1762480683; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YMu75Eww6+M90cGczeaGx/YkQkfHL7Zpz3XT6FysGYY=;
 b=PbFxq9UX8gOtDjHgil5rudKK22VBTPgw4mRYcsWJLcT9HOOQS1xCh3pFPzmpPo9N9D
 +3d0tzeuWLBQdxbPuk5Wb3wlR4i/2IW/s1oNa2bYRtmL2RNR5kqnqHw6Pr235tp5LQ//
 f/SqcxEsxw7ZYJCFJlJWq7j8XJLVHXOcOjI+IXJRlqmjvsppYx2i/gvUt2oUZ/+RDR6U
 2YTQZCeliynLtU5UxXtHA5HB4xSRECGl2YeS90wMbrkXG3Y6dr3bgBH79cNIsRnpo51Q
 a5vHAprG0ECdTOmdkzUfd3+VzHqNx43k6lyB1l3R+snzhu4wui1oz6j39XxjckdZMrv4
 y7Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761875883; x=1762480683;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YMu75Eww6+M90cGczeaGx/YkQkfHL7Zpz3XT6FysGYY=;
 b=FLLJUHkg+FSiI9TN8rE0pbWxIZD/R1aJILQItCUO3TLuGjrS9Fr6WKLLWtEFta6gq9
 XmTyZHN0iQKailpgg2CvzaauVuhb8y1r86Clfv2uROTPDFV7RaGL6XXrz2xYx1QazdpL
 JbQZCMaYvzImk3erxAUqp+k12jw8g9gQ30otOOW34OjUysW4KSv7bsKRc6GN0nFnpN/Q
 Lfh72nMJ/47yBL9FdZfd+yyk4z2MQPGo4gsYHzWPrtMbCL3U1pw6NGTyX+l+gCoU1hzg
 YG3a/3egr6/Ub0KbwA82Vmo0x2RjHe8tgCwwfiaEggJyP9Xkg7noGgUPrLUmmEOiquDu
 DoWQ==
X-Gm-Message-State: AOJu0YzZ1MbjI2AaFlkSdGLO/cDOX2s9WAbS8z6rzb5LyrqTmda7WH+U
 pSHkiYxBWEbrKWy+qV2qMrdbXVFfCqSpczXvkVAQEtxRV0gLuzH1Rp39ctu+84FYzOCtfs2s5pS
 PT0V2la5UwS/EMddHgN01tUvQrn6Hcxo=
X-Gm-Gg: ASbGncsYqqQ6OhcWKnz+6nC8y1jQ0uCQmLj7WEOxJuoDDKALSrCV9WaQQgksCfPiO7c
 +zZguQt//0sgxMhPMxVxMktOR046Z1AGXBxvQEVMpL52/byGeBc+HmPLuP/UTtEPGVYa9Cg8nFc
 iYjzDkmPuJTI8t/vPobS5oSZ9tCpHZNWh+gBgIn05oVBmGIydv/x0Cu68nO7QlTv659WSxO4CbR
 kfD32bpajUzsqAmUuf1rrUty/MfxBMFZACi+yjjNYY07UxQjBtERVV9O5udEjxBosv5Eht6boZz
 GOchNf3GEwo7fhg=
X-Google-Smtp-Source: AGHT+IGbfmcTJKApPj/Y9pwW+CLhSdqbV68q6VtT+Ki+rSXlSpDcqiuC5Qy4YCg4EoEfOQrkwO4L95khvbYdUXDC4QM=
X-Received: by 2002:a05:6402:42c8:b0:63c:4d42:993f with SMTP id
 4fb4d7f45d1cf-64076f6c06bmr1284938a12.3.1761875882580; Thu, 30 Oct 2025
 18:58:02 -0700 (PDT)
MIME-Version: 1.0
References: <20251027181831.27016-1-anjo@rev.ng>
 <20251027181831.27016-19-anjo@rev.ng>
In-Reply-To: <20251027181831.27016-19-anjo@rev.ng>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 31 Oct 2025 11:57:35 +1000
X-Gm-Features: AWmQ_bklK0YSkv2TQbsLwabO9D6VQ02EIdfd-dnhqvKX4Humketcppb-ZzXe4HA
Message-ID: <CAKmqyKMRce_LOYDG_5C2xvxa1LPQsDg0u3ZzXJKkJZ=KNd_6uQ@mail.gmail.com>
Subject: Re: [PATCH v4 18/33] target/riscv: Fix size of excp_uw2
To: Anton Johansson <anjo@rev.ng>
Cc: qemu-devel@nongnu.org, pierrick.bouvier@linaro.org, philmd@linaro.org, 
 alistair.francis@wdc.com, palmer@dabbelt.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Tue, Oct 28, 2025 at 4:25=E2=80=AFAM Anton Johansson via
<qemu-devel@nongnu.org> wrote:
>
> Fix to 64 bits to match size of instruction start words.
>
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 1e4128128b..f901608d0e 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -258,7 +258,7 @@ struct CPUArchState {
>      /* shadow stack register for zicfiss extension */
>      uint64_t ssp;
>      /* env place holder for extra word 2 during unwind */
> -    target_ulong excp_uw2;
> +    uint64_t excp_uw2;
>      /* sw check code for sw check exception */
>      target_ulong sw_check_code;
>  #ifdef CONFIG_USER_ONLY
> --
> 2.51.0
>
>

