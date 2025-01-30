Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0167EC0218A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 10:28:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdRlw-0007cX-Aw; Thu, 30 Jan 2025 05:27:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdRlt-0007a2-PF
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 05:27:41 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdRlq-0000wk-VV
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 05:27:41 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43624b2d453so6334905e9.2
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2025 02:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738232857; x=1738837657; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0HEnfd3vYGqVopqupIod4qfD+i2GZ/7R21Dp9JwJvKQ=;
 b=el9KjAMWWRbkGnU5xP+Ldqt8fWycHx9D8ZI0G7sy7+ATVCevSsmy4FpmR+jh0Q2/B4
 PvKOzzHVqw2PEec9esX6XY5A7UjLAVvdscdaR6FDp+UT1Mc8Z1LyI8c46KDQ64ekGA/q
 8b6LHSRRHK8Adf5GaXnomHoGK3s9LVNk1O3pautoPf8r+32Hu/vfZ94uBXxtpvejt244
 +GA6h13LET020K6/Zp8MmUBkz1uUd8GwIgd3/Khzl2hwV2+os5J1ltfUd3K1IpTSYhc6
 uerZaA22FF1fIJ3pjkQ+4PjPMDZzdFmKM1gXBzg20okOBAJ6IZsOD9qMr7sMOWcehI9v
 mFqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738232857; x=1738837657;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0HEnfd3vYGqVopqupIod4qfD+i2GZ/7R21Dp9JwJvKQ=;
 b=VJIN1you3gDbheV1MZfE3y9VjilQYNj2b1smdkhXYAvrqqJOYjOC1NKVUrQE9qgVIe
 Ve/jppovdNoHwGci7e/WwHCDcWHYE5tukS18t9zBJroiMfV71LV2zxnKCQ5ZFcBc3WBp
 vrTAK5PusAXDRfs3pz2kggOpb3asxW7zzf+Hdk8DoRLHoFVjG+Lrte//Tx+5QtU8qLuU
 TvRaEzGGOfOT8u/B0LO279rdig33l+x6P7j75RxtnUyyKaNrc5XF76E5xCiLC/WAr0sq
 qwY80+YTO6gXs9Ub6fgCJ/VMSBzNmMbE67p8n9e8b/PA20PqAqaCCPeR+duaZFQZEbs/
 Kldw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVw/x/b+zA4gt0gBIvYvLNyJBIQSQ6scExN4z9yjxLghV7SHcaupH5AotX98w3iPPvZbL/GsayN5b1/@nongnu.org
X-Gm-Message-State: AOJu0YyQ50wyn15BZNujqae4sxY+L8a/Av/0UFb02IPuR4OmadIufkTt
 MqYxqWQa9qTuVxs1hLmXXWR6v1sO46/f4O494Py2X4xo2jy0IYLeMsNtQDRXGYmLEHRbrbDoIZI
 0X6U=
X-Gm-Gg: ASbGnctg2EZnFxl5C+8AkPb7qVQUByAY/shXVRwkri8L7L5Hphs9jP9vsbtmRYwMSJI
 RQ5Ij5H6CN1n432rWsIwtVCH8g1xaG/OFiJbolJMch/4H7A26Kao3bSPV190MwvOEWUWlpfKbNQ
 COTryTKhs9274IjihhpE+5LKinCle+34Uq4b+H1Ka/48XheHUjHP/yY3vCBZSXU0eAWXHJsUq2t
 dsVXKMUQYmY3Kj+USVV/r/wi07684DedmSxANphQ1TcVSrtaoKh+s7h4dLlI91p5UD4MqNcVyrL
 DWKFPcnv8avpoYDTfvl7IgxGGc0FxvC3GEXQc6Fvhkwi0P4n1mpn7kkSD2k=
X-Google-Smtp-Source: AGHT+IG/OObATeVJ4F8gvOa86e4bHj3xhKH5FL5eUJxfjbJiWbSRKF1uJhqxBfZwv7gU0XIUQbUAqQ==
X-Received: by 2002:a05:600c:3c82:b0:430:57e8:3c7e with SMTP id
 5b1f17b1804b1-438dc4251f2mr50749615e9.28.1738232856658; 
 Thu, 30 Jan 2025 02:27:36 -0800 (PST)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438e245f49dsm17990325e9.35.2025.01.30.02.27.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jan 2025 02:27:36 -0800 (PST)
Message-ID: <7bea68e1-855b-41c2-be28-bf94a1b43cc3@linaro.org>
Date: Thu, 30 Jan 2025 11:27:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/21] hw/i386/pc: Remove unused pc_compat_2_3 declarations
To: Michael Tokarev <mjt@tls.msk.ru>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org, QEMU Trivial <qemu-trivial@nongnu.org>
Cc: qemu-block@nongnu.org
References: <20250115232247.30364-1-philmd@linaro.org>
 <20250115232247.30364-2-philmd@linaro.org>
 <9ee34c5f-d65c-447a-b128-96cf44b94b6e@redhat.com>
 <85be953b-7166-4353-85c0-7e15b9ec6423@tls.msk.ru>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <85be953b-7166-4353-85c0-7e15b9ec6423@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 30/1/25 10:59, Michael Tokarev wrote:
> 17.01.2025 11:52, Thomas Huth wrote:
>> On 16/01/2025 00.22, Philippe Mathieu-Daudé wrote:
>>> We removed the implementations in commit 46a2bd52571
>>> ("hw/i386/pc: Remove deprecated pc-i440fx-2.3 machine")
>>> but forgot to remove the declarations. Do it now.
>>>
>>> Fixes: 46a2bd52571 ("hw/i386/pc: Remove deprecated pc-i440fx-2.3 
>>> machine")
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> Thomas, such pick-ups from larger series may not be a good idea
> for qemu-trivial in general.  But this one looks okay'ish since
> the series is about 2.4 and 2.5 machines :)
> 
> Philippe, are you okay with merging this one through qemu-trivial?

Sure! Even appreciated :)

