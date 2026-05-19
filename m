Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A5F6CD4851
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 04:22:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPByT-0007Zo-Bv; Tue, 19 May 2026 00:22:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wPByR-0007ZR-FX
 for qemu-devel@nongnu.org; Tue, 19 May 2026 00:22:31 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wPByP-0006bW-Np
 for qemu-devel@nongnu.org; Tue, 19 May 2026 00:22:31 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-bd4f8260e4eso629471966b.1
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 21:22:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779164548; cv=none;
 d=google.com; s=arc-20240605;
 b=Xntd6fwq+8exCexVGZ8Zul/DT983yL1O/hkqiz1o03UOHXwYFmEaO+6dt1s3BJGwlM
 ndItGPiCaGNcKOdxLkFf4F+HVmES9hZM/tjgrDSE2q/KJYp6gOGI+hQcfSq7pzBPutSC
 059T2/kiXN5WFHIcmgeDRaGtL+R7/laBJIOJpMMrxUlhXKrwHL6rdtuvEKCC4WBTOCr0
 9vJwMSNCfRXGJA8VdRWqg5GO55goq0mNXJkSO+QptzBdQMVQt0+04h5ltxMLegYSHODn
 zmIMBiSRVcdsvkmaBcOUdEarg7jFe0ncQFt5ChYWHufXCNK6lAOSNjfuCXM08ehS8YGR
 Yfqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=0gS5x0srMRbZK8/Rz76zI9Hj+kTIzrvEglB0nUzdkQ8=;
 fh=+dPXGxW3pQNYFrTSil53fSXYfdhGIs7bI6Dyql1Mx+Q=;
 b=EV3YCN5KWDJnKevj5gZse+HTmbi3mz3q2FC5MgAvyiR2NbLclo/XtGgKwUZE2Uqgku
 TF8eNdUxR4j1iEfhuDhyMguxy6m9Mp15VnYmvKu5agC8VIXUbKlk2s85gAz84NAsuYLr
 PxVt3cWiMYyHEKt63JqNylKkXi/30BiFEvvk1RF4SGHyfgOxYidW/61pB/Uf/nOXK7Mz
 v/1v0SHaJg2gmmyhPpyyD8TwUcaiwE0NavS2UQ+Q4y1eJrVceNBCR78aKhIv6eui2bSL
 EdOrIRQS/8G9VohJIIHPA+ZS+GiXEL7+4A+4KgpBppMsaHFZf20SuuqO7alwoPFffAyU
 fbmg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779164548; x=1779769348; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0gS5x0srMRbZK8/Rz76zI9Hj+kTIzrvEglB0nUzdkQ8=;
 b=UaHiIMu+WDZJXcCnTwicWZTMqUFmO8D8xSOP0bfWSQHlNEEmeH6XR9J2D/Ql4L13px
 +e3+qx2Dk+dVaRbCXX9mfX03It5GCUfdpj9DSzrAaJANgx7EZu9pL9x2vva1wE6gUl2s
 HKhW2qSxa0Wpksn59PZvHLbM1RyP/8diUJNjQX4g3TAALHKnQsdNv9EdxB/6ag/pQQet
 rxgZ13fQoGt6OPDjoZs4RaVbUa5WbsF3DJkzK7kPxufIzpNzaEcK4lQoFZrR8u5Mu8+l
 oTaF4eO/cmFMpUKCoShPC3PgIwoCPor/09xVbyEeEfg1pjC8SGVkIsg3NbkmXOE43zDt
 ubFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779164548; x=1779769348;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0gS5x0srMRbZK8/Rz76zI9Hj+kTIzrvEglB0nUzdkQ8=;
 b=OhjU5dE/PR6kIJWFzuJv/ce3ZrkPeX+yfmNYdAJ6ZxYbKHc8Ym8WnB0kojLHBTQbWH
 8iq2U4I+jq0khMEmNEdE0cu3SNWoK05dxCapq5LPltSwRugcl++Brz7du5x+cdR9Bw6P
 HbU6UOMsHLEAMGlSj9C/YPJ/z5zJVT5DcsnZzT6rejXAteEu4u+2yYJUTccw09BZoWjz
 cPNnHLHN7sdoLEbCxnOkCPxQ4LtBZj3F+gZ+LcPqSQ/AmZbFq9fP6KuVh4hv6dLuFjkL
 /2Ob8XC4vw7HdesueXTuSaGoyXTuCLUTR9omvMGWoLkKc9cbWVVgatXkMweRCJGqQGcg
 Ir4A==
X-Gm-Message-State: AOJu0Yw+ZV0VPZRgb8tlcV/NhGxTHFhzWqoN9ZCe1Wb5VpR2Kjxg1Lir
 kAw2KWLvlYs5Cna6U+QzRUseb+Sl35JRewWaDq/pk5ulEdt7uJJa58STA1J93HFrBgdwoObsC9l
 MJkt0uDhMBdf+SDZ1mFVsWIpMntCzifU=
