Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4B16CD5BDE
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 06:08:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wS7R6-00080Z-CV; Wed, 27 May 2026 02:08:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wS7Ql-0007zC-Hh
 for qemu-devel@nongnu.org; Wed, 27 May 2026 02:07:53 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wS7Qj-0006DU-Jq
 for qemu-devel@nongnu.org; Wed, 27 May 2026 02:07:51 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4903d730b1fso48067275e9.2
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 23:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779862067; x=1780466867; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EQO5d45Oirm5bSrcF0UzQ67R1CsKGekz2RisK/iFB6k=;
 b=sImvtYVvcubKRQoJVwB+F6wukBcmqWS9ydcMPDCFLkzAepU/Gd7FLOvdnLXw8MqFFS
 8flmVY74yr/w9WPjRhTiMaDou3LWqiMHAlqPdeRQczIpMX3w+g90q7AmF90V3IjJdmOT
 8ZQpbdGLMaNle4j4iBx7BYiQ5W3FXVgtV7ut2NdQdCFisf9qWadT8CAX0k+hrOSXVA4n
 b3FtNSpdbnpXf4YppDvFWYRXZdIe/7xTnZ5EMmiMrefCXWKvNVm3AiaEsuR0JILhiqNy
 03WoVttK/+RrxagTy6oRYEsephCqS59hqobAR2HEpephM9rVtDJpCxk4+xeX0342onj0
 iwIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779862067; x=1780466867;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EQO5d45Oirm5bSrcF0UzQ67R1CsKGekz2RisK/iFB6k=;
 b=eHV+dZVv3U7SDzz14wQGIRCYyk3836asChgF36QPNsiqd0QC1UPvkxAZKS20HbtQb2
 0Lw6N+PatEWfkmEpoyyV25beZJZ769A4iIbTBix3leLNPdTHJzoBHKgsft3+cOfFPCAC
 RRFjJYmM9IMOB7z7UDigig0wg7fZtZNZdCYV+DGT0XZREYMH6twR50LAypWaIHkKsquz
 lEaDXAcn4oL0C6mNMkaxL9hjp0sle2Z7wGfUYQOKiLAYSZAvZ6Hh/xwV1Md6mLp8EyqT
 gAXW08AZUOOwK23Q2cwZZUPCBnDRWMZ7JiqkQuZfWATeG6AdCyUdhf8yT762WVyPge70
 9E7A==
X-Forwarded-Encrypted: i=1;
 AFNElJ+PtOYyoDDIO+h+Lzg0hsvIVhzPYZ04v++hkefRqXYdG5/qewswjyRPfgpHjhDADz/PXNDzs0JzkG5L@nongnu.org
X-Gm-Message-State: AOJu0YxAFtLE6jiVwJ8z4Cr3gl69YobtWiPCxuUMdlnCrip63azZj15Q
 K6uyvlXym2pRBFmu6Ia6j5cThFImNDbGsYcLGlSGiFOebSyWYNJjrVqZ+bD+OCoSGzg=
X-Gm-Gg: Acq92OGsy8jD6Uz/P38UI7yakseHLnGbtO0dHxs+PeX1p206NJEN28FW5HD+sh1axZ7
 ZCaxjWIcCGDpQtUdqWzJX9sS0omYk+BQoYAKh93HFdBIFbzYgYbPFi5qJ28CZBQYNUiPFc5mBJN
 xCvuO61Yc8ZTWFTlWoeKmPMBqeUK3K+rknl8L/CS61FuXB8sSoopXiwgtb/wCqpOaJdcFMEmu29
 gLY/E1mFm4y13gNw+P+xueeULa19oPBgVge3i5oy+pVXnnsTroLmQmG7KaIZY4XUyV2xb0bEH0q
 /uVcC1qFRTquVta9jIAG2HyBVq0ceXeuTQNk4ydG0Fh5ZxCLqMTl5z/VFkEpJgVp6z4QcDOL5VV
 4YUdfo7fQurLeIvpmbnDW112l+KdpUc5o9zY7tAlChXsfeyeGDptFIZk3qs5s0iEmU9DuC54ZsT
 wzuQU2tWy7HVFdmjMMZB/Z6Dixhe60ynQPbP09cI+DHg3VxefdDk/vemNI8W0yFSoSmvhnzeIZL
 EjG
X-Received: by 2002:a05:600c:a402:b0:488:9bf8:7f17 with SMTP id
 5b1f17b1804b1-490425ad10cmr291998755e9.14.1779862067238; 
 Tue, 26 May 2026 23:07:47 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490454ac676sm406910605e9.13.2026.05.26.23.07.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2026 23:07:46 -0700 (PDT)
Message-ID: <81244594-ec27-4cef-85bf-60a4f7bd08ca@linaro.org>
Date: Wed, 27 May 2026 08:07:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/14] single-binary: Compile hw/riscv once
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, pierrick.bouvier@oss.qualcomm.com,
 palmer@dabbelt.com, alistair.francis@wdc.com
References: <20260520-hw-riscv-cpu-int-v3-0-d1123ea63d9c@rev.ng>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260520-hw-riscv-cpu-int-v3-0-d1123ea63d9c@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 20/5/26 15:12, Anton Johansson wrote:

> ---
> Anton Johansson (14):
>        hw/riscv: Register generic riscv[32|64] QOM interfaces
>        hw/riscv: Add macros and globals for simplifying machine definitions
>        hw/riscv: Filter machine types for qemu-system-riscv32/64 binaries
>        hw/core: Add riscv[32|64] to "none" machine
>        configs/target: Implement per-binary TargetInfo structure for riscv
>        target-info: Add target_riscv64()

Queuing first 6 patches (addressing rth comment), thanks.

