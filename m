Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 681EAD2B92B
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 13:34:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8Jh7-0005hZ-Ke; Tue, 05 Nov 2024 08:34:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t8Jgw-0005dD-PT
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 08:33:56 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t8Jgv-0007bL-15
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 08:33:54 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-37d49a7207cso3442312f8f.0
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 05:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730813630; x=1731418430; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CThTI3fAaFQlbh7yNGpZawSVxzl5T/FR37+Jv0asbTI=;
 b=EUtrnDL9u0zqOFu+/OOej9iHmVeanYFe2KyCvU0cmWIx+onEFfGkxzPFNsZb+iXayO
 3f6lUZ98U9DzcBHDDYGJJ+h2n8JsiQOutLC8xzi1QqVNJZq6ZPQCexZbS+zxExFKn70K
 0h1K0Cv1m8hceDkCeMfHE/tqHk3fQ/Rolgkvd3v4XZoj5UaJVQtOxzOHe9dok1wc0PX9
 PprOzn/9bdEpHss/3ogR/nLl+t+xY5SEASoLNf5sAS4II4rvGWVCnTvTL0WGh/Aaruck
 wmY/1eQ5Pd5JcXApKmBkrEtLAA5hATA6hj+gG+eqUYtoqj7en23zvEIaEqmdH6kVLGXx
 A4rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730813630; x=1731418430;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CThTI3fAaFQlbh7yNGpZawSVxzl5T/FR37+Jv0asbTI=;
 b=esIc0WKuptIvDELG9sN8aevpXG/FG/688eBmiWW6OJmcyLdcCkyNwM/rBalCuT0TuP
 gw/ed227wDIH6rFxr7JZSCaXTWzDFwxjnBopPodB4PJ6rhG8aOoV2O/BtQn1OFDIXkTX
 o+4WSYvhF5ibOUCtePdpelWmbHibSgI9jKTNbuEzrYeWwLZLIoYmID1gCzelQk97Pp5V
 rWs/V7mSwaxJBVcxNeJL5KiLasEdCkujghiyWCGOmAQMyJc04Rq87zn1WIKfNmNiriU2
 xerSbkCryiPsd4CVcO9RYhWYXkVuDpzOxP3/aW6wPTFkzz7GHIWVgfxz6iFu9WBkOlV4
 rMbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1xSjPQDq5j7K4dP0E5qo4SQS8sDwm8NMp5UKk3uTVbRKpt1coeVVbBrWV+d4yEll+BPebvpuFdZ9W@nongnu.org
X-Gm-Message-State: AOJu0YwuI1LzVMIuPJzjXmltx0ZqsVrdscdljwZhvReYNQLp2m6GSx4a
 kRNJYci2B9dLgFfsdcmpEl4fOlG8DTLKZFCtpjj7UnJ+fOqMX6FwU/pnaZga+ow=
X-Google-Smtp-Source: AGHT+IFi80glbWZ4unVc0D1DrMsL3ogmUhFN+PDWRJwgQcUVATatcYxSEf3RHRxRiLHt3Ks48yll6Q==
X-Received: by 2002:a05:6000:156e:b0:37d:33ab:de30 with SMTP id
 ffacd0b85a97d-381c7a3a535mr12808921f8f.8.1730813630250; 
 Tue, 05 Nov 2024 05:33:50 -0800 (PST)
Received: from [192.168.21.227] ([89.101.134.25])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c10b7d2bsm16217677f8f.16.2024.11.05.05.33.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Nov 2024 05:33:49 -0800 (PST)
Message-ID: <5859ac91-38a6-4f56-9d88-eb6f837f5793@linaro.org>
Date: Tue, 5 Nov 2024 13:33:47 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/19] target/microblaze: Consider endianness while
 translating code
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Anton Johansson <anjo@rev.ng>
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, devel@lists.libvirt.org,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>
References: <20241105130431.22564-1-philmd@linaro.org>
 <20241105130431.22564-17-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241105130431.22564-17-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42f.google.com
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

On 11/5/24 13:04, Philippe Mathieu-Daudé wrote:
> Consider the CPU ENDI bit, swap instructions when the CPU
> endianness doesn't match the binary one.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/microblaze/cpu.h       | 7 +++++++
>   target/microblaze/translate.c | 5 +++--
>   2 files changed, 10 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

