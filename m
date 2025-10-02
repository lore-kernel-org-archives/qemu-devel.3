Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39281CAC5B8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 07:39:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4Dr6-00053J-KH; Thu, 02 Oct 2025 03:36:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1v4Dr4-00051v-Sb
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 03:35:58 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1v4Dqx-00006k-7f
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 03:35:58 -0400
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-36d77ae9de5so6582181fa.2
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 00:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759390537; x=1759995337; darn=nongnu.org;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=iK4XSnl7Qi7rwSVgReGqadwCrJsPpJaxbIbu3FYVy64=;
 b=VCYgOBLJ/nAK0o8PzJoZOA5UVN4zmdxp6cehk1D4jsnPiw5F2IQnzz669OO7gkRFA1
 NDnlVDigxoNg/tiSUHwyyKed3pPp7N6aQayky+1nIKjl/wiGNYu7nLiqAww3TciSv1VZ
 LZcpLya7vZSSxxdaluyfwdEQUTJ2UrXUI86D86QIuLqKa6KnXShKHHXivsJ2hN5cMrMN
 7lMHnHZyKtfQW0wFsnWnQDYkSjHRU9SsDTZaBkfLlulJmsj4tkGXDfcXrFgs3o1brd0O
 ugjEECMENvrd72Lvehfjujsm5esHwiA7nhruZv91Na+qMlD8nEa8DcOkUCtLP5Stc4JM
 osTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759390537; x=1759995337;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iK4XSnl7Qi7rwSVgReGqadwCrJsPpJaxbIbu3FYVy64=;
 b=g9F1X4PKMMukx/OvVtRllFK0e0QvaCFRulQ6kcqETLjy9BRteCABn4r+TnF3b7SeG2
 /Lea7oUOjhXX5qkt9CAMfLPQWWRDZxNhll9EfonsiB5msKlZX4LCRotS8FjG2KXPn2wB
 ezuZ5xDY1I4dc8X6moCqpsWr2RYPPvmmJOdh8ff6EBvv/JqhC/cbgL6EBw97uz1xHufK
 8hsiIhsUGHwRkUykYauP80UJZ191QQBNgvsaVBhmgOSXqqrfQBTJzo2nmxfamJ7TsqhK
 wvCFHhc2icEZlaEv+i3A23OSembEzfURc519X1uz0VeVbjCDgt+xRxCVDTm0ir5FNzKz
 m7Dg==
X-Gm-Message-State: AOJu0Yx60RSPpUkve/ItrAVWZeirHcJ4jnCHyo5CinjMgT9Qog8ZTqCz
 E5btH+0wU3aDLmmrvm1uVnilncjaE/ohLUn+Bo09Sq1WpRlsmQx9Iqsq
X-Gm-Gg: ASbGncvDYRdlMlXaiJ2QTFqYZ0Tzj0L02DPGdtlXp3HgdCnW3JAhXClY7uuJH0tq3AN
 79zELaO1CJyg538ncI9H/MFhhJEYRmdftP8Ly8ptjUZwIZEoWfSOUkBX6MxArjKqnyXoFQgQGy3
 b61EhFnnqw+0IVzJ8DETjDxaL45rAkKsnzqJ4Roh6E5T+KrTXBURCyZL36SofhqNavDr4ZYu1iB
 IZtGTWH8ZqwTuSJrcVoMxTfZ1KhugcW+nerSjNEKX1kr4xC1otYaDe+qDzhyprpGRmEEaPiiXKT
 4hb+btmqyThvYGswk9r/aiDM2LCxhynstCeZniJ/1pkaDGyfI0dZubQJKlz+3H7Rp8lXyh4AjKz
 +hvZlUcmjIXbjovz4ixK4ONngyzOT2r4eJ2PCUywxPKlRKqWGQCPI9wVzLs1E0+mAnVQjtgj4ZH
 TyIaxvPEE=
X-Google-Smtp-Source: AGHT+IFELBXdmxX6nofW16abjULCE4Vwtz1hkiOUhR4O7R/GXiOqjZnz0BxdVeBlUoRQ2HXAdQDFcA==
X-Received: by 2002:a05:651c:2208:b0:36a:297a:7d73 with SMTP id
 38308e7fff4ca-373a7361d0dmr18536521fa.5.1759390537064; 
 Thu, 02 Oct 2025 00:35:37 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-373ba4cbd6bsm4730661fa.48.2025.10.02.00.35.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Oct 2025 00:35:36 -0700 (PDT)
Date: Thu, 2 Oct 2025 09:35:33 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: =?iso-8859-1?Q?Cl=E9ment?= Chigot <chigot@adacore.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org,
 alistair@alistair23.me
Subject: Re: [PATCH 2/3] hw/arm/xlnx-zynqmp: introduce helper to compute RPU
 number
Message-ID: <aN4rRXnFX-Qj5CoR@zapote>
References: <20250930115718.437100-1-chigot@adacore.com>
 <20250930115718.437100-3-chigot@adacore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250930115718.437100-3-chigot@adacore.com>
User-Agent: Mutt/2.2.14+84 (2efcabc4) (2025-03-23)
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x22b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Tue, Sep 30, 2025 at 01:57:17PM +0200, Clément Chigot wrote:
> This helper will avoid repeating the MIN/MAX formula everytime the
> number of RPUs available is requested.
> 
> Signed-off-by: Clément Chigot <chigot@adacore.com>

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>



> ---
>  hw/arm/xlnx-zynqmp.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
> index d7adc070f8..3d8c46986e 100644
> --- a/hw/arm/xlnx-zynqmp.c
> +++ b/hw/arm/xlnx-zynqmp.c
> @@ -207,14 +207,23 @@ static inline int arm_gic_ppi_index(int cpu_nr, int ppi_index)
>      return XLNX_ZYNQMP_GIC_NUM_SPI_INTR + cpu_nr * GIC_INTERNAL + ppi_index;
>  }
>  
> +static unsigned int xlnx_zynqmp_get_rpu_number(MachineState *ms)
> +{
> +    /*
> +     * RPUs will be created only if "-smp" is higher than the maximum
> +     * of APUs. Round it up to 0 to avoid dealing with negative values.
> +     */
> +    return MAX(0, MIN((int)(ms->smp.cpus - XLNX_ZYNQMP_NUM_APU_CPUS),
> +                      XLNX_ZYNQMP_NUM_RPU_CPUS));
> +}
> +
>  static void xlnx_zynqmp_create_rpu(MachineState *ms, XlnxZynqMPState *s,
>                                     const char *boot_cpu, Error **errp)
>  {
>      int i;
> -    int num_rpus = MIN((int)(ms->smp.cpus - XLNX_ZYNQMP_NUM_APU_CPUS),
> -                       XLNX_ZYNQMP_NUM_RPU_CPUS);
> +    int num_rpus = xlnx_zynqmp_get_rpu_number(ms);
>  
> -    if (num_rpus <= 0) {
> +    if (!num_rpus) {
>          /* Don't create rpu-cluster object if there's nothing to put in it */
>          return;
>      }
> -- 
> 2.34.1
> 

