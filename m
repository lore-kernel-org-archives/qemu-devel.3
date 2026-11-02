Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EC1606A326
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 10:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ni/LrMjF
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNpU7-0007UM-0h; Mon, 02 Nov 2026 05:41:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNpU3-0007Sj-03
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 05:41:47 -0500
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNpU1-0007zk-GO
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 05:41:46 -0500
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-8b2d149b483so7205497b3.0
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 02:41:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793616104; cv=none;
 d=google.com; s=arc-20260327;
 b=WgYx4x5p7y44Wau9rvo/5+xxryCg3I6rgInmBwJYb2s4ZXc/0rU/BvkKjTaJhCLjjp
 nahiZraQvR4ARzmbUBil8YDVK6G2Zjp/0lealAONBkqhYN37i+dQxM/vd1h3rWa93s+R
 utVLmtK5fP08AdIGGPBSqcq9PWHeVULO2cxf3oX1MOZZgMEZppsRWGgtRziPq32kuOzC
 5dYlSs7O9naHoeRBOCs4RTo8EyWo5ho+0XfDB7y99aqdzmDGurWsJ+Cj2VtTkz/qQTxR
 8zoChAfNFXx/jlPNWfEKKJDrnpxCjGKJSplgTNk0T0R4z4VVovUk/EXHIdfaKWU/Nxa3
 55lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=MhWsz6CZ7C9QhkKweSDnzDjgrdEAs3cdco4AL/JHOIU=;
 fh=TYgLo6LSaCnSg4LxfB/cFu8QqHO9C1zPedgQPfry9ms=;
 b=oTF70tyyzdvi8NsGf85BvzCVJqxCESB/GPvTHG9EjfUiILK9HsDxGOdxjIj5u6d1AQ
 LwgjRDJx5v81eN4rFxLN1AjnS9Z5+UVCzRLOsY/ntEMa/rGsmyhyXuMpivXZ/cd4hYNO
 ilL6if0EXF1JgzBeADjzTWb76aScqU+nefRvJuhCCK+ILSgTh8GBZ6b3JDe5BH3xK3fk
 xNeSNqMDtRvlD809J+OOTQ+m9jNoTpOamV/OnapsTNqfpdaU9MwzcSVMrMXSZamkYHuo
 QT6Mn3mXPCrcitos/r4V4HjmZ+evldpca09K3HIajTix8znR+GzM4RT8DCFqMCbPqJ6n
 IrkQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793616104; x=1794220904; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=MhWsz6CZ7C9QhkKweSDnzDjgrdEAs3cdco4AL/JHOIU=;
 b=ni/LrMjFrYqtRUUAIAELb87PRe7Pp+CBNTXH2t9NAfDcFxJNdJBvmCYQoUmLHsMAaT
 bRWbj8dHelG+s3In64hZjLWQ+o6s2jsJ68yNzj8NkVhVBhzW9VlskbEjsYtdG6pKnzr1
 KkkbrGY8GxA1wVILupeFhBcvrhtsAzCv5pJ2mTzy2nOp9xug9z+3Bx4p05SGFdjgJbtZ
 DdfHRooJOYW6tTx8VDB95g7EvSNYiNh6IPzOFiGbxjKmq3VzMRBkYZDewUcIZTYRt1cc
 CoLk7nTECFMgSggGv1yy8ik7a42Qdj7vQV9R3GiJ1i0qeJVbJV7Aykqra/JSi+oFSP/m
 lk5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793616104; x=1794220904;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=MhWsz6CZ7C9QhkKweSDnzDjgrdEAs3cdco4AL/JHOIU=;
 b=gwLfXR7ZUWkr/qQ6Mf58mph0s567fGzqU8bNvL//Lxy2BERtWKSmzVJoEckzEx8hpa
 QA5v+e1pQ4dpC1jS25YNpjpFD/O8+xqZD0VxIB1Z7P9NMY+UF02a/o0HDHnEDBin2UW7
 eTfE/utQnoqm3/oLWSvROCeg5q4CVB6vZ2EevqWESbYA9U0AeDw50NaWJeMyyrkGdeWr
 gnXo+qMrsWKQfzGAZdPb9L2/0jt/PyVDkolfF/pqSrLN4w099faR5hKHkFbQ34zQhK7z
 1DLDZaP+VmSPiofrFE8a5qlC9VCdaqOvb0pS9Ip2Hg3+ADVD7aXNBTtcw8fJuIXV+dcj
 PrYQ==
