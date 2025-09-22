Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DAD2CAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 07:20:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0apj-0002n1-0z; Mon, 22 Sep 2025 03:19:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v0ape-0002mm-3O
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 03:19:30 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v0apb-00046s-4i
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 03:19:29 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3ee12332f3dso3992630f8f.2
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 00:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758525564; x=1759130364; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nirHqXsuPkI6XQMno8k8/7OhusDBgf4FpcrwdqSwKVY=;
 b=JH8F2tGzBzrVSC+I8QU2pE01V8JC7c0yUtAztaiiWelSRDoSJ4U/h5SbIfb+yufw3n
 0rAjoz1vSNxKiewZZC/SqcisF1LS8hW4XAZq4mu3r0ZPRlK7PZ6ucYjZajUW/0/VANav
 1cYcv2jCEN5kD7pLCUOSVD/meHnEaygsApGmzArs2UPrpzTPE3dicAiys1dUCqBTfdom
 vzdIxTn/vI161JpcGFlXZcdJKVDYDuFFhySNBEW/AZ8zYpqOETbIBJo0m0lcurIkQh6i
 UWJADCTAHcVOMnLA5gM3cPKnU7yYm7XHAxgZA8VbCUpWKhkJCjdBfkYGNQdAmC9vPrbW
 REBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758525564; x=1759130364;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nirHqXsuPkI6XQMno8k8/7OhusDBgf4FpcrwdqSwKVY=;
 b=OjTUEmJqBnI0Vjmc0pwaFnOgNMMFYQtjb3wMy32LtaFdqW8rS7wZ6XBC76BY8m1H6z
 lRH0n4QZkZK09GM2RZIL5wfArHC1GstVsG3RIrj3lrLWxw3lk/0VB9jB/x0jfM/Bwh44
 U0fdPhim3x3QTefQAYEnOBkvcPYDd2Tf0WXFR9iu4znJmLu+/DKov36UYIW43mOA9aS9
 7ZEf3i2trl+2ZWo1W0rywhO/0MzwUq35qKTrQWVb8pqi6Oa8SaQMTwgA+B+94cp1mhvU
 Jhh6hwlYhV68PCgL5mZ8oBFgxYwAMVc3RZDKj152wToZPnjpdUjzfH55GZBoYm9XdMtz
 cwTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpk3KoqGUhuMyPclHurOAzuMHscKlmzP0rEZzBgLUcgf3EDtfd/GsjyNpfjsMTEHH14QIhfb0NgZsx@nongnu.org
X-Gm-Message-State: AOJu0Ywx6FAhvRWYgebdp5E9YYeVA/3pWqMglIN+LmBTO5aXkIa0XowO
 6A46cHix9QFVcXq2l9XCVT+rarnNiZ/tVVGDnK9lK2qlDTHJl4IWc/07rMdq20IOgJqIEMJlMVX
 3XwuV0jsgBQ==
X-Gm-Gg: ASbGncvrEcI5VrbLSUIXhn38drf/pp5JTEO64LvE8LmX3RH87E5DUUG6C4kSt4wkZpZ
 Od7msuhktJo27daZHiWUWUCje5LMACRMFYAdY3Apee9/VBVMXYpg+aZuo3g4G+ZeHkKtRCC0yT4
 KqKhgofP4PjpmLmeAIvcTLta1VUwF2FelD1aVeGB/83UEP0l6ubk+LhRQgqY+Y+JDNj8s2OQxfX
 temBbgVtNpwB1l4q/7Mzz10GsvN5Yo7NbjGtkYisbdTnkUuY4iOu8zaem7x0O2aCjw5ldOv8B5O
 hmWMS30MkPWQHz0aEV4fmm4xuZhYQy18ltq63u3KM0HOOsCQc7t9D8NZy/M6Pw+PdYOCTibx526
 KbGOJwfSj/2TlychUSsjwbNAvanF7jsdcuV7yP6WkLiO+dD5ddNqW+bDzxMP076W3sZtOb0M=
X-Google-Smtp-Source: AGHT+IHZN9AlomqoiSaN01yD0FOI+xmX+DgG+4zxpwjRjPsg1me/WD3yaSksH+FJ4Df6FfrAQMyu2w==
X-Received: by 2002:a05:6000:2892:b0:400:4507:474 with SMTP id
 ffacd0b85a97d-4004507084bmr653197f8f.18.1758525563601; 
 Mon, 22 Sep 2025 00:19:23 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3ee0fbc7460sm18843943f8f.31.2025.09.22.00.19.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Sep 2025 00:19:22 -0700 (PDT)
Message-ID: <45947ebb-edb4-4dbd-b4b4-8bb70df2f9ab@linaro.org>
Date: Mon, 22 Sep 2025 09:19:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bql: Fix bql_locked status with condvar APIs
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Fabiano Rosas <farosas@suse.de>
References: <20250904223158.1276992-1-peterx@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250904223158.1276992-1-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

On 5/9/25 00:31, Peter Xu wrote:
> QEMU has a per-thread "bql_locked" variable stored in TLS section, showing
> whether the current thread is holding the BQL lock.
> 
> It's a pretty handy variable.  Function-wise, QEMU have codes trying to
> conditionally take bql, relying on the var reflecting the locking status
> (e.g. BQL_LOCK_GUARD), or in a GDB debugging session, we could also look at
> the variable (in reality, co_tls_bql_locked), to see which thread is
> currently holding the bql.
> 
> When using that as a debugging facility, sometimes we can observe multiple
> threads holding bql at the same time. It's because QEMU's condvar APIs
> bypassed the bql_*() API, hence they do not update bql_locked even if they
> have released the mutex while waiting.
> 
> It can cause confusion if one does "thread apply all p co_tls_bql_locked"
> and see multiple threads reporting true.
> 
> Fix this by moving the bql status updates into the mutex debug hooks.  Now
> the variable should always reflect the reality.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
> rfc->v1
> - Fix comment [Stefan]
> ---
>   include/qemu/main-loop.h  | 18 ++++++++++++++++++
>   util/qemu-thread-common.h |  7 +++++++
>   stubs/iothread-lock.c     |  9 +++++++++
>   system/cpus.c             | 14 ++++++++++++--
>   4 files changed, 46 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


