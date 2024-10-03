Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B531CF34CE
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 22:19:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swUA1-0001at-59; Thu, 03 Oct 2024 18:19:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1swU9v-0001ZZ-O1
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 18:18:56 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1swU9t-0003hm-CV
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 18:18:54 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-71dba8b05cbso1493802b3a.3
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2024 15:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727993932; x=1728598732; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=u+sIJw14vB64lL10qVXJASnrhOwQwQ8Q53Yq3hrrIBI=;
 b=RxIy9KvwbW0wmTC23oYakrX8/NyQnh6ZepBYbf2HWfU2lg0rrnWMK4NRtz+xCZkVG/
 RZi6KbMYC2bX24actSp1gRtGK98OOFVlk9h4wBHO7vjza3htJ4fPgJoVODxAW4WngH6j
 jXnCOt5U7EKD+Nr9R3Z5eMRuaKACzN58JsMyP6ZeKkcJ4HBp8jtPP5xuBmvUC88zCF82
 Vr8SIceTbHIO8dnDHQDagctpPFxAliv5rtXKMPGh0nUepPqJcW5VZO+fVyhNC6I7EB6a
 EJtDl8CdbAgyE97Q2zAzRhnMcEtj0Sr4CTEyVVEz3dvmxIJ8+2cLX3hJCPVYcb+5/MwV
 E/zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727993932; x=1728598732;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=u+sIJw14vB64lL10qVXJASnrhOwQwQ8Q53Yq3hrrIBI=;
 b=mKFblwMDhc4Ck12gX9NNApO01TdMM9rQhyP6I++bqCjOqHHEQKo5HO3pAtcAzSHC4X
 KcSXgF+nZXJDSkkBAD1UUzDvCcERmvwtgL68EHX9a+PqqPLXJ5wTu8UEPSK+kTABztf/
 CGYLHKtmvxXWm5XJfBdlAxeITnlHCGKMx0gMJUUuWVJMWQX1OJSW13Aw51rKMo2qfRO1
 6h+q0hxB8SpkJGva2gyzp/b3kSSvDWBrMoqhZnELFAmlxHQI2RBgPJxhxufb8kSkGS6+
 nZbUc803ICpjILoRqg5eocCaQTbKdoMALVqZw2WAmjUKPCL9cg/Hvx7UQ4gSPt2vkMKK
 EjvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWPu9jeCjcHHDEqC2o30zo/nOAQfA5WqsOKakFinunWtRwAQEOJQ6Hmf4rUM+DywjFwEmjzKqFxejs@nongnu.org
X-Gm-Message-State: AOJu0YzppDU4DJji2yhQzMjAhW0NZtfLgXk40I7kx5WNScX2uEDN4uZ/
 FdjMciwZA3r5zxg1GHsjUQp5/uF92ZysdUDbwNumxibid4FeBGR8vOElw5DxKpA=
X-Google-Smtp-Source: AGHT+IEX5ltMQfirprQn39UgJCc1mJIdbkq9nZwd4/p86YY+CbPqCRpEY+pgmVRK+vpo4NRseEcNgQ==
X-Received: by 2002:a05:6a00:acf:b0:717:86e9:cc34 with SMTP id
 d2e1a72fcca58-71de23c4b76mr927339b3a.8.1727993931907; 
 Thu, 03 Oct 2024 15:18:51 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71dd9e083b4sm1864238b3a.214.2024.10.03.15.18.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Oct 2024 15:18:51 -0700 (PDT)
Message-ID: <67b644e4-d5f4-4802-8a76-4cc109de54ca@linaro.org>
Date: Thu, 3 Oct 2024 15:18:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] hw/ppc/spapr_nvdimm: Simplify LD/ST API uses
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <20240927215040.20552-1-philmd@linaro.org>
 <20240927215040.20552-2-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240927215040.20552-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

On 9/27/24 14:50, Philippe Mathieu-Daudé wrote:
> ldn/stn methods handle the access size, no need for the switch case.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/ppc/spapr_nvdimm.c | 47 ++++---------------------------------------
>   1 file changed, 4 insertions(+), 43 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

