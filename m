Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99B49CD98F6
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 05:00:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbWlx-0004sa-J7; Mon, 22 Jun 2026 01:00:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wbWlv-0004sJ-Uf
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 01:00:35 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wbWlu-0008Np-DP
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 01:00:35 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-bed2195323cso602257466b.1
 for <qemu-devel@nongnu.org>; Sun, 21 Jun 2026 22:00:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782104433; cv=none;
 d=google.com; s=arc-20240605;
 b=cdHcvrS9kRsD6uaV9f6KKnjXOtqaE6k28cAdIjO8lemdhCK45kf2a2wDuLvWrrSOzJ
 BYsDd/lRx3EGZTu2gZ1ocLWwHPBdfubXQ6Lr0VLU/YxEVaj+nCCQ3L0hIRCzop/6JxQJ
 NbgybNzpcY6SUrdjyUWbqmK0qkpJ6YPwLicPep+/CQZrayxFa+10V6bAsEdRaur9Dl+d
 jkDUoDK2x2XyiBz5VgTCZs6soT8frf0wQKoQ9Ru2o+6i3T52dE8Q4CLyIstIHEK6EPKm
 f5nvdXAP1r0aajotfpFXfRL5AnK7wdx8VO9WAsZ5ncLiVSCA88aVyODYciz6FYov2m/J
 pxfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=BhqkaOqXBinUIqi3QUMQOFwpWUMds6go2D7ktKXVaqc=;
 fh=y/39rxWsHsSIhiCgFyox46bvYsAfNaBS3wRFv9pkMrs=;
 b=QIVUbd4edsrJxWze6YllT/ydY2pLZUpiqy3Rmi+2sGIlTDxEq11AXFRJxQcmKqD5Fb
 lxIdkOVUSIToko2QAAxNgCIxda1+mPecTnwM2Behm+01pasah02w54DKLCweo8LVDRgX
 +gsYEKrl1zqGdTjDI0oZdnafWR9T/WSKFGpVp/MqFmqKsRZFHjErH3gzAeKCqi1iN5ZU
 tC6poLpAibyTtq2KIoq0pnARsnN3rrop/BsU3cRKpzelf9kF7gWsQLGqZtSuRHv6ww++
 OmBZGlKJt409sjCfBVuvix9mleoa/t1wunHgSsV00+jQeNeaLtPGKJDJnebOFxomn8Zz
 cFCA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782104433; x=1782709233; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BhqkaOqXBinUIqi3QUMQOFwpWUMds6go2D7ktKXVaqc=;
 b=l6wylg8CrwA3jUZEWvoAjziGT4+B1lYuEISfz1O5yxw5anXEi23GyZtR8Q1BWYctD/
 BUXFkMpYmFFWoMkKjVExFoo1IOOpzCiMsZJ9toxccL7DWIlC11Dzt2oRSsCTr1xDRuQm
 o9hkCrMR9s6JWGRxbdUfrNVdIBz0sw4B+wJLWc4Oxyom/5dxx+/stBzPLl/TxJgA0S/I
 iWs+LceN+skTbLefxYs8RD53l7dr2ZXoFqwzaBB8VmWwGWKCJavNbHnZnxiB+Gih8jLj
 9BJB9Lt0LVUJXXzl5OKSc//39psHFe8+FthgvqnBe9HqPrwYifurDhvOSizg96QxLQ+n
 377Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782104433; x=1782709233;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BhqkaOqXBinUIqi3QUMQOFwpWUMds6go2D7ktKXVaqc=;
 b=B9VnCXkWOGDEKeEJRouJQH5o+WekA/RItfrHOJdyw0GZdk4MGKYLA+sQj64qlQhCkK
 CJkI7oEPiiyeZ7RxXwb/EOGD+MXZ8FfyW5uuXS30thxFNBZpesOOKnn7/SvPcMXNdAET
 TrJ5G8b/yCNRdCwd4Ckoxqh6l/uMXUA+YRBeWWJZWuVFSieKwN9dUP6QfeD5USnPwmuK
 4LOFK6pPEohswxzEi92NrX1y/Uk1pWm9VkP0bssKSPZPbzvpYpMB0aJhWI9Ap44AFhHg
 kEjh5rLnLLWiIyR1SPtWef6RSa8sFdHgqPoE/+KIs57uOTYjWJHV7dIyIP8zrVtbrdeZ
 2c6Q==
