Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ACC3D1D899
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 08:35:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vR4oB-0003hG-MW; Thu, 04 Dec 2025 03:35:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vR4o6-0003fr-Fs
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 03:35:23 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vR4o3-0005gz-Qf
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 03:35:22 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-477563e28a3so4881695e9.1
 for <qemu-devel@nongnu.org>; Thu, 04 Dec 2025 00:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764837318; x=1765442118; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3yRFZ6+FQTBkK11sctGj4ov316+g4LWQUK4c7w7DpuE=;
 b=xX5lnPlAg26Cv9KncTaVFZwf5JGdd34+GA7JY50Ck667Q0tjWjNfyGmhxvEptPNwQj
 v6qdNKIia+Q21zVHscqHiunU5ZHJwE5so6aUJ6ltjzCmaWl76+yOMO0IcBLg67Xb7VxS
 lysbgVz8fCd9DW3hMaHBscu4p8YSIhpc2VFQW+6cSSaSuH4S7n/PIWzGkymuZw0ma8tm
 SFtbrvtj0iWOfgPd1GK2moJsq9Va6UKKv04HLYHe5WFXreRo3KbbUnofWKiOGosVz9Ra
 ES2H6rKtXrlS6MNLwr4XbdStp+iA7ASgenpOe5v/hgbsXpf9BOusTgXT4Qs28Ix5LO0j
 nyaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764837318; x=1765442118;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3yRFZ6+FQTBkK11sctGj4ov316+g4LWQUK4c7w7DpuE=;
 b=UOCxBbFyHGuRABQb06B8KHTU4Ml2+VqS/ZtmTrgSScu7EVtuPWBGmlpwJzGz29VFW8
 uLG37WAMn4fRDief8W5y9zMOXEkn6QYG3js7YGaT70WzrRlxyZWGDUh6y1XyrSfYge/V
 DE/4rHqf1+wgCKf3jES9QVRlzxUXCxMAYDa5lYHo4iJ5duleDh+APDDHm+8gaQbwK3Lk
 fiM02pR9Cw1WwZ7GUpYKAOIR7Qd4QXUGV52rL6Z+xHWLFIc467bM3pb4ckEt/GRUXaZ9
 6SCW4CoCbYAepV01XvwXlm/JG5F61R+sxQow6ZPvH4LeBz7K8hWVCQSGxeTUZkgpX0FZ
 Z6MQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX83Ro09bLGTDXe9doBen9j8qOE7BWhVEYaqIBRWkXMymtBB7eqsvYjSqU4fCfmOwfPcnocAj+7M1Sy@nongnu.org
X-Gm-Message-State: AOJu0YzxPMGgozkurCH7xJa7i/ev0GL+10NQ35okacQo5DKnqRbiVwGH
 Hk61KZfGi93dufMYRHjYRVUSzUIdE/02LPtIK/noS0J/tS/es7LcnVu0JAXfH8NeU/U=
X-Gm-Gg: ASbGncvaqYrzHJQ4I3SWbXNzln9ln9SHaCVy2vuDRWPdXoVJ4lEY2o29e6B7sy2S5lW
 ws6nzPglKDBxpbvFcFVV8B4XrAjrhfYXqbIMxq4IgyR+Ye/p1JYrJz5VRr0xnXL/DB73Lz97LRD
 6Q6zeiJlvT7nyl8rTH3TKElCwHQ/9o14HagF9SnJzfD5+y1XkwCnPL7T8PjaYRdG53uoq5BbQT6
 n34btUP/jKlSEv3IrureCqcZWoIQYCjWmq1StmXqqMGmMWMwki9SSQO0Rj0Hoh41mdh7C8V8EXM
 m41p9R+MV35UA2z52zSfEyTqbP3C8nDLOo9kd1z0/aFN1keftRSPz1yNPvw4KjDGjvL13NapyYp
 lTixqGrr8IRJUzmNKY53DmMJyJ2vJPBFtVMLvG4uSJszTbagyW9swu9RxvM7q/ySY4CPo4wFQAU
 mZkO9FoYq+jihomRN2bCr3s4I/6mHXHpRe4AzJk7WeJEAA18Jbcv4arw==
X-Google-Smtp-Source: AGHT+IGnNnZsCNDga82lzcD12G11gq+TIOGostO9iZFtl4o9mN1wEBNG8Z77fK+bB/yxHOOsYHqf3A==
X-Received: by 2002:a05:600c:2052:b0:475:d7fd:5c59 with SMTP id
 5b1f17b1804b1-4792eb73281mr15691105e9.16.1764837318064; 
 Thu, 04 Dec 2025 00:35:18 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7cbfeadesm1860836f8f.10.2025.12.04.00.35.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Dec 2025 00:35:17 -0800 (PST)
Message-ID: <bbbf42c5-98c6-4f24-929b-7bbb2853f5c9@linaro.org>
Date: Thu, 4 Dec 2025 09:35:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] block: reduce files included by block/aio.h
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.omc
References: <20251203185133.2458207-1-pbonzini@redhat.com>
 <20251203185133.2458207-4-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251203185133.2458207-4-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 3/12/25 19:51, Paolo Bonzini wrote:
> Avoid including all of qdev everywhere (the hw/core/qdev.h header in fact
> brings in a lot more headers too), instead declare a couple structs for
> which only a pointer type is needed.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   include/block/aio.h                |  7 +++----
>   include/block/block-copy.h         |  1 +
>   include/block/block-global-state.h |  1 +
>   include/block/block-io.h           |  1 +
>   include/block/dirty-bitmap.h       |  1 +
>   include/hw/core/qdev.h             |  6 +-----
>   include/qemu/job.h                 |  1 +
>   include/qemu/main-loop.h           |  2 +-
>   include/qemu/mem-reentrancy.h      | 10 ++++++++++
>   net/net.c                          |  1 +
>   util/async.c                       |  1 +
>   11 files changed, 22 insertions(+), 10 deletions(-)
>   create mode 100644 include/qemu/mem-reentrancy.h
> 
> diff --git a/include/block/aio.h b/include/block/aio.h
> index 59c56d695ee..8cca2360d1a 100644
> --- a/include/block/aio.h
> +++ b/include/block/aio.h
> @@ -23,9 +23,8 @@
>   #include "qemu/lockcnt.h"
>   #include "qemu/thread.h"
>   #include "qemu/timer.h"
> -#include "block/graph-lock.h"
> -#include "hw/core/qdev.h"
>   
> +struct MemReentrancyGuard;
>   
>   typedef struct AioHandler AioHandler;
>   typedef QLIST_HEAD(, AioHandler) AioHandlerList;
> @@ -211,7 +210,7 @@ struct AioContext {
>        * of nodes and edges from block graph while some
>        * other thread is traversing it.
>        */
> -    BdrvGraphRWlock *bdrv_graph;
> +    struct BdrvGraphRWlock *bdrv_graph;
>   
>       /* The list of registered AIO handlers.  Protected by ctx->list_lock. */
>       AioHandlerList aio_handlers;
> @@ -393,7 +392,7 @@ void aio_bh_schedule_oneshot_full(AioContext *ctx, QEMUBHFunc *cb, void *opaque,
>    * device-reentrancy issues
>    */
>   QEMUBH *aio_bh_new_full(AioContext *ctx, QEMUBHFunc *cb, void *opaque,
> -                        const char *name, MemReentrancyGuard *reentrancy_guard);
> +                        const char *name, struct MemReentrancyGuard *reentrancy_guard);
>   

I suppose these changes were before you move the declarations to their
own "qemu/mem-reentrancy.h" header?


