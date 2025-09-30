Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98696CAC5B9
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 08:47:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3W0P-0003DN-D9; Tue, 30 Sep 2025 04:46:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3W0N-0003CE-2D
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 04:46:39 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3Vzy-0007gS-Rr
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 04:46:38 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-46e33b260b9so9593165e9.2
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 01:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759221968; x=1759826768; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lZvsoaMcpg3aXN+38dOlnVqGpH2jNFFzXHa022Ew8zM=;
 b=nUHVjczkFfmqQkiMIC6viXbgcnuo4+OotkJk44FJozfCCk0EfLntRBjSKtL0eeMBtY
 rv4JJDBO22f05znKwMexYiB80qWkF1w2UfsqZaSqmgvkQAEWWGj+ZSxCMC2X9tLfwXAM
 6YvVeUtZiSmY5gY8bctj7y+w9fKeRSU5QZBS2RfxxuevPyw7A3eaEis80kGDlcLibzhp
 1EsgJu4IexMH2Wc1q3pE2aq003yIWVtKIi6hhYZtHQD6JrzFyFQlSVJ/ac7nmEMHpzIy
 YHjJubu63yd8d6FYTcRdi4ZFI+lBpHoVMVI6BiN1nhcrZvz6ty7836CDR7airVihMVh5
 /ckA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759221968; x=1759826768;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lZvsoaMcpg3aXN+38dOlnVqGpH2jNFFzXHa022Ew8zM=;
 b=VzDgdrqxsDo+Xk/DvGe1A58YRqfAv3gCQ5Cb45MdECzNJLwoyc7UedrRQYHxsk5Ibf
 LpPr0hwr/+kqcsRzqjy1p2PBBtHjQk9H7zTqRpOD/0cQjXR23kmO9awhfb0s1eWeQotf
 wWOOpLMenoaAS6bF0/KmUhuNbhsZ0nI8i3sC0c5t1jeZpIiggr+0J+jst0sOdmu7GN9j
 zuNr2Nx3HaR9Mdc8nmbBiXuOiy+uejcUEj4WBXcZY11jcx+mGzAMFr20L9rOOZZfYgPc
 MJTRtqLcCyyb4aHHVyE8UcRNrTf6hFdJnCGWrynbAlAVHy5MC1sNP7H4aS7lmNod4I/2
 7hNw==
X-Gm-Message-State: AOJu0Yzuzhhh0DsPOGcPPv+awryJXCr9cOrCPhiGFMokAp2oAsPBZPaT
 ZO5Z0a6IrTt9WNL8G8YytOH2RfapMDF4WDnQDouJuXTT8Jus5J64+4uLQO2b3Xa3i+rx+K2xp8z
 szRg+g5DP8g==
X-Gm-Gg: ASbGncv3LEcQ9gn71QoEzh9Ygcn7Px/CsnE8kIp7wh2ArqyktlVw2GOAJySePatqAbz
 4uQ+AAllXE3fswdNsKbottF0Uiy6OLEmtunk0PpRWtSHBSi6YyWaMBXoeKNeiCY/g6K78GXnc3o
 xTCQy64jR032+Dc2XFZ1+xMYcR+WY0MzAJuNppexftfdK4Njt3k0di+Hkqnn+rhXeIocrljPjUA
 HFb7oegkSnCorWii4B7+7FbcsRpEFMDi1eY+MgN0HCR36xjfFzwn5cTwMIBIREPMseF4V4VALrA
 3CUYI0vlM/LQJqZlMHxJ+pbNnBVymm3KDY1sRmaLAGwg/AH5CXdc/Pf+dBOO9Y3H4hJF5Xp38BF
 2hwC1T+0yQtUH8J2hJZSpoP5sz4QqKlTo0AkKNG0DZTGuHI1ndq5COlGfJfWfFGzlSn7yG8GtPw
 tFSWQLsnf32bD0ak6PzoiAPqKg
X-Google-Smtp-Source: AGHT+IHzjKmdl6sAtXGgcTTj3dCVGV2Q+lE5eKjeBMRW9owcVoHCjBBPpwwxJ3cQprYBK+W3P72PKQ==
X-Received: by 2002:a05:600c:3f07:b0:46e:3e6f:fb90 with SMTP id
 5b1f17b1804b1-46e3e6ffceemr140574625e9.28.1759221968412; 
 Tue, 30 Sep 2025 01:46:08 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-410f2007372sm20913396f8f.16.2025.09.30.01.46.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Sep 2025 01:46:07 -0700 (PDT)
Message-ID: <6ac11401-03bb-4684-83dd-f84b4c10bb87@linaro.org>
Date: Tue, 30 Sep 2025 10:46:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] hw/vfio: Use uint64_t for IOVA mapping size in
 vfio_container_dma_*map
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Thanos Makatos <thanos.makatos@nutanix.com>,
 John Levon <john.levon@nutanix.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>
References: <20250929160807.73626-1-philmd@linaro.org>
 <20250929160807.73626-4-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250929160807.73626-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

On 29/9/25 18:08, Philippe Mathieu-Daudé wrote:
> The 'ram_addr_t' type is described as:
> 
>    a QEMU internal address space that maps guest RAM physical
>    addresses into an intermediate address space that can map
>    to host virtual address spaces.
> 
> This doesn't represent well an IOVA mapping size. Simply use
> the uint64_t type.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/vfio/vfio-container.h | 10 +++++-----
>   hw/vfio-user/container.c         |  4 ++--
>   hw/vfio/container-legacy.c       |  8 ++++----
>   hw/vfio/container.c              |  5 ++---
>   hw/vfio/iommufd.c                |  6 +++---
>   5 files changed, 16 insertions(+), 17 deletions(-)


> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index 9d694393714..b5af3ac174c 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -15,7 +15,6 @@
>   
>   #include "qemu/osdep.h"
>   #include "system/tcg.h"
> -#include "system/ram_addr.h"

This header must not be removed (yet).

>   #include "qapi/error.h"
>   #include "qemu/error-report.h"
>   #include "hw/vfio/vfio-container.h"


