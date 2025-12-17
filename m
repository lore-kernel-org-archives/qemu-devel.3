Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9ECCD66B9A
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 19:08:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVwsI-0003e7-2U; Wed, 17 Dec 2025 14:07:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vVwsB-0003dW-9R
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 14:07:43 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vVws6-00005b-Pf
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 14:07:40 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-7b9387df58cso9397183b3a.3
 for <qemu-devel@nongnu.org>; Wed, 17 Dec 2025 11:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765998457; x=1766603257; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=M2Ij+TO9IRQQJ4HqFs4hJR0Jsov4OObzjS5ZcJ40pLQ=;
 b=Eq2K+6ABe2tZi74ss+g/3T0yNfM06JMn8bUlCg8QP6afFYcW3cCTVMYtgpT9ihpUy2
 JZ5YtNpKXaCHQtqEtqLL478OPV31CdkghLzwZbdbR1VyBmnV4ASSpE8p2oDYnYpbBU+k
 0ug4cmSYjLUoOa0Ko3tpIMPXHgtNxnQjYQ/xCC1hmfCSveAp9uokYTTanQZpmZkXnmJJ
 8FqahDwfq4QxP3txqtDWCsoKysTS9sYbDFXDekWcOPXfos447wYLZ09Js/WN/r4Pjo+K
 q/wICzPOidGjzaV0hXkgT0wXP+HaInOJL3h6lipLOyDPpko52FPQVOyXK4+NsI8AYM/o
 boxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765998457; x=1766603257;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=M2Ij+TO9IRQQJ4HqFs4hJR0Jsov4OObzjS5ZcJ40pLQ=;
 b=FyFctKJzUJKwYbSSE6y8+7TgTW8I+azTlOL1BRQXRxsoE5I1puy9I0cSLu0SAU02UZ
 lWDsYWhDKMwdSkhEs8jxUD4Z9VYeKoxevEFXWwOy04+eYrrKBzHNGrH1cdckX9TZnGdY
 S8pBs8gogpOvLzpw5vfbLWZVXnZLbDb8qvY8i3lOmaaTxTOcxr4NonyjhCz630eIcmls
 3LLE9FU45tuDhE915a53VITZp/WnKpxEZkKRO3RqyLTLox10Ceesqq37RYuBmU+Zb/P6
 2hdx9ffU+Z6WNgTAlNYYs1xz3OiugcCjXD03qorvzLyNcm6mlVh3LcfBJKTeLCymJJZ4
 12YA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcXdXI18EQHAls4NFiCyA2nXipGfCQE5DrMbCUaz6OCiMc/JT6n1kZgkpOiNQAWxcH2eKwTt8MZUhp@nongnu.org
X-Gm-Message-State: AOJu0Yw0SVL3LQwx7geQnNdIaw54E7agI+OFrvapFTfeizjKz4LxUBGl
 ndpVIXvjlW1+JMJeFdGsiGh8o4Zk6wP7qN54KoDeMQFUKeVsptskyYh/v+eFo6u2q8k=
X-Gm-Gg: AY/fxX5tNVuiVPbNgsnDoO2VAInFqzzK/AyOKHsQ3tq+cT8wxHv/qtkt9FRWPz+HR+v
 kTcSIWi2CMY7ySUdAbGsIfNGxaLiw57G186l3CqxlOibfb/nOr5+HxwC0fXSjgRiLcyAZWZDDLw
 9SmTdfeuelRqQ/YnHfhm4XjLazruda8HIqaPZWeadh3ld69NOeU2XACILRaVH5Pf/ACRZZedmFC
 KRWreTwQ6gRVOpUfFPUMzKr+LvJn7qXuvhRRDkCAMAe6nHRkXn3EJPrUS4FAMQAaVgrrQySr5mC
 0aDxtsbumMQjQHAkvnuGtZByfvgv0gtBlYcpYtMr0awJKE479GcHz6CJ7OEoDG22taaOOI7Acdp
 6DidDJELENp4NeoKpiJtAxsypkGINOqdZL06QN2j8rrFkQC6SMuU48KjjnMZTo99F+qAdzAmSHq
 mcCNpCgFmFpc1A0+Jbz42MRFRsAfe2JA==
X-Google-Smtp-Source: AGHT+IEnDs5mIT1HNCcg9ffKMB0EZQiDJkFPBSZOh8kfm7rzi/91q9+/2pUJpcZalI0aADnuz9oyeQ==
X-Received: by 2002:a05:6a20:a11e:b0:35f:2293:877f with SMTP id
 adf61e73a8af0-369ae4902e4mr21270864637.33.1765998457108; 
 Wed, 17 Dec 2025 11:07:37 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.245])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c1d308bb972sm120798a12.36.2025.12.17.11.07.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Dec 2025 11:07:36 -0800 (PST)
Message-ID: <1d89855a-a760-411b-ba2b-a828564b1c78@linaro.org>
Date: Thu, 18 Dec 2025 06:07:27 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/14] hw/arm: Update bootloader generated with '-kernel'
 using stl_phys()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 David Hildenbrand <david@kernel.org>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>
References: <20251217143150.94463-1-philmd@linaro.org>
 <20251217143150.94463-4-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251217143150.94463-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

On 12/18/25 01:31, Philippe Mathieu-Daudé wrote:
> When the MemTxAttrs value is not specified and no MemTxResult
> provided, address_space_ld/st() is equivalent to the simpler
> ld/st_phys() API variant. Use the latter.
> 
> The _notdirty() variant is supposed to/not/ mark the updated
> CODE page as dirty, to not re-translate it. However this code
> is only used with the '-kernel' CLI option after the machine
> is created and/before/ the vCPUs run, and*only* during the
> first (cold) reset; not during following (hot) resets. The
> optimisation is totally not justified, since we haven't
> translated any guest code yet. Replace by the normal stl_phys()
> helper.
> 
> Suggested-by: Richard Henderson<richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/arm/aspeed.c | 3 +--
>   hw/arm/boot.c   | 6 ++----
>   2 files changed, 3 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

