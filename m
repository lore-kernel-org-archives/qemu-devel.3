Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5578C282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 10:43:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsg1v-0003aE-OK; Thu, 13 Mar 2025 06:43:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tsg1l-0003R7-GL
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 06:43:03 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tsg1h-00059m-V3
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 06:43:00 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43cf628cb14so11581625e9.1
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 03:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741862576; x=1742467376; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+73O+Ezdwzg9EroESuSqgivd6QH+Zkd8LRP2NKwZQcA=;
 b=FltFMRSQmA1rHEhBS023vWMfnCpIlUop2Dg9jBFo2UiWns7/gtHXXngYKdtn/IhEZK
 hdV9fay02aa+BZUpDYejAp/uXJUah/SrC+s2nQjtR1crIddy2gOqs7QEIert3Aw+ARfY
 AcURTrEW6UY1ZqDsc+/AINEmyWAKh8F3TUmUOnbPIMB5bL4gOL0noSkR8WvwIboh7xQr
 v+dwQNXQ89KKIEEUGhy7qoc+0Bu6AvYuH7uOHCK4/xZ8F1sY/INTU8a5Uiqq2EhyvZJy
 84I0GQPUIHpqeci3EfktdkPh9aqO2ELjoX/9BCNu5QMjIcHku4OTWOQdHHqLD+kdftkq
 6eSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741862576; x=1742467376;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+73O+Ezdwzg9EroESuSqgivd6QH+Zkd8LRP2NKwZQcA=;
 b=Oo5/1y+rfQYUDbU8Y0OjB/7+w4NsO7c5NvVHBr6o5W6s0xt+7mSC2wjPYrBPcOqvrF
 N9+dpUYPOsxHalkpYtF5Rv6/JVfmX3u+0NPSSsZNHlpAyNd313VQwGGacVj342spZB9i
 2/J4JuC1Wj01YqimK5wScbAJPMYQ4VwgE6e8nHQNh+DHTX3Ww/dzjgGQS/qH96LuLwsC
 pCav3fK363E2jkPYlf9rEjbfW21K250Br37dHaoU5NQT0kZFjK8ztQbd1CuP07YFpE0g
 4rQybQF+b2aKetng1yktvUpnoawd5MU0W3NU1G/15Sly/a50ldPXhV8NX/apio6jdOSm
 khWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXp9TvV2A0XLZgptPfa0qGVqgNRuUCVyt9JqBZxKgt0yb6ZhaVVLSScXmtPNKNG3iirwsT6ny+vqQUy@nongnu.org
X-Gm-Message-State: AOJu0Yzr1ZxSQFL+mMxc1Efuxf9MJ+htfVjpq3IRQn3ioizn1TDp4NF7
 zzsAlFqlZHvqiWGwvxxOnFg20IfguCGv3cg8iF+1JrGE+xx+xGRcx69zMujayjE=
X-Gm-Gg: ASbGncvv9E+8eFVGcenM1MYSsVfY79OVqmh6RkbETJiCtDCka/GKQTWz1boYArnz7yo
 Rvonpc2/LJKPUg1hr2Q36dXIgbN8DR30A56AfB3z2JKZQ895+73u/X0xYPsgRYHfNYKmfZhg0F5
 nm6sUqH/ucLISkroFacBfX9G7gOW/26iNxDp80lm2nh7u1YJ7rv3riCankZhOfDQaxe+jyF6BKv
 6LLMamxaJDmRY8R21YkDk2RUpbSF7WViRadGi/G8vqnwdZhCNTNDEZvVg+I/iPhm3XZ0kqqxMBD
 G90QjGmKVCEajsnyIjfR6KHByEvBKFaAyUBaztZ/opJStXhOZQ9rUKtoxebQRFBpson3jqf1QY5
 8LEhQHfBriJMaOys=
X-Google-Smtp-Source: AGHT+IF30wcHutQD536A329BW8Vea98jIrkRx5Db+jMPEG6o0kjXVCigAzIAZy7YeEP1K21yB94+cQ==
X-Received: by 2002:a05:6000:1f85:b0:391:1218:d5f4 with SMTP id
 ffacd0b85a97d-395b83108femr1382251f8f.23.1741862576230; 
 Thu, 13 Mar 2025 03:42:56 -0700 (PDT)
Received: from [192.168.1.20] (88-178-97-237.subs.proxad.net. [88.178.97.237])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395cb7eb92csm1699205f8f.91.2025.03.13.03.42.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Mar 2025 03:42:55 -0700 (PDT)
Message-ID: <50d39f28-3fcd-4984-a496-09c2e65c5cac@linaro.org>
Date: Thu, 13 Mar 2025 11:42:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ppc/spapr: fix default cpu for pre-9.0 machines.
To: Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: npiggin@gmail.com, berrange@redhat.com
References: <20250313094705.2361997-1-harshpb@linux.ibm.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250313094705.2361997-1-harshpb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 13/3/25 10:47, Harsh Prateek Bora wrote:
> When POWER10 CPU was made as default, we missed keeping POWER9 as
> default for older pseries releases (pre-9.0) at that time.
> This caused breakge in default cpu evaluation for older pseries
> machines and hence this fix.
> 
> Fixes: 51113013f3 ("ppc/spapr: change pseries machine default to POWER10 CPU")
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> ---
> v2: addressed review comments from Philippe, Daniel
> ---
>   hw/ppc/spapr.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index c15340a58d..825afba4f4 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -4781,6 +4781,7 @@ static void spapr_machine_8_2_class_options(MachineClass *mc)
>   {
>       spapr_machine_9_0_class_options(mc);
>       compat_props_add(mc->compat_props, hw_compat_8_2, hw_compat_8_2_len);
> +    mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power9_v2.2");

Ah, this makes more sense!

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>   }
>   
>   DEFINE_SPAPR_MACHINE(8, 2);


