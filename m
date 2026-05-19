Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BC64CD4F3C
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 04:47:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPCME-0006IG-5F; Tue, 19 May 2026 00:47:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wPCMD-0006Hx-Bg
 for qemu-devel@nongnu.org; Tue, 19 May 2026 00:47:05 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wPCMB-0007wP-So
 for qemu-devel@nongnu.org; Tue, 19 May 2026 00:47:05 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-67f7caa33easo6546766a12.1
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 21:47:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779166022; cv=none;
 d=google.com; s=arc-20240605;
 b=Q0Qijq3W+JiVmZLVyPSafPDZAj4sZj3ooVZvwmyLlCBy/xaqpgaYyS9qJOBR6n0l4o
 FGH6QSomy/Jv23MC6uohHn2JN1SkxAfaehYh7ba4+kKNEThP/TzvoYCEjf9W2b5gZ+Jt
 8J8b8RpPEwNF4Wz7R+VKrQjWZkNLUkQBcL+bTHsX2zfn5eXtz5f/yhxdy3uFj4n/cjw3
 UvpPvWXWov2PcN/bEXWPXp+LgpIA1gU46HbjQcMk+ZCD8d4JZIceCIV7xtX+7WHbBt0q
 u09Fq78/Phqa8zr5ogRYz0AN468tKptyw+LGSTUca7QnWZix2XRmQZ239PyWSPnJaxrT
 pnWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=3991GbzDPesCO5+15GL45/56y+2vXTmeBnW5Dhu9hXo=;
 fh=QdiGAo3+20dYAsNfYmSmkU0NWi4CmpUW2WBeZPr6iYY=;
 b=VoZxtT+zsUz9+jmxotUX8YtdDQV2MVBp/jbmFH13dqhjdo7SkZuur4ESNRqPQIRAq9
 9VstM31Wdsj/jzhz0ShHxkK4aUCP4GnOqBBGlpyd7QdMla1OoB625LPOu4a9KG/8wh31
 LPTgdl3K4o3e9ZVA+P5NMsD/Bqgz8R8CFnEmcq6yz+g/GAH5gIAJ1qt2dTigaU5xPZkK
 Kv2rmOGke7zHoRf6p+Zd6Sf5UtGpz7eoWM4wxGnhhIeiDqe5o3XsGLctNNEBvpdUNuh3
 Bsbf/LHXYwDw5GaiD4QkRhvh1aiFazzlyCVsMKoWECE6pgebP8OnqABmThcLrKLoMhoo
 JY9Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779166022; x=1779770822; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3991GbzDPesCO5+15GL45/56y+2vXTmeBnW5Dhu9hXo=;
 b=aqQHykO07em1/6kFMvdfUcXHD+UZSQ1bopGlV5Lxkx1ZgJ0ANcEdm9Ma8KoMIka55w
 vRv2KXzgC9YLPhEkcrw1JihLrll9qOtKz6jJpKEIdMD2fZoeH7f3K+pF1ZJKC0cXvxem
 81DDuYSRur8DwiIEUbwIOsiCHFCh5tTxcBAVVQazJYPwHWtqeL4tPuny+BCpGfy4LHPk
 9WUNkNhX4/Auj/wuU81OQtcrFgGnxdEaEwKVitx9xN0kE9BfyXOI0kBEoYo9dKhn/KZi
 C23AixGR/BYy0yI0nDxYXQe6KhIcUYXbYHXFl7uwCW9IsF6oGFutGwzaDgv/sW8XcA6l
 U2AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779166022; x=1779770822;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3991GbzDPesCO5+15GL45/56y+2vXTmeBnW5Dhu9hXo=;
 b=p6Mu6jUPHWZ1yCqqSsYd+69XTnbcxeEr5MvGaph6PbcBn4Mlfl7PxHFK3t4YHuK3je
 kkyT19RLz66gw1iiFsi+CQ6IwMfGwoZ+1hy4N7ap2tEBuqA2bffvFK48wgwROZKZqt3f
 ts97xM7hyGF6S9jlBOuzauGoW6R5hGXZPARtS+8FQCbaxdqtxWWn9/BUj0bZzLg6vjiB
 zO4Uly4/DIDk+gd8JLzWX75yAPJvfOSsNmXuMRbZ0yEjKozj7595kPek379PUBElaOnu
 AkuktEhObDuxYg+QU/oRy6z974k7V4j7kAG38/KcTyWGdTFqdD7iRm6EYj/jtLYDUT7h
 t8ow==
