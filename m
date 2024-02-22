Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A935C54791
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 17:55:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdDHo-0007nr-J6; Thu, 22 Feb 2024 12:55:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rdDHj-0007mt-Bx
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 12:55:04 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rdDHh-00080n-2v
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 12:55:03 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-56559248adcso467209a12.0
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 09:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708624499; x=1709229299; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bx3KBbR0xVU0uc+ydHpKxX1ggOCwvwbxtqZweBfpygA=;
 b=k3zkSdLSPCfvtJ7oy1vk2zBqZVAh0G30HUEKR1A4sl6T91km2VIZF6UHRy37AwNZwv
 JnmhE3CjRbtn695QFFhuUhp0arbQ/PYDuHh1yGlWm09UCKoP0vkJSk0EDp/HvHi9Mczf
 qgKmOBnWcXSAPlGS8uYZjqkbbpfYcqNzYXWlcwcULRrVDT+MhYAT46ToiTQolSiV+Jx9
 omgwjZVdCOyeU/Pc6s9L/TTf/vw6uyrN+vHOTtQ1nTKf5iJXyeYv4RZDrmtnFO3U6pwk
 AXpG2ZGAmMBWSUBTryZF1+xGTTQAg9ctRXmmo4yNLalbfXOsCgM/R5kAFr0ZObMGeDHw
 JzBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708624499; x=1709229299;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bx3KBbR0xVU0uc+ydHpKxX1ggOCwvwbxtqZweBfpygA=;
 b=sPwA0IG2xV9CPJ3VjHwxDkgd1M4likcYtheyrSWQhV0pi2Oo433h7KEyh2w1BJsUdI
 EO7ssxCQflA1KBLcSZ0bMCiKJQlytnG9d9kshggVjn+tyigh9GjBGrNAKqmmDyLR0bXe
 xGICBpP7XhJE5alVzlMVWDqtkUgU6Thb/IzrLiZ0FEUPmxFq9a0XkOmpnBJqYu/NlMiz
 9+ztjE/p+hjmASvQAZFwdrgnVgxv/ss633bZfxZdvFI/bJRWByBJLAw9cY0fPvdRoR+c
 +0xKhVzDymAYq4FcVHaF643pZjUR/1mU6iAJheAq2gJd9ybsZ2gw6i03ZRhITGab7M2O
 WNKQ==
X-Gm-Message-State: AOJu0YxhnKtBbw/BihyrY+RCGDGcw7SlUx2yN1R16Sz26ogs/taeCSPJ
 5PAUkvVlUxsDgUG5lg7sCH1CQSdG9qD/9vLgqe2TuHkjXUvN5D3LXNdC485GNtqyFhpGcGHYxuw
 Yig4E18gOgrZNoo5kUj5l7QyDgS7wXS/JEZQFuQ==
X-Google-Smtp-Source: AGHT+IHzxZ4iZplLjV5IySEG8FVP3e/eDeg/uJkbvPQt63DDqNuOUkwdlv54wTEmJuA1k8Tf0IXCjFVdLcmxzwT4D+8=
X-Received: by 2002:aa7:d851:0:b0:564:59ba:2cf3 with SMTP id
 f17-20020aa7d851000000b0056459ba2cf3mr9086898eds.9.1708624499395; Thu, 22 Feb
 2024 09:54:59 -0800 (PST)
MIME-Version: 1.0
References: <20240220134120.2961059-1-rayhan.faizel@gmail.com>
In-Reply-To: <20240220134120.2961059-1-rayhan.faizel@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Feb 2024 17:54:48 +0000
Message-ID: <CAFEAcA8GFFQ-L6zGcft9q8arJxuggraHYRhcAf4q+Oi+VMSP3Q@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Add support for I2C in BCM2835 boards
To: Rayhan Faizel <rayhan.faizel@gmail.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, pbonzini@redhat.com, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Tue, 20 Feb 2024 at 13:42, Rayhan Faizel <rayhan.faizel@gmail.com> wrote:
>
> This patch series implements support for the Broadcom Serial Controller used
> by BCM2835 based boards for I2C.
>
> [Changes in v3]
>
> - Add SPDX license identifiers.
> - Fix a few minor whitespace issues.
>
> [Changes in v2]
>
> - Fixed and simplified writing to status register
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/481
> Signed-off-by: Rayhan Faizel <rayhan.faizel@gmail.com>
>
> Rayhan Faizel (3):
>   hw/i2c: Implement Broadcom Serial Controller (BSC)
>   hw/arm: Connect BSC to BCM2835 board as I2C0, I2C1 and I2C2
>   tests/qtest: Add testcase for BCM2835 BSC



Applied to target-arm.next, thanks.

-- PMM

