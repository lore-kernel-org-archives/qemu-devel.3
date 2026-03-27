Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E53E10AB830
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 14:15:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w67xd-0001hs-Iw; Fri, 27 Mar 2026 10:14:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w67xc-0001hI-Iv
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 10:14:52 -0400
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w67xa-0006V9-2c
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 10:14:52 -0400
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-64ca423ad53so2142030d50.0
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 07:14:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774620889; cv=none;
 d=google.com; s=arc-20240605;
 b=VAql5/mpfaFG4wqGvyv8p2UjhYsgmkkcrfgW8/MUTm8yyycRfd7XO/qtZg5hyX2xCn
 s6r3TwWUWk5yKmLCyu7QXoXA2H2vDTYH7e7EeaX/u8wzdBSs8L9NUexqa7R2R/ChZWlN
 +oGzWkcoRRRp2BLvQYQBLCU+YRpg0pXT+2q/dCeohQgouWtJm89eKjeYkQPRwfReaoKd
 CkywDk6QiZc8O2RceQMAoJvt9UfCsy9HiK/jdGlQtZDsn/3ma9w84W8q4dpQ+3ehA61k
 6fbPPb7N9hWQ9kR3WyyOVJiq9P9scm+AD56+oTBhzJs4f19EP00oUQix2Jfzi1lZK2z1
 RRog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=C/ml6sj2ij7nuKX/I796QqZSws+/aq+hBHX9oGOjYsU=;
 fh=TtLYQyfjIL8eEMj471x//w2/iwo2ONcxjRvAmrUSEpA=;
 b=MK+sXf0rTBLh/q3+1WY3yy36CMb2StLGN9kDbWxKyHU/vfQg6s6q6IV1iviHlpMpxA
 q0jzcC3n7UGpKh65oOGvCGYUwTnUhdwKPs0J75N4zGTjA6OWXQHZWOXhhgExs0AyXHBt
 0xkEKbO/kozl3bM6e7bFlLkDPt5FsZZDWkjDuOeiQfSCFZ4AWIaaYkQbcAHo8F1THQ52
 KHbT8r5eUYtx/HlAha4WH5tT0xZSsIK5hD7pxrFcaJUY1wGP+4Ty0R63d3b5k6rt8ug7
 g6nfC1D0R5WZ/HutlqrHukmTng9Ajm/t26IzKHwh2Xn3MPfv5sV9T1kKac4bajiJCphN
 TjdA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774620889; x=1775225689; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=C/ml6sj2ij7nuKX/I796QqZSws+/aq+hBHX9oGOjYsU=;
 b=YymqzxT1YwNz/ht3w1oE1qoTJp3I/YcI2M9Z6lOPk4kwmeeskdfKIV0qnow22mgQBE
 C9ue6Oz91HhbWnqPEB9ffLlkbkFpGZQtSiTHb9FUY63y0X5FRmf2nBYumcUzSxXQENTs
 0MDwmMdOD5S14xk+MKgQYrdvwe1ASP4lU8lds5Mjx7+nCuHXsIJuXvILqaF0ygdzGI7T
 i9bMQ0KVqYP8WWFg6GHYdSHOearWdmAO1g0DHvYMrQzZKMa+ZGTt+dBXuryo6dQtza5A
 Y+PePl9D9+7p70sySenFPBZ96BT5meYzouRV3XjGQCTYVEeOOGU6L7uiqbXIGkl1aJC2
 HIUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774620889; x=1775225689;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C/ml6sj2ij7nuKX/I796QqZSws+/aq+hBHX9oGOjYsU=;
 b=DJx+2TVs7UPq7Gmh1vEreMMulE3NinYF31fTTP7dM/qbRwsGb07W73Ts9DVv4E9ZBT
 zucHM8hfJcajP82yv8FHNepj9AB5fewvY/AtiHIAL2JBUEgTyF5KZqHHZMo6TFV43QF7
 MDW5RQHivsVx49LWIozIcMayr5Tze13Hb7KyEiRINT7lxQVt5760xyq+o9fsZG0vwKvA
 5WaMELXMI0GV5wWiOIzyxI9S5qtZVGT1nYQ9Rotkg2lZFoLyjSvY+5Qlw448FIRNy8pw
 jvWIU914wClAi2gjtgcjqBT991mk2Xnq07koq/UVLkipsewalnjoegBp/uRhKM7qjqlx
 dLAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXsPtVLuB+yryj8KomwdtpqqL41dW79QfkdxedXrjdY7M+TrIbWEljNnTHdqGKvhZyRAMomE3Tk27h@nongnu.org
