Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8A61CD8C9D
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 03:53:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXsxa-0001k8-AE; Thu, 11 Jun 2026 23:53:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wXsxY-0001je-HQ
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 23:53:32 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wXsxW-0001Du-TN
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 23:53:32 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-68d23430690so952275a12.3
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 20:53:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781236409; cv=none;
 d=google.com; s=arc-20240605;
 b=bHlZqZMnbf/ui4GWrJcWDsf1Iy5WLUUarcqj2t9dx61dnlD4GktnOY7R8E/v4lXAB9
 aWMkhKCXTosg7gwIyhmiUch1SqMrWdnqru+KSDnK827fD0f1sPTL+KpVn5geZkwrYDqP
 YtGS0mzNHJhPhho/HCXpkW9Tkayhi1gvVP0KSe89uYYmO8AUVqZi+6sj3LCDXkFuqwZy
 hFi+o8noEPTNMkHX4xbOkKWsr7BfHNujSmbCVQNelyx+8nsMOyI1xX+4U7iRQdYGlArQ
 DTUgE+PgHUm/vYXABQ0dYqiOPJzEP5RY8PZLPworsMWxdaXNqLspSW8xSU5ULtTjXUyb
 rezg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=NT0jiI1LL8LpL+XLatjRNUWIc5cedH8v9+dfJaedNU4=;
 fh=y/39rxWsHsSIhiCgFyox46bvYsAfNaBS3wRFv9pkMrs=;
 b=RBKHocgsa6e58ZTscbK8CwLkwNpk8QieGpF94hZq7zYoly9zI2qWHPSwGyPeUmOQEv
 QdOOS8eSuOeiy10BH1MAs0gvdLNEANDGYfpxxanuIklFKXMzgF4L5ZBiGgAdxnUUBTL6
 D4NkcO7UzKWDMDn1FdV3rDUVILJIXPGezYWXDPwnsf1jBFhvx1yjqL7DpCRfj2fcggZO
 u3YTfHi+937PkzXQMYdw9HFCpo8Bf8WrMEoUfPg+RdknAT7z11ctRmMOWhsV/8WyFpEp
 PdOFvmpmhM1yXpzVBtXSecEwchvlcquMQn0IR2BXnGRAfKaR245Z8UzUegLYdybmcnjO
 hX+g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781236409; x=1781841209; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NT0jiI1LL8LpL+XLatjRNUWIc5cedH8v9+dfJaedNU4=;
 b=AlTdkQrvqI4VpNsqFnUKPzYI98jWhEtzAGSi0KiSePcY6rfQc0i8NnuE8nbBx+aXT/
 M79x4EIxo/pQp9ztwpS/g5wvGvYsUhPrctGff9/gvENVmBDrrdR1Je5kYuN4G5iOd2wa
 QaMtDPmqyU7jtJKGJnWb+8/f5UNXCEb+xWFxl12DBu7YrngKhH5ZZflL7karu3Yxtx7O
 MD8h4s0Zakdzs/xBKNMNwAlIa1m9MUoS+ix61YM+f9GBnXMyk/jE6bpz5oKh0AoCbyXJ
 AxvKc7X6ZtenU2+6DfKlAfGzalLrSR6Qs/NfFN02Zz+exxNf6iIFfB0sGqRlGiJPTjmM
 BW9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781236409; x=1781841209;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NT0jiI1LL8LpL+XLatjRNUWIc5cedH8v9+dfJaedNU4=;
 b=O5k31jmjF7aTW+ZraG8HtBkqkwkj3LLoj6AciHMwnTmlwm0ZjA5h8uMkh+w5WTXuhC
 qkWD9sGfwsPrNUqtF2ghdKpaoB2QPLapB8pdkQxH02m+NjVli1WNk1qYiO1pUzXfXk1a
 l5OXlGcyEa0SM/9nw+ak6oYpmt+iyHGVMafIhsMz6K7S5ANuGZlQgparyU9azsS4Gd+G
 fFh9xnNvN+8Ob9WSd0xotNET308Z+jBbUBkiJiKtuRQ7L6gF8CeZT1Yg6cd+ha0T7KCD
 nIOBXMMTJ5kmj1JKRXGJRX302oUZi+hmw6MDBd0ajJlwz90JJCjnoXtMAMhTRM/UvWJh
 +4vA==
