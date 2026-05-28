Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E47F4CD4F54
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 15:46:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wScve-0006oH-UO; Thu, 28 May 2026 11:45:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wScva-0006hO-4W
 for qemu-devel@nongnu.org; Thu, 28 May 2026 11:45:47 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wScvW-0004pX-V8
 for qemu-devel@nongnu.org; Thu, 28 May 2026 11:45:45 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-49048e043e5so52477355e9.1
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 08:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779983125; x=1780587925; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8vCDK+KeyJO3gUt/aA96bfC2TBWjmjbKE5Dg98WGwbA=;
 b=Z+PnqcfxyHqPuNRgiyR0ohAPIDWuPp/QpXuCQBhe9LQQNc/BltUHrKddoAzF5vHZK4
 GN7a5ruttYmjosd7/JXd/c+X8GXEPYDFyg+Ws6yZCBZ8wCUrtyb4Klb6inwyoKatK+uU
 j+LDBbjL3TPL0I9/UCL8n5AGugi+X/fxvJoWDM6rtgZwB44Ss2rxkIWq/68kw9Gep2fr
 OQDTOAOyeVVRriuzL2+mtaIltK31VT394GdaWAYE1shcLA/7SSYBGVHTFuNwHLE6aR60
 SKQPbMWfyhNiHkpYWq0OSnf8N4nd2qyUq7DRz6p44KIEVkoYr/EC/qbgvY/bePhWyGFs
 OzvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779983125; x=1780587925;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8vCDK+KeyJO3gUt/aA96bfC2TBWjmjbKE5Dg98WGwbA=;
 b=Igl5BkXpVbrltk7WauihfV9yNnMUF3eciytjZ1lDG/ORnVvad+vpLs7xPLaS98fdop
 0gt3cU8ZNiA1m88E7tVRJpL501mjpyDaZSufBe2wMSd2itjAkxeZsIOje/ne7TJt9EhQ
 G0gnzFtRqCEvAfKMR0RIcy/Cv/4BVta5TX4Lna5Uyp1zVpF2EffbemUw4h7fHB6Pg7tX
 uKJ9nGU1MagDB5uwIMz/9rq2rx4okv3/nGqOadSaXM3FaPlY0q51mdUvNTF0Ubmkz9I5
 mhaPAUGbXcHolV9J7Viziz5LwXUzT+Vya0PIR7xSVelCnHU3fJuCYroBYj0BtzQZ0Eki
 MTRw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Mv2ihMSwW2PgwguueWTeJX0B/EA2LxSM+Is4GuU33EDKIzMzWUuxJtWfjmHkYUFNvI/7Uaq/irTi1@nongnu.org
X-Gm-Message-State: AOJu0Yy0k2nWeQjzmIvKzpgVY3CARscnH4nOQGyFSxTziDebcTCtYTtf
 BXg44eg8PHNHm1QKu9r0x7kviBVuFm9hCB59Lxk//IqP1lZmVhz54a18FOs8wdq1FkU5REo4U47
 fZrpTsPvIkA==
X-Gm-Gg: Acq92OEYaEhecZPih74WxSRyce13jea+E/W+VBi8ZMhrvsGKrr8MB/CYUchjWXe0Vck
 yGTQW6b770kFJX9y9pAqnjPBWXM9lkQs+iSRKXY2CcfqyYGxYx/LzliQ7D/UaSEmzeajXjhBR2n
 comCKCWLYs9cSn/GXJyEFYRCd3wFWBNfBLeuDwYjLRO7r7KWjZQ8DB5fpU2bTB1JiA69SbHZ/UC
 ojMn/gBY6fd4Sjyy1Evm0Ip2fNV31xda9B4WLc7df/IYHmX/gYgmxt4Z3hErNo1mhBXRmGEAY8l
 pqUmIAGzKgdWstye1TlWCQLUR5d+exkuhIoECyxvl5UTHk2ZTyvXxsyKV/AbGzjxwFNQQLqvAGZ
 ozePyX/q37t5e+3arMFPSNRUSik0yq0/x+pZ2lTZcCAKPcjLi8IsIw8jPTQCCTosDYyM/hwgxnU
 gd9hhRWqhxmKLZwQqZQgotAm+3AFmqMCuSiTkcXUgH/Ho/jiB47hkTpU+FZMNq7N8b0MpyRQM/H
 YgV
X-Received: by 2002:a05:600c:a402:b0:486:fd5c:2b35 with SMTP id
 5b1f17b1804b1-490426adf66mr379191365e9.13.1779983125221; 
 Thu, 28 May 2026 08:45:25 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45edb54903csm14606215f8f.6.2026.05.28.08.45.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 May 2026 08:45:24 -0700 (PDT)
Message-ID: <1eeb409a-3319-45b5-9dc3-2b983b291967@linaro.org>
Date: Thu, 28 May 2026 17:45:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] hw/dma/omap_dma: Fix coding style in
 omap_dma_transfer_setup()
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20260528152852.3349928-1-peter.maydell@linaro.org>
 <20260528152852.3349928-3-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260528152852.3349928-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 28/5/26 17:28, Peter Maydell wrote:
> We're about to fix indent in a section of the
> omap_dma_transfer_setup() function, which will make checkpatch
> complain.  Since we're touching the code anyway, fix the uses of if()
> with no braces and wrongly formatted multiline comments.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/dma/omap_dma.c | 51 ++++++++++++++++++++++++++++++-----------------
>   1 file changed, 33 insertions(+), 18 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

