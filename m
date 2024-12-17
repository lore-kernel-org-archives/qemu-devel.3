Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE85DE7716A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 07:11:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNRj4-0003EL-MO; Tue, 17 Dec 2024 02:10:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1tNRj3-0003Du-3f
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 02:10:37 -0500
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1tNRj1-0001KK-Dm
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 02:10:36 -0500
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-53e28cf55cdso4367021e87.3
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2024 23:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734419432; x=1735024232; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=UQae+zCcA79EIlsX+SB2839BhRUwlMBvl5iQNG5MpRI=;
 b=zXqETOF0PTHPyQ2xgbCnCEaQrWUk4DWaLpvj4/rw5VNzwfTTlXOLiqOZCDajB/UcUz
 vNPhYLPOxD+LSSTmX5BtjZ+UXdZ7oGw4u5KrO55XxnRvtshWc47QaDasBrXCezUs3/ER
 fFHHOtN/N9NY7WHQ2VICo3Axp96JK1Rg+dCAlXEldkeQD8ozJ6n+E6Vj2Xfs9dpgg/Yb
 OsJCQr8EPu7NDwF8r52cdp+bqqQr4pj7SrHSbDEeT7V0pu/KF8XzK0pQsLvwBAmXECFJ
 rJ1TJWa6AQIsGMIYIjvn5QVms/yGawBi4SHC/ZBTZtyqoeE2006NiorYW+dvnChptUhj
 zLOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734419432; x=1735024232;
 h=content-transfer-encoding:in-reply-to:organization:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UQae+zCcA79EIlsX+SB2839BhRUwlMBvl5iQNG5MpRI=;
 b=P5Eg3j9NCsvTWIkAnLNDbbugX2naqDWYIh/eYkTuqgzuqNfis6MQbo0TDMS0sdMEoJ
 DJbuAH/eEbT+hn3obJ13+qMZlyR79bAHT8nFBsqgmaq27/TacxDgBOerVMSxRY/PvemX
 TK2+e2t/TOZIYrlvjT+PVOlTMEYjURueqXQLk2u9L+JEjPngkEd6vMVdnDmEhcaaq7Rs
 3Dy8BlpZ6Rr4V+QskT18VJFSS1r5emP6E5xeyme4JD14ydNM8ZB06xEMvOWaLd0ndAdw
 nnhgbL+/YsJSgel22f0RaQme3QGVHk8RJECgZB+sZ5SwuAVbkESO6vr6LOyQYjOs/FCz
 cVxQ==
X-Gm-Message-State: AOJu0YzSAvd7HsoGDvGtSSCC0YmsARuweozGVbqtjQEGXCaS/gObwweK
 UE0+qmfBBrREXoVT8ozsKm/cbnUGhvHceD1DoKro4OdRchI6bMD5HApd8z4lueM=
X-Gm-Gg: ASbGnctxTyAQX9vVwFpRsR37LajDAUxKN/rtoU1uN3B9HsZGBWSIkYGQaXyfV0dbhe4
 cKIOEPizTti0oHvltT96VsDfw3zsyRxugdgA0nfnPTvJj7yOK+6NJcm8kHUY8pgGSE5apgqx8Ck
 BF97+BFM+s+CKxtrSnju9En5nrqtV/VyT09qdFKZr1vK2cbVmYdqgbZF3VF+KifTTBXgvcGwCB8
 MvEbGMS/PJK48z3PFl0qumElY4lfJJKfCGu0tvKJyA8E1k9HCqtStcWlInldvwMESZ21pI0O/7Z
 Zz5+OTSDrUNJ7UYZShsKnswZFAsptpOkKvUUMQ==
X-Google-Smtp-Source: AGHT+IHD6XuXugCi6AsXneXRa4HMYsydL/++C0anz1aIBR1qOR2wJK/J8yz9PCDGsflx//1E8bv5ZQ==
X-Received: by 2002:a05:6512:39c8:b0:540:2fe6:936f with SMTP id
 2adb3069b0e04-5408fac7b04mr5674884e87.3.1734419431628; 
 Mon, 16 Dec 2024 23:10:31 -0800 (PST)
Received: from [192.168.210.26] (83.11.13.135.ipv4.supernova.orange.pl.
 [83.11.13.135]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-54120b9f3f2sm1077214e87.31.2024.12.16.23.10.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Dec 2024 23:10:30 -0800 (PST)
Message-ID: <7d5f349e-761c-459c-93db-cc32ec2a207d@linaro.org>
Date: Tue, 17 Dec 2024 08:10:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] tests/avocado: update sbsa-ref firmware
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Radoslaw Biernacki <rad@semihalf.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>, qemu-arm@nongnu.org
References: <20241125125448.185504-1-marcin.juszkiewicz@linaro.org>
 <CAFEAcA-V3PGF7vst8QFjh+bWVx5EGDt_B9ZCe1OryNV8e39N4w@mail.gmail.com>
 <CAFEAcA_SRU5UtttB=G2=L2YSK2D1U7Rumbc6eafioxR3yfnYUQ@mail.gmail.com>
Content-Language: pl-PL, en-GB
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Organization: Linaro
In-Reply-To: <CAFEAcA_SRU5UtttB=G2=L2YSK2D1U7Rumbc6eafioxR3yfnYUQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=mail-lf1-x12b.google.com
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

W dniu 16.12.2024 o 13:46, Peter Maydell pisze:
> On Mon, 25 Nov 2024 at 13:25, Peter Maydell <peter.maydell@linaro.org> wrote:
>>
>> On Mon, 25 Nov 2024 at 12:54, Marcin Juszkiewicz
>> <marcin.juszkiewicz@linaro.org> wrote:
>>>
>>> Firmware is built using Debian 'bookworm' cross toolchain (gcc 12.2.0).
>>>
>>> Used versions:
>>>
>>> - Trusted Firmware v2.12.0
>>> - Tianocore EDK2 stable202411
>>> - Tianocore EDK2 Platforms code commit 4b3530d
>>>
>>> Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
>>
>> Hi; what's the benefit to taking this update? Would it be better
>> postponed until the 9.2 release is complete?
> 
> We're now past the 9.2 release, but it would still be good
> to know what the benefit to updating the firmware images
> for this test is.

We tend to update firmware to the latest in all places it is used. 
Previous one was built from pre-selected git commits due to changes done 
during cycle.

Now we got both components (TF-A and EDK2) from stable releases.

