Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FA12CAC5AC
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 23:54:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1Cov-0000to-9Y; Tue, 23 Sep 2025 19:53:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1Cos-0000tV-V8
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 19:53:14 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1Coq-0001rC-UZ
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 19:53:14 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2680cf68265so45861595ad.2
 for <qemu-devel@nongnu.org>; Tue, 23 Sep 2025 16:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758671587; x=1759276387; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sz7XfCOQUHEbVARaNnHhQS/7wUnja+zUrs5SqhMlAGk=;
 b=VfTBlLIM57PGWZGFRJAtqnxxDiweme0wB7vfZGQDtB7b3/Hu8YKAmq6AZB2SI7q5I5
 8JjJNK8mxL9ZALmXyRNapGjkbBVCjBTC24euXqCtiOfC+Aud8xFESuUn/tWgYBPHfoyo
 SP0hOgwtIe8jMqKVONyi06K6SM/QZSNJ/DhL3o+r7D9KRxJCk+Q4+L15ZPIslawkUJBS
 tVtu39u6AkuZhTrS4unG5GHLvt+95c+fRGb46ykVpXOqvUbVsRw2waRWpa9IGhbJ1UoU
 goPvrSBy5jjraXsa+tYsLwZE5ThQtbE0n3o64hyZVoNO4mBJtksHDalv3k1FAwUwS4UJ
 KpCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758671587; x=1759276387;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sz7XfCOQUHEbVARaNnHhQS/7wUnja+zUrs5SqhMlAGk=;
 b=OGcbIkdeYJ5yhM4AVUJg/8Qfuw2xbjEI15jG30Aw+91FBpOfvCEJv/uK49iHHd49CM
 zODXTDCuECX1+8pLkR+TDsKDEMkvMZ4IlZ5kbYrxvv2IDs70KZYTGU4LL2pAYRq8IDQP
 YnDXdPulqD1ck5vLlkLnZ34sH5x1MU0FVTOQe9yMgPqJ8ziIG6D2LUkHHsnXEpOEpJvj
 4dUFpXHte5ThLoDYmRJXSsOSeRAXA4Lr4KLpWoPtlPoKP9AQwGus2OlUebzh35ddN3sQ
 SZzRymaaKkMel3S/vGXDy5zeLOL5W6BYEuFJzXOPvvWaFC0Q0CmUypj+nncODBaZvBpP
 N2QA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXykh7rGM+4DR2zwESjTC/uFac1pd2oI26E5KToaE6clCbqO4BFLsbZ/YQduGqthbhB9OdcsS3fGr1E@nongnu.org
X-Gm-Message-State: AOJu0YxOCQCXiZAbUaSPWgT9sa6fQn46p9yahOhvn3WCX3Xw+XZ8kBs2
 sV/RauVPJgHOH+33fOaiC3KbcjCqkKWicw4Sd3mcFEGKSC/w4/ojcN11xpEK1U7K7lg=
X-Gm-Gg: ASbGncuQN/oOByG9LBCmJWJyrvsu+ubd1imXJGrL/o0yntI7g4UDuirX8ip2jnuE351
 G90d2kkW79mtmLCUrGyBAYJ0VvU2Oaxi+D/UAAKclAs4Vn2X7gc5URteS8CRfhkdJb4nn/R1FDR
 vvrLbQOIig+7TAivMcTs+DOva7WiHY/+lSfrGyJoAOdcaOXwlL9ono+pwmlawrMmaytwJw9oIzL
 wEbKj2eIA3slcMKY24A0PvROt3W7X8Yq7SuA+iVjw1WsBkd6FKSUpJ5lzUryIX1yGKvKQssoe19
 sSgCSFfVCUnuralAJ8kwEkBU+vc4Z0xYy5I8KgKqXr05PIFkdGms6B0Z92uDjs//FA51QiE1FEU
 rH65oFyYyINrS/Wj28b8Ck8Up/VOUqjRKaZom
X-Google-Smtp-Source: AGHT+IHV80gDW9y5mUA23vpux3vyp4iY8uh9biVdzc6eQJZJ0mDp9qd/G4R7o/zcox8l9Rsv2UtHwQ==
X-Received: by 2002:a17:903:3bce:b0:24a:fab6:d15a with SMTP id
 d9443c01a7336-27cc185851emr43937975ad.20.1758671587094; 
 Tue, 23 Sep 2025 16:53:07 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-269802de963sm169992525ad.77.2025.09.23.16.53.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Sep 2025 16:53:06 -0700 (PDT)
Message-ID: <8adf8096-4279-4549-aa89-4aafe262e5fb@linaro.org>
Date: Tue, 23 Sep 2025 16:53:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] hw/pci-host: fix use-after-free in hppa pci-host
 devices
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
References: <20250918114259.1802337-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250918114259.1802337-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

On 9/18/25 04:42, Peter Maydell wrote:
> This patchset fixes use-after-free bugs which show up if you put
> some of the hppa pci-host devices through an "init -> deinit" lifecycle,
> as the device-introspect-test does.
> 
> The problem in both cases is that we were calling pci_register_root_bus()
> in instance_init: we should only call this in realize, as all the
> other callers do.
> 
> These bugs show up if you run 'make check' with an ASAN enabled
> build; they are also likely behind the intermittent segfaults
> on s390 that RTH has noticed recently.
> 
> thanks
> -- PMM
> 
> Peter Maydell (2):
>    hw/pci-host/dino: Don't call pci_register_root_bus() in init
>    hw/pci-host/astro: Don't call pci_regsiter_root_bus() in init
> 
>   hw/pci-host/astro.c | 27 +++++++-------
>   hw/pci-host/dino.c  | 90 +++++++++++++++++++++------------------------
>   2 files changed, 55 insertions(+), 62 deletions(-)
> 

Queued, thanks.

r~

