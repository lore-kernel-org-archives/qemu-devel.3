Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F730C43458
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 11:05:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiVVV-0000k9-Rl; Sat, 11 Jul 2026 07:04:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1wiVVU-0000jO-GE
 for qemu-devel@nongnu.org; Sat, 11 Jul 2026 07:04:28 -0400
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1wiVVS-0008RT-Vy
 for qemu-devel@nongnu.org; Sat, 11 Jul 2026 07:04:28 -0400
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-667971437d6so2521705d50.2
 for <qemu-devel@nongnu.org>; Sat, 11 Jul 2026 04:04:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783767865; cv=none;
 d=google.com; s=arc-20260327;
 b=gjt9x1ynm7BG98og83CpVfM2S54WKsWd6yTaWlg69ie9Etj1dlLpjdE6A00g8M8Ae2
 6f+v4s/waVstmNIhhri3ZCGoJsOtNlQQSDUpnCOauU6DyB5uU+m7krSo37sY43vxWrSI
 fpD7VmFnOzaHj7mATEhLS2zHdf9DSapl88mOvk4eu8VKqSobmCCUhox72O/JRxrj6tZ9
 RVeyKrrLpPfnJzUYmFlIpNfcNZFVpWCUyyA9qZRMNrqs9gO8/kIyvyR/xLptfdLzaCl3
 gWIICsa89vXa+s6x8hlmEXW0ZyzCmkXCgsRX55pu4NO2KUpYmNrOi5Cg4loKjlhfE94V
 TxYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=NLECCsMWXnqpvQBUgmVChXHrgMKE08qUHwIWNPzAbKM=;
 fh=IJDx4GgyYm6AA4Hgq1Jsws8tvuUKMe4rnTN1vGj3V3Y=;
 b=aMqu/FApDR/f7mL5iKisF1l/+eoh53htbToyMVBl2EzpL9sofGQoExe/w7GZDl8cag
 G+vxNqCxasNs0xqpRumrAxts9DIxJW4F4+GaqXLAx94h3oKCkkeEciFJsGS2OI5UCAC4
 cGuuxQyba6GfPHtYEX0HekNv8yUNj2gfUrkocZii58J7S+XNKnc1XdHfQrRZpYyJTLwL
 sYOGBPrlOMtxNf8TxYXgK3JobLkcB7jhJMN15XNupYlxnVGmaAEb5abE15Ll4ogqItA2
 atoz6tnvzEG1BRGWSGTnPi274MXIAZDqRi7Je/LdXWaST4YUuT+q7u4kMxU+T8n1+TwJ
 C9eg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783767865; x=1784372665; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NLECCsMWXnqpvQBUgmVChXHrgMKE08qUHwIWNPzAbKM=;
 b=dPBkIn6HmmhDBZ/HoUV2MmhkDVq+k0Y/VnESGUURl2xU1GjvlfYCO8wcuoJIwl3iol
 Vo/3xwmuVOi20Lv1e3jeG7uizH96cV8K1GFNNCi/aXr6bsxPxN3B03P9uf67WJgf+EZ+
 4xruwbqwyr730gwEc4edWFHT2AXZzjqUk9zu80fQdUuddm7YtLqw2lKEgjlNlcR74z8K
 vJ0pi6mZj88wPuEUNCtqbm30LGkrW98NH2bCScl3+fE/k77jKrp6ebHz1aEOKSFJ2ujs
 pktaFBBJCcn8niSYU2WdZmctpfa+lKeee3qt2MG/J2xgRhTcAfbfQX09uWKYJqdOMTFi
 VX8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783767865; x=1784372665;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NLECCsMWXnqpvQBUgmVChXHrgMKE08qUHwIWNPzAbKM=;
 b=DabHSaSymqxwQtMUyHPi2jDoeYqHO8djNqtBjwhv+C+y9z0w3UV+8zQ/zb5CI4+HMy
 7JcVS+8jm2cWr+/hlDZi9EKzqQv37kv19qtgLO56R9tjUJ+nyrRYv42fO5jnq3K13qfT
 8HbkREBiAatQ35u8R17oXmrA0nthne/L05n9YbpNIt9c63mDoWGw4f6SzYCeXPHbisTX
 M5lepkN/13olK4v/+bDUydusGVkcOcHxBOUWlgjpoSibwQTCFDlZVWoK32sdAmNG84wo
 b8uj9jfGBy5KfSTOK9D3CbumBkVkrFEmkCrYhIjHL12rPXcdCaeHKpHzCd0LtPt5xKCX
 OBnA==
