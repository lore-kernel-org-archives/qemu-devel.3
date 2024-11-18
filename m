Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DE87D4920F
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 12:38:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tD118-00040f-4I; Mon, 18 Nov 2024 07:38:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tD114-00040J-8C
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 07:38:07 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tD112-000403-Jx
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 07:38:05 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-432d9b8558aso23582945e9.0
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2024 04:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731933482; x=1732538282; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pYLZ6AW86wi9PWbPBF/87Q2a7NF7pQ3IdyaYdUoxTiM=;
 b=EkIc1ZXNE/ilT2O2YEsDcFz4gL7dTAc+s9PSasaTGTaDmgWgzDtwYxIh24WPuG/2t9
 LgJp4jMiXbtfBbufJLU/PUn8AC/Thd1mr/9Hs4kNmvc1+O4vp4qZRlIX/lNFPomLGS0P
 oyIMU0EzJqLduLnPp7qSkmFLEVCX6WYSgypXlD7ikWtzZSnTFmokx95EDqaLboaHf1eN
 Tazp43dIU3CKeozD8JYe6c2J0feAlmT7ttGUPiCAAKfhdjOyky/A/z4fSRNtu70U3TsX
 gl6w1HG3T0ZXYz6SfL4b1TTjOcql0nllOid/xbY8GsIEwYVE7ufp1e+vrv0zlEKGJw3S
 p2EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731933482; x=1732538282;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pYLZ6AW86wi9PWbPBF/87Q2a7NF7pQ3IdyaYdUoxTiM=;
 b=eRL4MW53pcfK7El0tT07a1/thC3vxbpv+8IBLI7/Ix/ln3vVyLWCkNpToipd0cjCwY
 31g7fhJrsUhu+0V2BK8f+xQV9Rx+3uyjQe/qAWAuzmX26maGOorRMtGw1bfJwuhrimXJ
 Jan1jn7iTY4sPWBX0RJbHemPFBbawzzV1uMBqL3XKKBuvkeBA/BlBvOUXEw0kRaSfum9
 WG4oSSt5xC1vWAnjvd2WEtY+pWHMK3Lyd5YWtQXaGO67ct2e5VVZnYpEt/D88wuE5AT6
 jQxBtqD7iJmWrN9hrrIQbhvPekIRRqxdOg9zV44BIAcCDqNZXANzuAp9okLZQ1qG3Yk9
 UYWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLYmDvaNDRZ+OMTaxNuic2cPtdNmI8gaY5/g7fSx2QkSD3vNMCgSyJh4BzfHhBQRgFZU2s9pZvsIEc@nongnu.org
X-Gm-Message-State: AOJu0YyynqLNppVwu1ZxiMFs3XTsJb7QIF3WllYYgendTbYZAJMMXSwz
 uq797WQoBjVkOtEHnz8tho21BncXUNk1RMOUuNacQWHRYXoYW5xLynFDbnfvxQ4=
X-Google-Smtp-Source: AGHT+IHo24F1xC5XNHUqeBEBUQbov8cdBiarTct8UBkBYp2SVWjFDQDRPxEyYyfUaMxJ3sfdJqvRgg==
X-Received: by 2002:a05:600c:4fcf:b0:431:4a82:97f2 with SMTP id
 5b1f17b1804b1-432d973f949mr140571005e9.6.1731933482080; 
 Mon, 18 Nov 2024 04:38:02 -0800 (PST)
Received: from [192.168.69.197] ([176.187.198.1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432dac1f409sm152500025e9.37.2024.11.18.04.38.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Nov 2024 04:38:01 -0800 (PST)
Message-ID: <f353b35d-7f3a-47b5-bbbb-97634bece10d@linaro.org>
Date: Mon, 18 Nov 2024 13:37:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/i386/elfboot: allocate "header" in heap
To: slp@redhat.com, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20241108230314.1980-1-slp@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241108230314.1980-1-slp@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 8/11/24 23:03, slp@redhat.com wrote:
> From: Sergio Lopez <slp@redhat.com>
> 
> In x86_load_linux(), we were using a stack-allocated array as data for
> fw_cfg_add_bytes(). Since the latter just takes a reference to the
> pointer instead of copying the data, it can happen that the contents
> have been overridden by the time the guest attempts to access them.
> 
> Instead of using the stack-allocated array, allocate some memory from
> the heap, copy the contents of the array, and use it for fw_cfg.
> 
> Signed-off-by: Sergio Lopez <slp@redhat.com>
> ---
>   hw/i386/x86-common.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)

Patch queued to hw-misc, thanks.

