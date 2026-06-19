Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1690CD98F2
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 13:55:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waZgQ-00064Y-Rb; Fri, 19 Jun 2026 09:54:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1waZgN-0005tH-ME
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 09:54:55 -0400
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1waZgM-0005Gy-AP
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 09:54:55 -0400
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-6603d8697d2so2416066d50.0
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 06:54:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781877293; cv=none;
 d=google.com; s=arc-20240605;
 b=lGSaPU6Kv2XZfaOn9JtwvcRMjTm05bV9gta4vwBw1bsMDYfyr3do0t65pAyNNrr0H2
 tFP5uOLmcCNux8sp1UYWFT8VAwz0Iw+JklpY0Fuk52pDflRZrZEWSR3JpVpzHaM/6nIF
 rohT43mvbT1hifftX0e2qCfGXUggdxJJwtebeDUli1Hmb0SNfXh6C6eoMGGI4Y97iFgk
 hbE0Cq60wODh11/J9VsTUe9dli0cZ4i9UpS4fwkOQl84N9r3b7WfZjKXulYaLBWv4bUc
 EUBXDxIeJYpLXJVsL2FiszHAsIJ8K8HzqXzeMsQlQaJj25CTh8kq88YtSBC846vKvosN
 DA3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=GbMj8ohN5hSH5sEwG9AhdJgrUsTXPcM0/iSaYnRqT8M=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=QSZTCPJsKHpo2vsjjD0RDzl2G/uECLFhzT1OULcbGWgIwYUueZbCwStKuRlMttJ3xK
 x5RXpeZ0tHoatex2NRi7HivsS4xkDNgiBUP7zEBra4qtp5K19M6jUBg3tNyt414qpG1N
 umso9wEnIOyqcYwAQgpEFgQofu7atFHfaPYhiBbXWUxCXOFJTxI/3pjCmDwaWUQKyeGb
 fJs8hM9QbifPhXhk+nlIEDCiajDvpeo2Sl4PBYz6CldQMk9v7+q0U9AyCo8pH+lxrNlW
 E5yxPZREhy3Syw9Upw2M9KWe9bQ/yeII/O3mq847XMuUvC/K2tCxa3+2lTlxZn5X8QPq
 y8eQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781877293; x=1782482093; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GbMj8ohN5hSH5sEwG9AhdJgrUsTXPcM0/iSaYnRqT8M=;
 b=uJI1pYWvn3abWGfGvhngSEU9bgtkD7ReAYXVKtoa+7p8NIczOvfi9/wWHRD2c/bVaY
 dVyhbGJbajf2plbfMhTIbbYsocy+G5F+pxh2aIt+rG1k1hTcuJiIz2bUnCgaFP4OZPhX
 z46xEGGTr9Aypa34W/tzp7jR1M+aKG9QA5s3gBlAdiKNCTgHxf21cF13XZwqjVkQnYrx
 fqBmqiE5DxuWB+ffI5G/xIaChL1HsNjJi2vacnOBWPSkzYfiCoNdXkNwj+/YII2D+/FI
 P3w4cD/wfxSXjkdNwgoYQxFSvPs/KoVN5npItsx8yCzHYnhSZiuJUS2XZ6zSZ1YawWBr
 eaqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781877293; x=1782482093;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GbMj8ohN5hSH5sEwG9AhdJgrUsTXPcM0/iSaYnRqT8M=;
 b=XROFSJD1rhZSCLp4+4OO5l4em13rG4RmxIiHEyG+IaXkznQfchszr/mMtg/x4560Jq
 SdWc3ogS7R0hIa0MU4qzJNHTp5F62RDloYBT2nj1gqHU1hTQ/73qbyPOVx+9p+6autpc
 c3sSECHZ1sI+sbKNp9aabw8yvJdgUdsfGssi/VBvLmh8SkZg52PQZoA7TfxlmH0JRLon
 2ibIZxx5gz6EVKo65mmh1t+gw/tn1KwZPqmp4y+Z10wb0/JPuBbBSZSqCOzMBraLos1/
 jEaWf/lBJE7ZWYRUEIT6585DuEeITfybgshhSO1PdtQEsrMRd43EKIU0VfXibRuZuNLK
 7iqQ==
X-Gm-Message-State: AOJu0Yz8oFDUzvLm416HDne7YlCduxkgDQoLL0mEv+jnDpY3pEhGTL44
 UBWGbEQ5QCX3m/pLXaumjdSlO26Dxt1ktMd8bgWRKtvRoAITx3NY9hmFzay1PSKqI5nLefJ065Z
 WHHAIIKgOQE/5ACRZSoIjsgW9dFWzYJyeyKHJll/U7r7ZlALS5dOh
X-Gm-Gg: AfdE7cmTqvLKGh93SHBotkV7i//X/NuA+bVQdyA+TbzLzJ7AZXS0f3rsv+HVuoMtOm6
 b93JHpjM6V5mgaKh/QCSTxACXcV1icFllyZbSBbT4B+hL7WpSJtrP7lt9nSSPJ3r4oD/qE24HXy
 aXh0FCw8wXhykg/bmVCfv4e7Prg0kDUZ6vjzdVbWGz3h1XobaZ9YFW330Mklq/nogBhwSDnns0R
 svzMcz/tf/+MMhnBzQ7ZVlvLwBpq4qEU4nB3Icga3vCUknG2uWuHW0v/SbOKp3rRffqE6hZxMrT
 7uEr9iPez9c2ReAyhygP8TRy37lsBfZjtrO7jEvynShucFljQj50CfGk
X-Received: by 2002:a53:b1c4:0:b0:662:b984:a5c0 with SMTP id
 956f58d0204a3-662fc91c8afmr2915774d50.18.1781877293106; Fri, 19 Jun 2026
 06:54:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260618041517.573469-1-richard.henderson@linaro.org>
 <20260618041517.573469-11-richard.henderson@linaro.org>
In-Reply-To: <20260618041517.573469-11-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Jun 2026 14:54:40 +0100
X-Gm-Features: AVVi8CdQf0qlH-gfv9Zf8x6Ugw6eIuCufMPTh2iLLh6RWpdeCmqQZahl-FAXzhI
Message-ID: <CAFEAcA_K8C4x7jCy3afb-NFH==38a7-KoiwmwDTAUXY8qxfeJQ@mail.gmail.com>
Subject: Re: [PATCH 10/10] target/arm: Enable FEAT_SME_F8F32 for -cpu max
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12d.google.com
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

On Thu, 18 Jun 2026 at 05:16, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Are you going to do SME_F8F16 next? That seems to be something
of a pair with SME_F8F32: each feature implies the presence
of the other.

thanks
-- PMM

