Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B298BC67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 14:01:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruC1Y-00072Q-Lw; Tue, 09 Apr 2024 10:00:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ruC1J-0006tV-QV
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 10:00:21 -0400
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ruC1D-0004OG-JF
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 10:00:17 -0400
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2d87450361fso44217641fa.2
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 07:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712671206; x=1713276006; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+lCs/PCN91N9C3zJ0fBleuXeCV1UwcWxGT+Kv0IgR+k=;
 b=XPu6byVeoO1sTMcRUArUpgp3tc+GVLi+M+D92//NVoWRuuE2N/IiIQpweghI+pYcet
 s8kG38qcjzuXxkGyyYbVyFmuHgsfxRDeYpVUhU6xQ49lVi2Gq/fvc6acd9fLI+lcPSnZ
 e6A+FnbqAN53XsnDHuJDAw3HoSNbBMrhi/tiAXHUnmzDwOUdxoWRyZ+YrikDA8Lfllf2
 uL+vc4W8kCEvKM/pH34VMPO5rmWAfJzEQwEHc/ehX0Wx4BR/EOLAFsMczOz3Mv6uXUFp
 PS8JXQQ0yhzGAjSHeUuAhlHEseriwTfcHhgibYwCPnKYULlnZqmJeAzL5PZ2Y3t/ZHoN
 NuUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712671206; x=1713276006;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+lCs/PCN91N9C3zJ0fBleuXeCV1UwcWxGT+Kv0IgR+k=;
 b=IyAFYOuVORR23UJZBLzShuNytf035Y9GnIOyltxfRXrAESzLy9tVxXnjobkMer9ANQ
 FK7w35iF7ERHtZIwlpYVh8tBEH7MIYBnRWmy4CSNK5kW3Kw4pF1GpeCrVBuE0XQWYLup
 p3FbjeNcoUzDl4462FQ9g8pnSS+PzDDmhZRO523XCFB638LGepgRjYjrePDge/3MAhwP
 x7uQNfFJnqyLrUiGB0AYGzdYJT7de37c4UAiQxq8VnM6BagvTWSxCLV5VYWxb//z0pE3
 +E/yfpOFCVQ+qi//lWPaSUlcjawBYvklu83BvaJ0u7hSEyS/9C+sFA/P4F8A/AmVAkIq
 a5nw==
X-Gm-Message-State: AOJu0YzTjpsciPzWhw8ZXvOnjhyrBNFp1mdqIGZ5tOd4g37KL7+JPhsb
 +RUU+LQ7+rbFDtgtRQhGKT0eXoC8Ky6AL1NjftCSdVrMcfhYRPvVb5hpD5wsL9gACrcmpTsYWR5
 MTXYMDjEQmWcHDeIlmg3fDLjaz8OXjHoOR+IxjA==
X-Google-Smtp-Source: AGHT+IGPe8ff03guCa5UiunQr/L5rBkZ9czbJQsc04byce4PEa2c1ELH2piPQzyeLOWB5dVrQ6BP3EouheMZ95h29xI=
X-Received: by 2002:a2e:909a:0:b0:2d8:57da:c2c8 with SMTP id
 l26-20020a2e909a000000b002d857dac2c8mr8244757ljg.25.1712671206275; Tue, 09
 Apr 2024 07:00:06 -0700 (PDT)
MIME-Version: 1.0
References: <20240409133801.23503-1-philmd@linaro.org>
 <20240409133801.23503-9-philmd@linaro.org>
In-Reply-To: <20240409133801.23503-9-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Apr 2024 14:59:55 +0100
Message-ID: <CAFEAcA8eOnja8CYv2wD0VOqrZXMZmNRTyMbDOP_xOwHN=H=nsw@mail.gmail.com>
Subject: Re: [PATCH-for-9.1 v2 08/11] hw/net/lan9118: Use RX_STATUS_FIFO_BYTES
 definition
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Chuhong Yuan <hslester96@gmail.com>, 
 Jason Wang <jasowang@redhat.com>, Alexander Bulekov <alxndr@bu.edu>,
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22f.google.com
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

On Tue, 9 Apr 2024 at 14:39, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> rx_status_fifo[] is an array of words,
> rx_status_fifo_size is a word count.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  hw/net/lan9118.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/hw/net/lan9118.c b/hw/net/lan9118.c
> index a983ce193b..cace22381d 100644
> --- a/hw/net/lan9118.c
> +++ b/hw/net/lan9118.c
> @@ -262,7 +262,7 @@ struct lan9118_state {
>      int32_t rx_status_fifo_size;
>      int32_t rx_status_fifo_used;
>      int32_t rx_status_fifo_head;
> -    uint32_t rx_status_fifo[896];
> +    uint32_t rx_status_fifo[RX_STATUS_FIFO_BYTES / 4];
>      int32_t rx_fifo_size;
>      int32_t rx_fifo_used;
>      int32_t rx_fifo_head;
> @@ -332,7 +332,9 @@ static const VMStateDescription vmstate_lan9118 =3D {
>          VMSTATE_INT32(rx_status_fifo_size, lan9118_state),
>          VMSTATE_INT32(rx_status_fifo_used, lan9118_state),
>          VMSTATE_INT32(rx_status_fifo_head, lan9118_state),
> -        VMSTATE_UINT32_ARRAY(rx_status_fifo, lan9118_state, 896),
> +        VMSTATE_UINT32_ARRAY(rx_status_fifo, lan9118_state,
> +                             RX_STATUS_FIFO_BYTES / 4),
> +        VMSTATE_UNUSED(896 * 4 - RX_STATUS_FIFO_BYTES),
>          VMSTATE_INT32(rx_fifo_size, lan9118_state),
>          VMSTATE_INT32(rx_fifo_used, lan9118_state),
>          VMSTATE_INT32(rx_fifo_head, lan9118_state),


Ideally in the state struct we should have the arrays be the
size of the largest possible FIFO, not the size of the
default-out-of-reset FIFO, to leave the way open for making the FIFO
size be runtime configurable in future if we want that.

thanks
-- PMM

