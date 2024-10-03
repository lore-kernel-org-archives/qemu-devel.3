Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 021DACF34AD
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 21:16:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swTB3-00022f-PS; Thu, 03 Oct 2024 17:16:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swTB0-00022N-92
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 17:15:58 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swTAw-0002nk-L0
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 17:15:58 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-37cfff59d04so1444451f8f.1
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2024 14:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727990140; x=1728594940; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xlvzzjZlFFA+4yuIB0/aX53wNEZ27w33GYF04DZffi8=;
 b=wAEc0WE7AoLwPGGbXfjeM47JuinTDW6MTaT8tXVM0rw+E+CkzrMHrO5V1e2oayzRfp
 /5OhhbPydnycwwv4Sk1k/dgB+/hZTo5YWYi0BKQZJvdt0RjJbfIOqNzgHhm4UeKACt5X
 o+sjC7YXSWX3NTubnD/vbhoDajWWuYwWhJez5gz5FbWTOdRjIk3v2Vlzvf7Hsktp8oKJ
 gEtSkjioYOsHQ0d8wvDeVIhjuGmgb2gop549/1XoOuhLCEac3RZXEzEq2D1UiYxn6W4q
 nZiUw1CcU8X+R1QqX8DKH7rok15V9RVcTjbckQcTAGljR7njqF0me2B9eOk9nR0s1e9W
 CgxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727990140; x=1728594940;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xlvzzjZlFFA+4yuIB0/aX53wNEZ27w33GYF04DZffi8=;
 b=f6nvttAv42rBIAeoaLQlm3SWXG/1BQhz32TP6wpE3NFMCMsND6dEDLzgPNwNIk3anr
 w0SY7XKOOCvyXvTAe4/xJApV1FCrrsA+A8bcxDRgXNG1LiA6lWz23e6vjSMbH4sKjs78
 WXrnyloe5gUf5qPEdGBngYQJ6Uj0CrEjrCDoG596MQS29QQs2Q5+f8lpL5Li5ln0EDgy
 rCU5J6uNSxV1IS2Lb9KwQrDNBWyjDQbvlVIosVk2rrTS9ogYmSLu0wCGWj+AdmBJVyQl
 FYgFZIl8I4zd1YCI/U6ZYNVML9MR5MZ6+QY18ZypbHgU1TpBXRqwDnKUojdLLcBbJW6n
 AOQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0ru3tMtTd6rpxpfUTaxG4FVpJD1A2HiLPBWaW8crVjLUiu+lArgXuWOsjX7j9ixtiarDoXdI0+aPD@nongnu.org
X-Gm-Message-State: AOJu0YyL7byY305NKonpZfyehkkV7ngflZ6B4PRzRAspOzh9Y4NHtSZv
 Fx3+uiRxPyLSu89ETJbVGzsi0P2WWcTAjeqKYHlULc+2y/52vQmWX72hng+JArY=
X-Google-Smtp-Source: AGHT+IE9ebjAJpMSxZl/p8qgShh6Rbu9N3jJ2bYWLShDI34KVAE1eV3cdkvBRj0J9jamAqAgDo/l9w==
X-Received: by 2002:adf:b35b:0:b0:37c:f997:5b94 with SMTP id
 ffacd0b85a97d-37d049ea426mr2815036f8f.12.1727990140368; 
 Thu, 03 Oct 2024 14:15:40 -0700 (PDT)
Received: from [172.33.27.23] (134.pool62-36-43.static.orange.es.
 [62.36.43.134]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f7a01f514sm52969535e9.32.2024.10.03.14.15.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Oct 2024 14:15:39 -0700 (PDT)
Message-ID: <e873ce71-0178-46ba-b3e5-1312497c37d7@linaro.org>
Date: Thu, 3 Oct 2024 23:15:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/pci: Remove unused pcie_chassis_find_slot
To: dave@treblig.org, mst@redhat.com, marcel.apfelbaum@gmail.com,
 qemu-devel@nongnu.org
References: <20240918234748.468148-1-dave@treblig.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240918234748.468148-1-dave@treblig.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

On 19/9/24 01:47, dave@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <dave@treblig.org>
> 
> pcie_chassis_find_slot has been unused since it was added.
> 
> Remove it.
> 
> Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
> ---
>   hw/pci/pcie_port.c         | 10 ----------
>   include/hw/pci/pcie_port.h |  1 -
>   2 files changed, 11 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


