Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F861C369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 11:33:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uA5gq-0001Q2-1k; Wed, 30 Apr 2025 07:33:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uA5gj-0001PU-9R
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 07:33:18 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uA5gg-0002ec-KH
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 07:33:16 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 9863855D247;
 Wed, 30 Apr 2025 13:33:11 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id FkE2cuLFI3Fo; Wed, 30 Apr 2025 13:33:09 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 85E0455D245; Wed, 30 Apr 2025 13:33:09 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 83C29745682;
 Wed, 30 Apr 2025 13:33:09 +0200 (CEST)
Date: Wed, 30 Apr 2025 13:33:09 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Chao Liu <lc00631@tecorigin.com>
cc: pbonzini@redhat.com, peterx@redhat.com, david@redhat.com, 
 philmd@linaro.org, zhangtj@tecorigin.com, zqz00548@tecorigin.com, 
 qemu-devel@nongnu.org
Subject: Re: [PATCH v2 1/1] system: optimizing info mtree printing for monitors
In-Reply-To: <501e578a4ef28515ccdefcbc82defc04363855ca.1746001489.git.lc00631@tecorigin.com>
Message-ID: <7ec1e581-3919-fdf5-499a-279cba99d43d@eik.bme.hu>
References: <cover.1746001489.git.lc00631@tecorigin.com>
 <501e578a4ef28515ccdefcbc82defc04363855ca.1746001489.git.lc00631@tecorigin.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 BOUNDARY="3866299591-686446110-1746012694=:25048"
Content-ID: <527844fc-2175-2283-40e5-63e7b8ff2d5c@eik.bme.hu>
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: 6
X-Spam_score: 0.6
X-Spam_bar: /
X-Spam_report: (0.6 / 5.0 requ) BAYES_00=-1.9, MIME_CHARSET_FARAWAY=2.45,
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-686446110-1746012694=:25048
Content-Type: text/plain; CHARSET=KOI8-R; format=flowed
Content-Transfer-Encoding: 8BIT
Content-ID: <19525fa1-0606-730a-2452-95eae2037834@eik.bme.hu>



On Wed, 30 Apr 2025, Chao Liu wrote:

