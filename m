Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36ADBCCD1BE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 07:00:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBSn5-0001BK-PX; Wed, 22 Oct 2025 02:57:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBSn3-00015t-T4
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 02:57:45 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBSn1-00086B-8B
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 02:57:45 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4711b95226dso52841145e9.0
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 23:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761116261; x=1761721061; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QnPloFsjFit3k8b3uukb85Gevv0GhUmTfYnV5ODHyak=;
 b=QjjodzOVW2R8Rv0HgYj018XhH57IFrOVRpaR1BrUzKf6bDy84QieGbGMZxbp2XaVoK
 A4jbJMMD3cjI38T4LknvTOKRz33oNxzLOgeNaN3V3TcaFpKFUzQD6Twp7jvroanLb8bW
 mc59Rvac9AQCPeOx5b2YBTbkyH9Rn7YmbvepEjBAfNje6gDjHJpxXP41aUUEzo1CDnFK
 L8SHAYRj1uH/yXF44z31RTzJrZZBeqcHSD2tubK1Rjr5Ov5v4LA7zj1rytUJMM0Hzgir
 3I9LP6VJT1uCzJGztyOkADtf/mUY1c4zptq7vlL7Bomep8oSLizrDzsEMg0gtPql84N5
 /SmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761116261; x=1761721061;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QnPloFsjFit3k8b3uukb85Gevv0GhUmTfYnV5ODHyak=;
 b=kJoeQ7VkIyWtspzX2VP7MN03UE04CXG8xISKqdduFwe9U+nW4wd4thRAj5dv1NktAT
 /WK0R4p08Ewn09+D1qzeVz9Cn1rot0cxQYse4MVduqnnH9xGc5UZ3fJLoiqNg7Zr7m1E
 UFjsgw+evu8DgjO9VAIK2ZluCsq5pqFSSCT3ii+btdIdox35VUkdu3Tn5Fjc2KVkAqT+
 imqCDXTB/Lk+PUm5OPl/Z3IokzfZ0dz12xLwR5UndOyem4pKtVqbW6mUcS/ImjFvIRgE
 0wrzswgB4Of3L1fg6XuvW38iAjeZGq2WjrTZV1tBe13Gj3X0FRt/mNN6uKe6Bf2UZjxT
 eACw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjfYAh24uZAsADZck8bSi72zhsJxiNPSmYk7R5+HZRie5zWO/kKM0QJc0DvDB4u9Bczb1J8OD4TqC4@nongnu.org
X-Gm-Message-State: AOJu0Yzzen518u5ffNJ7M3tyKqRA1FXUORLzncTkge1QFtkdNiyQQuA2
 EqTc8of3m5VDIr5avxw+TW35KDh73HQxFi4f/LBVtKSa33MEGlzf8FYlqyiZQXveeX4=
X-Gm-Gg: ASbGncv4106vTdF6OaJAlWweHsdZt2amf8QtSFT+NLAI8l+R8nlydWLbGlHHkvc/BKC
 SR+lfXGDlmfVeW22AOxt/URFLf9Cx8zA5y5GZaf8UfQwsGasHpjKhy77Whm4UnWYNevYUXxO4ak
 3GaS3QwV+sxc7VJyV/NaU6FT1amWEApgVqwWIZh4W84/1zE+XP3C/d4mCbFk14S81NBcpGxNqmN
 ZN1ADp+Xv3+hd3ffeqS8o7i0QJBamccC2j5k2joWVRRqalDXTGZvIAOtChptM8FHwC5QKZ0rBWC
 CvL+awDG5EWZFFuKAth6qXPhGs6da7oj4zCgIdHZSovT4IOAGNs+bvkds/txc0QivLVgfcH7Zwb
 6x9EUpj+CQRV5ybKVF1Oy2THEsWdvA4NHq6M32EOiNVPZ5dM6l09Wb79mSMYH4vNWStf3MCLWnL
 KA/6b1U1LnsOghWh58leuKpg0Gr8OSNonzym/CQXsFYo4=
X-Google-Smtp-Source: AGHT+IE5+4ddQWHPr5frwJdpVMVACxr2T4XPoxFldVuShxMrAH5vZ7F/O3blDy8LTBRv3QNP5YxzEA==
X-Received: by 2002:a05:600c:3b8d:b0:45d:f81d:eae7 with SMTP id
 5b1f17b1804b1-471179176b9mr164828215e9.28.1761116261038; 
 Tue, 21 Oct 2025 23:57:41 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475c427c3f7sm30356415e9.1.2025.10.21.23.57.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Oct 2025 23:57:40 -0700 (PDT)
Message-ID: <b59aaee4-89c6-4033-946f-bc2702993294@linaro.org>
Date: Wed, 22 Oct 2025 08:57:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] igvm: add MAINTAINERS entry
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Roy Hopkins <roy.hopkins@randomman.co.uk>,
 Stefano Garzarella <sgarzare@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
References: <20251015112342.1672955-1-kraxel@redhat.com>
 <20251015112342.1672955-6-kraxel@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251015112342.1672955-6-kraxel@redhat.com>
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

On 15/10/25 13:23, Gerd Hoffmann wrote:
> Add Roy (being the original author) as maintainer.  Add myself as
> reviewer.  Status to be decided.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>   MAINTAINERS | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 84cfd85e1fa1..3ebcbcdfdb04 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3893,6 +3893,15 @@ F: roms/edk2-*
>   F: tests/data/uefi-boot-images/
>   F: tests/uefi-test-tools/
>   
> +IGVM Firmware
> +M: Roy Hopkins <roy.hopkins@randomman.co.uk>
> +R: Gerd Hoffmann <kraxel@redhat.com>
> +S: TBD

If not Supported, then Maintained?

> +F: backends/igvm*.c
> +F: include/system/igvm*.h
> +F: stubs/igvm.c
> +F: target/i386/igvm.c

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


