Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AF5DCCF9EB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 17:59:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEARd-0006uh-At; Wed, 29 Oct 2025 13:58:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEARa-0006ta-P5
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 13:58:46 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEART-00070M-KO
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 13:58:46 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-470ffbf2150so7961335e9.1
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 10:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761760712; x=1762365512; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=u9mbM1TJeDrfNVQfN5B2xHuKYeF4jWa/ZDtGhcb6GVM=;
 b=grjcvLx+qD8Ke6CNhFF20DGkKCENEftiA9WJSm+SL6vV7JBRu59mTKSTTI82I/VXhb
 DjDsBCrqkanPixj32H8MhYVlqebcgMTNU8DoZnL0kym6IS0jjsiN80ZSSnZxSX7g+f0K
 rLAsSpYyOvNtcLqk7nXrykwyRe9+QjIJsVeVE9eQWhO3dCHtumKEs16S5JYgjabCTSPl
 egTvxKnmwZfZ7B7sBb1J1i70SiRfw0RuAE+syz3JE7wlnrJ5oz+8Ryyej5OMpijSnJ86
 sYdpPXBAC3GABiwajn4rQtU1WzLUWsHc51Wm3RM70EQ1pN9lp/weaCidUh1iDRNPNJb5
 oEqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761760712; x=1762365512;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=u9mbM1TJeDrfNVQfN5B2xHuKYeF4jWa/ZDtGhcb6GVM=;
 b=GXJsUQG01yrBJAxHdSSJyBkK2glKZE6NfmVMPKalLuwFNOoDEsPWZNkiITLR8SmUhY
 FYZllqDEgJiSeiDYwsPZINDSaAZq7pC6y1Zp+ikXhSl7oMkgwn7ZgEOL5MJtJeAujsef
 2rRimtselvirRh8Q4rkXC3/Ij+CfaiwVpjUaCXPShjgXyqPZMq7ETAafcN12giO9I+a9
 EVPznp4QPSyARSNjnPVsEOODgIsYz1My8cEyJehJOxUTbbt/3zrDeqzF3Wov9RLoem9C
 zkkuVvFdhuMDISU0BPFSxk6a/352zSQgghcMY3pNPzNLkStMREP8iPVy+KVe/u8RHs/S
 27Tw==
X-Gm-Message-State: AOJu0Yw88ExFJ78d4MPbCejoBflAEFM35+N8gM/zG2cbCl+PqWldiPwd
 CYuInH8QLjvlKur8Qz/LA2Xl/yNtvUIdj7DGLqKMdppEdO+f83Gjno0m1wrjdAeiTj8MrD0NHUp
 /brccqpk=
X-Gm-Gg: ASbGnctZVUI6RAh09u6GnO/MrlrIxLK4raBcMlu/6PPEnVpPBTK8BwKWUfFyqTOqLr3
 A5f4vHPuwZmrwfyApu8QZS/bAwpVCtQHP5J67CI9CgW21dT0m1uEX1eO4yYUShHvz89oNMIXtX+
 ZTFFOLebvvLW6qKBdW0QdsDAkULiic9dNvpnFqW2kb0Zrt2ETH0FwVv9gxyWJEmSblFXo6UkaKe
 5OteM3IuclUXzbS7+qPEDPePfUtqz0+MRM2jm322/7zrmMmlGhpKwBGHXeNCeu53PrtYpSb8seB
 P/K3FwLifna3SiVjWsKAdwdJb+VPKQzVAp1tp8kWxvOb6lIyuDyZmqTk0Qh1ntsD5yRBfZlMSED
 99vFTLwWFeTjGlVL97KImrDHRNGdpffBKeLgb6cG9YMVGHLmyhj5QeyFHdgiYkdYBeDY9KrEruw
 08ceciqQ8ORkNU8I6N0AnAImTaZcfaExcO2CdXm+iChvU=
X-Google-Smtp-Source: AGHT+IGy8U1c5cK5CgNTx7+CWUBajFDbxrbBWu2QCrhlMuEJK2sD05bVqLryZVTHjp3L+ObQl9SeNg==
X-Received: by 2002:a05:600c:8710:b0:475:d9de:952e with SMTP id
 5b1f17b1804b1-47726238877mr5601515e9.1.1761760712154; 
 Wed, 29 Oct 2025 10:58:32 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4771e196a9asm60312455e9.7.2025.10.29.10.58.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Oct 2025 10:58:31 -0700 (PDT)
Message-ID: <395c7c86-08b1-4af4-a5ca-012a9aa89339@linaro.org>
Date: Wed, 29 Oct 2025 18:58:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] cpus: Constify some CPUState arguments
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Kyle Evans <kevans@freebsd.org>, Warner Losh <imp@bsdimp.com>,
 kvm@vger.kernel.org, Laurent Vivier <laurent@vivier.eu>
References: <20250120061310.81368-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250120061310.81368-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 20/1/25 07:13, Philippe Mathieu-Daudé wrote:
> This is in preparation of making various CPUClass handlers
> take a const CPUState argument.
> 
> Philippe Mathieu-Daudé (7):
>    qemu/thread: Constify qemu_thread_get_affinity() 'thread' argument
>    qemu/thread: Constify qemu_thread_is_self() argument
>    cpus: Constify qemu_cpu_is_self() argument
>    cpus: Constify cpu_get_address_space() 'cpu' argument
>    cpus: Constify cpu_is_stopped() argument
>    cpus: Constify cpu_work_list_empty() argument
>    accels: Constify AccelOpsClass::cpu_thread_is_idle() argument

ping?

