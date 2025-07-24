Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4E63C83F26
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 11:43:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueuLI-0002Zy-GL; Thu, 24 Jul 2025 07:42:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1ueuLE-0000zY-W6; Thu, 24 Jul 2025 07:42:29 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1ueuLC-0006Vn-CT; Thu, 24 Jul 2025 07:42:28 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-23649faf69fso6607795ad.0; 
 Thu, 24 Jul 2025 04:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753357342; x=1753962142; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YGJVUz9mBibmGgtEk4Y7L7qVGPbSoKqxK7OY/c4JxbI=;
 b=iGkq9GDe9HRPCzeEA1aeDk0X5WCjDYGsRjxdcGSghI5DlLl+Fz2BgDb8qOsibXc2sx
 KGw7lKrGTFDXu+yfGzJigXLEBMNvogyr9rHDQOKbuMjYUWtzOR6SWQkE9boOsKFYpBXb
 FMejsqL3LNxAHz+BYQFWYzi6uOPugMr9LSZwJZ75F0j+utm9iCbKchSaV33uCzT0GMW0
 Svz7MnGQ4TXhnbGzetQdALNAQ+N+KUVgj6Rgy5b6nnkH7Uv77jnEp1N0LBidzPkhfWqu
 4gFFV7qCFdAMwUdiOBUCc5wuWp8+K7tl2PG7FEnjJ/7sTRVvAyuWHDdgY1FHi11wUX6n
 OaAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753357342; x=1753962142;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YGJVUz9mBibmGgtEk4Y7L7qVGPbSoKqxK7OY/c4JxbI=;
 b=k7DF60+XXWfy2K9yMiQILroeDcEbSgyddZGbwo/3idVMPMqGKFw1JL5IfMAn27kUyU
 1677Eo8ov//p0Khg0IXIMTnFy5ZERBEa/Jv23AQgdPVXYqBcVGyn7brjYmGJgvTiJOos
 X19SxfHa4+iCfmDexmySHXMrZk9Mq8GXaGMQFGBNHSmuItNpnEVCNkDlmJsZZExwgyD2
 5sgiVP3Yw0k4+iLHdzvOhuJO73n/M4aecXeoo0y3V5AecUkk3oqsBoCn5+tbiOJpIEam
 GJJP+bmL48ZfM5MAv6W5FOG+EvIRUh16k8Wt0+UnyW3AJ4EnTME99P0kCzI56K3c+2C7
 77Ow==
X-Forwarded-Encrypted: i=1;
 AJvYcCVO7oOxRtOID9TFO0yoNf57pVMQmF/42evwpgEC3Kp02jTTg5kzKhKe6qM0RTqwX/Dwa5LQ5+aLUZnI@nongnu.org,
 AJvYcCVrn521OCqynGBjKX+5y8jUc9KXzeTQl3YYY5fECH/lUzfb6+Ecr54gLvP/lvl1Ffjn2xpkK2qcvtg=@nongnu.org
X-Gm-Message-State: AOJu0YzAUIYMInHfMs8PNrDemKRtea7GQTRR5LM10JOZk9DStBke7OFj
 vdYuPYJWVnBWwyjAMMHD3ww1k24rZyGahCrt+axyuprOVz2jznKwkj2c
X-Gm-Gg: ASbGncuTBLcSRIx2G8D68KUiSfsSqWJl7UtQagYWiyH25+b+0XT4ZXRf9zfVoVVlW7O
 lv8xPB/q99z2YMR2ZYBTDI8nwpg/3kvMBDZ/RNZai3uTo9FwRSnnr5Md08wU9uWANfqeE9DSS41
 LnBryQiZGs2M5FFoUbIZPrju4hv7zDjIF5GWDwTCVNDMZgypJOaKqasOxSQphjAJVAurrXAYn9s
 +t09q3oXdJ68vstBYBwCEIWV1HLpezPD/rBSKQmkjsYw2xlCXsQLW2NR7y3KLLmw2qCjmCXWpiY
 US/s8L36fFJ3LpnRUSviK7rbCb6nWNgvTQtRZEjenglLZbeEejfjONb0j0gUhzhoWGxZQ6tJnYE
 jRpldG7iy0pkXNci1zlkQBG92PYLEOFcQ6jmKVt1lQj6qisoo+pzFeWblz3kbR4KtefgsIhU=
X-Google-Smtp-Source: AGHT+IFbXxsdCrvChAV6CpH6XhMzQjW7iAZBKs4hIF1JdY/PQ8tf4cXRWD5u4lsB1HDQyOr44BWy+w==
X-Received: by 2002:a17:903:40d2:b0:236:9d66:ff24 with SMTP id
 d9443c01a7336-23f9813ae8bmr74900905ad.8.1753357341670; 
 Thu, 24 Jul 2025 04:42:21 -0700 (PDT)
Received: from ?IPV6:2804:7f0:bcc0:8924:370b:6e58:6804:59a0?
 ([2804:7f0:bcc0:8924:370b:6e58:6804:59a0])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23fa4901a62sm13734715ad.181.2025.07.24.04.42.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Jul 2025 04:42:21 -0700 (PDT)
Message-ID: <681a7e36-d011-4f30-b167-55ac065063e6@gmail.com>
Date: Thu, 24 Jul 2025 08:42:18 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IFtQQVRDSF0gTUFJTlRBSU5FUlM6IFJlbW92ZSBGcsOpZMOpcmlj?=
 =?UTF-8?Q?_as_reviewer?=
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>
References: <20250724075916.1593420-1-clg@redhat.com>
Content-Language: en-US
From: Daniel Henrique Barboza <danielhb413@gmail.com>
In-Reply-To: <20250724075916.1593420-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=danielhb413@gmail.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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



On 7/24/25 4:59 AM, Cédric Le Goater wrote:
> Frédéric has moved to other tasks within IBM and no longer does QEMU
> development.
> 
> Cc: Frédéric Barrat <fbarrat@linux.ibm.com>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---

Reviewed-by: Daniel Henrique Barboza <danielhb413@gmail.com>

>   MAINTAINERS | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f3f981f90deb..9481a21c8018 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1578,7 +1578,6 @@ F: tests/functional/test_ppc64_tuxrun.py
>   
>   PowerNV (Non-Virtualized)
>   M: Nicholas Piggin <npiggin@gmail.com>
> -R: Frédéric Barrat <fbarrat@linux.ibm.com>
>   R: Aditya Gupta <adityag@linux.ibm.com>
>   L: qemu-ppc@nongnu.org
>   S: Odd Fixes
> @@ -2780,7 +2779,6 @@ F: tests/qtest/fw_cfg-test.c
>   T: git https://github.com/philmd/qemu.git fw_cfg-next
>   
>   XIVE
> -R: Frédéric Barrat <fbarrat@linux.ibm.com>
>   R: Gautam Menghani <gautam@linux.ibm.com>
>   L: qemu-ppc@nongnu.org
>   S: Odd Fixes


