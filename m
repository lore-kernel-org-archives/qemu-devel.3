Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 633FAE9D82F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2026 03:01:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9aCH-0000je-RQ; Sun, 05 Apr 2026 23:00:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w9aCF-0000iS-Qz
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 23:00:15 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w9aCC-0005Jt-Gc
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 23:00:15 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-823c56765fdso1678111b3a.1
 for <qemu-devel@nongnu.org>; Sun, 05 Apr 2026 20:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775444410; x=1776049210; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jvg9WPTn9JS4NULEzSmYzeBGSc5qvShIbDaAIH8k2nQ=;
 b=Yc9ezDsXT4YS66UfjepMCfJ1LTC8NO11tl7jMKyQCaNPXP58cJ+9OeD0yR3QkzWXI2
 UW3lxnM7sX4ftxKakSpQgbHYnWMA8v1G+s0/Z7OlGgjm6vniufbbCEiS3yi4SBnPA/Dc
 pEkP5RN4iOcnrK9jS4426UJxSQATlid2MNYaVc0SZf80qp3Dze9z7zHICp+2mOlk3Ssh
 +MTMuyZgbHVIvvuRpLSwbpkvJ5+AOQD9IKOXb1ax/PQ2ldZz3yiOH/9hq8sn+jSd1FWP
 Jgks7jUfs3o0tpNsSwpH4fjOf6jsxgJ4IGyeUtFuagIp3L99rzNphq6CoRZ2izsfE3Hz
 ojwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775444410; x=1776049210;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jvg9WPTn9JS4NULEzSmYzeBGSc5qvShIbDaAIH8k2nQ=;
 b=HhrFu7EHC5+GvGempRyafj44JsVM8DbQ5j4zrd98wQT6PFGXJ3v4Bg7vCdua46IFM3
 moISR37DU8vnN+MqNbMAnXq6StbiYALOzpC44tZwt79THnyraAQSzR8LRF2zyu5K20OW
 wGoxHt2ABqFqxoKMaXiZm8EOidnHI1MinzhIHTYggu0g+CPaOHKXJjKhUGqLkOijHkQM
 40voDV9akTawDEbq1LOucbvQ5Qic0mItnN+JIegscoBbdcRZDeyHZc23stbZ82Rdfvnq
 eRT1n5yfxa62laNbXvP7GV12nERW+eB7+SL9kDLEQg8yZ3fbp8/ylPrl1I9sYtaD6ya3
 pllA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUg3fFjMCNhgt44lAidqPK0XSq+XrJnaf1EEtNDPLOhIG5TI5PUF1KYQofqo/5fOju2xl3fSsLIAyOR@nongnu.org
X-Gm-Message-State: AOJu0YwobxK3/I7mBOnhsDH75fk7AsUuSIU1s+qx9dCxcV0lqNEoZxjX
 CMbBkTu9piN1V4YMmcfpjOcRqsq96Rsb+8uZ6FvGNJ6tzP+5WP+G50ABsNv0mpABfAg=
X-Gm-Gg: AeBDietuPL+j1c/UDbinsbF9ejY9dvbrN/U6tTXl2nP+5+K8xMRlBKwXvrzY9pkdaK/
 5PgNLX2fvk02p9ZGBVvhW3NZsibhmejVoZ8DhMcqbppK+a1hphNJY+ReTROOaPK4hQFDYqovDBc
 Ug52bWcVBRKPz4pl9PMOFA1A0srqZZtSrUw8w3pw831iOIrgKQCTQDS0XmaS7+m4tLqZOtZX41i
 l2c6dwjHKsZikAxLTxazIufbngEJ8uGDqZOCEuz/6HDzO91ZKpKzkHoi14RNawMLhWmKXkfJ0J1
 KagKclnLch6loBUiwsZsSVZjGD3kY/ATwPyCMP748NV8kn/d+kp4iwPQC1Pnavu7hfPWSwtvhL8
 72aQRUo+y6h0IbBWLx0S6IIsvGoH0EwzOITLgqsi6v9Mfyz+LZyPwLBNwxDKlpXAujFN4QX45W9
 3IXp9iHfbLrvCkkme8K4F/Aeweblf5kbsoZH4EtuOC9D6x70jftJnqJ+OUYSgzXZqoocU=
X-Received: by 2002:a05:6a00:1406:b0:82a:7dfd:9757 with SMTP id
 d2e1a72fcca58-82d0da44b00mr10089236b3a.4.1775444409878; 
 Sun, 05 Apr 2026 20:00:09 -0700 (PDT)
Received: from [192.168.1.105] (124-150-69-109.tpgi.com.au. [124.150.69.109])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82cf9b3dcb3sm12170536b3a.16.2026.04.05.20.00.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 05 Apr 2026 20:00:09 -0700 (PDT)
Message-ID: <fbe27b77-b369-4218-8354-4b5d0d5db139@linaro.org>
Date: Mon, 6 Apr 2026 13:00:02 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 28/35] target/arm: ensure aarch64 DISAS_WFE will exit
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, Peter Maydell
 <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
References: <20260320130607.2071996-1-alex.bennee@linaro.org>
 <20260320130607.2071996-29-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260320130607.2071996-29-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

On 3/21/26 00:05, Alex Bennée wrote:
> This mirrors the logic for DISAS_WFE in 32 bit world.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   target/arm/tcg/translate-a64.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
> index 073454b9195..d79c8ab431b 100644
> --- a/target/arm/tcg/translate-a64.c
> +++ b/target/arm/tcg/translate-a64.c
> @@ -10917,6 +10917,7 @@ static void aarch64_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
>           case DISAS_WFE:
>               gen_a64_update_pc(dc, 4);
>               gen_helper_wfe(tcg_env);
> +            tcg_gen_exit_tb(NULL, 0);
>               break;
>           case DISAS_YIELD:
>               gen_a64_update_pc(dc, 4);

This appears to be wrong since 252ec405768 (2014).

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

