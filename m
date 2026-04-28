Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 305E8FF8867
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 02:45:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHYRb-0005zs-7O; Mon, 27 Apr 2026 22:45:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHYRZ-0005yj-4O
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 22:45:01 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHYRX-000643-KY
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 22:45:00 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-676d8582a13so12353187a12.0
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 19:44:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777344298; cv=none;
 d=google.com; s=arc-20240605;
 b=FoCkjJcNLATA0erA9gYl7+EboW7K4MvompkCRUZOL0z+0Vcu2zsEMvz6dFX+Isb8+P
 XqaWEyuLWyoJVUaF8EtcMgeMX2syy3kLwSsnOSHJ5Pt42L6TSrplKeBBBpK4KdxzOYEM
 WdcaPOdcS3nTRnr03R4xYuypx/bxvJg2buTJssK2zaX3yuLg9HSlhTKhwSl1ijspz9mR
 HB/DiY1upHTVgEF23wjZG0cPpToYGaPbwm9b4NGgILCBcyNFABE1NjGKf0EbHTJXFJRq
 xItSwgV6TpfLdS4ZQDvTBZ5hXQrWqV1dMmhyvJlB1ZztvykLyR+cubEDdFHOWPjwoujk
 NsFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ozSwEU3Jc/oEuesdC9JExzdfEwYAdOyJFvm9c0u/qpQ=;
 fh=Awic0G2EMj0AD75JUNDifFbec8MmVHu7qb8WQ6Vww7g=;
 b=ZNF2DCVs+5QAd5EtA7GARqqur4iZoocqwrV3BDYxbzdMqlVnMzfB0pixDtYpSr+0Dx
 Vy7mE92oD9ptGq6WwhBcyf+Onjlw0QtxHgo3CDAO63GfOX/+PVh9oRR4r4pxu3ATHuE3
 Yz3WPBKQSSZgMK4MxEK9cd2GM/v5HxtYBYp3HhpFwGLZAzHXxw8T7zmS0MQSRvpZVLxR
 y/oTfKGH1+c9FZET3UK+RVIQZKIgZnAUd1yl9S4K4T5cUxNh+/RAwD+EtBuCDkuoE6RD
 eH43ujzUfjUrjtiw1iUlQzWfQTxKy4AO9PLLXWCBPEcANgX19/vcr0pLqQ/sycz6oHmO
 41aw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777344298; x=1777949098; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ozSwEU3Jc/oEuesdC9JExzdfEwYAdOyJFvm9c0u/qpQ=;
 b=rmZUrxzk92+TgQnkyZ54ssnYQS4QXK+80g83fulXcpWXEr5y9SzZqBhmavQNZsjV/a
 fG1ABDAY1u6Tv+ucXTaxyc8/idpO4W1JZv7wYF1dx/ua2eyOTgzoEaiVPXLef3Or8RRE
 hvF2np9aOWZ+Ab9SIvat6m2pcIeGIjYsxo7gyc8WHR7XQHoDV9wQ6D/HAmhbnOnc8Ea+
 vS4TO4FPVE4bNh7Lii1xalFbYByunWMOwRrOqySzvK2ZGfWL8I/KqBLprVx4njOzc1xo
 nYVVojrvm7/IJ99M7SVFyDfjbuYgwYXgaD7W8vHAnb2gP1MuMf2W7eKcbMVFOiGh2Pbp
 uV9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777344298; x=1777949098;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ozSwEU3Jc/oEuesdC9JExzdfEwYAdOyJFvm9c0u/qpQ=;
 b=FzXthRvq4gOWx7GvmjrwpyVefgWaufsNQLyMZuIL8GUNUwoF2WViKo0LZFbVgS8TJN
 imJO0hurRO8/wzoA0eVecBPBctO2FupS4cTuJVqX7yWSd2brO/sc12IYLhgyFEh8WloB
 OBVmQjLz6qSE0qgT1upkWH1NCsaBIQ7T7cwg/X3N9Om7CisryI5CgADXHNc2vHLGVu8d
 90k6HzsFcQ4uHyiFwyXNiJdcY8gIC26tR1kUlH60ilDyfN+5VGN46BiAKgHTOR9xXO1d
 xLtTp5c+Z/KhMTbfNNc2ud2KoGgm8U1T1qyN7nt2WBzA3Sy6zGrR9EnEwjkFym/zIKgX
 IYmA==
