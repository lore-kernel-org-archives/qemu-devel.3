Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA0FBD35E5D
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 10:19:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8zb2-0007U4-6r; Thu, 07 Nov 2024 05:18:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t8zaz-0007Te-Sh
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 05:18:33 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t8zay-0000kL-AB
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 05:18:33 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-37d4821e6b4so448077f8f.3
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2024 02:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730974710; x=1731579510; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5Ot6nktp9ukXes2MHl6aaiewWQLD/hREeaP9cLER83g=;
 b=bXbn+mRocdhkxCRA6h3M0evOIkCdpa3XIxFTpeASkWVQ6Ip1ofyX4sof6mvK39k8t1
 OCFKQUH59Q+fg9+N+878kvNFZw7zWH9EJMLg5soGt78Cq5EKjjZjtLvvWxmrYDZ5Mdyf
 JQ906kcVsZweHDoXaXDr/W32CSUOoPB3IeGNxB5ljeee9dpZc7w7aWu+1FhGe+FCxAfD
 x6SHDJwd9c0iGgaCOdqfdhhFH9bDYkfl9ln1gREg8ose4qZoXnlpfsFNfRgh8Nslz98B
 mcwdAhQwvvlyfD3w1JlBR4XTuZUdWB4rtoCvSMk1Yy5hqUODmidkvsdAy/jK+RzenQXc
 oU6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730974710; x=1731579510;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5Ot6nktp9ukXes2MHl6aaiewWQLD/hREeaP9cLER83g=;
 b=j+qT9511TtzmwTdM0JIcB7Q9P8OK0XPeM0sQRspWJYlP9Ezq882AmxRtWL/sU8J0Qz
 NGJ+Kc8uNdLQmOAsLmwJ6t6qHHnxqe7/m3v2kMaqMfDGDcXmKUjwX+bBGVpw91HFu0iS
 7rQUoRyeh06BtvZFl4KTMJupQqqBl//aCK8WTwHILKPsCrOBnBI5r2SXjziRzQUcCwgw
 LgIeDwmgSt2ZMSnqZ+qei0JfrLV0Y5hrYkVVP/C6FY7reaQOyBQwDnMEzJV/CB1b/5nS
 IJDTWBIQxTWfiihTRfLBRTUbA2vjXjCuhoq+cA1sRl40eDrRqxY5FJMQEdzbctXmSxfD
 KJig==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvTA64X8z6mKNDZEJKIVGPLK4NjQ9wsI1cSJHfyBVb7NYRpux84M+h0tus+Bo9HDI18fu9xqzqK3wf@nongnu.org
X-Gm-Message-State: AOJu0Yyjw0uRFM61Oxp6qM604Pio9BEEz5PavYTuOr/QMjL6oczJvd7N
 NCWE3j5O8MENI6QimfavwUoXMrBgp3xKZPcPxnoBN6pKI+V18k/myOmuX3J3pu4=
X-Google-Smtp-Source: AGHT+IF/U7IbRSKOse8zeUIMD6XryT5wgWiSArMwzVoaevFziGoea2HYsgaXaK3fu+Z6PXW1ytPgFw==
X-Received: by 2002:adf:f305:0:b0:37c:cdb6:6a9e with SMTP id
 ffacd0b85a97d-380610f2ed0mr30247401f8f.9.1730974710484; 
 Thu, 07 Nov 2024 02:18:30 -0800 (PST)
Received: from [172.16.23.118] ([154.14.63.34])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381ed9f8f0asm1334389f8f.79.2024.11.07.02.18.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Nov 2024 02:18:30 -0800 (PST)
Message-ID: <1f0768f1-6b7b-40e8-ab37-0298a08789d7@linaro.org>
Date: Thu, 7 Nov 2024 10:18:28 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/16] hw/timer/xilinx_timer: Make device endianness
 configurable
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
References: <20241107012223.94337-1-philmd@linaro.org>
 <20241107012223.94337-7-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241107012223.94337-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42a.google.com
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

On 11/7/24 01:22, Philippe Mathieu-Daudé wrote:
> Replace the DEVICE_NATIVE_ENDIAN MemoryRegionOps by a pair
> of DEVICE_LITTLE_ENDIAN / DEVICE_BIG_ENDIAN.
> Add the "little-endian" property to select the device
> endianness, defaulting to little endian.
> Set the proper endianness for each machine using the device.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/microblaze/petalogix_ml605_mmu.c      |  1 +
>   hw/microblaze/petalogix_s3adsp1800_mmu.c |  1 +
>   hw/ppc/virtex_ml507.c                    |  1 +
>   hw/timer/xilinx_timer.c                  | 46 +++++++++++++++++-------
>   4 files changed, 36 insertions(+), 13 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

