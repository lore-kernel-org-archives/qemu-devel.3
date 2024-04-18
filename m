Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08909C04FFF
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 12:07:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxQXQ-00067I-22; Thu, 18 Apr 2024 08:06:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxQXO-00066y-ML
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 08:06:46 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxQXL-0000aL-LJ
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 08:06:46 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-343c891bca5so526543f8f.2
 for <qemu-devel@nongnu.org>; Thu, 18 Apr 2024 05:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713442001; x=1714046801; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PXnIeijJGcOJXRMEB0cv17kNSech5WaeGsQzX+LqGO0=;
 b=Erc1M/V9co3hBwfkZEd73yhnujlotFXNpORVPT3i+69zmlUpN/0873lcfUF4YYwH7Q
 nYRVszGXXoiioUs8afBM3RByLSoAobXXPYL0P+HCiPY8s7e8EgJ3QwMSUH7GRTbBzoS8
 bjWj0cmPrW+6aFyofz6C/Y8jQ2H5OVb7xGzLttAOqB9BQ0E/dIUHQLWmsAVd5hkTJhMm
 fqAkqZULcZqmEX4h9NR83e6k2uglwdmjIKNuQoYEfNa+GseyspNY1CBw6IpeqgLekBBa
 vcsVIYPE5iAfMD/pxXuD8WAPY0TZSqmI1Oi20rueiZtUl8uMAIe2zRvtKkZPcHqcx3mf
 90Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713442001; x=1714046801;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PXnIeijJGcOJXRMEB0cv17kNSech5WaeGsQzX+LqGO0=;
 b=tues9tFnmEV3uhczuPh80YtyYKFhJ05sIPU2Qef2+X/nWFFNQK+rfchY81/+vp7ODi
 2e5ev4aDK4tSC/gyFK1DoVT3mgXAy7GRfBAO5v6XrKxl1CTjBPURp+9ikhl4AUnD3BPt
 637PB8HrCB+bCUVoErEOjkOkivTAnt6JOH+ZQpey7YgKN7aVwYblq2hYMkxJhMTBZuvZ
 okvZoZaSVMGU4oFzd+xxN2HQhcpndAIRALzCWvJ8GDmYeF7mlJr3jhXJnEJhUO4V3f3Y
 mKf9gwcjn44iKarjZABMsY18wH0yzqFIlRfcbUXfoBfARJwBrZuADvPvm3959Cp10y19
 Z6hA==
X-Gm-Message-State: AOJu0YyzAJqlwQZsiebgda4Ri3UwkufVXSY/DBINFIXzcdzG9KKFZ4hA
 PMXszzWUljyjZiNSWLZCWDJp52QUriTmsYuo3uEIFvGHCgygte1JTKl0INlI0G8=
X-Google-Smtp-Source: AGHT+IEjzH6dfU7o/Pu34nZSNuRxWhLqS5YUiFyBqw1GPDiujnmVM+wbQc1v6ayCdh9T82IKVjVPSA==
X-Received: by 2002:adf:ec04:0:b0:343:7228:f70f with SMTP id
 x4-20020adfec04000000b003437228f70fmr1967455wrn.61.1713442001556; 
 Thu, 18 Apr 2024 05:06:41 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.151.213])
 by smtp.gmail.com with ESMTPSA id
 z18-20020a5d6412000000b00347ec0469b2sm1701633wru.46.2024.04.18.05.06.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Apr 2024 05:06:41 -0700 (PDT)
Message-ID: <54117bfd-644a-479a-a477-e0bedcc837b3@linaro.org>
Date: Thu, 18 Apr 2024 14:06:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] hw/cxl/cxl-cdat: Make cxl_doe_cdat_init() return
 boolean
To: Zhao Liu <zhao1.liu@linux.intel.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, Fan Ni <fan.ni@samsung.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
References: <20240418100433.1085447-1-zhao1.liu@linux.intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240418100433.1085447-1-zhao1.liu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

On 18/4/24 12:04, Zhao Liu wrote:
> From: Zhao Liu <zhao1.liu@intel.com>


> ---
> Zhao Liu (3):
>    hw/cxl/cxl-cdat: Make ct3_load_cdat() return boolean
>    hw/cxl/cxl-cdat: Make ct3_build_cdat() return boolean
>    hw/cxl/cxl-cdat: Make cxl_doe_cdat_init() return boolean

Series:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


