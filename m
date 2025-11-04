Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5923CCFA04
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 16:53:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGKHM-0007wF-6c; Tue, 04 Nov 2025 11:53:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vGKG9-0007JB-AJ
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 11:51:56 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vGKG6-0005ox-UZ
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 11:51:52 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-641018845beso318951a12.3
 for <qemu-devel@nongnu.org>; Tue, 04 Nov 2025 08:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762275108; x=1762879908; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4xw9jV5dUzwgWaY3RhOJnldzK2ZbH/nthsM2NH1c714=;
 b=wlT6h1HKFs0zvEgjE80s3TY89aiTC8p2Ir2DxCJDYFFYKiZsO/3VDrF1FF32FxzP1A
 Ybfx3DwC9LtP4gIijjN4n8UilP3Gsihn3S8hjRU8ZqaHwfMLutt4x7ucmWfvPOBZUJNu
 OELUgOpJCoJaQ17jNim4Dq4Ky0pu+34vaNu2aMv2aDiL+6DqW9sYGF3XfoEwc7IIVrGm
 vPJkHrvT2WAdv6a43hlOPiDpu4sYdnhYT1qbTO4fFZ+JtNvl18G2bmgS+QSVGbHONm2O
 q5AJQNYapLcVV8fufOtDx93peVKeANSj6jB/mdd2eVEUbeiljpvTV6fmtmub6JQDgfXs
 kb/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762275108; x=1762879908;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4xw9jV5dUzwgWaY3RhOJnldzK2ZbH/nthsM2NH1c714=;
 b=TMLA/UAzDUhDbtd3bLE1Vd/yWWjXmBFHoHU4L9aONm/SIBmUtJDZPoekvS+VZf8uLc
 fuJkLsF7fAVlva3LoXD/at8CJDtB9wFcdLVlVK6vtVASoZ+dTKo9IkmH0l6WuN17KmsM
 8U8QvI5UBlYvt7Wxs7fgYK+Ixa6bMhAW5zfsbDM3ylrZP/LpCL8Lx0HSi4QRUrAEwrGL
 8OyJHUvL+Kl/HLPUM2N1yG2/qyCARjJeEExwX2XnBq9RqmprHCGYu4w/pRkLQnq9utJt
 nU+ovKTLrdMAuwBprcw7R6cfY3SEgqArknObaXiYj2ytonWhAgbgfZrIdS0bZng+JkJ3
 Oghg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGk0O9l3VwFVRvKU+v/axinnvPbq1LxWKBKyYAN4ZzbtRpy2QdCsc7YU8YZM+rPuh3XPyONkirP2Cx@nongnu.org
X-Gm-Message-State: AOJu0YxVfY8FUdveZefWaxU+2UIZRAqMsMyXVVNskKealwOR9CX8K2kU
 0ctwhvGy/E3kpLZiz7oiq1GBKhTfz9MJZRiPHlv9MHW7iuczxz1t0iuqyiRWRD/TEKE=
X-Gm-Gg: ASbGncu32fzf4Tx/kfSSxRmPnr2lM/1VqHbUhbkvWgUjAYGIErGO6nYRfXBqsz6M7Bd
 8FspS6BXgCJ3CCSBgkpu6IlBQP7jw/Nx6S1KIYuYIbQWffcun6MfISGlUvevN45wBPu+t7TTUWK
 fv5KBHpd+wq2fsbIRKmRXglHsErMnZXp3ytp/aWmMlM25BfX/pBLpFgXfbAnyBVgM93xj8491hG
 Twxy/hC3VJw0gbZKfafzKp3JDwoBzWCwuO0lp4UoMxJT66/DI8oIx4klrC9c32Yx6deAqZiVlO8
 HwOUPo9thkKMWpVUzV/Ap0StAePqXBFkotsqVgOi65Art6mwjstGDOqvuwHiq+gBeFXHgsBtiqh
 dOwa24P01fr94tO4bV4rX5r1piNcsr24MSep40IQGISKGTXVHjPZodQvh7B3IzjXWFRz1FAcjFg
 SZNzdUlZ8xblZN3gR+ZNQ=
X-Google-Smtp-Source: AGHT+IF6TzSwUuowCHHeB1tMdgxFRXf4H6WQl1JUJPJZQzmnpaPWJ8R8JxG5rD/zpjmJaHTRGOKSZA==
X-Received: by 2002:a17:907:a4e:b0:b6d:51f1:beee with SMTP id
 a640c23a62f3a-b706fe36da8mr1619239666b.0.1762275108409; 
 Tue, 04 Nov 2025 08:51:48 -0800 (PST)
Received: from [172.20.148.75] ([87.213.113.147])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b72404470e9sm249483566b.70.2025.11.04.08.51.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Nov 2025 08:51:47 -0800 (PST)
Message-ID: <65e5b3d5-af01-44f8-8fa5-480ed3f91e47@linaro.org>
Date: Tue, 4 Nov 2025 17:51:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] vfio: Clean up includes
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
 Fan Ni <fan.ni@samsung.com>, John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Alex Williamson <alex@shazbot.org>
References: <20251104160943.751997-1-peter.maydell@linaro.org>
 <20251104160943.751997-9-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251104160943.751997-9-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x534.google.com
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

On 4/11/25 17:09, Peter Maydell wrote:
> This commit was created with scripts/clean-includes:
>   ./scripts/clean-includes --git vfio hw/vfio hw/vfio-user
> 
> All .c should include qemu/osdep.h first.  The script performs three
> related cleanups:
> 
> * Ensure .c files include qemu/osdep.h first.
> * Including it in a .h is redundant, since the .c  already includes
>    it.  Drop such inclusions.
> * Likewise, including headers qemu/osdep.h includes is redundant.
>    Drop these, too.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/vfio-user/container.h | 1 -
>   hw/vfio-user/device.h    | 1 -
>   hw/vfio/pci-quirks.h     | 1 -
>   hw/vfio-user/container.c | 2 +-
>   hw/vfio-user/pci.c       | 2 +-
>   hw/vfio/ap.c             | 1 -
>   hw/vfio/container.c      | 2 +-
>   hw/vfio/cpr-legacy.c     | 2 +-
>   8 files changed, 4 insertions(+), 8 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


