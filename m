Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 944C7E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 10:30:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOaGv-0005F0-US; Fri, 20 Dec 2024 05:30:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOaGu-0005D8-LM
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 05:30:16 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOaGt-0002AT-6f
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 05:30:16 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-388cae9eb9fso1000529f8f.3
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 02:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734690612; x=1735295412; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HE9RICSg/G0qang2Ph2nixOO8jUJ5u4RPl1sDo5OuqY=;
 b=Enk/vQoD38ASMFCk8098XaYalrPbu8obGiosTxmPrz06TJ5zst2GL9dbAsWNvqpn7z
 sa2Q3o2HdDcmxruOKW9gXItCg7SyWDzuMjmYUOMr3/QZ1R+E4HxMaHaQR8gCdcGIyR2F
 GjGu4WwNy8ykGrOH8SGdyFUwnfa/BBnQB++78H3LFNVDWtKlzazlgsD+vpvpCpBzGnF/
 kA52ZUM1Vp1d27x1XteAgsFq0jVBO8t7s0rd/wmo8SxT1vWDgMhLeJxWKn1IU73JeLS/
 7RdHhkC9clJJyp5ArSIFDZ/j7uZG73W3xeOW85K4LqIco9FVnLrfGBXptXU6z0MlS7Dp
 LeAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734690612; x=1735295412;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HE9RICSg/G0qang2Ph2nixOO8jUJ5u4RPl1sDo5OuqY=;
 b=KNluSAipA6lqGci1fVyUCfeOaQyxpphlai5JhaNKgj59BBjSOt9TcqVQgBXHHX7ryg
 OZLylZ4b65gPIn37ipY0T1XhI7bjPoqckGe8XnBOYOrsJxU9T9bsmYZihveYDX4ck1KO
 T+DCadD/VY+oOv36/F9ONoF7fqylyjvA+Z+ZYRAVW/OhHz58ZJ80TmSXuMEjIEqtv/Dw
 WnoMvKc4YJU5xLCHiYZBIbpg9Eo/SF92lABq1KK7kwxZ+Ui68Sp2IDyBceUPo8Jh82YL
 XeJ9nQfXD8btcPcNH8b70/Ui1sYAmgV7n5NI8wp5EqkRXhWlCpyoOEFnkMrVOPraGT7+
 /wqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVuHq6aEUMgwtPVSf/R4AgAZ9NlFkbJ2y1x+OfkeaHWVB0KIY8sCK0l2hqS3+QaPXC1g2hBaPSzDmpR@nongnu.org
X-Gm-Message-State: AOJu0YxnDVICVt+SWnXo334DFPL8Tt2yX9LOk8X0DYWsXpRAO7M58S4D
 D7m+7r37DEI/qb5VazwcxmaOivwIbIveLtNI9UOUVgNu4UqPCJYbiI5NCnU+EJg=
X-Gm-Gg: ASbGncuhsjZhbWJ/iqfVSA4lUVTpmtYD3MaJJr5hHP4B1zbo7qYQmwo8stH9HOskdca
 tex0u6N+881PIhJbSf3sPFvXMtuexrA0hhn/xpdcaw5g1pv5i9RlQs4QlZRdPmJ9YO+Mey4w3of
 ZNmZ1zzZ3u9OnKusSb1nsuL8X1gexAgSErWNVUUrujQiPZdj8sFbEJ49AeTVpLtIals7EZmqwSf
 3+MQFLrZbS8Fn/HtmHqOkzLaj1XWYMqKBHMqj6Z13oYi8He6Do6/+Jz2AikWHyZgDjFOCs=
X-Google-Smtp-Source: AGHT+IFvUWO/UrML/hvKJS8pYiq5gIfxV+wvsc1nXj80x9wEbmLxReGjnKl/rxjx7IdZX+IoupLSCA==
X-Received: by 2002:a05:6000:1446:b0:385:fae4:424e with SMTP id
 ffacd0b85a97d-38a22408624mr1880937f8f.52.1734690611702; 
 Fri, 20 Dec 2024 02:30:11 -0800 (PST)
Received: from [192.168.1.67] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c89e2f9sm3786282f8f.81.2024.12.20.02.30.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Dec 2024 02:30:11 -0800 (PST)
Message-ID: <a7deb1d3-4189-4039-b388-381b3e2dc23c@linaro.org>
Date: Fri, 20 Dec 2024 11:30:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] spapr: Generate random HASHPKEYR for spapr machines
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
References: <20241219034035.1826173-1-npiggin@gmail.com>
 <20241219034035.1826173-4-npiggin@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241219034035.1826173-4-npiggin@gmail.com>
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

On 19/12/24 04:40, Nicholas Piggin wrote:
> The hypervisor is expected to create a value for the HASHPKEY SPR for
> each partition. Currently it uses zero for all partitions, use a
> random number instead, which in theory might make kernel ROP protection
> more secure.
> 
> Signed-of-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   include/hw/ppc/spapr.h  | 1 +
>   hw/ppc/spapr.c          | 3 +++
>   hw/ppc/spapr_cpu_core.c | 2 ++
>   3 files changed, 6 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


