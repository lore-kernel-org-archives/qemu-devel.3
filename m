Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2DC2CA1002
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Sep 2025 06:38:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uumYA-0001Cn-Qo; Sat, 06 Sep 2025 02:37:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uumY9-0001Bx-8j
 for qemu-devel@nongnu.org; Sat, 06 Sep 2025 02:37:25 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uumY3-0005AA-Nl
 for qemu-devel@nongnu.org; Sat, 06 Sep 2025 02:37:24 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-45cb5e1adf7so22830395e9.0
 for <qemu-devel@nongnu.org>; Fri, 05 Sep 2025 23:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757140635; x=1757745435; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Yk9KJv6LAUadVzBflEA4IF97hNs/USC7F0kGnQa8HZw=;
 b=ti8RLBdQE5sgwBpKSBgNMV1y6SnKGfbZ4eoGuLFF/+D8ylUnm3fKdqMlQ5YTTa2ftL
 nfotGBuAUXUZBfKwEc/0gxOsjB9s1U0kL65lJh+y/C3LeEI36Bsx8bXQX+nJvrvpbtxn
 sl6GGsYKCPKPM8rPDbqGfjUlwtTQl5IwKGfQwa5f+4DcDUX2BTZK0vI8QoLBF8zqWb7j
 Z2H428mxetxUHD8theX5GfVGhqxzYSP2cSzSOdr6AlQ9DAJETXEXHXEDcwun1h583m5Y
 8vJgHXtIWNo2Wk+sth9XSlLdOl54ymPVytr9tfSo/x6wyM0rqUsg4O1TkXujjLGXHNT5
 SAZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757140635; x=1757745435;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Yk9KJv6LAUadVzBflEA4IF97hNs/USC7F0kGnQa8HZw=;
 b=lFvPaJlM0gv17k0WyY0loG8Ugl2Df1Dxd0ugw4tkD8lVD2gI08/zeHuNq+pC9KhauU
 ustdgCqvkWEB9zqnWrpheAlqRxWoXzaSlgsdJ4ehqsbZvaUeABLalBgw07H9iAxjuqPc
 PFvxhadyq2vkj3lj/IiTPHGk2t161LDuceZ6Q4dxmrQlvP0LSTez4iH6Dz/2IC9QB+aU
 zVB9R+YjQZZSeWoXU0tjdHn598eHMdtRAIt10Cd/UzmWunCjBFLbE3wHVy/xe1z884Go
 2bVIrAZcUFC+JtQXH4F7Kntai6t8BEmzWFRkGAhDx14+JTPwQ4TJmqnxgee7kPciDc0X
 P1RA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrgb3aR3p0n8VA1Qu2fFtzKxBKtKNV3m/gqPcLPPh8ITta6c54pF5629EjU/PVtdjZhXjSJEeCEjqq@nongnu.org
X-Gm-Message-State: AOJu0YxmB4JSYY4uJxRqY/0nAlYxdtT/19TlN3CWYfHum1Bc+ML9V/o0
 UoTEqhWZwn3x0+Dp7IN8Ma9pjKa28R/NdO6wOn/cKobYqdfsjkbi310jRVWZmsOXCbM=
X-Gm-Gg: ASbGncuYu1H8wnjItuJ5zLxK1N/sGTAv9dMS0i2eXuc4x3KHsogB8qAC+LDO+lr5l8Q
 IXpdN0+YW+LeCWRU2K7nsyFeMpjLaU4wEGFxCptiJ7K4BAoyRc2HbEZkzZ57mrK7oYWTli9QCAB
 B1kl1DaQwT+gY5bo4F3DQ78ki6Ypm0xLLsIFSg8a3ra613yZAmYcoIzJgW9IYKH8Nue3oBby3fw
 9jxBjmEOz8VCVzIjwd2gna+n+BTmPrAMp2+piJopbWBbEOczRMR+dx2ds3s5Rqf64TEyWZ40+Ab
 sZM21HtGQRy3X5XG+YanCFApNvG0KIXdUp3FerdJ/KMsMTsHIQB8e6YNoBFdQfOcowkA1Md/cpa
 J8cxNlQgh590MAcb/WucuKwyNeQ+iqBEb3nzYJXg=
X-Google-Smtp-Source: AGHT+IE3iIMxvoWCHZ6H5qo3XV2zOXEJRymyZrVaiJN68qfKJY/QxjgLtDvNYL3YNQoV23Qe+hXyzg==
X-Received: by 2002:a05:600c:4fc9:b0:45b:7aae:7a92 with SMTP id
 5b1f17b1804b1-45ddded75e1mr8092075e9.21.1757140634834; 
 Fri, 05 Sep 2025 23:37:14 -0700 (PDT)
Received: from [192.168.104.251] ([217.65.133.19])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45dd60b381csm61111985e9.17.2025.09.05.23.37.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Sep 2025 23:37:14 -0700 (PDT)
Message-ID: <56092d2a-b8a1-4f9c-a9f6-486d251e70dd@linaro.org>
Date: Sat, 6 Sep 2025 08:19:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/11] accel/tcg: Move post-load tb_flush to
 vm_change_state hook
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, philmd@linaro.org
References: <20250906051820.160432-1-richard.henderson@linaro.org>
 <20250906051820.160432-6-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250906051820.160432-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wm1-x329.google.com
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

On 2025-09-06 07:18, Richard Henderson wrote:
> We need not call tb_flush once per cpu, only once per vmload.
> Move the call from cpu_common_post_load to a tcg-specific
> vm_change_state_handler.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/tcg-all.c  | 21 +++++++++++++++++++++
>   hw/core/cpu-system.c |  8 --------
>   2 files changed, 21 insertions(+), 8 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


