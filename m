Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7D6ACCF9E5
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 11:43:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDLcE-0004cv-2F; Mon, 27 Oct 2025 07:42:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vDLcB-0004bo-Lj
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 07:42:19 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vDLc2-0005kH-JP
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 07:42:18 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-b6d6c11f39aso622055866b.2
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 04:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761565318; x=1762170118; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DTuxr+0WunDSxx21Sv1eT4VTnRR+nuGv5Jqhw5TU5Ow=;
 b=vsT4/LJcPtbu4CSsLqqlYP25vHAAnKEbZvyzK2aAHgwa+6KqqpnEbW64wM5NE4g16F
 bsuv6PbPQ42+KagS0ReJcLO8aXn7o8xYr7Z/cWvbhSeNFWayO6bXu3SutJ4Ni1Ktwsm7
 dHWeCfCC8KofeNWKwA/uWxz4gMAPTHgzcguZK+jVmw4FOAvxV9tcr5aV88iLhaRTzKsG
 DVlEGoqxbQ1iQN0+ZJvqBcZ90Oed4fw18MRSEDeqHQxFxew9aGC5adG84R+p0nLObzoM
 MrfrTPm/g5mFc60d7mxTMXFAqbq4NY5A+u8UbrD08bK092PUCGLBEoOFMWDNrH3Fetuv
 2/9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761565318; x=1762170118;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DTuxr+0WunDSxx21Sv1eT4VTnRR+nuGv5Jqhw5TU5Ow=;
 b=WX1A6X6+EYCADUi5JGk5MmrNGsRWOMiWghAG0106uRhbjQjxP2bGkqSlpN5BjD/TAf
 5u6ugA2APvXz1dTl1+dqaeU8UNPsit9yqP16pW+wuXbWib+boOO4OIc8V1CotUqnDC81
 tyiPmmQidFPC5PwTq0BT6M/cDlKPdHIYf83p+eRGy8XI1yiYE8VKkOuOQ5fBqPE4Gmfg
 GKaPNlxJ2Pj2bmYhHGagm58AZLsKSPTtXeYMbBrmhuwwphOOz/oHBI0yK+KTFDXBK7+E
 k9uSMxfro/hsMMKcgu42iIZzRjZ0SxnP2Mm+3ZRzUz5Sys495SWFiP1fvuW/nELu+W0M
 RBow==
X-Forwarded-Encrypted: i=1;
 AJvYcCXM8+PHpidxOdn4dmUoE7VLbziow5L/SWzVfRl7wRaOJ+ykND2wEdXKthNK+Q9TcgNRW+FY29AOumn5@nongnu.org
X-Gm-Message-State: AOJu0YwhR8d6qLtYelD3t1FyQTPV5KF9/NdLD10IP33kgHUQ3w6sEjys
 W+dY9sZu6nU7o7QLbv6nGnj3n2SnWdXQPsPck9XpNk3IGLzE8a9FJMh01P+6L+3/bBs0d1SJHKB
 sFFX/2HDWZ2hRRd/SOeRDwZIvV3zNS7BKMcjP25hTzQ==
X-Gm-Gg: ASbGnctfIZSFXwCbG7uXD9IYuwU+8tIup7fpdezLIEqONDLRcIWo4MDIwuw3VzOH3K0
 O+y0XDtOaIZgm8zTvzkk64Z2LNar2O6vRpe+KfRF950vG279oL6yAwzyKBfLBQom+pfo4rq+8hE
 Y/WufViHN9Ci5EjVPXQV2kc973DpxWXliw3ZPKVBpEiX5hQKlKRpOZQhlXU2fshAknoqWz6M4Iz
 6ikmNNECaXc7GuTR4446/8bPpAvmRzjCAMpdL8d+BcYtvH0CUyowIuHSmB2JQ==
X-Google-Smtp-Source: AGHT+IGy7wcYAGVsLQ6c5IT5G0qXr3AampUAm8xd3E8RamHomHLw4n9d8AhGQmO3Z6yPEQkMf/uNQNwfL27gyaSiTaw=
X-Received: by 2002:a17:907:94c6:b0:b6d:3de6:b729 with SMTP id
 a640c23a62f3a-b6d51c3102fmr1558234866b.51.1761565317558; Mon, 27 Oct 2025
 04:41:57 -0700 (PDT)
MIME-Version: 1.0
References: <20251027075123.2237914-1-quic_haixcui@quicinc.com>
 <20251027075123.2237914-2-quic_haixcui@quicinc.com>
In-Reply-To: <20251027075123.2237914-2-quic_haixcui@quicinc.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Mon, 27 Oct 2025 13:41:29 +0200
X-Gm-Features: AWmQ_bkTkZDLlwZfi0xQlSGCsXMDOLbBOKly0s_kIFtNc9pQW76443I-TZh4EKw
Message-ID: <CAAjaMXYGcVdY9Y7xx_aXo0K+0t+FvpXP5Zwq1nfTnDKZCCVgBQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] standard-headers: Update virtio_ids.h from Linux
 v6.18-rc3
To: Haixu Cui <quic_haixcui@quicinc.com>
Cc: alex.bennee@linaro.org, viresh.kumar@linaro.org, quic_tsoni@quicinc.com, 
 qemu-devel@nongnu.org, mst@redhat.com, zhiqiang.tu@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x62a.google.com
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

On Mon, Oct 27, 2025 at 9:52=E2=80=AFAM Haixu Cui <quic_haixcui@quicinc.com=
> wrote:
>
> Synced virtio_ids.h from upstream Linux kernel using
> scripts/update-linux-headers.sh.
>
> Source:
> - Linux commit dcb6fa37fd7bc9c3d2b066329b0d27dedf8becaa (v6.18-rc3)
> - Author: Linus Torvalds <torvalds@linux-foundation.org>
> - Date:   Sun Oct 26 15:59:49 2025 -0700
>
> Signed-off-by: Haixu Cui <quic_haixcui@quicinc.com>
> ---
>  include/standard-headers/linux/virtio_ids.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/standard-headers/linux/virtio_ids.h b/include/standa=
rd-headers/linux/virtio_ids.h
> index 7aa2eb7662..6c12db16fa 100644
> --- a/include/standard-headers/linux/virtio_ids.h
> +++ b/include/standard-headers/linux/virtio_ids.h
> @@ -68,6 +68,7 @@
>  #define VIRTIO_ID_AUDIO_POLICY         39 /* virtio audio policy */
>  #define VIRTIO_ID_BT                   40 /* virtio bluetooth */
>  #define VIRTIO_ID_GPIO                 41 /* virtio gpio */
> +#define VIRTIO_ID_SPI                  45 /* virtio spi */
>

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

>  /*
>   * Virtio Transitional IDs
> --
> 2.34.1
>
>

