Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B499F5A8B6
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 20:03:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEuqD-0000bM-Ky; Mon, 20 Apr 2026 16:03:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wEupz-0000T4-9c
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 16:03:19 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wEupt-0001eI-CT
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 16:03:14 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-488b0046078so32488865e9.1
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 13:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776715392; x=1777320192; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HB7j7ONsO2JINaIpg/4OsvbKSWkJNbJ/sojJRttqg0s=;
 b=OuYnE7JIU+k9bcov8onORy2uaxDQgbMf4UPWVuVPLcEWiMBud6eMx0+eW5qDD24dgQ
 FTVkaGu3QEGU9FVv3V8tETwM0rN4+PMPDE5t/CDDhObQhOK/Y+J7bQYQptUMf3AZM9Ua
 ueg5hjNuCyqCYrwC+JwWLpnjinP3nP5+9obuP/lvpmNnYE1llD/mkMUJ5TtE4j3xqK5u
 btHPpB6aa4eh9wQx0UqBVwm/3fO9y9mMv45zTy0DjLre1ieIIjghdFTi7CwZMi/LPEBl
 5fLsQs5G174D6sR3hEREsAVT+csBPiuDZAh2Ceouy+WMcKVKrCoelajLCe/uNw8p72Ws
 QtYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776715392; x=1777320192;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HB7j7ONsO2JINaIpg/4OsvbKSWkJNbJ/sojJRttqg0s=;
 b=jRVs3cFhG16noHbZ9KgKIfyhp1mrBnbuhGnj5bOF73HHK8ELEyFrGdr4fflKOvTvjd
 h0kc+clUNHc4wHxlTfK3eOIpIPBpITnUzPWFXsiLE+5+gJHbm95kIS/PHUWUGiUl6HcO
 7tduCeGOgWsn2kRDpOXX5z4earHGSICJHQXT5Q+x0a1V3Ktqrn7hShxi6JQLOYI5vP8I
 TJPQrCbMZZcumcvf1lfLglVKdBsCn4EUhgs8Phg+oIttAjhE8MRKB5bgTd1cOt+6ClMr
 SFw1cd2PT4eA9YsPbS5HNMqZx5imnFAa5KbEAIJ/p2LX1GIPVb0sCGeqIR6M8S2YiF9s
 16Nw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9v85MCCSMhHf+/zZ98hAjrqgK3GJXf2mXDFKZ8EIc0/xX6npaw4GkguoH4p3mSBpgTL5ev+3sejpxH@nongnu.org
X-Gm-Message-State: AOJu0YxhH8pywByAJHEZniJd111xdsJL+P4ImEsK69RxrjOiUKQ+Yie0
 iJUScEqv++tTgVVFSX3GTECU3jDT8DH5F0hMaw9YbaZcCWvytfFJH0MWxvX2faAk5zA=
X-Gm-Gg: AeBDies/emcC446/Kea6rNsNZG1hW/S9CxPGfcNywcRgcHtogM/5XRRXREyQrLkwBp9
 4L2ko3UJRD6X9l04CSDmBZtDC4WZxeelp3/aUMBCcJE1C13Sc2V13mJOG+OYVeoHYmNtYrkUR5X
 dzzFzaxZwp2zW7z3aTvWupLIggXV7j8TKN70l2bK9iJA7rKEpp1+KMMqaODAYnByOYZ2qnOIYP6
 rXRBrG/592rCSPPb+HFDjHN3boyuVtfiAKTyVdr1fxGljb7ahb+zfURdIE32dTlmBO5NK0oZeeL
 V+DQGb2pj1xDi8hDSxckjb+M7SmVFO1oXN3Sf+dSkM15sq0FsAhGn/CltnaW1KoSJCWWvWy6Z9w
 2gsUoJxiDc/gsckuFF1A3RJpDeR1ihnT138plOxZt7giSE8HFHtZ+HOfJE/P/9tMSDBaQ34a3Kp
 JVcvuHcqtG4VCdFZt05RloVYhu8oc1V+oxJwa6pwFeQm/WbsW1r5gMoQI1wgU4/6Rq2di0Gzk5Y
 mgA
X-Received: by 2002:a05:600c:8b8a:b0:489:149a:f9e7 with SMTP id
 5b1f17b1804b1-489149afa2bmr107133295e9.27.1776715391735; 
 Mon, 20 Apr 2026 13:03:11 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc0f8188sm329813745e9.2.2026.04.20.13.03.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Apr 2026 13:03:10 -0700 (PDT)
Message-ID: <b2654ae9-704e-4e95-b51d-2408fdacc2ba@linaro.org>
Date: Mon, 20 Apr 2026 22:03:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/virtio/virtio-iommu: remove duplicate include
Content-Language: en-US
To: Osama Abdelkader <osama.abdelkader@gmail.com>,
 Eric Auger <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
References: <20260420163050.321668-1-osama.abdelkader@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260420163050.321668-1-osama.abdelkader@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 20/4/26 18:30, Osama Abdelkader wrote:
> qemu/reserved-region.h is included twice
> 
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> ---
>   hw/virtio/virtio-iommu.c | 1 -
>   1 file changed, 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

