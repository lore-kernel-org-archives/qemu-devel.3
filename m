Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AAB5CFC5E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 17:41:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syxAD-0003Up-TI; Thu, 10 Oct 2024 13:41:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1syxAB-0003O8-Jw
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 13:41:23 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1syxAA-000564-6m
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 13:41:23 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-7cd8803fe0aso858774a12.0
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2024 10:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728582080; x=1729186880; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cOZ1uKnvWJeCSrq1couF6Ea5U7vU5+JkoVJnZcJ3R2g=;
 b=xcC7Ia7933AYINbrnKALLCfFj49a0MdwJ8ycnVEYdBgaiAyRySTk5au9/598aa8n2p
 IhfaFaP9FtVCCPVY9w5fjtD5q6LO2M1smaeNi19g/iVFZWWFzosWCkkufk9xOSfrEnao
 s6QqFVoPca9C4j08hGMs+u1J9HZX6PV/k8lAovUi+4X0sPbfKP9h58KPav4KJfh3ZVXD
 cQnyTFl8vmukunTcyDaBPok0z8q7k3ECKaXULpMXVR0X8eDbMGKtxduJDrVRzbsyivLq
 J5Iorz3xbfmYMlLZE1ywB1KO57vrTbhlNCk2l8Amasv4/XGpQ6QRd9ltVaBClGh5mqt/
 llfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728582080; x=1729186880;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cOZ1uKnvWJeCSrq1couF6Ea5U7vU5+JkoVJnZcJ3R2g=;
 b=g0icT/HdGsnZShqPIKgP/Ot7RAxCif25UVffvAHXAJTQ8iQbuMJYU5wNEK1QSrHb8O
 ZcFW61SOiF7VVuaeYupZ5EoqulxU8GvNmLSZlpKZa45lSyJ9X2azn8hVFTE3+ZznVCLP
 IqzRBXfogJkG2dRYemAGSc545I3YyeKyO/JjSsHHSr6qXICv4xUNVzl5kki1nhp5OIK0
 aeaeW0S0QtJhkAi1y+jUxYwzJbUkG0xRm8WLiAgOmS+UfYZkHleuNXjQ27UN4G7PHQm0
 FLFwv/FwIFy46LnLBaM4IjLerQMfgPYq0wEUt4iKwFGMAOH379wLRTYL3gYNM6RdZDwa
 wPHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFKISmT+6oW1CpGyOGpb2IpPfKRMzhoSHffqq5jsYOxZdCtZyt1BC2AqqzGw1Llx7w/7EDIMCrNfWw@nongnu.org
X-Gm-Message-State: AOJu0Yyw9kr6pecJOK08i4DpuA2pIDrcI6pOYq74JcUzDH/1z/hyF8O/
 Dxe/MtmPpCuXt9VB3l5Swzp329uaqjZcLIu8zTIjMFhb3OkCi+7Kw7UAdulslSw=
X-Google-Smtp-Source: AGHT+IGY4SO5oXg/iKHF+xDwQzd1l4ENIlPD+wfpqJaDDklaJ3lUA1hZasPcC7K9TjeJpQd9RVL5JQ==
X-Received: by 2002:a17:90b:1943:b0:2e2:8349:239d with SMTP id
 98e67ed59e1d1-2e2c63aa8b9mr4507982a91.28.1728582080439; 
 Thu, 10 Oct 2024 10:41:20 -0700 (PDT)
Received: from [192.168.100.35] ([45.176.89.169])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e2a5712814sm3909375a91.30.2024.10.10.10.41.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Oct 2024 10:41:20 -0700 (PDT)
Message-ID: <a844e829-24c5-4bf4-8bed-d000e1c0e73d@linaro.org>
Date: Thu, 10 Oct 2024 14:41:15 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/7] qerror: QERR_PROPERTY_VALUE_OUT_OF_RANGE is no
 longer used, drop
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: xieyongji@bytedance.com, kwolf@redhat.com, hreitz@redhat.com,
 Coiby.Xu@gmail.com, pbonzini@redhat.com, berrange@redhat.com,
 eduardo@habkost.net, mark.cave-ayland@ilande.co.uk, michael.roth@amd.com,
 kkostiuk@redhat.com, qemu-block@nongnu.org
References: <20241010150144.986655-1-armbru@redhat.com>
 <20241010150144.986655-8-armbru@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241010150144.986655-8-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=philmd@linaro.org; helo=mail-pg1-x536.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 10/10/24 12:01, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   include/qapi/qmp/qerror.h | 3 ---
>   1 file changed, 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



