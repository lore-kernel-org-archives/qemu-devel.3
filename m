Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DAC7C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 11:16:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8H2S-0003Bf-O0; Fri, 25 Apr 2025 07:16:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8H2R-0003Am-02
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 07:16:11 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8H2P-00048E-8x
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 07:16:10 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43cf0d787eeso24074715e9.3
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 04:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745579767; x=1746184567; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=C0+6++I8ZYzgo53hdAJlQ+PAexnb750t9iDp5+aKXc0=;
 b=IPoDpf8Yucq3Jxk6eHJrFNQ3BMAbKpwViBpe0XVYvq7mxLy38u03d70+rMQyMEydk7
 3Vh0dyU+VGBSaWeD0AiKPYO/aE6JyJ70wHRPAn3XYOADFsLo0HxGfBqpjCFNf/Qt29GN
 MTU/sJtL6QMUTV/CU2iyvfty4hT1pTYB5am1s7djOXk0Pjz4491Lx/12flnda9gcpjDa
 M8GOs7jM2yqyzlgMEhSBkneCt2LnLknoPQfms59p7mo2P6U/52VGpAf28VocdFX9jeKN
 bJbqa7ru3EljqDDTcRiIFwg8k1+Wufw24td3LbjPX6kEnCxHP0Qqh0HwgKnvRXYd4Atn
 EPzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745579767; x=1746184567;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=C0+6++I8ZYzgo53hdAJlQ+PAexnb750t9iDp5+aKXc0=;
 b=rEJxSFiJm5ZxLBN7Yzeq0ZDMD5e/VdVVd7J4qzExk+EjZ0OqdMQ7LN+bo28tqRiowa
 F8aonaJgY3+0hFUdLo0L/y1X2HhXbNFb24rcUWaTjOpBWdD5Q59auCKzllUPR95wfnOB
 Aid2bMYrgtTvuvSG4T+wsquqKJgbrA0IeaPd4kycOGL8hUmzpPzhZtYjuAgoQTnivghb
 EA+i/yDlEpJ8KvyT/7gU6m072XThRnTB4Ksm8WYWSb0PnVipQyP1HFUsKGIE8GPAj1lC
 nVCYdDFQ95EFrq2CC6fP3Ppess1fQlvsY5MBwPpCslwgLcoEbUh/FaLXjIdGZ1EoMYr2
 Jy+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXc+L8wG5riergcH2biAmFBlHEImQPt4cDWeWluEct55J5oG8dINS5CWfVMmDwaBRPEdaryzU61IY/v@nongnu.org
X-Gm-Message-State: AOJu0YxD9T0ylaLNzOgbBI32w5T8u30pr+wv763eTYA8cfZWdY6+4B+c
 mFmMIoqMEKIFc+nQzns4muC5eedy0lOXUDfHYij8//0WNQfhyY9U8iYJH+8KbgA=
X-Gm-Gg: ASbGncv1KjszaBmIJM6LVr7AlY7Gmv52YBDoqsmIS3JBZ8lGytr915k6UgFpBKdP6Jc
 HMaShe5WhKPxXYB8JcxBmPBVWgIKmMgMYU8J4zxEIrSw0zKWGmNou8wk2SO/YNutXuITMNd8kW0
 wk/Cxc58FRnhdre+YUeHSbQKLlvEPjE6UuQgXEr+2ElWE6Tyd1yvR03zQpzmXkprUoeuK6805e+
 VPEyhNhgaX+GHAyfbhmehMei3ur5UbS4ID8vYapmTjoAbIzuSEc7uug6blXgJg0f7WJQ+Vn9HhG
 dW/rw741Ilemtvj0xsZatFzcCC2tYBJ6y7l5ibjZ6bG4rdNUVfpK69J66WmpMVXYGEwYpKyVRMV
 WF60clwv1cMyB4uJNJK8=
X-Google-Smtp-Source: AGHT+IFJV11VAEAxATVG3sMjByRSdGuphrEr2qODFZ9f5cf/caZYYTfz2MLUCKAR0HsSka0w8rNILA==
X-Received: by 2002:a05:600c:1911:b0:43d:83a:417d with SMTP id
 5b1f17b1804b1-440a65dbddcmr13430915e9.12.1745579767379; 
 Fri, 25 Apr 2025 04:16:07 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4409d29b9c4sm56294895e9.3.2025.04.25.04.16.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Apr 2025 04:16:06 -0700 (PDT)
Message-ID: <152f7911-21ee-48e7-b0ca-dd562dad8afd@linaro.org>
Date: Fri, 25 Apr 2025 13:16:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Whether the qemu mps2-an385 model support getchar?
To: =?UTF-8?B?5bCP6ams6am5?= <1353455048@qq.com>,
 qemu-devel <qemu-devel@nongnu.org>
References: <tencent_6CC3332A93DC02BE2030AB5BC0E63B10B808@qq.com>
Content-Language: en-US
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm <qemu-arm@nongnu.org>, Gustavo Romero <gustavo.romero@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <tencent_6CC3332A93DC02BE2030AB5BC0E63B10B808@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

Hi,

Cc'ing Alex and Gustavo.

On 23/4/25 13:31, 小马驹 wrote:
> When I use mps2-an385 model on qemu, I found that it seems not support 
> getchar. I used the FreeRTOS official demo(mps2-an385-GCC-QEMU), then I 
> tried to use UART  to receive input strings from QEMU terminal, so I 
> tried to use getchar() function. However, some errors occurred in QEMU 
> as shown below:
> qemu: fatal: Lockup: can't escalate 3 to HardFault (current priority -1)
> Is it means there are something wrong in the emulated board? And how to 
> solve the problem?
> ------------------------------------------------------------------------

