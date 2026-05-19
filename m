Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02AA6CD4F57
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 09:58:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPHDC-0005LT-1P; Tue, 19 May 2026 05:58:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wPHDA-0005LL-Pb
 for qemu-devel@nongnu.org; Tue, 19 May 2026 05:58:04 -0400
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wPHD9-0000tV-B0
 for qemu-devel@nongnu.org; Tue, 19 May 2026 05:58:04 -0400
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-65c6a2158d3so2380286d50.3
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 02:58:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779184682; cv=none;
 d=google.com; s=arc-20240605;
 b=JMJGtvFgnl1aiIcb3+rQB5LdYzi7PZnwgDhbn/11uxgiod36zID1OaaVyumj0gqdsQ
 BddWpywTGglXxcaeDguO3A37q5oGry0fnXXkxkl7Tn/dpiEHCrKdBqgW7I246XmUera2
 3RYPlG9yA4uXlMaH90GtiFqXiHw6tIkPK+e/rD3D3gXC33u+YfXd03YMi/gwp4/aShoL
 gJowioLiu4me7Xow1Vu3KutZHWsXTNMQl4riqXgFms715G8Mlz+FXWqxhBGy+uab+Yid
 0DmQLrqtfbpoxnUAsO78JraT5EsZ91b5VrBDupLXcjvbJmHKTYDwI3rHlU+D3lS3BBF1
 E9ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Vj49m6GXllWJ3hKSXBhlJfr7cEZSDKGiNNG4XO6lpcs=;
 fh=GI2e/SBiq4MTIPc9mHou6R6WJe3VvhdDMWKbaXflkfU=;
 b=FWexkuo2+4UYu6W1ZYjg1GvbQT5qVFFtqunMmBqwuyTmh8ujuGhILo+fzN/FQilFpM
 gLlp0D8rZNhMyZ/3omyU06TrFnK+MyTxYSovE6Y3KrDPSktl9jvpBVcaYTIxa1iKBolB
 5Tw03vrGv5d3oi6WmONyf3qyquVbeNxTbK9r7RuimJm/djS6VNmE6WiR4XCkBKI0/XfZ
 1UiHDnO3PNRmc/qzyrfeRHC3VVbWqeAAmM58OjWvgk9qNdsR7UUMwLXNq9nZ2Sw6yKrO
 8sEN8VkocHJfiaHNhi7EM+pe4ggZU5Wqoq6oT39quXxFY0rAt+HWkYqWAvdBMo+RUz0/
 +2pw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779184682; x=1779789482; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Vj49m6GXllWJ3hKSXBhlJfr7cEZSDKGiNNG4XO6lpcs=;
 b=SpEac8WppoS4a4RgdiIayd9lnpf4JK9qBObznK+5tVpJnkj99U9o9GuRszk1tidf1N
 SfoVjYp6U3Njqkntot6MMqY/EBxYCxcVlnHWsOzsvtbkII8C11u5q8YnXVJFXyCXDxYW
 UuQY99rHHNSq/0Az1w0VPY3KUmIjyCZir5NjY/h8N82eYZ5FTjcHbsxdi3S7eEzIrtSa
 MFxw3FuOYAy1l05TYu96F0jy4jSarPQq3853bL02KDwZLAnzStLoC5SpOkmVMzQX0RRd
 9iUtyY/SMWVCh8pob8+mte5yydDHWUVGyf4YhXN1wuWkdKP8TcBrTrixzppzzy0KJqcN
 fiZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779184682; x=1779789482;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vj49m6GXllWJ3hKSXBhlJfr7cEZSDKGiNNG4XO6lpcs=;
 b=k5Wzy42vUmYAPAJ3RcFSSMrUsN2Ob5tbDbvV+nOC46BUD7VyaPdkPZPAS5Cnj3zhMD
 Pd/aK90CNCxZpMQz3J3KygGqPIHQM2QXtRrfgmR26g0ix/+Imen5w7kh+4j64sgnCr7H
 WxySc9xmYDLoxBFc4zoIpoWgooyk9tKD5gMXwIXAoB57qJQQTmzVcG8Q1zojpqr98qKd
 /YsKfF13no8/On6eRd4T3OvVIDj/RJckU5y525cIp/Sq7WrHFaSaDdXsQ70T2BKb1o+x
 BzUMzTZ3AZNa96ptdq+csDetp5TBl7JE4UW5xgN1RyOiZPyYYrJnSskKnLL6wPtHQG9q
 vH4Q==
