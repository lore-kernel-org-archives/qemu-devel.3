Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC56ED1266D
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 07:02:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQgsB-0002VB-EJ; Wed, 03 Dec 2025 02:01:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vQgru-0002K7-KW
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 02:01:46 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vQgrt-0001oA-3g
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 02:01:42 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-42e2d5e119fso1971347f8f.2
 for <qemu-devel@nongnu.org>; Tue, 02 Dec 2025 23:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764745299; x=1765350099; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iLegxef/YiqYKWzWPFEOA2BIUc7KYmVqjzdVrXKPuiA=;
 b=FCzkrSu+hSxXFItoXRLA0vw2PD2AWFL/QusmA2ZFGCqpSccfUA21tarLME28MaXxYK
 Ip3TsvXzIWzR6FQ9o7dI6sHeqNC6pFe7sEGla7bUZ5PHNYmksOqAsbZ2CrZ1YNe3YZWn
 S8dylEV3P3DOg0+2mt6SxI5h/4oVGufnDN1mgcaJqTL6cJ60BCuOfXzsOQwtJcNIu2An
 VueCv+SFYj9baUFqamxpa51Cm2Eh5wVqcPXkp25o4KzUJeLMl2AavAyBoAXgHt9RW90C
 BA3rewq61YWkZq70jTrVFToRulrODYimHuY3DAlxJmb1GOV+myXqth8yaICSmh/ZrmHA
 Ms6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764745299; x=1765350099;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iLegxef/YiqYKWzWPFEOA2BIUc7KYmVqjzdVrXKPuiA=;
 b=ByVnlp44y9q0JRiqvE1Oo/BshbTOuK8iHegrgZXx4R2DqY3LwbQWORhstV2SIbvTEe
 pnZEs9wSi50C9LBSC+z4X2o5Gwq8C9TL7AeDe1XPvIaNyWq9Wc+v+8RxmLdp+P+NEbhu
 tBqnppExMVilgjqQ7BGQh7NLzdJqSr5J+Ouz4NpSwwrm4zQGvsBT3SwY1LTuGiX23bVh
 M0vUFR1Eae9vELjhj7zPSQU+Gz6i6ObaZYkJhLeQXlIpgnFOEHBj/8ytp1WNhcx2uT2b
 4zp5pdef0EOfM9Pq/X9PZz5Uxf/utHVWtwcqEWJTIUhPnHKFtYd6Q4ZufOQpZzuzHrf0
 aQwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUj6pRQmeE5hYnZlejouuUb6yAtglDYisC8i83mq1rNu/SVSr+kRvqatw2esa+2MzJOFXnsy6gFWE7Z@nongnu.org
X-Gm-Message-State: AOJu0YypCz0FbuFZwerj5SugJCvULPr+dlWxAN7T3coiAmPbPhA/0DVE
 MfMwKduKH1sY5JGMZuOs+0eAgQxSq+UtuqcT9IerZmvF3RwVNMCU1ZZ7l5ceZsLGb5M=
X-Gm-Gg: ASbGncu17uQPRPVv27vye1IcutzTtNYBjjyZHrM9ftUZgYgjKsL7LNlmUjabCPJDc6u
 7lVJB2e08Hcv+gI0LT3OGDFEE7x94I7E/6/I4pZDk7I1FCM+hkEZpVMXLsfP2l+ghSSJx+sgX9r
 tvSzGXVbjmK/P60rmwOssOk5l8Y5OuOw4IANkOTXXX+BAAEh45Vyavtyj9/8zjJZ4E65a55jkXt
 V0O4t1qZ8H3urAD0yQW4GpGTYe2GQoSCat/AtfiW/QnJq1LOSnDZLghoDRKOPKvU1vk9K8H3fmk
 3zf1jFDS/3CnBsc/Mt2tsLj3xSuW0hf8rDpdYkMjX5ASSUjw+XVH5Keha/b52lOb5dVfqzyALUM
 0GmsCvZm4OS/U1L2rJUyLZUFnRuA3JMUsKcmAy8EaP8TjNg5pl++FotPBPzMItrVHzkqt8fXVp9
 ir3pRxFdQ9JtkGrD5vAAufzlmpPHGuShfZEbW2HZAPqyVCt1erGggv6w==
X-Google-Smtp-Source: AGHT+IFWayL7dZkqCSl/nVOxv4Bv/f6eF21QUbKlrnYnU7+tA8VCf5qu+N8vib84rXuH2Fw2mN1z9g==
X-Received: by 2002:a05:6000:428a:b0:42b:2f79:755e with SMTP id
 ffacd0b85a97d-42f7319051fmr900134f8f.3.1764745299574; 
 Tue, 02 Dec 2025 23:01:39 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42e1ca1a3e4sm37760730f8f.25.2025.12.02.23.01.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Dec 2025 23:01:39 -0800 (PST)
Message-ID: <74013c3c-c8c3-482e-8811-265dfc557fb5@linaro.org>
Date: Wed, 3 Dec 2025 08:01:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.0 v6 12/13] hw/i386: Assume fw_cfg DMA is always
 enabled
Content-Language: en-US
To: Zhao Liu <zhao1.liu@intel.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-riscv@nongnu.org,
 qemu-arm@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20251203060942.57851-1-philmd@linaro.org>
 <20251203060942.57851-13-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251203060942.57851-13-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 3/12/25 07:09, Philippe Mathieu-Daudé wrote:
> From: Zhao Liu <zhao1.liu@intel.com>
> 
> Now all calls of x86 machines to fw_cfg_init_io_dma() pass DMA
> arguments, so the FWCfgState (FWCfgIoState) created by x86 machines
> enables DMA by default.
> 
> Then 'linuxboot.bin' isn't used anymore, and it will be removed in the
> next commit.
> 
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/i386/fw_cfg.c     | 1 +
>   hw/i386/x86-common.c | 6 ++----
>   2 files changed, 3 insertions(+), 4 deletions(-)


