Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7CEFC02181
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 10:37:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taY6j-000453-Ec; Wed, 22 Jan 2025 05:37:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taY6h-00043h-KZ
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 05:37:11 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taY6g-0007og-43
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 05:37:11 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-435f8f29f8aso48049045e9.2
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2025 02:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737542228; x=1738147028; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JClirEZhGSs2HNw1ii7DYoOZ+9JhtZcsAi84vf1O18Q=;
 b=Wf/60l3YYa6AGrBKvDme7dC03QC9WAez2Xx2yA4URcRdBOo6MeuxQqUoFF5qJSGj9Z
 pDwppsuLZMyZg/kFwPBh4xWns91Jkhga3TY3TqZTehbJmdNOyurRCp84lapLKCJvxFJF
 Gj6fhvE+aKFT+aDgT+v2OHRfMqAoMsbwUEl/9HU7+ZrYtbimon8Ly7BveDXZ8xl2TqiI
 KLU0tP0kiH5hhr2etQLosEH1Kaj+GQtJ0kaBpGWGIZPBliAnCdAfESO5/ZN9iAoqAZl9
 YbR1dU2/rCvJjMGLT11Qar2uM+lFqEeb7DAAlRQmIiqLzTTv1L+pT1rkC8SbGdtpkPNE
 oHCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737542228; x=1738147028;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JClirEZhGSs2HNw1ii7DYoOZ+9JhtZcsAi84vf1O18Q=;
 b=QyhDROTzysnWELJmAIGqBoPxCcwo37tvZ6DjLJ9fDvIHzBAOh4d7AD59XLJ+8b1oEE
 eE+SBcmdhsEwjS93Beo0bGlj448/95pBrESvLJ3kD7yjG9jkGwthujiaYEGt5cW5RlCB
 svFgOkYJIvi+47UHalbI2x7sztHn8iHQ10MbscofXNUcVOCpywGmHn1k3xS7ud18mwXO
 R+xnCfGRolYGUEsfyhiokRy1Rs90wYeO/aVVnEg7ZCKcK8f1xPC4e8zFQTXWrznsEi2A
 QlNveN9yz6MDk4zyNe8Qe8hlRvMkDFHy+vEWg0uhILTaRHGHsWDCZ5hQV5q2dGGsjFFq
 8YCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDqzDmNyBGBjEMfVNmoFywErcI32Nzugf9P3A5JGhy6BIxUkJ93j3xi5fv+8tcczuExpYDcSFSaKwM@nongnu.org
X-Gm-Message-State: AOJu0YxkXtewRN/O83nBgNibrITgHzrWa4939ivZ82kVrr/4G24ZILyq
 rXHOPLrF1h4SacpDmm6bKgE/A78sKPQ5QBQ0RDS1vjB7D877c1V4OhrmQ6hoh8c=
X-Gm-Gg: ASbGncutFiyblJkinZ1abtShesCET+JrPYf5z1wAg8MVNN1Opi8gLhcg34ftuvDYRuZ
 yXW2QDTS4U67wfDgyEEUDE4No9E9aYzWipQuUzoe3sRTSLwCYe4oCoNHTAaZUP5sDiJFTHwqxnt
 r7ezf/vUCeNdQ2tmt1KrnwngG3SUVxRj+jxT7h6m0aBPN/Z4XBg6hmzJ9odv16tl3Wg0FUa/3DP
 W9qzGTsLNhJozqRlqSO88HQkn1nxWh0i//VvhjvBjJI6P1o8UlkAIOHKBhC2Pb2eoI6qDcvKpkR
 P8JDH2W35qmCa3IdScNqQ3bsEp5EbsWsnPGF5g==
X-Google-Smtp-Source: AGHT+IEi14KAMMW3sfrZXONjud4kBqwnOBmFJqbWs3flgkvoIVrOJNAAad5R3xY4qo+hTqgUQ7RezA==
X-Received: by 2002:a05:600c:1e1c:b0:434:f0df:9f6 with SMTP id
 5b1f17b1804b1-438913bf655mr203889315e9.3.1737542227865; 
 Wed, 22 Jan 2025 02:37:07 -0800 (PST)
Received: from [192.168.69.181] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438b318c004sm19605455e9.4.2025.01.22.02.37.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jan 2025 02:37:07 -0800 (PST)
Message-ID: <e8ba79eb-824f-4c9b-a224-026d5a3daa1a@linaro.org>
Date: Wed, 22 Jan 2025 11:37:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/10] rust: vmstate: make order of parameters consistent
 in vmstate_clock
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: zhao1.liu@intel.com, qemu-rust@nongnu.org
References: <20250117090046.1045010-1-pbonzini@redhat.com>
 <20250117090046.1045010-11-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250117090046.1045010-11-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 17/1/25 10:00, Paolo Bonzini wrote:
> Place struct_name before field_name, similar to offset_of.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   rust/hw/char/pl011/src/device_class.rs | 2 +-
>   rust/qemu-api/src/vmstate.rs           | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


