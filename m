Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CE6CCA0FF2
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 12:33:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utmfq-0002wn-0w; Wed, 03 Sep 2025 08:33:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1utmfo-0002uW-N9
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 08:33:12 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1utmfk-0002SH-Jj
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 08:33:12 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-b043da5a55fso390060766b.0
 for <qemu-devel@nongnu.org>; Wed, 03 Sep 2025 05:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756902786; x=1757507586; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vKi1wo5buj4xFBtxxQuq3YgiXdf7blqtkt3ObkxtCko=;
 b=M5ywvyhxKopi7GsC5p4PsEnqVwBFI3vhn+X7qKtWG8CNzCvIlcUEm7lCLI86CvXbHb
 GnKFUP5WsoknJiKPrU3EnDAkt1lb8jIfOvEhSMqKQhcGQKFoQp54q//B/d1u1Cfq3sWj
 X4O1ppHEPwju8OI8VN8nHucr5qIOpRiEf3NAKLJ+c0gtRl0od14aJPnylYDHNce6M+2v
 W58F4/PTbgcOWjI7B8JI6qYzmfa9DGzrQRaX0cV8kTek5+o4YDn1YnP5GS3ybS+Wfry0
 0GHu9Pf7DWiAoaVtjMj2usszPd/BGCnOuAi+WBv+9M3sFbgmAEwwNKdEz+Y5THasigcm
 WMgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756902786; x=1757507586;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vKi1wo5buj4xFBtxxQuq3YgiXdf7blqtkt3ObkxtCko=;
 b=SxopIwXwXnpCpbzsMbcrlTWEd1y1zv49jE7kQM9HjeVr/NEf0Bb9yuvWNXvFmRnAHH
 Rd+stFu3O8PbVCvRrc7Vf2REVtXpVPB5Xipd2Cdu2/ZPNzS1udgNZFIXnxFKSXlEnRrL
 OypL2logo0JgoLo554o5D4rYiQ/HbA1+Gpx8QDqH1NAvmTaN34Mh5fTcZ+eogAAelgwT
 F27PtoPRyY+FL5Riq75gYi0LZqVT5x4VXBTylKF4SToWfzFgvASJdqAu+WzrNU17/dnL
 +EIN2JdKm2ozUCiib4v+QLCW1RX2ctnpoZ7yRdn0v+uKP31NkrPUSB15aMcu1TscT9zG
 emqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNcNNX63E9KLcnHSHNt9mqWDTyS+3gbmE8JjNiP9D6DI2GGC5KmEJ2UqSwPH3XANqoyU19GsqN1LoM@nongnu.org
X-Gm-Message-State: AOJu0Yxq8auLWIcHjbwA9/Q0ChyTOfsLuV8FAODD768tod9qrofg1/I/
 gOu0fMAJy3YakE80OI0VMhNnTJCIDX0yOawOCFztlZAdITc2YB32O4Geltb5mJ5eCfE=
X-Gm-Gg: ASbGncugKVhhgbI/mO0dgQ3xabB5m4TH7k8V7JaV8qnCZDkW1YDxocm42u2qcO+wmpK
 AVA5boEM7HWk4Ib21+5OWdnTXl+VNnZaQjnxvLJcLyBatZVp819LtPpZzcfx0YxAgsieDOZPKlC
 DnSJ2qgxmxVebYmGsiMaT2F/S3IGmqTpkHDWeIcdwR+9SNyUh8dsyHIfph/IxXvHmyh6pYvBJN4
 tw9D6vohfuYHBADnoTEQHLtsPte+mXI1kpQ7rn1Ve8U86/kJP4WhrJOhVnRwtuN6MquniWPBIDc
 SPtBYG+aV8O66UUdHv6V05ohkmN7cK3Jubt3vlOQUf4qIULbgiCt0o2NzAcg5PO9FJ7GNt8gfW9
 98F2sjAKZVzpJ/PK7asXZqevhE4yTCEHQaYFYxke9PtXza/woPEFQy3JGY1zbYBulCwFCFvdBxc
 EqmRk5KQ==
X-Google-Smtp-Source: AGHT+IGMQ8RtHjFgncqJMgx8QCn9gi7OOCewGeMOb4mRr0w/vckxw4Een8xe0qMo3I0TBLKUkT/40A==
X-Received: by 2002:a17:906:694a:b0:b04:25ae:6c76 with SMTP id
 a640c23a62f3a-b0425ae7255mr862111666b.47.1756902785656; 
 Wed, 03 Sep 2025 05:33:05 -0700 (PDT)
Received: from [10.40.6.207] (93-51-222-138.ip268.fastwebnet.it.
 [93.51.222.138]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b0416842ffasm903543666b.38.2025.09.03.05.33.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Sep 2025 05:33:05 -0700 (PDT)
Message-ID: <f736e11a-1d46-442d-9268-e28fa67848e1@linaro.org>
Date: Wed, 3 Sep 2025 14:33:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/24] accel/hvf: Mention hvf_arch_init_vcpu() must run on
 vCPU thread
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>, Mads Ynddal <mads@ynddal.dk>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20250903100702.16726-1-philmd@linaro.org>
 <20250903100702.16726-8-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250903100702.16726-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x629.google.com
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

On 9/3/25 12:06, Philippe Mathieu-Daudé wrote:
> hvf_arch_init_vcpu(), along with hvf_put_guest_debug_registers()
> and hvf_put_gdbstub_debug_registers(), calls hv_vcpu_set_sys_reg(),
> which must run on a vCPU. Mention they also must.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/system/hvf_int.h | 3 ++-
>   target/arm/hvf/hvf.c     | 2 ++
>   2 files changed, 4 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