X-Gm-Gg: Acq92OEIbjk8CdnUj2op7EjF7M0cugzBLc3ac7pQmJAUIaL8Ec78osHr5P1sQ/BfmKR
 UTqbjMyDlNlnm+pPFNbsvyxe952pp740zIJPSwgrFtRWm2O4FLjYa+4D6LTHGpC7BbbcWbTp5Rs
 GaW+T5vO6unMeG4KBxGLHdjmQwAqfZBWt6rIUrZY+ceRlD4/a4TWJaahGj9OSaZtACD6J4Z1GjV
 gbKEYGni/RPo1f2psNNhne4oS7SPlpwEsOcGqvV8B4+1PDjFfccN3T7jB+3FnlKIO/UeKqodnHy
 8F4jyBSLfjdyuPGPb+hCDC2ZEJWLmXYtfT2O4A==
X-Received: by 2002:a17:907:1b1b:b0:bc2:e438:da0c with SMTP id
 a640c23a62f3a-bd51780540dmr804257766b.22.1779164547761; Mon, 18 May 2026
 21:22:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260512032926.1978818-1-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260512032926.1978818-1-daniel.barboza@oss.qualcomm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 19 May 2026 14:22:00 +1000
X-Gm-Features: AVHnY4IB2-rxHBbJ7-fRokujdTkh6w8Jjs6Y_k2PqOB97OTdcDLpsHW2T9GSP1c
Message-ID: <CAKmqyKNcyr27MkEzXseUyvyqbNRFLYFDX9tB599hNMjae0xAgA@mail.gmail.com>
Subject: Re: [PATCH v2 00/14] target/riscv: remove riscv_cpu_* arrays
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x636.google.com
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

On Tue, May 12, 2026 at 1:30=E2=80=AFPM Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
> Hi everyone,
>
> We have been dealing with two sources of extensions information in
> target/riscv/cpu.c:
>
> - isa_edata_arr[]: an array that we must keep in riscv,isa ordering that
>   also has priv_spec info;
> - riscv_cpu_* arrays: used to set user properties and set defaults for
>   rv32/rv64, among other users across the code.
>
> The main issue here is the info being duplicated across arrays.  When
> adding new extensions we go through a ritual of adding basically the
> same stuff in both isa_edata_arr[] and riscv_cpu_extensions[].  We can
> eventually forget to do all steps of that dance, resulting in patch 1.
>
> The second issue is a desire for less abstractions.  An extension is
> something that we report in riscv,isa, that might be exposed to users or
> not, that might be a vendor or an experimental ext.  All these
> distinctions don't require multiple distinct arrays.
>
> I also made an effort to start moving away from the 'named features'
> stuff we have going on.  A 'named feature' is just an extension that
> most of the time isn't exposed to users, most of the time represents
> innate TCG behavior, and sometimes have a different enable mechanism
> aside from setting a flag to 'true'.  None of that is exclusive to this
> class of extensions therefore I believe we should move away from it
> over time.
>
> There are more design simplifications I want to do in cpu.c and with CPUs
> in general, but for now we can enjoy less lines to maintain.
>
> Patches based on alistair/riscv-to-apply.next.

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>
> Changes from v1:
> - added a new patch (patch 08) to handle riscv_cpu_update_misa_x().
>   This solves a build break reported by Chao.
> - v1 link: https://lore.kernel.org/qemu-devel/20260511132910.1738069-1-da=
niel.barboza@oss.qualcomm.com/
>
> Daniel Henrique Barboza (14):
>   target/riscv/cpu.c: add xlrbr isa_edata_arr[] entry
>   target/riscv/cpu.c: fix smctr/ssctr isa_edata_arr[] order
>   target/riscv: make riscv-qmp-cmds use isa_data_arr[]
>   target/riscv/tcg: treat all exts equally in
>     cpu_disable_priv_spec_isa_exts
>   target/riscv/tcg: use only isa_edata_arr[] in cpu_cfg_ext_get_name()
>   target/riscv/cpu.c: remove riscv_cpu_enable_named_feat()
>   target/riscv: remove riscv_cpu_named_features[]
>   target/riscv/tcg: use isa_edata_arr[] in riscv_cpu_update_misa_x()
>   target/riscv/kvm: use isa_edata_arr[] for unavailable props
>   target/riscv/tcg: use isa_edata_arr[] to enable max exts
>   target/riscv/tcg: use cfg_offset as cpu_set_multi_ext cb opaque
>   target/riscv: do not set defaults in cpu prop callback
>   target/riscv/tcg: use isa_edata_arr[] to create user props
>   target/riscv/cpu: remove riscv_cpu_* arrays
>
>  target/riscv/cpu.c            | 315 ++++++++++++----------------------
>  target/riscv/cpu.h            |  12 +-
>  target/riscv/kvm/kvm-cpu.c    |  25 ++-
>  target/riscv/riscv-qmp-cmds.c |  30 +---
>  target/riscv/tcg/tcg-cpu.c    | 144 ++++------------
>  5 files changed, 157 insertions(+), 369 deletions(-)
>
> --
> 2.43.0
>
>

