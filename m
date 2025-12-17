Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BBE0D66BA1
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 19:44:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVxRq-00038M-Gy; Wed, 17 Dec 2025 14:44:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vVxRo-00036U-V0
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 14:44:32 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vVxRn-0003Xe-Cp
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 14:44:32 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2a09d981507so7795645ad.1
 for <qemu-devel@nongnu.org>; Wed, 17 Dec 2025 11:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766000670; x=1766605470; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cR27yWg/Jn5aA69H0d50//PbOPRGw+GHliD6/H6qm/4=;
 b=Atft6YuMVRMw9sM+N/oraiNNXfREJ2RfPcLy5tuNL64gaJsT7VI3IF3yG+8oHaMpCu
 KyoEKlhkmiMKhMqZmJlvorebA5P9HcG8CxTVgy+RCp8SDE0Lb9y5mycNeLnVwf5szd3W
 WH+zjZE2Q/kADu4cnY8Gw1IfmR6U/KA90oZIvaz5hA6D1dAx5RjMRnnXv4JHd6NEoyOJ
 WyP+6tk8RjEKwBRosz+scBtaVKiRoKYdz0gIUsMdUomiYC+CamsYSXc5KJOnnj1suZRw
 d+tQtFqyc5l5NI/hrcPFwUX1JKuy4JN4qCuctHZnHW/bCTwfdvI6uZwd1owflyRt6vcB
 Q6gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766000670; x=1766605470;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cR27yWg/Jn5aA69H0d50//PbOPRGw+GHliD6/H6qm/4=;
 b=FLP55Va712btHAE25ylIJjPhNQGxrRZkzvuGK/MUupa77bj+Fs4Q6VdXMG4Q3DW48k
 G6L0NHXHzL1HfZM1B01H2K5BHYsQRnW31zm94K9odthIGfx3AVYslpBPqsIEwXXqJfFu
 1QvTNuHRNSodFWsRmLP7jo3kxQ61jjSDeTz67/mOrbsDZqF2TCwxG9iSVheYZQpGZWA6
 56QghHxxshwabekGnS4ne4NNP/1o3G8qNWxzVqMCtA4huIRJdwaHwd+7p/ufWVq9ppn/
 JW7Mx58Z+wzfI/fWQZvNfl0TG8Qqirz7KFMnNaSG1/VvR8Ov6Cbg1N1hpxszzq0QJfzM
 Nv1Q==
X-Gm-Message-State: AOJu0YwhJovtwnyab5pLtVRgwUgtEhulwTDqb4xF+LJEyMLDbIBTVL0q
 yWlt+IJ69yX1tntQg43O3zKiws+VSCd5lLOjroq2EjP1xHyMsFhPokj/GhGfiDPV9e82GJpHxup
 pgvBa3bQ=
X-Gm-Gg: AY/fxX7VaDzyNV7Du/0OzFDcfggB8lbWCgD/6Gzl+JOdXF3gHXkelSa9r4BeIA//5An
 lCRDYX6zi+UPxNmufOghe8FwhdU9r/PXTI/fp0IplL6uUvoJV1NZEFjLIWpEUcyD7EDBqxzgUA9
 rnVk/QjKPIdCEPVfH6KnYk3AwEdyaeJeiFdJFvW5cyRyiF+zpxydufDqkEn66vCRlhflSu5kq0i
 g4r/p+PCH13qx8MlwfbkL9Un/LNOgkrpi2CTlkhjfsdWdQxNBvirUYNDNB8OAjR7qi7v+1IUVuw
 3xGx9/jr2uQqWK6cuXmnjFMICWNB4fUS2DtaR4j2mF6BaV40fpATaSdwn+pRt6LyN0DHGfi386F
 HY0hJW4j9+MD+Dj2kIAJU9Nt4oKza+7aYQmdudiTD8V3vgCRLz+G4StLq6aRZMJ4QTE9X+9ijpo
 XzH2M78DXZbjho+ghh4ZYP7pfz5YjS1Q==
X-Google-Smtp-Source: AGHT+IHoPV8VkGkT7P1dAvXOUd0+G2e9FQlGzJRrmJj/fcDtblne5kim4or/Y6Zo9g8W2z6+inebtw==
X-Received: by 2002:a17:902:f70d:b0:2a0:fb1c:144e with SMTP id
 d9443c01a7336-2a2caab67afmr6130175ad.7.1766000669924; 
 Wed, 17 Dec 2025 11:44:29 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.245])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a2d1927273sm1146515ad.86.2025.12.17.11.44.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Dec 2025 11:44:29 -0800 (PST)
Message-ID: <b5987277-beb2-4362-8d1f-546ac4fa829e@linaro.org>
Date: Thu, 18 Dec 2025 06:44:25 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/14] system/memory: Split MemoryRegionCache API to
 'memory_cached.h'
To: qemu-devel@nongnu.org
References: <20251217143150.94463-1-philmd@linaro.org>
 <20251217143150.94463-8-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251217143150.94463-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

On 12/18/25 01:31, Philippe Mathieu-Daudé wrote:
> We have 115 direct inclusions of "system/memory.h", and 91 headers
> in include/ use it: hundreds of files have to process it.
> However only one single header really uses the MemoryRegionCache
> API: "hw/virtio/virtio-access.h". Split it out to a new header,
> avoiding processing unused inlined functions hundreds of times.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   MAINTAINERS                       |   1 +
>   include/hw/virtio/virtio-access.h |   1 +
>   include/system/memory.h           | 185 --------------------------
>   include/system/memory_cached.h    | 207 ++++++++++++++++++++++++++++++
>   system/physmem.c                  |   1 +
>   5 files changed, 210 insertions(+), 185 deletions(-)
>   create mode 100644 include/system/memory_cached.h

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

