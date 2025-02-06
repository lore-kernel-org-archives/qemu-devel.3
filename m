Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AAD7C02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 21:34:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg9UW-0001F0-HI; Thu, 06 Feb 2025 16:32:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tg9UV-0001En-Cl
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 16:32:55 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tg9US-0006z1-JZ
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 16:32:55 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-21f49bd087cso10219805ad.0
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 13:32:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738877571; x=1739482371; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mfvmlnluusUMUpKk6ZL+inlTMfV1gsd+jaZ0lcL/wLE=;
 b=fM7buvkyMRdvlUeGs4AGZSlMZFbdwi3VNWbcDSmWJN1NO/Rg1Xw/CEaJzOc7BECc/N
 gZCdIq95H0XXMS/PBu0BepW6hs3vmUqbu7LhI8pEQjqFgMEuA4O19DLRgNt6nRJ1nEyQ
 lYseaqxrrLPyhSVZSzDTb/1WRXK+rfNxYiOsekFv3ewDf2ANT4pxMt25bZ8Iz0kRAo+4
 jAvVLRu5p2ulnrS10SsCfH+TeibYBCXM8W6Lu5pusKC1tZa3D9XzATUisYzA9nXz18Va
 MflQXbM6xe4xKEvJeAPuAhWbjIIAheXTrjN9U7hjYfFuEA0yD9XAKOypjUgxZXbpTUYJ
 g6hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738877571; x=1739482371;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mfvmlnluusUMUpKk6ZL+inlTMfV1gsd+jaZ0lcL/wLE=;
 b=MNMqD5iiVipOggWXyPfUCf5b1RR+CPfhMd1UafnficD4Pw5qI3PSPtXASWmOSZrRTK
 vB+nmo3z0blC4tNxdEkBevvtQS6kImPPP4Q9p9cAyi6hx9CoASUYA00sJSZj7MBHR5Yv
 HAgc4zRfEQsP4GrzsHe8MnTdVLTmBSgqh8ge6abWU/iobWxmMWWxrZWTWh8KYjdfjyYk
 0o8rMFEfQtQ5u4q9mWxAm46VCr+lKXczsQ6w4tJfM+aCaDJYrakrACjtQXhPLEeQatZQ
 8lHZwYz2qlzKsGJjCBbKHsmGeYCLJ+djPoXcyIbWSr9zeL7CPdkzbTDa3RicxnIcEym7
 hlGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhFej4S9D1zun7lFw3qJhmBj9EPUVTe3ZZy5eiKE+k4x3xe7XbPERRfF29DAjjBv6PsxpwTbSLulWr@nongnu.org
X-Gm-Message-State: AOJu0YwahKjPT3iH4hA336fK9by7XGCMMlZ7bzoUF904qA2Ai9wvo9qt
 8CCQ+2v+7y4CGS/hP+bKXVln3SEgDnJBcedWHFFnmRkrnT0S1qzX3gsKCtQR0lyxsYUuJlkisEd
 0
X-Gm-Gg: ASbGnct06pxPZBHDjL5GDTSyftUkhDa80co2IfS3VVeo+VCmMeKh7ScWJyfjHhbPQWY
 JXD452FC8FOJsKQKJOnA45z/YuK/CCz+NtjBpwrEdY3uQ1TjauWjXC1DVi0lmbR4GXsG3KEdmkC
 mW06e1/2GhisiB8iKHCrgWdBJ6WEjn8u26QFrUi4AoO+exMM8m+YIsQ92g1jiDFoZPuG2+GKJdL
 2ODoCnywk11HJYwojSBVPqUTniQI3VOE8MU1tj5+otVuUloOfr34ha8Zms0uWfmbZh5+N65VbMC
 jDt6DlAhufTskeQ0AbSkAq2t20P91k6s2WRC8VklmUDffcfPRzmEtq8=
X-Google-Smtp-Source: AGHT+IGTuD0YEfe2wVYILIoLLR3Q778sh4nd+uvjrdbkjS4LzyLl44HrCDoZ1pqrWdgu3VP3GODuig==
X-Received: by 2002:a17:902:e802:b0:21f:4c8b:c514 with SMTP id
 d9443c01a7336-21f4e76391amr12106185ad.45.1738877570744; 
 Thu, 06 Feb 2025 13:32:50 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f3653ca1csm17568245ad.58.2025.02.06.13.32.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2025 13:32:50 -0800 (PST)
Message-ID: <09a180ed-ee76-4dec-b6f1-1977c4fe2cb8@linaro.org>
Date: Thu, 6 Feb 2025 13:32:48 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/16] hw/net/xilinx_ethlite: Make device endianness
 configurable
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Anton Johansson <anjo@rev.ng>,
 Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <20250206131052.30207-1-philmd@linaro.org>
 <20250206131052.30207-3-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250206131052.30207-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

On 2/6/25 05:10, Philippe Mathieu-Daudé wrote:
> Replace the DEVICE_NATIVE_ENDIAN MemoryRegionOps by a pair
> of DEVICE_LITTLE_ENDIAN / DEVICE_BIG_ENDIAN.
> Add the "little-endian" property to select the device
> endianness, defaulting to little endian.
> Set the proper endianness on the single machine using the
> device.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/microblaze/petalogix_s3adsp1800_mmu.c |  1 +
>   hw/net/xilinx_ethlite.c                  | 20 ++++++++++++++------
>   2 files changed, 15 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

