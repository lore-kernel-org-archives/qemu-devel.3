Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45BB4C3601A
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 17:35:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0OSq-0007Gn-AB; Thu, 03 Apr 2025 13:34:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u0OSO-0006Ii-JK
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 13:34:26 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u0OSK-0007uE-CK
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 13:34:22 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-224341bbc1dso11375655ad.3
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 10:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743701658; x=1744306458; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ECX+sWfOEdAyAyQAIngp0JGLEA6Bc2QXCPvBV0bUAto=;
 b=kauzyOT4y39p3bNlFz+gUkhV7+4wwwD9XVjFMn11kYqNsonjhBK+yiJc74YPSLj8vl
 gnhqiE3/8DDl8L4sgg3r/xgfp5mXQoB7jSgfNdo17R/7bkEZirA5pBIzRkg2yhLyAwqS
 RWcLliTALtrHxdI76pp84Db3P5/y9guzl9wziZCd3Sn54rmFs8R6rtkmS4iYoNgep0PY
 WgmnvK8cyoFfPibHm6tm+cAogVwIUgRVWCRo8roXunPQ6/Xcif3Cjt4VteaBHZLhtruO
 yQnozggBYOHyoUV3MEGR9RsnzCvSyVpon+n4Fg8YvSzu3ol902EN2a0gbfc0HcQIQ86/
 HGrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743701658; x=1744306458;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ECX+sWfOEdAyAyQAIngp0JGLEA6Bc2QXCPvBV0bUAto=;
 b=wyRYs4FXLYS8WZSZwWYilYd0W70qUzhWSHlk6cHGQT/C2Wb9nF8XlO4BEP/gjouEow
 l6+vMAedAEpbKGv2kIpA/gxRHyheOPRXw1cixJtDTLO3vq0FboSeLHJzFucjlWzwZwxm
 5wft0XiqX59qGCp4qD+lHENOtXceSj4DZkYhZlmwuYKOswcPx8JfLJLrF6tITiITKoQb
 hK4WjfWhtHhB8mqaqU2WJ1/rEnhSLVdkyHznGSnV9umcqEsPYAmBVxjgOwUvNvU5q7mq
 Av+R4oMcRlDAKhcCsOs4YiPlLZk/ytp7hjJsG5VabMXVyZ/ll06mXniRqdHzK0MhHXGF
 wVzw==
X-Gm-Message-State: AOJu0Yw38hHbvt1OYmMEnWCNazRPkGzTRZAAQa4cOPIOoCJQftE2ezdy
 h+F9B6T+05oLhHAtLGfVLNBj3DKbcERtNalPcuYTnSTZqi/znTepBmMuWI8A3GCX0KeNaAbbezx
 f
X-Gm-Gg: ASbGncvjpVtsakd+AMxgtBu+Pn/kK35havKPoZs/u7wG8/HSUg67GhSHVjcQhXv7VvD
 2RxMLFng+6wR86/2xh4+99UcMxAefAuMNEXzxSfyAlh7yzhesMz2IVHpqxifpabFLPEWdCJzfAh
 LGvC/3qFrbHEAnrclHSebc53838UhIGslgcFRqPXIa3YH6mNZQiGUoDIMjYyUE6A65b/gr4Ucdp
 q2MrDXmhXwgUcSIn5GjH/6ausZNU0TJYN6Jd4p8ifTCB+d7jU/dIS7BGkpzv7Kg7Nn5kGO82Qny
 wifbvqp9qqALJywzHXIJCf8l2boW2TcYAO3CuzqLF9zZ4J3h/RHZycHGOjlUvZ2B4a6/g/pJK31
 wJmW4x4eC2Ycp0cjKgNI=
