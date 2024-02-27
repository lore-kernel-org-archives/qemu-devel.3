Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77C09C54E4A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 12:34:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reweA-0001RC-Hz; Tue, 27 Feb 2024 07:33:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rewe8-0001Pp-Sd
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 07:33:20 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rewe6-0007pv-4p
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 07:33:20 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5656e5754ccso5242451a12.0
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 04:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709037196; x=1709641996; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pEOUocoZ4xSZ5sf4B5oQ2siRhD+4cGJaVgEPNv+cdwM=;
 b=N4peydMofJ3ZWiBrWgo/JkAMEZGw0ihS0x7zOmJdroasArrhuObxa9fZ0SFlji68g0
 XFytZRX93N8KIiUDtcOVef4YqXGJ5SxI9ELW0UIb5W3TFPBJz+1GBnSeq/+dDJOlvTjy
 uSzYA5Kg1+ij1hwqRKEe/L11DctVbeXl6dUoSOLcD5axjuCTGO7ruSVnEYtK3lfx2Ndx
 gtTM8fTAurdIKdwxAbFQsuLDJzw9VXVqRahX0U4WiayIHdOoNMdBt4ioBcuPs9D2+hB6
 cHFRvcxEbXyTcoJmvUxCKUwpJCEnJkANk+75hA0wdmATu6/zngKVES17NZT3QsxCmfAM
 kO1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709037196; x=1709641996;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pEOUocoZ4xSZ5sf4B5oQ2siRhD+4cGJaVgEPNv+cdwM=;
 b=Ja67zyzRk5Rdiw6dWlMXS5ziwLNztkKEH9NCoH3aW3Qz3WtDNfPbzN8lITRp2bGUlS
 /0Hs03vpvioaDha1Y9AVayY9BMDKgQN0DMR9KkPedQm8XUAGBau08PoqfB1o0hPV3iuu
 cg1cUBpaILX6nmLnnaaTmxq3Asy1pu+FrjJ9sEBDH5YyWaT2QBd0cBpSFriBLV/GtFHo
 pZO2aF9eGEhG5gYYLX3QD9I2aJ6ThiCl5oy87hxpuAyUurqXJhu9AGaoDX7zHZG9FCm1
 5/VmahBPqKESGG7WXzfVOAfbIk9IB5lQTUI2DjY+bFun2r6R/h4bE+imUvaGgo+TWyN+
 acqw==
X-Gm-Message-State: AOJu0YzyviXijqQ2C99bV7tDhJ6pXew8qZK2tTHZ77vbtpzQ5NzokW3p
 dl1ytk2vIB9OxOalA0W4+XWTj7qqP2Tnm30FxFwRHMHJm77Tr0Jde6oKiatoGerSW8+NmGEVoG1
 SUYci2JKqI/ds1opZdi8yt/tR+4dgf34QGGep1Q==
X-Google-Smtp-Source: AGHT+IH2Gz9NshjaZ7X12kWqTZ5mNvq2Ovu3yZ8cMr75edKiRsXO4BOkwO/gM/A6J9060ogR1NJp9isrAjbSn09HYGY=
X-Received: by 2002:aa7:d818:0:b0:565:f7b7:8db1 with SMTP id
 v24-20020aa7d818000000b00565f7b78db1mr3629122edq.27.1709037196202; Tue, 27
 Feb 2024 04:33:16 -0800 (PST)
MIME-Version: 1.0
References: <20240227083948.5427-1-philmd@linaro.org>
In-Reply-To: <20240227083948.5427-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Feb 2024 12:33:04 +0000
Message-ID: <CAFEAcA_SzY7nJd_s670g8qttsszLxynDiVXH-=7feyq-vVfixQ@mail.gmail.com>
Subject: Re: [PULL 00/30] Misc HW patches for 2024-02-27
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-block@nongnu.org, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
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

On Tue, 27 Feb 2024 at 08:40, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> The following changes since commit 03d496a992d98650315af41be7c0ca6de2a28d=
a1:
>
>   Merge tag 'pull-qapi-2024-02-26' of https://repo.or.cz/qemu/armbru into=
 staging (2024-02-26 11:22:32 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/philmd/qemu.git tags/hw-misc-20240227
>
> for you to fetch changes up to 0316482e876988f7526ebe62d579ad069f485957:
>
>   hw/ide: Include 'ide-internal.h' from current path (2024-02-27 09:37:30=
 +0100)
>
> ----------------------------------------------------------------
> Misc HW patch queue
>
> hw: Remove sysbus_address_space() (Phil)
> hw/nubus: Add nubus-virtio-mmio device (Mark)
> hw/usb: Remove usb_bus_find() (Paolo)
> hw/usb: Extract sysbus-ohci from ohci (Paolo)
> hw/nvme: Fix invalid endian conversion
> hw/i386: More PC machine housekeeping (Bernhard, Phil)
> hw/ide: Restrict "ide-internal.h" (Zoltan, Phil)
> qom: Expose object_resolve_type_unambiguous() (Paolo)
>
> ----------------------------------------------------------------
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

