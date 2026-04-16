Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2B44F8D775
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 19:46:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDSeT-0002eT-5t; Thu, 16 Apr 2026 15:45:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDSeM-0002b9-5P
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 15:45:19 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDSeI-000368-0x
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 15:45:16 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-43d7e23defbso2469414f8f.0
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 12:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776368711; x=1776973511; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tXGADF0m9fvSVjoVMvi01D2+qEpRcaU0JW8MXDn0hV8=;
 b=Jt39y32EOg2mvB9Q1qMPFktOSkJervuz9Kx+sOUVV/MVi+AzLywc6ognZG10PBrXMR
 qwsn8IiS05kLkVQCZmexs90sD6E5RniEEzlLl4bZnXWWdKJHUBvGYN6XSrWWXobIslu3
 mRpbY3Mwvm7QPNfflRkC45nObBX33f58AiYiDLIM9cr/uPytVw1VbMn1nNWH/2/0uKLq
 q4LatYn+qqBzzKrATtDKeUR7zh3U1pzw4o2XHa1i/nK/u/vuYv32ebKN6hN6jyuvJLbW
 ZuRyN7zh1WwEUu1W/frE1F6dA9U+/BkL2hNDUMVwf/TfBXa68YjNPJD3ydDQRkr7y0nq
 exZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776368711; x=1776973511;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tXGADF0m9fvSVjoVMvi01D2+qEpRcaU0JW8MXDn0hV8=;
 b=BhPlJuVWWQRjMj9hUXzg3Z2ppRw+51E5c+fZfr1BWmTz647/97AtUiozS7HhOyzwKQ
 9QrqW1fVuR/MmFpx4/Hxoiob4HrZEIpu6kEUdKCoTrcqwoSCNu1S3z07od3F7PeSmNbO
 OuUkOYjk8N/ZeLAQSJSByxpi8k0LbBZbvSFvp9+Mmc2n2LfCk21SyA4iPb9XuzVdhStV
 aZe6GaCSX2p7W1NFaBEcRpd2Ksfjj3X4DJoF3iwRlfMpZdQyObeKmt58y5FCPm7cS4pc
 7RtiD0xBtZbNSWG72W5Nx/ECVxx/B5C0BJOEJuTpynzbsi73uFH7XbSKrRL6SVkxK/EH
 dJfw==
X-Forwarded-Encrypted: i=1;
 AFNElJ90BQ9QtmAYwS0SWQHLgX8qJWI55fBZCGxPYa6zsuLulhXEbtF8KwbqjPu/sYRYDAk3ibgRH11j5Y2p@nongnu.org
X-Gm-Message-State: AOJu0Yy32ca4E/nNtY7teb/fXydHdHKh6zRw+FKG077RTVf4owP+zK42
 Ggsa+2X0wz8HPngPW42GOdyJWbCHbpjvH1vApubUH+xCrh6MkFJdaCPb5k2b+QDel8E=
X-Gm-Gg: AeBDieseG4qnZAi2CueuWgVQ8sKpg65kwMK2UtokJXbsQ1A6xrva5tcdhTCDhUPAikm
 dDCbW41R6BDGmvln2f4THEokeI9juRoYeJhIZspNUoKVCw+jBurnm/fybSAjG0xzVPBLeJgdPG/
 FemnSXJFzlRp1p6CP0Cy2pghVDp0UdZ2wRS+if1nFcsu0tGp25FeIwDpfnpSnXLCUy6EYCyYrkn
 Wo9lW+LXuGVBHyb8ns+JQaOqehVEW0fkyk1FvtWoevehAjMc//VN+AS0Fv3n++T6p0QPs3j0qfz
 iIpdEXU05NZzLLNrWI25vucmQtuUMB8CKpINJjTU1i6IqKl6Ceg+ywcCI4dASD5ohGcU+nkHH2T
 QcK0i+6F9u7d4+3Xx/p5GAbacalNXMje3SvAGJBRy0PbFmAsRfwjmU0JBEuknIRWyHlTnWIA88Q
 1/z84tTZf9vr2BwdWzDrCiLyIvQrXW3DC6YgTFoQACv5+1YOrgiMIW8KF+T+kZjH1/pkGxI4+Cs
 NIZIRyHQw2k19s=
X-Received: by 2002:a05:6000:2586:b0:43d:9bb5:bd97 with SMTP id
 ffacd0b85a97d-43fe0ea3d84mr1039467f8f.8.1776368711464; 
 Thu, 16 Apr 2026 12:45:11 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43ead3d5eb4sm16469685f8f.20.2026.04.16.12.45.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Apr 2026 12:45:10 -0700 (PDT)
Message-ID: <da07a012-cbd9-43df-b7ad-e705a67c1c43@linaro.org>
Date: Thu, 16 Apr 2026 21:45:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw: Move ARM_SYSCTL_GPIO definitions to arm sysctl
 specific header
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20260416172627.690396-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <20260416172627.690396-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

On 16/4/26 19:26, Peter Maydell wrote:
> include/hw/arm/primecell.h used to be more expansive, but now the
> only thing it defines is the ARM_SYSCTL_GPIO_* constants for the GPIO
> lines for the arm-sysctl system-control device used on the Realview,
> Versatile and Versatile Express boards.
> 
> Replace it with a header file specific to that device.
> 
> virt.c and vmapple.c included primecell.h despite not using the
> constants it defined; there we can simply drop the include entirely.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Trivial cleanup; I was trying out emacs eglot and it flagged
> up that virt.c includes primecell.h unnecessarily, which led
> me to this.
> ---
>   MAINTAINERS                  |  2 +-
>   hw/arm/realview.c            |  2 +-
>   hw/arm/vexpress.c            |  2 +-
>   hw/arm/virt.c                |  1 -
>   hw/misc/arm_sysctl.c         |  2 +-
>   hw/vmapple/vmapple.c         |  1 -
>   include/hw/arm/primecell.h   | 12 ------------
>   include/hw/misc/arm_sysctl.h | 16 ++++++++++++++++
>   8 files changed, 20 insertions(+), 18 deletions(-)
>   delete mode 100644 include/hw/arm/primecell.h
>   create mode 100644 include/hw/misc/arm_sysctl.h

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