X-Google-Smtp-Source: AGHT+IG754glvWMbw5vwdfKeeRU+N812A3ZFsO4jmqToqcDHbsRwh2YJaspTUFy5dIEi2J62nyqOWg==
X-Received: by 2002:a17:903:1c4:b0:220:c066:94eb with SMTP id
 d9443c01a7336-2296c688bdcmr86327305ad.25.1743701657731; 
 Thu, 03 Apr 2025 10:34:17 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2297866d094sm17362275ad.166.2025.04.03.10.34.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Apr 2025 10:34:17 -0700 (PDT)
Message-ID: <bc5f1078-3a2f-430b-bee0-755ecf5c882a@linaro.org>
Date: Thu, 3 Apr 2025 10:34:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.0 v2 05/14] hw/arm: Do not build VMapple machine by
 default
To: qemu-devel@nongnu.org
References: <20250403151829.44858-1-philmd@linaro.org>
 <20250403151829.44858-6-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250403151829.44858-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

On 4/3/25 08:18, Philippe Mathieu-Daudé wrote:
> Unfortunately as of v10.0.0-rc2 the VMapple machine is unusable:
> 
>    $ qemu-system-aarch64 -M vmapple [...]
>    *** Terminating app due to uncaught exception 'NSInvalidArgumentException',
>        reason: '-[PGIOSurfaceHostDeviceDescriptor setMapMemory:]: unrecognized selector sent to instance 0x600001ede820'
>    *** First throw call stack:
>    (
>      0   CoreFoundation          0x000000019c759df0 __exceptionPreprocess + 176
>      1   libobjc.A.dylib         0x000000019c21eb60 objc_exception_throw + 88
>      2   CoreFoundation          0x000000019c816ce0 -[NSObject(NSObject) __retain_OA] + 0
>      3   CoreFoundation          0x000000019c6c7efc ___forwarding___ + 1500
>      4   CoreFoundation          0x000000019c6c7860 _CF_forwarding_prep_0 + 96
>      5   qemu-system-aarch64     0x000000010486dbd0 apple_gfx_mmio_realize + 200
>      6   qemu-system-aarch64     0x0000000104e6ab5c device_set_realized + 352
>      7   qemu-system-aarch64     0x0000000104e7250c property_set_bool + 100
>      8   qemu-system-aarch64     0x0000000104e7023c object_property_set + 136
>      9   qemu-system-aarch64     0x0000000104e74870 object_property_set_qobject + 60
>      10  qemu-system-aarch64     0x0000000104e70748 object_property_set_bool + 60
>      11  qemu-system-aarch64     0x0000000104e69bd8 qdev_realize_and_unref + 20
>      12  qemu-system-aarch64     0x0000000104e258e0 mach_vmapple_init + 1728
>      13  qemu-system-aarch64     0x000000010481b0ac machine_run_board_init + 1892
>      14  qemu-system-aarch64     0x0000000104a4def8 qmp_x_exit_preconfig + 260
>      15  qemu-system-aarch64     0x0000000104a51ba8 qemu_init + 14460
>      16  qemu-system-aarch64     0x0000000104f7cef8 main + 36
>      17  dyld                    0x000000019c25eb4c start + 6000
>    )
>    libc++abi: terminating due to uncaught exception of type NSException
>    Abort trap: 6
> 
> Disable the machine so it isn't built by default.
> 
> This is tracked as https://gitlab.com/qemu-project/qemu/-/issues/2913
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   configs/devices/aarch64-softmmu/default.mak | 1 +
>   1 file changed, 1 insertion(+)


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

> 
> diff --git a/configs/devices/aarch64-softmmu/default.mak b/configs/devices/aarch64-softmmu/default.mak
> index 93f4022ad62..ad8028cfd48 100644
> --- a/configs/devices/aarch64-softmmu/default.mak
> +++ b/configs/devices/aarch64-softmmu/default.mak
> @@ -9,3 +9,4 @@ include ../arm-softmmu/default.mak
>   # CONFIG_XLNX_VERSAL=n
>   # CONFIG_SBSA_REF=n
>   # CONFIG_NPCM8XX=n
> +CONFIG_VMAPPLE=n


