Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D03F6CA0EFF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 07:21:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urARw-0007fq-5Y; Wed, 27 Aug 2025 03:20:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urARq-0007dr-RQ
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 03:19:59 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urARi-0004bW-4h
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 03:19:57 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-32326e5f0bfso5339356a91.3
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 00:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756279186; x=1756883986; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MUHahJJ7wR72AtK1qhqMQ6mYEqawXe7MjFSGztaHDt4=;
 b=VSExsoZ1O2d9Bmm36viYAZoKlM+1HwGNNYhNodeYMInibm/tjfy0Y4I5/idwsMXs/M
 rNdDBRXw2FBcNEs8J3xG75ht9nMt4aFaelZ3nDqwmjXyhPUn3J7xCe4ryHjUjkyTZxoc
 a7e+5W0p/YbaATggX0FXfv7VGj/RQuLad10sB61gt2ZbMNCEj7dz+l03hxrItobnEJU3
 SAAxPY6UtJrmoDo8BOfp1gIUUNBdfpmIpGEvSE/3+DyIR8bPnsxWD6Ho9u5r0XmOUDPE
 oPoLEtk6mWs8rnyoXdKdIag2erdyRiuJLSyGCcEe/LiecQPr6+uvXVr51OayCgpWjgeo
 CUZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756279186; x=1756883986;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MUHahJJ7wR72AtK1qhqMQ6mYEqawXe7MjFSGztaHDt4=;
 b=m6LthvIsH1SHlwjN6+y8xmuE+HRjlQJt5qJiMLlioFnhOsVFOZ9RcGw/2Zw7xv0aRa
 MQ2xTm5zEAkCJx+tvRwjgy/JFuSNi25GHydlfG+pAiIp/yjtzXAo22mwdk7BDJiiiXUV
 JiaGm8yDNK1ZJD1CFGxKyfuThjkBYu2y1kd/5Yw3/jm93nza6HcvhKxUQzOJlWydxAjd
 K5kye5vTMHYr6kscF3WK2JCLUpCsSTK0vssZCU1NVVxoZVZ+rm9IpGF2BIDQ2ouH7q+F
 qMb0VCmU9b6erg20N5+Knm3xKTeLezls75pWUrfqn50hcbEKVH1JgnKP6P8nCTo0Upb0
 1+ew==
X-Forwarded-Encrypted: i=1;
 AJvYcCVk8vUPWRzN2luwOwc1YTJsQYuY6lCbBiA3QPlR1k9m3AIE8WmZ4Dl7HvZhmhu1kQS1LrtI97ECLjuB@nongnu.org
X-Gm-Message-State: AOJu0YxXpHibR5CjbhXMY0WNIK9+vqE3lfvwcVErgRebnXPcn4H/cFNu
 pXGSRGHR1EQWPQwr4rtFrJVLuijI+SX10E9Sx6QbBMLldweVl59Ayoxv0LQoH8S4IOQYKTwpdgU
 HurkWedk=
X-Gm-Gg: ASbGncvr3ZLgF21bKwHMx7HjkjSxzGXfcI4u3dBW2FI6mNqkwtXvDcwvvEQJxqkQdpb
 xTpzkeQE15TGaiKbyMUHIlZW7r9OQ5KB7A9VjVo+Zy9ab7wExiQfc6KuO0g9acLumSJoZFE2ACh
 BGaQAP0jjUvXdKtR/OBv6qhn7qVdgtsGJKAh42g4Asl9DShCvBOxETuxxp3D3hip+pEHh6Z05Z+
 +9AbAkhIa8NGKNLVp3eiZWrDvjqlxyc2tsF3lVPWNt4NYSL7ZWKAxbuh3aXwKyY4L3X1RoR3Vfy
 Y8nPG0/0d4MrmmRAKjDvn3y589IHxTIVSpNLNZmeYPLhkzVESsCk0r0v1xnG4n2iFJcS1FSUySI
 b3iiENgC4vZBNVeiQsUBG3VvdPNt1YT5HYZMp
X-Google-Smtp-Source: AGHT+IGmTTfk1U8VTw2EKO4QjariskL5R1hlsoBfCj5xl0o4Z4MupBMGm8H3vX4Yt6X/jgKEHz/sOg==
X-Received: by 2002:a17:90b:48ca:b0:313:1c7b:fc62 with SMTP id
 98e67ed59e1d1-3251774996bmr22088078a91.22.1756279185759; 
 Wed, 27 Aug 2025 00:19:45 -0700 (PDT)
Received: from [192.168.0.195] ([144.6.121.55])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-77202f6dfa6sm2050406b3a.87.2025.08.27.00.19.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Aug 2025 00:19:45 -0700 (PDT)
Message-ID: <7857ae80-63eb-4d18-9618-d6c94cdd0c17@linaro.org>
Date: Wed, 27 Aug 2025 17:19:23 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] target/ppc: Move floating-point compare instructions
 to decodetree.
To: Chinmay Rath <rathc@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, npiggin@gmail.com, danielhb413@gmail.com
Cc: harshpb@linux.ibm.com
References: <20250619095840.369351-1-rathc@linux.ibm.com>
 <20250619095840.369351-3-rathc@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250619095840.369351-3-rathc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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

On 6/19/25 19:58, Chinmay Rath wrote:
> +static bool do_helper_cmp(DisasContext *ctx, arg_X_bf *a,
> +                          void (*helper)(TCGv_env, TCGv_i64, TCGv_i64,
> +                                         TCGv_i32))
> +    REQUIRE_INSNS_FLAGS(ctx, FLOAT);

...

> +TRANS(FCMPU, do_helper_cmp, gen_helper_FCMPU);
> +TRANS(FCMPO, do_helper_cmp, gen_helper_FCMPO);

It's probably better to standardize on TRANS_FLAGS even though the flags checked is the 
same for both of these.

But anyway,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

