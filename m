Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9133CCA0EF3
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 22:00:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sk9eb-0002GE-VO; Fri, 30 Aug 2024 17:59:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1sk9ea-0002Fh-B0
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 17:59:36 -0400
Received: from mail-lf1-f48.google.com ([209.85.167.48])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1sk9eX-0007Yp-WE
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 17:59:36 -0400
Received: by mail-lf1-f48.google.com with SMTP id
 2adb3069b0e04-53349ee42a9so3120378e87.3
 for <qemu-devel@nongnu.org>; Fri, 30 Aug 2024 14:59:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725055172; x=1725659972;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tedaxnU6laKLxR0hCGsHsw0sQPPhYdBpOF52KPVsM8k=;
 b=bJ0MnK/Hf8JgU2wd3vsaCZKkyXZJkfq/xGrHDaJlvW+Qn25/OwD+uWpFAnK/eZ4C/z
 0gJtinu9E8LgeY5+UABsB3U33GH//Xo55DIW4oWxiQRq0Fqvt3o6qumF4JXLQuAEC9mi
 k9TyDuvFHfMy5AHYPpcluldL2Z7aCcNY+5quMGfYDkhPG2+uD0UAsGoxSDRYnZLysKUA
 4nd2SnS3B17VGjirRfD2gO+xLe74eOxqv8HDLiHKbT14uD9RnRqrffBynHhQhIPmiY8C
 bRoBPLdVFrs3rYr0hb9NTkoz+7kYOHjxSz09xIRsHjp7xnbNbsy+mwSNO30uAzbDL8zf
 dFBA==
X-Gm-Message-State: AOJu0YxfxFFYOEmOTm1mVFeC9hOSmFcsJ2uEgxCiIQJI82GCOg1EKqzv
 onOmTwP9pc84BulcZIi63v10tVAOb+7vVRdu7fI9pUdBoJTDyhaI
X-Google-Smtp-Source: AGHT+IHmKSndt6IhW+ryxRya7rA09G5nqedK33s3UpcHaHU4TXzxygwFVoiAA30IQV3zMM+/jupjGQ==
X-Received: by 2002:a05:6512:2215:b0:533:4676:c218 with SMTP id
 2adb3069b0e04-53546b191c1mr2703665e87.8.1725055171271; 
 Fri, 30 Aug 2024 14:59:31 -0700 (PDT)
Received: from fedora (ip-109-43-179-35.web.vodafone.de. [109.43.179.35])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a89892221cdsm255475166b.207.2024.08.30.14.59.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Aug 2024 14:59:30 -0700 (PDT)
Date: Fri, 30 Aug 2024 23:59:28 +0200
From: Thomas Huth <huth@tuxfamily.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>
Subject: Re: [PATCH 1/3] hw/m68k/mcf5208: Avoid shifting off end of integer
Message-ID: <20240830235928.57e14c09@fedora>
In-Reply-To: <20240830173452.2086140-2-peter.maydell@linaro.org>
References: <20240830173452.2086140-1-peter.maydell@linaro.org>
 <20240830173452.2086140-2-peter.maydell@linaro.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=209.85.167.48; envelope-from=th.huth@gmail.com;
 helo=mail-lf1-f48.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Am Fri, 30 Aug 2024 18:34:50 +0100
schrieb Peter Maydell <peter.maydell@linaro.org>:

> In m5208_sys_read(), we have a loop of n from 0 to 31, and we
> calculate (2u << n).  For the n == 31 iteration this will shift off
> the top of the unsigned 32 bit integer.
> 
> This is harmless, because we're going to stop the loop with n == 31
> anyway, but we can avoid the error by using 64-bit arithmetic here.
> 
> (The SDCS0 register is documented at
> https://www.nxp.com/docs/en/reference-manual/MCF5208RM.pdf
> section 18.4.5; we want the lower 5 bits to indicate the
> RAM size, where 31 == 4GB, 30 == 2GB, and so on down.
> As it happens, the layout of the mcf5208evb board memory map
> means it doesn't make sense to have more than 1GB of RAM
> in any case.)
> 
> Resolves: Coverity CID 1547727
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/m68k/mcf5208.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/m68k/mcf5208.c b/hw/m68k/mcf5208.c
> index ec14096aa43..0ad347dfa81 100644
> --- a/hw/m68k/mcf5208.c
> +++ b/hw/m68k/mcf5208.c
> @@ -158,7 +158,7 @@ static uint64_t m5208_sys_read(void *opaque, hwaddr addr,
>          {
>              int n;
>              for (n = 0; n < 32; n++) {
> -                if (current_machine->ram_size < (2u << n)) {
> +                if (current_machine->ram_size < (2ULL << n)) {
>                      break;
>                  }
>              }

Reviewed-by: Thomas Huth <huth@tuxfamily.org>

