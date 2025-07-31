Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4830C87FCA
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 22:04:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhbMI-0000NF-3v; Thu, 31 Jul 2025 18:02:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhbG5-0006RE-A6
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 17:56:17 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhbG3-0003pu-M6
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 17:56:16 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-7426c44e014so1494104b3a.3
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 14:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753998974; x=1754603774; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SRC87jIXMP0qugdtfgXa8tdfered5QnzHmAI1huFC9g=;
 b=CGY6Zb4sT8Lj2GG71/fOaMXuCf1H+9wjw8Lxo616B/IcpZ7YBPowVTBdhcz3gdGJ+p
 yh/cH70bJJgWX7DPwkd1/Squ52Ju2hgr1+KtC4ACGORCK8f4oEXn1mTuOyQtrKsas0du
 QQb7eRmivXT3LvlKS8s4JnXZdhySzkSeXI+P/Peg52gcA8A9/yuHfe0F/ZDU7C2V00md
 0ndVl63OsaW8NGKVJQ7jygUF6ONsf6QKKYkkzixxkDhgS7RuZWSqwWISBhKAXfft3bly
 hVDNyP9IAij19xgVIC6V52Lfjom8s3im+/m3Bn7liiGhH11FrIt/LR2Cbf1pp2nnB+FY
 VS3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753998974; x=1754603774;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SRC87jIXMP0qugdtfgXa8tdfered5QnzHmAI1huFC9g=;
 b=Ok1XH0NgN5MEmqBI+447DpPcC+pU3MVAEKTHvfAB5CzhaqpFguxI2gvvypa01XbYA1
 3b/qn5RrwWHLp8acFxKgDWZ7KS5GP5vvAM2sXSiHaKe8Vojd4/ngemjcwltZc8hDvD0m
 5sdI1sEhkPlS3Z84xnjKk/oAbpAslabJBexxXhib9yeZ+mnXu8jd/vkpRlOpDVCghYyP
 XoMuG9+o64kAGj6dHdZ9KfKLgqpS2fG61K0BbR3Gnfcq3RtSajJzClvN46v5anR650Sv
 /aQG9wCQL2n+OPfsMuvLiGGrDLon/4ERMMxAs7pQWRfLSrfLhuMFJ4nhuOBQqOfLN0c7
 NX5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuTWzrJExFOLHb2rm5uxorwRlgxYrD5JLGnGu+XW2PmyohO+LoCBjXJ85MeS2HTPmnpdN4xcKG80fd@nongnu.org
X-Gm-Message-State: AOJu0Yy0maLdiZwL10d4yPByqsv/YoJ4Dz9oehvkwpPVPqvmqq0Bw5TL
 oKzu67ubL7BIV/qZ0orbS/7kbd6PSGNGM6shCWiLboPwmBTys/IA38AbSgXCGwj84b4=
X-Gm-Gg: ASbGncs/sOGlf8qj5aj0MtgwSyV/Bq7ynTjVck9MQJtozkZ/L5NLIxfUfC/I9trZeaa
 JuVkEgjWKBSUhBFIimAmldso9Z3rlruee+F9q2608WohHi7YP24dc+4EHTdXZOmy4DN4Ro+sgGf
 C14ouABB9145RqoZw6wFJkost2O+pbN60kGM+2I79RdtFCYJ2afKobiXMVzVL+NNJKpN+9IKXts
 vYqlWsIIIryJPv6qz4Tp9ITB2NpvMBgmdd5rpLSZSn/2mE5TLmnDWPny7aOQTnlo2avD4MMQG1D
 iIWKuAzfg2lgUUj5VjUDJAzY1MV8+wX9t6U9bkNgRf49pXpxHf3Mw9uJioEJobWhlwZa8jtZ91x
 wIgyeGfLeocE9mNS45jddPXMN3FBH7s59EoA=
X-Google-Smtp-Source: AGHT+IEyOuCNHQQ8cLq22AUtnQUqZazKqOSgJs8t4+jT2qHlTOYX2tVcRTkW4BktRBV3rDJXVABYfg==
X-Received: by 2002:a05:6a00:80c:b0:76b:c9b9:a11b with SMTP id
 d2e1a72fcca58-76bc9b9b027mr7101429b3a.3.1753998974161; 
 Thu, 31 Jul 2025 14:56:14 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bccfbce4bsm2411038b3a.77.2025.07.31.14.56.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Jul 2025 14:56:13 -0700 (PDT)
Message-ID: <fbe224f8-6270-4c74-be4c-2d643096b4e3@linaro.org>
Date: Thu, 31 Jul 2025 14:56:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 75/82] target/arm: Enable GCSPR_EL0 for read in user-mode
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20250727080254.83840-1-richard.henderson@linaro.org>
 <20250727080254.83840-76-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250727080254.83840-76-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x431.google.com
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

On 7/27/25 1:02 AM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/cpu.c | 4 ++++
>   1 file changed, 4 insertions(+)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


