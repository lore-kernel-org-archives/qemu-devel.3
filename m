Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7AFF109E530
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 02:07:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5a8C-0005tj-IU; Wed, 25 Mar 2026 22:07:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w5a8A-0005rY-Dj
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 22:07:30 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w5a88-0007sk-Qe
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 22:07:30 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-668e55bd36bso513842a12.3
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 19:07:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774490845; cv=none;
 d=google.com; s=arc-20240605;
 b=byB/9FhUtotWtIHdwgGegG/X9NHEeaug/59N+x6/Pz30rVBIe55g8FOdzY/k+4c/fr
 2eFCsTjCgG5t3qQCNw50chgpjfzkYHD28lVYStSojBUzyOEzVi2q+F8JvWJFGK4viEvw
 XV5UGomvNTAzLdwLPJAGSvFt1rMKiD8cmEpevUgJmAhL/p8FnYIasWzQUvztV4nVaQSz
 s04BK9SgOW9Cf6wh47pw0hQIa/KoP5KOf28zpqRxz6hQ3o3Y4KCFRw7o1WQCafQmzAez
 JcR/aqHONVMS/tFztLM7/pUlJ1vdFawrVQ6+CWgrToTunkpcVst9Jchn+R/x8a9Kg1yW
 DTRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=N6jUDbhQuX9TsYYJpdTlv2DdFgf4Vdbf7ZqtQOQ9M8A=;
 fh=0bIOm+75pw/QTN9FDs8ZhfYo0XBcsOIKWWC6mti+rTw=;
 b=ggTpLfRNqZroKjK0oWl/kU+o4IrVci6jSOvyLXSCoX+vRkuXANo+WXwqinBfEGpeHd
 PDFdgziYxDvkWXPNzo+yExxOG/ilhqTrzNSib0vxgJX9h8Eb+EBMrHwzBq3RJtlomeub
 TEpDJAnql5q9Vb77CLex1GMvvxTk3pBIFmC6ANsghXyMSWBp/oAcsRDBvYHfC8kaN74h
 XVqlksw+DA5LDySPJu+us4q2NTJ0mBgeJzfRMEE7a9Pq9OrZtswMlD/rQiPCsPS7Gtco
 F+Gs+1h1b21IAnXpOKvT9ZLEF5MHdUdWzFKNdq0RWDaFPcuNk9NVCQVCQL11ptiU204i
 EG9A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774490845; x=1775095645; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N6jUDbhQuX9TsYYJpdTlv2DdFgf4Vdbf7ZqtQOQ9M8A=;
 b=J4+XJaH1v1wBX41W/K4q5qViyN55ZMOgdoThNjY9KMporXtPlqUn8kvCaFXLFfyUr1
 QGju+CFrNPXve+AHt3+hPLuFzlUTJiTyZyay47R8Dda9fv9/ualJuZMFYEnoRKN7Lbvb
 lrWJ4Kk9pitqPmLvEIJgMRCxHz4TsbmvVkjskpMNGKL7PZk8i3QbgkUbHscBBhCLyPxj
 ikRlhVgMnU5uDGq6G+usAhkt8VCyq2d4OCJCE791QARqf1Rq2E4WLop+QypG+7mEj+gb
 q2P01/5+vvR6kgAa5pttoM59/ken5HtJYE8KRkzxQPnkHOOVI0/VZFBV6iAiPV9q9hIo
 hK2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774490845; x=1775095645;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=N6jUDbhQuX9TsYYJpdTlv2DdFgf4Vdbf7ZqtQOQ9M8A=;
 b=iqtWmtkKUuGugIZsw06tiHfF3txlZvqxeyaCHlwiy6KdswObtCUIQGnI2Iy3VTTmep
 Q9NZ+HU+9qeCs732SIaz+T1chZD+eXcfj9TW+WU8mTqn9aXtwGIJDM90BEW2QyOnVnSF
 +SUquVqKdhAl4RwggDq4bzFXdQoGhCn+EnS9VJJyfGSrwDUKobFsLlX2QFEseULtzaxy
 zO+3w8Y5GZcyFW7vHosEVHIbHlToz9wOwfY6B4ZclhGyi9HJoSA3xeCSoC9Z3tSKbZne
 r0R59EKlQG5OdvIK/2srQyzxjFOItjlVGzc1hP76rrblABj3fUc7DqiugeJDrkhPIpaK
 7ozQ==
