Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45B2BE92714
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 15:40:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZWNs-0000cN-Da; Sat, 27 Dec 2025 10:39:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vZWNr-0000bu-2u
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 10:39:11 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vZWNp-0003Rh-IY
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 10:39:10 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-47a80d4a065so39695065e9.2
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 07:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766849947; x=1767454747; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+rylR8S6mVmxXalL7IQ6x7wtN1d2wT5RvxNL9Ibi6fk=;
 b=V0p3gSQip6sEUs5nkqR4I9rv1yXlpe+9ILKN85SBF/QHCvKMFx739kUcn/O6bFS9JE
 K+eOPpSiNjFU+wzDKPMsqjK7uY3OrN/5w6A37SUmPl8FaDnRZ6vw7onEX4NwOo9Hm0sj
 kExjsN0nikR+TPNLn8pZMxmBCokyN1kLX0iEzt6p5V7D5Xl9qDz7hqhRCN03oyTRKsNs
 odyuPyeLKrid7zgKvZnqHD3rVphzyp1tcd6A/0C6iUY2cexeBHf+tfZoZ8vSALHVqZQb
 e9M/G4wSSGugCbaRN3pVavQsmd1ijrtMEz3YGEenDCMNGnwsJ+KGM/NPUKDUoHJqupqs
 JEqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766849947; x=1767454747;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+rylR8S6mVmxXalL7IQ6x7wtN1d2wT5RvxNL9Ibi6fk=;
 b=ofB3Of04K2VSJQ3OiLbF1Ziy/tBdM8l3xQNWisY71eMGIoivuaTF0fnyOAzWT2s2PU
 kNKF7tLHhSOGwNEXn5uJHB8QuzwZeXrgnvj8RpOkJDhcgV65Fgz4XBGZZFnfQj5TM4WV
 wMH7e0HUtQ/BwKvILfl48MQI5CI+NRJ+CmitxoOMk5g5U/TDzdByWtjnW74zkYlEi5cX
 U9ajza/SH52wU8vKhVl84BSqY5k9AgdkjS4qxUqO8nFHiI6YPEjzBOB3/6Zg4hU7DCi1
 gGhR8Y1XxhykrBJghMDBZc6Gd7hwgMqZD/f5kCJE7mTEGxj6GHO3XmGYPiryCKruTjy2
 FNTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVeclubCo4Kqcg+kp4nq/Km/lc2jLfnHIUU+DnUT3/YuiKDsolov6SIUM7Kai2+AIG4s3frtdoYGQA+@nongnu.org
X-Gm-Message-State: AOJu0YwRVrG30Xf/O9usKICpxOFM+/OxEn1RL6XCI6g5ocC25Oacja0U
 iCyBn9WWrRt683dNjMpsVbh3o9Oo0I6sufb9Fsa6a9s3Pwf8bAuY9lL9DeGaTXy/4Vo=
X-Gm-Gg: AY/fxX5pq9iIEhy4hUtePL9wa/h2y5zYP668DeuTKSC1z7m+piGXZouz3thYQBrxJuZ
 IaYF4rVM/15QgRKIv+3oKJVhx4u9vHqa6LIoAnNzwX5NMVj79Au3Jrmh5vgv6d7VuPL8Rq3FduF
 DH3nabRCwEMlgyUIciv9+TVYmLKiVn8nu8az+jUFGD80CHEQepywN9tSU/RczrcObwKM764oTp9
 2p4lIaYDJMXuuycx+7hMYAVEEB90b8CGTzYL2XoCI7j6DsLSvk3ynSKtNNsi/16cEnhp8iGVXyy
 kNxHQ0IqB18+ehyInhaEajqSkRkS3AQHhIxILNpDhGyUuzzFn2hNc8QdY5/KjrtzDtAh0HQnjF/
 7XvKlHeYNia2aiMOE6njMj9efXbVpXWtknrSiUCeLAyW62IGcd7bgut5HCxT35QeX7sZ3E+CD5v
 q5oZ1XoxCWCmB/dNF5jTb9r5znU/KaN/9C5g/oE24Ti0qO/wkUKypHCSGt0tLQMQ==
X-Google-Smtp-Source: AGHT+IEkXZ2Js/9K6VC7V2WaZVqnkfhcwAHybMV/ijNK/MUY3Svm6lSmZoRrqa3ItgDpvmxP3Yaj5A==
X-Received: by 2002:a05:600c:3489:b0:477:7ae0:cd6e with SMTP id
 5b1f17b1804b1-47d206a9856mr247625985e9.5.1766849947066; 
 Sat, 27 Dec 2025 07:39:07 -0800 (PST)
Received: from [192.168.1.15] (alyon-655-1-564-32.w80-9.abo.wanadoo.fr.
 [80.9.105.32]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be3b3a80dsm206584465e9.7.2025.12.27.07.39.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 27 Dec 2025 07:39:06 -0800 (PST)
Message-ID: <1b6349b2-c313-421c-ae89-6a094f6627ef@linaro.org>
Date: Sat, 27 Dec 2025 16:39:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 003/153] include: name the MemReentrancyGuard struct
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20251227091622.20725-1-pbonzini@redhat.com>
 <20251227091622.20725-4-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251227091622.20725-4-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 27/12/25 10:13, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   include/hw/qdev-core.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


