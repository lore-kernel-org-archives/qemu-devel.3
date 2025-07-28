Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2B7DC83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 05:13:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugG8y-00027i-GD; Mon, 28 Jul 2025 01:11:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ugG4t-0006FQ-Dz
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 01:07:11 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ugG4r-0006D8-P5
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 01:07:11 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-b3182c6d03bso4498322a12.0
 for <qemu-devel@nongnu.org>; Sun, 27 Jul 2025 22:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753679228; x=1754284028; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LeeomvkRliYrwrP4xDn787GNt7lak0BADmBXfK1zEeY=;
 b=RixaL5gymK3pYaFkXfIJsFvlo/HZO7s2GcMhCeJf7IFMx4sP5zG+ZZNyzgco0TQ4YA
 PSXsyy3eQqS4zdc2qB3WFWPSsdfcVmgNj1Ojtx4fxd8VagZuyOFS7g0cktUj2JUtHKbN
 quaQgILq/KfprRDVVuplp0N8wgmrxtpDMKAwbO6RL9AL/aKNq7/I8HEQeYkwLOftcMdh
 mhP3H1otNGt1IaT2q6iJ9tGJ2vup+3IXRgXAD03IWldz6zj58rvMo8sn8fIxPZE5D00/
 yv6zdszg+uUy6Xsg9rh1IAeby4fg6gziKGGkTaFIs5Xt3EcPQqvcRVud/oAN+38z+QiX
 XIzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753679228; x=1754284028;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LeeomvkRliYrwrP4xDn787GNt7lak0BADmBXfK1zEeY=;
 b=J8T56VcrupdgI05oy5vk/Oh0nJw6c9kSAlSn3IpOsFQTRpPmShqPBRSJezj+MluBzY
 bZ2H02mre4je+gaM0FYh/RzRTo1ycex/OyNkNCasfvIZFpKLe8H54/Oxlin5Gk6r0qAX
 j/SPCXyjpBGc1Ate9YCDLxdX7v7IxrTL1S+TsqH9inttgRHIjSyT5e1OnjXVF/jUmXAA
 uoCu8l7z3T30nh2GI35SuzHoEYH0eYINzp+jkblVRBrrOReXMTrciFdhxouiQQmoUx2i
 n5eVQYdfVOyAa3kv4bnyF9mi1mS2ENJrR4+Yi1Bd7rf3cBjjtr615eVsirsP6ucgV3+l
 Yyvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/crzCNquk65NqBupJaDwTgcCN34t4x8djbSQ9UenmBu99LqqcgOdiA/fqZwf779Ha2yOOR3hoKlg6@nongnu.org
X-Gm-Message-State: AOJu0YzQzEDwJ4s31GBvHg/2xsBHloCKuZyFK1N1OqkFVpoFD0ilYbm+
 +rSicl4Rn6dgjIwpkIK/dWVBJfO+sMVG9oFtdyIr8OKOWHmJJYEJ7I56viZIEkpO1G4yWBubT9b
 wYQlZ
X-Gm-Gg: ASbGncsooRBxFqEL6eD595w88QDX5+1nRoSVItCPN2A9oLsqDEIZXSEg8BCifgDU56V
 dMbkeKjY6aIXJcOXVoUMaYwcEhOS8+FUSlnI7/r9IA/8m/69h7jyZ7GudXEvvVrc+G/yPoKVuj5
 1OpBlG+J5VAiJTlzY0dHbInaR0LJG3FDV/nMFJxoAsQLCYFseQJbyHZPrnm87rQOOyfI79h2CEK
 TL8tje8J5vKPA1X6L5UvgoJxbr7IwDjn+KWNOamgup/isAsAODrNd+CmBorPAzcpgCyatHxdcr5
 SJZp0bpyMnjMAZu2P7jJyOxennCXy8uovIOyXqg5TzfwCUir0MnhicfFkDjb3XYEq78NsIjr8BC
 TUOyaiCxpZ79YcDjvRc69fOMUc+wqG1MlGm3l88wZe65AT/+yKfCVtivKGedJbdj1ei+R8MkwWH
 8MwrAO4b634zTe
X-Google-Smtp-Source: AGHT+IEh/dYny0ngQYUC+N3ZvuCIu+ECWtOs3Jnaj9ozmHlhQNyJAYYM04XykxYYA6MahVb/xtT5YQ==
X-Received: by 2002:a17:902:c40f:b0:234:d292:be7a with SMTP id
 d9443c01a7336-23fb3065fc9mr144150925ad.1.1753679227472; 
 Sun, 27 Jul 2025 22:07:07 -0700 (PDT)
Received: from [192.168.4.112] (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-24007d9a31bsm22508285ad.103.2025.07.27.22.07.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 27 Jul 2025 22:07:07 -0700 (PDT)
Message-ID: <b032eaf4-29ad-4016-8301-460aabaebf42@linaro.org>
Date: Sun, 27 Jul 2025 19:07:03 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/17] target/loongarch: Add common function
 loongarch_check_pte()
To: Bibo Mao <maobibo@loongson.cn>, qemu-devel@nongnu.org
References: <20250725013739.994437-1-maobibo@loongson.cn>
 <20250725013739.994437-6-maobibo@loongson.cn>
 <98090f39-b71a-4770-b9f8-9b7545e2442a@linaro.org>
 <6148a822-0ddb-8c66-9496-a158b814251d@loongson.cn>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <6148a822-0ddb-8c66-9496-a158b814251d@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
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

On 7/27/25 17:15, Bibo Mao wrote:
>>> +    uint64_t      pte;
>>> +    hwaddr        physical;
>>> +    int           ps;  /* page size shift */
>>> +    int           prot;
>>> +} mmu_context;
>>
>> QEMU coding style prefers CamelCase.
> Will do, how about the name MMUContext?

That sounds good.


r~

