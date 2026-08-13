Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43ECBC5CFEB
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 14:14:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuWCD-0001GP-Eh; Thu, 13 Aug 2026 10:14:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuWCB-0001GF-Qo
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 10:14:11 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuWCA-0005gf-Aa
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 10:14:11 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-84faf0fa17eso851020b3a.2
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 07:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786630448; x=1787235248; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=e1OTGh62WghWdLwvFtWZC0iytxWWmyiNI+xTTL5Vk5Q=;
 b=p4b0mXIL4xa92F0s7tSjxgCyXtmIuTXyTVZxXeIz3XYX3vIlBQLEJQO+ybMNEEYybR
 gMC8UIvk7rb5YqLxJpT7QMGVEcK2oSpPAEsSu7Dn307mR8K4dv3ED2YhGpAyeDL2zTjG
 C+27ES1Fghxa4W3vR+G85prdIrEIePcuMfJWBP6T2goE0wsWBH7BLnJAS5Uu9CixP4wa
 KXnimd7v0j+Sg2R5G43PMnu2qywUz2Jj5asc0dTkxBwqH7HnRNmqsALJTQ7nyVWQJ+YW
 m9AdEn3z78YwvxX80ioZuMmL14e69at1/VjFXtdMJWaySsQRK/zuVdhGfn6L2c96K/8V
 DemA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786630448; x=1787235248;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=e1OTGh62WghWdLwvFtWZC0iytxWWmyiNI+xTTL5Vk5Q=;
 b=qD8D66YXY4K12y/1/qnp2nDsvtYbzm9r2wEXEWaUmiYOq6uj2EszmyJNdjyqHG37LQ
 cWtMyZ2kXX0lLwd+2ZMHYp31ws2oOd2U22ZeQMGIsUJ34hQ6e0c0loscnLCuxd1/akx8
 +ThMIAxGK+KML+gXykHu2UVv/fR3xv+aWNPfB5UxH0YJZ2/IodiXt3AiNp0mFc6HGTIB
 p4FNysfGsEGByhwENwDKXQ0/93PJl5GdqW6QYX3kxm2faLYBfi6IUdWlhDTD1K9/hCDe
 9XHd4tKNw0AC+/c1ghJG8YQG5fCp/Ks/883zZKOWNO3TTSz6LBFAZ47ReXQkS3JQHgAZ
 VEHQ==
X-Gm-Message-State: AOJu0YxDTszRZniyRRpCW8auImjVTnVWJXXHWKFHEB6UxQ4UP21srp2f
 kNQNPKfTJk332cfi13L17UQzEHBFtoQWjhNg6IfQkbVjF2Qqcw42R7OpwRIvc2y61CA=
X-Gm-Gg: AR+sD10qtOTahXMIpr2EjgTiO9xpq2aRaxVVsXLc0Dr/czCRYP9lOXYO0xXwG2pm4uU
 sQDA04RSaFnYe90rMbqov9R1rlku2B0nxnBHPiNl/ermonHpbqCrznJcYKgKp9EZk/GJXuLYZGu
 5//sXD3CTRhV61hGM91v5X4AIlNkRRxYeXzkMXN9OvMw8J3oGwElueEwsPbNHoSCwy1ym8Xj/Eb
 Jdq4Je2mOzENyP8ys9jhySDX90Cy7AH0RwWaxkh2kw75k3syQHvcBWfB3JYtnMNNmUZZdluJqdl
 znf4iBTOZrZ2VgBfaW8xeYMkpvok5zi3pN7x2dazJ+MVP25dM87RdD385pMcFtHceYHxKFQPFSY
 1c6859/ezgyV8+PX/RyRz0w8CS7blqABfvpeqUClfGzJbkj3BXyGxiuOi2gbWGoFNVPs7dwF0PB
 ANoxNTmZOc8Of9+6OG7a5M/t/E0FyefJXz014DWm+NafetEmXP0ZKoDKPuuQW/85VFh5RhQHRVN
 lYu5RctOjTOp5MUSEiHr7sDWhVMa2H9jXAJFlA=
X-Received: by 2002:a05:6a00:f06:b0:84f:3f5e:f072 with SMTP id
 d2e1a72fcca58-84fc74f73cbmr7058958b3a.10.1786630448122; 
 Thu, 13 Aug 2026 07:14:08 -0700 (PDT)
Received: from [192.168.0.4] (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84fc5a8a480sm931217b3a.53.2026.08.13.07.14.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Aug 2026 07:14:07 -0700 (PDT)
Message-ID: <f6f159d5-4740-49b6-949c-cdcb1ec3c71f@linaro.org>
Date: Thu, 13 Aug 2026 07:14:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/10] Next patches
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <20260812151444.2611689-1-peterx@redhat.com>
 <f0a852af-1859-4133-9d96-be8b9231888d@linaro.org> <an26zg9zVW-JrV9f@x1.local>
 <an3JcZvNNS8o_UFg@x1.local>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <an3JcZvNNS8o_UFg@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

On 8/13/26 06:41, Peter Xu wrote:
> Now when I think about it from the root, I tend to like what Xen defines
> with ram_addr_t:
> 
> /* address in the RAM (different from a physical address) */
> #if defined(CONFIG_XEN_BACKEND)
> typedef uint64_t ram_addr_t;
> #  define RAM_ADDR_MAX UINT64_MAX
> #  define RAM_ADDR_FMT "%" PRIx64
> #else
> typedef uintptr_t ram_addr_t;
> #  define RAM_ADDR_MAX UINTPTR_MAX
> #  define RAM_ADDR_FMT "%" PRIxPTR
> #endif
> 
> I don't know how we supported 32bit host emulating anything larger, but
> logically it's doable, then IIUC uintptr_t won't be enough allocating
> anything >4G? 

ram_addr_t != hwaddr or vaddr -- it's just an internal token.

So a 32-bit machine could put 1G of ram (identified by ram_addr_t) at 8G (hwaddr) just 
fine.  But obviously it couldn't put 8G of ram anywhere.  :-)

That said, Xen was weird in that it used to be possible to have an i386 qemu command-line 
talking to a x86_64 dom0 kernel controlling x86_64 guests.

So, yeah, now we should drop this ram_addr_t distinction and always use uint64_t.


r~

