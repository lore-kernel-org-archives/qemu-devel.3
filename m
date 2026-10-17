Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 288A7CCF2C1
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 12:42:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xI3jv-0008LD-ND; Sat, 17 Oct 2026 08:42:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xI3jj-00089d-J0
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 08:42:13 -0400
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xI3ji-0004Aa-4s
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 08:42:07 -0400
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-679965fb848so790331d50.1
 for <qemu-devel@nongnu.org>; Sat, 17 Oct 2026 05:42:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792240925; cv=none;
 d=google.com; s=arc-20260327;
 b=HkxWRUqX6h2mkP6+MMZ4lpjb4Z0QMPwhSlvIciAVYrJHIJEYKSQi8lroeGh+Qbla00
 PBcgr9043wQYedTU4wxO+3ww9m929T3nOiCGLVlddvVPZwTvljMQcyuguWZP8CgeNkt1
 vAMN/kiGx1XS8vGRIBclgLQjlISmiTYtMm7PeCxv7BcGZOuioZOK4BAkrM+pjpOXRLqf
 Vduzyd2QjYJzj2BIjPXg3F1xg1RQ0dJMBBOjmfHYDL9K0L8MpsHzaDi/sgKAb+G0jYl4
 Qv5Sy9IBBFqUtnOPFF5Nu1bXDOm0m/hdGQVYVSIa7qYBjQtMruWumF8390GN9UvNNlVW
 M7Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=TNjtibBQf0l5DDWWq6EfcgjI+8g6A9kd4BHUDWDDkpE=;
 fh=TUfzxw1B/DFEA1jNT0iQFdzEda/YXFE68WBEXYJToV4=;
 b=sN95Sotd7ckeb3IuOyz/iBp5Tke3wGZlmJ1uvqDuxZj6hkKnsYD/xR6gSwcyjOWbK3
 YorJyJ9XNxPpKcvtxd6vLeyPfomYIXq+fVfxVEvqTk1MfOAW9W/piP2NTAvETKAUwaeA
 kyLOaYn6fgR4qW0+hW5195otAyB/+zqIBQUfhtgXDdOhYXY7tKqHwp5mfHDakag7qqV6
 meTh8GDm/vuGpD2wy1TyI2SYEF5Ho/iFJM0rKkM2W3A1KLrIzp2b5iXFuTxKvJNSGFGn
 JPkcf1Rkn4tAq8uTpBxFB8xqlxr/c0F84Hy54M/DyZbOEAGlUxtsnmMkwkcD+HWXMzYg
 2Z9g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792240925; x=1792845725; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=TNjtibBQf0l5DDWWq6EfcgjI+8g6A9kd4BHUDWDDkpE=;
 b=xnxfRWe/VFlhNVRZ01vnOc6b0sF2Wfd2tIh6tWbaibOgLhdnmwWrqK0YX/9tffLFEt
 toe4jVTAx4IfZhlVo1/1cV91VXVac+zI8Jbupu0wKFyFXDlDANBK4IE7q7JCTLIm+WG9
 DRvFAi5IEbUA7ZrfWWeK1zRDALiOYllFBqP4CE95vs8s5dD0k81iFo44OcJK+tdK33+c
 q+CDJ5Bu8oe0F+7c3zINymkUFo1kt1igTDbHI0QBTLEwTgNLihXYqu07vfgY/eHirzmf
 rM8jqP4QZmC1qHChXPAUrKB2cn29Z0nrs0hw/QFYKpekAIyNdrAWnNPEBZDSok++nUGe
 Z8aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792240925; x=1792845725;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=TNjtibBQf0l5DDWWq6EfcgjI+8g6A9kd4BHUDWDDkpE=;
 b=P7NmajkrZZDYQODuPb+iUMtvj2T1moSSnkSQ7QmOOGcGD89A/pbO9ICE9335Kj5yGN
 4dzC0GoopuZTX+5Z9rzd7WhqgHniVrlc+ukmsLPaJiESTFPo/4QJ6R31znsOWItDswhU
 dLnUCnMfdYlBW+9GOaYqtKz/s+z1WdVL50SJZb7Bi8icL4Af4A1Cbk2WwLq6ioKiCz4s
 cwYMABmscZ7K0P+iQBW9MUHBkawofFXEDLSzJKeLVUk/ot/L2R6hSFTBJsaB8iqNVsCl
 68wQZAUQ+0HMAvlVn6/llkvbA+dUQdxD17Av9wdR8NQ2LTuV2r+m4dM9bsIERtP+0laF
 vUpA==