X-Gm-Message-State: AOJu0YzSVN/ZCSAb2K2qFlnQsZ09iXIoB65rSkZkxm7ZLsbrTII/3U6D
 OhpEoFVG1E6uykAoCAf99KPbiIu3xv7IXzrnO5y7n3oEe3BgRezhbSTJ9AJ+iF4BrIDgljk5yPU
 zNeW6rhELXcepKrdaXF55Hme68AIgBk2lqRuhZwvuAQ==
X-Gm-Gg: Acq92OHNyux77+rtlnobGCzUtrUvAAczLXOyktcOEaHjwCcxhByw94/pKI0pcqkkTO3
 kQv/dMhgIn0XZ17pZrB/sE1lqKW7txTwZVfduf/QPPdDlRkzoof/cZe6NxV87OlFdRCsScBsLgY
 r/c5l59bCz0f3bJK/CnHO8vIz7ZRBgX4J54q+ACDIqYCeVTyZGA9u5YdpgwFpnvT0G8gDfRanTz
 LVSURwyG2zg0AcZAbyYlnPgukya3VHrkC6fVmK9VjeG+iJYHKYosC4Kf3mbg745gdLkuTx8/hx1
 0Hg4EhmAqXgXQXvLLVjqldNR2OYep7tyatH5s25vntO38f340F+K3i8v+F59Kll3U04=
X-Received: by 2002:a05:690e:1403:b0:65e:39d1:d9f4 with SMTP id
 956f58d0204a3-65e39d1e47amr12244582d50.9.1779184682217; Tue, 19 May 2026
 02:58:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260517002550.321291-1-richard.henderson@linaro.org>
 <20260517002550.321291-12-richard.henderson@linaro.org>
In-Reply-To: <20260517002550.321291-12-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 May 2026 10:57:51 +0100
X-Gm-Features: AVHnY4Lc2eJAnG3su9YlMUbDtCOEG1ngIzRqBCaAjq8nA9ylGvqVM1uIA7-g57I
Message-ID: <CAFEAcA9ni3_c83Ex+Oc73yTxvUm2GkF=CFcqf5gv4VhD3uTJ2A@mail.gmail.com>
Subject: Re: [PATCH v4 11/12] fpu: Saturate the exponent in uncanon_normal
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb132.google.com
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

On Sun, 17 May 2026 at 01:27, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Notice the conflict between saturation and rebias_overflow,
> which should never happen.  Otherwise, saturate to INT32_MAX
> and allow the usual overflow to max, infinity, or dnan.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  fpu/softfloat-parts.c.inc | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
> index 45606f8402..914e588ec8 100644
> --- a/fpu/softfloat-parts.c.inc
> +++ b/fpu/softfloat-parts.c.inc
> @@ -341,7 +341,17 @@ static void partsN(uncanon_normal)(FloatPartsN *p, float_status *s,
>          g_assert_not_reached();
>      }
>
> -    exp = p->exp + fmt->exp_bias;
> +    /* Because exp_bias is positive, we can only overflow past INT_MAX. */
> +    if (sadd32_overflow(p->exp, fmt->exp_bias, &exp)) {
> +        /*
> +         * rebias_overflow wants to compute a modulo exponent, which
> +         * conflicts with saturation.  That said, saturation can only
> +         * happen with scalbn, which is not a PowerPC operation.
> +         */
> +        assert(!s->rebias_overflow);
> +        exp = INT32_MAX;

As mentioned in the review comment on one of the Arm patches,
I think that if we set exp to INT32_MAX here then the
"round up" code below can increment it, overflowing to INT_MIN,
and then we won't correctly spot that it is too large for the format.

> +    }

thanks
-- PMM

