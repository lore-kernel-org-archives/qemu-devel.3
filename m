Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C90F1C5DF87
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 11:51:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx1I7-0006yL-C3; Thu, 20 Aug 2026 07:50:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1wx1I5-0006uY-3j
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 07:50:37 -0400
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1wx1I3-0005CE-4I
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 07:50:36 -0400
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-66cd07da38fso2129088d50.2
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 04:50:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787226634; cv=none;
 d=google.com; s=arc-20260327;
 b=Vgt5ru1KfxjVdGoiuQe+LTUHLkIw3oAYQxSW6HugMnXhxb5/1OKB28PNf1/ig/7NHk
 8R5oOBEKvn20ogsijOHwEcTS9b5ID/9C3VMib6bXVYzPoyCq0vR/q6bKwSLpyAD0o3mI
 kMUXG/ZirA8xyuCJzJ3TZ5R+N3Vu6LfNb6iing+L5yhvM3jioNQTPJ2oWPofNgLr5sfu
 IjfkWCpQpv4FgE2b9jA4uab/bayfQhElVMICyS7yAfBx3Yg4Sul88Fl9JhPWvgtR8q32
 TJbMI6Rtwg3aCpEBUua5e6xDpf6lCPtttWwfhxOeoOWGliJfsZUWWngz1YjirAG5NCCt
 Dvkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Y0dYfev4ExP7gbnuioImKtNXmOfTbxUEBas0KSbMMXk=;
 fh=90H685tgdCqFnjzSfPl1O7q2DFaOXI/OZbYpRHaghpM=;
 b=IJCmiy1iaCLIQjrQlzOqukf4P/l7wdDg1DIoeUcgeSrrp4dW/72LAcOBGuMtts/1sg
 /7tEF6D1ATWvkRtl+lLuOtUWM6R54cniCyL2xqV35u46TgImaBcZxPgzzouzstqjn6CD
 7LOlfW+yt7FE7vmHufzQM7JUwVB/9L5nvqyykTMLBeIJl0IKR19oxiS6v+17/iLtVrMb
 43JeEHnU5SuhlL705ZGv1Vc068HWK+RuaY3UNZILZym/k3Xf/A0LnDBz8+1IgJaKGDct
 1GKzb6AK9QUerlht9VUMd4Adp2gyu/RB8bOQB7UCVzjPGAe6qPrLIVLVh/YYzT07u70l
 xuaw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787226634; x=1787831434; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Y0dYfev4ExP7gbnuioImKtNXmOfTbxUEBas0KSbMMXk=;
 b=JU9p6MjwBqN8EdanwS7s1O9Ena0bX/jg0dluYapmOaFW6REcF9KRN9JFXtUXeWbbQ6
 XBfBh/NmpnXqGG3tF5VGXUcFgcxJJhB9Uc+59jLJJJYp5O1FqAKQZNlLd+Oa+FkPJ8a6
 uHsulrnoR7gMAnaKt6cOcaoQo2GdufGSzIMa5LQIOfW3LwBbWjHoKtNEU6CXbl7HKD4T
 drVUtfif8Wgl8Bb9zLspsrfYxnA8cMjcmoGz6rl8jTiv+75PRhe546IU8sAvGrRnkXiM
 gAVOfUh7IJKe+8CXfFr8tIcNXaz1J4v9YlMDk9np2JhZohOQFXhsojw7WeeW2mLzoDij
 VMJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787226634; x=1787831434;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Y0dYfev4ExP7gbnuioImKtNXmOfTbxUEBas0KSbMMXk=;
 b=ibruP8o67K9YXVFytQUtt0dSOmepuV6sA/Y2zMwwCCgiNiFX1UMeuXGzqJWI+5qdEX
 oIJbluHuGrrgDp7zqluxAsuFNuPhBs5v1QzAk73gnsORkCVFNaY/NQ13W4iKzv9GTjnM
 JSs3cQ9YftOACR5d9pEWiLoloUb/lRjmihO4aJmy4jTfkKWU8z/czWsUpZYuo7CbqyD7
 R2ZxYFkiGutJVQKLi4nYvaGjIzRmFatQ0miObel4MBp6itAXkpHmWy4ZGaKtQ2sClTru
 D6ApaH9ZvYapWy+IdMNf+rXtlgwWJbR8PA0cWqQGiuISZ5nNV+GnaXhVBKzOvMc4Bxvx
 KY6Q==
