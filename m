Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C267CD5BD0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 02:24:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRhSn-0006Mz-7j; Mon, 25 May 2026 22:24:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wRhSl-0006Mh-K6
 for qemu-devel@nongnu.org; Mon, 25 May 2026 22:24:11 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wRhSk-0007IL-4L
 for qemu-devel@nongnu.org; Mon, 25 May 2026 22:24:11 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-bd5047a2a4cso1531956866b.3
 for <qemu-devel@nongnu.org>; Mon, 25 May 2026 19:24:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779762248; cv=none;
 d=google.com; s=arc-20240605;
 b=chHCFZu923nhrRWpvgWpyNJn80PHLZe5OHho6uz5lDDfEtRjdOpuRIgEnOs+Y3BIOl
 BZPi1I/DUfau6sHP0xb3N7xEs0ODYae92u5f8LhD1ObP9I92M0xSu+7No1YIMwO3Zxko
 ki6OiQ0tPAHqGGGXcWh8BWrUZyWITqsyFQSNHdMcjH3OcHtBH/EhCnedGI58oRTbgQTX
 QTSVVum/PqZyFwRg8w3sLpkf5CVpw72o0iByQM8y+5V2VlNzUK3DKSOmoYSqnm86E5+y
 mMvTcw05GVSEnBg+mqHWVFozyFdJ/LxdqScA5zxAG7FP5YiWvYbSD/24HL3AN5hExwgd
 fYBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=0d9AZwgYpCL0YwPYf1oZyutx7N/DXN0wPbj2vreU/Vg=;
 fh=c5t5J5DuZ07TpANKDNQXBQqHNrBr5lv/14VrOPTGi+M=;
 b=GRnRedio4KwFL6qiX+xxbq8xMnq9po+m25EqXgBgn2/5mdQcPrJeLcpGv8ZQrlqBr+
 L3FiVx6eKlSaJqO3FuCmU1YKhhCiPVK3chk5pY8BGsBi+mzCqUS9NFo+xkRvSpevvMW0
 glAQyG3jGZof/6G59FvCqabXwzq0+e7fWlSO2HWLGue8OJa2wXLyXW8VqWjn3adHWqik
 JRvDGPzmZBUOoGOaC/c2BQB2ZxxQVp7ISV5CjI/LuK0JpJZ5Etdgbhj8qJvCCzpi5qfD
 2w1A7ml1Yww0jPkhNDOaNO5PMYugLo5MNPBxP4mCMBi4lCXimdsPbBkcruFVDa9iLFSa
 FA8A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779762248; x=1780367048; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0d9AZwgYpCL0YwPYf1oZyutx7N/DXN0wPbj2vreU/Vg=;
 b=MpcX/tmFg23TEo+RejWdIVEmPD/qrtTQXmiQ0Bd1JQJop10MF0OKMUohsvax2MEdn9
 J6RZ92FdVjYMEVybSdNIftpdYW+h/1Mx+ckLX1NZCnQQYiFm4mQoCQGpQ4+yHJTBQQ/H
 8SlAbCrSWXmwvSY+rTQCYsMKSKRIgyRBuv/AqzSDYnEr+sHF09umDJ0kZuiUUqTCoGyI
 B5u/jA7sfx5KZCb8iveex6RLnYdiPOI5hsn70IwlF/j/i1c6cm0Jhcu04ZVtC83nG8AB
 6sf8KTIj0fOdL5PTSd78PDsulMy+VVT9CDY6QSwJFX05auGsZOmQdKuPeFDpCWoZz1cF
 oWlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779762248; x=1780367048;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0d9AZwgYpCL0YwPYf1oZyutx7N/DXN0wPbj2vreU/Vg=;
 b=rk2Wvt5AlgfONDqGPUR9FEBykBz897HxvW7OyTFpvlzKMug7MSd+XJ0pyiHAaqEM6D
 cUpeL2Xyb+1L214VH0Uo0T1IUtJR9SqkHGH8upsbecZgBA35LlMU/OFWrBuPbj4wsNJn
 7Sj0PWAjAXWmUQcSZThd0jm0auHymCYOg0z4jlO93bvuO0IKZ4LxwAmfRFqMDGfZFvJ9
 0FV/sdD6wZED4geiMV2zc8ZVyfdHIIHpEj2ooP2bf2p5tvVfyCJMBzBVGs0SOCcLIj36
 33dgQzLy0HacdJVpk7ukTV2XG6Hqn9w67nNKDwM5aj9fkw9geFb7LO+htUnDUM8BfUez
 776g==
