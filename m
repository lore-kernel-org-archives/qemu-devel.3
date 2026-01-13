Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA8D6D30CC0
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 21:03:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vflX3-00051L-7D; Tue, 13 Jan 2026 16:02:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vflWq-0004zL-Ba
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 16:02:17 -0500
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vflWo-0002l7-Ph
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 16:02:16 -0500
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-34c363eb612so4703374a91.0
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 13:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768338133; x=1768942933; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5vv+ot4BC/0VQdnLdrgZK8fZZEu2LmZMegyDAM36c0g=;
 b=t+7u+vaBb2V3WZmX2HEzdF3meKsVIzNke/njjWR9fscBtcrqTsUztRVjouo3JiUatE
 luqrULEVisJCMsY4QRYEbFxiSCMVzNrZvLvwOwCcrqkvmvP+f7Alca4h3R/t2iq59Gc8
 nv7szTH6fhGQQTQpyJPTDu3PzRwZyDhIxV0DWKVaYdYaop/Pd9LhmzkPjemfFE/nbXhF
 vChAr0taWqwTJa9lCmxLsx2A91fQ3qR3NKJOWMQ47c49tKTEESFXc8j/y9SGfVLUte9l
 ZyEd/KdlvgKOUljxbEY0SBF79HXK5k0jHmd6FLgGyEvdM0t+A35W1Hzmf+1L3wP6AMMa
 Wx1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768338133; x=1768942933;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5vv+ot4BC/0VQdnLdrgZK8fZZEu2LmZMegyDAM36c0g=;
 b=rETdbJpufBPmAjdNgj2ITcTxZccLDd4GhDYErlD/SDg1cMC0w33UitrwR2J66XwOsS
 hhFThgAg59aYdSysK0g7SbnbptqGPLjN+9gb1RBHzjOi/WFOnJcvZ1H9KvFRGcFWVkCi
 4i1RvroWtoG5dv92aOF5ducl20dzjiTD/Ykgor0Ci3M1OQw6potCwwJ8nbSkjzTU4hGO
 qn7TpKFN2t3xsUzJM7WLedlE8L602EkQgnW1KIDlyVLIDLJMOoDCFwyePmf9i0hUYpwZ
 2aT1JHCB+UoXQIQnV1TcxQWMQb7WnjNmGdrJhlwBJEFw5WrEES4Hgmg5L+MaE1NeRUEd
 UXyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXP8UW83XtskSpDrvq+ihU/TKh6DZVjMwROTsQuQY8W6bo0VAJIZm+HE3klTDt5cJ2RG+qhjECl1UPl@nongnu.org
X-Gm-Message-State: AOJu0YymIk9LKXEF8cEYKiCuaDmgUZepHzRYi1w3CLBYgg1g5ePPh2dW
 KVJTz0umIfK6WFfjFpihq50w71M/ZqKz+65hV04+Y7ZnKgHE1zY8KY7OnCut+lMaMDU=
X-Gm-Gg: AY/fxX50OMpFXSbS3BAL2lqXt6T2xs6qC8NL4zRdjCUxSKPXcFLaMjXVYA/XXGEAZqF
 gJD3bXjfoUVwfN4IA+tGtAJ1h3dxctUiuWD37VfjNjl+zfqYiNw6civD12SOqVvadWtGSJQyxFs
 VyzrGbo81XfGsp3ZLnvaTZFZ8RaOm5JcdMYbxDFSA6xyY/TyzAJ9SUUwIT6Leu7YSm3psciB3xK
 9SAwhp2UrDJa4x0ofA8QCveQJUUbreLOOWob5WEniKoeTHG097mc2p7BSPEF9X26sSX/DKwintQ
 7jjgYiRaMIIVTNpykNVEFq/L5MZFFWUfkcAT7w54bMFurEyCUcY+uuuv+seqTNuV6IPNbRficK0
 Uy+lx9M2fiS4ZmXVsJpZrbSso73zEl+Ke1Zx20zcLSa+cIsU/ge9Keiqr2EjnBJCUZzRv3cwTpr
 +O9H3LcN1cePbOBLFliQwg/JwGUDMl1vHdjl2Isdi1sFw3wcBssNkdyqjZ
X-Received: by 2002:a17:90b:4c45:b0:349:3fe8:e7de with SMTP id
 98e67ed59e1d1-3510913e893mr326323a91.28.1768338132961; 
 Tue, 13 Jan 2026 13:02:12 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c4cbf28ebe4sm20965070a12.4.2026.01.13.13.02.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Jan 2026 13:02:12 -0800 (PST)
Message-ID: <d2554bf9-5c20-48f0-a666-481e6b75ed4e@linaro.org>
Date: Tue, 13 Jan 2026 13:02:11 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] hw/arm/smmu: add memory regions as property for an
 SMMU instance
To: Peter Maydell <peter.maydell@linaro.org>
Cc: eric.auger@redhat.com, qemu-devel@nongnu.org,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>, qemu-arm@nongnu.org,
 tangtao1634@phytium.com.cn, richard.henderson@linaro.org,
 Radoslaw Biernacki <rad@semihalf.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20260108210453.2280733-1-pierrick.bouvier@linaro.org>
 <08c42104-d7c5-4df8-b25f-7138ddc94a94@redhat.com>
 <82940e3b-f9a7-4172-8ae7-680bc1a5785b@linaro.org>
 <CAFEAcA8ZiViYfkvBJ6P5rqGmChTw3VyN5iaEqxhfNb59ba2RdA@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
In-Reply-To: <CAFEAcA8ZiViYfkvBJ6P5rqGmChTw3VyN5iaEqxhfNb59ba2RdA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1032.google.com
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

On 1/13/26 7:30 AM, Peter Maydell wrote:
> On Mon, 12 Jan 2026 at 16:21, Pierrick Bouvier
> <pierrick.bouvier@linaro.org> wrote:
>>
>> On 1/12/26 1:58 AM, Eric Auger wrote:
>>>
>>>
>>> On 1/8/26 10:04 PM, Pierrick Bouvier wrote:
>>>> This will be used to access non-secure and secure memory. Secure support
>>>> and Granule Protection Check (for RME) for SMMU need to access secure
>>>> memory.
>>>>
>>>> As well, it allows to remove usage of global address_space_memory,
>>>> allowing different SMMU instances to have a specific view of memory.
>>>>
>>>> User creatable SMMU are handled as well for virt machine,
>>>> by setting the memory properties when device is plugged in.
>>>>
>>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>> Reviewed-by: Eric Auger <eric.auger@redhat.com>
>>>
>>> Thanks
>>>
>>> Eric
>>
>> Would you be ok to pull this patch, or would you prefer someone else to
>> do it?
> 
> Since it's been reviewed, I'll take it into target-arm.next.
> 
> thanks
> -- PMM

Thanks Peter!

