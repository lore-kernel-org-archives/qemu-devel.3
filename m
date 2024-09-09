Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D007ECE57A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 15:27:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sngHh-000712-WC; Mon, 09 Sep 2024 11:26:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sngHh-0006z9-6V
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 11:26:33 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sngHf-0002PD-Id
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 11:26:32 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5c3ed267a7bso2106144a12.3
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 08:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725895589; x=1726500389; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AIwxvFUgMGuu28vVE0Ra3a1C77yW6FX4mD9Ilj46Ccw=;
 b=iBeX7i0i+RmNApg7a16WNpqlabf88LynOhYDysgkvfcgIMN79Q/6MVJ6Xdjdb7PJAn
 XW2r2A6Y7fNpwULmXmUSz/5fAjnNrDarlnBtxw81qFOewT1JXQAXrggKou4Jxrm3JXRL
 dkrzYbbK6XS3ShmquMLFgrdCV1p+MoWgYpmzrBTzbDPMJ6njrRzBno3NqFRwG5AnimC8
 vkGsocJiZevGbjJTZbuA5Q28FvtBIgff5i1Ogfj82tL34oL1K4AE9YE0ifb4ywOP1B7V
 y4Fwd5BDLw8A16vc4XKLdfsrUTZiw1NnOBThWIbSRS5CnxiZ3RxhUo/8NkEdeVHoBmRk
 hNnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725895589; x=1726500389;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AIwxvFUgMGuu28vVE0Ra3a1C77yW6FX4mD9Ilj46Ccw=;
 b=pTDUA0iYBOmbCuVevo03ViZva+uHeUdF8dX/z7AOSZyOEfWeZo2RGDu4IFVPKBMxYx
 /j0+/pLU8I/WeDj4B6Geq7iQCt9aEFGNiR/hT39+LSkYFPLlqF5IFhlGWdZVexfx+0Ns
 hOdxAOuG960CeL9RS6ZxVFXX2weWNj18gHVCT5sp0EDnilinb84Q2ykORIX3tqojsnts
 JEACGrRDHfOn3HWBtbod8P9JUorKet7vdFvyITTV3DxkJsdWiqN+cDfsukdF6V6+zXxP
 3vwKPe4BydLOzFswy2gvFHvKAwM2yB+4xpCocZ2p9d5S+OB/NTbMLx3+ilWPVsUHcPpj
 h4pA==
X-Gm-Message-State: AOJu0YyY/kNOJAcrEX0nvMYghfM8yuFwt9eIKfnKhRNex1xfk2iHEcIi
 GjmYORE6I0qIMaRQUQ4pzQXLsdBZkt1hTWypjXu0m+FgJlD9XLQk2WBxutzZDUa8C26m0HVJps1
 C0yP2AQxgOE+s5IPJF7ZgLfzbz1FAd7LgyRZAeg==
X-Google-Smtp-Source: AGHT+IGjj3fZ6W7hH5BOzg2QETg26mmXbEquhYY4SevzzjKoZGXTtaocJ16plCb5knHNP3KdaxmOrE4aewHHLbD3Pf4=
X-Received: by 2002:a05:6402:210f:b0:5be:eaf1:807d with SMTP id
 4fb4d7f45d1cf-5c3dc7c6ac3mr8334951a12.29.1725895589281; Mon, 09 Sep 2024
 08:26:29 -0700 (PDT)
MIME-Version: 1.0
References: <20240903200446.25921-1-philmd@linaro.org>
 <20240903200446.25921-3-philmd@linaro.org>
In-Reply-To: <20240903200446.25921-3-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Sep 2024 16:26:17 +0100
Message-ID: <CAFEAcA-Ny03OHMHFKu8kSbPSJsiJRqR+qmhDOg6jsM9HtT6FCw@mail.gmail.com>
Subject: Re: [PATCH 2/2] hw/sd: Remove legacy sd_enable()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 qemu-block@nongnu.org, Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
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
> sd_enable() was only used by omap_mmc_enable() which
> got recently removed. Time to remove it.
>
> Since the SDState::enable boolean is now always %true,
> we can remove it and simplify.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

> @@ -2328,7 +2327,7 @@ void sd_write_byte(SDState *sd, uint8_t value)
>  {
>      int i;
>
> -    if (!sd->blk || !blk_is_inserted(sd->blk) || !sd->enable)
> +    if (!sd->blk || !blk_is_inserted(sd->blk))
>          return;
>
>      if (sd->state !=3D sd_receivingdata_state) {
> @@ -2460,7 +2459,7 @@ uint8_t sd_read_byte(SDState *sd)
>      uint8_t ret;
>      uint32_t io_len;
>
> -    if (!sd->blk || !blk_is_inserted(sd->blk) || !sd->enable)
> +    if (!sd->blk || !blk_is_inserted(sd->blk))
>          return dummy_byte;
>
>      if (sd->state !=3D sd_sendingdata_state) {

Maybe add the { } that coding style wants to these if()s
since we're editing them anyway?

Either way,
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

