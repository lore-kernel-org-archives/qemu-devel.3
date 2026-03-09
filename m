Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F18DCF41807
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 15:32:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzca0-0004Kd-F4; Mon, 09 Mar 2026 11:31:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzcZo-0004D1-V9
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:31:30 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzcZl-0003xa-SJ
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:31:24 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-439af00d33cso8868314f8f.1
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 08:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773070279; x=1773675079; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0Jk9g5xVJBESmpIqrYUAyEMtlqKY2FYPPc2k4WoqoEE=;
 b=RsMFi+FUmc1Rb+nOwRl+NtGj2bOH5mr4uEo7vwN/wpdC8JdqzWjkmfoX5h2MaAXRym
 iu4MMjR/BA+t47ZLvtaPapj8fHRb6OEZ+RbyszQWJO4oL0XRfjfUeB6YUDE+LazZFLBt
 PBMawcxsiFkos+XiBduLo+t27WHc2TXjbM10xSHGD/0zX9djXwpHzM7bO+6Cp50laiAK
 niSElZL4yjqbU45Gjz3rk9btyL1qCVUwhLFxr5mjPzq6M2NqWsTXBoY/CTpoH8TSPs8p
 KlZ6N1oJSilT78LvJXUDszdLq6Zp/57D0hnXkg5DTPrdeQo2cl0uFHE5mHNP8BtOop8B
 Tp1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773070279; x=1773675079;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0Jk9g5xVJBESmpIqrYUAyEMtlqKY2FYPPc2k4WoqoEE=;
 b=sUR7vSV5Xh2/igS/V9f8+PEk/Sd7hWqdMA2fcII0097mHmKXcgGTXIF5Cjq+bzwKuH
 vguv39FeRc4MUV4ni764hi9J+DXknLme3kC7J1qEZlN2YRNLxx0M3k7FLC7Bq5JRjlsF
 urbnKrfNcrS9YT49ruzZBuw0XTRVBuTt9ZyOx5TPq9Eq0yoWcKKyHCh2h6pWP9sq6xCW
 ogCeTfgX3SBV5ObSxK51y6RyNgHLKq30UsgNrp65BA9r1cbo6pzp47wee9etsVji21DG
 0gp5b+x4mSuwOpXNqJ2AmqgCQqFf/d0QtfisoKZCudGgH+e0EFFF2Xp6HTrih1pgIt+7
 klqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcyPWPhcTdRG8hiBlmqGOedneKzJC9f6E9bqzu9a26NS9S6dCixfaqkQ+9qIBIaSpZU250dZMauy/n@nongnu.org
X-Gm-Message-State: AOJu0Yy+YGZQmR6ZB15rCPXzbHIdSMFCA/hF2XvfuAYU7woJHJiAGJPr
 k+UNgfQJ8PHwps5j6J5S1APeClspGifplntHeF4ujPeZOVee5a0GG4w7fyZv6zEpzxA=
X-Gm-Gg: ATEYQzxkC/RiyE8kQhYkibgGSEfp127MCFM81PN5Vul9pazS6OMQzabY6AlLNrptImR
 DJipMK39gcDvIVPoC0KXwDkvDOamQmJukfEmyqqmYB0ShftuktZ9p4XHqVwitW5ZwqzXQfIlBmT
 Nfb3nm+uB6EncANDQiLcCQitiR6sq3byr0D0xYfJxYwrjCbff48A7RjLCXmUeOv6z8npO2XFXKf
 F3G78JvR5NT2Cdml8brDLHA9WHGAoUkYNyGT0pBfNosvGqhRziITq7QBcdvEb4UFJ+em50z2UxL
 9GgrJvN45ZItd/755aJKwYXm2AAYmAAGQ0lNEsdVtPNeg37FV6EYgk/gWnBVzbxZrDspLyVjV5t
 k8y3iKwf6Lv2g6f5liaZ/OcLbo6M4PEPPCSL1UD4eR2+BQUrVHVJc1g1qryzJL/IFQNIXkeIxaI
 nCE7U75q7nlfJ0b8ztSLpj5rHlbJCJ0WAdoCXHuYFxzP0xxx/wf88jlrnbCRhe6sRCRQ==
X-Received: by 2002:a05:6000:230f:b0:439:b114:60c2 with SMTP id
 ffacd0b85a97d-439da880b2fmr20161919f8f.34.1773070278960; 
 Mon, 09 Mar 2026 08:31:18 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dae57401sm22761234f8f.38.2026.03.09.08.31.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Mar 2026 08:31:18 -0700 (PDT)
Message-ID: <a8cf5873-c202-4e8c-8c0a-a84953101485@linaro.org>
Date: Mon, 9 Mar 2026 16:31:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] hw/qdev: Document qdev_get_dev_path()
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Alessandro Ratti <alessandro@0x65c.net>,
 Markus Armbruster <armbru@redhat.com>
References: <20260307155046.3940197-1-peter.maydell@linaro.org>
 <20260307155046.3940197-2-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260307155046.3940197-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

On 7/3/26 16:50, Peter Maydell wrote:
> We don't document qdev_get_dev_path() at all; in particular
> we do not mention that it returns a string that the caller
> must free.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   include/hw/core/qdev.h | 23 +++++++++++++++++++++++
>   1 file changed, 23 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