X-Gm-Message-State: AOJu0Yx3ewuO4nMJR/R+Fpo5TsPmyPGzVG3z81USPbc9gT41mK2jHzRa
 mrTeNKHy9U7zMSkA+v0qN+6uOCcA6Tkn/QjrisMVU4muXBR7PlkPeIhNq7MFPCGj8eI0yOrZ3Ds
 jyf/N6PNbvQ8e5qjAVn35eyK0q0Zt+kU=
X-Gm-Gg: Acq92OEQebLbh0hBFyue1ufuHs2XuHBswXfNDu72RQ+ItCf4lH89JEmukg3fs3G+ARp
 I4SMH1J0yrp0/wlh3NHYPPs/UXlItTNYxyLztUl8yUtTL8tfoImVLtm+18xskLuoIYmiKePW3pI
 XgtDXuVGvNTe9COdab+69Y+9CjGT0bX6e/2wxeHgPUGUEmQofv3N72WK/urzDKEsKrWqSkpDQF9
 aww53NZFlx6KjAHRK/G6yPgsBqVV7T4bCl+jZjUIOhfeVDhem2LHMqZ10MciXJlZaPQpD/AzvCF
 WcpI9nzCz5A1OHPAhrc6+5go7+NqCD/rc43SdBkasQwoLGpL
X-Received: by 2002:a17:907:8f18:b0:bde:77c3:ff22 with SMTP id
 a640c23a62f3a-bde77c40074mr454760466b.29.1779762247642; Mon, 25 May 2026
 19:24:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260520063606.36600-1-jay.chang@sifive.com>
 <20260520063606.36600-3-jay.chang@sifive.com>
In-Reply-To: <20260520063606.36600-3-jay.chang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 26 May 2026 12:23:40 +1000
X-Gm-Features: AVHnY4IUnLeifyRkSdRWadQT4iFTE3a7gnJWJjsM6FNL3uKwBCXz3ft9MqfTJG4
Message-ID: <CAKmqyKOQqJzjd4e4JYnxdMwxpEhHv2unL27C9vgC1j13gn5DmQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] target/riscv: Improve PMP address alignment
 readability
To: Jay Chang <jay.chang@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x62c.google.com
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

On Wed, May 20, 2026 at 4:36=E2=80=AFPM Jay Chang <jay.chang@sifive.com> wr=
ote:
>
> Replace manual bit manipulation for better readability:
>
> - TOR: Use ROUND_DOWN() to clear lower bits
> - NAPOT: Use deposit64() to set lower bits
>
> Signed-off-by: Jay Chang <jay.chang@sifive.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/pmp.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
> index 8adf7c9719..58a8923d0d 100644
> --- a/target/riscv/pmp.c
> +++ b/target/riscv/pmp.c
> @@ -247,8 +247,9 @@ void pmp_update_rule_addr(CPURISCVState *env, uint32_=
t pmp_index)
>      case PMP_AMATCH_TOR:
>          /* Bits pmpaddr[G-1:0] do not affect the TOR address-matching lo=
gic. */
>          if (g >=3D 1) {
> -            prev_addr &=3D ~((1ULL << g) - 1ULL);
> -            this_addr &=3D ~((1ULL << g) - 1ULL);
> +            uint64_t granule =3D 1ULL << g;
> +            prev_addr =3D ROUND_DOWN(prev_addr, granule);
> +            this_addr =3D ROUND_DOWN(this_addr, granule);
>          }
>          if (prev_addr >=3D this_addr) {
>              sa =3D ea =3D 0u;
> @@ -641,13 +642,14 @@ target_ulong pmpaddr_csr_read(CPURISCVState *env, u=
int32_t addr_index)
>          case PMP_AMATCH_TOR:
>              /* Bit [g-1:0] read all zero */
>              if (g >=3D 1 && g < TARGET_LONG_BITS) {
> -                val &=3D ~((1ULL << g) - 1ULL);
> +                uint64_t granule =3D 1ULL << g;
> +                val =3D ROUND_DOWN(val, granule);
>              }
>              break;
>          case PMP_AMATCH_NAPOT:
>              /* Bit [g-2:0] read all one */
>              if (g >=3D 2 && g < TARGET_LONG_BITS) {
> -                val |=3D ((1ULL << (g - 1)) - 1ULL);
> +                val =3D deposit64(val, 0, g - 1, -1ULL);
>              }
>              break;
>          default:
> --
> 2.48.1
>
>

