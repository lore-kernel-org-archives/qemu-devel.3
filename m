Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 185B9F55452
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 04:48:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv6pO-0001qK-SP; Tue, 24 Feb 2026 23:48:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vv6pO-0001q9-3r
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 23:48:50 -0500
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vv6pM-0000F7-OO
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 23:48:49 -0500
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-64c9a6d6b70so1551797d50.3
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 20:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771994927; x=1772599727; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bFIuEqmr1e/1xEuWdpBKEsOGPavwdIJQdq127Cp/+wc=;
 b=Bu2r9g/q7oznJ9RZTzUtGfJrqtEwag2t194IforfyCfuEC4zkhhZm4KSyvhAQtGvkv
 GadOcsElDIxE5kofTRMoj29uhRNLIjZVHRzl3Ir682Ok8MIr2oDGg8fm2FgLyKAiFvkP
 hnsy1jXYZ/N+H4SL/9Ae2NmAiyyiw/NU2Jw26OaBMxAHnYyEl0l3vC1kRPtN9Tvw7vmY
 xbS77kGppSxkXuq5VuKdX2olyzQtelxMh9YR55tKSJCVDVW7KED8jdA12CeK+OakGujU
 V9UNkm19pViPCCTOssgkShRcRQM9xCnUhz5EW466gicGkG99eh9hixapG5R9HzCrwsZh
 HFSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771994927; x=1772599727;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bFIuEqmr1e/1xEuWdpBKEsOGPavwdIJQdq127Cp/+wc=;
 b=tLef0qVRxGIkheD3OWmy60+rN4ORxi6zBAATdW7I2rJeyL3egTqk0oxtZtQdw7ClzN
 mBHNIt31fbjLEr0z8UFRt19PCOTZtKJS2xbAKY06yh5uuVdQLw7cqC6VKR1dHn9Drx6Z
 LD5lM7bwM1xsA8qazOkyaJnwopvlCxF0L/VKSlfWK3raEpgvdbmJgRG6YaQxYd2Cqh8e
 YoU4yWLF4GxQayQKOLiq5xmUS7t6snYvofqAtH8QcMrj2pQXz8VxSUw2u2BEidiM3y/R
 pkzkqajcWj9QRquH8oinFCJpPHzvUcA8GzVU0/Wtxr956cMfMICjnphqO7LU+knkAu8p
 4JrA==
X-Gm-Message-State: AOJu0YyIJAG27MxCJG6kPmihz27mVjXOMT1Exl2TxRr5GG+7zJbgXIIE
 UlDSZLWpfhYBnSguQMIb4ILIiE6g9xLleUz/skPcpB33JcNe7sLMxXCa5NUnZm4pFh/3e+l9jhG
 4DaWGHr0=
X-Gm-Gg: ATEYQzwMOBk4wOYW6j4aCiK6hfYXx57XYvzRXDQhdoFv3IGhhFWcApE1gyOYrXjAtlx
 Y9XuG27wbuR/GG1jMLpqK7FhmiSR3eb8B+G0eEwc169J6wSGhVzLn/sIqXSN0SG/nxyie3cUMMA
 Lkst2SCj9FpJJMMTky57MOf+VOtpCji8RyWWWPzDyOG5ETsyPtmkhD3gm1BTn8nd4gvJAk/bSnE
 Csl/YDMmI9tDVbwegZyUYptoo53nbZIMYeaYteBBrwO1pMcjgSOQndUXwixC7gnpZFoaX7a+PTV
 s4cAoRB88PMRY7wQ9gZzyU7d9GLz+dG2z/RRsxFvrvB1Li7WLaUsnLkNUoQFOOvgjjbkIMKl4er
 MjXCaQsnqVi3KP23ylCxC72zY4EGV2ARwJJP3H2Wn80p3z9/BAWNDNEHs58a2Uw5fJfsZMBPc+u
 hPFi4zml76kzhO42+1hmB0S1Bkpbx+oOq/fckI7tY1i1+JqxwhDkFlayAXUKRdeGE=
X-Received: by 2002:a05:690c:f02:b0:796:409d:85a9 with SMTP id
 00721157ae682-798680da1d7mr10297377b3.11.1771994926564; 
 Tue, 24 Feb 2026 20:48:46 -0800 (PST)
Received: from [10.34.149.227] ([172.59.192.107])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-79865ef6631sm6488547b3.12.2026.02.24.20.48.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Feb 2026 20:48:46 -0800 (PST)
Message-ID: <2252f2a8-1471-401f-a728-9b4b332c8e33@linaro.org>
Date: Wed, 25 Feb 2026 15:48:39 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] hw/virtio: Add virtio_vdev_is_legacy()
To: qemu-devel@nongnu.org
References: <20260225041948.52929-1-philmd@linaro.org>
 <20260225041948.52929-2-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260225041948.52929-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b131;
 envelope-from=richard.henderson@linaro.org; helo=mail-yx1-xb131.google.com
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
> This simplifies code compared to having
> virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1) or
> !virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1).
> 
> Acked-by: Stefan Hajnoczi<stefanha@redhat.com>
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/hw/virtio/virtio-access.h |  2 +-
>   include/hw/virtio/virtio.h        |  7 ++++++-
>   hw/virtio/vhost.c                 | 12 +++++-------
>   hw/virtio/virtio-pci.c            |  6 +++---
>   hw/virtio/virtio.c                |  8 ++++----
>   5 files changed, 19 insertions(+), 16 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