X-Gm-Message-State: AOJu0YyorSLRTHkBlfDUB+c/zj0HYhXSwtIQDxF5BBSra0lOxUx34zdo
 nBk1olh/W2WycxZKM8Zrt3W/vMtZUwWV+TKJDgByKhHCbJviBUgKGF1qCQnpD9khXIs3EeRH7k0
 LO2PzNBdMXhyCPBDPSeXasjk0khfPjoY=
X-Gm-Gg: AfdE7clHO81AeoeM0z8u/CaGAL8ytJ9f4ykXr/RcfSXDKGu48r+xaYuFmbh1H2NqbFF
 tLw+R5R0kLhQl8FSXw1sJvqYxpWqOKA4AvbC26XGOhRkv22XxWLdZFM0tkqqEpS4JwP874twT67
 Vvn6JCjKxAWjrwp7DZ1uBeRgYkoMgZw6P1FHtZ5TrKfAWW6D8yAVllLxYXn38zH1N7FfBb5bAqs
 UgYEkOEF4uRWY0to/gqgMIcqJKWwK1LbSbNr6Dvn//cEpHTXdjI3XtUclR+ZArmd3KGJ6fqpyLR
 /bYYHCf+wkpkbK2mj9Jw3k/VlHw=
X-Received: by 2002:a17:907:7b8a:b0:bef:87ca:aec5 with SMTP id
 a640c23a62f3a-c0b75785b9dmr643252166b.47.1782104429338; Sun, 21 Jun 2026
 22:00:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260616235939.1358663-1-daniel.barboza@oss.qualcomm.com>
 <20260616235939.1358663-5-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260616235939.1358663-5-daniel.barboza@oss.qualcomm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 22 Jun 2026 15:00:02 +1000
X-Gm-Features: AVVi8CfR7fOc4rHUydlOD2g0D_97RleexCXhz_lQ1BOeAjHsrLhenUrHK5zjztI
Message-ID: <CAKmqyKM-J2VTRqm0s9LqtsePvU-U0Y0FPoaJovF=YS2d04XkXQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] hw/riscv/virt.c: change 'plic' nodename to
 'interrupt-controller'
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com, 
 Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x633.google.com
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

On Wed, Jun 17, 2026 at 10:01=E2=80=AFAM Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
> We're still using "/soc/plic@..." as FDT nodename in virt.c.  This is
> not the right nodename per the DT docs:
>
> https://www.kernel.org/doc/Documentation/devicetree/bindings/interrupt-co=
ntroller/sifive%2Cplic-1.0.0.txt
>
> The nodename must be 'interrupt-controller@...' since the node inherits
> the 'interrupt-controller' type.  In fact, ever since at least the 2020
> Linux kernel commit c825a081c169cc7f ("dt-bindings: riscv: convert plic
> bindings to json-schema") the correct nodename has been
> 'interrupt-controller' for the sifive PLIC controller.
>
> There's no deprecation needed for bug fixes so we're just fixing the
> name.  This was the policy we dud when fixing the aplic [1] and the
> imsic [2] nodenames to 'interrupt-controller@...' as well.
>
> The sifive_u PLIC FDT already uses the correct nodename for PLIC, so it
> is safe to assume that available SW is already aware of the correct
> nodename and this change won't affect well-behaved SW.
>
> [1] commit 29390fd ("hw/riscv/virt.c: rename aplic nodename to 'interrupt=
-controller'")
> [2] commit e8ad581 ("hw/riscv/virt.c: change imsic nodename to 'interrupt=
-controller'")
>
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/virt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 33775a61fd..fa464e644f 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -335,7 +335,7 @@ static void create_fdt_socket_plic(RISCVVirtState *s,
>      plic_phandles[socket] =3D (*phandle)++;
>      plic_addr =3D s->memmap[VIRT_PLIC].base +
>                  (s->memmap[VIRT_PLIC].size * socket);
> -    plic_name =3D g_strdup_printf("/soc/plic@%lx", plic_addr);
> +    plic_name =3D g_strdup_printf("/soc/interrupt-controller@%lx", plic_=
addr);
>      qemu_fdt_add_subnode(ms->fdt, plic_name);
>      qemu_fdt_setprop_cell(ms->fdt, plic_name,
>          "#interrupt-cells", FDT_PLIC_INT_CELLS);
> --
> 2.43.0
>
>

