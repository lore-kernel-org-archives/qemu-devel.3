Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16FB1F46442
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 09:59:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w24in-0005e2-Vh; Mon, 16 Mar 2026 05:58:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w24il-0005dm-Sn
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 05:58:47 -0400
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w24ij-0001U7-49
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 05:58:46 -0400
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-64937edbc9eso3778844d50.2
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2026 02:58:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773655124; cv=none;
 d=google.com; s=arc-20240605;
 b=DOA8Z3lQDCjJkgFXs3YEyga7Al9+X9usKRUYYnWi40dDD1E/OQimxWhs3OJFeN4RU9
 NywAjIJsWv8pRsh+X0WopEGNKAAPcZUOkhiECoh1EEw1V55b0PdupvgeBlMKqwFdbfWP
 jq1Ub4g96vLGCQxshNuGD/b3iTiIN6skd14XRDXfRO985go0kUUCqkLDxGcqfsV1y2GA
 OijYaKa/IE9Qz5fhZmVq8LTGKrSTEvGDqDDN50V+wDHmcI3d21widKJgOfuoAfo1pGjz
 xYR+opuVGQV5p3mZGiwU0ufKk2rCJdvVtCIyvcpc54J8imOk8AEx3qo3nS2ajj6v4Io3
 dhSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=CYSi0AQiciZuKtxJGODZ7ypnq6mxBM9wXxyovmeCrsc=;
 fh=q4FOwaLWKjdhqaH6fRkTBrgQvOYFgSH4SJFe4z07d1Y=;
 b=XnGLycNKabZBMBMksjcGQRyCt9a6EOnk4DFz4TdTF1QR+bLgk7SsMHtT7PumeO9aqx
 SL+GBeVrnznZfMgebbdRTV9ljspDcgTk+uPJtH3dZ/dk886tO9tNeMDJfqCQCRde51sF
 BBNgvQWrmGGCzMcBtqmdLVeLutFN2LnmDiN27Xc3GbpDWCkWu7fiUXl3j2gh37jhR1Yk
 q6Dn7GZxFsCOUoTyYn6UhfKI7Z9A29uT20K3nVspIAl5K868BYU4iO2iqNRag5MDaO/0
 lqW1BCR8CgM0sSJqc98fzv1aERoctKE9K6ghf/K5juf+a6HQB9F5bqyux0S8xe5oK8Ms
 +i3g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773655124; x=1774259924; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CYSi0AQiciZuKtxJGODZ7ypnq6mxBM9wXxyovmeCrsc=;
 b=h2lAFmBwhSHloeEYNWh6r6faRwC/ooMUo+Yh4duwnIGb1C3FI7MlHVmZxwW9Xt9DD2
 CosMe7rJvoiOLfTkHXpJtu0EaDVV5J5ME7lAH/LjMYJbcuAkDqBqF0NY7GY/3viGIxbq
 OENedAju02PeNn/JVgvtCIjC1R/PoFB4nKOq4zc/L6gFh/oXB5ZBl3n/Lo8OLrTOaVDL
 qRmRRo8H6PlYy4nztLIOyXsLUU4o/xYmRJ7lHoE32mKW0xPhunbrLg3S0E62k5SM44w9
 iJLJRETi8KnfJnEe9zr/o9uy6IyNp1OLx4rlEjilY74mDBjvbkqS8wwYpZY1quqaGeJ6
 5HOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773655124; x=1774259924;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CYSi0AQiciZuKtxJGODZ7ypnq6mxBM9wXxyovmeCrsc=;
 b=QBiVT0ckGYYF90IN0Yh5RBvWs1F4yGVteSkyGIxqkjH+jOh3IUjleO2L8DRXe3Bmel
 obn6itBCPCQNIWxMe4E5Hy8/i3z3A25XalwDEj4CrfPGL4f/nsEIyssWaFq8hHVurMxc
 XpX/kQDDJhUIW3aniYSWXWo43lkW3TNC8E+Pj+FmFU+RLIjDrwLGUKXGhPxsbgnMcBqc
 zbCjwJBwGxuFV6/3t7aRfNfPizUxvRUDhyvDYAsPNs73AxAyPXiP/qi/5vePEf4eo2/f
 SXz6hU3erxliXEkfP28WcSPSoOG1VLu2Er0h4YLLnk+eX5pZqa+yPZMio9ypPkS1WVda
 V2JQ==
X-Gm-Message-State: AOJu0YzAVMqYFGLOHo7DdBMsjA+Xzx2kQYFMOWJs78PIVDsKAKY1MdoV
 PhlN7Kw98RGHN0tSPJJas6ap0BYNUjnJyidNBO6bo1QV5L51Sh49GHUITz8POCkPUVzysbqhNub
 Q1oHLcRl28Rb4aUGlcz97doAul4NKlNTY0DwSuYPW1w==
X-Gm-Gg: ATEYQzy4OFGepCtRhEeOccIgKM+WCfxQrgHL0efXqA0NksdEQLPb+yFvoCbE4gWn4ts
 VL5VJW0QCnoUDigcigijhjzrYfYcQrLGNj52ct3/315hgIunU66x6/ffTODG7jmQkvJQlut+gXl
 f0xgCT8k7AQnWXFb31zAnQ0sNgUt25nLyoYO0IRxf3BE5i8l+urZHCG31btPlP779xUe/prf9aD
 RAFInsbX5VoFWeb6g5H3jx3yWgstn+TLhP65CTFW2iBzTOP0v5PuNaUTWQzNtPNqwYLHys3Op7n
 K2QbXrO7neJ/hKANeQbCyylHl+IUrkmsuRrX8URp+LK0JIJICBIwcZbcM7VUZXy6OqI=
X-Received: by 2002:a53:ef02:0:b0:64d:6bee:2c5b with SMTP id
 956f58d0204a3-64e62f5969amr9114398d50.16.1773655124082; Mon, 16 Mar 2026
 02:58:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260313182957.28432-1-farosas@suse.de>
 <20260313182957.28432-5-farosas@suse.de>
In-Reply-To: <20260313182957.28432-5-farosas@suse.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Mar 2026 09:58:32 +0000
X-Gm-Features: AaiRm506pNz_HKO0xibitEuU8nL0yCFguRR2g-cHh0ZwbQpVWvMh9Y158A4qAoM
Message-ID: <CAFEAcA8LUzwQLgzAeSswjWZWz0UOn2dmYKcOA7c3PipqLJcnDQ@mail.gmail.com>
Subject: Re: [PATCH v1 4/4] hw/riscv: Free resources allocated at
 riscv_iommu_instance_init
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb136.google.com
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

On Fri, 13 Mar 2026 at 18:30, Fabiano Rosas <farosas@suse.de> wrote:
>
> Add a riscv_iommu_instance_finalize() routine and move there the unref
> of the iot_cache and ctx_cache hash tables from riscv_iommu_unrealize.
>
> Also start freeing the register state masks, also allocated at the
> _init function.
>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

This is the same as
https://patchew.org/QEMU/20260307125222.3656140-1-peter.maydell@linaro.org/
which I sent last week.

thanks
-- PMM

