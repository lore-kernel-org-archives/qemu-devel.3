Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69B72F55452
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 04:51:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv6rZ-0002yN-Vh; Tue, 24 Feb 2026 23:51:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vv6rT-0002t4-Jl
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 23:51:00 -0500
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vv6rS-0000b2-6U
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 23:50:59 -0500
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-79495b1aaa7so57515867b3.1
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 20:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771995057; x=1772599857; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ptBb3Z5qpO2Qa/ZfGaunHdjGgOqZs3QtvoAU400L35M=;
 b=K0S3holdTPBqA+z7ZSBC3j/6VxMWbmNLP+iQsk58vRbQIFS+7j3wkbqClMzI0W8xq0
 5USkrHzgxmiaIsmTkerpJmuJtui7uHjxraM+MXzIBu48YJGu2jxUZGyXD9bAhk+JjXcZ
 aN9MBwDyB6+AakIrk85uQ8M7D3nMqKtL9ofspEA/RPmf4Ltuq2Wth6SEsYLeHgxP4Xne
 DUBxWGwIXdBxXGRMnviHlX6hQvybxokjfnP34lwh6ixAufE7L0D9LDbg+111Gt0b80ss
 IO73PnXysoNa3Z2/dOUabDjX7OPYPvnGZXtsGx+L7Yj7JaP7F+l3d5POk5rdKWs2gNen
 tcuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771995057; x=1772599857;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ptBb3Z5qpO2Qa/ZfGaunHdjGgOqZs3QtvoAU400L35M=;
 b=eQ2sNlfZgIeq0WnZYZEbra6MazlkNByodQIemiUZF5VZ3EKrQZlIedMJqAueAsJUBy
 qvus5Pf6WGqMm3gObSWuCG0IpGjzRHIGMi6L6+hDgDQa9GM5lEpeiIn/D4W8vSLohkxZ
 lBfrzmnMQSccIEq4kWJjdjDwNBEOryRHtNLqfaW+QiPd1RKXPiKvhLoxs3B8Lwt0mUKj
 RIJXEJdnxEKLn2hjtbWswM5kdH/SmRUEM4c72REJk5n/O4Lcj6yL9vLwuyBHpmNHThTt
 AOFwkTADHpQfbBr1evG5gyKxVGU6dkuNMMBoCxDdTAORlJvkkXdBlwx1A4dO9DqFeJE0
 7BXQ==
X-Gm-Message-State: AOJu0YzXSoio6mqoQ2V2puiSj1XOP4nzdmrAXqu3h/420Je5w5trEECV
 E2Sxq5KFrvfKVd35YvBUIGP2d4POvuD0StYALmeGAP8NljipeLHzNOolNR2pw4dbmIs2CTqT2pX
 J/6fWKus=
X-Gm-Gg: ATEYQzwO0OQFJEmkcm3xWqG6JPnRwL99AgNQ51xlL7f0CAmmUCf1Wo9UUakii4Jqffr
 wvLn+z1qVXkHniCV9F8jWrAi+EGuH4qL0qwMLgvy1FRixBmsf3CQeHtGfPoycI5HTDef2GbpdE1
 /kAGzO29T7GZMiRuCkrRKoZA9eXdCAk7vTicskIykm/EAJf71GyOQRiO1R5s2h+9vQBTdMWvpLX
 eaPIeb9k1hySeJN32rflSZM1b6Bfiyp0g8kcr9TAhLx5DTt9G3dIRj3ebTdhzsC+NHjLKIJSwpW
 Dg9oNGPkomVQ7dwA7C/a18VyTKJCtFfOIQEFRMoInHdajjK/EzDKhj+byyuQMOimts153y+wISa
 B+SHwyyysEQsflkIoawyoyLGXxIkkeY48lWnfxJ4TWjDQYPMdAsy244xTKNod494e8Z5OI2KWhB
 TWxJV0oI//yinXbInWWjkHUSHPQfRg+KnmzWDrNYZMP/3T4b6wJAWJGaV6IcSz22i26eZIBmcSa
 g==
X-Received: by 2002:a05:690c:c4f3:b0:795:c78:b648 with SMTP id
 00721157ae682-798291a1676mr130655537b3.60.1771995056869; 
 Tue, 24 Feb 2026 20:50:56 -0800 (PST)
Received: from [10.34.149.227] ([172.59.192.107])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-7982dd81dacsm51589437b3.31.2026.02.24.20.50.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Feb 2026 20:50:56 -0800 (PST)
Message-ID: <0f4a1c16-6fb2-45de-812b-606cc1c40125@linaro.org>
Date: Wed, 25 Feb 2026 15:50:50 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] hw/virtio: Inline virtio_access_is_big_endian()
To: qemu-devel@nongnu.org
References: <20260225041948.52929-1-philmd@linaro.org>
 <20260225041948.52929-4-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260225041948.52929-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=richard.henderson@linaro.org; helo=mail-yw1-x1135.google.com
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

On 2/25/26 15:19, Philippe Mathieu-Daudé wrote:
> From: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> 
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> Reviewed-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Acked-by: Stefan Hajnoczi<stefanha@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/hw/virtio/virtio-access.h | 29 ++++++++++++-----------------
>   hw/virtio/virtio.c                |  4 ++--
>   2 files changed, 14 insertions(+), 19 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

