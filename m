Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECD06CCD1A5
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 08:41:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vB7vv-0007Er-HH; Tue, 21 Oct 2025 04:41:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vB7vt-0007D4-2b
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 04:41:29 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vB7vq-0000hG-FK
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 04:41:28 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3ee15b5435bso5311244f8f.0
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 01:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761036084; x=1761640884; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9pdjAhGPOKbiWGXRfMs4/Rv2ViRZ+hqcx69OXv2qTHA=;
 b=ctG56pT39yLogszykA8gD9fpuLDqRyeXYM3Klo0p31Df1nfujVEDUiR0fBpkwI+WhR
 c7Hy3gKaKaA94lS7BXneBZanhlU2Or6TP6NvOyx5mRpSoe2ALWodw7uh0Lk9ypeLK0JQ
 wPJYQVa0e8bVnSeXqPDegpuLyC9J1aOuE3EV3Eo3BAaI5EVwvV8kg+t8A5J9Mr6P2WaD
 7DILtfsdK0aSTRc+5eHmR+OAYwZahCqx0qFJovGhrzgvvie/7/iLH+a5qZ+xARLeUy3v
 AhN7mzm00RyWWwaZwkZ52CJjUdwzrc44SS1wEmFYcoWw0pegiqPcxjo7RSwMOJ9kc3yF
 MFLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761036084; x=1761640884;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9pdjAhGPOKbiWGXRfMs4/Rv2ViRZ+hqcx69OXv2qTHA=;
 b=WDnWgcm9cQAgX298LzcLxmodBmw0+qkgk9uvWmSU5Cv8GC99aXvskHNa3yKHVbuXRo
 HbCpVU+aBqKaufX349mRTdq8Auk0MFzDoBjGBOxgEDj1D2guR6fXRjAAmRQPiKQIK3HH
 ysigJACjnWHXqUmfS+gUtoPhvQxjtpEwhukQ4+xcL6PEOmoCoNPhJW6SvtvSeYYn46mj
 XzAt3SzseWv4RGkC5UzJeXEmUCT5c+9Y8Ev0A4Us2+a+9RCfOhWe9dfMudvR7SuGBNC1
 ot0L26pQzrCBNz048XE0iPL6gLiG/rwi6O3bLhGFNFk7D6L9zb4hY83sTe//3/m3IPR4
 ipeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9Edn6UJlup9f3DxsFlQVeAQg/tdsJVxpEAEp0u+C1a2j1cqtLbxRHuSIfPXdHNz1gFCpZnQZwhJCF@nongnu.org
X-Gm-Message-State: AOJu0Yytopb2I1RKEpWcR2FAVMbkSaJD0JtnyC6Nin6k5qEy1h4PNIjE
 yC9BJ5XStIrqqgNL7BOpcKWV+hbTuwKrqgbEIEJ88J5HC3azRyJBhOkuUDZHu2aRipU=
X-Gm-Gg: ASbGncvT8kLrMMBGpoM1JaPl9Z1CDkRQ726l18cACLXNtsPSEBwsvAj66k5RB2wE1Tm
 8WNuU4PGGeqliG9yMyarH5JhHCl9sr5Rqo41v1EHmhVjYQtVHmrjn14WtHAxdtVedZnpJtI4ZQ9
 dX4JwX5WlZ1PrRhb4ruYm/MrU9dEu5rfrhDEyyj3sjCTm+bihX7tt2kukcXdUNkk+cYvd7eoeaq
 tYuSFQ3aVMJBUHHRcJfwIVn+3B2CMhmXlx/0Qo0I2fjdFQe15yRA/i6obgglBnLjeYLYnZ1WaNa
 gGNXmrGmYBJtGTkMvP6JPlEHMJ46DKXT+ZhQoe2NQjkho0eTSBDn/xh3OSGGIETosGv/51AqR8B
 IGc1GqREEeL6ymI3E/BKkX0AXbYYv6H5lxeoj6WG/H9rVxAQyiTKn8yopFByK/qV6jNkfrQAThK
 lDDgiauPTmycUvW35idjJTFFKDRTN6ll8ZmDjVRXQ8MegtrxQMXxG29A==
X-Google-Smtp-Source: AGHT+IHLb2hhls7CmzdC5uuJ3k8uDyLGIIrHJLKfQUIGVoKZG6uX7C3odt0aWNSChx6y9ZBdugjjtw==
X-Received: by 2002:a05:6000:40e0:b0:428:3c4f:2c4b with SMTP id
 ffacd0b85a97d-4283c4f2dbcmr7502853f8f.46.1761036084042; 
 Tue, 21 Oct 2025 01:41:24 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427f00b9fdfsm19074155f8f.40.2025.10.21.01.41.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Oct 2025 01:41:23 -0700 (PDT)
Message-ID: <6308d43b-32d0-47fb-a103-9105d56ab31c@linaro.org>
Date: Tue, 21 Oct 2025 10:41:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/18] hw/ppc/spapr: Remove deprecated pseries-3.0 ->
 pseries-4.2 machines
Content-Language: en-US
To: Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Nicholas Piggin <npiggin@gmail.com>, 
 qemu-ppc@nongnu.org, kvm@vger.kernel.org,
 Chinmay Rath <rathc@linux.ibm.com>
References: <20251020103815.78415-1-philmd@linaro.org>
 <fdb7e249-b801-4f57-943d-71e620df2fb3@linux.ibm.com>
 <8993a80c-6cb5-4c5b-a0ef-db9257c212be@redhat.com>
 <6dcf7f38-5d1d-47a0-b647-b63b9151b4b6@linaro.org>
 <6c1c6488-679b-4bb8-8fb2-569a9f705ba7@linux.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <6c1c6488-679b-4bb8-8fb2-569a9f705ba7@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

On 21/10/25 10:34, Harsh Prateek Bora wrote:
> 
> 
> On 10/21/25 13:16, Philippe Mathieu-Daudé wrote:
>> On 21/10/25 08:31, Cédric Le Goater wrote:
>>> Hi
>>>
>>> On 10/21/25 06:54, Harsh Prateek Bora wrote:
>>>> +Cedric
>>>>
>>>> Hi Phillipe,
>>>>
>>>> It had been done and the patches were reviewed already here (you 
>>>> were in CC too):
>>>>
>>>> https://lore.kernel.org/qemu-devel/20251009184057.19973-1- 
>>>> harshpb@linux.ibm.com/
>>>
>>> I would take the already reviewed patches, as that work is done. This 
>>> series
>>> is fine, but it is extra effort for removing dead code, which isn't 
>>> worth
>>> the time.
>>
>> My bad for missing a series reviewed 2 weeks ago (and not yet merged).
>>
>> Please consider cherry-picking the patches doing these cleanups then,
>> which were missed because "too many things changed in a single patch"
>> IMHO:
>>
>> -- >8 --
> 
> Thanks for highlighting the delta cleanups, we can take care.

I'll do the job and repost, don't do it.

