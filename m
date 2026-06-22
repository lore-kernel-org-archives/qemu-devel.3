Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E61E1CD98F0
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 02:41:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbUZu-0004Pe-BJ; Sun, 21 Jun 2026 22:40:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wbUZt-0004Oo-1i
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 22:40:01 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wbUZm-0007Ad-6E
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 22:39:55 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-691c5776f35so5275460a12.3
 for <qemu-devel@nongnu.org>; Sun, 21 Jun 2026 19:39:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782095992; cv=none;
 d=google.com; s=arc-20240605;
 b=Ttln+xzKkIHfMSXfHZsbCuN5ejB2JYesi7njPboqaTEVB75bxXOOB0+ArelM1EgeLH
 +N8MfgRefDa4Iuh2sY8a84CAlJLeOLnr3/q3wMQt5i7N3Mos+DGRYiww8jS76JqrRGLb
 kfkuPEpbja1WCGZib0F17vBTlhlg2E7EfC/bK61GXdIL7UpbkMlodJ4LFHGFeCRR7mbi
 TEVSD1djALetW3KeT4ikRej1mZQgJ8NZZMj2kHj4dO86KEnzZpxsv0jM4dsR9YcJ/TSs
 vMQ8wB6KjU+2x/QBId7Bshy6bJUdpZ6MVWg3D0wFfVhQuh8VJKpFfiEPwZ/LfUlXxpCV
 o/QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=BfBCEKNx6wiLcALwkO2rf5NF+oLg7W772NfbvvJ+zKc=;
 fh=y/39rxWsHsSIhiCgFyox46bvYsAfNaBS3wRFv9pkMrs=;
 b=CKr7MrI0HC2xp3xTDsEg0MZMX9DySIoJ29Fp0SSRjvT4LbIrpNtSCo4MTafBiRrUrT
 v5K0L3PI7fc8IjMi1XtjN/kXkxxOEPrizRh8FDya1U7oh5qfxRcDbYYGpELV0H+wr+ir
 VmOrYNv3wIPwQROevjtHDvbz2f3/zlkK7rboRpGjhiwrY6aFJ54KnZ6dAuLlt9BeFUme
 JbUPYi9IuKDlRDESoJscHxskCUaGS88Qnnf7xEMDTWeHYCIF8Oc3fBEZlO6kG9ZuwGbO
 sWvDcgTnlMDrd3kSbsEZBIoRDbE8p6RTEbyuKz9HHhKKYPtOUYHT47yU5bicfdaQZLZa
 D0LQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782095992; x=1782700792; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BfBCEKNx6wiLcALwkO2rf5NF+oLg7W772NfbvvJ+zKc=;
 b=X5Pw44VqRZkc3NDcfw/9NtdJEUMjgFNfIjur0kmUUS4Sh23TX1wZPViscpC8vkDvQb
 PIfM1Ft/NV7Vl5RypEX2zuzPLp/QNzKcUApfBl3C8Osg6U4WllJqyuNH9PhBg7AJSP1H
 xKTLCDNkJSp9V9FGmRjzi0vJOhpzxtaod+muByqeoCMDqYEXKS2OIJvmxEFBlPaHPdpP
 mzQqm97ep5s0LC34SGnf2hsnclkBmGNEzsGvQYgjosMunEjoUTCgIew5RzDIDXgEv6lV
 y/BxDLDG7jcvdmJdZWoWxyeQHiV/h+32TFP0Trv9EFButQ3yexSQzD5vM7Hyc5sHH9yG
 /BcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782095992; x=1782700792;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BfBCEKNx6wiLcALwkO2rf5NF+oLg7W772NfbvvJ+zKc=;
 b=rS6MzzdgHYMvT3j2mBsRM3+NI+BUeFtgaxy3pPFsKbkqToU2BE0Zs4DyyK1vlj1y4G
 bLaXvh5Dmg4TpBpBlGA0/EfChtqVGLGUrCH65BBA3G34Tz24wf/L3/KGmcMGu/KrngjO
 2BEXmoAjreuHepMdZ2nr5x2IIdWc67EfWpWlcHYtWAeHaA2P9NqO3NjIB8psEZdxsrT6
 Af8y6QwTCqa/QCsxV3IYt6YfwExYTDRtk4G+U6MMpX/lLKm6ll8hNkFRhXKr7RYbohS4
 UYloPa39CfKx0BluH4SUJsO6VNYGz/aWDLCqiaRgawqT/32BrCsP7ueiAF1pUGsi4B7H
 TC8Q==
