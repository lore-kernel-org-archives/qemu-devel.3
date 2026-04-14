Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76ED9F9D0C9
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 11:54:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCcKd-0004qa-07; Tue, 14 Apr 2026 07:53:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCcKa-0004pn-NE
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 07:53:24 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCcKZ-000244-3b
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 07:53:24 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-488b8bc6bc9so39458375e9.3
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2026 04:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776167601; x=1776772401; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Lotglqzmbs5ymAURJXXG/BqxY5lLuAk0pIEkLHGrelE=;
 b=QuD/U78Q80aCnVyUiqY0gTZmr805woMMmf9/RA9ZF25Irmt+X9y8sJLnAwNuSTdjty
 LhyO00Xx0dvsJ1u8Bg5CFPXAcvt/IWVnpTqZhZShkhowoMaFCh8355ZcZdQ2UdiYe2wU
 zHpXKAluWpIYVRwXdtLjG7vZ+CmmaywXbKp/3s8foQj1RTXUEUQ1U8wPALjr2IANTqHS
 z/8BK1bFh0BnogH0rXWfEfXcoPqjKSuJmh0MGejYnzJE99r4HuwxQ61KqgOY0/uGL1vU
 rzZvoUXRQdXqlJhT/dIuW6YEx7Cx1Zh65atQ87oxembh9iDGm/f9B+b7RraYVIwY72z4
 YDQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776167601; x=1776772401;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Lotglqzmbs5ymAURJXXG/BqxY5lLuAk0pIEkLHGrelE=;
 b=YAkOk/+cDt7SUY2+otue4z9hJBUwsZSE6lP0doz1xqEfrjJHojK5cGG+KEk/OSsqF6
 ZCeM6H6//axV2Vm+nqR6WFUzzMR7AbKDwitHDR5qVUg3zQzddBnOfDvEZj/lqM8E+lFn
 EPKbOFlRnIrinjYuOgHqk/owKeB9cpykZJ08C//q9Jy88N63MNtEFeSeNgsan8tD1O1+
 6521Ud8VJIFHbh2kgxgfO85Zssu9b6s51JLaIKYF8kA3VNcWFcE5MU42Pklu1mnP0GJm
 NMaB/2MHycYqsdgrmKlr9hQW9vxE6bTxBPAn+WCps0GK7JizDHDPGcuMVdf5mX5y+7Kd
 g2fA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9YLkQPOdWZor5Mvj/w2kOQs8Obz4AuLwBxkt5sDDSjaifxVZ7L5OqtEIgkapaFmkEuPB+x0peJ83tL@nongnu.org
X-Gm-Message-State: AOJu0YwXy3J18abs2NwQL83pXJC8688RDNiZ0bj0QkOB9eI0vQfYfLii
 gDcw4hIyz2178rDWNKYq7E8kCAhdXlfnDlXHHoj2r/hKNC5ow8CcwO+e4aSMZjpStsSE9F/rq62
 DuCgtPwo=
X-Gm-Gg: AeBDies9KoY/gUHG7wtQlItaMMk7Ot7j1kVeFG6QwvvxAbHParlnGDhTlnuQ9Jr5eiB
 559kE50H5hRJ+kHmGd10aLDYfnE4za/eleZBoSeIaXjy/wvYCLWN7kV3EfPfiIhuvIOgK3pqod1
 ugCsVcXYDoHL1pweFSTMcm/PW1hgVUFlRme/KSqlhFviJ9p+f2CuGSgByaTXHW4hrsqks8I9OBH
 lPOtjaCWaS/gLK8Unruuf8kU/+0/oGHO39RqE7vnF+axx4k4Fm7p3Dc2X0RxAw6+YYdrQ2Lxuem
 DmtTojHju77vyglZbPp9IKrPiE7C8uIvIYsU19Fw4K+je3RDq79K/8+/Fr55LC1k+bky6Fchauu
 PVpA+zhor4W6N9Bo1U06b+8Div/gKKw5PbA1h8PKu9f93OSiCEX67gVMNqtDcagYHfOdR4sL98N
 NTUGBP4DVCMtoT99KQISUBr98ncCETkJrqTvHIrE3Yf5/jHbkTv67fPM451RDKHs8K5A==
X-Received: by 2002:a05:600c:450a:b0:488:a882:b7 with SMTP id
 5b1f17b1804b1-488d6ad17e6mr223922915e9.29.1776167601158; 
 Tue, 14 Apr 2026 04:53:21 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ee018b34sm47048365e9.13.2026.04.14.04.53.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Apr 2026 04:53:19 -0700 (PDT)
Message-ID: <77ee7af1-5dcd-48b5-9343-ad540b129a11@linaro.org>
Date: Tue, 14 Apr 2026 13:53:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/65] hw/intc/arm_gicv5: Create and validate QOM
 properties
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
References: <20260327111700.795099-1-peter.maydell@linaro.org>
 <20260327111700.795099-8-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <20260327111700.795099-8-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 27/3/26 12:16, Peter Maydell wrote:
> Add code to the GICv5 skeleton which creates the QOM properties which
> the board or SoC can use to configure the GIC, and the validation
> code to check they are in range.  Generally these correspond to
> fields in the IRS ID registers, and the properties are named
> correspondingly.
> 
> Notable here is that unlike the GICv3 (which assumes its connected
> CPUs are the system's CPUs starting from 0), we define a QOM array
> property which is an array of pointers to the CPUs, and a QOM array
> property which is an array of integers telling the GIC what the
> IAFFID (interrupt affinity ID) for each CPU is; so a board or SoC
> which wants to connect multiple CPUs to this GICv5 would do something
> like:
> 
>      QList *cpulist = qlist_new(), *iaffidlist = qlist_new();
> 
>      for (int i = 0; i < ms->smp.cpus; i++) {
>          qlist_append_link(cpulist, OBJECT(qemu_get_cpu(i)));
>          qlist_append_int(iaffidlist, i);
>      }
>      qdev_prop_set_array(vms->gic, "cpus", cpulist);
>      qdev_prop_set_array(vms->gic, "cpu-iaffids", iaffidlist);
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> ---
>   hw/intc/arm_gicv5_common.c         | 80 ++++++++++++++++++++++++++++++
>   hw/intc/trace-events               |  3 ++
>   include/hw/intc/arm_gicv5_common.h | 25 ++++++++++
>   3 files changed, 108 insertions(+)


> +static void gicv5_common_realize(DeviceState *dev, Error **errp)
> +{
> +    GICv5Common *cs = ARM_GICV5_COMMON(dev);
> +
> +    if (cs->num_cpus == 0) {
> +        error_setg(errp, "The cpus array property must have at least one CPU");
> +        return;
> +    }
> +    if (cs->num_cpus >= (1 << 16)) {
> +        /* We'll hit other QEMU limits long before this one :-) */

:)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


