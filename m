Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABDD5EDA685
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 15:12:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxROb-0007EK-1P; Tue, 03 Mar 2026 10:10:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vxROO-000779-69
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 10:10:36 -0500
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vxROM-0004AK-As
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 10:10:35 -0500
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-64ad79dfb7cso5403768d50.2
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 07:10:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772550630; cv=none;
 d=google.com; s=arc-20240605;
 b=M3YWpInIrQCiv/KDPUyne6nZGN6kny+EUbLBmCJ0jmmHwNLhbC0WDO/J79OJdcH7zy
 5FzLWUkAZLQ6Ji86cSLjJSy04cASG0Bp6NRb/rHSkWV4cfzQTWOFk3oo4is09NLh14Dz
 zOCWylolfedb7dryN13FJPoOkw3IaXTSqv5ZEiIN86tbxkXGLWEqycDu/kkD7lQOmPn/
 f4CDhK7hEX8oyC+ugOxZiV9FnZn7gBKZGIYu6D+p04lmTE1aMz5vAt8PlooBoC6Ufzf5
 D5ZtWjOc1S5pbonVLldxuU8LpFOY3vfkFNXIbADJqh1LhByT0tppEAcdrMgeb3++vMlW
 qq2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=8y5OIp/jfVpXibTs0NlVeqzjri8nP7FS+PuUPn0XIIQ=;
 fh=0ddAhvz4rCbcEjQQAaoVcBj7vu+1LxR8hj6NujATvn0=;
 b=IjDs7mfdxMOkWxaVhksdVBYixpWlskx64PhEqhzWxkXlToG7O9/+UCgg7zKw7H6qhK
 sGpX4Q2vk1KVpZpuoCScu3wD7nVhfQ0U0cRoaLY3oCaVfHoF0T172IIhMCSfIMrA51OL
 REMw97nqjiIvbOlqMfDEZ17Y91iKJnWVHtFgkJv99TIQSlSmMEqNxVvj8qI8dqOTtC9q
 JCAPFKgTvPSQS4KTTnsFBDu8zZ2jiYrpx14HA1+YnWiLoHzXZzPaGG3W6F48CYExl6N3
 QgPc3f5Zd9jfzIwPT3H0pYEa3kiwbCL/ad29V0diri2Ro3mhSVQf2z0aeyS1zCMUA1Y4
 fY1w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772550630; x=1773155430; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8y5OIp/jfVpXibTs0NlVeqzjri8nP7FS+PuUPn0XIIQ=;
 b=T0KWbHBtWFKKzbQvU6o8eYpf0CqqKGHMqCoj2AdBbh/t0/WuoLI6ha+/ek9wfugoHT
 MTjKsJFU9ouxRul3FkLDz+Z8nwU/yymXytz82DJwDh5Haz1FfUP1zkCTIW0RAR9rfkNg
 x+mbtZkcr1834scNJAIUlbfewdtxAJF/zypdq6Z3fgqOeN42SKY78khierhk83oy8SSp
 espCczTr+m70KiBcImjUFsfFzFF744LhC1Vv5guXJzmbV8xMeMgdHovMozQKSyIyPHn5
 oiFjfX+NXdCqbWBBFBZOaWo2lfX2/0agg78ALxMd0IyhFCF+LT39E2jYugHa20MkeBlh
 Z+1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772550630; x=1773155430;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8y5OIp/jfVpXibTs0NlVeqzjri8nP7FS+PuUPn0XIIQ=;
 b=BpJD7bIq2PWGgIPUZ6WmoxCDxHJf3tBfwNO0LsbS0pz1C4U7fxumbRLNbIAQYJsq43
 M/OyQCxpRvI7S740uY6Xitn5Ds1yoOi7IL+/oE6iKsPANR79pH+RxUKDlue1lFjzstDF
 OTFOs07gTbkpHqwASqcd4WDrMqIFP137RhBCDbsph0ao1VvQxVuGb2cwlNHMaVLNBPUn
 TzNkOfRACG+zzb/iNGciWGvzXu/DaDGUTWQkA/VvvMrFo5slt0LLS6OfPZuohNhPxDdj
 pyomUeQOQtWD0+VUI9jHsUFUl0tL//679d9xVEJtuMTmEcQT5XeyNETrnP7I+4xSWa75
 jWcg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXy69rz7Aj06yL/FbusYCqkoTj15wjTpFaXuiXJ2Mc8olrlnYp5sNeSxhJHh00P6Bso8OdgPCsb5wBB@nongnu.org
