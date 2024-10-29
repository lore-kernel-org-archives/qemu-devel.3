Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC6DBD3A66C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 15:46:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5oQH-0004Bo-RC; Tue, 29 Oct 2024 11:46:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t5oQG-00047v-OH
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 11:46:20 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t5oQF-0003lT-0g
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 11:46:20 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4315e62afe0so57855065e9.1
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 08:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730216777; x=1730821577; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ssB1Rg94YwUmTla3o0BYcYDWI6c4SPCfzBE2mdXUziQ=;
 b=hQzn6+BKTnq9OUojlb37Gfo2Z4GRkYUMTlw72NQm+PVpkjzF1WrgQf6F/BCH1rDDnL
 lejGs5XZXJG0P1mheyvj/Tnf8Q5eCNNF1wMKVkJEhrJ9suZCGRIcDNc2SXal4i0lGFNI
 ssxsP+hG2Fq88JcqozAWLplJTL3x0UYSfgHqYIuGwpkCP+ffm/lqFnLznTNuHqQdqPwk
 UGx6DUCgBJAaLu9DMuxYW3vFfXwCDmcLYkxhVSccyyRjjFUVqhZJEd30u3WO1Obf5p1E
 GpDSVQQuwkZsb18mwAk4V5ySJSnnNhXQTpmndduSEdu+JoG7Gae7TdxWtdgTR1mTpBzD
 9gdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730216777; x=1730821577;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ssB1Rg94YwUmTla3o0BYcYDWI6c4SPCfzBE2mdXUziQ=;
 b=m0gJI0VDZt0PIoE94jdVTRM/7jx8Ot59vL/j4sxTMFNEQfT1H2Y1GBLL+CrCLChXc7
 bixYBO/3kQI87W4DXtZmSm1bAhCHBKtxBtjUDwVCpCy0jpmX8GY+u61CO6kGpmTFOuwl
 6j59rp2AYnaIb0Ep+zA87xrKNMWwJGMx3/TRaKM9R3IEJ+y5DQlE8/mKYceGA6uxEFDM
 jEG7xCz3/7+gTASrQGdjDD9cwODTv1Is/ucVX/nAry5RmRKYe4f3QB7/hPllijfYSSiy
 RHYf/eSEwaYHkbR7XxdTUo6ZsjbjDzfcR6B86JAVXZU1ZJ+CqLkxsQeiOZjro+4dcrza
 vBpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhLyuHk+aESubbwnNscJKq46S5xQsv1OQ4+8euEzSB6zQ/AuwGHaJBhqWHraGbNZh5nszosVpoQEEX@nongnu.org
X-Gm-Message-State: AOJu0YxtCB/ZzZqESl7XJwTkTCCJ8oYB35dy8TIlB203c8oY4ZHBGO1d
 uAq9R41INt1F65FjvU7xbfr37mqpBgB2E8NBb1JHwoqVNfLOR3nbumNpDQaHOWw=
X-Google-Smtp-Source: AGHT+IHzRFsTzvqsT/mQTl1M18K9I/0K3sa81NQtEvWNWpry248Je5B2vq7Dq2I84BqAdWBBrKuwww==
X-Received: by 2002:a05:600c:350b:b0:42c:e0da:f15c with SMTP id
 5b1f17b1804b1-4319acbb947mr87609175e9.20.1730216777411; 
 Tue, 29 Oct 2024 08:46:17 -0700 (PDT)
Received: from [192.168.21.227] ([89.100.107.89])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431935f7789sm148779855e9.36.2024.10.29.08.46.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Oct 2024 08:46:17 -0700 (PDT)
Message-ID: <571547f1-3fb2-4704-904e-aa6e6f461c33@linaro.org>
Date: Tue, 29 Oct 2024 15:46:14 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/14] target/i386: use + to put flags together
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20241028151851.376355-1-pbonzini@redhat.com>
 <20241028151851.376355-15-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241028151851.376355-15-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x332.google.com
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

On 10/28/24 15:18, Paolo Bonzini wrote:
> This gives greater opportunity for reassociation on x86 targets,
> since addition can use the LEA instruction.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/cc_helper_template.h.inc | 24 ++++++++++++------------
>   1 file changed, 12 insertions(+), 12 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

