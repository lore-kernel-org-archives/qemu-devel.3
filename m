Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7C45C27C53
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Jun 2024 19:15:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sIvK8-0006GU-0n; Sun, 16 Jun 2024 15:13:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sIvK5-0006FL-Ma
 for qemu-devel@nongnu.org; Sun, 16 Jun 2024 15:13:53 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sIvK3-0001t6-VC
 for qemu-devel@nongnu.org; Sun, 16 Jun 2024 15:13:53 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-681953ad4f2so2927903a12.2
 for <qemu-devel@nongnu.org>; Sun, 16 Jun 2024 12:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718565230; x=1719170030; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lyan6J1k/Fm3Jekvcijd/2r4pqKilvni/X0ntym3Fs4=;
 b=U0PSDscX8C8PuLAhlwzcjPyPmXi+uTD/H+RDo+dWdZWR7YJ59ZkY64HX7Ag1snvBP2
 juJpN7VT0mc5hZdJPyucEK+9sdWbGQpEyZvrjQgcKuzsvZCiTPFYc1lsbzZp2fvnA/Q5
 d70owARcRcIwb+QCvlqShlNw/+kXSwMfrm2CwDH7qjw4mqD07undx0J5yqr9NGVIPLpk
 XGQYgy3S846GhwuELpps8wyOulx8SchoFFdy11t9Bp3m0jfnBLQdaA/Xvqr9ritTPEQF
 Mxs+yUhhkm0ZZrtL1UaHwv5UxHnwUgVwcjrMLM+qTgyKRq5OyXYsmmKPIbsnNH7CmZ+x
 S0Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718565230; x=1719170030;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lyan6J1k/Fm3Jekvcijd/2r4pqKilvni/X0ntym3Fs4=;
 b=jNVYqh3K0KxJ/r8cER9otAo9r72z9CuoUkqdAiIAx7UHndTZAWjsVzGhJB0elAJTY3
 FsUvUnVpVd/KmuUqkpRh1x7y92c9y1PY6YQLdtBk7i1Km5ocSyba5N4vG2JKmQXsmCih
 p7dEhqI8+XwX6tY4MOl0tvoHcy2KLiv/oxf4YgDNrJg5MGX6RHM8CUeJd0VJD9UwxhJq
 xAfl7PP53D4H5LBh/YlbT2A1leKEt8Et0SWZKot+D46jitfOB9LQ9cAMzTomJJVHUG+A
 rBISW/wp2AQNB6iVUUlaBvQ46aw8G+EduwH8YJJKGtiqIQDlvH0sX20/iOYBlJyFQn3N
 alwg==
X-Gm-Message-State: AOJu0Yz/cc0oSWYR0F4VKdYYYJo5vssxgG3EOnGuyFO54Up05neGaRzz
 MHSBOKzx8o2bzb3g+KMqUCxUW1wehqWjaGOVeQs8/pMV7uGsk4X8J7lnKax/URk=
X-Google-Smtp-Source: AGHT+IGBkxdG3sn6DQyunx8IdM2aKlFDyQNnhf2MOWHXfRnSe3VGkT3FWyx0R+e2afj2bZheSrqdQA==
X-Received: by 2002:a17:903:2301:b0:1f6:6a94:76be with SMTP id
 d9443c01a7336-1f862900706mr82063825ad.46.1718565230291; 
 Sun, 16 Jun 2024 12:13:50 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.132.216])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f855e739b7sm66797185ad.93.2024.06.16.12.13.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Jun 2024 12:13:49 -0700 (PDT)
Message-ID: <6638b813-f4ef-4587-b94f-3c24d90ca09e@linaro.org>
Date: Sun, 16 Jun 2024 12:13:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] target/ppc: Move VSX vector with length storage
 access insns to decodetree.
To: Chinmay Rath <rathc@linux.ibm.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, npiggin@gmail.com, danielhb413@gmail.com,
 harshpb@linux.ibm.com
References: <20240613093318.314913-1-rathc@linux.ibm.com>
 <20240613093318.314913-3-rathc@linux.ibm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240613093318.314913-3-rathc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 6/13/24 02:33, Chinmay Rath wrote:
> +/* EA <- (ra == 0) ? 0 : GPR[ra] */
> +static TCGv do_ea_calc_ra(DisasContext *ctx, int ra)
> +{
> +    TCGv EA;
> +    if (!ra) {
> +        EA = tcg_constant_tl(0);
> +        return EA;
> +    }
> +    EA = tcg_temp_new();
> +    if (NARROW_MODE(ctx)) {
> +        tcg_gen_ext32u_tl(EA, cpu_gpr[ra]);
> +    } else {
> +        tcg_gen_mov_tl(EA, cpu_gpr[ra]);

Why are you making a copy, rather than just returning cpu_gpr[ra]?
If you need to modify the resulting EA, then you also need to make a copy for 0.


r~

