Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48F68CA101F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 03:29:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uxzt9-0001BF-Uh; Sun, 14 Sep 2025 23:28:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uxzt7-0001Aa-Bx
 for qemu-devel@nongnu.org; Sun, 14 Sep 2025 23:28:22 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uxzt0-0007Gd-1T
 for qemu-devel@nongnu.org; Sun, 14 Sep 2025 23:28:21 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-b07e081d852so277813066b.2
 for <qemu-devel@nongnu.org>; Sun, 14 Sep 2025 20:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757906886; x=1758511686; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AoA/jqUKIY0v6dxNbyWGOocOt8tElA1wb0Q++UnjMe8=;
 b=eDJNhy+/MdTSnP6IqHbk/T5sabEPNu4xnvi5TUanHPXWyhoNh00bvUk8xWS/uGhzfi
 CEjK6bnNze6wI3n2mhUmZR6Gy+PPZtmLuyhF1WmuRsfD8PquLkJsk/aPdpjPeaqC932q
 2bO90DVK9JiAv9nttL6qWj7rsNPlfTp9ru0yhsRJIYxfOVuqJlTlB+uhJ7p8Bev5VhQZ
 y0qHXIK+gdwh1VC9xyzzOSm3iudCjR/UT4wkcPaKx00Ul+Dr2Kj+Dx2eKe6ei0cCl3q0
 h0J3lKxteu1Qkaut+jx9J+7VJ4glWRQZqMc2Fd1W9Qrs1p7rzoNqTv5PPlwWQexXOJYB
 xsIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757906886; x=1758511686;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AoA/jqUKIY0v6dxNbyWGOocOt8tElA1wb0Q++UnjMe8=;
 b=vUJQmHtFLuYsmn8L42TwhwtlfI4UgpTjuq4KCfOn4MoufwgrLgQB+BnyPTA+CNTAjm
 pDd9tyOm8L2aTEMhDsPwsH/QwBoK6NxdJdo3QJqnAvJ5+DaMlSISbxhUgY5mz0McgsV0
 zRBreC7tbWrblX2kNSwCUX+6aOSLP2FdgJiqGx0unhKHgnXWshQxBwqGxjnKeVuQMUvx
 v4jYwvF/ezDgt3z3NVvSCXaLduOfO+S3BI3CAZWSKhA7JR3Mrdquw1p8DjN7Xk2kLnr+
 O/0qH44gcK3BbnMvczxih92R1Qwpkx+mrADoxaPGXJ0i171flqasleU/fuNGuQ/ECIaR
 hjBQ==
X-Gm-Message-State: AOJu0YzFfATZSiFgg0d7Cm0BOQ6vbEWfw/tYxUg5V8sC+QZbyZ/ans8I
 g3teGlRQxfzs4Q7Ite78sFPeoi4O7ekahna2cLbv4dByUMwhkjyV8+Hz4WIHCwiRLGFZaiBp8t5
 bTqKM8312LVIoYLfd6hf7UqQVZC5Hf3E=
X-Gm-Gg: ASbGncugwC9S7QhBeqTlTMEC9NNLsQerWuiN43nM9ulsg14Ky4IzMLilERgJGp72bH8
 BKP4S4Fn53CyVUywLFaTsWmXc6sxEnbdjISNFi0raDyYl8eRgsbD/BrsQbzY3s5MEf1p3EuIKIj
 9DaemMg6VmQnSK+AQJY7Z0ZKBfRnKkW1JpGOBxt1BgoCgP4zf2oMfAZx12jfd3SUfaYMkWZ/4KF
 ssriDo5xQ9jcAuBejOUOTtZwblP+uuKa3GVvg==
X-Google-Smtp-Source: AGHT+IE6syJhHOmX/rZPDFWS0oUKiq+DJVsDRq4rijkXJvHZUla7t7I5VrgQ99zeDUtExKtKqsTTinX6Yet8oOgGC+0=
X-Received: by 2002:a17:907:9710:b0:b0c:6cae:51f5 with SMTP id
 a640c23a62f3a-b0c6cae68b5mr560805966b.43.1757906885662; Sun, 14 Sep 2025
 20:28:05 -0700 (PDT)
MIME-Version: 1.0
References: <20250723094213.2975268-1-dbarboza@ventanamicro.com>
 <20250723094213.2975268-2-dbarboza@ventanamicro.com>
In-Reply-To: <20250723094213.2975268-2-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 15 Sep 2025 13:27:39 +1000
X-Gm-Features: Ac12FXwOg9Tu0NhrKXwqZSOwfzdumhheic31N4SS9IPCYyiPsC3Uj3etjjqXF0M
Message-ID: <CAKmqyKPirO4wLus3kWeHk_ir6kOTru6U745AVUW1jNzYXbzr2Q@mail.gmail.com>
Subject: Re: [PATCH for-10.1 1/1] roms/opensbi: Update to v1.7
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Wed, Jul 23, 2025 at 7:43=E2=80=AFPM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Update OpenSBI and the pre-built opensbi32 and opensbi64 images to
> version 1.7.
>
> It has been almost an year since we last updated OpenSBI (at the time,
> up to v1.5.1) and we're missing a lot of good stuff from both v1.6 and
> v1.7, including SBI 3.0 and RPMI 1.0.
>
> The changelog is too large and tedious to post in the commit msg so I
> encourage referring to [1] and [2] to see the new features we're adding
> into the QEMU roms.
>
> [1] https://github.com/riscv-software-src/opensbi/releases/tag/v1.6
> [2] https://github.com/riscv-software-src/opensbi/releases/tag/v1.7
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  .../opensbi-riscv32-generic-fw_dynamic.bin    | Bin 268312 -> 268752 byt=
es
>  .../opensbi-riscv64-generic-fw_dynamic.bin    | Bin 272504 -> 273048 byt=
es
>  roms/opensbi                                  |   2 +-
>  3 files changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/pc-bios/opensbi-riscv32-generic-fw_dynamic.bin b/pc-bios/ope=
nsbi-riscv32-generic-fw_dynamic.bin
> index b2e740010b..02be3a72a8 100644
> Binary files a/pc-bios/opensbi-riscv32-generic-fw_dynamic.bin and b/pc-bi=
os/opensbi-riscv32-generic-fw_dynamic.bin differ
> diff --git a/pc-bios/opensbi-riscv64-generic-fw_dynamic.bin b/pc-bios/ope=
nsbi-riscv64-generic-fw_dynamic.bin
> index 018b4731a7..cce35c65c2 100644
> Binary files a/pc-bios/opensbi-riscv64-generic-fw_dynamic.bin and b/pc-bi=
os/opensbi-riscv64-generic-fw_dynamic.bin differ
> diff --git a/roms/opensbi b/roms/opensbi
> index 43cace6c36..a32a910691 160000
> --- a/roms/opensbi
> +++ b/roms/opensbi
> @@ -1 +1 @@
> -Subproject commit 43cace6c3671e5172d0df0a8963e552bb04b7b20
> +Subproject commit a32a91069119e7a5aa31e6bc51d5e00860be3d80

https://gitlab.com/qemu-project/opensbi needs to be updated, but I
don't know how to do that...

Alistair

> --
> 2.50.1
>
>

