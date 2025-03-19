Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9256C35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 11:58:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tus3k-0003t6-8s; Wed, 19 Mar 2025 07:58:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tus3i-0003rD-Ll
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 07:58:06 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tus3f-0001ib-9o
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 07:58:05 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3914bc3e01aso4507441f8f.2
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 04:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742385481; x=1742990281; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HrdUg/alY/vauKYZ6SVnOhEYzyiRi5BZkZ3o/ZgY0f0=;
 b=sAPj/xbxcySFDSyOf56dLK/sZ4lMiEwRJ9Be3olZRE9HNqwPLyfMwEowgvPAfIDJmM
 AVXwQScFdURMadhcOU4wJBzqcD94SEdQ354Q1U0Z1626zzCVDt7nhb9DJhoO3gxEhH2t
 FFO12LeajDPvSD5VL+gTNuZV9FTuRfe8Gb0KiT+d0hFMEdLYxC+mZRTxceTcyqw1Yxjp
 WOch7kErNNDePR9u4WL0qQ1T9CbraqQRqzJ9Xzps6u60DNTTHwMxGTNnv9q/C4bdqwi2
 IWCUs8ZaJbf3Ps9MMGAFCvf3hT8xv5Zx547AqdT1MHPx9xJKmqzh9pygrZesXc7lSFz9
 AcAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742385481; x=1742990281;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HrdUg/alY/vauKYZ6SVnOhEYzyiRi5BZkZ3o/ZgY0f0=;
 b=Yak40J8rlPy9EkEQm8xuBBbUVnttinrydPCrRo3kmgxCLdaMvhJckgaRScx5AvxS0F
 MDLxk8IUgi39WSjp35DKi7IX7m94Zvm5mveplJYrJVcQlaEiqBlhH0OKlHES+NARp8wR
 77U4NBiXoKLLBYR5V5uhDH9/VL9dVfxpWARxqmo0oNtIo552dtf2UYJcIRRFMVKpMSW1
 4ywuAQjuDYyb70cp0byDx23N1Xgsqz0Jn0zPjI7hLV8y1CFDPjTSJg/BsBVilMvV+eNb
 RYdbxT1YbSGUjZhV01FiCqM7u5mQIDi24Kv8ixOh+2KOa2JY8ih/FhSFL76dEvBtmIzd
 L8Kg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnV+LVsvBpewG762Yam/i0ofhd+2gpbz5AeM3qR6hD0bx9GjSmEZxKZATjPS9Ax5bcdMvLOSMMNJt9@nongnu.org
X-Gm-Message-State: AOJu0Yxk+M0Md1D0luCXfY5b4VwHUnHhSeaOOt8fJ4489+8VabjISu/4
 19ys/SZxZQoNgDOXwTxh6DZKk/XV9waHrkQX4pDzdqdwAGLaKFhJBswLw+eder8=
X-Gm-Gg: ASbGnctFOvflziSp1JGmJIwS68nEtvSSMu197rmA+9FQ5pvG5VUMHsMXQaT4A2kcETx
 vuJrMUBDUtz9T3BGwMuT3mHMZNC0ZoeY0jgGISUY9D6MYYs+sSdfmN1+AUxEmH5W4jZ+aMSKpid
 C/N6Vt60/F8N2cLPaj2JgDlFVXvJ115oy/j+eHdYggOYWXuRvV4ZdD2TCr5m/W1KGa5N5EO5o6A
 Em5xkr42CBTDpafJsWt0Ha8gROgjTvgBa/LDYW/qwhNDKu5GhlFErsrl0EhKq9XLFUGsPsEWtz3
 bNylW84pFxLwOFSHDT4Sbqh3fKZ7HhfCdcELbA/mnbBVvBoV/Ki3Vh5dJIt5iT5a5JXoRwPYc1T
 8c84gHsKr1Nsx
X-Google-Smtp-Source: AGHT+IHG+GKS6KHeyt/EvNz5Ct0X3NwZA3Fo2U7B1Kdsg9J17sugMn+mA0bgBOm+cgdV3leDz3xf7Q==
X-Received: by 2002:a05:6000:2c6:b0:391:3150:96ff with SMTP id
 ffacd0b85a97d-39973b02261mr1873124f8f.32.1742385481304; 
 Wed, 19 Mar 2025 04:58:01 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d43f33237sm16970175e9.4.2025.03.19.04.58.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Mar 2025 04:58:00 -0700 (PDT)
Message-ID: <46166d3a-00e1-4dbe-b14f-aa55d5be006e@linaro.org>
Date: Wed, 19 Mar 2025 12:57:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] hw/uefi: flush variable store to disk in post load
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Kashyap Chamarthy <kchamart@redhat.com>, Peter Krempa <pkrempa@redhat.com>
References: <20250319110152.1309969-1-kraxel@redhat.com>
 <20250319110152.1309969-2-kraxel@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250319110152.1309969-2-kraxel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

On 19/3/25 12:01, Gerd Hoffmann wrote:
> Makes live migration more robust.

Typo "Make"

>  Commit 4c0cfc72b31a ("pflash_cfi01:
> write flash contents to bdrv on incoming migration") elaborates in
> detail on the motivation.
> 
> Cc: Peter Krempa <pkrempa@redhat.com>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>   hw/uefi/var-service-core.c | 1 +
>   1 file changed, 1 insertion(+)


