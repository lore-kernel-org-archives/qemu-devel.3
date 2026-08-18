Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93E3FC5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 22:46:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwSZO-0006lq-Ac; Tue, 18 Aug 2026 18:46:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwSZL-0006kI-Es
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 18:46:07 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwSZK-0002mS-1f
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 18:46:07 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-38759bcd877so575052a91.2
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 15:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787093164; x=1787697964; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=oGuf/XaNaWykShGTpezI/jND/2tJdqSSD0ArGH3BQL8=;
 b=O7eSdj2KM2jEfXXUWOfcRxJdkps2UUmMOk1hYUzdHLUba5p8wwMkPgT5AV+AAxJgQg
 poFSHCD0IMpupFhkqUMYKDlDOtQce6rWUcEqikHHdxbhF/nJdXAjAXd+BylKUY6Bi8Y1
 cTFUmYZCVbNjS/cIlavKZAR/2qFvWNe5oXqXjHfNx0CgmXnwmY4Pmx+UB2l2WAvtbRF6
 hUlwlbmcS20VuGtHYGa+qb/8biEH5zZjGyIye+dPSGu1d7pCHQsBRx5/nQgi4Yy+TZlm
 gFWAIXewVbyqbuZfQMYdhcGPglErCYz9B1ikMN8uIJcX8LFbDL6Yf5unho+LV+qm0xBi
 lnpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787093164; x=1787697964;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oGuf/XaNaWykShGTpezI/jND/2tJdqSSD0ArGH3BQL8=;
 b=Ell34nn1LA/bVwadHcRQukEl90B4VdAGe6GXpAcLodiRfI/iAZifM1u5penl7HLJ/D
 +9gxrcVA7YehalpPHyErtI4MTr1t2XkRVF9LUR6kmAp0TAA6Lv35TrnNkyHq72butoVO
 7S7rr5UrAf/FIRDjLRiojumhJU9FMy+BESndkBGh8uNUS2R6o3msLXKcrjeXwRSGfWg8
 7CCAfux5DXmO+QXcGcdFgwMS6qn/5D8M8jhkHn/BhvZW6mAq0+AGeNjkz7pVu45YgSe6
 r2Lm50lo+UGWmVEI7moPpykqrJO1NEqmP83YC+vzwPeQR7zCvFPNWt4rxQimy1rFP0u8
 kZkw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqlAP69pWh99oqOnBAQVHbI7J+1wokXvDAeCspQPoBu2xEsKQ9EeBB4BM75daOcheeDwKxdUNwDcgcn@nongnu.org
X-Gm-Message-State: AOJu0YzZLdU+/pKHEsEuGYccLxEjmM81EG8lktLh4+VQ9ICP27RlZ/35
 sZ+JBkhRIPDcOFcSwJiLTwSrNeqIoCW9KhrYiU3/dAT7DujpdOCBgQ5hB6643UHc6ag=
X-Gm-Gg: AR+sD10d/w6cVmnj8ViNIRZ0fUTgP4be68qte9l7YNRFaTuxyoXoLHq4stKtGsYuDr+
 0okAtu6IHqFkCGTg3dxKlMOcyF2OnzD07v5Vf5aHiU2PI1K3q2wR/dyKZuPzOwkcUmjluhmbRIJ
 FTJwlb+ffjPYN1HxCjO5iwIjO8lumgEuoIX0/AptRX+MZx1wVWbQsWbkGB/2hfsUArdnROeTXQT
 yAwazWcmoyvQc02XLCBaJanUXwQTX32mDUTe7skZ88X25GbmdabY50b1xfjdvi4GUwxw7EL2MXS
 mNp0JRFE3cMfmaP5PcEI87j8PVEWh91jQ6psWYl+qPoiVWzTy4qoc8EM+yK9eHwN60jWyhq57qq
 W69DQZxF4AksL7VQGsqEWNdq1gWHsRSDDveB1VfLaYc8gZm2Ka1r7DvTxyxZiiXgLdtui+H9OLn
 UohI7OlGco3FaqqHgEZahSRbBq8iZLQUqj4V2zlnANlfc2wx56Pp8uZhoM+dYThy/edK9Mpmarc
 f3Yt7Mj
X-Received: by 2002:a17:90b:510d:b0:38f:18f9:785 with SMTP id
 98e67ed59e1d1-39580f2d498mr432611a91.8.1787093164482; 
 Tue, 18 Aug 2026 15:46:04 -0700 (PDT)
Received: from [192.168.122.51] ([173.164.107.233])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3957f6b7543sm129841a91.1.2026.08.18.15.46.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Aug 2026 15:46:03 -0700 (PDT)
Message-ID: <8f7204f6-2341-432a-a8c6-806d35419375@linaro.org>
Date: Tue, 18 Aug 2026 15:46:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] accel/tcg: enlarge the TB jump cache to 64K entries
To: Matt Turner <mattst88@gmail.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, philmd@mailo.com, zhao1.liu@intel.com,
 laurent@vivier.eu, deller@gmx.de, pierrick.bouvier@oss.qualcomm.com
References: <20260818174247.649526-1-mattst88@gmail.com>
 <20260818174247.649526-3-mattst88@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260818174247.649526-3-mattst88@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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

On 8/18/26 10:42, Matt Turner wrote:
> The per-CPU TB jump cache has held 4096 entries since it was introduced.
> That is too small for guests running large programs: an emulated compiler
> misses often enough that the fallback qht lookup shows up prominently in
> a profile.
> 
> Measured with qemu-alpha running an emulated alpha gcc 16.2.0 compiling
> the SQLite 3.45.1 amalgamation (255k lines, -O2) on an x86-64 host. The
> compile performs 34.2 billion TB executions, of which 8.4 billion take
> the indirect dispatch path.
> 
> Sizing curve, on top of the preceding patch, instructions retired and
> wall clock:
> 
>      12 bits (  64 KiB): 1,563,829,403,943          133.13s
>      14 bits ( 256 KiB): 1,493,865,985,972  -4.47%  124.89s  -6.19%
>      16 bits (   1 MiB): 1,469,729,281,442  -6.02%  120.97s  -9.13%
>      18 bits (   4 MiB): 1,462,262,363,257  -6.49%  120.16s  -9.74%
Interesting.  Previously we had performance issues with the jump cache too big...


r~

