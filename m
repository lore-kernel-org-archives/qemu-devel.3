Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1345FCCF2C4
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 12:55:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xI3wD-0002zs-OG; Sat, 17 Oct 2026 08:55:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xI3wB-0002zI-J0
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 08:54:59 -0400
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xI3w9-0005a4-RN
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 08:54:59 -0400
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-8ab43af5e97so8423527b3.1
 for <qemu-devel@nongnu.org>; Sat, 17 Oct 2026 05:54:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792241696; cv=none;
 d=google.com; s=arc-20260327;
 b=q/7BG43DNUkslmlwGxYAYPfue6f5V9ScCCpK6sDswTgUE03PQ7M0ihFh7uDDGkoTzW
 VrmjFVWgUB5dUzuh0XXpkbSUcKtYpCd5ifx5v7Yx4fUF+17FLC1KmLSyiY7rBO/EkV/u
 tHhgUn9B570jPGfm7LnzrvDh/gXz1JzcDmrDraupcaM4vpGn5SkwEj3G+b1wn2Stl9xn
 ZAnCb7EZLeYhWB2xk4n2WsVWszKgPyd7fSJuRI0WGaTa/TMJKE2Rid617PKckoEl80DW
 fxnLGGSkOYeSxGhxcckpRL4B7jpAEa6bX+gg+ASMcVlHKYkNwlam4b5YGQlwQyN1FqlK
 K1pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=c4h/k0zYSPigK6KUfZ3N41/XzKXVybJXmD03MwaLw7E=;
 fh=ltWIwVsWDzxKvEG7jBnlBXPrQvIjQc+HOgvPossf/dc=;
 b=opmqdTODvshtnN9YrkrV3VVag3e3Yua2/wYxDYm9sngfxgdfswxmvShZn65+pFJxP3
 YVdLIKMLNFoMvKcJEieiy/TS7RrVQZrOHcNINpwx02lYPww11PzhssH9GEpa03EVcrjs
 R6ROEVnrcoEDFINfEkyN518fWzQ3nWP7vZvWjQpJtf06OCYGlKkIf8MvdFi+31zo4Ofe
 9AIHAQYZatzpaFy7pTck98kLEYSQtkPcczTnlmZ1LuemuIaqViXddkz5NVLTE/9pJPuu
 OqBflBZwebJPvwlg9d1y2Ko120OdJKREFH9LxLKs7B1/Dqilsg0VOpyg5G1J1brS5GEe
 aWCQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792241696; x=1792846496; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=c4h/k0zYSPigK6KUfZ3N41/XzKXVybJXmD03MwaLw7E=;
 b=JZtXq1NjaRELNTeUJduDMXHNzVaAejb89IoDvq80FZfmiXSOAeSYyUl/OTQaCb78T3
 LpmBLy88OzpBnuhXBns6/HSnxqF2n03d9o8EYmmau6rwx9ivSX5KXGBSt/fi5XBnNjmj
 pBjIAO1p/zZhJsY02HMMf8fWxWstDc9yakU4l9tdidsUBI9bUo8Z/Uj8AhHbkqeoM+EU
 22eGkkS1MENTlmkT5if+x1yO8UPhDj9X+yGk/kZBxbv8C2GUkF2FEveNn5CyCh0vBcvL
 7oYXpRjDEeDjsa7P78We9V9b5QIvMjFQXvicOOFliJSJUnWLkiEGjhC/RhgqTfeym8B1
 t2MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792241696; x=1792846496;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=c4h/k0zYSPigK6KUfZ3N41/XzKXVybJXmD03MwaLw7E=;
 b=ZGJJwus24s7SWreCgF5so+/ePHUVeqhwVTVpCsgfqNFfsCbJC77buSoTcsu22yChq3
 P7/Iiy2mHQJ0npPgvtRLPSPM6Pa+PDQVz6Zl/a+OB7Dk/Dg7JkwfWd1achtCvvcH1OYo
 ebaT4sZwi8FUtjrOv+Z9/oRQ2LBMkzfb1XJgABFLD1zXDtDrIcmiZm97sZlTm/whvgki
 PTJfKRy5JNUrgMpXwS7mDJBwWdwJBG2Y7BqWxb1d1Jg7n3h0lrytjbianHAe0P+5jJPe
 VLtcbm1VYolog9gMR5T1Q51qi9fksabIEnmevTikqwKD+OA/djnUBBCYPLyCseeusU0i
 4j+w==
X-Gm-Message-State: AFq9FYJTqoyXZFZPNdXtwjcOlKIF1c2yvatnrozYD3zsWsJcPedVb50E
 J2Pu4F2IURyA5X+h9l/Zppy/8L+hMFtB85I2TlBzK3rxabmjTz6CKLnni00amE7kXLs1GMTz8TZ
 qa25VBQW89nXCLzLPSamS829vlXVHrZS1QA8zWR3WBg==