X-Gm-Message-State: AOJu0YzRU5gvoxNKyQEGNsBp3mgx6qVLlyW44oZKIemTuu66JlW/nnRx
 GDS5krJNSMyl15OaKlBLDwb1l8OF4Sa4Q3NSwr3J3S0P06idtc/VzP5bziA3/DOQtpPV4L8rUCA
 9ADc41/X3aS/evRWZf2OEq3KgYJymBIY=
X-Gm-Gg: Acq92OEOhxCoJJzxBQD/LGctPN21LyhfEwzlYztXAISm2GYqozsT1b0jik79lxANQpa
 rg6FbxJSNsY+AGnr6vClNO5kephsYgG4zAaxzvN4QXL1cO3dILgMVZalITNQGOt7D4lcUPx2MGe
 h7N9f9V/R7ib02omZrzUJtTAhaw5A/manQCnSalGvKjwdDYQUzjfcVYPRqjE6oAnPCMwl/h0HCB
 o/beto74l7gt0LLjh1uZYkhWQdSC77wn4BTlrPv48b7XFSUHF36Xzaf2a7GqDKFkUn+UUgMGQkq
 RbNKa3mOUxm2PbSgIvKPQ6309AmMx7uukLlrAA==
X-Received: by 2002:a05:6402:2349:b0:68f:cc95:ba5b with SMTP id
 4fb4d7f45d1cf-69378a9515cmr357891a12.27.1781236408994; Thu, 11 Jun 2026
 20:53:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260608210642.464131-1-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260608210642.464131-1-daniel.barboza@oss.qualcomm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 12 Jun 2026 13:53:02 +1000
X-Gm-Features: AVVi8Cd3PdcYY4Lv5bkQDoI3Ozt8d_lSUNo6Kfo3lDflORknv8xJMjd4iF-jCPg
Message-ID: <CAKmqyKPCRKMnrUyWEZerHF30Gwvdo7nds1LvFUiK=JoW27CSew@mail.gmail.com>
Subject: Re: [PATCH] hw/riscv/virt.c: fix 'iommu-map' FDT entry
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com, 
 Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x530.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Tue, Jun 9, 2026 at 7:08=E2=80=AFAM Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
> Based on the DT documentation of 'iommu-map':
>
> https://www.kernel.org/doc/Documentation/devicetree/bindings/pci/pci-iomm=
u.txt
>
> - iommu-map: Maps a Requester ID to an IOMMU and associated IOMMU specifi=
er
>   data.
>
>   The property is an arbitrary number of tuples of
>   (rid-base,iommu,iommu-base,length).
>
> ----------
>
> We're adding a no-op entry (length =3D 0) in iommu-map:
>
>          qemu_fdt_setprop_cells(ms->fdt, name, "iommu-map",
>                                 0, iommu_sys_phandle, 0, 0, 0,
>                                 iommu_sys_phandle, 0, 0xffff);
>
> This is easily seen in the generated DT:
>
> iommu-map =3D <0x00 0x8000 0x00 0x00 0x00 0x8000 0x00 0xffff>;
>
> The tuple (0 0 0x8000 0) does nothing since it has length =3D 0.  The
> information we want to advertise is in the second tuple only.  Thus
> remove the empty tuple.
>
> While we're at it, seems like we've mistaken the API and we're using
> 0xffff as 'last address', but in fact it is length.  This means that
> we're telling the DT we're mapping 0x0 -> 0xfffe, which wasn't our
> intention.  Therefore change size to '0x10000' to reflect the address
> mapping we want (0x0 -> 0xffff).
>
> Found while reviewing the RISC-V Server Platform DT generation, which
> happens to copy a lot of code from the 'virt' board, and this nit is
> also present there.
>
> Fixes: 2c12de1460 ("hw/riscv/virt: Add IOMMU as platform device if the op=
tion is set")
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/virt.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index ce64eaaef7..0c489bb412 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -900,8 +900,7 @@ static void create_fdt_pcie(RISCVVirtState *s,
>
>      if (virt_is_iommu_sys_enabled(s)) {
>          qemu_fdt_setprop_cells(ms->fdt, name, "iommu-map",
> -                               0, iommu_sys_phandle, 0, 0, 0,
> -                               iommu_sys_phandle, 0, 0xffff);
> +                               0, iommu_sys_phandle, 0, 0x10000);
>      }
>
>      create_pcie_irq_map(s, ms->fdt, name, irq_pcie_phandle);
> --
> 2.43.0
>
>