X-Gm-Message-State: APuU4Z8xFy2tmiF6Y2zg8dR3rnOfDCOeT+aF7jEL8S+aN60VEj66Y31w
 qad6rkFjNLIAco/Lt8HSII3U6CeUWXlu+CdYcbiSYi+95C+bBlaLAcFSB3rAyTttVpQVW+N7rDi
 yLq/cC2+onS56C3tbPU9tD/Mxf9m4upUlEDgI2F2tLA==
X-Gm-Gg: AYBFou2p8Xz2h4URiBcyis8sINcwvyzv96p6JhzQ5qkqz6b6Ci+KGbI8TsdfAx7ZD5B
 2kSyl/qUljJ0Swl5BLR+lq7UffXGIQ42zLPFJYD7RNBguuX63oO4kCkfVKKnZ5x4hcg16QvrISY
 Y3STf6KRYzuF1YJ9CQJIPoaawivGDvpFVEzu0rVyLQybYAyWmVNZOS62xCI2xbBmhgTDILksvUM
 T4wooiK/lhVj7z1uq/XHb7aerLebOnyhCTpmKZhFAy9iPTEiXQRGGRFcMCocxZMkRzdZ9Sh0SXq
 RIy7PzodavfyYIeuqjK7jibWS1RCemvbt7iv0x2qyMnzrcgTcqQWqHDVUF2dsVinNVedi647O9s
 r0mu7PKq7b4fsO6k+yKPsppd1cabPvIN7Jd7Dge1KbKA/GNp7GaJY2iYBDhhD5GR6iR3uuRlq0k
 4zQxCFW8boJ6c3WMwMIWfg
X-Received: by 2002:a05:690c:6d12:b0:8b0:e7df:dd4b with SMTP id
 00721157ae682-8b2b671f3a7mr67672897b3.35.1793616104156; Mon, 02 Nov 2026
 02:41:44 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <cover.1793613972.bcm2835-fixes-v1.git.lorandmarton.dev@gmail.com>
 <0deb097d24128afea6839a2d6e222c2cf33de45d.1793613972.git.lorandmarton.dev@gmail.com>
In-Reply-To: <0deb097d24128afea6839a2d6e222c2cf33de45d.1793613972.git.lorandmarton.dev@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Nov 2026 10:41:32 +0000
X-Gm-Features: AclHuK_y_5ZeKVuz-2dYgJchdvP6EIYDiDoH_ZGI4-YdqXjeCnOYnoOjBSkpOh0
Message-ID: <CAFEAcA-WTv10G6PZmKke8CZWrMJ3L8pUwVYqJCY3QPVSHkL1eA@mail.gmail.com>
Subject: Re: [PATCH 1/5] MAINTAINERS: list the BCM283x qtests under Raspberry
 Pi
To: Lorand Marton <lorandmarton.dev@gmail.com>
Cc: qemu-devel@nongnu.org, philmd@oss.qualcomm.com, qemu-arm@nongnu.org, 
 farosas@suse.de, lvivier@redhat.com, pbonzini@redhat.com, 
 alistair@alistair23.me
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1129.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 2 Nov 2026 at 10:13, Lorand Marton <lorandmarton.dev@gmail.com> wrote:
>
> tests/qtest/bcm2835-dma-test.c, bcm2835-i2c-test.c and bcm2835-ic-test.c
> test Raspberry Pi devices, but no MAINTAINERS section lists them, so
> get_maintainer.pl names no one for a change to them. Add them, and the
> BCM283x qtests that follow, to the Raspberry Pi section.
>
> Signed-off-by: Lorand Marton <lorandmarton.dev@gmail.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3b12ba90f2..fd08d80aba 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1046,6 +1046,7 @@ F: include/hw/*/bcm283*
>  F: docs/system/arm/raspi.rst
>  F: tests/functional/arm/test_raspi2.py
>  F: tests/functional/aarch64/test_raspi*.py
> +F: tests/qtest/bcm283*-test.c
>
>  Real View
>  M: Peter Maydell <peter.maydell@linaro.org>
> --
> 2.56.0

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