X-Gm-Gg: AYBFou3TwTZkKYBbW8mgewk9Pt32r+5G3gP7VZhhUpALiS2CzGemdeK7ydSF1K27xC4
 8zNNVHk0AQVqgfTMv62luK1koXcKmHwu2AWaTfXWWDmHVd2YIdeoesyxqT27CqkFFFhTSa/uIrQ
 A0xlxhMYKtuvu8sJAaxermPRbtq+fRZRDB3M0T3Jy8Lwxg6XpG66IKwvK1/SXunxBSaFeGL4FLx
 7YBU6rTu/M8KzxsxVWKQ005e5foGEAtsG4l9rvPWvt2f7aVH+qPO3izJTTM86WxHi+WDS/YZ9jA
 FUKDVn69Wj3tyS8+CUPB2OXwPPC9dFF+kErRrv2tuvQV/t1+UNDQ5o9NmTMh7kdcT0hzonQ3Ie5
 ql0y4/NQrw9Is2zGVucUdG5cckv9NVPZaZ4fWs8s=
X-Received: by 2002:a05:690c:4902:b0:8a9:8744:c07d with SMTP id
 00721157ae682-8b0e2dbee67mr21206177b3.18.1792241696397; Sat, 17 Oct 2026
 05:54:56 -0700 (PDT)
MIME-Version: 1.0
References: <20261015181122.60608-1-marcelomanzo@gmail.com>
 <20261015181122.60608-2-marcelomanzo@gmail.com>
In-Reply-To: <20261015181122.60608-2-marcelomanzo@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 17 Oct 2026 13:54:45 +0100
X-Gm-Features: AclHuK89gsivALYZyQoZU2dGrjxzWXbVXXVLuGcI-1x7xzbSHwLa8ohVELMMXLU
Message-ID: <CAFEAcA-r5n6X-eEcnnHUaVrwg9EKmLHJOxPjnuodOtmS4Xq8=w@mail.gmail.com>
Subject: Re: [PATCH v3 01/16] hw/arm/bcm2838_pcie: add BCM2838 PCIe Root
 Complex
To: Marcelo Manzo <marcelomanzo@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1130.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Thu, 15 Oct 2026 at 19:11, Marcelo Manzo <marcelomanzo@gmail.com> wrote:
>
> Add the PCI-facing "root" part (D0:F0) of the BCM2838 (Raspberry Pi
> 4B / BCM2711) PCIe Root Complex: a PCIe root port with the vendor's
> device/vendor IDs and capability offsets, not usable on its own
> without the host-facing part added in the next patch.
>
> Adapted from patch 13/41 of Sergey Kambalin's "Raspberry Pi 4B
> machine" series (patchwork series 829638, posted to qemu-devel in
> 2024 but never merged) against current QEMU master; the surrounding
> PCIe/GENET networking support for raspi4b was left unmerged upstream
> (base scaffolding aside), so this and the following patches complete
> and debug that series to get real networking working under
> raspi4b.
>
> Signed-off-by: Marcelo Manzo <marcelomanzo@gmail.com>
> ---
>  hw/arm/bcm2838_pcie.c         | 82 +++++++++++++++++++++++++++++++++++
>  hw/arm/meson.build            |  4 +-
>  include/hw/arm/bcm2838_pcie.h | 53 ++++++++++++++++++++++
>  3 files changed, 138 insertions(+), 1 deletion(-)
>  create mode 100644 hw/arm/bcm2838_pcie.c
>  create mode 100644 include/hw/arm/bcm2838_pcie.h



> +static void bcm2838_pcie_root_class_init(ObjectClass *class, const void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(class);
> +    PCIDeviceClass *k = PCI_DEVICE_CLASS(class);
> +    ResettableClass *rc = RESETTABLE_CLASS(class);
> +    PCIERootPortClass *rpc = PCIE_ROOT_PORT_CLASS(class);
> +
> +    dc->desc = "BCM2711 PCIe Bridge";
> +    /*
> +     * PCI-facing part of the host bridge, not usable without the host-facing
> +     * part, which can't be device_add'ed.
> +     */

This comment is supposed to be next to the line that
sets dc->user_creatable = false, because it is the rationale
for why we do that, but it's got separated from it.

> +
> +    resettable_class_set_parent_phases(rc, NULL,
> +                                       bcm2838_pcie_root_port_reset_hold,
> +                                       NULL, &rpc->parent_phases);
> +
> +    dc->user_creatable = false;
> +    k->vendor_id = BCM2838_PCIE_VENDOR_ID;
> +    k->device_id = BCM2838_PCIE_DEVICE_ID;
> +    k->revision = BCM2838_PCIE_REVISION;
> +
> +    rpc->exp_offset = BCM2838_PCIE_EXP_CAP_OFFSET;
> +    rpc->aer_offset = BCM2838_PCIE_AER_CAP_OFFSET;
> +}

> +struct BCM2838PcieRootState {
> +    /*< private >*/
> +    PCIESlot parent_obj;
> +
> +    /*< public >*/
> +    uint8_t regs[BCM2838_PCIE_REGS_SIZE - PCIE_CONFIG_SPACE_SIZE];
> +};

If this is register state doesn't it need to be in a vmstate
struct, or does it get migrated some other way by the PCI core code ?

thanks
-- PMM

