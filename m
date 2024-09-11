Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67C04EE01FA
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 02:15:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soCse-00036w-2l; Tue, 10 Sep 2024 22:14:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soCsc-00035t-IQ
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 22:14:50 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soCsa-0001OK-T7
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 22:14:50 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2068acc8a4fso59213815ad.1
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 19:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726020887; x=1726625687; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=W38YS+nOGBKh9On0bIFr/0AwS7EYfAE49Ulh7k+NJ/k=;
 b=QaxuKLjjSod8j7sBRTKRDiLnZIH0mxr1fYuRdO/vYk2OcUhUMEb0vz5JZc6EqKeBMB
 4zxAL28309ILneAMRkmZbwMz4fQAqjsdshLMkjTnQjYDZFGuFrOEXJN4YUqd4zm9jOu9
 IecVrf3KHqRq3xj04IiBNV69Pdg9RsC8l5dkhSRsLvW939Ii5d/8j6jmnEM8W/ZzUxb0
 3gj5YZsTfv4DPhoiuUm/tXv2G+kz9vgHJC0F4uG2cYSdqNZHG09iMhddJJq2/AbfcMMN
 xIo6kqSdOB0OIprtvjwHm3BKaQ4DEbE8otpNDYC7gbCXduhR+j5OAf4jVaj+k1CD1nR7
 mZ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726020887; x=1726625687;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=W38YS+nOGBKh9On0bIFr/0AwS7EYfAE49Ulh7k+NJ/k=;
 b=BLV4bF8ZF7TgHuTo0juitsL2s9uMpNsEpnNL/BvP9enKPyCTR3VvYB6wkqAoPCMIU1
 bLJuo+13hYKB9sv5BiVhxOYx7d9cAwyDatccOjpcfSim1cGOA9o9pF63ORGnN3Oxlace
 gwqAmgV70Vmo3eULv4x53pC0njy5mPHSmblwLAGowKhvPeHNqlmQBhmf9UY/r9sCKkNX
 1Su0IH47k2elH19m60gqXzPRWYm76UmfkBIns3dONtwBEw2it0T9HU94nYw36Zn3VdFq
 +BnBs+3jh/uTcOpcMtK4hlm7X5uREInAaRDwKLHUd+LpKHpPMUG2+XNTlAZf99BF527w
 P3dA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBB879M2oaSEweXVbHUH/DqkgtZlmfIWVn5SAOvnr/8Q+GoXa2XtRgu41DNsHOZB6wyWPerei0wXYa@nongnu.org
X-Gm-Message-State: AOJu0YzzkNajMeDuupawjXdz1nsvhiF2VdHpnsSg5nXM4NEgY0EMlbxc
 Sys0qckdMinj86uhfpNAg+pDbo1idq+lcQ+Eiw9UxCVzxblSNYTDzPeCWL7VLck=
X-Google-Smtp-Source: AGHT+IH7IXSMjg/W3o5esA7r7EuWyi86QWFJLlM7R6ewRNT72RBIvz/usyd8J/exLIBENAl5t77nLw==
X-Received: by 2002:a17:902:d4c8:b0:206:b7b8:1ef9 with SMTP id
 d9443c01a7336-2074c4af9f2mr38757375ad.4.1726020887053; 
 Tue, 10 Sep 2024 19:14:47 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20710f3552bsm54314265ad.289.2024.09.10.19.14.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 19:14:46 -0700 (PDT)
Message-ID: <41691d2b-b208-4397-8eaf-e3749a6cf08b@linaro.org>
Date: Tue, 10 Sep 2024 19:14:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/39] hw/watchdog: replace assert(0) with
 g_assert_not_reached()
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <20240910221606.1817478-1-pierrick.bouvier@linaro.org>
 <20240910221606.1817478-8-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240910221606.1817478-8-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

On 9/10/24 15:15, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   hw/watchdog/watchdog.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/watchdog/watchdog.c b/hw/watchdog/watchdog.c
> index 955046161bf..d0ce3c4ac55 100644
> --- a/hw/watchdog/watchdog.c
> +++ b/hw/watchdog/watchdog.c
> @@ -85,7 +85,7 @@ void watchdog_perform_action(void)
>           break;
>   
>       default:
> -        assert(0);
> +        g_assert_not_reached();
>       }
>   }
>   

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

