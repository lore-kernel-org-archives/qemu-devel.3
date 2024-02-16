Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5E9FC48260
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 14:50:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1razXJ-0002CU-1w; Fri, 16 Feb 2024 09:49:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1razXH-0002CI-5y
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 09:49:55 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1razXF-00063r-BZ
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 09:49:54 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-55a5e7fa471so1045271a12.1
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 06:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708094989; x=1708699789; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7VibctzhXdSNGnPmq/82XJ2FrkBgcFpo0v0gHF0RsXo=;
 b=YSS2sLLaQahq3vpIDKDk/HQCh9AIFkOLLNAcZDIZLQB7dLQ6dTzh7hfclzbXFSVGlu
 dyKjThkVKiLPw9pbpxmLAm6hrFx69UOh8PUFNGDSvJ4sQBfoAIbjYb7JME0uy28Yopk2
 R/FjkclDe0CElDe23v7cQLvUyLPioD3BhFKi+z0PFxaWFBlYt+63fCfNpNB7ZaDN/1g6
 0LwQC40qNm701CbRZHwoaaEJ2gGwyoau+yE8599jgI4dw2xqpbhaayhOuQ3BLmQ7rA0a
 4CCOSWcHAE3iezjtYcIjUrZM8J0A/ZLzPb8+PG1r5OsbUoKKhB3M+3nACkSXort1B8Io
 G9vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708094989; x=1708699789;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7VibctzhXdSNGnPmq/82XJ2FrkBgcFpo0v0gHF0RsXo=;
 b=X5G4Hqrkh/CHMcjYnwew5GAWXaGM7UZrGTAficFHC6qD4U/QlPYY56WtBSQslIUaAq
 ia8uwnqx/F7vWn0hJy1PTWyWPWRFWMQOM8fqGIppO8HhfFmKQEHhnLrvEB39RQOxytQk
 KAlenvIlOdSJMRM4xM2myj4s18xabOKvkLzNOb+QBC4nuYP5NEotzuCvRgDjbhO7mqHu
 VRHtREIfVbjAT3//vgkSqzY1i205FDlm4Pj0LPaa1esbvwsvJyDRBFq+DBgiL05u5pkh
 Z6eg13JdIvl4f7L7dEuglvDDTDUo6dI8+Q0loURSZ4986F+ZTv3LKDDGMWno5uy7hfJ4
 P3mg==
X-Gm-Message-State: AOJu0YzvucNhlmDD2uEZO4Jv2lEzc+Zm+I9zK8Xpx5oXifZk3+K6H9DH
 fFu/NfJiEqJND0920wPCrIo69qkEYkcIgdn7+M3Baz+dmMeoWkQBVK0PZnmohiA3m4wTcrhtWdd
 EWb23Ydz6zJHfkjcfMKK3hDs6udw9Er35FfU/WKnlc5eIho63
X-Google-Smtp-Source: AGHT+IF8u/KIRXot/zqJzya3dNimH4kRO61tGT1c9T+ZPnzRROv0TvZuKGSLqDH2JxHVzBJ+YUx6cJ5gTHs7jWt1oR8=
X-Received: by 2002:a50:ee89:0:b0:561:bcbc:7c96 with SMTP id
 f9-20020a50ee89000000b00561bcbc7c96mr4421878edr.31.1708094988757; Fri, 16 Feb
 2024 06:49:48 -0800 (PST)
MIME-Version: 1.0
References: <20240216135137.8668-3-atp.exp@gmail.com>
 <20240216135137.8668-4-atp.exp@gmail.com>
In-Reply-To: <20240216135137.8668-4-atp.exp@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 16 Feb 2024 14:49:37 +0000
Message-ID: <CAFEAcA_D+rJys-YP3W3UkGM+RFkv+GsrXymqUDGEgOdSu+KKMg@mail.gmail.com>
Subject: Re: [PATCH 1/3] misc: m48t59: replace qemu_system_reset_request()
 call with watchdog_perform_action()
To: Abhiram Tilak <atp.exp@gmail.com>
Cc: qemu-devel@nongnu.org, clg@kaod.org, david@gibson.dropbear.id.au, 
 harshpb@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
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

On Fri, 16 Feb 2024 at 13:56, Abhiram Tilak <atp.exp@gmail.com> wrote:
>
> A few watchdog devices use qemu_system_reset_request(). This is not ideal since
> behaviour of watchdog-expiry can't be changed by QMP using `watchdog_action`.
> As stated in BiteSizedTasks wiki page, instead of using qemu_system_reset_request()
> to reset when a watchdog timer expires, let watchdog_perform_action() decide
> what to do.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2124
> Signed-off-by: Abhiram Tilak <atp.exp@gmail.com>
> ---
>  hw/rtc/m48t59.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/rtc/m48t59.c b/hw/rtc/m48t59.c
> index aa44c4b20c..ebda084478 100644
> --- a/hw/rtc/m48t59.c
> +++ b/hw/rtc/m48t59.c
> @@ -36,6 +36,7 @@
>  #include "qemu/bcd.h"
>  #include "qemu/module.h"
>  #include "trace.h"
> +#include "sysemu/watchdog.h"
>
>  #include "m48t59-internal.h"
>  #include "migration/vmstate.h"
> @@ -163,8 +164,7 @@ static void watchdog_cb (void *opaque)
>      if (NVRAM->buffer[0x1FF7] & 0x80) {
>          NVRAM->buffer[0x1FF7] = 0x00;
>          NVRAM->buffer[0x1FFC] &= ~0x40;
> -        /* May it be a hw CPU Reset instead ? */
> -        qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
> +        watchdog_perform_action(); /* watchdog-expired action */
>      } else {

I don't think we need the comment, it's clear enough from the
name of the function.

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

