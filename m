Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E50B2CD5BB1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 10:50:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRpMI-0008Iu-TX; Tue, 26 May 2026 06:50:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRpMH-0008IQ-CX
 for qemu-devel@nongnu.org; Tue, 26 May 2026 06:50:01 -0400
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRpMF-0006vU-TI
 for qemu-devel@nongnu.org; Tue, 26 May 2026 06:50:01 -0400
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-65c305f381eso11093640d50.3
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 03:49:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779792598; cv=none;
 d=google.com; s=arc-20240605;
 b=VBBZX12lqSkyawKUD4JERMXy+JZCpdW6zT3mb2GsskWeJ5i3AEDIQdli1E0qR5TIHs
 d/qLvBdYYtt3fZBYkVh+7tEFOF4RZdrUbj4NL/y09MQvbelS3UnL9js3fOoLF0FNoIfU
 9ZztxtvOPFjoE1M2HRf0QqXKSWiV77JFHkRJR6FOvvIgNNehERY+rHEdjsYcYpIx/fN6
 t4zSAYO5lZWxV9yVapKB5xxsj8cS9f7DyMovR5ICYEu2gvi2iSvBMdSyQ7/wp72s3HeB
 UJoTQTEvk+F1eD3W9Xb7Oa+48BKahXNNJ5qjeWo0Zl00jSq2WY6udV52/r0hfNSVoj+Q
 fGWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=9y9wZpGNY0ig4+RNsuCUqB9qSvM9dhhqbzXdUoQyxmI=;
 fh=twdMwO8HtYA0tKWE7ZrcLTTV93JyaLUwFo/XJNgsMPI=;
 b=D7tP9h354K1TykNRwkeiOkYnWLCPWy3cvoPcyKCsGQUlnAJhqeoV/T+Z9RZhsLmXFz
 YxsyMaKLOJLON5LlrHLWq7sRYjoyP4+FDC1jvL88RY74fk4h4GEefZCe/NO3erBOpmk4
 aal8TvdRUTqistpGsqm1WSfKv2OE0AWvnM50S3EUC47o+N9LMoOSFAQFYist45k5FCCU
 ZAP0/x0vOKsEPKQ7x7Wcp8NBLUXzugK2T6W3cF5dt54uum2BgnjOr/ttiBiR5w3HdA7f
 B0Q/w95sX1CXHAtb9AYtPgZYZKip+zmpFWljiN9BXEJlrONppNNCaFQmHa52H5TxayT8
 XJKg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779792598; x=1780397398; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9y9wZpGNY0ig4+RNsuCUqB9qSvM9dhhqbzXdUoQyxmI=;
 b=aPHL+gvx/XHNem5dZmxAjNcvM8MoeXTlIZqV6Vg9By/bFdFeYG1fa+30at8wxbWnLn
 DERdPRBExLnIOtzUYLCmTf0Ow9uPoTDbJR8PDzvZ7At3tFhYhKUI+WYHwR497HhgFkZg
 2F+8bh+NolQBic8xMWgm/lF4gLREpfUH7sZdyj3zL4eBS2NSqKExzvkYByW/gjadba22
 neiR/5BvePV57TlIpHxWvsgA2WQXqCy29XkupmP1acDGybXNXHY1YQ7GyxsDXf9Q60Sl
 gAv6pS34Aoqh4XeJXcRpo3GFa55AFyFmXNrSpHD1UVgYt2gBwL3f9ZF0hQI1tcvkb4Md
 FZ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779792598; x=1780397398;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9y9wZpGNY0ig4+RNsuCUqB9qSvM9dhhqbzXdUoQyxmI=;
 b=aSvJhFZNqi2Xb89GrAIQ4OVXJ+Bo6MuM4ET59KsmW6btc51A/j9rU4TNkIhbmfC4zY
 S2s8xgpoC/ejHDdS9RJ3Pxv1j3TpdzIfDxClq1UrSBKYsYta0ePpyNYiv6PkFpF+SqoN
 8whdqZLjo/Ypyrwr8GlmBzQmt6xbIagwki2t9ZXt0z7z47TTiUn+1bBCFY06t3t4PZ5E
 +SNFoLE8iv9yjz+vZ6Gp2BF1hcJ39GMa7YwJ+LeWNPMc6Zdsj9Pj9Xe1lhy9EYoabg/X
 cfsNvqEWYDAOL8BCpsWmlWNOEbwelE3XLkDKt0ppUkism8fi2wgEt9qgMN4cMk9Mts4q
 2EJA==
X-Gm-Message-State: AOJu0Yxw+qFxpxkad2ZUn76m4kyiw0eS6/aHdui87gRZ4EeVrBZaBymX
 f/TXCSCMymcETnVYLeb57EPofXI3Ase4jKVOOrL/Wr32KREciZ6eyDHFIEe+cNjVSHkOxD+xlcU
 UcjlEmvWFePWEnKpaQa7u9Qu/UZEnRlXySzxRZ1gESg==
X-Gm-Gg: Acq92OGBoNYbup6vHXkGVKHbEHM805yqjDVSSOaoxq+oAjutBTMmXRNg5L5aWxx6bN0
 /eY9l8cZ42VvloPyar7dpwK5UwPmxGg+kL6qJ4ZwXrYNeI/FWW/AZ3KeA3r3iUa4+KQPF7/aSET
 TDGCJSWzlhDfX3JqMNM2PfSAj4Zty8Zlws9jM1CNzy/0vYw/rwpu02sjDOtrBt2IvtG8vGXir9h
 eQzx1ueazW3XNOf7+CY5+oUDtWbj4gXcFFxRSJVC4faukbZUUQzbZoYcrLA67ilOKyjNrEXDqSk
 SwExEcACONCrUMrodD9ZN+iECqUy5Jg+s8CD4ewBDr4strr2wPwYV3+CrROjuxatjsM=
X-Received: by 2002:a05:690e:1507:b0:652:53cc:dfb3 with SMTP id
 956f58d0204a3-65ec99cd958mr14903882d50.52.1779792598363; Tue, 26 May 2026
 03:49:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260526104102.5283-1-deller@kernel.org>
In-Reply-To: <20260526104102.5283-1-deller@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 May 2026 11:49:47 +0100
X-Gm-Features: AVHnY4Jm3TBzfqe9TqZMGRx-BkQ18s_VsZeFxphCW0aELkUsbDxYf3boo4Z3-r8
Message-ID: <CAFEAcA8pOxmrfMmO7e_igtuGFpvCjDW4dzBOJys=dy7rXt1A9Q@mail.gmail.com>
Subject: Re: [PATCH] linux-user: Fix typo in function documentation for
 pgb_addr_set()
To: Helge Deller <deller@kernel.org>
Cc: qemu-devel@nongnu.org, Helge Deller <deller@gmx.de>
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

On Tue, 26 May 2026 at 11:41, Helge Deller <deller@kernel.org> wrote:
>
> From: Helge Deller <deller@gmx.de>
>
> The third parameter is called guest_hiaddr.
>
> Signed-off-by: Helge Deller <deller@gmx.de>
> ---
>  linux-user/elfload.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index 0e757787d2..f7625c0952 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -848,7 +848,7 @@ static bool pgb_try_mmap_set(const PGBAddrs *ga, uintptr_t base, uintptr_t brk)
>   * pgb_addr_set:
>   * @ga: output set of guest addrs
>   * @guest_loaddr: guest image low address
> - * @guest_loaddr: guest image high address
> + * @guest_hiaddr: guest image high address
>   * @identity: create for identity mapping
>   *
>   * Fill in @ga with the image, COMMPAGE and NULL page.
> --
> 2.54.0

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

