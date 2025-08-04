Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7AC8C87FDA
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 03:18:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uili8-0007up-8S; Sun, 03 Aug 2025 23:18:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangrui@loongson.cn>)
 id 1uilhr-0007rU-BD
 for qemu-devel@nongnu.org; Sun, 03 Aug 2025 23:17:48 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wangrui@loongson.cn>) id 1uilhn-0001bp-OW
 for qemu-devel@nongnu.org; Sun, 03 Aug 2025 23:17:46 -0400
Received: from loongson.cn (unknown [209.85.128.172])
 by gateway (Coremail) with SMTP id _____8BxnnNOJpBoGRo4AQ--.9728S3;
 Mon, 04 Aug 2025 11:17:35 +0800 (CST)
Received: from mail-yw1-f172.google.com (unknown [209.85.128.172])
 by front1 (Coremail) with SMTP id qMiowJAxE+RIJpBowPE0AA--.64046S3;
 Mon, 04 Aug 2025 11:17:29 +0800 (CST)
Received: by mail-yw1-f172.google.com with SMTP id
 00721157ae682-71b71a8d5f0so27206667b3.3
 for <qemu-devel@nongnu.org>; Sun, 03 Aug 2025 20:17:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCU0eTWnOKPZ6jtVR8NB+tH6KjN4V7/tZN8Eq+X0gS3M5V5oK1KhdKt8dwfkWHTo2q3YEI0yho/gRzwP@nongnu.org
X-Gm-Message-State: AOJu0YzzqYTPA6iopbvKwJHMai3cMf/PiwkCQcwnNQWlP0kdAc0GlYoN
 GUsSkrESM3ISIJaqIaJqnwW59fYGxSTbzGmNo1cHJA+zFkaJXStiZxerxg0DL47hmSmkRDtDLS9
 r5TWdvAap84AxbDmcpADOnnZ15oLkeQeZcrT7d9jiAQ==
X-Google-Smtp-Source: AGHT+IHTrFMR7ZDhjyBTmIEcRv0+Y6NNt3wBRmulokuMJc5p5bhLk4iqn5PYhEy1vwY/sZLyyLlMB4VanbhBV1yDTek=
X-Received: by 2002:a05:690c:6893:b0:71b:9483:56b5 with SMTP id
 00721157ae682-71b948356e5mr42648647b3.30.1754277447621; Sun, 03 Aug 2025
 20:17:27 -0700 (PDT)
MIME-Version: 1.0
References: <20250804023206.1306413-1-wangrui@loongson.cn>
In-Reply-To: <20250804023206.1306413-1-wangrui@loongson.cn>
From: WANG Rui <wangrui@loongson.cn>
Date: Mon, 4 Aug 2025 11:17:16 +0800
X-Gmail-Original-Message-ID: <CAHirt9hZ20=UD+e2S0+hHAG+0+qojpu2=3974JTQAzSOf0iEAg@mail.gmail.com>
X-Gm-Features: Ac12FXyNErktsJIf20PRORqcnYoSeyQE4VmBQSUm5-6HxMBsIF_DPF168VJRUHs
Message-ID: <CAHirt9hZ20=UD+e2S0+hHAG+0+qojpu2=3974JTQAzSOf0iEAg@mail.gmail.com>
Subject: Re: [PATCH] target/loongarch: Fix [X]VLDI raising exception
 incorrectly
To: gaosong <gaosong@loongson.cn>, bibo mao <maobibo@loongson.cn>
Cc: Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, qemu@hev.cc, Zhou Qiankang <wszqkzqk@qq.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID: qMiowJAxE+RIJpBowPE0AA--.64046S3
X-CM-SenderInfo: pzdqw2txl6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Zw13JrWkWF4DGw4ftF4rXrc_yoW8WF1rpr
 1akr1jkrWrtFWfZr9Ivw4UtF13G3yrKa1IgFn3t3WfArZ3Jw1kKF48KFZFyF17AFWUur4j
 9F4Fy3ZxWa1jvacCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
 AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
 JVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
 8JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r1Y
 6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7
 AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE
 2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcV
 C2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73
 UjIFyTuYvjxU7QzVUUUUU
Received-SPF: pass client-ip=114.242.206.163; envelope-from=wangrui@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi folks,

On Mon, Aug 4, 2025 at 10:31=E2=80=AFAM WANG Rui <wangrui@loongson.cn> wrot=
e:
>
> According to the specification, [X]VLDI should trigger an invalid instruc=
tion
> exception only when Bit[12] is 1 and Bit[11:8] > 12. This patch fixes an =
issue
> where an exception was incorrectly raised even when Bit[12] was 0.
>
> Test case:
>
> ```
>     .global main
> main:
>     vldi    $vr0, 3328
>     ret
> ```
>
> Reported-by: Zhou Qiankang <wszqkzqk@qq.com>
> Signed-off-by: WANG Rui <wangrui@loongson.cn>
> ---
>  target/loongarch/tcg/insn_trans/trans_vec.c.inc | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/target/loongarch/tcg/insn_trans/trans_vec.c.inc b/target/loo=
ngarch/tcg/insn_trans/trans_vec.c.inc
> index 78730029cb..ee10a9ebe1 100644
> --- a/target/loongarch/tcg/insn_trans/trans_vec.c.inc
> +++ b/target/loongarch/tcg/insn_trans/trans_vec.c.inc
> @@ -3585,11 +3585,6 @@ static bool gen_vldi(DisasContext *ctx, arg_vldi *=
a, uint32_t oprsz)
>      int sel, vece;
>      uint64_t value;
>
> -    if (!check_valid_vldi_mode(a)) {
> -        generate_exception(ctx, EXCCODE_INE);
> -        return true;
> -    }

Should the INE exception be prioritized over the [A]SXD exception in this c=
ase?

- Rui

> -
>      if (!check_vec(ctx, oprsz)) {
>          return true;
>      }
> @@ -3597,6 +3592,11 @@ static bool gen_vldi(DisasContext *ctx, arg_vldi *=
a, uint32_t oprsz)
>      sel =3D (a->imm >> 12) & 0x1;
>
>      if (sel) {
> +        if (!check_valid_vldi_mode(a)) {
> +            generate_exception(ctx, EXCCODE_INE);
> +            return true;
> +        }
> +
>          value =3D vldi_get_value(ctx, a->imm);
>          vece =3D MO_64;
>      } else {
> --
> 2.50.1
>


