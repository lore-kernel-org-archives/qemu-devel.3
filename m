Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D1B1C54FB3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 11:48:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJWJC-0006yg-9Z; Mon, 26 May 2025 07:47:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uJWIx-0006x5-C7
 for qemu-devel@nongnu.org; Mon, 26 May 2025 07:47:45 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uJWIv-0004hY-EQ
 for qemu-devel@nongnu.org; Mon, 26 May 2025 07:47:43 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3a4dc0f164fso512366f8f.3
 for <qemu-devel@nongnu.org>; Mon, 26 May 2025 04:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748260059; x=1748864859; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=B0UJsvc1+ALrk4fF/5yuavqKWybj/ok+fhSZ+b/4LvQ=;
 b=Qt3+jvtfY4b5ox4FQBrWioOpG/vLXELDh+4PquzI349WBmRhsk5LGr5S3dpLC+RIcU
 b0bWj38467kraDVTUyRtivXTp51EHoMjH64+jENYUzoQTLPGDyjxMr03j5DFO+pzHIpT
 WxDB2ZfQzWSvQN2fmymPapsK6UoQYQSWMRpRlaQMnX12Wag832BACGLykXBJWNbBKP9w
 SbSWKnPrJdNlx2iT48/e7ftyhTaAp5aqsbeq0wvXF5l3g/85KH6K4oZJZPwBBStDk8Ig
 4XxQORKRA9znsF0xxe1BYZcgo1OcOLqio03QFiVIgjtl4n2AjHeEzGmhYTPfq1JarR6r
 mbeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748260059; x=1748864859;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=B0UJsvc1+ALrk4fF/5yuavqKWybj/ok+fhSZ+b/4LvQ=;
 b=o3nrRw3DGd2pgAlXPneWOqblmo6+Lily/86FbiD1Isy6wq8o9KOUcU+y16a1kTi0qA
 l1ovqdkuYEiMn3ev8Zy2VHMe5bkOulBIVdl/3V9GTS+v0aouJjRHoTx20qBK9LXE+xla
 ysKRm5MpOLJSKWBkIXa17u6n7kAFI+CLSGkTqS/DiRNugyv1MJ+b4JWIA92/21D9mj1F
 JGoWhvqChvZd9s6gcLMIdu71eN0j+30zlcASis4TuvwAMfWekYajAQCNC9MlsLOIhoVq
 kjQ0SW76T8dbk14XamI6zeX9fhdyfQ6xPHEQjoWAnUX0ngOzGlRxlC7JnyzeQREIVQel
 oVLQ==
X-Gm-Message-State: AOJu0YyEBMEoMebLYnhX8o4MflEKBCUeTQJCmJc0DbvyhESHj8j8kXgW
 OMy/NsOAycaV7Fe4GVlDWfSBwB8Mwc6K76/i2q/vzo6ME93t4IdyUs/OD3EW5CMP2xI=
X-Gm-Gg: ASbGnctHBFByAx/0qyYxgWuxaJa5xHPGWrso/Bb/v83RJK7j/HAe9+wbSHtz4rEgv3U
 gRwFbAge8qxgjCugYgGZNfscEZmGClOFI3486r4pDLaw6yLvvWRhqzISWEsmVHEC4tJKUtEMUN4
 SF1ngt0N2xKA9COcL1XcsC/n45/bZJe/8WGdWsojlv43ziE1aFCvUCI+aYhdRr7ZNrJVc1ylB6B
 OmgoIq/49yMeuzaZpRXLy6efBGbGvCzV1QXz5UZHIvEEopbZy9JM271njkhJPRL2amKGiOBtRkQ
 9hBoHqpeyURAcdc0HjKpPnvOWrhzJQ400PQsEF8d7aT9Igxy72BRDbvpfaAKPI/FH+XftnF0TCy
 3W4IghkI623voZFPaC70y0kdx
X-Google-Smtp-Source: AGHT+IGnGw0QDlccaPAPAShxxWmZQYunDaTHRF+NvLSFNEbUYRo6vZeIRO17FHC/cxxj59Ig8awPyQ==
X-Received: by 2002:a05:6000:4027:b0:39c:1f02:5409 with SMTP id
 ffacd0b85a97d-3a4cb4619camr6103639f8f.9.1748260058842; 
 Mon, 26 May 2025 04:47:38 -0700 (PDT)
Received: from [192.168.69.138] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4c73a4284sm8779513f8f.85.2025.05.26.04.47.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 May 2025 04:47:38 -0700 (PDT)
Message-ID: <5bb32949-e72b-406b-89ea-92eb44484beb@linaro.org>
Date: Mon, 26 May 2025 13:47:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386/tcg/helper-tcg: fix file references in
 comments
To: Fiona Ebner <f.ebner@proxmox.com>, qemu-trivial@nongnu.org
Cc: qemu-devel@nongnu.org, mjt@tls.msk.ru, laurent@vivier.eu,
 pbonzini@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net
References: <20250526114447.1243840-1-f.ebner@proxmox.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250526114447.1243840-1-f.ebner@proxmox.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

On 26/5/25 13:44, Fiona Ebner wrote:
> Commit 32cad1ffb8 ("include: Rename sysemu/ -> system/") renamed
> target/i386/tcg/sysemu => target/i386/tcg/system.
> 
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
> ---
>   target/i386/tcg/helper-tcg.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Thanks!

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


