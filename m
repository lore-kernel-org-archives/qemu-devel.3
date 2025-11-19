Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CDF5CF258E
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 07:50:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLcxL-0007dV-CQ; Wed, 19 Nov 2025 02:50:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vLcx4-0007bT-2w
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 02:50:08 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vLcx2-00034y-8N
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 02:50:05 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-47755de027eso43417775e9.0
 for <qemu-devel@nongnu.org>; Tue, 18 Nov 2025 23:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763538601; x=1764143401; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FJ+QmTMK/yL4WwUPLL+36Dcb1t/YVv83d7fJPKTkS3s=;
 b=j7lU/PCL+WfDEg2mF9yWAFEIkRhE36E8KK8U0roWfKr5lvYlsydmggJZevxsHEx912
 H7lilk8SQhGI+eR6e8u6JjBlUj/9US3olPURHhDzjpL26yazttpkm7klImjXeAR/xKuu
 ak9FLScH1daqLb1eamlS1MT2iLFIhSmNNPyJKj36wwmUjgEjYmGI/PVhDggSrdakdemK
 ck4N0JBpzAk1HdFmdgYLE1oXolZhAV64Kw2k+oHF4OZFkXA8gx2GEQK3JIxQ57/8/O0E
 p9aEKq9b0/phoIyECuAxncI8vlv4KteuwqiHJ1SvLyv8223JUkCZeWfZNmZjU6xTBYGv
 irZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763538601; x=1764143401;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FJ+QmTMK/yL4WwUPLL+36Dcb1t/YVv83d7fJPKTkS3s=;
 b=OSpuP+yVcSKeVUJzn4ApcaK2P14Z8MvYc6F/7QPp/mFjcGQJnhxDOYaFVF0eO1FCWJ
 G1TaI3W4IChvyTT1m1kkMLkhPsHjN7gu+uCnYG+WkWrM5BKhsemuWBsyQKxmbdhgTPkl
 P43Ch6JKvl3CAtC/DgVq+CUfEmkFAFIKNWltueWsBscCvFrUws0MJ1rP/GMIDH8JbgeG
 Hy1dx2b6pxCg3PBLYYcW0cdMVtfqYUkEaDgOH5wnDPFtudQzedl24Y2oHW4r4GhIxhsE
 wJamnEwYTbrWkPDT4sGnxgfUQwDC7Bh4n+T6bqOLJRrS8IbxBLOrCk1a/m5xX9RuIsge
 HD5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUT/Af8nbBLFcvjSupQFyXOyLRZtJu6Oj/nv+vSR2vt5IX+rccWcAzQsIo9UiWIfzyjKg79WH6zttmB@nongnu.org
X-Gm-Message-State: AOJu0YzW5VqHK+7AF2fklr3RgixFb6NT+Wt+voPoLy12doe86y6NpDSt
 SNiSY5qvu8/KM8GJygMMRl+klr5dfVAFSKrKxTvC3B8DYyx0sXHaUtiqdZD92NnDjJo=
X-Gm-Gg: ASbGnctTeiI/zKrEoZ4LRy4YRmyFf90inbTIIyiMM57ZkiFRqHIsQQx/WbQlVV6ZM7q
 1wCAy1ZjD6WwEDrd7klxZsxFhrIeeftHCB5hlX1Lg7Wuif8FVNkzk369YBM6DMT/+btzbtY0rEw
 QtvOGPfqpKOpVnC9nHD3NzXJpgsoIpQ0pIe+VKEJ1vY2FRlGHUgv3wGvDinaEc4tNtsK+V9fa7T
 IBO/GiuKhAPGVfaJ/gu4P+XWY1XZ59BdWfVK4xn2LDsjhizB0GlK1aD0204es1M9pTWGu/jG40W
 FshsZ6PIW9sQptkQHml7UNE4qObN7gNRa6QLBKsJri4l6wZlQgqSgSyUj9yDiYM60sR9eTpZC0L
 q8Uuq5Vd8M9R8iF98q32nF2M5aB/ksJAvVk8RGDnAbnBoBT4cEuS0+Ae5/34EMIUjaxwZoD9j3z
 5Mk7OFAi3eXG9UIsjFj5KHms1aHSleH23T5gusk7eCp3tEp//mSXKUwImff5OnE4I/zbAQ6NK+V
 04f9g==
X-Google-Smtp-Source: AGHT+IHlHYPZYZ/A8dlSBOApFfINloS/UkSxz/qceUhwqiN5F3xbDyOGt7NibTP7G79oxS8BR10B0A==
X-Received: by 2002:a05:600c:3b12:b0:46e:761b:e7ff with SMTP id
 5b1f17b1804b1-4778fe89ed9mr150826425e9.28.1763538601238; 
 Tue, 18 Nov 2025 23:50:01 -0800 (PST)
Received: from ?IPV6:2a01:e0a:ed5:b1f0:90e8:1fdb:2cba:9db1?
 ([2a01:e0a:ed5:b1f0:90e8:1fdb:2cba:9db1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477b1022a32sm39203225e9.8.2025.11.18.23.50.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Nov 2025 23:50:00 -0800 (PST)
Message-ID: <0820f522-1174-4a92-8f4f-168511d959ae@linaro.org>
Date: Wed, 19 Nov 2025 08:49:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 09/10] tests/tcg: added test for MTE canonical and
 NAT
To: Gabriel Brookman <brookmangabriel@gmail.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>, qemu-arm@nongnu.org
References: <20251116-feat-mte4-v2-0-9a7122b7fa76@gmail.com>
 <20251116-feat-mte4-v2-9-9a7122b7fa76@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251116-feat-mte4-v2-9-9a7122b7fa76@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x331.google.com
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

On 11/17/25 02:40, Gabriel Brookman wrote:
> +    p0 = (int *) (((long) p0) | (1ll << 56));

mixing long and ll is sketchy.

Best to use uintptr_t anyway.


r~

