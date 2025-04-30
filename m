Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1969EC369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 14:05:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uA837-000350-Se; Wed, 30 Apr 2025 10:04:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uA82m-00033v-9h
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 10:04:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uA82i-0003qh-VK
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 10:04:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746021845;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BOWeOQqE40KqZmK+yPmGeXYGgMjO+qJ19Deai/IsOYo=;
 b=H3NRXxDFw6ACBqVFryncUQvNEC+dC+FdlMNkEDpo98zu5kYqJS8IsDDST5+XfGffyZutkQ
 erCHMJaa4/qHhbmwak65sXPdSWUFt6i28hUGcQQCJsPDrHG/MigSb5vraNo7Km4nSiKoxU
 0Xre/OAV15Y9DyIeV8TBqpOFO7iXn60=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-459-2JjkhWCrNkWFLo0ur49Rrg-1; Wed,
 30 Apr 2025 10:04:01 -0400
X-MC-Unique: 2JjkhWCrNkWFLo0ur49Rrg-1
X-Mimecast-MFC-AGG-ID: 2JjkhWCrNkWFLo0ur49Rrg_1746021840
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 10BD81956094; Wed, 30 Apr 2025 14:04:00 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.27])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E6A321800570; Wed, 30 Apr 2025 14:03:58 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8990221E6768; Wed, 30 Apr 2025 16:03:56 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Chao Liu <lc00631@tecorigin.com>
Cc: pbonzini@redhat.com,  peterx@redhat.com,  david@redhat.com,
 philmd@linaro.org,  zhangtj@tecorigin.com,  zqz00548@tecorigin.com,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v2 1/1] system: optimizing info mtree printing for monitors
In-Reply-To: <501e578a4ef28515ccdefcbc82defc04363855ca.1746001489.git.lc00631@tecorigin.com>
 (Chao Liu's message of "Wed, 30 Apr 2025 16:31:47 +0800")
References: <cover.1746001489.git.lc00631@tecorigin.com>
 <501e578a4ef28515ccdefcbc82defc04363855ca.1746001489.git.lc00631@tecorigin.com>
Date: Wed, 30 Apr 2025 16:03:56 +0200
Message-ID: <874iy5d9v7.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.483,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Chao Liu <lc00631@tecorigin.com> writes:

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

info qtree and info qom-tree could perhaps use similar treatment.

> Signed-off-by: Chao Liu <lc00631@tecorigin.com>
> Reviewed-by: Qingze Zhao <zqz00548@tecorigin.com>
> Reviewed-by: Tingjian Zhang <zhangtj@tecorigin.com>
> ---
>  system/memory.c | 42 ++++++++++++++++++++++++++++++++++++------
>  1 file changed, 36 insertions(+), 6 deletions(-)
>
> diff --git a/system/memory.c b/system/memory.c
> index 71434e7ad0..3a7faeb533 100644
> --- a/system/memory.c
> +++ b/system/memory.c
> @@ -3296,6 +3296,27 @@ typedef QTAILQ_HEAD(, MemoryRegionList) MemoryRegi=
onListHead;
>                             int128_sub((size), int128_one())) : 0)
>  #define MTREE_INDENT "  "
>=20=20
> +enum mtree_node_type {
> +    MTREE_NODE_T_INNER,
> +    MTREE_NODE_T_TAIL,
> +};
> +
> +#define PRINT_MTREE_NODE(node_type) do {  \
> +    if (node_type =3D=3D MTREE_NODE_T_TAIL) { \
> +        qemu_printf("=E2=94=94=E2=94=80=E2=94=80 ");              \
> +    } else {                              \
> +        qemu_printf("=E2=94=9C=E2=94=80=E2=94=80 ");              \
> +    }                                     \
> +} while (0)
> +
> +#define PRINT_MTREE_COL(level) do { \
> +    if (level =3D=3D 0) {               \
> +        qemu_printf("=E2=94=82  ");         \
> +    } else {                        \
> +        qemu_printf("=E2=94=82   ");        \
> +    }                               \
> +} while (0)

Printing non-ASCII Unicode characters encoded in UTF-8 assumes the
monitor / stdout uses UTF-8.  Are we happy with such an assumption?

For what it's worth, such characters are exceedingly rare in C strings
so far.  I found:

    contrib/plugins/lockstep.c:        g_string_printf(out, "=CE=94 too hig=
h, we have diverged, previous insns\n");

Intentional.  This is a "plugin for debugging TCG changes" (commit
c81950a2f19).

    hw/uefi/var-service-policy.c:    fprintf(stderr, "    name =C2=B4");

This looks like a typo to me.

    tests/tcg/plugins/insn.c:                               " =CE=94+%"PRId=
64 " since last match,"

Intentional.  Seems to be a plugin used for testing.

    ui/sdl2.c:            status =3D " - Press =E2=8C=83=E2=8C=A5=E2=87=A7G=
 to exit grab";
    ui/sdl2.c:            status =3D " - Press =E2=8C=83=E2=8C=A5G to exit =
grab";

These are #ifndef CONFIG_DARWIN.

None found in QEMU proper.

The common ASCII equivalent to

    =E2=94=82
    =E2=94=9C=E2=94=80=E2=94=80

is

    |
    +--

Not as pretty, but quite readable.

[...]


