Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B485CC3ABBE
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 17:22:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBzVq-0002a8-Pi; Mon, 05 May 2025 13:21:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcasquer@redhat.com>)
 id 1uBzVm-0002Yz-6z
 for qemu-devel@nongnu.org; Mon, 05 May 2025 13:21:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcasquer@redhat.com>)
 id 1uBzVj-0005uf-Q1
 for qemu-devel@nongnu.org; Mon, 05 May 2025 13:21:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746465705;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xjbCV6OHIp87ekAtC8x7PjsCwMBMv35Ov5BZrizMNEE=;
 b=bN8MJH2Wc/hYYb24e2RSbTCD93f04GLsdcZmmCJX0q3esVQXTjPcXTNu+C/5hHTbi0uZHU
 WIapfcIKadK/5B20PYvUwYguVZL1hJ7mPdMnm2WP6c+tE8RDNUXwhgyuSyUBDWBDyeUNej
 nzL/VZeiNHCcCO8oRRu4fH9ooGr9Hpc=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-170-7Wz8hSybP7i4yIGaSNimJQ-1; Mon, 05 May 2025 13:20:36 -0400
X-MC-Unique: 7Wz8hSybP7i4yIGaSNimJQ-1
X-Mimecast-MFC-AGG-ID: 7Wz8hSybP7i4yIGaSNimJQ_1746465635
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-30d6a0309f6so30838451fa.2
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 10:20:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746465635; x=1747070435;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xjbCV6OHIp87ekAtC8x7PjsCwMBMv35Ov5BZrizMNEE=;
 b=THYgYtceVvK7b06/bFEWadZbGmYCg9r4wTE1MxYx8IRQv4O5s7Z5VqIXSqqlAuphf5
 Ro4h7etwhqPR0jvqZuBrjDQDR2oHLJxAF6IFlpvTrhK3hJm+wVbi3rLSXJQqfDMFA2rH
 YIM/o0OOf0OfKTF5JmEjZsGz2BStqBZMjVdeYF19FXu1T69fNkiSfVq4DWeYpxV/NeAW
 5grdu4CT9fh+XetwjPQUxMUoMkzIAMGHqep78vEUFwSE+nNqdj/6GQT2LTgTaLFp0mBH
 HonpqjSMPyvjBXcajz2NFtxNM5vZME/njFFkTxpfyd55/xdLaR461IunqyiZ4U4bF59g
 cZ1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmdSX3TDi0miRmfV5+RTucJnCNe0byJRvuvt6ZUVP3SOPLMtEtyxZ1MW1bTqchzJiH+nbKhRrsf6pj@nongnu.org
X-Gm-Message-State: AOJu0YyvMTwurgW5TltJKqB2gJoEgw2D11RZDwntsTnYT2kOh4mg0/Fi
 WxVj4M0UVInHa8DCMhVd7yXSVHs2XGL0t4Ys62fW9OarFosiWb/X8M8g1rhACpoTNgkflsAC9ry
 zdBBSycRnkPiIl7moq5n/GWOMSZBLZVWVmL/SaWdEHiWk+mycmxRNX/jt84BRv7AER8m7WrWVaA
 qYtoeFkZuNnPhlxnpo/uZ8vbEhd/w=
X-Gm-Gg: ASbGncswspCu8cDkl1NMiR7hNAAOlNmWVXJ52mvoP16YR5qfoXu07bQr/uW26bmuFdo
 zoKQp4LHkVt4nsRNsC5NljHB35SEXG+AbzmuFJ4eQdz1EPN/eYEtmO1VP75BtQ6m5j2+b
X-Received: by 2002:a2e:ab08:0:b0:30b:ed5a:6f3c with SMTP id
 38308e7fff4ca-3264f00f23emr490171fa.10.1746465634839; 
 Mon, 05 May 2025 10:20:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkAjhiLTdxP6TFSve9PlqNaMwgPNCKMTPSoW3yMdvPw0hASQWes/uXCZWLH6t8gz02Db7Mt7hvHvPIu38FzPw=
X-Received: by 2002:a2e:ab08:0:b0:30b:ed5a:6f3c with SMTP id
 38308e7fff4ca-3264f00f23emr490071fa.10.1746465634424; Mon, 05 May 2025
 10:20:34 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1746003314.git.lc00631@tecorigin.com>
 <6b3567672da9d5778c18a32ee1306aaed884463c.1746003314.git.lc00631@tecorigin.com>
