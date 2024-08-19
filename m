Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40EA3C52D7C
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2024 08:46:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sfy0o-0004z0-84; Mon, 19 Aug 2024 04:45:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sfxyh-0004qj-2r
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 04:43:03 -0400
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sfxyf-000579-8H
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 04:43:02 -0400
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-5d5c7f23f22so2565236eaf.0
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2024 01:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724056978; x=1724661778; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YFZXflIC6w+8NTmWZWiIr15r14a0IQtMl8DADI0F5oI=;
 b=Ivy8/zi92r4c/WELdHwTqKyPWmgqiBK1qHblJcIe0c408XksjISO1iaWSMEP773uhr
 YX2ystP23BwHOlxQCB/jhZaOu7zMo0Y/lKigFTGMFuRdKnhii/VpQtn022f0UYABW7KO
 S7yEIXwmG3CkWoX1mUQbbfXfBiHs03/VxmuX3mJMSDz+cKOZVjHVtOq4tMOJkyUzjJCo
 o8Rz0CmQ3weaHB6sMVqgkuHhKDWx9hrOTo3hejFPIrviA/lVsaLb3+6jlGbK6tKEhvvu
 Et4WzWG7ez9MDWzqxnxOeiV/GBrFd0yOu4zyiGnkPiy5R4gbbssGhj3e+33hr1HYjNyC
 QKrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724056978; x=1724661778;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YFZXflIC6w+8NTmWZWiIr15r14a0IQtMl8DADI0F5oI=;
 b=d6Rm0Oj9qjzfDP1c5OFNlJ9o695blxtc2MKvVK45UPCAPCb9FwEMgxXNe+x+og2DhF
 4o4kFobin2lOPycfzZbFeCFOY+co8oW+3zDRXuaRfzORpbkjoN4xQbEdaH582ZE7nIJN
 gpanDqMTCLMMZ/2tIEr4m1144SvdnjeFv2pRJi9vT75vveKRaQDYCHwXfEoTjW6dHyyU
 1Kg08e17Zns5Is+7LzaAF/UthuOm8ISqpVaBQiv+/Dh6V9KcLQhFZolR1CMP0lnb8xyZ
 ZDGxPk/slicATRRAgzFO1no8vxSBOPiDOE61fznhY87asOuC78RheveIvjkQhd9q1dN+
 2gWQ==
X-Gm-Message-State: AOJu0Yz4/mmtG2GA909UQ/aYvcAjeK3XQiVY68k1N6kGPst9BTnLEG5N
 /yCTSvZtsn9sLtXlkOlyUIJ39bl7wz0x4PPuYUqtpwdUnz47cR3Uzp42wClSRYjbfVXKO39rMQH
 U61g=
X-Google-Smtp-Source: AGHT+IEjgCJjIBAepH8z+lD6GpwDKo1a9T7a/KBIHN1KwbIB3Z0MOdPNcwL93cVD0yl7eV7ECtizEQ==
X-Received: by 2002:a05:6358:d28:b0:1ac:efb0:fb33 with SMTP id
 e5c5f4694b2df-1b39329f548mr1486219055d.20.1724056978199; 
 Mon, 19 Aug 2024 01:42:58 -0700 (PDT)
Received: from [192.168.1.113] ([203.30.4.109])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7127add8e41sm6195908b3a.24.2024.08.19.01.42.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Aug 2024 01:42:57 -0700 (PDT)
Message-ID: <f39e476b-1db4-423b-8e40-d7a96b469be7@linaro.org>
Date: Mon, 19 Aug 2024 18:42:52 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hw/riscv/virt: Introduce strict-dt
To: qemu-devel@nongnu.org
References: <20240816160743.220374-4-ajones@ventanamicro.com>
 <20240816160743.220374-6-ajones@ventanamicro.com>
 <CAKmqyKOXS+Fmb1Jxzwh3fAkeKi5eXQZ+JKkc3H77XjKrrKXe-Q@mail.gmail.com>
 <20240819-2773526929f81da7a462d10a@orel>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240819-2773526929f81da7a462d10a@orel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 8/19/24 17:50, Andrew Jones wrote:
> I agree we should deprecate the invalid DT usage, with the goal of only
> generating DTs that make the validator happy. I'm not sure how long that
> deprecation period should be, though. It may need to be a while since
> we'll need to decide when we've waited long enough to no longer care
> about older kernels.

This is the kind of thing versioned machine models are good for.

For instance, for the next release define virt-9.1 and virt-9.2.
Set strict-dt in virt-9.2 and reset it in virt-9.1.

C.f. hw/arm/virt.c, where virt_machine_8_2_options invokes virt_machine_9_0_options and 
then adjusts for backward compatibility.


r~