X-Gm-Message-State: AFq9FYIWWGGuM2spsd0espxUtxu5GuCb08a44+P3R3pXuFsoUqMlODS8
 qPqvr8/ToeWgA6Z17pBlZPqzgAlIRY5gq5PTtdC5iV5qWDn5KszNWl8MDt35jXZBs4ELHXOH7I1
 VmvpktGqazZg940WrYlnIaCXqK0vHRSAHWzSJBqTsJw==
X-Gm-Gg: AYBFou0S24OkPvuVyilYOAo2xU1weOoeMC0UUe4VwzH1CnEjGvA7Ktq1LKyzOHlZsG+
 WpEjzQvrdnk54VQQt92n54u0r0nkenwxZYVEryGy4olcowa2OjLi+wquWTjXTBUCxOBDRiv8Tv8
 nxAhPQcUCRjYAQ3ovWM1Gu+SP8sWY+R4+NAvh5me0JeTD1PaIekS0JqhsvICU3FoJe7Qu1JYIng
 3c0anR3UeNTdX2lNKJREwXZwKkhBA4CNjxxYuqSHmy7SpUwuavfwCXel6TKyVpSm6fUe2LUFU5o
 MgaT5Ll9iFqPmBvZrnLd6JK3gOzLXjRCwlOerevRvPFUCU+DBqcBeKUhRqoZAsbYLd5wosYPNzJ
 4CPhY1aOGLYRFhsi2nHjUQOlk08xUZ+HuwSN/EZY=
X-Received: by 2002:a05:690c:15:b0:89a:63da:fa8b with SMTP id
 00721157ae682-8b0f2208ed3mr9226377b3.70.1792240924680; Sat, 17 Oct 2026
 05:42:04 -0700 (PDT)
MIME-Version: 1.0
References: <20261015181122.60608-1-marcelomanzo@gmail.com>
 <20261015181122.60608-10-marcelomanzo@gmail.com>
In-Reply-To: <20261015181122.60608-10-marcelomanzo@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 17 Oct 2026 13:41:53 +0100
X-Gm-Features: AclHuK_yBBZsqqS76yrkVs4BjNTtIshJKyc2WdSO36G_CQWD7Zi-CA_z8f2n1Zk
Message-ID: <CAFEAcA9N1v7wX_qr2_tPCVhzmGB8QXoOU8Gj9ZGATOD1RpUd_g@mail.gmail.com>
Subject: Re: [PATCH v3 09/16] hw/net/bcm2838_genet: add GENET register access
 macros
To: Marcelo Manzo <marcelomanzo@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Sergey Kambalin <serg.oker@gmail.com>,
 Sergey Kambalin <sergey.kambalin@auriga.com>, 
 Jason Wang <jasowangio@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, 15 Oct 2026 at 19:11, Marcelo Manzo <marcelomanzo@gmail.com> wrote:
>
> From: Sergey Kambalin <serg.oker@gmail.com>
>
> Add offsetof()-based byte-offset macros for the register block
> layouts added in the previous patches (INTRL0/1, UMAC, TDMA/RDMA
> and their per-ring registers, HFB filters), used by the MMIO
> read/write dispatch implemented in the following patches.
>
> Part of Sergey Kambalin's original Raspberry Pi 4B PCIe/GENET
> networking series (patchwork series 829638, posted to qemu-devel in
> 2024, never merged). Carried forward and completed by Marcelo Manzo.
>
> Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
> Signed-off-by: Marcelo Manzo <marcelomanzo@gmail.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

