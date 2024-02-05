Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43756C4828F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 03:00:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWpDI-0000ie-6P; Sun, 04 Feb 2024 22:00:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rWpDC-0000hc-Nq; Sun, 04 Feb 2024 21:59:58 -0500
Received: from mail-ua1-x929.google.com ([2607:f8b0:4864:20::929])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rWpDB-0006rm-9y; Sun, 04 Feb 2024 21:59:58 -0500
Received: by mail-ua1-x929.google.com with SMTP id
 a1e0cc1a2514c-7d2e1a0337bso1987454241.3; 
 Sun, 04 Feb 2024 18:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707101995; x=1707706795; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KKHZ2rIkbB1ivSidWAS7YL5DYq1ZoyelphM4FK6W03s=;
 b=AHWbQtXde7d9JaO8GFvltizUQQzPJRg/xiXnvpenPWzUEN3tjP+PrLYJWhofj+Mdy5
 fh6CFmxwV67Uw0fbr38oenO/pD+EbxXGJx4W0tVLTiGQUX9jFaleSzetxnt2ZBBocGm8
 G1zh2ecsJppaSkxDaxes2B7kpUfVpYGn/LlTEVyum5Dd7a1e0ANMqRdW6HokW6D0Sd1V
 F9eOujkkal1izJ54SQLmmcqMz0M8hdAwSpE6iEfViFLFiVDnRB84CtiMS67izkVgxuds
 ow9M3POq+Ryadv/LHNqv6px738FJSASxQopzUEiIqnfbrRJEDqEPwFcZRLpyfWrWFVOb
 R0MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707101995; x=1707706795;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KKHZ2rIkbB1ivSidWAS7YL5DYq1ZoyelphM4FK6W03s=;
 b=qzd9kzqL4aLxKVOt7YiqR7h7Vm56zjqimrQJ//BoX4FQ/D1D5ZJhNfZG8bPVDr2Wqm
 UZbTNLU2WgAD1fM0HFler+lbxHDNRQMOqkH9zWnD45+tVhcUdZoxv6dopUFOc4ZDfKux
 7hyUJfxAKMUNpaWFMRobZpQjVNdHMW6Si/cOEOY3LU6Aori4kR0oD1b0Y2N2tgl0UJnS
 4+1pqCCKEiFE2GHfaZ65jw4p2UsHg6v8jGEX3r5pMjGgoSOMo7913apcHPPPAYeRjfta
 JMbnNXpKVMscPQO3StlETWlSXO9NdC9dI0UgDMwiSiFb5Ec1lvJ0bHN64Jmf81bU6rXz
 wxGQ==
X-Gm-Message-State: AOJu0Yy9jLQ3g3d9U7sY+v8j/N+XQTonVVPUM+7hMnJ0IcKGLquLRg2/
 5qj9IlJ9A0y8HVRRd3igEzF41aQKNjV+x1jZFi5o2lfOtuE9+09dPLRLEjZIwyIg/QDwa1jEFc2
 xjMVuNJumQHwB48FlmXENyXg+uZY60dfAlbw=
X-Google-Smtp-Source: AGHT+IEJr5H/EuQV9yunH7TKj/YUSTChtL//qJfLGkUiCbxK/jHXlfpq50xOUcmSav1kivrty00YV4kEo7hxNiRKKSg=
X-Received: by 2002:a67:f543:0:b0:46d:1b1a:a375 with SMTP id
 z3-20020a67f543000000b0046d1b1aa375mr2399987vsn.32.1707101995747; Sun, 04 Feb
 2024 18:59:55 -0800 (PST)
MIME-Version: 1.0
References: <20240122221529.86562-1-dbarboza@ventanamicro.com>
 <20240122221529.86562-5-dbarboza@ventanamicro.com>
In-Reply-To: <20240122221529.86562-5-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 5 Feb 2024 12:59:29 +1000
Message-ID: <CAKmqyKNvEwUuUgjoGV0_D5mFhCrXOhMpDDjXUe3_ji1ezNusUg@mail.gmail.com>
Subject: Re: [PATCH 4/7] hw/riscv/virt.c: use g_autofree in
 create_fdt_sockets()
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::929;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x929.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Jan 23, 2024 at 8:16=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Move 'clust_name' inside the loop, and g_autofree, to avoid having to
> g_free() manually in each loop iteration.
>
> 'intc_phandles' is also g_autofreed to avoid another manual g_free().
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/virt.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 373b1dd96b..d0f402e0d5 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -721,11 +721,11 @@ static void create_fdt_sockets(RISCVVirtState *s, c=
onst MemMapEntry *memmap,
>                                 uint32_t *irq_virtio_phandle,
>                                 uint32_t *msi_pcie_phandle)
>  {
> -    char *clust_name;
>      int socket, phandle_pos;
>      MachineState *ms =3D MACHINE(s);
>      uint32_t msi_m_phandle =3D 0, msi_s_phandle =3D 0;
> -    uint32_t *intc_phandles, xplic_phandles[MAX_NODES];
> +    uint32_t xplic_phandles[MAX_NODES];
> +    g_autofree uint32_t *intc_phandles =3D NULL;
>      int socket_count =3D riscv_socket_count(ms);
>
>      qemu_fdt_add_subnode(ms->fdt, "/cpus");
> @@ -739,6 +739,7 @@ static void create_fdt_sockets(RISCVVirtState *s, con=
st MemMapEntry *memmap,
>
>      phandle_pos =3D ms->smp.cpus;
>      for (socket =3D (socket_count - 1); socket >=3D 0; socket--) {
> +        g_autofree char *clust_name =3D NULL;
>          phandle_pos -=3D s->soc[socket].num_harts;
>
>          clust_name =3D g_strdup_printf("/cpus/cpu-map/cluster%d", socket=
);
> @@ -749,8 +750,6 @@ static void create_fdt_sockets(RISCVVirtState *s, con=
st MemMapEntry *memmap,
>
>          create_fdt_socket_memory(s, memmap, socket);
>
> -        g_free(clust_name);
> -
>          if (tcg_enabled()) {
>              if (s->have_aclint) {
>                  create_fdt_socket_aclint(s, memmap, socket,
> @@ -793,8 +792,6 @@ static void create_fdt_sockets(RISCVVirtState *s, con=
st MemMapEntry *memmap,
>          }
>      }
>
> -    g_free(intc_phandles);
> -
>      if (kvm_enabled() && virt_use_kvm_aia(s)) {
>          *irq_mmio_phandle =3D xplic_phandles[0];
>          *irq_virtio_phandle =3D xplic_phandles[0];
> --
> 2.43.0
>
>

