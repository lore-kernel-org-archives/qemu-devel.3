Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97FDFC71135
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 05:10:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uR26v-0000Mq-3E; Mon, 16 Jun 2025 01:10:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uR26t-0000La-Uy
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 01:10:19 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uR26r-0003gW-Uu
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 01:10:19 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3a36748920cso4771870f8f.2
 for <qemu-devel@nongnu.org>; Sun, 15 Jun 2025 22:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750050616; x=1750655416; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=u/nR/C4+1wkJLJlbyL3jVPdlWgMU9RGnMrRVt9igRVk=;
 b=BF9vLCqyi7n/cQAX5R8t/Fnbo5m/TPvoArwb6+1ND6v043eNB4yXCuZlnebTpP1xbL
 EsbymMsOus88ovkcPCXGw7S2jwckReUcoiLU9bFlhZpamdg24ir/M+tfXIycC73mB/B9
 F8Kt5jM1fPOohsGzsx/D378jWjIHglExJGBOuuW9N+lzEUd9O2K3lPfQ8IsvGWb65Q6Q
 QNEFjIMZMUZdqc1gDwiG6JZzbQkwlQ24eSm/w9BdFwY0gMWBPd/KkOMvZG2gXUiBDTMx
 Mh/iLQOEWl76XTMBLriSMakxLeH+CoMu+z3gM+Sf2xplxDiFn/Wgy74Wnz2+/xZVPjFE
 PfBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750050616; x=1750655416;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=u/nR/C4+1wkJLJlbyL3jVPdlWgMU9RGnMrRVt9igRVk=;
 b=kQObL5SUWQDd6sP3WHgbVCBvJKo5irBIf3j09G92hEq7g4U1VCEU4vIQZyp+ugXFqZ
 KCCkTQrXVSM4gLzx5JThj+qcr+TB6A/8K/f7ROngAmQBIp2jFe/gF1Cm7uaXdcOnseHW
 kDmGzSvYaH8uTNJ6NXbQBarfK4EwqH+ecqQJTSERyy60xdLd67QG2GTzYf02BjMr/ijb
 fvVCuZeg+kikK7GqHx95hmaWQG3pfYz2UqYtVjcKlYJKKgS4RDEc7yoiYadAMnKyW6At
 gHXtb60MZS8jWj/y5Y9BwlseXi0lQedmhwd2Fjz+cCEPEYoBXc6LvEzyLykRw12ZshxV
 wZkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbkYnLjVvYUKLgeYaaoCPyCx1ni2fdUst6O92yTwMQ6ON1gJUJ4LW7HBXXfFqtIQ+SfFnvYqMMBQ56@nongnu.org
X-Gm-Message-State: AOJu0YyUIaNk+WkiHiTBgEjz+gxj1ASKGLJHSdF+8HkiYUIxYQY4rF4s
 c5LRw54xYmWVBIV10Xp+xeCbf/5bm6xNX/j3WQCxPzf4CbCnoR69iO0bGbzoNIxT+wRobrmhVk/
 FExpFahw=
X-Gm-Gg: ASbGncshWqF8BzxXphWAhKiK77A9vaasotryARHt5ijOCpLo/6HcJ9OvBaeLExhRLTD
 LvxFzAxt7yTY9dON2np0lFbxPaWLZK+GY0J+nIyAYdhgt141uABFxtBDaR/zkM9/v3rUDUk7dqe
 EUfQJpY+kpC5iPp7iCKZz8YvtCgRSZrM+xdwPO8nnujIlizOqndV6At1fv6o249nbxQoE6NgeGw
 GzrrE/sDpY2in/yI9r2dsOpkmPTo2xNYZPTAEflbCXLAO+RrCheMjdpgn22sZlTLlovRO3hRxql
 PazeRMnI2cj/umlyXRkgRPxRltNNRX15Lpm4O9SJCQZbvULbXd52QbnSbUHyPjAUmlfFfK+j8sG
 TAhmm1npTsvCA977RCBt5eG31ngzLCQ==
X-Google-Smtp-Source: AGHT+IEhAHSu47VDIUDbOjvorzdzkCrnUf4AQ8eyPcoIjdApwkMzTOc8BHpkgbwGwauZVk6E9xyYYQ==
X-Received: by 2002:a05:6000:4284:b0:3a4:eb7a:2cda with SMTP id
 ffacd0b85a97d-3a5723a2c2fmr5191451f8f.30.1750050616261; 
 Sun, 15 Jun 2025 22:10:16 -0700 (PDT)
Received: from [192.168.69.167] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4532e13c19esm132070705e9.25.2025.06.15.22.10.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Jun 2025 22:10:15 -0700 (PDT)
Message-ID: <c892aff3-b77a-4131-b3c3-9c671cd18af4@linaro.org>
Date: Mon, 16 Jun 2025 07:10:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hw/9pfs: move G_GNUC_PRINTF to header
To: Sean Wei <me@sean.taipei>, qemu-devel@nongnu.org
Cc: Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>
References: <20250613.qemu.9p@sean.taipei> <20250613.qemu.9p.02@sean.taipei>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250613.qemu.9p.02@sean.taipei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

On 14/6/25 04:09, Sean Wei wrote:
> v9fs_path_sprintf() is annotated with G_GNUC_PRINTF(2, 3) in
> hw/9pfs/9p.c, but the prototype in hw/9pfs/9p.h is missing the
> attribute, so callers that include only the header do not get format
> checking.
> 
> Move the annotation to the header and delete the duplicate in the
> source file. No behavior change.
> 
> Signed-off-by: Sean Wei <me@sean.taipei>
> ---
>   hw/9pfs/9p.c | 3 +--
>   hw/9pfs/9p.h | 2 +-
>   2 files changed, 2 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


