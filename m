Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08A1FCE8D6B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 09:42:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKvkx-0005Ec-QU; Mon, 17 Nov 2025 04:42:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vKvko-0004zv-Oz
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 04:42:36 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vKvkm-0006fp-Ct
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 04:42:34 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-47775fb6c56so43423125e9.1
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 01:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763372550; x=1763977350; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mzuxWBLYmztdE1hA6596Vt2GcnY2LEN6ojcn/svKNGY=;
 b=o91rooiIRyPxF7Eo6UdHal8fdsglM+7BOg/IIvjXm1JFzQtIIN3+VGYiLZ+Wrz0Jvn
 YYPBZik+xQ2fTsa9O2tlOsBevvaPQzrxUmL51yQUxfueZ4fDoXsG0lCY23hqinvrxik3
 0hd6VE1CSnC70Mnjd6PAtObYidV/nTLMRHlQJLRYlfO3F4BqHw/JV7BLm+4/XWcs7ntw
 1T2SNSfjHoEDUAT56IjVgky1mgzq3JYu/PwMYKlREVVNwI1tXxTO+XoWuBkbp7lVcVPm
 iexonmrJuElEzkK1TLTLdU8VYGCA2thCRacviCCNEhDcgIo/QYJpxPEg/mPD+UR0OsUB
 Fnjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763372550; x=1763977350;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mzuxWBLYmztdE1hA6596Vt2GcnY2LEN6ojcn/svKNGY=;
 b=VWq/5SUlYaxOchXnffGaGB0fOb1fBMZwq10IOTWOuH1jG1kI1VKvIODZIN3ymmWyzM
 rTKD2ada0yhTv6vqVlHcEg/bntGAaiGuF1BAX0xzvNmUVxHbvKEAoStcjnL01MR8kJRU
 VZH+V8S02RNuThPe3viOZ2LhuoS142lcx4GA7Y+fDgI5Qy0xPeAS5bw1TjL4h2Qf3DUk
 Mivjg9Z7Yk8qlSD7NYnDkCTRDnD231Kw6xC5xHgSyDaz6NokCnCBY0cr+EtiLKwT2DoQ
 NC6D/w7BFsyHwrCH2WuWX1sSCe1EtYnqHcKjF09m+wC5W3WDOS1N59Q/AWF/ZpOEDKfu
 5eEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVo/cKI54Iajn318FxKQLJrZdccbDovmcmKtt3a0JELsS1esrzEf6WH+83LmSamPMChVKWdE0YVKIhI@nongnu.org
X-Gm-Message-State: AOJu0YxfmuOXzb2kv97XC6CB4TyEVOtmipU55686woJH7hmLwQL74b12
 ig0t90f3BI7dEm21TtGrkuXfUshzFXH2wNXyU59G+EOyixpGVPkh4Www4Ks0aRQYP8c=
X-Gm-Gg: ASbGncu0iTqldLi7b4Y1oqQp073GFsB5L3Q8IWsnTTsE4rXgHUE82XH+GCMg96aVbYn
 Tms/PPgSWPTucCiz70phK6yoNbAx/VPBGha71HI/QNH7YbO1dhTlyxMEkaFNXwT3b5SUAF8H4Fa
 0Z7Zh9V4eT4TgJEg4WDhjrCo7klNo4RQcCEBK2OZb6ni/d1VkCpbhrALNYkqdXzCGRrzoBaGuqW
 5miNoKVu/8lIh+9vDugS2n5kmZbk51bjSJblgaKWPbZ+sshtcI6Ljp4BTX0iWPULkjBzsL3dtFe
 Wo90N7ix5s1a2Hb9vZv6zw5TPF0QGnN9ZQLsZlqHR75D1RClGbyT+ujV1/ghsUrbjl22p1lWoUV
 L+q8YZUBHlU4Tr+G/M3eg/gjcD+FbDNENIrwDpnRjzLhWBN/PyTNn/RE3jAacXv25iALrgjhjRd
 uaupx6zlXEgNhiQX57H2X/O/reQ66TZahwP2/ZG6B4zli7GyRD2I0hcBv6w+7OmeKUxcAnL8s=
X-Google-Smtp-Source: AGHT+IFq3ZSEIEge3MGT+aLlf4Cq9Sdb6OMyKw5CoBf7Gc1WP4j98t1V3XazYNwWBOStHAk9TmaZDQ==
X-Received: by 2002:a05:600c:1c20:b0:477:5b0a:e616 with SMTP id
 5b1f17b1804b1-4778fe4f635mr112198145e9.5.1763372550303; 
 Mon, 17 Nov 2025 01:42:30 -0800 (PST)
Received: from [192.168.8.105] (66.red-37-158-132.dynamicip.rima-tde.net.
 [37.158.132.66]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477980cb1aasm57983285e9.8.2025.11.17.01.42.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Nov 2025 01:42:29 -0800 (PST)
Message-ID: <3e215a17-11ed-4172-9598-42a2e1bd9e9e@linaro.org>
Date: Mon, 17 Nov 2025 10:42:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386: svm: fix sign extension of exit code
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
References: <20251115002644.103889-1-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251115002644.103889-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32f.google.com
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

On 11/15/25 01:26, Paolo Bonzini wrote:
> -void cpu_vmexit(CPUX86State *env, uint32_t exit_code, uint64_t exit_info_1,
> +void cpu_vmexit(CPUX86State *env, uint64_t exit_code, uint64_t exit_info_1,
>                   uintptr_t retaddr)
>   {
>       CPUState *cs = env_cpu(env);
> @@ -732,7 +732,7 @@ void cpu_vmexit(CPUX86State *env, uint32_t exit_code, uint64_t exit_info_1,
>   
>       qemu_log_mask(CPU_LOG_TB_IN_ASM, "vmexit(%08x, %016" PRIx64 ", %016"
>                     PRIx64 ", " TARGET_FMT_lx ")!\n",
> -                  exit_code, exit_info_1,
> +                  (uint32_t)exit_code, exit_info_1,

Why cast instead of printing all 64 bits?

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

