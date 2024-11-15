Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D301AD68BCE
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 16:37:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBzJF-0004np-Li; Fri, 15 Nov 2024 11:36:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBzJD-0004n5-Ap
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 11:36:35 -0500
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBzJ4-0001Mn-5y
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 11:36:34 -0500
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-aa20944ce8cso374360566b.0
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2024 08:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731688583; x=1732293383; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BYeXWb2q+HVZXGESukJ4gqLBNc9DefCyjtgcxN4LuNk=;
 b=bQ16Sg7VjJJx+1Y1iOzsSKMo7v5/SxaU3sqM3KmTG7RUiejP6EZXIBfshOGrJNiHxs
 QoQeYYE8IGwHjjrpAtqstIcp4eZxDT89nM/U3UjmgwBkgVb30xa5mVeGH7i1gCCH5X2W
 xb6zfEHbu3ZN8mQd+nA1rXXPbb7ZttZU8blpgqfdpQXu+fzEUyBx6N9QV31RtcTVGD28
 ES1ARljdno8U4k1dztJjrSS774NUQmZHVpT6PTtIL0H2eFgUaZWnOARmi9FiSUtxiL28
 WAPfQiapVcwLZ3kMU8690MGW/1iMtgHHcJDT6zy9Fzy7ryotLQlCWQvfAM5xziWolvV0
 tChw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731688583; x=1732293383;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BYeXWb2q+HVZXGESukJ4gqLBNc9DefCyjtgcxN4LuNk=;
 b=T170JhY7HuI8daN7AAufDNAAdbcBMrodO51/33v4uLCTdyDEumfkziwTwHAMFyTjRP
 JCyjnt6L/ndy7aCI8by1YsBFwVEJq7eQSTa3DQJK5OdvGe6IJuhGaEGzJK1t7o7cy2D0
 Xslv+0E9vOrmcneavzX42UjS/06YWw4iPdJc2OuxJYLOBIdleaWWKqaU7/NB82BQ5rEi
 If96696bhIgr5+IUtg95C7oVYu9R/m1YvuIaOpmdbpAWxxkpFJVyw03pP+ZUSMWIM5gj
 0McZt6EDaLCXNjeibW2j+iGXF73XIns0W2CUnGqK/Ecc/X/0vFqG1ziMXFq1uw1HwhIi
 1XZw==
X-Gm-Message-State: AOJu0YyrUkW7YfkZTJMhIpgN9kXHPMARXweQs+fvSHahnaEE1nWcfKuC
 xHWohIgqQ4F4E0sBMfLRZijz8EfCfU/4lW7YRL1q5UDBuIEec4wHRUu2NtYx2IU=
X-Google-Smtp-Source: AGHT+IHiTY8KS3sG8gldpRkJY7RebSPOBDuLe1wSoRPaQw0FESFd5xG+wjg2YzaYEjpi/gxtagIxGw==
X-Received: by 2002:a17:907:2d93:b0:a9e:82f3:d4ab with SMTP id
 a640c23a62f3a-aa207687241mr715415166b.9.1731688582768; 
 Fri, 15 Nov 2024 08:36:22 -0800 (PST)
Received: from [192.168.69.174] ([176.187.214.209])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa20df271b7sm192885766b.41.2024.11.15.08.36.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Nov 2024 08:36:21 -0800 (PST)
Message-ID: <89547c36-94b5-457a-9a63-66c31c8c825d@linaro.org>
Date: Fri, 15 Nov 2024 17:36:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] hw/watchdog/cmsdk_apb_watchdog: Fix broken link
To: Roque Arcudia Hernandez <roqueh@google.com>, peter.maydell@linaro.org,
 farosas@suse.de, lvivier@redhat.com, slongfield@google.com,
 komlodi@google.com, pbonzini@redhat.com, venture@google.com
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20241115160328.1650269-1-roqueh@google.com>
 <20241115160328.1650269-2-roqueh@google.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241115160328.1650269-2-roqueh@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x636.google.com
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

On 15/11/24 16:03, Roque Arcudia Hernandez wrote:
> The patch changes the comments to point to the latest Design Kit
> Technical Reference Manual.
> 
> Signed-off-by: Roque Arcudia Hernandez <roqueh@google.com>
> ---
>   hw/watchdog/cmsdk-apb-watchdog.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