X-Gm-Message-State: AOJu0Yxql06iw5k8+ZdE0bUnDEoHJ85qBYxrF4FkNCk94vuFO2hWTB4i
 rDHJXZruSQUyik8HvoS60ZocnvVptAz735rjOSrf71P4sIE9VAAfDoTEWMBfnhEAV9UTqMgXNkA
 EUNs8KlYzDGaVRQQkYkB+IJKr6C+xklE=
X-Gm-Gg: AfdE7cmA4HAWmeuYx+M1h+X2gb3LWujXXgv+l2Ht3wc8uWLep+hxppnNz4wYn0eR3TX
 hPWb0fLZzBqyjM8J7/TmJ+ncNHuVggfBCB8D+sY8A0ZjGMeLXE2MJD17he0Q+qPbgUmTUvv/pJM
 09sbA85ODeq/prpxVigY6QtmlAoIVFiaHW8N0DGFhhcBjTbgIJZdwubh8E+5ReP6LfIdjcwkdia
 VCXaeCYI9BfTxTsxqboS38xNadO/79Se1CQOr6hGQbvXiMWBd0V5sWSWlf627nMkIB652TjaFJS
 vMoJkaFU5/LNBytZjEnV30+PXa8=
X-Received: by 2002:a17:907:3e18:b0:c0e:e136:5dc9 with SMTP id
 a640c23a62f3a-c0ee145c108mr68722966b.37.1782095992306; Sun, 21 Jun 2026
 19:39:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260611162223.2361941-1-daniel.barboza@oss.qualcomm.com>
 <20260611162223.2361941-2-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260611162223.2361941-2-daniel.barboza@oss.qualcomm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 22 Jun 2026 12:39:25 +1000
X-Gm-Features: AVVi8Ccy8TPAP1bOVGvSPAkHXWbio7X2Ttuuc6fQ9wqPh-E7ghyRlJT7Vc0zn9c
Message-ID: <CAKmqyKM_KdpFevyDT_T_xppAcaEU7qzyzdK3SZnFrr1JhSyqeQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] target/riscv/cpu.c: add 'svbare' satp-mode
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com, 
 Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52c.google.com
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

On Fri, Jun 12, 2026 at 2:23=E2=80=AFAM Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
> Seems like we forgot to add a flag to set satp-mode=3Dbare.  What we're
> doing instead is to set the CPU default satp-mode to 'off' to set it to
> bare ... assuming we know the default satp-mode.  Otherwise one needs to
> do -cpu X,sv39=3Doff,sv48=3Doff,sv57=3Doff,sv64=3Doff to get a bare-mode =
CPU.
>
> Add a flag to make this process easier.  The name choice is based on the
> fact that I didn't find many references to 'mbare' in RISC-V docs, but
> 'svbare' is a flag name that toolchain uses to set satp-mode=3Dbare.
> Might as well use the same name to help with cross project compat.
>
> After this patch:
>
> $ ./build/qemu-system-riscv64 -M virt,dumpdtb=3Dfdt.dtb -cpu rv64
> $ dtc -I dtb -O dts fdt.dtb  | grep mmu-type
>                         mmu-type =3D "riscv,sv57";
> $ ./build/qemu-system-riscv64 -M virt,dumpdtb=3Dfdt.dtb -cpu rv64,svbare=
=3Don
> $ dtc -I dtb -O dts fdt.dtb  | grep mmu-type
>                         mmu-type =3D "riscv,none";
>
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  target/riscv/cpu.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index c1b10cc7ef..d968daa404 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -421,7 +421,7 @@ int riscv_cpu_max_xlen(RISCVCPUClass *mcc)
>  #ifndef CONFIG_USER_ONLY
>  static uint8_t satp_mode_from_str(const char *satp_mode_str)
>  {
> -    if (!strncmp(satp_mode_str, "mbare", 5)) {
> +    if (!strncmp(satp_mode_str, "svbare", 6)) {
>          return VM_1_10_MBARE;
>      }
>
> @@ -1053,6 +1053,9 @@ void riscv_add_satp_mode_properties(Object *obj)
>  {
>      RISCVCPU *cpu =3D RISCV_CPU(obj);
>
> +    object_property_add(obj, "svbare", "bool", cpu_riscv_get_satp,
> +                        cpu_riscv_set_satp, NULL, &cpu->satp_modes);
> +
>      if (cpu->env.misa_mxl =3D=3D MXL_RV32) {
>          object_property_add(obj, "sv32", "bool", cpu_riscv_get_satp,
>                              cpu_riscv_set_satp, NULL, &cpu->satp_modes);
> --
> 2.43.0
>
>