X-Gm-Message-State: AFuF++m9pPQlOLJ1w8mJJyBq9igcl4DI4lKzxz9HysYilTKQTy7lx8Wp
 MwIT6aOikOjzsApNiZAECRkCqAgKyyW4OGrPL72W0UfSmhpxrk9OGU/l0gj25YE+hoD5atF2S9N
 n1nMl0R2RYmYNYYEnXPFQtJYw1JqlQIg=
X-Gm-Gg: AR+sD12bFo/ddDlQZ0g1cGNDpI5wxKzSIo/0XN+tn/WFVecowKQ7jU2HBL44ZJJqTn8
 oH4PLDDCXuNY3yJRDmFvHiBDPa7rDYavVgrqD0Lx3lTUvWyE6SDY4mkdYpizef0e867YYMER/vB
 rHtunrTHfHG7ekotZwTdSTS18phQ5X/puLmu7E0zx4jTC6dKDvGr9gRU7BMLBuaZwh1NEDOiJaK
 OH38JwanUg8EX4DEj4KIvUOrreR4hH90Z/jfZNmpDaUQyuWn6StEGEzew/lnkI7iyW32eoxtbQj
 ibF8ZnLuAIgdHen3wPiRU6SQekrE3jFbaf44v9r4M5Ti
X-Received: by 2002:a05:690e:480f:b0:667:72da:e798 with SMTP id
 956f58d0204a3-66ccb6cf484mr3049706d50.31.1787226633430; Thu, 20 Aug 2026
 04:50:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260820024834.3286721-1-kylefoxaustin.github@gmail.com>
 <20260820024834.3286721-2-kylefoxaustin.github@gmail.com>
In-Reply-To: <20260820024834.3286721-2-kylefoxaustin.github@gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Thu, 20 Aug 2026 19:50:20 +0800
X-Gm-Features: AcwNN1XVHrrZaGUwHaKdLpFN7ECQ9UjFjPdRwfgQm3fHoFhOkuGGhTCIgHdnHFs
Message-ID: <CAEUhbmXjTHjw3v90p9eg4Pv587kQxuiEcMwkwT1XT-ZedWhbMA@mail.gmail.com>
Subject: Re: [PATCH 01/16] hw/sd/sdhci: add i.MX uSDHC SDCLK_AUTO_GATE and
 NO_SDMA_BOUNDARY quirks
To: Kyle Fox <kylefoxaustin.github@gmail.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 "open list:SD (Secure Card)" <qemu-block@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yx1-xb133.google.com
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

Hi Kyle,

