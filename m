Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E51ABD66B81
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 18:40:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVwQI-0006i5-Dk; Wed, 17 Dec 2025 13:38:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vVwQC-0006a4-A5
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 13:38:50 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vVwQ8-0007o7-Ax
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 13:38:47 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2a09757004cso54828415ad.3
 for <qemu-devel@nongnu.org>; Wed, 17 Dec 2025 10:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765996722; x=1766601522; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=seABeKHpcn3xEvoXlJNdpC7YVLBGOeOifIAM39GElZU=;
 b=csguFCS+Wo6Y8sHY34zE4hQXDT9q/ZOKrwtirJQK7EMJS18spW9HG2d39mD6KOWmgi
 r9/MbgAOyReDacmVN8c8Zs9RC6MLw63HY3NnvsatEK1Si3dyo33mNFmcvBWS8kGTdl+T
 O10m5uT2Mqi0JQ4SCo8b+bJSQOG+YNAggtQBeGn2hGaqhf7MBXJ6Q6uDsqepV6uLFKX0
 qs7iXx03aiOjmfUeimC2c8nsxD/jNJVrej5+IF2jjL1KLPI3fkP2I+F+lH3Z8/pyGbfO
 JLk2uEi66wNJAZ9EidBwpU8BI+bAQ100MgJPVjKtFR2zVi2QgM0fG+7hTw6ZfcpeU1IC
 cOwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765996722; x=1766601522;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=seABeKHpcn3xEvoXlJNdpC7YVLBGOeOifIAM39GElZU=;
 b=rfN2jWKwwVbY921JrZmpLc+Tn/WqrN9nKKdIsYYdj1DhnKvUAsSF6GGWh7fHCKgDcg
 0UFr3WLsXP+3VXeyf9W/IxeOhHa/uMd/qMHb3jsge0Atm8jscMNOGsDP+IrsCN2qVXGa
 ZbpCOgc174pZoVqJ8qf8SsdVnC/WgafSWanR4gNnkvOZVhftVCIUjy+WuS0VP4xHKNR9
 gOVbLQhrmEe8NFdBKlHpwueXs/YUTK5Kbu26J9hrMrdADkKbHY7PXM5tREfqd0J5ryTi
 /4gsy01Gb0L0vUwkD07SuRw03Ft3aqiDTn106ZOW13Bubtm+dScR3kgNorYqGab3RtvF
 dRLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5nDcvIXEPzPWERWRYyFDdc7nGuYaIPl9MmPlNY1ipmzfxx8zRDnE1V1rijjuwGuugv2jDp//ctTOC@nongnu.org
X-Gm-Message-State: AOJu0YwEIwZfLVvWndBfG8EnZDMAU7UCcU/ft/PMwYJysc2fpWo8hbg/
 nEOB9bHwDonkRGV/ws40h6u36Raap3Qg/lte90rrscIxIclKrgBMBMcCfVdyPrigtm0=
X-Gm-Gg: AY/fxX6BDEwb2Yyu+S/Q4yoZnZVn1UvZV+FoRoHIKYrlHxCCSbGzlkBfXNGHLsIQkUj
 nXGf0CZjBsmEIHtxQS0zjwatDcSXsFhYkgy2oRagHV3YRVWOhadfM+5/YhgNpNZKhlayE5D3Q3j
 PKBBNysGrs3i/dedUo+GXSXnHT+V8TcUQLS3RFTJ1ClC038VD41YmvkoH9H6wVpVXmZNPtk2VxN
 uPXj5rNcTaXXDh7tVPxumv2K8ZVF5s1SI319HqZV2nSTjlQeWdlFhTk6E8g+HjKp5rXlJUAoQA1
 75rt4Pj5hVHCYxeQj1mfnUps4qcosgKqtauzGz5YWOEdi3Eb5IdQGIPSUOVuJxH7qiw0rO/k+Dr
 sA3wzpIg7eLRV3pP/izj+uUZQlNm94uchdWacpg4CLlnKyMTJCXI8etmaT7ITCoKRJvjzBsvPK9
 lCfDc39K5JNycGXiWJLfX79mM/OQQRTTFuHQVItNA8vWOwxboBDvJnwRs=
X-Google-Smtp-Source: AGHT+IEVhglo+Hr2QPGO23r8JcmASMupGhNaTkRzw+hYZgeeYWBybC/0N79C+m0PeIHwcHPmzz6+MA==
X-Received: by 2002:a17:903:3843:b0:2a0:d403:a2e3 with SMTP id
 d9443c01a7336-2a0d403a5cemr135330545ad.37.1765996721541; 
 Wed, 17 Dec 2025 10:38:41 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a2d19269f0sm208365ad.79.2025.12.17.10.38.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Dec 2025 10:38:41 -0800 (PST)
Message-ID: <c5f0b0f1-cd02-47fe-aae9-1da25c91f6f0@linaro.org>
Date: Wed, 17 Dec 2025 10:38:40 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/14] target/i386: Remove x86_stl_phys_notdirty() leftover
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 David Hildenbrand <david@kernel.org>, Peter Xu <peterx@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
References: <20251217143150.94463-1-philmd@linaro.org>
 <20251217143150.94463-2-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251217143150.94463-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x630.google.com
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

On 12/17/25 6:31 AM, Philippe Mathieu-Daudé wrote:
> Last use of x86_stl_phys_notdirty() was removed in commit 4a1e9d4d11c
> ("target/i386: Use atomic operations for pte updates"), let's remove.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/i386/cpu.h    |  1 -
>   target/i386/helper.c | 10 ----------
>   2 files changed, 11 deletions(-)
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


