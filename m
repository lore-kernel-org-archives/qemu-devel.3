Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE0FBCD343D
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 14:52:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slUtE-0002TK-1A; Tue, 03 Sep 2024 10:52:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1slUtC-0002M3-Bf
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 10:52:14 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1slUtA-00068i-Kb
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 10:52:14 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-715cdc7a153so3757729b3a.0
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2024 07:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725375131; x=1725979931; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Y2qVYLaMvH9sQ8WL2KZV1nFs1XE+e+jvR5YHSOqqk94=;
 b=hyOzFtKw6ozCIfDmuEeuwC4EdKX5CAzyOUjxxhnLJgFNENLvFSRvryoamIdrLLCSip
 ZxCIFui7pkIkdQ6DvYyhEfhWYeXbONO+QBqll8MQQvsmY461c+1t+rJAs3oyFzYvUsIv
 LJSNiKENO3pFKMx5oCti+I9KbfY+F6OYqJF+m2brrvQY+hrfdQqrY+PtCv2bkEFinc0Z
 TvHj4dwUJVd4swEu4UEfYepsw3XwCqCmt+HWLx1x5NmQ5TE0GH+z5FCxTozb4w1eqPwT
 SvBQzxnU1kXD57vwcYl0acWKMhoxsfzaEFrDfyDNGzbDVGaFkhugafvpEHBek/I9oG86
 NqGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725375131; x=1725979931;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Y2qVYLaMvH9sQ8WL2KZV1nFs1XE+e+jvR5YHSOqqk94=;
 b=AxK5nFlm4WzSfcT/L/wXz37YgREmQn+YoQ/I/ZQH0kBsCK8KSaSsH/7BpDBYW4ofd9
 rPgCynkVSMjud942q8ctY8JaEZcn+Y/E7kfaHt+tHqGlMeWI9coPDNWNTznB07tCLjA1
 eje/R9GPaFSxhZuxGt6xOl/7WHpW6fGl6xpOtDrmTkz1w7RPCWbaRMa4ekZ5ACOmR+O+
 3FckioC8IUjYOzxvdNevHpgMKxa+5/z58JZGn/OyT/GTGaP+a511TvCsYVr2mfMCfRDy
 gs++Rtje+9emTxnR0jceFsyTbprFZIhtY/N9S6dGbdMrnrfPiT1wOH8FB8/LqAgdwVP2
 rIfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWusmVF7a6tgcJf3lm2X9KkP+0lVha2xh/pT/IUDDOFBnNDeNKfQRNlNmmW3d6+OF/wjQsPPSXKxza8@nongnu.org
X-Gm-Message-State: AOJu0YwwQGSP51BWGTOTBaouatJnmLrzTY7hHcHB2BJ35SXrRRvtxgBh
 KJoiMI1QuJ6IDiw9cyZyC5YD/oj2Oaj+0n6FwOcExMpu0vXltfFAgkcwGw8qKKY=
X-Google-Smtp-Source: AGHT+IGnb60e6bHVdhzZz2EUWx68rrzjTiEIEQEU5uabvQpJ0sLp5lz6a5qKx1imCgHiYC0DSPWoWg==
X-Received: by 2002:a05:6a00:3a99:b0:70e:ce95:b87 with SMTP id
 d2e1a72fcca58-715e0d94b8cmr22832944b3a.0.1725375130991; 
 Tue, 03 Sep 2024 07:52:10 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-715e575c3efsm8571892b3a.202.2024.09.03.07.52.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Sep 2024 07:52:10 -0700 (PDT)
Message-ID: <d1b311c2-b642-4bbe-b61f-7be19b414eee@linaro.org>
Date: Tue, 3 Sep 2024 07:52:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/14] tcg/riscv: Implement vector neg ops
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
References: <20240830061607.1940-1-zhiwei_liu@linux.alibaba.com>
 <20240830061607.1940-10-zhiwei_liu@linux.alibaba.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240830061607.1940-10-zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 8/29/24 23:16, LIU Zhiwei wrote:
> From: TANG Tiancheng<tangtiancheng.ttc@alibaba-inc.com>
> 
> Signed-off-by: TANG Tiancheng<tangtiancheng.ttc@alibaba-inc.com>
> Reviewed-by: Liu Zhiwei<zhiwei_liu@linux.alibaba.com>
> ---
>   tcg/riscv/tcg-target.c.inc | 8 ++++++++
>   tcg/riscv/tcg-target.h     | 2 +-
>   2 files changed, 9 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

