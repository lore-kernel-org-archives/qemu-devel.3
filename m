Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04656C2BD09
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 21:33:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRIT6-0000wJ-80; Tue, 09 Jul 2024 17:33:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sRIT4-0000nj-8V
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 17:33:46 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sRIT1-0003E0-QE
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 17:33:46 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-36798779d75so4901573f8f.3
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2024 14:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720560822; x=1721165622; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QInenkhpDK6ypR10+eCEt51q+RWBo1Z1UmpFqwu2sgs=;
 b=actHx9Y/BcjH+1Rn9b+pWv1Q9kkwY/XYdBHB7/5lzV1cRHrNfz4G5f5CRyFlrl9J9d
 NC9qIEIuSAmrrRMwb4qHAY4QfVC7ge2uGMWI8loFsr/VNJvkA9BNLS0FSgUqwPJopHLd
 S4i9RQseU3+WCzCbPVJJEF/XmYth/igQIlbtuRM7Gz1evEDYa3nCdTuKVdrlPpQsZcmt
 sxhJYsw+PBv7lmELkBdikFFMk2cc8jaP5jBShX+k2XO2g+6kSx3mXLzQGPSKM7ttqnTO
 FxPYm9kETV+wiSP3YXs62PyNYmBc/Rfvcf+ZdqQT1dEftgOvzQ7+P+04FqUbRxGWarYd
 u7MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720560822; x=1721165622;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QInenkhpDK6ypR10+eCEt51q+RWBo1Z1UmpFqwu2sgs=;
 b=vMWmL5DkcBWGcEbeAxZbf36nBcl82D3Sf0+/c+GrBwNIYyOBVcXCvfzzbe4S16bGMu
 2ygl++Tq6W+3OoMhqki4qt+9wsc1sbNk7+lc2micZkJyq8TRL9pUcfIx+QRS/k68cQmX
 N9/mzlnRTfcY6z6DYZVNG6MXKsStyPDRhulyT7cLKd2RHZMjvvls1ge38C/KXuug04e5
 iIgjTJQHiOcS0ysZjHDLOUrjSxKNLTyKKcBsdEPhw6EtH29CqieTKiWWBWsd8I8wD3pz
 rDJKN9oj/N5IQu1w9jSSpSkIWlk25CWeQ7zINwLAnCfA4oD97L0v1bLqm3T1z+aS3ZmD
 SKHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVN0lK7yu0dEAH5y/OwSTYZwEhqY6jmO2yn4oGhrGq39uIYhShxear8j0fKRy3K/HEsy0S2SDzevZ1CBG8PU/GoSES6Ems=
X-Gm-Message-State: AOJu0YzQCqvb4e4x/TF7BkNhCIlYpIQb39vgDAGUfTlt/a7TfBVjvqv1
 TsOU1RboqtAYU8d1CwhgK8BBKNxZkQsk53D8jevN27yCv4VziFOITDHBrweTgh4=
X-Google-Smtp-Source: AGHT+IEeLsnefRRgSRqwRUlWQE85R3SZgQA/SeV83PhSoSNjpSy6YaBkL6a5CL64XmRYUSuMJ0oqOg==
X-Received: by 2002:adf:ae59:0:b0:366:ed80:d052 with SMTP id
 ffacd0b85a97d-367cead1207mr3059270f8f.52.1720560822140; 
 Tue, 09 Jul 2024 14:33:42 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.167.117])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-367cde84912sm3553328f8f.40.2024.07.09.14.33.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jul 2024 14:33:41 -0700 (PDT)
Message-ID: <aa23058e-742a-45e5-ba6d-3aaf0e66a261@linaro.org>
Date: Tue, 9 Jul 2024 23:33:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v47 12/19] hw/sd/sdcard: Simplify EXT_CSD values for spec
 v4.3
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, qemu-block@nongnu.org,
 Bin Meng <bmeng.cn@gmail.com>, Joel Stanley <joel@jms.id.au>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>
References: <20240709152556.52896-1-philmd@linaro.org>
 <20240709152556.52896-13-philmd@linaro.org>
 <04d15252-0b94-473f-8db2-02e221ea80ec@kaod.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <04d15252-0b94-473f-8db2-02e221ea80ec@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

On 9/7/24 17:43, Cédric Le Goater wrote:
> On 7/9/24 5:25 PM, Philippe Mathieu-Daudé wrote:
>> - Set some keys to not defined / implemented:
>>    . EXT_CSD_HPI_FEATURES
>>    . EXT_CSD_BKOPS_SUPPORT
>>    . EXT_CSD_SEC_FEATURE_SUPPORT
>>    . EXT_CSD_ERASE_TIMEOUT_MULT
>>    . EXT_CSD_PART_SWITCH_TIME
>>    . EXT_CSD_OUT_OF_INTERRUPT_TIME
>>
>> - Simplify:
>>    . EXT_CSD_ACC_SIZE (6 -> 1)
>>        16KB of super_page_size -> 512B (BDRV_SECTOR_SIZE)
>>    . EXT_CSD_HC_ERASE_GRP_SIZE (4 -> 1)
>>    . EXT_CSD_HC_WP_GRP_SIZE (4 -> 1)
>>    . EXT_CSD_S_C_VCC[Q] (8 -> 1)
>>    . EXT_CSD_S_A_TIMEOUT (17 -> 1)
>>    . EXT_CSD_CARD_TYPE (7 -> 3)
>>        Dual data rate -> High-Speed mode
>>
>> - Update:
>>    . EXT_CSD_CARD_TYPE (7 -> 3)
>>        High-Speed MultiMediaCard @ 26MHz & 52MHz
>>    . Performances (0xa -> 0x46)
>>        Class B at 3MB/s. -> Class J at 21MB/s
>>    . EXT_CSD_REV (5 -> 3)
>>        Rev 1.5 (spec v4.41) -> Rev 1.3 (spec v4.3)
>>
>> - Use load/store API to set EXT_CSD_SEC_CNT
>>
>> - Remove R/W keys, normally zeroed at reset
>>    . EXT_CSD_BOOT_INFO
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> This should be merged in patch 10.

OK.