X-Gm-Message-State: AOJu0YybaTe/WtujIJGuh6wbp9bu1Qt97AKj+Yk7DWvA5zemxvr0XgMX
 E+gQQkNhMNuvsjP/uHx/pVZ7mprbqTHZ/0x91xPhzht2xKxj5r62lvN4z85YmE0JWN3WrqB9jFY
 sJ099VuaBV6weO1vQXqFeMGqfOmFdjmA=
X-Gm-Gg: Acq92OEjtYrcbzQDVpN74l+735lI2GuvfSLone44Gt3KP6iitp+g4Vue+yDI5ZhoNkw
 5M03wQxRDdF68aXMdmWSkxUgr6/HyNOG6qfC0JXF45yaAuI6372eX+DhVzoZJsJNI0Nsi6RUUsF
 IKDWo+lJTjJJ3VwRoDwY2mwI9Wsy1tUEXYUYFaq9yMMt8QPzqPa1ze08aFwvipS1A2ewu1Pxkxl
 RbPfq4b9771hoppi8qF2x22RD/wcbcfqLUq+lV2eMfyu7Cwe/0KMbFHjCrbXgVnoTAeTb3FLjG+
 fEZ5lnxT1S+eJa0uIEvddRGNIlCr5UPJj36SWg==
X-Received: by 2002:a17:907:72d6:b0:bc7:73f8:9f4c with SMTP id
 a640c23a62f3a-bd5177d53admr962489366b.8.1779166021947; Mon, 18 May 2026
 21:47:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260428160103.3551125-1-jim.shu@sifive.com>
In-Reply-To: <20260428160103.3551125-1-jim.shu@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 19 May 2026 14:46:35 +1000
X-Gm-Features: AVHnY4LFsH2fj3ff9PStkK8G1AtLrPN_8ZfKM6cRDmwBP4DOtijRnZfuvexTlP4
Message-ID: <CAKmqyKNVUUhRYt0Dn6cBF9FUqGEKAJKdAyc+7u__FbCE8GuZVA@mail.gmail.com>
Subject: Re: [PATCH 0/4] Minor fixes and enhancements of RISC-V AIA devices
To: Jim Shu <jim.shu@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x532.google.com
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

On Wed, Apr 29, 2026 at 2:04=E2=80=AFAM Jim Shu <jim.shu@sifive.com> wrote:
>
> Bugfix:
>   - APLIC should also clear pending bit from rectified value when it is
>     in the both level-trigger mode and direct delivery mode.
>
> Enhancements:
>   - Add reset API to APLIC and IMSIC device
>   - Add trace events of APLIC read/write function
>
> Jim Shu (4):
>   hw/intc: riscv_aplic: Fix level trigger IRQ in direct delivery mode
>   hw/intc: riscv_aplic: Add reset API to APLIC
>   hw/intc: riscv_imsic: Add reset API to IMSIC
>   hw/intc: riscv_aplic: add trace events of APLIC read/write function

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  hw/intc/riscv_aplic.c | 116 +++++++++++++++++++++++++++++-------------
>  hw/intc/riscv_imsic.c |  19 +++++++
>  hw/intc/trace-events  |   4 ++
>  3 files changed, 105 insertions(+), 34 deletions(-)
>
> --
> 2.43.0
>
>

