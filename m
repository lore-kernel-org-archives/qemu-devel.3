Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 426D4C4828D
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 18:23:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVbhT-0001wq-0b; Thu, 01 Feb 2024 13:22:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVbhR-0001wf-CU
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 13:22:09 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVbhH-0001fx-Ka
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 13:22:09 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-55ee686b5d5so1732365a12.0
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 10:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706811718; x=1707416518; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=91BllZ7POQ90lr6bMJfgFD6cEaGrdm2GYAT6IrOL3PU=;
 b=yZhLCJLmJkGAhl6qa4fqkt1x9gX7JRsXd/m1g/32D+HeCzjjot+ZYa3fmE1kQEh9HQ
 OnAxHfOHJE0/Ii9YSXaHEhiFM2kIeywlAzfhZRYmtKlU3UaGtxUvCc/pqzMzgsllztas
 uufc5cfOMHPzaq5g2vTaQmu2yPM676eUlVOv3M9ugiYBAwolgmTegNHLxrB1gmg/gtJb
 gKlXL/zUCVsOpiYxmP0iuKQvjtcG6aec7UfFOFJrU0Suh3cqvu2l6S3ipHtb0rd8VeM2
 O/ZFoYfA+DC7BnXQtDaCdCWujVLQuzMjquGKg4Gs5aDHyAsHGISX14RnEPSI7CReXZqu
 lz7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706811718; x=1707416518;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=91BllZ7POQ90lr6bMJfgFD6cEaGrdm2GYAT6IrOL3PU=;
 b=SAbNurrkOHl7gi7Ccsgalf3QbKXKnQy+9FarHFyr1+qze4Sh+qr4et/ztpKlQbx6c2
 AtEp2k9vIVuZiyioJjAjsnJFO4ctHlKWQXk087b8xJUQaaBP4H8zk5dKimRuFHBRtCDz
 2L1mpHIzOlypX61+thYjAu+qj25Vq0WEvyuzVgKNpkGpJ/+yczjZQEOKySaQjlrKCYhq
 RSHj91mpb8GMx5Lri5HuYbKwJF7xOe37xxkAT6kLK+4oa1jEXEOPqie3r+kQJnFhRFSL
 BasFDIxY1RBGFPkXK/5eqt9V4o42obdiqrTOgd6KQ9NX2VZM6RMUd2rOfuZ9NJcx2HgT
 bk3g==
X-Gm-Message-State: AOJu0YwRAkbscM6qn4VDJPjZRKYZPs4rALFQOOLtz7a+Zi7Qf3qDhJ/g
 aunyaeGkUO62b6sTgJjHYmsmMc3JfrCjVuifh0Pk5IaXQi2aGwLP4Kx2tL1rxHBMPg+ktFNk5Hq
 eAPwXoCGNKZlBQNpTLTvZ/xUDkIupTc3VSyXU2Q==
X-Google-Smtp-Source: AGHT+IF+3w2ejJI2MKS3rlCU9L6JzUAVhxTtSClJd4qzRb3KZkR/+FlUb9LlXyNRN3o7v8FZzMohKkiyAWKWPBnDT34=
X-Received: by 2002:a50:fc19:0:b0:55f:e4b3:4b73 with SMTP id
 i25-20020a50fc19000000b0055fe4b34b73mr136512edr.39.1706811717739; Thu, 01 Feb
 2024 10:21:57 -0800 (PST)
MIME-Version: 1.0
References: <833CE971-9EBB-4B41-8CFD-6DC6827FDE4C@gmail.com>
In-Reply-To: <833CE971-9EBB-4B41-8CFD-6DC6827FDE4C@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Feb 2024 18:21:47 +0000
Message-ID: <CAFEAcA9LrexR_OZTXfC5CxsjDya3fJiw53y95K6as+iBc2MA-w@mail.gmail.com>
Subject: Re: [PATCH] Avoid unaligned fetch in ladr_match()
To: Nick Briggs <nicholas.h.briggs@gmail.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, 1 Feb 2024 at 18:11, Nick Briggs <nicholas.h.briggs@gmail.com> wrote:
>
> There is no guarantee that the PCNetState is allocated such that
> csr[8] is allocated on an 8-byte boundary.  Since not all hosts are
> capable of unaligned fetches the 16-bit elements need to be fetched
> individually to avoid a potential fault.  Closes issue #2143


The way to mark that a commit fixes an issue is to have:

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2143

just above the Signed-off-by: line.

> Signed-off-by: Nick Briggs <nicholas.h.briggs@gmail.com>
> ---
>  hw/net/pcnet.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/net/pcnet.c b/hw/net/pcnet.c
> index 494eab8479..ad675ab29d 100644
> --- a/hw/net/pcnet.c
> +++ b/hw/net/pcnet.c
> @@ -632,7 +632,7 @@ static inline int ladr_match(PCNetState *s, const uint8_t *buf, int size)
>  {
>      struct qemu_ether_header *hdr = (void *)buf;
>      if ((*(hdr->ether_dhost)&0x01) &&
> -        ((uint64_t *)&s->csr[8])[0] != 0LL) {
> +        (s->csr[8] | s->csr[9] | s->csr[10] | s->csr[11]) != 0) {
>          uint8_t ladr[8] = {
>              s->csr[8] & 0xff, s->csr[8] >> 8,
>              s->csr[9] & 0xff, s->csr[9] >> 8,

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

(The whole function feels kind of clunky, eg I have
a feeling you could index directly into the csr[]
arrays rather than constructing the ladr[] byte array,
but this is the simple fix for the problem at hand.)

thanks
-- PMM

