Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FF32FAD3E0
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 23:14:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFglr-00058w-Ku; Wed, 22 Apr 2026 19:14:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wFgll-00057K-Nx
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 19:14:11 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wFgli-00053l-Kf
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 19:14:08 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2a8fba3f769so27109315ad.2
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 16:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776899641; x=1777504441; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fPbKZhbSa90P+oET+q5xHZ5cbCBBtfcv9FXCfUnIhDo=;
 b=ZVucftiql04yUB5LP4e4KbGOKPAeTtDZJ5vfh6YcLsD6yyRlKV6Wd8XAxLrZtjkGzO
 GKgrZitd3Sqcl39yIaCxCyrBrpwQnXPyFPjZYNk3RwxXNfPkcmntnJErcO++AlMv1mmL
 Cpkm0mwiK8PeeVU97tZMKiFsyVk50vZTdNSsUHuY1u19CuyE5D+OkS4QJs9dpO1b9kzz
 VAh/HvmQRh39rIbuCpdsbaur27KvVitJPZNbTTaFknCA2SYoxCTmqV4ju+KyIHGFZgBQ
 e2CYoZvASDL/6gBhfAMLOk3Re2Sy+qkrqM8XsNF+cDxCWFKr+nrNdIy9tNUPzpQg0yZU
 p1Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776899641; x=1777504441;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fPbKZhbSa90P+oET+q5xHZ5cbCBBtfcv9FXCfUnIhDo=;
 b=L0aBmOa7RZCCYeQhB6sfvURhWEh3OX5UCOIhmrv4pJavrq7SWYzKIt/gcOdxEXaykh
 ItaAYKsmhRaLfGCGadSfM43makqTyyL6T5s4fOeC911o+aXQf/9lk1192VNKYhffXFKI
 HzxvNyUEcyz9jCIXVIFUdQzi90Lcy7hu5d551IDFUVmUn77554jGf3c998VGIpf1eiEv
 BQ+WQ2q1nWjAojqq9/zxWQMgWJrX1fo5w/8W8WP9oqPU2f3sWqXLwdcG2WjwmcM8QJGa
 dNwO9JdXUYF8cjj5KGPHX6yPBmbAgCly4h1b7JVJLSXcqidukDorOxyhH0dgIgDUtmBa
 wrrg==
X-Gm-Message-State: AOJu0YxGFNCxriDaivJvXmkqeKwRjFBbmuN9RkRLOZiZrLzW+TcRuWHl
 shauwUlI8PfWYuwfFQjfPH28bnRxVDPaY0fVrqMcQPEMBytGw9vrOD096K166MdZgkMu9J2ftu+
 Qg+1juA4=
X-Gm-Gg: AeBDieuuAdSdYbCXo46ccC9HT5cqFvqVwlvetkSIDgZS3uM77dPwEp+1+bb1Ni/Kkoe
 /WF6aRlVWAJ6jUImzy/mPBFnFwFl9MUW9R8ZFawBSGG50ZmBu6y965GeKKyfukZT41DWJhV1b6f
 6fBH6/JHL2OmnsgUKRasMtKjdsirBJyUXYlXUUhz/88h53ln7SLETtBszOo2iYyUCb28bpGQKXl
 UoJXITCdv7A+tgL5BOLyb5rxdxxDq4HYnzIVpClLFYPp7/7ZIh6t4rUixD/nnW1u47gGWCFOVZ4
 Jem/NdqeGfu7FjAEdxEkolvD8npgfQK137mGmMCGjVZ4Nu5X7BS/fG5jlu2OMUpyijbmhISzbt4
 OGpTgZk9yjNJF9RTlwY0zguSgmKNUGj1F/MIqrVqrb0/ykhdYqhf9Bp+8h4Ncgo/oW8D+2QDnPt
 xsXolpGIpJfTIoamdLFDpthLntNJBysD/bnimj0hFM4lBZxVcHOg==
X-Received: by 2002:a17:903:3905:b0:2b0:7e4d:f43f with SMTP id
 d9443c01a7336-2b5f9ffe73amr234047165ad.41.1776899641368; 
 Wed, 22 Apr 2026 16:14:01 -0700 (PDT)
Received: from [192.168.1.134] ([110.239.0.232])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5faa174c3sm171963165ad.21.2026.04.22.16.13.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Apr 2026 16:14:01 -0700 (PDT)
Message-ID: <43d393df-f7f3-45b7-8c02-ca1d886ddcb6@linaro.org>
Date: Thu, 23 Apr 2026 09:13:55 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 32/32] target/arm: implement WFET
To: qemu-devel@nongnu.org
References: <20260422125250.1303100-1-alex.bennee@linaro.org>
 <20260422125250.1303100-33-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260422125250.1303100-33-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

On 4/22/26 22:52, Alex Bennée wrote:
> +void HELPER(wfet)(CPUARMState *env, uint32_t rd)
> +{
> +#ifdef CONFIG_USER_ONLY
> +    /*
> +     * As for WFIT make it NOP here, because trying to raise EXCP_HLT
> +     * would trigger an abort.
> +     */
> +    return;
> +#else
> +    ARMCPU *cpu = env_archcpu(env);
> +    CPUState *cs = env_cpu(env);
> +    uint32_t excp;
> +    int target_el = check_wfx_trap(env, true, &excp);
> +    /* The WFET should time out when CNTVCT_EL0 >= the specified value. */
> +    uint64_t cntval = gt_get_countervalue(env);
> +    uint64_t timeout = env->xregs[rd];
> +    /*
> +     * We want the value that we would get if we read CNTVCT_EL0 from
> +     * the current exception level, so the direct_access offset, not
> +     * the indirect_access one. Compare the pseudocode LocalTimeoutEvent(),
> +     * which calls VirtualCounterTimer().
> +     */
> +    uint64_t offset = gt_direct_access_timer_offset(env, GTIMER_VIRT);
> +    uint64_t cntvct = cntval - offset;
> +    uint64_t nexttick;
> +    int64_t next_event;

Don't compute complex things up here...

> +
> +    /*
> +     * As for WFE if the event register is already set we can consume
> +     * the event and return immediately.
> +     */
> +    if (env->event_register) {
> +        env->event_register = false;
> +        return;
> +    }
> +
> +
> +    if (cpu_has_work(cs) || cntvct >= timeout) {
> +        /*
> +         * Don't bother to go into our "low power state" if
> +         * we would just wake up immediately.
> +         */
> +        return;
> +    }

... when you have fast-path returns immediately following.
Delay computation of complex things until you need them.


r~

