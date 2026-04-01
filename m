Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8724AD3517C
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 13:30:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7veB-0002vJ-3m; Wed, 01 Apr 2026 09:30:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7ve4-0002Zh-79
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 09:30:12 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7ve2-0006Me-JG
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 09:30:07 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4838c15e3cbso57809495e9.3
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 06:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775050204; x=1775655004; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CgtCkMHXmx+vk2N46JQQ+p/xKZOEUL7X/rPNDh3mnTA=;
 b=zJfmYCQAFEh+3Zkhnx/nhjYa8Sxn7KdARWtA9gx8VOsLMj+x4UEWh1E/grjjhY4cK5
 p1Rwggeeu11E3Gu05Jp1bSvktC3f7olsia6XxDXYUbS1SsWS4yGJqMLsHNBnuRB2sRyP
 bnoVRvc/ELrGU5f3xy2+YTAQ7JrT8KTenbr8TihNDMReQtguL+rqZ7zjTK2xaMPwhJqw
 H7K+E/XBOto2S5SWeXA1d6Iuzdh6G+ZhS6R/9oUncDwkgDy1IEJ1SzjpH2x4r33zP8ol
 IkLAH2ISMzg+wkk/DZdbFLMN/S+8HClzDVxWnAltrsoCgSknBQT97Op7CftuFTnmJ3Jv
 048A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775050204; x=1775655004;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CgtCkMHXmx+vk2N46JQQ+p/xKZOEUL7X/rPNDh3mnTA=;
 b=XXXYlGXN2V4cehzF/chEuw1LW5WWGulVsEYEGTdHHdmrQNCBtDuRYANrYuoYXWlg8U
 RzDPoHmLZLGyU3zgu0CzpO1EiFmHljHVhi+LXIs3NucHoA70eOlppxTVB1DTsxzfVz1V
 NmWaP5kVDyPZHEfaQbuZeVwrsalehTDSv7gDk+++fNU9fENJ2ayuekHy1ES2yl65CLi8
 QkM2cidJbyRIUX5HX1ZTb28xd40ZhtAzXsrtx39+6IJlGeI+MQUx4enuNyWbpt8Bs122
 ADdFeEQQIsyRultZNUgOxEiNmHbY88FtLDFW4mXh0dhitWl4SqJ2bZA3XGmEaOX+Yxjo
 xOFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXl0+oYCSh3Q37Ngjqbc+eMHdgUpq7tvjpHp7jVv+lpVzDcnOr3s/oiEcQuT7nn2llC2SoAT4AuQLWx@nongnu.org
X-Gm-Message-State: AOJu0Yz33CFf5ZOnw+Kujv6zloBCTOxuI7IXMG+8gMwVpCgqYNTqAs9g
 2iPZw/TmoOhIbcZzeGLNXM6xS7apEmyCPSUQmR2Lm8GRC0VkbnRG/d2X6mPnsq4swGg=
X-Gm-Gg: ATEYQzw5XFgPgQjHWYtmMaz3DV+FoF/uVK5Gu1VW1mqXvMqvB/q81HWdrCfAxLL3u9x
 y0/WVcLwN8WxXdgbLChmYTizNBpqHFTOr5sVqxsXRI6gDJa1zB9zMdq4RZxScBKCYS9o+Ei3uSt
 mccXrzk/rwJOxVD8ed58xmZpbuNbi3K0PCV7XHG7hmGETdxt7DL4wuuYC2DuVtADS/0InOutWzF
 cZY+Dy7T7xtTsla86tBobICJ25iStcuB9/VxJkdomnYKrJOJc1nb1kCGPLzC9pFTuAVTJz6RUrQ
 vYbv37DkhEEDeJFVupk0dsGXAljuL5WH50MBNGky/olGr0wIAgbtUXi57kvASeNlOrbEXfQa29S
 K3nNUU4ISf+ct8YFaUXkds5G50XmuwoIvMzLirbzrjNeqxJZ8nWjPXkY76Xzw/yuFr3yb/tmovo
 Ams932uSDIdsCLnHYigJj9wcO8jnsueH/rIIT3w6EeWH78hrKTXGtqLqaCPe8nnK9Ijg==
X-Received: by 2002:a05:600c:821a:b0:485:4135:5c92 with SMTP id
 5b1f17b1804b1-48883306dd5mr64134285e9.0.1775050203207; 
 Wed, 01 Apr 2026 06:30:03 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887e86ecf6sm124893165e9.14.2026.04.01.06.30.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Apr 2026 06:30:02 -0700 (PDT)
Message-ID: <96429e00-cb2c-48ed-a069-39f897959b99@linaro.org>
Date: Wed, 1 Apr 2026 15:30:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 02/11] vmstate: Pass in struct itself for
 VMSTATE_VARRAY_OF_POINTER_UINT32
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Fabiano Rosas <farosas@suse.de>, Juraj Marcin <jmarcin@redhat.com>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
References: <20260326210532.379027-1-peterx@redhat.com>
 <20260326210532.379027-3-peterx@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260326210532.379027-3-peterx@redhat.com>
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

On 26/3/26 22:05, Peter Xu wrote:
> Passing in a pointer almost never helps.  Convert it to pass in struct for
> further refactoring on VMS_ARRAY_OF_POINTER.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
> ---
>   include/hw/intc/riscv_aclint.h | 6 +++---
>   include/migration/vmstate.h    | 4 ++--
>   2 files changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