X-Gm-Message-State: AOJu0YxkxpB5PVu/R9g6xovpsVQYBcGIfIPw6L+y0gVW1QQ2JCGVQjk8
 57PgC5u96qKPQ2/O6FFACb32UcjNPrCBeBgyY95+dEgujDDywQY6DuIbpxzTyTtkV+0S2Itp8mb
 5W/VUP7Q0i4aR7ei6UVScB03Rv2kmQTA=
X-Gm-Gg: AfdE7cnooK9KX/FaosrBnNVgHb0B0tBIjVi/6mdasCoj0O4JPU214pqt2clJtjOP8Wu
 zK7KOFFluuTyis1Zo7tPLijYGsWr+sD+N4niOld6qvPmM/YNkm3D2IFaJ3+3tkj2JP+jWkFi2RC
 6fUTIsSnr30jcSvy0QOv6hMOiixB7//0JlkjNfmJ4JNaH6x3Av0qDZDAz/gBAD8n4uQER4yYLQF
 YZ+TG+1YQvR/bNCUX6/VGs+Qjq39Db17bMbuI7vX4qxyKcf3P4G05GVDYmFtrHXiBHsw78=
X-Received: by 2002:a05:690e:21d1:b0:664:ae6b:b498 with SMTP id
 956f58d0204a3-667d7c9f133mr1302147d50.77.1783767865460; Sat, 11 Jul 2026
 04:04:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260710114305.2961898-1-armbru@redhat.com>
 <20260710114305.2961898-2-armbru@redhat.com>
In-Reply-To: <20260710114305.2961898-2-armbru@redhat.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Sat, 11 Jul 2026 19:04:14 +0800
X-Gm-Features: AVVi8Cfvp826Yl-iAwVGKj0WWndEsEh3T9PRgpIf3rpW0I2JuKzS_dD7a8WM1KI
Message-ID: <CAEUhbmXaA6wpyUeVGL4Vn-zaP9LBFfmpTuWxDB=aMaXez_p=1w@mail.gmail.com>
Subject: Re: [PATCH 1/2] MAINTAINERS: Mark "Microchip PolarFire SoC Icicle
 Kit" orphaned
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, alistair23@gmail.com, qemu-riscv@nongnu.org, 
 bin.meng@processmission.com, mzamazal@redhat.com, mst@redhat.com, 
 sgarzare@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12c;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yx1-xb12c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Jul 10, 2026 at 7:44=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> Commit 4a16a1a7ad (MAINTAINERS: Remove Bin Meng from RISC-V
> maintainers, 2025-01-28) removed the only M:, but left S: Supported.
> This makes no sense.  Downgrade to S: Orphan.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 576ef6fff5..aa2df9cbe3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1761,7 +1761,7 @@ F: tests/tcg/riscv64/test-crc32.S
>
>  Microchip PolarFire SoC Icicle Kit
>  L: qemu-riscv@nongnu.org
> -S: Supported
> +S: Orphan
>  F: docs/system/riscv/microchip-icicle-kit.rst
>  F: hw/riscv/microchip_pfsoc.c
>  F: hw/char/mchp_pfsoc_mmuart.c
> --

I plan to send a patch series to resurrect PolarFire SoC support.

Regards,
Bin

