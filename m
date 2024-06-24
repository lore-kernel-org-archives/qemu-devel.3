Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8CCFC2D0D1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 15:42:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLlpf-0002nP-92; Mon, 24 Jun 2024 11:42:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sLlpd-0002n9-Lt
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 11:42:13 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sLlpc-0002mb-0P
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 11:42:13 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-57cd26347d3so4783276a12.1
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 08:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719243730; x=1719848530; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=E6ISa8+Qw+F0SnhHbSOOPpnlg7ypL2Jw8gPcbTV6Sto=;
 b=ARoxe1oSO+evPlwPHrvDdCN+c7sT8dnFJY6WzMAV6EFbiZ2YJKAgAgTw2m3T4KEogO
 pY2bAtixcFjqNW/5kax/G4eLJ8+qWxpJgGhb90zDNYr2gB9RrRJaXl2c6/Na/CvNbH9N
 1iLIxlfojpNyqdhxoUJp1oPAFsKXcYOB1oyo3cOyffHWBK/zfrcHisCwFHQHa1flaQSD
 q01fIcQXZrIJMnIupJjGG1hHHc/7WpPp106/KBMN6SFCFtmBynad1VjlLz7nB28HkGWr
 2C1bAS8vvhJEORh0iH7ifhhzwmJ+VqdVed48GE3GVTO/Nghsui+klO+i8kAI5dYDz9nA
 NNUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719243730; x=1719848530;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=E6ISa8+Qw+F0SnhHbSOOPpnlg7ypL2Jw8gPcbTV6Sto=;
 b=QuSmZiBNkl7234BkQ57E0w2QSEg71UlLMjyKLwEXnmeUi7sG9CW6nMClTnRZ5h0Tny
 i3TBUhfjicF4CGCEA862ouRvk6xkQmSHRkL9Mn175hJWtboTwRd5lyqedEC8/fEpU2Gp
 0tGWQ9iWfSFa4yxvVhUe5RUVafzvBv4Ssb+Qybr10V/BIrurIvvbVS8b73bGzjfg9dpH
 l1Z8jD/zuzM7lMJf4FIrVmB9hL03VIXs0sR7nhPzQ1lCqWyWNnyvFZCRVqw01Jz2Yq2h
 +21hP2K1Xtz5as1U5vCt+zqX0Tm5wlGgwaVcZnwiy+66Fg5DXWLpvf5IFRlL90Fm0/PD
 9NPA==
X-Gm-Message-State: AOJu0YxflUVHq/GSYcAbYiQ8EnJ1UIzUV4+LBvXdLVRq68VNHKjbH6JA
 I9erW34w2A5w/Hkt0X8A128w7HujvH4dlb26wZfS5LhAYMQ4M4s4Iqm8ZSLqQ5rtpmeXL9MOehG
 LBpFbJOgwNkbFcldQMtLqx3y15mbfJ+vdFEUjuLYoohSErP98
X-Google-Smtp-Source: AGHT+IGA+3gMHcvf89knvnrlKHjJS/xJ4+QDVKj+pOyx22HllTyQgeI+TldxkYYhG1jeT/9V8Oy7VxaWoEJDAP0mX8Q=
X-Received: by 2002:a50:ab14:0:b0:57d:2659:9141 with SMTP id
 4fb4d7f45d1cf-57d4bd83465mr2719496a12.24.1719243729977; Mon, 24 Jun 2024
 08:42:09 -0700 (PDT)
MIME-Version: 1.0
References: <20240624153950.350-1-shiju.jose@huawei.com>
In-Reply-To: <20240624153950.350-1-shiju.jose@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Jun 2024 16:41:59 +0100
Message-ID: <CAFEAcA-UR7a9Se0f4W+naLrXrvMCeFNBCVYq=--wROM2igS6eg@mail.gmail.com>
Subject: Re: [QEMU PATCH v2 1/1] hw/arm: FW first ARM processor error injection
To: shiju.jose@huawei.com
Cc: qemu-devel@nongnu.org, linux-edac@vger.kernel.org, 
 jonathan.cameron@huawei.com, mchehab+huawei@kernel.org, tanxiaofei@huawei.com, 
 prime.zeng@hisilicon.com, linuxarm@huawei.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
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

On Mon, 24 Jun 2024 at 16:40, <shiju.jose@huawei.com> wrote:
>
> From: Shiju Jose <shiju.jose@huawei.com>
>
> Add support for QEMU based FW first ARM processor error injection.


> +++ b/hw/arm/arm_error_inject_stubs.c
> @@ -0,0 +1,22 @@
> +/*
> + * ARM  Processor errors QMP stubs
> + *
> + * Copyright(C) 2024 Huawei LTD.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2. See the
> + * COPYING file in the top-level directory.
> + *
> + * SPDX-License-Identifier: GPL-v2-only

You missed an instance of gpl-v2-only (but you don't need to
respin immediately just for this).

thanks
-- PMM

