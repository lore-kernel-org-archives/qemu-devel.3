Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C653C4452B
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 02:39:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmMqv-0001uT-Dm; Tue, 21 Jul 2026 22:38:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wmMqt-0001t3-ED
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 22:38:31 -0400
Received: from mail-pj2-x04.google.com ([2607:f8b0:4864:39::4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wmMqr-0007Ac-W7
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 22:38:31 -0400
Received: by mail-pj2-x04.google.com with SMTP id
 d9443c01a7336-2cc80544c74so28346495ad.0
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 19:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784687907; x=1785292707; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=QISwBCs4sD2mmFmOUbcVxlXxJtN6pCFSLWlNjTB7PfM=;
 b=AdRadO+1W4jsXxz+jWKuDmk33humW2/JUtLba+4r+tK9FL9jbu25j9Z+uqt0pc2Ayr
 4mIujz9OWui+eTn42Dso1itzX7uMS78QrWSl/vq90stt1wqjztv3Q0JfWZjz7RJsufa2
 Kjy/zeSrwgp7rBYTW05SGXVGy4tjIGv5jnIrmmTQg/+J3HnXsrgg/L8jc6InJUy0uu28
 4GU6vWCRBUz2FfKUkOTg+X0EpNdWWemSwnwfA0NGk7nDaRhoJPnDkNyFW9anhbZxpY7W
 bHuq9SioVcIyoDPE3P80HTQRXCG/Y3yVsa71l8PweHgOXSbfE9GATXiKKxB4TeRw2Inj
 BeFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784687907; x=1785292707;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QISwBCs4sD2mmFmOUbcVxlXxJtN6pCFSLWlNjTB7PfM=;
 b=MUmEL+cfEQSSBhl9yS1utDwcqvp+FoYye/sB9YpS5t0O3x0AcnGsq+qCZqy/RGMkLt
 rY/0nxc/j7XzQ0fnt7OVkG+i/4G+LHR2bKlNTsgt/WJ/0if6F+bS9qVJFgND4jVW4F81
 91D5MzkkS5TeGCQSrMgdhJ2z2rmVufM3xChCWvUQC6hwLkSJnqCw1cSt1v0HCaLd2A93
 7TMwc93IRXIKhOojZNjCfXmriv7ivMLRYCPRmLEOG1HcxN2q0oSJ86py/ZibDHIn8lB5
 aAZtYlux4lUnbnQ+QTXUrOoAV/3p25FD858TSd0ITCchbHr9PnPqjjVpQKwAXSFIzTQO
 S7lQ==
X-Gm-Message-State: AOJu0YwShzFRCW5McM3XdVg/nmWRw2NjIL1MCa76Ezemt8HuvrsqYEUp
 J/lhMMOlMX/micPcjRwunFb9I8QpRuKUwOJfv8HFj7Bub+aynYF/+HoM
X-Gm-Gg: AR+sD120Su0avHsPV6EPLXn23nw4/+qU8KAwCh0TGVTyC2NQgZNZhET7pVddNEleHPf
 Lal3zE6RRm3hKEF/EudEJxLBqxtv1OYqXJNbZgHp2U4wP+JQwqslk0mjPPdH7oOphWPlAYAdZkh
 oPonORTBMr11CPY8sU8UTLuu9lCPXxnh9m8oXiDCPAho1WBXLKu/kM+4fyP8eaDs+hiY+/nm+cE
 M1178W3ENvODcQUF0mn2PHE9tMTis+ZnaxW4rEPB8Eikj46PPg1wUIeJx3GoI+yLg6T3rDdZ0wg
 eeZNo4QvFdogADrkqQXg0UkM/xUvYVdoNoDzOTvke4n/7aYETQ2vm32wUkDwgvOzE32nVaSBZrc
 kuHLkB6yc7dakS7u5l/c1lp/SlEhh5M7IhAnEkYAhEFqqmusvO3rEYWPtlhv3eKyV+ZBxcj5CPY
 ieKIqBnhNAKdb1Flp/bW699dt3PMaZs+5ss8bLijbd
X-Received: by 2002:a05:6a21:7008:b0:3bf:a0e5:999f with SMTP id
 adf61e73a8af0-3c3ad7a439fmr23727951637.22.1784687907302; 
 Tue, 21 Jul 2026 19:38:27 -0700 (PDT)
Received: from localhost ([179.255.148.148]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3147dc1b99esm3508104eec.3.2026.07.21.19.38.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 19:38:26 -0700 (PDT)
Date: Wed, 22 Jul 2026 10:38:23 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Max Chou <max.chou@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>, 
 Peter Maydell <peter.maydell@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v6 1/9] fpu: Fix biased exponent write in
 parts_float_to_e5m2 saturate path
Message-ID: <amAtFXK9m1LXFPM-@ChaodeMacBook-Pro.local>
References: <20260708161859.1124848-1-max.chou@sifive.com>
 <20260708161859.1124848-2-max.chou@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708161859.1124848-2-max.chou@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:39::4;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-pj2-x04.google.com
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

On Thu, Jul 09, 2026 at 12:18:51AM +0800, Max Chou wrote:
> FloatParts64.exp holds an unbiased exponent. Subtract exp_bias to store
> the unbiased equivalent of the max-normal biased exponent.
> 
> Fixes: d8be49537658 ("fpu: Add conversion routines for OCP FP8 E5M2")
> Signed-off-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>

Thanks,
Chao

> ---
>  fpu/softfloat.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fpu/softfloat.c b/fpu/softfloat.c
> index bc244a44ff..e2e53c1d68 100644
> --- a/fpu/softfloat.c
> +++ b/fpu/softfloat.c
> @@ -2435,7 +2435,8 @@ static void parts_float_to_e5m2(FloatParts64 *a, float_status *s, bool saturate)
>          /* Per OCP, conversion in SATURATE mode bounds Inf to MAX. */
>          if (saturate) {
>              a->cls = float_class_normal;
> -            a->exp = float8_e5m2_params.exp_max - 1;
> +            a->exp = (float8_e5m2_params.exp_max - 1 -
> +                float8_e5m2_params.exp_bias);
>              a->frac = MAKE_64BIT_MASK(float8_e5m2_params.frac_shift,
>                                        float8_e5m2_params.frac_size + 1);
>          }
> -- 
> 2.55.0
> 