X-Gm-Message-State: AOJu0Yzuu+ANdx9Bqi7HsxhtCQy0OWHo/pRggq+gWRu/835QR+NymThT
 Uw9m14DTX2j+EPyfbcew9aufokKAb9HLx7PhQNVLBGTn8a+PIZUHkA3DmXJFbUVfJXUevRzjUVc
 YcBwPzRzjZzB8cySrKeLotQk+aEOicSE=
X-Gm-Gg: ATEYQzwAGnNY5PBbfHFPuiRtIUl/f3arXRk/2VhjEOLQFiotMtXGioCz5LJiaegiNFG
 S6PmIf03scRnLyOzRNiXtBtq1+2e6CRLmawVPjTp812B8wZq8SNJ/P7Y10w66PYja8ORQoPvcIG
 AOfSCu8/D+cPhbQyTxIls5h38aecsMKttCZpZXP0ztrEjgSfSJfj31cyfNf6gez2TCflvxwS4E5
 3qcdqA9IlrBVt5P3NGw2kByDSFfuii4wQIrOjIuukcHAW3nJ6SLg6VMQ5KuJqSi9o4WrnNRYPuM
 p36EXHXCRgF4gGaMJm4pBBnT5JhGWY5FaEk/wg==
X-Received: by 2002:a17:906:eecd:b0:b8f:e98b:4952 with SMTP id
 a640c23a62f3a-b9a5426c31fmr336789166b.41.1774490845054; Wed, 25 Mar 2026
 19:07:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260318103122.97244-1-philmd@linaro.org>
 <20260318103122.97244-5-philmd@linaro.org>
In-Reply-To: <20260318103122.97244-5-philmd@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 26 Mar 2026 12:06:58 +1000
X-Gm-Features: AQROBzDqkRvqjsyg9ydAZWA1CPaFO1AgTbOKLM_NsVXS-sMwVkhcvv1n3FhiZuE
Message-ID: <CAKmqyKN_BSB-n5CJnniFkB+YXdrY6BuRbsZee9ity3v_vD64GQ@mail.gmail.com>
Subject: Re: [PATCH-for-11.1 04/16] target/riscv: Remove MTTCG check for
 x-rv128 CPU model
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Weiwei Li <liwei1518@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Warner Losh <imp@bsdimp.com>, 
 =?UTF-8?B?RnLDqWTDqXJpYyBQw6l0cm90?= <frederic.petrot@univ-grenoble-alpes.fr>, 
 Vijai Kumar K <vijai@behindbytes.com>, Anton Johansson <anjo@rev.ng>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-riscv@nongnu.org, 
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x530.google.com
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

On Wed, Mar 18, 2026 at 8:33=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> From: Fr=C3=A9d=C3=A9ric P=C3=A9trot <frederic.petrot@univ-grenoble-alpes=
.fr>
>
> We had to check that mttcg was not used when executing QEMU with
> -cpu x-rv128 as a single 128-bit access was done as two distinct
> 64-bit accesses.
> Now that we use the 128-bit ld/st that access the data atomically,
> this check is no longer necessary.
>
> Signed-off-by: Fr=C3=A9d=C3=A9ric P=C3=A9trot <frederic.petrot@univ-greno=
ble-alpes.fr>
> Message-ID: <20260101181442.2489496-3-frederic.petrot@univ-grenoble-alpes=
.fr>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/tcg/tcg-cpu.c | 10 ----------
>  1 file changed, 10 deletions(-)
>
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 988b2d905f5..3407191c224 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -1305,16 +1305,6 @@ static bool riscv_tcg_cpu_realize(CPUState *cs, Er=
ror **errp)
>      }
>
>  #ifndef CONFIG_USER_ONLY
> -    RISCVCPUClass *mcc =3D RISCV_CPU_GET_CLASS(cpu);
> -
> -    if (mcc->def->misa_mxl_max >=3D MXL_RV128 && qemu_tcg_mttcg_enabled(=
)) {
> -        /* Missing 128-bit aligned atomics */
> -        error_setg(errp,
> -                   "128-bit RISC-V currently does not work with Multi "
> -                   "Threaded TCG. Please use: -accel tcg,thread=3Dsingle=
");
> -        return false;
> -    }
> -
>      CPURISCVState *env =3D &cpu->env;
>
>      tcg_cflags_set(CPU(cs), CF_PCREL);
> --
> 2.53.0
>
>

