Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66965C9832A
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 15:44:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBa0k-0003zd-Rp; Tue, 29 Sep 2026 11:44:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1xBa0h-0003yb-DP
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 11:44:51 -0400
Received: from mail-pz2-x29.google.com ([2607:f8b0:4864:3b::29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1xBa0f-0000hj-Sp
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 11:44:51 -0400
Received: by mail-pz2-x29.google.com with SMTP id
 d2e1a72fcca58-8864c6bd0d5so235970b3a.2
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 08:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1790696688; x=1791301488; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FtnvpBA4+dRQFWAJXjg2RG+jSqgBLd4rI/12kJ5llqM=;
 b=NYLRYZsBcfwS2i/6fUupzDqDQ1AgmwSc+taJIJ3Ph+2PgXqN6P9IYtjP6fX55up3PB
 DW8uFTKKFwQXPV15nmMeFYRKFqRCgZbAxaIaK2k4TaA/7q60xZ7++Rqmi0d9iju17RlW
 x3BOG3O8qov/gq7Pv3+99Obpn1r5iFxJcuuXg2Bb81fdKMxBhQ0tAhgl/Rq3HxlhxI0u
 L9Y8C39Ad0a4iSE9/QuKmpzhNcSZnIevL+x2T1sBXFu72EHDmByfF2S0zVfMOm8hKtvW
 HIrTFF2YzL+Fyg3pDNCidus889cBrSxL2SRf9YFvfS62BSCXGhPnSW+Aa9jPScwI3hOE
 gw9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790696688; x=1791301488;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FtnvpBA4+dRQFWAJXjg2RG+jSqgBLd4rI/12kJ5llqM=;
 b=lF8PY7TsGjnubplwPojPP+eRtOfbSDMVrOjrVWmJ9WXZlpIZ61YlrI1FMVmRYube0W
 5igxodgbE2grNdhCmyzYVRA0lgnj25XG8Ow2IqaGDGvwO8u6GzvKf8N4TbJ5Vs7KIR3F
 QD1RNvBM00MoLjrf6Dn47DZLhpeQYSD3HbQP233e3Z8AfoXcumeja9rZNLkQbU3QAL7B
 IWY+zVdGfTS39L6k5zr3/0oX8qu+3PkHaMqX9sWrjFpYr0WgYD83UINdZmKYkQFwCog+
 J/710EtQOvBOXKuvff1UC55YPFwOAOeu5sZAHP/xaxaBGOnDg4UrCNLGaM1BOZVyZezy
 ujoQ==
X-Gm-Message-State: AFuF++lTKUAcgP567Axx9O2StOJFwERv4JAuGj6N3cfucSuB8ESphPxp
 x5ImrLgcNdKzu1nzSdlvcaSbCFb64vaAVleZFXF6WppuCc22aUCXx/z3x8hv6GdDS60=
X-Gm-Gg: AYBFou2MYQtNs1tEYGRxYw5HBDUmon2DZRm6iTiiRUosby84X35OGs45Y71pEamXSPR
 /qUNdaInutjHbgq72jpgQA177Dt9oLJKrVWzNDUbds4mOZdoD3j9guv64WwH1/AA9APLMBAtV4C
 rcfitf9QXzdvq4cUPhSUG700wFsN3oOvMHod9c6L2lQJdE+q7KuEzhaWwkCxHIZA0nf7tdGUhJY
 v6th0YbahUZ5ic5phYVRdaaa5KFWTep2x1ByHLQwnxxAAmc9tdQ+FmjFvGRd02MCT4Xr67f+i1Z
 QDkk0AoFk/S2piVdaYh56Rr1JKRrKavGUfSX0Scar70kSy70SQgHVw1P7uHGfZlbec2VyIu2M1k
 /DwZxyUEP0XrDrENrL0cw5eI+kM48K5LLJHmFkOC7inE4eXyt21p7XVQP9CdT5bfivZXp5TUEbK
 q0j6cH/G5qo/LqjmytrDPFrqUSOaqlEfzpKlir/+4hA9MLSi/s4/8fh8F/tSS+rKzt/+10dk0sc
 7Gx5+x4496wkRMfSOd+w/I=
X-Received: by 2002:a05:6a00:91c3:b0:886:29a4:a00 with SMTP id
 d2e1a72fcca58-88629a43b5amr982314b3a.47.1790696688265; 
 Tue, 29 Sep 2026 08:44:48 -0700 (PDT)
Received: from sifive.com ([136.226.240.165]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8868c1f335dsm152207b3a.34.2026.09.29.08.44.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 08:44:47 -0700 (PDT)
Date: Tue, 29 Sep 2026 23:44:44 +0800
From: Max Chou <max.chou@sifive.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, palmer@dabbelt.com, 
 daniel.barboza@oss.qualcomm.com, Alistair.Francis@wdc.com,
 philmd@oss.qualcomm.com
Subject: Re: [PATCH v3 04/11] tcg/riscv64: Use signed type for encoding
 immediates
Message-ID: <arvc0-0j0-ObxhCQ@sifive.com>
References: <20260914000814.785155-1-richard.henderson@linaro.org>
 <20260914000814.785155-5-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260914000814.785155-5-richard.henderson@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:3b::29;
 envelope-from=max.chou@sifive.com; helo=mail-pz2-x29.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 2026-09-13 14:08, Richard Henderson wrote:
> The immediate operands in the 5 base instruction formats are all signed,
> so passing an unsigned type was logically incorrect.  Use tcg_target_long
> not int32_t to avoid truncation, which will become relevant later.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tcg/riscv64/tcg-target.c.inc | 33 ++++++++++++++++++---------------
>  1 file changed, 18 insertions(+), 15 deletions(-)
> 

Reviewed-by: Max Chou <max.chou@sifive.com>

Thanks,
rnax

