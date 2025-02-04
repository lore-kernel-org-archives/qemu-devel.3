Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04667C02194
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 16:04:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfLPC-0005lD-A1; Tue, 04 Feb 2025 11:04:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tfLP7-0005eq-Ke
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 11:04:02 -0500
Received: from mail-yb1-xb2d.google.com ([2607:f8b0:4864:20::b2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tfLP6-0003b7-0W
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 11:04:01 -0500
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-e3978c00a5aso5166496276.1
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 08:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738685036; x=1739289836; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BZgFwqNHFMpqZkhlnVMdmPCfAbdtWvVTXyS6HvGZ3+g=;
 b=HMdHPn743dbtaQRVxKO8tHivyJPLX4CiWt9zYriRxhH4jHjuwRLJ/s7R6x/e2ZycTl
 0ixG8//71JtyXjAm8PAUuWHLmu2jz35EtGYdBIJ25hvyqqItJW2BUEYi/WYcWWy3DA5Y
 Y1B74uT2zq7uqHLBlh2mkF5/eZ1pdCBNo9lW5nzLwuHfYS+K76GEZMq5pnDDbX+N9B8S
 3A3pqU/kx3f84y9PwtplQkKcHY65bcapSEoF+n6UkEpDAE6r7zxQrxEvGoTDvIsDCpIt
 tOZcIm+vksmZQTlDweBk8LM1NQv2Ny+AFfU/5VhvmQD15wWT2kOZGGPzqcJvg6+ZUUC9
 bVjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738685036; x=1739289836;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BZgFwqNHFMpqZkhlnVMdmPCfAbdtWvVTXyS6HvGZ3+g=;
 b=S7ujpwaspomgmTzsyiH4GXRzdXXwnyRlJhcS+jCtmiX8LnR0uQFvEvLw4DR8oHBOUw
 OGC2NhoXFd2zyaqlvoLLifzNy/tqmDJvOut4k59WXjtUbuVJaHSoOoDmUNUcV/76FcPS
 EUD6UChas2j3cPDEUxpuansjDC/8CBEh/+HoeXIGMd/B+zlP8Q7wk21RZhUHMf7h26tx
 /CVOD6OkT7ybKNk+53RPqMVk8YNRrtf3SrOrLfg7ANC6xXMZhA9FqBo4rV2RMm7G/SmI
 bu+xcpULhl4QY8zENZE1KtHlSgEhUEyakOeScuHLukoLXvj7IghA0KpBATRtKqiH61cD
 Riew==
X-Forwarded-Encrypted: i=1;
 AJvYcCVba8/3pwUso8E/g6yl9aqCckvlaMXmKBcWDjY8j8s7Q3htYC3HM5/RffTSM6KZ70FCAPtOVbund43I@nongnu.org
X-Gm-Message-State: AOJu0YwcINausj/VzGGq6Tufmao8gemDYvSH/ykCnKxoOGVATszeLLjn
 KVz4JubfIjnjUJiXjRp/Z72girIpftYJUSGFSVXAqSF4f3jelZKkWHhZ7RF1leADIvZjFJ4cFjK
 qlxoXlJkoDdb697jOP/ZpxBej77jVlrShcFqRU5NXYEOsnq0b
X-Gm-Gg: ASbGncu21d9BGMbzQYLdXeD5r/+8Oad5tsiBu2xyf33TUJcUbxxG9ejJGt4d3RGEQaU
 HVgF9v3UGy44zeU9WzXTp/+edV10E+PSsUn97g1sj92bXf+LFXVuaOKq5KzxUwGsFj/UiiDK/1A
 ==
X-Google-Smtp-Source: AGHT+IHzW96PnxM50mjCJxykapKjfYKBwLg15PnYNqJ0ymvgBO6JZu5pZqA8HWva4nEk/s1IZ1LFeFAhQlzetTdJqC8=
X-Received: by 2002:a05:6902:1025:b0:e58:2e75:9f6d with SMTP id
 3f1490d57ef6-e58a4bc46a8mr19590446276.31.1738685035857; Tue, 04 Feb 2025
 08:03:55 -0800 (PST)
MIME-Version: 1.0
References: <20241226082800.2887689-1-wuhaotsh@google.com>
 <20241226082800.2887689-13-wuhaotsh@google.com>
In-Reply-To: <20241226082800.2887689-13-wuhaotsh@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 4 Feb 2025 16:03:44 +0000
X-Gm-Features: AWEUYZnLr0gYW3uxhUHnEh1EvQBCy-fLMmQC9ATIjcq1zsb0cPd5gQOr6bDNjJk
Message-ID: <CAFEAcA-s+jvKrypP6W8WUJdaosRgWCnZJaB8t=7Urh7nSFVn0g@mail.gmail.com>
Subject: Re: [PATCH v2 12/17] hw/misc: Move NPCM7XX CLK to NPCM CLK
To: Hao Wu <wuhaotsh@google.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Avi.Fishman@nuvoton.com, 
 kfting@nuvoton.com, titusr@google.com, hskinnemoen@google.com, 
 venture@google.com, pbonzini@redhat.com, jasowang@redhat.com, 
 alistair@alistair23.me
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2d.google.com
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

On Thu, 26 Dec 2024 at 08:28, Hao Wu <wuhaotsh@google.com> wrote:
>
> A lot of NPCM7XX and NPCM8XX CLK modules share the same code,
> this commit moves the NPCM7XX CLK to NPCM CLK for these
> properties.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

