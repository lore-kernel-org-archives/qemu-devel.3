Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86EF6CD4F49
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 16:08:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wP0WE-0001iz-2C; Mon, 18 May 2026 12:08:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wP0Vu-0001eY-Q5
 for qemu-devel@nongnu.org; Mon, 18 May 2026 12:08:22 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wP0Vs-00011C-7V
 for qemu-devel@nongnu.org; Mon, 18 May 2026 12:08:17 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4891e5b9c1fso20755735e9.2
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 09:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779120493; x=1779725293; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1Hq/U8uoTYQfZfrXhRIyCRMmbM4zcasjUbs+QOmzN9w=;
 b=mvwRnXGJg38o/Wcu9beJjKyQwbIPKzV5RAvUxnkKYKkt+m4vDEYAsoY/4uYfEs3Utd
 /SrNnRO2DhDv/GYVvtJHCim6EhDYXjrg82s/ipcoJoOAgHx9MkV7VHsfMIfwvQzQ2z8w
 VB8igN76Dxf4SrPXe0er0Jx7iihwW5BPtC/bnaFu+CcybAZuXb2Bq26eYQ1ljBFf787m
 Uw2ekAZ1tyTPLiQCBNhUQUMS9a5N7iVt+1eeVRtc2DOhB9//Zp/PglhHNuxLwAeZN+tg
 m59g6GxM0aKBBTW+9a0HgGPDD8spAzigmu/xhBGeffWxPnvrrwjGP3KJEraXq/Ek26OU
 NENA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779120493; x=1779725293;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1Hq/U8uoTYQfZfrXhRIyCRMmbM4zcasjUbs+QOmzN9w=;
 b=ngMCkxO/TuJ6ZPnlfGih7jwP8z+L65frQWF9vUn1PxFLzScc6strB/IlbTGqimn7NN
 2RZ6rsXZP3pIo6ReQlVV6+ZzsgO6P9X2rBSuuAH/YVO1gZD3ktoVZxULiiz6t2DTGdMK
 0tJkJwX6UcsY8VbEZndMJ28kSOveGE1ctHdZgpuvWehmPxaDU/7PDgErjrKkz0CE7HTc
 vHMjHerQs0yB2Tvl+ti2108UTE+8SyGuGC69HaNMGPMciObMDGhgQbem6pCYq0k7Dw7D
 Nv0nP5rb8k8T7YORwxLpFG6hI74p4nohJqemTaeRaadlCCqEgKqMjIdvUf7ulc7SrVm2
 ViLQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9XvAWJf52n6CTb4nlTgG2eQpHDOHdYT+jtuZFTWWLZNDNaWc5q2fjqoRVefObE1Q2Fgrif74hXAKcK@nongnu.org
X-Gm-Message-State: AOJu0YytlcqJZfOrsbYsZRx9ZnyaPrvZkJqu6nhukndpzjcaqzxTjnS+
 ZMHLpx5FaaG2kuXHNhDj8sRbmRF6Yyrd/Fwb4MD3QblnWpijrqHwonVDtTVmVjWlbdk=
X-Gm-Gg: Acq92OGUX8fsIq5Sv9Z53IX+PclTEhDExp4PDTEJF5PAM88N1ePgYrDBCkI3IcyE43w
 Lb0B1pmDgBvyC3AzlwHG8AubWCEUTzdZdW3J4u/fCJVfCm+M24M0wicLiMjF/cX+k4S16usKslR
 qUCqZE/sP6TMjNvG+ELNpf6QZpff29TtwJvV33+FHIasUS/pb2jve7O7K2TDoO1NA7Mf6RJ5Zui
 J4YsxEZJ7lWn9DMoBzdV1zmhqPMTxWaaWdLEgVDPy/UR8dZsZU0ClTsxS9v356Teo4jajLkCkyP
 wsky+peJGDi3OpsAU6Iv2MmRI0iUDFMNLA0Oti34dcNjb8J4yIH2X8E/j2YuUSb04E0QNwURmqv
 EKgnwoRNWoaqkgKUHI3ey2QYxhThUbp5jTbgqQl1dfaDiJ7okvr19f2Ix5XJXoxWiG4+qLLvR43
 8cBGxCDyt8P/mEHYAuadu7AoMlzqPAuUWMtj+4XHTTvTBfgcpHfUoqiKP2mmSQ3MfcAQ==
X-Received: by 2002:a05:600c:8b6e:b0:485:9a50:3370 with SMTP id
 5b1f17b1804b1-48fe60ecc24mr255578925e9.8.1779120493469; 
 Mon, 18 May 2026 09:08:13 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48febe67688sm106981265e9.5.2026.05.18.09.08.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2026 09:08:12 -0700 (PDT)
Message-ID: <99665646-f286-4e7f-8c74-b667718f4468@linaro.org>
Date: Mon, 18 May 2026 18:08:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] system/qtest: Fix length parameter in the b64write code
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 qemu-trivial@nongnu.org
References: <20260518134020.1420932-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260518134020.1420932-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 18/5/26 15:40, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> The b64write code has a sanity check that the given lengths matches
> the real length of the given data, and calculates the minimum of the
> two values to be on the safe side. However, the address_space_write()
> then uses the original value and ignores the calculated minimum. Use
> out_len here to fix the problem.
> 
> Fixes: 70da30483e7 ("qtest: Use cpu address space instead of system memory")
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   system/qtest.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

