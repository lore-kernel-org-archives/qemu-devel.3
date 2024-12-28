Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 814E5E77188
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Dec 2024 22:55:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tRfhR-0005On-Ef; Sat, 28 Dec 2024 17:54:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tRfhP-0005OV-Cd
 for qemu-devel@nongnu.org; Sat, 28 Dec 2024 17:54:23 -0500
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tRfhN-0002Tc-Tp
 for qemu-devel@nongnu.org; Sat, 28 Dec 2024 17:54:23 -0500
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2ee9a780de4so7697139a91.3
 for <qemu-devel@nongnu.org>; Sat, 28 Dec 2024 14:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735426457; x=1736031257; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hadw9i5P/AYlJ8iz640CIaPmIEKiTB8TepOzhvnT47s=;
 b=aFc2UMGWZ+kfqsHLAbLRsuBW6vHSq4NPxdncsHRauxfuVlTQCJVQxpiKIvT7/T9/P/
 ICoTQLgA02ncKppigNJ222Vn5VpVR1WJ77sM+9k5lRrYWGvS3H6Tk7T0pUKsql3c0dxA
 kLx5ZLPdkF47yi9QR5Cw+HQvSGnaZUzScZlYxJ9824WhfXGlqReWwc6W9kBwcgnhPG0q
 pva8qvA+TqF2fKg2CvznPnCYdCGOKW7ezZ1MgsFZ4TRCzk+fp3B6K3dmkyqCO9ccGvwI
 tYx2ZDcs+zUJjM1ifBAPyCtp2aOhqmEpy+mJpVYAX6JazgzURMYR3GRE3ZwFnto8SNK1
 2brA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735426457; x=1736031257;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hadw9i5P/AYlJ8iz640CIaPmIEKiTB8TepOzhvnT47s=;
 b=ZMbm/RTGpPwdWfXHYzQ6hresyzHD77hiZGjElp4epha9lGvoPoe2dkqbTezru9Yhvd
 4LQFWBdfR/F5tJTARwgoBqJbExv7jenqyDpfc9ROi/sFAUH4EBHvxoeK+n5H8HAeml43
 I8t44SCv6ILyGfFN0t04nvXgdmeSTOK+2MPopuxhZ2sPp0HlSlXRoUIsYR0ZMxMycckY
 S8m+WBMgJeVdTrY4Wbh7m+UjeODv9kwZ73WfmHhVFsjpeSNnR4AJPp4dna/yP2st25uW
 d9EkPB2HJOMqL/0PTvcb4ELLSHjJpqU8yBmMU1Cy+GkvUF02s96Cgdwt3TjOAw3CFxqc
 RzwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRHYjeEhaOLTC+d5Vpd73noxtnCwQfRUYyisih3kodsOjOY8sQs2RtGvERkfWhrNBeih7VJa/y5spP@nongnu.org
X-Gm-Message-State: AOJu0YyaE3DHStJNnai7keby/Y12W+z4/FjIFguCqhN2G0FJXlcg4zhO
 M1yMju1IMzLjZCdwCR0O8qbv2HcBb03HGdX+jhIzuUbXY9xp6JAuXfepguY3m18=
X-Gm-Gg: ASbGncv+N7krHZbcgIfNl7YV6xfcp23AVd90LZvHnfI5zr8F0nhQnu3nkxcjDHAskIx
 7u7WRzk+Jqz1JAULbHh391EzLugwHVkBiYkB82WQ/R4ECyeWux/gdd9SWfiLQwNU2FcLJ5WCoCj
 qh7Ey0YXxIacd0m7hxAecmyQODf4nWiHEywVrrKd320MeRlQP2BGSfaGnsKlPgoTwbUx3g4s/Ja
 WLSa9B2xbppsYXk9vzwCZlcCWAMjGHV7lQEGFN0Nc9CeNfOz5MKRcHqdEX4IZiYuhexXXiwYTBe
 daJpxgGLKSiUC1JsVHsnZTrNN3XuJyTs3bthm1Y=
X-Google-Smtp-Source: AGHT+IHfa+drU2a26MJABbz6QhZd8w5m0rbj4Uyiy55k18RFYrkIaVXsYNXoducVK1KEYE6AjvaW8w==
X-Received: by 2002:a17:90b:3d50:b0:2ee:cb5c:6c with SMTP id
 98e67ed59e1d1-2f452e4c520mr39744315a91.22.1735426457323; 
 Sat, 28 Dec 2024 14:54:17 -0800 (PST)
Received: from [192.168.125.227] (syn-156-019-246-023.biz.spectrum.com.
 [156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f4478af924sm17951667a91.52.2024.12.28.14.54.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 28 Dec 2024 14:54:16 -0800 (PST)
Message-ID: <5f906c4d-47a7-4741-b6d1-5c9c1ddbdcf7@linaro.org>
Date: Sat, 28 Dec 2024 14:54:13 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] target/hppa: Speed up hppa_is_pa20()
To: Helge Deller <deller@kernel.org>, Laurent Vivier <laurent@vivier.eu>,
 qemu-devel@nongnu.org
References: <Z3BouGUFFP87PJyx@p100>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <Z3BouGUFFP87PJyx@p100>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
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

On 12/28/24 13:08, Helge Deller wrote:
> Although the hppa_is_pa20() helper is costly due to string comparisms in
> object_dynamic_cast(), it is called quite often during memory lookups
> and at each start of a block of instruction translations.
> Speed hppa_is_pa20() up by calling object_dynamic_cast() only once at
> CPU creation and store the result in the is_pa20 of struct CPUArchState.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> 
> v2:
> - moved init to hppa_cpu_initfn() and is_pa20 to end of CPUArchState struct
>    (feedback by Richard)
> 

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

