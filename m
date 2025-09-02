Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 637D6CA0FFE
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 13:26:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utR1L-00023E-TY; Tue, 02 Sep 2025 09:25:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1utR1F-0001ry-95
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 09:25:54 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1utR17-0006px-0G
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 09:25:52 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-b0418f6fc27so336527566b.3
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 06:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756819541; x=1757424341; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VBAsnhXa4nvQDi8aKvR1n6R047OySgxdhCJTape8SyQ=;
 b=wTQ2/ta05eBI+F0sAZXjyqcXUBqYF/q9DSNqC7bmwpguK4C01sOhtVT4ZwsQG3gOdU
 SFLzHJQfn5IOn1+yq/+Uic4xS3om3/PmyeFxDJ+q3srEoD1OJNd+4z90hy45uo+VAPuj
 bi5ZQE8JrXqYHgnuqvkxQ2h1kAxoilh5KvVi7YjkZKMQkKZ7znLLLfxV6PgHLoHx4kBV
 CULYoHmYTR3MDqlnnn3vB15wvMvrMv8Uo+RIlcLbFXYgW05a0HTIXMCsBypCLFmrCcIa
 kTEWOLk4ob2AjGyNlT53aRatCY25PgvUwoXwTtfmCIgVTVMNo7m4rdZQ2WqPqbHVb4Pv
 9/uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756819541; x=1757424341;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VBAsnhXa4nvQDi8aKvR1n6R047OySgxdhCJTape8SyQ=;
 b=JeZc6ZwfvkdzUZIJdiwLbeAsw3Jr//x08hZE2QsIoIQIOMdaP1QjDp/hyhypquJcpr
 bd7ZBL8B2DDWLhN41cZ5psKn5HVHTfLzJxSpzgFW9EYCRrfK+WWSFwHL3eMyaqUX4tj2
 mi0FElbsLeKil/ZWl9TEQXYJVmgrBd/dkpe9eh9BT07iMQILEnafwlsyLEqvXBtAOKRb
 yzlYdpvWErWksa0JkwGSGVPQ0mvMiBQy353SktaTf9zYEmsoTt84vWBIMzU/70ZYcyGP
 LmCMx5G4cs+cyx6q8R2DDq8hYckWKJ0KXw0TJjbLqQIgMd72MyjNEmdwHepRuUdm43JR
 ywqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVg+cZhtHcyQop0XGwmACVrKNZb0lJX/Bnr1Np1pgUJIRj5tpQz6zONDXHSEUJ46x1nJha/HLnWe1sS@nongnu.org
X-Gm-Message-State: AOJu0YxHgDx09KaiwWKmfyp9Ck5/Zn5EmqKBXc/Ly7BgP270Pk51XYBl
 xx8DWILFebta5v/TFT72stQvAwA8sLJn08MRHbnjd+2DA9BmpAnwLH8dA02IIfLhmu8NaNmqA4O
 9PcYQ/Fc=
X-Gm-Gg: ASbGncuq/0kTE+Hp7ps4PzzluDCmkp1YKxlvznQKG5p4KjReA4EJ3dWaSMF3O8yFfYz
 96EH84luXzwGIcOUhHFii1zzn2tQWuzLAAIijJDYfydt4ZnM8BHO1kpbI1AcQAyJBvYZ9ZwY/rS
 djqWaSwWaOAH4KMd/yN4v+jwb/bhPdi43SaA2pxP9uW8gE5k/Qlud1lAiJhdRPArFy/bIMpujGB
 hqh62MOdLJxQfA0bQvvxCE8hPJro7FVojf6QhoypOJx2foOarv+mMznMx2HoO1SypzYWUvMfpZ1
 QANjyvytaAWKcr/FG/QFQ/r1vBDhXepp/Tn8U0tgsStAGsKSFZcFBMy+d4YJjDanYU2oPOuvMKz
 Vv5CnAkxeJ0REOlb/+zhLudekguOmfHrX/v6OLaxlbklAQ2nJSEHBChd/8VmVojEdJE8JM9+oUA
 D9aSQ3RQ==
X-Google-Smtp-Source: AGHT+IFqyTMaGpd8ZukEkVpy+1FFh10MCAadCDhA0Xh3VHbUMQc2/9OJ5mzrgQ3YR8HdwomEcAGRKQ==
X-Received: by 2002:a17:907:724a:b0:b04:3333:7e68 with SMTP id
 a640c23a62f3a-b0433338660mr656540866b.41.1756819540951; 
 Tue, 02 Sep 2025 06:25:40 -0700 (PDT)
Received: from [10.40.6.207] (93-51-222-138.ip268.fastwebnet.it.
 [93.51.222.138]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b041e6455casm606304466b.18.2025.09.02.06.25.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Sep 2025 06:25:40 -0700 (PDT)
Message-ID: <73b41cc4-dcb7-40fa-8ace-0fffd1f9465d@linaro.org>
Date: Tue, 2 Sep 2025 15:25:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: honor $TMPDIR in create_tmp_file()
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Cc: Bin Meng <bin.meng@windriver.com>
References: <20250831114818.4136358-1-mjt@tls.msk.ru>
 <93e542af-63a2-4236-9b58-b95eeb6b9185@linaro.org>
 <cff16756-3855-4fc7-8fed-0404662cf35a@tls.msk.ru>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <cff16756-3855-4fc7-8fed-0404662cf35a@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 9/1/25 15:31, Michael Tokarev wrote:
> On 01.09.2025 01:39, Richard Henderson wrote:
>> On 8/31/25 21:48, Michael Tokarev wrote:
>>>       /*
>>>        * See commit 69bef79 ("block: use /var/tmp instead of /tmp for -snapshot")
>>>        *
>>> @@ -862,7 +860,12 @@ char *create_tmp_file(Error **errp)
>>>        * so the files can become very large. /tmp is often a tmpfs where as
>>>        * /var/tmp is usually on a disk, so more appropriate for disk images.
>>>        */
>>
>> This is going to cause other failures, per the tmpfs reason given in the comment.
> 
> This is the comment:
> 
>       * This function is used to create temporary disk images (like -snapshot),
>       * so the files can become very large. /tmp is often a tmpfs where as
>       * /var/tmp is usually on a disk, so more appropriate for disk images.
> 
> It does not give reasons for "other failures".

It does gloss over the implications of "tmpfs".  But off the top of my head:

(1) tmpfs is generally smaller than any other disk-based tmpdir,
     so ENOSPC is easier to trigger, and
(2) tmpfs does not support several O_FOO.

> 
> Are you saying the user, who decided to explicitly specify TMPDIR,
> is wrong, and qemu should use /var/tmp which does not even exist
> (see the bug report this patch is fixing)?

I think this is a very strong interpretation since the non-existence of /var/tmp is, IMO, 
new and rare.  /var/tmp most certainly *does* exist with all of the major distros.


> The original code (before 69fbfff95e84) was correct.  Current code
> is not.  My change fixes current wrong code.

If this goes in as-is, you are on the hook for any reported testsuite regression.


r~

