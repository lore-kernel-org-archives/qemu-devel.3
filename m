Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F5DBFDEE51
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 22:28:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wG2Wb-0006ks-U2; Thu, 23 Apr 2026 18:27:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wG2Wa-0006k7-1G
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 18:27:56 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wG2WX-0001n6-L9
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 18:27:55 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-35da9692ec3so6224550a91.1
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 15:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776983272; x=1777588072; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=R4xO++qVhRd1W4yQ95C2lw/hYxaxAJmH0o2HwH7syhE=;
 b=sth5Hd5tbD781J7hy/68yxbC7Qo2kZHFEID9tiYe14up9znjpZtsPL+cG1YdxOiy85
 F0E41JMS4dEPBQ7n6vzutbXIvxRYgySekW9GS2JR76KJRRT5OZkqakDvsMB48KpUWtY1
 BHhnsRWwLisci4uNuOHutiZurXVl9YjTpQsERFmHKD/GaT7StOrQ9B+65t6zkmj7/fBT
 cu9R64xvDGBDlqODpYt/4p97Zs9HRZO303YCsgQutEZELG2NRZqimWjhss5AcFNV2QUd
 rrlbRrA5EQ/HGaVL/XK16zmk6Tz/J4ZwjIRAKqUgXWo70dhGNHONdTJr4l0bgFStuh7E
 JfvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776983272; x=1777588072;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=R4xO++qVhRd1W4yQ95C2lw/hYxaxAJmH0o2HwH7syhE=;
 b=WIwcS8DMZht4684JAuDr79k1Kg/B+1XKO+nLr9oO9HpMx0jlTvXVM9FYioxwzoLBOe
 BVkkLYDEglX95ZBjlWEDcvAqK4n28NBxlEo1yGZuzRsoJo+O0uXxDIJ9L1LnskH4GDnN
 Y/zOWxDLppmoCzlxUdiQdGKnF19N8U28BpMsCG3hWLHspXEMA4rBdF82X+zHpkvYsdBE
 EKESQxYWk5zlziiJWVYk5QV89GYic105aV+ngJhbIXvLHgQ7423dtvqPtwrVAlYHqaiL
 ToZxDXudveN1jcefJoBFwR11FZmcEteLbuKVLOoRhJBdT95H3xBEnCTCQvZczk3lcBpm
 lWwA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+bz9amgPo94jyCv2exTF+3Mp4Zq2N71q5kBhxQ3gFXFvjzNql+p4e0Aabo3Mj9CEbQfjl7+Nrj6AGs@nongnu.org
X-Gm-Message-State: AOJu0YzlfhZM27Mi6ntHf5k65a5zLiQPYLonxH5CcFMOwIp8tJk02/+/
 ScHU1FwGb0Dmh6aGFWQPn11uu+nznyURg/b+WS1vZWMytfGqPzJMsHZ6Mt9Br+gm8y3pkBTGaln
 r7j3hII0=
X-Gm-Gg: AeBDiesET/Sfmge0VX8neLM6xzxIXGmbn1cFkcKkNPMbOr7kk6Kpas+QDWxdlX7IojZ
 4gHkHD2NrGteAD2YvDEUnFhdulbDKAhiZBG5Xj9hraroWfCngDFS8TVokSlNqRr5lU9IqC8lQdL
 YQw8Zw3GnUunbUix9IO84Yi4VF3M8EOk7W9V2e6cdjkI7y92vkDadnd610FwrtKfEBAF+EplhQW
 c535JchjmWgr7G6gIthGeYU5HvshrWPmsZbs2mkJOSUvCt8Gw9bYhijIFLxhPUToxRSwKwTqur+
 geWKEQUOU19Ed9TKofdwKCsLdg/RdqI5QMBx2SmzZIv96x80Xem+PX0PuL/SqX24iC7MOFa2r7A
 LvFqGAnuehAUC2G2xHrG1B1Z/BQXfeMk/e/JH2e6c6RpIKKGdEStPxZRK34d7iJgq04QFPqMb8v
 uZbx+mrpBz1a5YFWXUg8xSXh3WfPRisEf/zv0+/mTO1/9+ma5BYg==
X-Received: by 2002:a17:90a:fc45:b0:35b:e4f8:7b2b with SMTP id
 98e67ed59e1d1-36140468f71mr29130726a91.18.1776983271899; 
 Thu, 23 Apr 2026 15:27:51 -0700 (PDT)
Received: from [192.168.1.134] ([110.239.0.232])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3613faf1103sm7841476a91.8.2026.04.23.15.27.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Apr 2026 15:27:51 -0700 (PDT)
Message-ID: <4388142b-c6cd-4e06-936e-c3b4b3ee7320@linaro.org>
Date: Fri, 24 Apr 2026 08:27:43 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/16] hw/cxl: Define cxl_fmws_get_all_sorted() stub
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Roman Bolshakov <rbolshakov@ddn.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, Mads Ynddal
 <mads@ynddal.dk>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 Fan Ni <fan.ni@samsung.com>
References: <20260423170229.64655-1-philmd@linaro.org>
 <20260423170229.64655-3-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260423170229.64655-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 4/24/26 03:02, Philippe Mathieu-Daudé wrote:
> Add a stub for cxl_fmws_get_all_sorted() to fix building
> a QEMU configured with the '--without-default-devices' option:
> 
>    Undefined symbols for architecture arm64:
>      "_cxl_fmws_get_all_sorted", referenced from:
>          _cxl_build_cedt in hw_acpi_cxl.c.o
> 
> Note, the CXL <-> ACPI Kconfig relationship is a bit convoluted.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/cxl/cxl-host-stubs.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/hw/cxl/cxl-host-stubs.c b/hw/cxl/cxl-host-stubs.c
> index c015baac813..9b515913ea4 100644
> --- a/hw/cxl/cxl-host-stubs.c
> +++ b/hw/cxl/cxl-host-stubs.c
> @@ -18,3 +18,8 @@ hwaddr cxl_fmws_set_memmap(hwaddr base, hwaddr max_addr)
>   void cxl_fmws_update_mmio(void) {};
>   
>   const MemoryRegionOps cfmws_ops;
> +
> +GSList *cxl_fmws_get_all_sorted(void)
> +{
> +    g_assert_not_reached();
> +}

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