X-Gm-Message-State: AOJu0YxIxUkRmx2q935VC3nz4YuJuyew4XHOPRmOq0oBSdfANVMaV4DG
 rkA0D5Sg446pm0YT8vpfutTXaRVPtQYLafQn1A7/KvvG+RULtpNkZzamluhhOOZFrnCsz1fyfH/
 FX9hiamMfHY1cQC/ficbgB5YEdICXMrY=
X-Gm-Gg: AeBDiev6fV8/l+Dr+66mFeiplHTqxjTR0P/4WCwK+3bVt2/gtCAWc9jUQistxqitkbr
 RDyu9Ji3ZA/cNIfY/Ehfz6u9CRW1Vnul9PjZCGUlWEcC48r9N4V7s64xgyDNwQmpwoOckaD7Poq
 r/pYEDW2SQRf4wZ4+Csgqwj+Q3I/nTINZe+hwpOdbBq+oTMuTyzf3dMM1/cs2KhiTg4YurXSTQl
 Pvq8uQoX/vt1sUI2XGZnvOgLhvd8bZkL6E3xmAp0ZElz4NVEEz9EUzgqyZUzwU89R32BBTbhyZi
 rEAwHjDywChEPH5ys9QFMqgLVHmGRfJi+Po1k9BEUx/sb2Ms
X-Received: by 2002:a17:907:7b85:b0:bab:b98e:76e2 with SMTP id
 a640c23a62f3a-bb8022c2cd7mr64387366b.1.1777344297584; Mon, 27 Apr 2026
 19:44:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260421093715.2995067-1-frank.chang@sifive.com>
 <20260421093715.2995067-2-frank.chang@sifive.com>
In-Reply-To: <20260421093715.2995067-2-frank.chang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 28 Apr 2026 12:44:30 +1000
X-Gm-Features: AVHnY4J2y5FDSSUBv2R3bVvf9h0hLDI8-c_auf3sQ0ugSfzh7kfh7EQUfUnqu90
Message-ID: <CAKmqyKPFyoRW=sw99rCsQSEY9Ycc75+yW=e51cVLu+Z_ps0nWw@mail.gmail.com>
Subject: Re: [PATCH v4 1/6] target/riscv: fix address masking
To: frank.chang@sifive.com
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, 
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>,
 Yong-Xuan Wang <yongxuan.wang@sifive.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x531.google.com
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

On Tue, Apr 21, 2026 at 7:38=E2=80=AFPM <frank.chang@sifive.com> wrote:
>
> From: Yong-Xuan Wang <yongxuan.wang@sifive.com>
>
> The pmlen should get the corresponding value before shifting address.
>
> Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/internals.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/riscv/internals.h b/target/riscv/internals.h
> index b001cbc080a..43b77d30f27 100644
> --- a/target/riscv/internals.h
> +++ b/target/riscv/internals.h
> @@ -216,8 +216,8 @@ static inline target_ulong adjust_addr_body(CPURISCVS=
tate *env,
>      if (!is_virt_addr) {
>          signext =3D riscv_cpu_virt_mem_enabled(env);
>      }
> -    addr =3D addr << pmlen;
>      pmlen =3D riscv_pm_get_pmlen(pmm);
> +    addr =3D addr << pmlen;
>
>      /* sign/zero extend masked address by N-1 bit */
>      if (signext) {
> --
> 2.43.0
>
>

