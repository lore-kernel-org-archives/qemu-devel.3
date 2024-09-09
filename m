Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D10D0ECE589
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 22:06:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snmWu-0007Og-1P; Mon, 09 Sep 2024 18:06:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1snmWi-00076M-Vr
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 18:06:30 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1snmWg-0007jw-SZ
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 18:06:28 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a8d404c7634so243280266b.3
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 15:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725919584; x=1726524384; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ns2whSMbMe/ABdoiszeYbfGXTRusR0+GwelS/obQWKA=;
 b=Wxe6Q0H4FHUSrGtmwEN5Vda8kI/7WwZVcMRzg8V04u9fa1b4T0AVxibyKSbm0mcl/1
 NemgsSZ0kL+uGlSgdf6gvQVCy6hPAFHhKO2ijYDQ5+OmNfW5MOQyaMbRWBC5ENBY0eWY
 xcnKyQS9i5Ci9gCF5DhZSFBecW1hGXGY7XjRb21CMq82BhGvTeQEKD4kIGQFm5zV+rP9
 ltiNaAr8NASQ153X+D/31Oe438c9+p+4oDbBB/f1L5TJMi8LAXaevSLyNm3NNp4Jv/Sz
 q2ibsrtzvSMWSAMpi3jAh6CuZrVRQHc/CSq0Aftr4ii3QtOgnyUjJ7WhpfYw2xClvrEm
 WmkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725919584; x=1726524384;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ns2whSMbMe/ABdoiszeYbfGXTRusR0+GwelS/obQWKA=;
 b=wyu52aXiXJ85xjpfnyeqbm2JHuEWnB1wNPZe06cajj4oXSAx5Blpq9P07HMUDy1PTk
 vdNST9DABhpiHUzYVTBRJF2n0y1jaHOBlwrXfSF2XigyaJWzGdoh0F6E16IaZ1vO3Skq
 jJEo/pV0D+H3CLv+rW1if23M/kwqjGumQOPm2aQndOFCXBYtVgPD/e9WPZ7patDEG7zx
 UmRzqcbTkmsm//P1bWskY+gogbvyZrwXntDfJFIrU6UaFJf9D78+7wN6IInhOZ/Yem2l
 2UbNxdDhfdNYeiVeGIRw9mgRquO/tVtscn3Z6sM63QOKC2hX6pEVMBRYO+vI8ab2zEoB
 LiMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVX1JORQMb8jLAZxn/I6Qj5J+T7LTxtm72sb+I1MdoWNiaSRyMXYKSSB4g+ERohu7zzs6keoDzays5E@nongnu.org
X-Gm-Message-State: AOJu0YxpQki2RBhGxHmh7rmp9fLA1+gR8S2nLf3lr56JYQeekX8mOC2E
 p9XeR+jpsYqwwi485R18zfAVqh1/+1NmRYCeErwbwxoCj9iHBu4QvCNgbeELHnQ=
X-Google-Smtp-Source: AGHT+IGwJyodfJkluauoPU243qKFDxu9VilsXwx7vSauambkAoxEqdxePYXe0bIvzeijsnFDVSN1JQ==
X-Received: by 2002:a17:907:2d24:b0:a8d:5ba1:88e6 with SMTP id
 a640c23a62f3a-a8d5ba18a22mr361909466b.28.1725919584093; 
 Mon, 09 Sep 2024 15:06:24 -0700 (PDT)
Received: from [192.168.69.100] (nsg93-h02-176-184-54-166.dsl.sta.abo.bbox.fr.
 [176.184.54.166]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25c72757sm392406366b.103.2024.09.09.15.06.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Sep 2024 15:06:23 -0700 (PDT)
Message-ID: <cadbcc79-0dc7-4cfb-80a7-44c80f1f1cfd@linaro.org>
Date: Tue, 10 Sep 2024 00:06:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 16/26] target/m68k: Remove env argument to gen_load_mode
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu, daniel@0x0f.com
References: <20240909172823.649837-1-richard.henderson@linaro.org>
 <20240909172823.649837-17-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240909172823.649837-17-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x631.google.com
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

On 9/9/24 19:28, Richard Henderson wrote:
> Use the env pointer in DisasContext.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/m68k/translate.c | 31 ++++++++++++-------------------
>   1 file changed, 12 insertions(+), 19 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