X-Gm-Message-State: AOJu0YwiQsk83S0IyTVSEAmRZ1j9oWMkDjX3ccahEFBq0kdmueljSgsC
 fTqtjNZVsQoqVxlLYhlsOvaVj0K2Pef5gWzO9iPSvq4Rq7FUh+ch5SNFzyTaV3oXD3fU7q+QdQ3
 9AgI8pkOiNOevBa5h+Khpg5MG+zZKXsP4e2KQ+T33WA==
X-Gm-Gg: ATEYQzwPivmx8g9Mbi/KPd301n7tR+JW/ha5eeSjkwcnzXsJ4APvPf5PRDSk2WPUAKy
 ENCK9KCEe/R0wZxk9YwGUrTwHnWn1PuaTz3ypK1rDV0oj6ZMehRg/MzKe/QZW6VJM3v6h0u/11g
 4Klps3Xne50/7hi3ooSqX6GnRgRKE+WwfJfQcYO4GmDxNxc6XYdsyBB7QHFb4WfKxDW8HeLGzbJ
 3M6tg/65KOA5DaO6XdoM8LlxvDI371s9ND51CwK4Aig2k3A4IPYM3BF6Z6Nuh4LUU8MC+XVDErh
 qOUf3pFT8BhzLSoo4YHvKHgxeQ0ZfPjWcJGNCpLhelFxTUk7ACxPO1zp6f8cLexDRGo=
X-Received: by 2002:a53:ebcc:0:b0:64d:600d:854d with SMTP id
 956f58d0204a3-64ff7404b19mr1981932d50.53.1774620888568; Fri, 27 Mar 2026
 07:14:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260327134401.270186-1-kkostiuk@redhat.com>
 <20260327134401.270186-6-kkostiuk@redhat.com>
In-Reply-To: <20260327134401.270186-6-kkostiuk@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Mar 2026 14:14:35 +0000
X-Gm-Features: AQROBzCi1095s2JAbhDfmDJVMDlI5ALR_3Uc637l3MuB9ZtNrrEgfitkidYRsAk
Message-ID: <CAFEAcA_MDAnHxX4SqdB8hvS3jJTOG3mYFZd912_61KPd0QgcBA@mail.gmail.com>
Subject: Re: [PATCH v2 05/15] hw/arm: Use glib2 instead of
 strcasecmp/strncasecmp
To: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 qemu-ppc@nongnu.org, kvm@vger.kernel.org, qemu-riscv@nongnu.org, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>, 
 Nicholas Piggin <npiggin@gmail.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12a.google.com
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

On Fri, 27 Mar 2026 at 13:44, Kostiantyn Kostiuk <kkostiuk@redhat.com> wrote:
>
> This is a change in semantics. g_ascii_strcasecmp() doesn't honour
> locale but strcasecmp() does. But this is OK for at least one reason:
>  (1) QEMU always runs with the C locale so there's not an actual
>      behaviour change here
>  (2) we want the comparison on boot names to be a plain ASCII
>      one, not to do weird things with "I" in Turkish locales,
>      so g_ascii_strcasecmp() is better as it's explicit about that
>
> Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
> ---
>  hw/arm/xilinx_zynq.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
> index d43f36b718..e3cfeb4c08 100644
> --- a/hw/arm/xilinx_zynq.c
> +++ b/hw/arm/xilinx_zynq.c
> @@ -186,13 +186,13 @@ static void zynq_set_boot_mode(Object *obj, const char *str,
>      ZynqMachineState *m = ZYNQ_MACHINE(obj);
>      uint8_t mode = 0;
>
> -    if (!strncasecmp(str, "qspi", 4)) {
> +    if (!g_ascii_strncasecmp(str, "qspi", 4)) {
>          mode = 1;
> -    } else if (!strncasecmp(str, "sd", 2)) {
> +    } else if (!g_ascii_strncasecmp(str, "sd", 2)) {
>          mode = 5;
> -    } else if (!strncasecmp(str, "nor", 3)) {
> +    } else if (!g_ascii_strncasecmp(str, "nor", 3)) {
>          mode = 2;
> -    } else if (!strncasecmp(str, "jtag", 4)) {
> +    } else if (!g_ascii_strncasecmp(str, "jtag", 4)) {
>          mode = 0;
>      } else {
>          error_setg(errp, "%s boot mode not supported", str);
> --
> 2.52.0

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

(I suspect this code really ought to be doing a strcasecmp,
because why would we want "-machine boot-mode=sdXYZZY" to
act like "-machine boot-mode=sd" ? But that's a separate bug.)

thanks
-- PMM

