Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73B60C53219
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 09:26:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woHbM-0000PI-7G; Mon, 27 Jul 2026 05:26:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1woHbB-0000Oo-Bv
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 05:26:13 -0400
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1woHb9-00024H-PZ
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 05:26:13 -0400
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-8114a4542b2so33334827b3.1
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 02:26:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785144370; cv=none;
 d=google.com; s=arc-20260327;
 b=mzHaIvZWhNeNTBR/w/HXaBYoMibRzNcitePBQn4KsyYMtlQQZMs+ezUtaThOCn00ok
 VUjjGP5pFH9PRrDGOwU0knT2DazT5cls+EqJvRt2ge33ANJgxUpntFKMBaKkdXrY4LVt
 H+JGvDYEq4mK3Fz8K0/1zBVoxcjLHYxYEy9DzkXGqj+qvgGv1JKk7+IP1Jrvjx/t1Ir6
 RqG/426cd4WKtqU4Ezkd9MXoCJva1udRK65DFna06f+LGrDfytiCG0yOObfBvgxGigDQ
 xN2Yqe9qxzXsnyMh3vAFza6HQ+O6uX/tYbFLbgSZPKSm3WYft69Fs/IKPKgX/Nfzde+E
 OQGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=dq+WxsqWrPkxkwVZOyR5+ThDmXd38bpx6qUb9hrnalA=;
 fh=aFAhVy9tlZR/GJPdBIgux+RpFBFy3QxbqdYpa8GVnjU=;
 b=A5idbRf7HX3SQIEFa01u7gTCCS9e2GwPdPz0uQg5grFEjCvlfWjGAMyQsnzwuqiOAa
 fBSXr/4dlYl08ZTbCHx9KO/VFSeWDOAgiAVZAruNGZ9cn1ZGt9Jt/aMKFrBrgbyFXkz1
 rFpzRZNXZgFFr4RG4C+rhht/O3XFO+RSZ/QQ0KQ0cZOi356NOsM02FwIQG1BS5HPcuX+
 fyShBVIKnkdHDr4vSVPS6keUGKdu7+vLSo85Gp2NrFdrk1BywOBbx2N/JKiaHzal3L7R
 puxppZr1jcS3wgpsFgCuH0+cpf+1GkjnKM5JgVb6MFi7MWrPK/qnSEcgvUPC/1oZHGVm
 fxEw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785144370; x=1785749170; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=dq+WxsqWrPkxkwVZOyR5+ThDmXd38bpx6qUb9hrnalA=;
 b=ezUKYKt1LfZjn5ywlVLqiW8k/+wabxtwYa16cm7M9Xq0tKFuxxbXH18uKE6AdR/pdk
 nfT0+aKYk+mAFUcnl94G80f13g9jpbe20mAw6u7cU6g6OaPw2vlzRmP375PuWQLvimxa
 4F3eU52+wB3n6opWGvVVVcCteLMwR9FvnZBxjYyraApqRum3oPsO9iCSDqyge8LhHY5i
 CArhzxHPdyAAzRq2kbSUkPWkSJyO8aprf5e2WB9mB/bhLMgpmjH7fSpuq0RdbOxOAhAp
 V819x2AG1HbkWP96AOd7Hunn2D6R6ysxBVX8d+GOD9ygBpxtOcGVEs3F8VZn4dmEqRBM
 tX+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785144370; x=1785749170;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=dq+WxsqWrPkxkwVZOyR5+ThDmXd38bpx6qUb9hrnalA=;
 b=XU4VyC4V925k715Q1Im5+/i2eVcb6cjqLJ0ih5b1R1baz6OWDmJEX879K4V9Vdhuuw
 pzpEiuou9p0B4zGtTH40rEM5hyS+h9V2M68K41UyblVYZ1Qvm0I1qSauVrX8Qyp+SvAy
 zYv0iV9fvLhESkAfDgY/D3Y5CL5vG5rw0kNVBEy+lD9vwoDV9aHVvXasQrxyQn0ti2HK
 aqN6MR1s23uzcbvdnoZK0yrVIslKeH08BcN1vKwbLaDwhUZDxSjzgcvUCmnPadbt72sr
 SXGNskqbkmH3bjebf6fxakLac24BrvPL9yA7L/OtKy9IJ6KOmmhnyIqkj2k6v5X4OFon
 fIXg==