On Thu, Aug 20, 2026 at 10:48=E2=80=AFAM Kyle Fox
<kylefoxaustin.github@gmail.com> wrote:
>
> The i.MX uSDHC issues commands with SDCLK auto-gated (its driver never
> sets SDCLK_EN), and its SDMA does not honour the 512 KiB ADMA buffer
> boundary the generic core assumes. Add two opt-in quirk bits for this:
>
>   - SDCLK_AUTO_GATE: treat the clock as running once the internal clock
>     is enabled and stable, instead of also requiring SDCLK_EN.
>   - NO_SDMA_BOUNDARY: skip the buffer-boundary break in multi-block SDMA.
>
> Both default off and are a no-op when the bit is clear, so no existing
> user of the SDHCI models changes behaviour; a machine opts in by setting
> the bits on its own uSDHC instances (the i.MX 95 SoC does so).
>
> Signed-off-by: Kyle Fox <kylefoxaustin.github@gmail.com>
> ---
>  hw/sd/sdhci.c         | 67 +++++++++++++++++++++++++++++++++++++++----
>  include/hw/sd/sdhci.h | 21 ++++++++++++++
>  2 files changed, 82 insertions(+), 6 deletions(-)
>
> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
> index e58a6103970..327e9a7cb74 100644
> --- a/hw/sd/sdhci.c
> +++ b/hw/sd/sdhci.c
> @@ -611,12 +611,27 @@ static void sdhci_sdma_transfer_multi_blocks(SDHCIS=
tate *s)
>      }
>
>      /*
> -     * XXX: Some sd/mmc drivers (for example, u-boot-slp) do not account=
 for
> -     * possible stop at page boundary if initial address is not page ali=
gned,
> -     * allow them to work properly
> +     * The i.MX/FSL uSDHC silicon does not implement the SDHCI "Host SDM=
A
> +     * Buffer Boundary" mechanism; it transfers all blocks back-to-back
> +     * regardless of buffer-boundary address alignment. The blksize-quir=
k
> +     * in esdhc_write() forces bits 14:12 to 0b111 (=3D 512 KiB) so Linu=
x's
> +     * "zero this field out" pattern doesn't trip a 4 KiB boundary break=
,
> +     * but the real hardware never pauses for the boundary at all, so
> +     * neither should we. Skipping the page-aligned path makes the SDMA
> +     * transfer run to completion (blkcnt -> 0) and fire transfer-comple=
te,
> +     * which is what the FSL U-Boot SPL driver expects (it doesn't ack
> +     * SDMA-boundary IRQs by re-writing SYSAD). Controllers with this
> +     * behaviour set SDHCI_QUIRK_NO_SDMA_BOUNDARY.
>       */
> -    if ((s->sdmasysad % boundary_chk) =3D=3D 0) {
> -        page_aligned =3D true;
> +    if (!(s->quirks & SDHCI_QUIRK_NO_SDMA_BOUNDARY)) {
> +        /*
> +         * XXX: Some sd/mmc drivers (for example, u-boot-slp) do not
> +         * account for possible stop at page boundary if initial address
> +         * is not page aligned, allow them to work properly
> +         */
> +        if ((s->sdmasysad % boundary_chk) =3D=3D 0) {
> +            page_aligned =3D true;
> +        }
>      }
>
>      s->prnsts |=3D SDHC_DATA_INHIBIT | SDHC_DAT_LINE_ACTIVE;
> @@ -992,9 +1007,26 @@ static void sdhci_data_transfer(void *opaque)
>      }
>  }
>
> +static bool sdhci_clock_is_on(SDHCIState *s)
> +{
> +    /*
> +     * The i.MX (u)SDHC has no software SD-clock-enable bit (the card cl=
ock
> +     * is auto-gated by hardware), so its driver never sets
> +     * SDHC_CLOCK_SDCLK_EN. For such a controller, treat the clock as
> +     * running once the internal clock is enabled and stable; otherwise
> +     * every command would be silently dropped (no completion/timeout IR=
Q),
> +     * stalling the guest on 10s host-side timeouts.
> +     */
> +    if (s->quirks & SDHCI_QUIRK_SDCLK_AUTO_GATE) {
> +        return (s->clkcon & (SDHC_CLOCK_INT_EN | SDHC_CLOCK_INT_STABLE))=
 =3D=3D
> +               (SDHC_CLOCK_INT_EN | SDHC_CLOCK_INT_STABLE);
> +    }
> +    return SDHC_CLOCK_IS_ON(s->clkcon);
> +}
> +
>  static bool sdhci_can_issue_command(SDHCIState *s)
>  {
> -    if (!SDHC_CLOCK_IS_ON(s->clkcon) ||
> +    if (!sdhci_clock_is_on(s) ||
>          (((s->prnsts & SDHC_DATA_INHIBIT) || s->stopped_state) &&
>          ((s->cmdreg & SDHC_CMD_DATA_PRESENT) ||
>          ((s->cmdreg & SDHC_CMD_RESPONSE) =3D=3D SDHC_CMD_RSP_WITH_BUSY &=
&
> @@ -1613,6 +1645,9 @@ static void sdhci_bus_class_init(ObjectClass *klass=
, const void *data)
>
>  #define ESDHC_VENDOR_SPEC               0xc0
>  #define ESDHC_FRC_SDCLK_ON              (1 << 8)
> +#define ESDHC_VENDORSPEC_IPGEN          (1 << 11)
> +#define ESDHC_VENDORSPEC_HCKEN          (1 << 12)
> +#define ESDHC_VENDORSPEC_CKEN           (1 << 14)
>
>  #define ESDHC_DLL_CTRL                  0x60
>
> @@ -1707,6 +1742,26 @@ esdhc_write(void *opaque, hwaddr offset, uint64_t =
val, unsigned size)
>          } else {
>              s->prnsts |=3D ESDHC_PRNSTS_CLOCK_GATE_OFF;
>          }
> +        /*
> +         * An SDCLK_AUTO_GATE i.MX uSDHC drives the SD clock through
> +         * VENDORSPEC, not through the SDHCI CLKCON. For those instances
> +         * mirror the VENDORSPEC clock-enable bits into clkcon so the
> +         * standard SDHCI paths (PRNSTS.SDSTB derived from CLOCK_INT_STA=
BLE;
> +         * sdhci_can_issue_command gating on CLOCK_IS_ON) see the clock =
as
> +         * enabled; otherwise the U-Boot fsl_esdhc_imx driver waits fore=
ver
> +         * for SDSTB. Consumers without the quirk keep the upstream beha=
viour
> +         * (a VENDORSPEC write touches only vendor_spec/prnsts).
> +         */
> +        if (s->quirks & SDHCI_QUIRK_SDCLK_AUTO_GATE) {
> +            if (value & (ESDHC_VENDORSPEC_HCKEN | ESDHC_VENDORSPEC_IPGEN=
)) {
> +                s->clkcon |=3D SDHC_CLOCK_INT_EN | SDHC_CLOCK_INT_STABLE=
;
> +            }
> +            if (value & ESDHC_VENDORSPEC_CKEN) {
> +                s->clkcon |=3D SDHC_CLOCK_SDCLK_EN;
> +            } else {
> +                s->clkcon &=3D ~SDHC_CLOCK_SDCLK_EN;
> +            }
> +        }
>          break;
>
>      case SDHC_HOSTCTL:
> diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
> index a9da6203fcb..e6940b62562 100644
> --- a/include/hw/sd/sdhci.h
> +++ b/include/hw/sd/sdhci.h
> @@ -115,6 +115,27 @@ typedef struct SDHCIState SDHCIState;
>   */
>  #define SDHCI_QUIRK_NO_BUSY_IRQ    BIT(14)
>
> +/*
> + * The i.MX (u)SDHC gates the SD card clock automatically and has no
> + * software-visible "SD Clock Enable" bit: its driver programs only the
> + * divider and the internal-clock enable, never SDHC_CLOCK_SDCLK_EN. Wit=
h
> + * this quirk the controller is considered ready to issue commands once =
the
> + * internal clock is enabled and stable, instead of also requiring
> + * SDHC_CLOCK_SDCLK_EN (which such a driver never sets). QEMU-internal b=
it,
> + * taken from the top of the word to avoid the Linux quirk numbering.
> + */
> +#define SDHCI_QUIRK_SDCLK_AUTO_GATE    BIT(31)
> +
> +/*
> + * The i.MX uSDHC silicon does not implement the SDHCI "Host SDMA Buffer
> + * Boundary" mechanism; it streams all blocks back-to-back regardless of=
 the
> + * buffer-boundary alignment, never pausing at the boundary. With this q=
uirk
> + * the SDMA engine skips the page-aligned boundary-break path so the tra=
nsfer
> + * runs to completion. QEMU-internal bit, taken from the top of the word=
 to
> + * avoid the Linux quirk numbering.
> + */
> +#define SDHCI_QUIRK_NO_SDMA_BOUNDARY    BIT(30)
> +
>  #define TYPE_PCI_SDHCI "sdhci-pci"
>  DECLARE_INSTANCE_CHECKER(SDHCIState, PCI_SDHCI,
>                           TYPE_PCI_SDHCI)
> --

A patch series was already sent to ML before to enable the i.MX uSDHC
controller.
Please see https://patchwork.ozlabs.org/project/qemu-devel/list/?series=3D5=
18052

Regards,
Bin