In-Reply-To: <6b3567672da9d5778c18a32ee1306aaed884463c.1746003314.git.lc00631@tecorigin.com>
From: Mario Casquero <mcasquer@redhat.com>
Date: Mon, 5 May 2025 19:20:23 +0200
X-Gm-Features: ATxdqUH4OUFkZ2fjw8EBApayyr4CobYA7YhqW8RLyRDls4PGgAQ1PZaZ4eSW8lM
Message-ID: <CAMXpfWuaYz0CX3UH4A6Daxxx_0=9R6mqh-C_Fw3T8WEs+KEi8w@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] system: optimizing info mtree printing for monitors
To: Chao Liu <lc00631@tecorigin.com>
Cc: pbonzini@redhat.com, peterx@redhat.com, david@redhat.com, 
 philmd@linaro.org, zhangtj@tecorigin.com, zqz00548@tecorigin.com, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mcasquer@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This patch has been successfully tested. Differences are clear,
without the patch:

/usr/libexec/qemu-kvm -m 4G -monitor stdio
(qemu) info mtree
...
memory-region: system
  0000000000000000-ffffffffffffffff (prio 0, i/o): system
    0000000000000000-00000000bfffffff (prio 0, ram): alias
ram-below-4g @pc.ram 0000000000000000-00000000bfffffff
    0000000000000000-ffffffffffffffff (prio -1, i/o): pci
...
After applying the patch

./qemu/build/qemu-system-x86_64 -m 4G -monitor stdio
(qemu) info mtree
...
memory-region: system
=E2=94=82  =E2=94=9C=E2=94=80=E2=94=80 0000000000000000-ffffffffffffffff (p=
rio 0, i/o): system
=E2=94=82  =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 0000000000000000-0000000=
0bfffffff (prio 0, ram): alias
ram-below-4g @pc.ram 0000000000000000-00000000bfffffff
=E2=94=82  =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 0000000000000000-fffffff=
fffffffff (prio -1, i/o): pci
...

Tested-by: Mario Casquero <mcasquer@redhat.com>


