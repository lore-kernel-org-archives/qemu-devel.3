Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27DFCC0219E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 16:30:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thWft-0008GV-AM; Mon, 10 Feb 2025 11:30:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1thWfm-0008Fi-TT
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 11:30:16 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1thWfl-0004DH-DJ
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 11:30:14 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-21f61b01630so43242025ad.1
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 08:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739205012; x=1739809812; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8XkQThXuDSBy0G4kTPouRSFGciVwaIQ3LzaHA1qWh/w=;
 b=m4O02bBS5M1i9VUDt8R824lAaesIHK3Xprl6HgI1qluFFhurH4GlmlzpjaHmoWYJHA
 hUHw/d3Bt0fjAENPKUwyIPdaVC09dNbUDvZcPOVdzo/74ywC2OudjzLB42nEShDYlKxc
 IceYtB0wtjDmLStoGvnfmgCssQX9VVzhuWllUt6PDoWiEZz22YxoFlxOP41MbiFoIDUx
 pjKbeOwtoCl0NFiWfiTDQcc1/vRH1A5V5cBrmTa2rK2YPgS8qmAzhh91nURPgvXREi96
 PAvYkO+9gbYjBH/gDc07U/MObvs2FURqAbGMlzYDsommKE+GxGNpknLefzCWUAuCy+lI
 Jtuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739205012; x=1739809812;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8XkQThXuDSBy0G4kTPouRSFGciVwaIQ3LzaHA1qWh/w=;
 b=wczda3E03Rmw1FexThsIcBxOv0KYVDQYLl8k+JGbVjGkTBILfg5DETCemXe38KNqje
 jX7LVNbxgzqcDY1a10K1PB+/bvACOSTEC1vxfk5X5hDxlP8LkATZQ3S5b2uek/mu61/N
 ZcVwZl+RmWQX6zxmitxQ9f8k8dDx2cP9r7tIuB4tHWdaj1u0+ejlicznK+I77TeHsuNJ
 WyCG6PAy2EW4MHlUzgkQ+axEIduAaxA9pLyIarB1O83XHZViuvQ9WBz4jfvRNPdbyDBW
 ilXueXJhmXgvb/MQGbjx+nv8jm1tv6JGGtcZhWhyupK0X9qC4CO9dcSruDpZEDErlzcl
 RpeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUagc2+nyPwXDxr/KWGOepiMR1tKGYHGfghBLGQeR0QHgIBg7OcgzuUiQgcFgxUnbcSZ6UuZucCURq3@nongnu.org
X-Gm-Message-State: AOJu0YyZV8JFuBQpQY6acIq5qoUj6VWW5AzcMmmbkDknrT7mPXv5/WkZ
 +KRSzRLtP9UP8LgVpj3CuCxe+Ko7PmKaRX0D0LqM60fyJODzR7Dp9u+DozZI+Uc=
X-Gm-Gg: ASbGnctQIJQ1yEBsvvl3LJYS4l+VCTA9SaESqYsbmB8/8dNiJ9tyDV5t8Cu/LygmS/a
 +BoVsnqajd3CFy+keaAr8zrWINO/ZJZ2IxwmQTiF9pwr7YJ8ApreMG3qwFPB4Ou+b8Sl2eSm/ds
 dy4cr9AINZSnwxszaYY85nlbs2+63xp2wu/qIQYgGKlemC++/J8pTfJVvCPlG4daa7BgLGhZnB3
 A/iaMe9yI68jfvlM/tAXowdVZlak/L6HWXN2R5p9Ho5SS8ZqIE/zvhCjkjidAecgb69EyoCLd/F
 cmAxv2kBayh3QNYFSoFtAewS4i03iFSMYI1kvx68B/EUvOoz/9Hcby0=
X-Google-Smtp-Source: AGHT+IEFYlDJGM1/AS28l4+whb5qhsoRNRE+QlZHx5oUrCbKiPL3lD2qUWKiY1QK5LdHJzqOdhJcVg==
X-Received: by 2002:a05:6a00:909c:b0:725:4915:c0f with SMTP id
 d2e1a72fcca58-7305e504eaemr22538685b3a.11.1739205011600; 
 Mon, 10 Feb 2025 08:30:11 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7308cef0957sm2346297b3a.5.2025.02.10.08.30.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2025 08:30:11 -0800 (PST)
Message-ID: <cbaa7fd6-594d-4ddb-90a6-6111fbac7c36@linaro.org>
Date: Mon, 10 Feb 2025 08:30:09 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/11] target/sparc: Constify SPARCCPUClass::cpu_def
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
References: <20250210133134.90879-1-philmd@linaro.org>
 <20250210133134.90879-3-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250210133134.90879-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

On 2/10/25 05:31, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/sparc/cpu.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
> index dda811503b5..462bcb6c0e6 100644
> --- a/target/sparc/cpu.h
> +++ b/target/sparc/cpu.h
> @@ -574,7 +574,7 @@ struct SPARCCPUClass {
>   
>       DeviceRealize parent_realize;
>       ResettablePhases parent_phases;
> -    sparc_def_t *cpu_def;
> +    const sparc_def_t *cpu_def;
>   };
>   
>   #ifndef CONFIG_USER_ONLY

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