> Make the hierarchical relationship between nodes clearer by adding characters
>
> e.g.
>
> qemu-system-riscv64 -M virt -monitor stdio -display none
>
> ```
> (qemu) info mtree
> ...
> memory-region: system
>   †€€ 0000000000000000-ffffffffffffffff (prio 0, i/o): system
>      †€€ 0000000003000000-000000000300ffff (prio 0, i/o): gpex_ioport_window
>         „€€ 0000000003000000-000000000300ffff (prio 0, i/o): gpex_ioport
> ...
>      „€€ 0000000400000000-00000007ffffffff (prio 0, i/o): alias ...
> ```
>
> Signed-off-by: Chao Liu <lc00631@tecorigin.com>
> Reviewed-by: Qingze Zhao <zqz00548@tecorigin.com>
> Reviewed-by: Tingjian Zhang <zhangtj@tecorigin.com>
> ---
> system/memory.c | 42 ++++++++++++++++++++++++++++++++++++------
> 1 file changed, 36 insertions(+), 6 deletions(-)
>
> diff --git a/system/memory.c b/system/memory.c
> index 71434e7ad0..3a7faeb533 100644
> --- a/system/memory.c
> +++ b/system/memory.c
> @@ -3296,6 +3296,27 @@ typedef QTAILQ_HEAD(, MemoryRegionList) MemoryRegionListHead;
>                            int128_sub((size), int128_one())) : 0)
> #define MTREE_INDENT "  "
>
> +enum mtree_node_type {
> +    MTREE_NODE_T_INNER,
> +    MTREE_NODE_T_TAIL,
> +};
> +
> +#define PRINT_MTREE_NODE(node_type) do {  \
> +    if (node_type == MTREE_NODE_T_TAIL) { \
> +        qemu_printf("„€€  );              \
> +    } else {                              \
> +        qemu_printf("†€€ ");              \

Could you remove one € to make the output less wide? Some memory region 
names can be long and with 64bit addresses it easily overflows the line 
length of narrower terminals which makes the output wrap and become less 
readable. Shorter lines there still shows the tree but takes up less 
horizontal space so I think shorter line here would be enough.

Regards,
BALATON Zoltan

> +    }                                     \
> +} while (0)
> +
> +#define PRINT_MTREE_COL(level) do { \
> +    if (level == 0) {               \
> +        qemu_printf("  ");         \
> +    } else {                        \
> +        qemu_printf("   ");        \
> +    }                               \
> +} while (0)
> +
> static void mtree_expand_owner(const char *label, Object *obj)
> {
>     DeviceState *dev = (DeviceState *) object_dynamic_cast(obj, TYPE_DEVICE);
> @@ -3335,7 +3356,8 @@ static void mtree_print_mr_owner(const MemoryRegion *mr)
> static void mtree_print_mr(const MemoryRegion *mr, unsigned int level,
>                            hwaddr base,
>                            MemoryRegionListHead *alias_print_queue,
> -                           bool owner, bool display_disabled)
> +                           bool owner, bool display_disabled,
> +                           enum mtree_node_type node_type)
> {
>     MemoryRegionList *new_ml, *ml, *next_ml;
>     MemoryRegionListHead submr_print_queue;
> @@ -3376,8 +3398,9 @@ static void mtree_print_mr(const MemoryRegion *mr, unsigned int level,
>         }
>         if (mr->enabled || display_disabled) {
>             for (i = 0; i < level; i++) {
> -                qemu_printf(MTREE_INDENT);
> +                PRINT_MTREE_COL(i);
>             }
> +            PRINT_MTREE_NODE(node_type);
>             qemu_printf(HWADDR_FMT_plx "-" HWADDR_FMT_plx
>                         " (prio %d, %s%s): alias %s @%s " HWADDR_FMT_plx
>                         "-" HWADDR_FMT_plx "%s",
> @@ -3398,8 +3421,9 @@ static void mtree_print_mr(const MemoryRegion *mr, unsigned int level,
>     } else {
>         if (mr->enabled || display_disabled) {
>             for (i = 0; i < level; i++) {
> -                qemu_printf(MTREE_INDENT);
> +                PRINT_MTREE_COL(i);
>             }
> +            PRINT_MTREE_NODE(node_type);
>             qemu_printf(HWADDR_FMT_plx "-" HWADDR_FMT_plx
>                         " (prio %d, %s%s): %s%s",
>                         cur_start, cur_end,
> @@ -3435,8 +3459,12 @@ static void mtree_print_mr(const MemoryRegion *mr, unsigned int level,
>     }
>
>     QTAILQ_FOREACH(ml, &submr_print_queue, mrqueue) {
> +        if (ml == QTAILQ_LAST(&submr_print_queue)) {
> +            node_type = MTREE_NODE_T_TAIL;
> +        }
>         mtree_print_mr(ml->mr, level + 1, cur_start,
> -                       alias_print_queue, owner, display_disabled);
> +                       alias_print_queue, owner,
> +                       display_disabled, node_type);
>     }
>
>     QTAILQ_FOREACH_SAFE(ml, &submr_print_queue, mrqueue, next_ml) {
> @@ -3614,7 +3642,8 @@ static void mtree_print_as(gpointer key, gpointer value, gpointer user_data)
>     struct AddressSpaceInfo *asi = user_data;
>
>     g_slist_foreach(as_same_root_mr_list, mtree_print_as_name, NULL);
> -    mtree_print_mr(mr, 1, 0, asi->ml_head, asi->owner, asi->disabled);
> +    mtree_print_mr(mr, 1, 0, asi->ml_head, asi->owner, asi->disabled,
> +                   MTREE_NODE_T_INNER);
>     qemu_printf("\n");
> }
>
> @@ -3659,7 +3688,8 @@ static void mtree_info_as(bool dispatch_tree, bool owner, bool disabled)
>     /* print aliased regions */
>     QTAILQ_FOREACH(ml, &ml_head, mrqueue) {
>         qemu_printf("memory-region: %s\n", memory_region_name(ml->mr));
> -        mtree_print_mr(ml->mr, 1, 0, &ml_head, owner, disabled);
> +        mtree_print_mr(ml->mr, 1, 0, &ml_head, owner, disabled,
> +                       MTREE_NODE_T_INNER);
>         qemu_printf("\n");
>     }
>
>
--3866299591-686446110-1746012694=:25048--

