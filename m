Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E1DDF8A15D
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 11:29:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDKuA-0003KD-LU; Thu, 16 Apr 2026 07:29:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDKu9-0003K1-82
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 07:29:05 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDKu7-00014U-Ly
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 07:29:04 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-43cfd832155so5445866f8f.1
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 04:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776338941; x=1776943741; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:cc:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+mjwxooNmygLDtFrBNq6mBWtH1YxjaUHFIYcyNkyw20=;
 b=RaJHz9ZKo9m2Lov6bEdfgseetbjp+fc2a/1nRlEPFPSUgsha5qeivw7wCMgI0p5LhJ
 jKNGvWMGyyI6QpningEoqpV2yxWKFdWsJcegcOUmuXolK3HjWW/+uFbLko40guvQYEyv
 tglx6o3RkWriTOrZuMS5lRzszaoUiBvhXzKt91P4HG+pbQHQmBazkGlinlN0KYlq+wLb
 8ZVweISsrocXGPcbk9dpomZSF6a2VLZ4tKN9Pj07u74l2Zj/2n9ppDJ2vjdVcTyrc+Zu
 ZiKMCbbz7P8fmDIju7i9W29sxYEhQyY4OuY448w/33+XUvDo4+1gZKe6Z/ZJAcL1Aakk
 SemQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776338941; x=1776943741;
 h=content-transfer-encoding:in-reply-to:cc:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+mjwxooNmygLDtFrBNq6mBWtH1YxjaUHFIYcyNkyw20=;
 b=DPnyiOlQ7MYoT00WoQjWsDvhq+uKQl4Iu7aTSkL53NWt7ZkBAxKzpwup29mhMXt02s
 Nc695PZSqnr7v4uiLZoQPzsHVKR4tO4tKSe8N5jvR3HuPJnY5QwP1AlpYHFc0uhGMQd4
 o62tKmAcBEnZevLnUA8V4kTZVzjXDTD+Ivxs6q75NIj5AaiqormkF7zK3hHAO67062it
 h1UqGoI+OAJDt21s9M2wd5agieBwVIJXbHt7gVncOSKazCu08Lm/H+VLDDfYHp2zj77r
 Un2/WLSOZfd+7o3giSrOkPJ3/8esipZE8VR7rmu18YxlE5Ny0Ri20obJiIgmeuY8If+3
 PU6w==
X-Forwarded-Encrypted: i=1;
 AFNElJ+0YQjXXZKVWfuvTW2fOZHh3fTcoK1WIjsxF4Amaigg81da4NJA4TyvhzJ/7faOPB6dlKAZpSjNxH64@nongnu.org
X-Gm-Message-State: AOJu0YyIWWr06uHwRND+7jbz9AbmlIu7MXn5MT1pdMtccdByiNmSNogs
 38hHYXEdk/zbCwoy4e6O1TOjc9o82J0fLO2XBUC49/vVkfoqKFNI3ZpYbtcfArFmJEE=
X-Gm-Gg: AeBDies8EMQpRxOH4/Q0B0B4AoFTrmW9M8w3B0tamzL4LnEpZy+fBpZXc3gMxMyvmIr
 /UPB8SyF3t62ZlWrq4T7NNNda7FOdGu9RbZyIG0kmEygWBdgBeJMa84L593pTnpLiq52wsj/btt
 9y1V8F1jZm0zIef2RW6fOzFOj0mXFX5NEfrWmb2LqljNxzVTMANUP4xjxzOxu1FRVBmKDyF0lh3
 V6aPo2MXKTR+U672QQJHN7cQkuBxzw0v8KY7NdP9tgGD0bN+qhnnFAE07xHxIxNw8/8cVMLCpfl
 iOthUXBeoMQegVxMSu3HD4Sn1hvC2fJ8Pg3uRZf/cK/+GHMbG1R5ApPn1Rh7xp017jF8MnecLDY
 s/5CB+nHoACy3IdSsgfLJ8KJlT9xFGm7xubdy5gatFTretThdsMgRIz7eANQKZQu9yGeU1hct/b
 U+hcIZTPya69MqCFtudNAkKIyqlDszco4/Fo2Zd4UYmtiOZ9iEGVtVDOzcwS7i0p/MQw==
X-Received: by 2002:a05:6000:40cb:b0:43d:1c39:593c with SMTP id
 ffacd0b85a97d-43d642b6a52mr36217139f8f.30.1776338941392; 
 Thu, 16 Apr 2026 04:29:01 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43ead3e89ddsm12481744f8f.30.2026.04.16.04.29.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Apr 2026 04:29:00 -0700 (PDT)
Message-ID: <58a32864-6c05-432c-bdc2-5763e32cda99@linaro.org>
Date: Thu, 16 Apr 2026 13:28:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/28] MAINTAINERS: Remove Huai-Cheng Kuo
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20260416091654.316158-1-peter.maydell@linaro.org>
 <20260416091654.316158-11-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Gustavo Romero <gustavo.romero@linaro.org>,
 Tao Tang <tangtao1634@phytium.com.cn>,
 Mathieu Poirier <mathieu.poirier@linaro.org>
In-Reply-To: <20260416091654.316158-11-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

On 16/4/26 11:16, Peter Maydell wrote:
> Huai-Cheng Kuo has not posted to qemu-devel in some years and did not
> respond to a query about whether they still wished to be listed in
> our MAINTAINERS file.  Remove them, on the assumption that they are
> no longer active in QEMU.
> 
> This makes "PCIE DOE" orphan.

Cc'ing Tao & Gustavo who are working on Security Protocol and Data Model
(SPDM) which IIUC use DOE.

> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   MAINTAINERS | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0b2adbc247..bc7c9b61da 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2160,8 +2160,7 @@ F: docs/specs/*pci*
>   F: docs/system/sriov.rst
>   
>   PCIE DOE
> -M: Huai-Cheng Kuo <hchkuo@avery-design.com.tw>
> -S: Supported
> +S: Orphan
>   F: include/hw/pci/pcie_doe.h
>   F: hw/pci/pcie_doe.c
>   