X-Forwarded-Encrypted: i=1;
 AHgh+Robut1Y9Ni1DE112aEFLXLEAMWhxqQygdBDOIlg7kjgA+mL9WKem/pNlTm+PsUAHK3xgC8Nh1X3z7jU@nongnu.org
X-Gm-Message-State: AOJu0YyX7PNuw6MEfNXpz3OofkqThqurN+spvfCAGU/NlVNOGOy/xb9z
 KOld7q12dV+HFkCs816AvQar9VoeNCh4rQs9O6fdbeVoZjL6HEaEH5GCyLgOgBiASdcFVz6WXwt
 snknTMbQR5WPMUf1WSV6PmO9F6B0t4oBh6Fxw1wSdYA==
X-Gm-Gg: AR+sD11h7/qa0fC8hMhko8KcyDIrgqXfjWa2yCYCTEvJxbORbXZCKO+0MA4Us8fLVN9
 v5lNa4MUvn5Y5uRT5LDcpXXG5nPuraGiG523EllJV+dLPldYaZElbWRpE+RyrMqb/mq/3HcExfg
 /4/zjYsSxn0RsOOj+OdUVVyyPr2iRsdNK+0pifhRnUcePLkK3nR1KNMrnlnrcgW+YNmxwsTpMbQ
 KmdSvOe5PKlxw4ug54BVSFghXgoX23984BZARMBmPKnwZiuCGGgZcF+Ic20ersVH9FwPZKg8Wkn
 c/4nIdPI9qtmfdjUgtF9Fqn0rJ6HJoOTDUlHP12Y29psJQ==
X-Received: by 2002:a05:690c:7209:b0:81e:f76c:b267 with SMTP id
 00721157ae682-81f69ebac22mr26078477b3.68.1785144369893; Mon, 27 Jul 2026
 02:26:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260725123411.993099-1-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20260725123411.993099-1-mark.cave-ayland@ilande.co.uk>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Jul 2026 10:25:56 +0100
X-Gm-Features: AUfX_mxUwoRivBH-x5TT7oBS4ZBSDJpq7dydE85v-gKsY-kXLEAW426ZdUmVUmw
Message-ID: <CAFEAcA8X-Ts3DFiq=ak1kyomhs3bno6cQnJ=izWeN=+Xwpa8Hw@mail.gmail.com>
Subject: Re: [PATCH v2] target/sparc: set reg window data structures currently
 after vmstate load
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: atar4qemu@gmail.com, qemu-stable@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112b.google.com
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

On Sat, 25 Jul 2026 at 13:34, Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
>
> In the SPARC CPU state, env->regwptr points into the env->regbase
> array at wherever the architectural CWP (current window pointer) says
> we are in the register windows.  We don't migrate this directly,
> since it's a host pointer, so we must ensure it is set up again
> after migration load.
>
> We also have to deal with a special case when CWP is (nwindows - 1).
> In this case, while running we keep the "in" register data for this
> window in a temporary location at the end of the regbase[] array, so
> that generated code doesn't have to special case this "wrap around"
> case.  In cpu_pre_save() we call cpu_set_cwp() to force a copy of the
> wrapped data from its temporary location into the architectural
> location in window 0's "out" registers.  We then migrate only
> (nwindows * 16) entries in the regbase[] array.  So on the
> destination we need to copy the "in" register data back to its
> temporary location again.
>
> For 32-bit SPARC we get this right, because the CWP is in the PSR.
> The get_psr() function does:
>      env->cwp = 0;
>      cpu_put_psr_raw(env, val);
> which causes cpu_put_psr_raw() to call cpu_set_cwp() in a way that
> sets up both regwptr and the wrapped-register data.
>
> However, for 64-bit SPARC the CWP is not in the PSR, and
> cpu_put_psr_raw() will not call cpu_set_cwp().  This leaves the guest
> register state in a corrupted state, and the guest will likely crash
> on the destination if it didn't happen to be executing with CWP == 0.
>
> Fix this by adding a custom vmstate_cwp VMStateInfo with corresponding
> get_cwp() and put_cwp() helpers which does the same for the 64-bit
> case.
>
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  target/sparc/machine.c | 40 +++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 39 insertions(+), 1 deletion(-)
>
> Thanks to Peter for his original patch and excellent analysis on the
> cause of the asan failure whilst running the "sparc64-migration"
> functional test.
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

