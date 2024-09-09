Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6979EECE579
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 15:31:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sngLn-0003Zd-7r; Mon, 09 Sep 2024 11:30:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sngLl-0003X4-6h
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 11:30:45 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sngLj-0002o0-Lu
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 11:30:44 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5c3c30e663fso5157779a12.1
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 08:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725895841; x=1726500641; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7QBAlAMX/7CLmi7XQQ6kE3/liMSEhNPziZhOZBa96JI=;
 b=XNP8Y9ldfGHN9FgJAeswnVy/gbamiaXizyDB1KYDRnhZ32TSybHeldjuqyeNGZMGaK
 LMX+JJmog5LPXlDKrW5RjhRqwm3jjwXeJeFSSkRwsIDJ2LI1BAz0H5nYva9oeObAIS5a
 kMJVcGefmM/lDBXlw7H6SO1fjsrIrWeWVMaOFdW1P9+4TR0GKrq/OYkDdNcvwX6IFozC
 HooM28ELLf8JhnMSlLK9nJ8FPkbpp7frxv26LnLuX30bHPPRS9n7OYnbGg5jm+cJpMNz
 oiOo9rNp5g7AT2uTepUEPKnBr3KVmNkUEFh8Q20PoE978+UwuJKG8l7j2az58kQq0b++
 cy2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725895841; x=1726500641;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7QBAlAMX/7CLmi7XQQ6kE3/liMSEhNPziZhOZBa96JI=;
 b=qXrithEl8V+7DCGJkBFFFoJQfNoYVxXne9OdbBFO/qsRo4q+IJ2FU92UUvF5sNJpd8
 xuvz8TXzbDyv/a5u6COr9wFZ+C33J7k8oPsv7gd0FxhahxCOFUBqmoeZUBkeSlbkwG6j
 mPy5kc3BTcr8hgfCiUFQ3FP5/wVEur9fjS1twD0y+0iEFuO2AHZpifMuSw8hwN1F9krY
 ulKZ5YGUXlQDWSzqmk0hDeOxikItH9wlBCtRb01yu3sEaeyLIfuM16fYd7eYw92+EGLm
 AyYb5uDsT5Bob1zS5iol5JftdWFBR/JUCdccKfq7/uoMMhRd2QGAdkPZuBfkG27T4Ae4
 zgEg==
X-Gm-Message-State: AOJu0YwKS3zCquRlFTkKpQrzViMCtFqINKkbxoGoBXrVH3U1oPvp1EEx
 gEuabxbBIbVkvRbGF9arIW+2YITfnX1Lq92gZfWxHKc33G0Uzf5fqb0txCS+E/JQmgk7bJbS0YR
 HSNh24RYE8XlpfSiwA8PfSl+XflJbIo+gsE4JCw==
X-Google-Smtp-Source: AGHT+IFhBCM4zWO18qtU7Q+BuHe9XhyXy16DFJff3N/fJdaR84aD/OAS2fOqcKBg6RtBW++OPz8C451IkFWVjWT/LQ0=
X-Received: by 2002:a05:6402:4312:b0:5c2:18fd:8a27 with SMTP id
 4fb4d7f45d1cf-5c3dc7b8016mr8604304a12.25.1725895841446; Mon, 09 Sep 2024
 08:30:41 -0700 (PDT)
MIME-Version: 1.0
References: <20240903200446.25921-1-philmd@linaro.org>
 <20240903200446.25921-2-philmd@linaro.org>
In-Reply-To: <20240903200446.25921-2-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Sep 2024 16:30:29 +0100
Message-ID: <CAFEAcA_Yfcjuz+3KfiKPDY2aVU1OuJ3B-9q9F82-fGCS9PTi+Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] hw/sd: Remove legacy sd_set_cb()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 qemu-block@nongnu.org, Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
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

On Tue, 3 Sept 2024 at 21:04, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> sd_set_cb() was only used by omap2_mmc_init() which
> got recently removed. Time to remove it. For historical
> background on the me_no_qdev_me_kill_mammoth_with_rocks
> kludge, see commit 007d1dbf72 ("sd: Hide the qdev-but-not-quite
> thing created by sd_init()").
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  include/hw/sd/sdcard_legacy.h |  1 -
>  hw/sd/sd.c                    | 30 ++++--------------------------
>  2 files changed, 4 insertions(+), 27 deletions(-)
>
> diff --git a/include/hw/sd/sdcard_legacy.h b/include/hw/sd/sdcard_legacy.=
h
> index 0dc3889555..a121232560 100644
> --- a/include/hw/sd/sdcard_legacy.h
> +++ b/include/hw/sd/sdcard_legacy.h
> @@ -36,7 +36,6 @@ SDState *sd_init(BlockBackend *blk, bool is_spi);
>  int sd_do_command(SDState *card, SDRequest *request, uint8_t *response);
>  void sd_write_byte(SDState *card, uint8_t value);
>  uint8_t sd_read_byte(SDState *card);
> -void sd_set_cb(SDState *card, qemu_irq readonly, qemu_irq insert);
>
>  /* sd_enable should not be used -- it is only used on the nseries boards=
,
>   * where it is part of a broken implementation of the MMC card slot swit=
ch
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index a140a32ccd..8a30c61ce0 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -112,10 +112,6 @@ typedef struct SDProto {
>  struct SDState {
>      DeviceState parent_obj;
>
> -    /* If true, created by sd_init() for a non-qdevified caller */
> -    /* TODO purge them with fire */
> -    bool me_no_qdev_me_kill_mammoth_with_rocks;
> -

Should we also remove the sd_init() function in this patch
(or patchset)? It was only used by the omap-mmc, and it's
because we have no uses of it that we can get rid of this kludge.

thanks
-- PMM

