Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E3D1D43341
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 11:03:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t90I3-0001bP-EF; Thu, 07 Nov 2024 06:03:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t90I1-0001b0-R7
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 06:03:01 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t90I0-0000tY-As
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 06:03:01 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-37d3e8d923fso539038f8f.0
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2024 03:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730977379; x=1731582179; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vcNWJcHRDdwLLZYXouVhvVogljhXPn6rzwLGc5USOXY=;
 b=qoEvVl2xCQt4QbJ5iswl4fYZMTxZ8WvTJ5p16EGNzsaICuTvykqjfVmO3r7Nu1gUli
 qykOnjDZgmop61o7G+5GknCaWm1H5voXGfbrsXofGta5CbwInPWSA7FnYKF7SQY0qh2E
 NIWbOkG2sNLAvDW9/JVCFBwCRAYIJ/ZO5SAQY4MfIDHdaW4Ns/5FA7aIfMFmOAwoBckG
 fnpQuBGykUmylhVyRI5qPLTsaaLIfA3EybMK0DC2IfHjpYpEE+1AJIk21s3/i2QIVCQ0
 Frmf+NNlYmum2BL70dDEd3XjnPweU1s1SFW1IXMvS+LLLCxmqL1I8nDIgtvT+PZyEoVw
 bqTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730977379; x=1731582179;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vcNWJcHRDdwLLZYXouVhvVogljhXPn6rzwLGc5USOXY=;
 b=iyAceoEpqHHD1LCjeCec2U1L3p/ui6usBdkhzn9NdHivXHq6F3Pjbli9Oc+OeiP4eO
 NkQyZJ3sUUTnb7aOj5pzml+VAOcp/cQgI5WTGk1ZefrIK6z0PV0ly96KwS30iBRj6G9F
 Unjd+mZbU7z0hbFTrK3c9URg7wtIZZYz9RwrLXIBOTqd5N0O4y5iMlGb8SHf6Zt6A21A
 JdIutFKwAYua0sk+l9a6SCghJbWnK816ham+gZk19nqQ7q4uzPxENOI6QagRXy7PTP39
 8+uFboj5uTzuIUVjWb7CfySuHLusAqBbcMde4gotPllVE+3WVeGAYeoYO+gJmyrXC89Y
 3bxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTdlvHfScbGhzGS76CSWSdzoq39/Lj7tRdXAtal8Jrn20EMYSIhxLDDwO78R3/Pto78bn4s7cOVfZ6@nongnu.org
X-Gm-Message-State: AOJu0YymWn+flfi/7LVH/MU8SvHZp8yTg2KyBwnNAEzSOo9nPq97Kpis
 TDk2Fd8lJEh0QtXzR/3yEj/ZOxS8sf4sOx3HR81/coJ+/XNQUguL06kNPyE60/o=
X-Google-Smtp-Source: AGHT+IGV9etVtLDD6vxW2rZqcgCmsr13VO51BfUpklfqTKqbN1hZafomqtieyyetTLq5Vcr2Fqtr8g==
X-Received: by 2002:a05:6000:e0d:b0:37d:3def:2a82 with SMTP id
 ffacd0b85a97d-380611e48d8mr21290308f8f.36.1730977378698; 
 Thu, 07 Nov 2024 03:02:58 -0800 (PST)
Received: from [172.16.23.118] ([89.101.241.141])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381ed9f8dfbsm1428853f8f.73.2024.11.07.03.02.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Nov 2024 03:02:58 -0800 (PST)
Message-ID: <1fd0220c-96fd-464e-9a95-9b44797ba578@linaro.org>
Date: Thu, 7 Nov 2024 11:02:55 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/16] hw/ssi/xilinx_spips: Make device endianness
 configurable
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
References: <20241107012223.94337-1-philmd@linaro.org>
 <20241107012223.94337-10-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241107012223.94337-10-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42c.google.com
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
> Set the proper endianness on the single machine using the
> device.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/hw/ssi/xilinx_spips.h |  1 +
>   hw/arm/xilinx_zynq.c          |  1 +
>   hw/ssi/xilinx_spips.c         | 46 ++++++++++++++++++++++++++---------
>   3 files changed, 36 insertions(+), 12 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

