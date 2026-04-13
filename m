Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F550F531DC
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 22:59:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCQFx-0004RW-Qg; Mon, 13 Apr 2026 18:59:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCQFv-0004RF-1K
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 18:59:47 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCQFt-0003qO-Jk
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 18:59:46 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-488ba6366a7so61524175e9.0
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 15:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776121184; x=1776725984; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KTgd4LIc38fL/1sz3zMphgk6GOoXAPiOesau6BWUUIE=;
 b=bS9YrV2pUQwl7TrAAQQIb2VQP3nRgafA9Rw06IvCPYhv30ieh//+55mi8Moqqwyd3p
 8ZMjghhuXFpJYfODAGao1v/U3k2kIDD5YsLKoAdvwukxT+UKKGvItwyEbd0V6kI6xFVo
 nyxW0aq6JUh18aOIydEDEt8A/1oTYn88GlkHnsIGFDiATnQ+cC2bG1b+AQycsjtSN6zg
 mrLQOzPkJQ/852V4jnnyLpZY46TbdF5ZfiV3HVgTtUs3d+lU6fsxk8V1ra7ldiYg/KH8
 YfBlqfq2GSU6rmHGVA970RheUPEgJt7hkdncr9LPBW3yZVR0Kjdl1o9JFoymjWdvBH7D
 XEaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776121184; x=1776725984;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KTgd4LIc38fL/1sz3zMphgk6GOoXAPiOesau6BWUUIE=;
 b=CQ1/YemX4WqTJR48mLL6Peyc/SstfWdk1FRWBn3/fRmHOV1uPu5W3f56h9X9GP4GTw
 0yysd+YneRSqz1lDGZhXquLDHin1rpaLzvWW0wBuSnamD3Z6j8FTZtwcLybm5RSOJlye
 Sb/TmyZnhqN9+zEWYCCg1Qy8OQ5OsDoNn7Xi6yN78rw2SyZPZbdJ8Tt785Oerk58ftBr
 sVpQVb3K6SclDaOIntIXtXjPuSVoJay89hPZeNwGfVLkt/CH0TzK9jnIGo+Yj/vzrQ/Y
 S2QJnmnMNbV7WgMmNFwLOuuXdaOBD8yFd7pP8mY2+khoVsDsVLLwE22MSrm9OtB5m+nz
 7Msw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9FKuom3BBMmbx/siGdSm8vBmcKalPcg1tjCoesLmKi6zmz7aBpzGAVj4bOjKH32C2GhZwAL/NrNCE9@nongnu.org
X-Gm-Message-State: AOJu0YzgSlUQXuov68jS4qeJ7xj+YqHRo+KxnJub9C/P5tI4TZM/Zm9t
 OQI43mYRsAy6J6yOw7G81yjARomimfbDNaH1JWudAYQdvYzPPEfX1p1zmM4BwYNBPmk=
X-Gm-Gg: AeBDiesRKsD5ccN9N9c+SFkUc/y8JQRpMO73L7QWho4Cwa7IxZ7wNLQ8knqKRKOwgnj
 /Z86pyPhJQK280QfAYniHRXHDJGkWxtZJcR87xWZc2Cc2htkYni3GLYaNmMwXkWGfzI9eE5ykkb
 gUwutchVLz3uuX8vbMC5prwq9sDThK047safiVq/274wj2q31PCzd8Oj2d3BuGgTZFEPstgv0dJ
 57LYNoKzzKva0suUfvGksZgUY1CWJz9Gb3nSTng4ACezwCsK3K4Ty8McwLfkMGYYXE6DBLocNPo
 wqxFc7kUcf4dDK2nBZQoL/0JbZe6YgOgRLuobbiuE4HAWSoqwkjYKGFEm0SDbHOO1xf5RO+SEYe
 U7w4I+LvLVVyyeJLvPmOAavoKvJZZc95olJEoAsVy2vaEVHUy280eWBP7XTt6Imjo8s5LJmd9nP
 24Lo8ooLJDx+BMHjYoCFZAJkwHHHRcG8pRNl1N5ZUOvwT0O3HP7QYR7buPX6thx2hD/kzZMQaMB
 PKD
X-Received: by 2002:a05:600d:9:b0:488:b4e3:aeca with SMTP id
 5b1f17b1804b1-488d67bf177mr163865655e9.1.1776121183881; 
 Mon, 13 Apr 2026 15:59:43 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ede24977sm1361245e9.7.2026.04.13.15.59.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Apr 2026 15:59:43 -0700 (PDT)
Message-ID: <fbe299e1-6fb6-4867-b80f-eb9b44a4110d@linaro.org>
Date: Tue, 14 Apr 2026 00:59:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 65/65] hw/arm/virt: Allow user to select GICv5
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
References: <20260327111700.795099-1-peter.maydell@linaro.org>
 <20260327111700.795099-66-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260327111700.795099-66-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 27/3/26 12:17, Peter Maydell wrote:
> Allow the user to select a GICv5 via '-machine gic-version=x-5', and
> document this.  The 'x-' prefix indicates that the emulation is still
> in an "experimental" state as far as QEMU is concerned; the
> documentation describes what "experimental" means for the user and
> what parts are not yet implemented.
> 
> We do not make 'gic-version=max' enable GICv5 here because:
> 
>   * the GICv5 architectural spec is still at the EAC level and could
>     have minor changes between now and its final version; only users
>     who specifically want to start working with the GICv5 should
>     select it
>   * QEMU's implementation here is still not fully featured, and
>     selecting it instead of GICv3 will mean losing functionality such
>     as MSIs
>   * the GICv5 is not backwards compatible with the GICv3/GICv4 for
>     system software, so silently "upgrading" an existing command line
>     to GICv5 is just going to break existing guest kernels
> 
> The last one in particular suggests that even when the emulation
> moves out of "experimental" status we will probably not want to
> change "max".
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> ---
>   docs/system/arm/virt.rst | 19 +++++++++++++++++++
>   hw/arm/virt.c            | 11 ++++++++---
>   2 files changed, 27 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