X-Gm-Message-State: AOJu0YyMBHtmrah5VU9AL66AS18BS33tIdkVNLLLZ1esAsCuDzLikyBG
 kwE+QiQbKsXR+/NKOdOU1+nflzVoRN8yIC56fhw4kRl2Vyn4NzSwL3u5MasZIgrjLsVrZU1k8Oj
 Hdy8bpcjz3ZlVSgekEuKM9wenLqub68DjDLchKZeCaQ==
X-Gm-Gg: ATEYQzxdtXJZx9KzV5e+tsnnbmNhzCiv+U5OUJVfEU+TeHHya56+GPg4DjdazLpKWGC
 tW1PFNawZnxOaATuQpOQ5uU8FktXg6UpMMavFL9Cq1HHZyCVzF/KQu5SFMy2WwtwSSthQNGXbLk
 M62+IQA50rfsI0CUCQEnVZRNDB0M6Z+E4NGWY1gmbO0bB81E6+UZ+okJfl1UvNvBJhCgcLxA+8v
 wwNDj8VdH/XOOwsL/00gIQMgYTCgitrOvffIv8SzOl8R+50IKl9+bxXDsFUpial2HkJ8lrpcbro
 QmH9HRSM20+5sYd8VMZiSQc4zKJFjy5cXbF7ebho7JxWaGtQr7t+MzSGsB8N2HNLs8Zqszt5eEj
 viQ==
X-Received: by 2002:a05:690e:1c1:b0:645:5d39:2547 with SMTP id
 956f58d0204a3-64cc22feb5emr10715420d50.72.1772550629963; Tue, 03 Mar 2026
 07:10:29 -0800 (PST)
MIME-Version: 1.0
References: <20260303143928.1747116-1-eric.auger@redhat.com>
 <20260303143928.1747116-5-eric.auger@redhat.com>
In-Reply-To: <20260303143928.1747116-5-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Mar 2026 15:10:18 +0000
X-Gm-Features: AaiRm525iwMLvGJFOu93Lp65UeY3xTmh-HZgxGu2VIDbpu-HihJykayJc_1JmtM
Message-ID: <CAFEAcA9LoXOnu9iYk76KA+rH_9VAF7g2HYS=iRA6B0cd6SoRLA@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] target/arm/kvm: Tweak print_register_name() for
 arm64 system register
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 cohuck@redhat.com, sebott@redhat.com, peterx@redhat.com, philmd@linaro.org, 
 alex.bennee@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12c.google.com
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

On Tue, 3 Mar 2026 at 14:39, Eric Auger <eric.auger@redhat.com> wrote:
>
> As opposed to other register types, arm64 system register decoding
> is not introduced by any 'register' mention which can lead to
> unfriendly user-facing traces.  Let's add "system register"
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  target/arm/kvm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index cfb46015d48..43dab246097 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -921,7 +921,7 @@ char *kvm_print_register_name(uint64_t regidx)
>          case KVM_REG_ARM_DEMUX:
>              return g_strdup_printf("demuxed reg %"PRIx64, regidx);
>          case KVM_REG_ARM64_SYSREG:
> -            return g_strdup_printf("op0:%d op1:%d crn:%d crm:%d op2:%d",
> +            return g_strdup_printf("system register op0:%d op1:%d crn:%d crm:%d op2:%d",
>                                     CP_REG_ARM64_SYSREG_OP(regidx, OP0),
>                                     CP_REG_ARM64_SYSREG_OP(regidx, OP1),
>                                     CP_REG_ARM64_SYSREG_OP(regidx, CRN),
> --
> 2.53.0

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

