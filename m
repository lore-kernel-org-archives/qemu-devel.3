Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1F45CD4F5B
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 21:54:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPSOg-0000kl-OK; Tue, 19 May 2026 17:54:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPSOb-0000kI-Pq
 for qemu-devel@nongnu.org; Tue, 19 May 2026 17:54:41 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPSOZ-0005Ft-NF
 for qemu-devel@nongnu.org; Tue, 19 May 2026 17:54:36 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-488a9033b2cso33840225e9.2
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 14:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779227673; x=1779832473; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=e8hHQusYL1VsKZmZG2CVMiY1cN8BOUx1rcY7OEt+SqQ=;
 b=Ry0msQ+SBs8CfnWNbpYTEsC3awV+Z0vQcT7fk4KQQf1Hu9r2bXd1PcOGOQM6JF5h4I
 a3VbyeylWbtSWx93iFN4rKcKIvWKkcXztVpdrinDKynCMWw3e5fp6fQ62aPoo2eGvlwh
 FnjKFrkXIFcE2MUnRhnw/HBtHgpmPHdSgmyLMdrDocZtOe6fZmF6zh0VyqdjFJKjcmga
 lZVqD7QOi5JgqWSMBuOmDDJSpbf0AUg9AcRo28Oy1koz/tBzw3GLXf4rCDGQMfboj7cQ
 SW4TQF3l9gsOdMNZx+i5Qk/7ayZ1+c9i0kjgdD2jfvf9Ph0cI/CCf7GvOkVeobGB1sWO
 B8hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779227673; x=1779832473;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=e8hHQusYL1VsKZmZG2CVMiY1cN8BOUx1rcY7OEt+SqQ=;
 b=h4+euhl8dG5hKR4tEwKofB9vY9YSfPhdmtVGIL2WKx22s5uaHHSJRNj2GWu32TjImy
 X5LMaNzhDd5NdSGaMblzZP/jCUPYJPnejtduFLeyQiyb0nlEaRGQfXbQSh7uJlH8K+g9
 9qwYBuxT3VpWCytXRDixu/mEtFoqTidqySO1gw1zYdzEjwE8AXi2ptnv+m124Zny40RQ
 BLmbb8F4e2fYGKq6A/e4q0+gMWt3m4qcTRe8runbD7fP01NB1f7WyLcKqpiJOkT5v00p
 z8PkvfjyP6F954RKj3L6TrzXT+qhDoCpmjWVTZJdqTAGWrH311xyW/aHIA9csF2ENEPJ
 utKg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/phGHO1PDNHNT6EpRRABtPGKltboE/2t4OWTijiJ7rYPnHM/KKbZ2UoAvnXf9ExAA9DKR/aj50ihH0@nongnu.org
X-Gm-Message-State: AOJu0Yz2Vxw0smF38oO3GBHSvEc45hsox++1zeMDhK1oqE9EL2T94qM9
 vBEc05sGh4uJw1E1+yhCIpij0kA7XpsLqHdXfNyTJEMtBtl5K0vxdF9abcjN0l5DnpY=
X-Gm-Gg: Acq92OGi2E1Pzxup8g713qUe17OS5hfCRoi3HlZxUqvhRw39HGXeH6XcMV0BA7EQ31A
 eabVyNwb4YyzYF2ZWN+Od8Eq7GjnpSJZd73fhOkRH65k2Uw+uUiAqZYAxDL0zPBBPJDJwaNnfAx
 FTKi6JlqUmzd/6EavhRvFrPTl4V/R4ZQqZPBVWW/RwWk6Q6l5tdYdYLh92XhbU4grIeSBMeT4dJ
 joYzQ1Jo0CpcxgAuVV0w22/wAtrWx703VzKuj7bpqEq3Q5C9Db7HK+DVJJy/K3cfEl5vFWlpl4R
 vak4NB/ajRH6fWxB8EwKLFlEfwzGiaRFGmQPBIQoy5Gkh6WgfYYPPWOR+GjmAHi/XXHZYM78nN/
 qSyjqbjXGLVI3t0M0uWLYmclxu1X5IAelrWJ0ZIMuLvyD3hFkFB5L3sLImukTQ8rKDfrK04/BAP
 k0lyW0rjQmTIUzyn1OeAcn+8eOtje+/IdPWXQMnYyKR48CoDHbNwGWupR9nkatKlJ5/xrShTbXR
 kg0
X-Received: by 2002:a05:600c:3b12:b0:488:a824:fdff with SMTP id
 5b1f17b1804b1-48fe61ed2cfmr311920925e9.22.1779227673550; 
 Tue, 19 May 2026 14:54:33 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe4862209sm350552995e9.0.2026.05.19.14.54.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2026 14:54:33 -0700 (PDT)
Message-ID: <ce615571-09fc-4723-9b39-1dd4e2cfdd66@linaro.org>
Date: Tue, 19 May 2026 23:54:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv1 5/7] hw/misc: Extend i.MX8MP CCM with Cortex-M7 clock
 outputs
Content-Language: en-US
To: Gaurav Sharma <gaurav.sharma_7@nxp.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, peter.maydell@linaro.org, shentey@gmail.com
References: <20260519175635.3245229-1-gaurav.sharma_7@nxp.com>
 <20260519175635.3245229-6-gaurav.sharma_7@nxp.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260519175635.3245229-6-gaurav.sharma_7@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 19/5/26 19:56, Gaurav Sharma wrote:
> Add cm7_cpuclk (24 MHz) and cm7_refclk (32.768 kHz) clock outputs
> to the i.MX8MP CCM. These are required by the ARMv7M model to boot
> the Cortex-M7 core in an AMP configuration.
> 
> Signed-off-by: Gaurav Sharma <gaurav.sharma_7@nxp.com>
> ---
>   hw/misc/imx8mp_ccm.c         | 9 +++++++++
>   include/hw/misc/imx8mp_ccm.h | 3 +++
>   2 files changed, 12 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