On Wed, Apr 30, 2025 at 11:08=E2=80=AFAM Chao Liu <lc00631@tecorigin.com> w=
rote:
>
> Make the hierarchical relationship between nodes clearer by adding charac=
ters
>
> e.g.
>
> qemu-system-riscv64 -M virt -monitor stdio -display none
>
> ```
> (qemu) info mtree
> ...
> memory-region: system
> =E2=94=82  =E2=94=9C=E2=94=80=E2=94=80 0000000000000000-ffffffffffffffff =
(prio 0, i/o): system
> =E2=94=82  =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 0000000003000000-00000=
0000300ffff (prio 0, i/o): gpex_ioport_window
> =E2=94=82  =E2=94=82   =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 0000000003=
000000-000000000300ffff (prio 0, i/o): gpex_ioport
> ...
> =E2=94=82  =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 0000000400000000-00000=
007ffffffff (prio 0, i/o): alias ...
> ```
>
> Signed-off-by: Chao Liu <lc00631@tecorigin.com>
> Reviewed-by: Qingze Zhao <zqz00548@tecorigin.com>
> Reviewed-by: Tingjian Zhang <zhangtj@tecorigin.com>
> ---
>  system/memory.c | 36 ++++++++++++++++++++++++++++++------
>  1 file changed, 30 insertions(+), 6 deletions(-)
>
> diff --git a/system/memory.c b/system/memory.c
> index 71434e7ad0..cf91718bcc 100644
> --- a/system/memory.c
> +++ b/system/memory.c
> @@ -3296,6 +3296,21 @@ typedef QTAILQ_HEAD(, MemoryRegionList) MemoryRegi=
onListHead;
>                             int128_sub((size), int128_one())) : 0)
>  #define MTREE_INDENT "  "
>
> +enum mtree_node_type {
> +    MTREE_NODE_T_INNER,
> +    MTREE_NODE_T_TAIL,
> +};
> +
> +static void mtree_print_node(enum mtree_node_type is_tail)
> +{
> +    qemu_printf((is_tail =3D=3D MTREE_NODE_T_TAIL) ? "=E2=94=94=E2=94=80=
=E2=94=80 " : "=E2=94=9C=E2=94=80=E2=94=80 ");
> +}
> +
> +static void mtree_print_col(unsigned level)
> +{
> +    qemu_printf(level ? "=E2=94=82   " : "=E2=94=82  ");
> +}
> +
>  static void mtree_expand_owner(const char *label, Object *obj)
>  {
>      DeviceState *dev =3D (DeviceState *) object_dynamic_cast(obj, TYPE_D=
EVICE);
> @@ -3335,7 +3350,8 @@ static void mtree_print_mr_owner(const MemoryRegion=
 *mr)
>  static void mtree_print_mr(const MemoryRegion *mr, unsigned int level,
>                             hwaddr base,
>                             MemoryRegionListHead *alias_print_queue,
> -                           bool owner, bool display_disabled)
> +                           bool owner, bool display_disabled,
> +                           enum mtree_node_type node_type)
>  {
>      MemoryRegionList *new_ml, *ml, *next_ml;
>      MemoryRegionListHead submr_print_queue;
> @@ -3376,8 +3392,9 @@ static void mtree_print_mr(const MemoryRegion *mr, =
unsigned int level,
>          }
>          if (mr->enabled || display_disabled) {
>              for (i =3D 0; i < level; i++) {
> -                qemu_printf(MTREE_INDENT);
> +                mtree_print_col(i);
>              }
> +            mtree_print_node(node_type);
>              qemu_printf(HWADDR_FMT_plx "-" HWADDR_FMT_plx
>                          " (prio %d, %s%s): alias %s @%s " HWADDR_FMT_plx
>                          "-" HWADDR_FMT_plx "%s",
> @@ -3398,8 +3415,9 @@ static void mtree_print_mr(const MemoryRegion *mr, =
unsigned int level,
>      } else {
>          if (mr->enabled || display_disabled) {
>              for (i =3D 0; i < level; i++) {
> -                qemu_printf(MTREE_INDENT);
> +                mtree_print_col(i);
>              }
> +            mtree_print_node(node_type);
>              qemu_printf(HWADDR_FMT_plx "-" HWADDR_FMT_plx
>                          " (prio %d, %s%s): %s%s",
>                          cur_start, cur_end,
> @@ -3435,8 +3453,12 @@ static void mtree_print_mr(const MemoryRegion *mr,=
 unsigned int level,
>      }
>
>      QTAILQ_FOREACH(ml, &submr_print_queue, mrqueue) {
> +        if (ml =3D=3D QTAILQ_LAST(&submr_print_queue)) {
> +            node_type =3D MTREE_NODE_T_TAIL;
> +        }
>          mtree_print_mr(ml->mr, level + 1, cur_start,
> -                       alias_print_queue, owner, display_disabled);
> +                       alias_print_queue, owner,
> +                       display_disabled, node_type);
>      }
>
>      QTAILQ_FOREACH_SAFE(ml, &submr_print_queue, mrqueue, next_ml) {
> @@ -3614,7 +3636,8 @@ static void mtree_print_as(gpointer key, gpointer v=
alue, gpointer user_data)
>      struct AddressSpaceInfo *asi =3D user_data;
>
>      g_slist_foreach(as_same_root_mr_list, mtree_print_as_name, NULL);
> -    mtree_print_mr(mr, 1, 0, asi->ml_head, asi->owner, asi->disabled);
> +    mtree_print_mr(mr, 1, 0, asi->ml_head, asi->owner, asi->disabled,
> +                   MTREE_NODE_T_INNER);
>      qemu_printf("\n");
>  }
>
> @@ -3659,7 +3682,8 @@ static void mtree_info_as(bool dispatch_tree, bool =
owner, bool disabled)
>      /* print aliased regions */
>      QTAILQ_FOREACH(ml, &ml_head, mrqueue) {
>          qemu_printf("memory-region: %s\n", memory_region_name(ml->mr));
> -        mtree_print_mr(ml->mr, 1, 0, &ml_head, owner, disabled);
> +        mtree_print_mr(ml->mr, 1, 0, &ml_head, owner, disabled,
> +                       MTREE_NODE_T_INNER);
>          qemu_printf("\n");
>      }
>
> --
> 2.48.1
>
>


