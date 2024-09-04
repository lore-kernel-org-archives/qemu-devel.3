Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76632CD37B4
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 13:12:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slpn5-0005GE-1p; Wed, 04 Sep 2024 09:11:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1slpmx-0004rC-MA
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 09:11:12 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1slpmr-0001tf-Uw
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 09:11:11 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-374ca65cafdso1690912f8f.2
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2024 06:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725455462; x=1726060262; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Lydw0gRhTGX+NYirz2VKthLPBJw5sipMFb9tROKJomQ=;
 b=ldMgOOsPc+6k5f54vCnDutrJc/bIRCCVDyNPKQI3UiHeKtznxtoziXEsbnWxIIFfXY
 1sX90xwAmoUCv2d9jH7/ftIS+RkMK+1/ZgY+1hlpHa7C+NZKKVxW6pn7FxSs3Xv981lm
 8iDqMWy5GcX7dTsU6ITh0bJEJi6veolTbvPyDDBWkh33B1XeP54N/QskYP0LWMhl4uqG
 Tb9giZ+ErYQfdCvCc2rpdrUZBwn7Z2hSyz6224C5MSna+t44ovj4Qp3wYQZkOmojaBYl
 GVwHkV3rb1+4ZCZAexmkPQ6v6T0M3jgclDNl5h7Msvp/+T+zT50ardFHcEJOPLQkQ5Ra
 Q6hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725455462; x=1726060262;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Lydw0gRhTGX+NYirz2VKthLPBJw5sipMFb9tROKJomQ=;
 b=uNpzYVgxGLGiWYyWYCUFMBYeiSUxa0gAdbGLNx4gWOjn6Av19mz5jVeTic8+d31cTu
 CX5kCXLnVM0WdVoQsDYaxxSdTtO6CStZ5/v0SRR9CLOJ26VuXiWD10QCjusC1+hb78NY
 9HkldxgkS/LbkGZFC1bTfqR7LnmC2mdWDKcfIYEcrZkpcz6e7lsFYVbvmn+BFU5RERNV
 VWULMngtkZVsRpBqdUr87pa7ewvYFVzBYtK7FenW1UAT7rcAO/2e3b4o40KRAhDy5rHi
 NtWcEGopQNk+G9hzBew9uaxjzbfzgDAwOq3HcmOSuG7Hrekj5R2vDKdxkOE12H9FrXEA
 H23Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3gDFOXX/RnzjzVmlAbVyOcrCswSEoIHWc8L0GMv3s1XbbI3arbFHREvAdysnNsWqF/OD+a1rIS11J@nongnu.org
X-Gm-Message-State: AOJu0YwOLgBo0vr0hkiqm/thQTc1g8bn4/zm0kRDaSvA7i/0U+HhtORF
 BWFB09V2nt+gi96HM3XR9TCbarO5kOH+3FTbuU5LKaRnVW4F49J/WUl0IogJtNBT/jkohnBR+qi
 I
X-Google-Smtp-Source: AGHT+IEkwfaAeBESCC06yuR9dtNuIZDGrAYDyZ3xrnbSlyxtN0rK7uGSREyaAO6uHkaK1VybajlPpA==
X-Received: by 2002:a5d:6d08:0:b0:374:cd1b:e10d with SMTP id
 ffacd0b85a97d-374cd1be31bmr5317776f8f.61.1725455462334; 
 Wed, 04 Sep 2024 06:11:02 -0700 (PDT)
Received: from [192.168.1.67] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3749ee4d391sm17015443f8f.3.2024.09.04.06.11.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Sep 2024 06:11:01 -0700 (PDT)
Message-ID: <8c723f1a-a337-46bb-bf6b-2bc3c4c6824e@linaro.org>
Date: Wed, 4 Sep 2024 15:11:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.2 35/53] hw: Remove PCMCIA subsystem
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20240903160751.4100218-1-peter.maydell@linaro.org>
 <20240903160751.4100218-36-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240903160751.4100218-36-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

On 3/9/24 18:07, Peter Maydell wrote:
> The only PCMCIA subsystem was the PXA2xx SoC and the machines
> using it, which have now been removed. Although in theory
> we have a few machine types which have PCMCIA (e.g. kzm,
> the strongarm machines, sh4's sh7750), none of those machines
> implement their PCMCIA controller, and they're all old and
> no longer very interesting machine types.
> 
> Rather than keeping all the PCMCIA code in-tree without any
> active users of it, delete it. If we need PCMCIA in future
> we can always resurrect it.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   include/hw/pcmcia.h   | 63 -------------------------------------------
>   hw/pcmcia/pcmcia.c    | 24 -----------------
>   hw/Kconfig            |  1 -
>   hw/meson.build        |  1 -
>   hw/pcmcia/Kconfig     |  2 --
>   hw/pcmcia/meson.build |  1 -
>   6 files changed, 92 deletions(-)
>   delete mode 100644 include/hw/pcmcia.h
>   delete mode 100644 hw/pcmcia/pcmcia.c
>   delete mode 100644 hw/pcmcia/Kconfig
>   delete mode 100644 hw/pcmcia/meson.build

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


