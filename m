Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15450CD1296
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 14:37:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtq7R-0001h7-2S; Mon, 08 Apr 2024 10:37:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rtq7Q-0001gk-95
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 10:37:08 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rtq7N-0006bB-3s
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 10:37:08 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-516dd07d373so1216911e87.3
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 07:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712587023; x=1713191823; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yCDQyG+FP5ng746D09xToBXY+tFyXOqQooASaSIcqb4=;
 b=XB/kpe3oKF1q8LR6uK8N7o1MdwYkAY+sI/V89vSCwR993sLFuE3ZMupj2eZx8WJBzZ
 XvAqVbhkOTH5c23JP/mpMUxHwKmm/2p5RFKUVnUMdrqvEO2LCtKYi+9uY7CWJP2ecGFs
 U11MLzsqPsRN9RXWqJCP7j3BX5BRsDjQAwBe5b7K323iOn0gqKsQfnrBz9H9lhO3A5Xr
 Y7NCzBWZx+dKsRRm1plipOtPa41NAiiXALwj4f5NFOnUvp7TME8wc+469gunhdeWJunz
 UepTnGWnbbX2EnLtflqqJK5nx03er8ELc6n0lBtCdL01AlJvRbDjk0KGYFRSsZcI0jpX
 UxtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712587023; x=1713191823;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yCDQyG+FP5ng746D09xToBXY+tFyXOqQooASaSIcqb4=;
 b=IKOw2GPMOhT1IINNxham9B76gdDz1r7qVDlEglrDUTDYmbg1VKOBj07dNXlSDPlzqF
 7oDKPRTb3VQEqdUnzNVlKjZN2urJemGc1ynmsaWUswAFqddd2Qyf3d4wiAZpX+VnEiy0
 9GhadUQ5fdzaJDtRq45XxTMPqDIAEFyx2pUuyM3WGwONzJ/gYSVv3WUQkoflPTBfepCN
 39X44rM0p7iEVtPvZJC3dB6hXJUEDXP9wNoLODgFC3lbyUfmZ87anLdTki4M4PDfNo6w
 jlK4tqaljwwb4p1hQ3UNJScL+rr94P+ss/bV+4EmD1wjEoauMBad/0Byv784yITYTcdC
 Xetw==
X-Gm-Message-State: AOJu0YyoH3LXVwfdtiq6xsSqLjoqSYZtertxX+PGuCNQWHO7JUDF+nGi
 vQmP86qqaALQrRmPa7QP7XktKMpMxICe+oimeVNwn0k3Y9UL9RN2GPsZAQxbgZuIUGD72l2GJc9
 ABSYLo12Wh6JgNAwwNhrquBCsVEkOfsG3s9xxNg==
X-Google-Smtp-Source: AGHT+IG0l8o3mVlwONUPpLrS5QMZRCe51Y5cSqX5PvRhKMhgy8kynOrS23Sa49PEK9bEAinK43tk0Epgi39R/QypZow=
X-Received: by 2002:a19:ae12:0:b0:513:b1d7:6d07 with SMTP id
 f18-20020a19ae12000000b00513b1d76d07mr5321230lfc.58.1712587022857; Mon, 08
 Apr 2024 07:37:02 -0700 (PDT)
MIME-Version: 1.0
References: <20240408141717.66154-1-philmd@linaro.org>
 <20240408141717.66154-3-philmd@linaro.org>
In-Reply-To: <20240408141717.66154-3-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Apr 2024 15:36:52 +0100
Message-ID: <CAFEAcA9RfS7MNvRHLGeWyu9HgZ4QzOq2i-umFxDn7N3R2Kn0OA@mail.gmail.com>
Subject: Re: [PATCH-for-9.1 2/2] hw/sd/sdcard: Assert @data_offset is in range
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Bin Meng <bin.meng@windriver.com>,
 qemu-arm@nongnu.org, 
 Alexander Bulekov <alxndr@bu.edu>, qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x136.google.com
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

On Mon, 8 Apr 2024 at 15:18, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> Prevent out-of-bound access with assertions.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  hw/sd/sd.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 16d8d52a78..c081211582 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -1875,6 +1875,7 @@ void sd_write_byte(SDState *sd, uint8_t value)
>                              sd->current_cmd, value);
>      switch (sd->current_cmd) {
>      case 24:  /* CMD24:  WRITE_SINGLE_BLOCK */
> +        assert(sd->data_offset < sizeof(sd->data));
>          sd->data[sd->data_offset ++] =3D value;

Abstract out functions

static void append_sd_data_byte(SDState *sd, uint8_t value)
{
    assert(sd->data_offset < sizeof(sd->data));
    sd->data[sd->data_offset++] =3D value;
}

static void read_sd_data_byte(SDState *sd, uint8_t value)
{
    assert(sd->data_offset < sizeof(sd->sd_data));
    return sd->data[sd->data_offset++];
}

(etc for read_sd_status_byte() etc) ?

(sadly I don't think there's a verb that is the equivalent
of "prepend/append" but for removing elements.)


>      case 22:  /* ACMD22: SEND_NUM_WR_BLOCKS */
> +        assert(sd->data_offset < sizeof(sd->sd_status));
>          ret =3D sd->data[sd->data_offset ++];

Checking against the size of a different array from
the one we're reading from.

thanks
-- PMM

