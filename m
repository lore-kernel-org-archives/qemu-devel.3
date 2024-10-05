Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 092F2CF8869
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2024 01:14:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swtMW-0004tk-T9; Fri, 04 Oct 2024 21:13:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1swtMO-0004sO-JU
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 21:13:28 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1swtMM-0004cy-SX
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 21:13:28 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-7e9f998e1e4so123607a12.1
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2024 18:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728090804; x=1728695604; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EJRRWqzkhEEsiiuXDawiHMWnOpeb7W+mfMDLB8750A8=;
 b=ySzVc49DnTmtryKSKNvx1k8bw3oqbx8MTN19tIQyp/YpOVTa3lFKEC065VqJEpaTsp
 NGdg3Z20pyJNVheU7RxomSShR5M42q7w0agKpIfY7oJehZIGTGOEnDCOjAtuj6O8BJZW
 P9lenf0tgCkUuGCfgQI1fpUzfvuvz6lG9VDgTN7zmOPr6MvwudAdMLLi5+Sk8e8+kS2I
 sc0bp+0ElYuX2z2LRNWoeUArniRl7NZ2ff5f6E/v9gOyGEaDNmyHEisLW6hLFh4ZAs+2
 In3QJe0b6YRm2KAgUR2tCMMaLyx0KVkOvj/aQbANvLRubs1PloW4kgdtEvexvh7UlvlT
 EOzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728090804; x=1728695604;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EJRRWqzkhEEsiiuXDawiHMWnOpeb7W+mfMDLB8750A8=;
 b=s6PQhmXHPLbeknvmsPZuK2oDcP9tQGcZS6XA5Rweua1uFfwPYjiIniI9GY6fdM16jw
 JmIT6U8qUvs0pIshyunTazIjUx5MMp1JuqAnKgh3TLCXQuVH9Ijfg+2eBgTEp3rpg+92
 RjbfbEgLnQtxuQ5CyYfy+LYtPc7dSM9UA9fdTISP7mgLRLDjsZHQ2rQ9RWcs2j3CAitk
 RctOKYERTUMyzPf3hVup7gf/xG5zJo3qWJKoE2FuD0QRbBW+b297jcq0TnAniVASjfvh
 3QGXifQRJ7SKTP3fqdX3T9cU+85E4Ou/0LBehQARgLOKXHqw23zafq6QRPfrcPP2wHMh
 NdvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVomxoBFREmxQwvz/jkboutf+Uul2MjQCRoHO6VjJ7+dKR/jtNyvl8e81kMD3yGYFUxWrQJlrrHaACJ@nongnu.org
X-Gm-Message-State: AOJu0YxR0oQZlOZi5Io+0c7h5yfoooBdg5jxFFL0Ar01HESvVmz/ge7w
 b8pys6TU5MZVtW16+4KEoHZVJr6LjrUeqjbX6skOmFD1J8p0yrkuug3sCXUnChQ=
X-Google-Smtp-Source: AGHT+IEiHBu1Ijn5d1Kaarw6gC7/ht1fxt7RTstZ+4Uwp41BAPPSYa82MAB2k8OgL+uRHZNmxwDhZQ==
X-Received: by 2002:a05:6a20:6f91:b0:1d2:f00e:47bb with SMTP id
 adf61e73a8af0-1d6dfa417a1mr5979511637.21.1728090804432; 
 Fri, 04 Oct 2024 18:13:24 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7e9f6833cdcsm644781a12.49.2024.10.04.18.13.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Oct 2024 18:13:24 -0700 (PDT)
Message-ID: <9ad4d5c9-7f47-40dd-a180-023282e4f459@linaro.org>
Date: Fri, 4 Oct 2024 18:13:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/25] gdbstub/helpers: Introduce ldtul_$endian_p()
 helpers
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-ppc@nongnu.org
References: <20241004163042.85922-1-philmd@linaro.org>
 <20241004163042.85922-6-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241004163042.85922-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
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

On 10/4/24 09:30, Philippe Mathieu-Daudé wrote:
> Introduce ldtul_le_p() and ldtul_be_p() to use directly
> in place of ldtul_p() when a target endianness is fixed.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/gdbstub/helpers.h | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/include/gdbstub/helpers.h b/include/gdbstub/helpers.h
> index fd83e366a51..e783d166865 100644
> --- a/include/gdbstub/helpers.h
> +++ b/include/gdbstub/helpers.h
> @@ -99,5 +99,7 @@ static inline uint8_t *gdb_get_reg_ptr(GByteArray *buf, int len)
>   #endif
>   
>   #define ldtul_p(addr) ldn_p(addr, TARGET_LONG_SIZE)
> +#define ldtul_le_p(addr) ldn_le_p(addr, TARGET_LONG_SIZE)
> +#define ldtul_be_p(addr) ldn_be_p(addr, TARGET_LONG_SIZE)

I'd be happier if these were defined in the preceeding ifdef for now.


r~

