Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 853CBC7115D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 20:47:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSM9x-0004Rg-NH; Thu, 19 Jun 2025 16:46:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSM9w-0004R7-CF
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 16:46:56 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSM9u-00062J-UJ
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 16:46:56 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4531e146a24so7636665e9.0
 for <qemu-devel@nongnu.org>; Thu, 19 Jun 2025 13:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750366013; x=1750970813; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TQBfabl2lP8nGO0NiBVmlCC1DNA+M7mjMEFguKY+ck4=;
 b=KhJTcHK1cZGy3k3wm4omWATs9I9t9SFzyWpET0t6hTOh7je2tLFKHjzKfe/jx4afwE
 H3Tf6tpe59t1psD09TIPfWjP1b2IwVCz38mwAwaEZu/BxRnRSXGP4huzLF4f/Ei4PG9T
 eK51EuoiS7eAybfnjSsFI+CqsIyhVvZ/oau0LsnjCUvpJ+XrvQHu5gANmSkilO5cPL00
 eSSU4giertzahw0z83Ax+nvkvIJVcTeMPJSIGKqZ9Wpm2o+9rQy5mRNeJhtUltRABvcJ
 KHfa47eBB82YwS9LO+4DYus8WwDqA04L6KGqMxLECj3AwEydeL5DnMa2pVCxiVJagOkQ
 NZnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750366013; x=1750970813;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TQBfabl2lP8nGO0NiBVmlCC1DNA+M7mjMEFguKY+ck4=;
 b=NOCJXASODs/1rsKOQkPW9+nfp4OOOU5lchERlzlbV59vutC1PRLcivOjwu+If/KPnz
 b86KLaQyZxuuchZfxTaWoKSR8bUFQORVEulP5ZTGu4bjjIDqJqG1LTaoG1MV3uJxRN+E
 kpSTBHSpREEOs0Pc0dGSXWv0M5NUR02F6sBtluDg/ncCWWDUr364Htf4n1Rn+Bgm7WT3
 m/Pf2x4iLXutnVlcb/WN+RmaXKa1HNv7Tbg8UN5LpcPaCBG6lXboRxWwI3rb+QWcq1Rm
 WdOGEHLDf5mh5v7e+KRvkfHfXkVE67xQNrMRVMlFSr+RPIGPAR5iTMGm7BbRKlNuN7Sw
 69SQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9ksezWaRLavJZCHfp5mANZaN/Nsk6U3t6RQ2uxuQayxI7e8Jr4LpTHlm//vTJ1zE5kIG69je93+EE@nongnu.org
X-Gm-Message-State: AOJu0YzFOEHYLSYPDaJvPE/lE5QBv6acspJ42ETrZ8j6CIYiIG2JNy9R
 xhF/P/gXwPy6S2a5K8QG5TwivdVyWKONAg02lD7RWfFRL3jG7K94YRSHAXnR/6V6xZU=
X-Gm-Gg: ASbGnct2yCNqUNPVMmRgWGS+gkEO4HPQEB7+MsUDz98rcS+EP+QA2thedDSuYmhu8fC
 eMPQg/wxcuGxZ3d1UcUrQaU52M1+DAs3u6fGtfOmCrHdpGhlCJ4/KGnGBbZok5oUT6M6RzZGYhf
 rgtjnOyj4vEQQ84zap4eUileAvBwlC0GfDv2/dpw+jMZ8bkHz/NC5MZOnI8CTSs6B3qU2f6/eyS
 udNIzeec3lZ+4xG2xK6DDB9M4y9LASHxql/Jf8zY3WtjcIkRJxJO7p2nwfWZovHDcyLqUysIf8k
 TgMLCF4KI5b2AIjbPqdW/kIJR9xpthCWA3dQS0MOxoaYWg2QtK+ZSPIqgfx4+qeRNkuU1qUIGd1
 ZpR1Ml/l5igyLAQfscOOkoTPu18yMKA==
X-Google-Smtp-Source: AGHT+IHFLb72fdwAZiyWaFvxTzFsUiVJnYZoPXGouXh/IvgIQq2EAwlxpoMEkrJbVai9juraj7Sy7A==
X-Received: by 2002:a05:600c:3542:b0:451:e394:8920 with SMTP id
 5b1f17b1804b1-453659edd18mr1498265e9.27.1750366013428; 
 Thu, 19 Jun 2025 13:46:53 -0700 (PDT)
Received: from [192.168.69.167] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4536470903asm4590935e9.40.2025.06.19.13.46.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Jun 2025 13:46:52 -0700 (PDT)
Message-ID: <aba1612c-b382-4093-9002-d8a2fb70a718@linaro.org>
Date: Thu, 19 Jun 2025 22:46:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/12] hw/i386/pc_piix.c: remove SMI and piix4_pm
 initialisation from pc_init_isa()
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, pbonzini@redhat.com,
 mst@redhat.com, marcel.apfelbaum@gmail.com, eduardo@habkost.net,
 imammedo@redhat.com, qemu-devel@nongnu.org
References: <20250618112828.235087-1-mark.caveayland@nutanix.com>
 <20250618112828.235087-4-mark.caveayland@nutanix.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250618112828.235087-4-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 18/6/25 13:27, Mark Cave-Ayland wrote:
> These are based upon the PIIX4 PCI chipset and so can never be used on an isapc machine.
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
>   hw/i386/pc_piix.c | 19 -------------------
>   1 file changed, 19 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


