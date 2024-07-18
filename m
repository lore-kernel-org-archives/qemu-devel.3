Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9DB9C3DA60
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 12:03:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUPpZ-0005YV-3n; Thu, 18 Jul 2024 08:01:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sUPot-0005Mi-JD
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 08:01:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sUPop-0006cp-70
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 08:01:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721304063;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qkF3l/xAfqQZQqXJOdzLcM9wVOjQIOvygZURVhGWAx4=;
 b=Tyl2azZ8a1XYl6ai6yHuikDZwZ1H040bPFguyDHp6xdj7RINQwx0dAUlVSODxd6RtQqYgb
 t/vt0AXxiTdExexGAVPsmReMLHmsYX/8tTIeWwH5x4VqesEv8c1GEK5kTg/vC+b8J1wXsb
 M+/xWk1DdJBuFcDjxlXMpzoFBEQ18uw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623-aiVnpjjXOhiSgOifhLgImQ-1; Thu,
 18 Jul 2024 08:01:00 -0400
X-MC-Unique: aiVnpjjXOhiSgOifhLgImQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 773AE1956064; Thu, 18 Jul 2024 12:00:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.65])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8FB8519560AA; Thu, 18 Jul 2024 12:00:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5E91221E668E; Thu, 18 Jul 2024 14:00:54 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-block@nongnu.org,  qemu-devel@nongnu.org,  pbonzini@redhat.com,
 eblake@redhat.com,  hreitz@redhat.com,  kwolf@redhat.com
Subject: Re: [PATCH v9 4/7] qapi: add blockdev-replace command
In-Reply-To: <20240626115350.405778-5-vsementsov@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Wed, 26 Jun 2024 14:53:47 +0300")
References: <20240626115350.405778-1-vsementsov@yandex-team.ru>
 <20240626115350.405778-5-vsementsov@yandex-team.ru>
Date: Thu, 18 Jul 2024 14:00:54 +0200
Message-ID: <871q3qc3k9.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:

> Add a command that can replace bs in following BdrvChild structures:
>
>  - qdev blk root child
>  - block-export blk root child
>  - any child of BlockDriverState selected by child-name
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  blockdev.c             | 56 +++++++++++++++++++++++++++
>  qapi/block-core.json   | 88 ++++++++++++++++++++++++++++++++++++++++++
>  stubs/blk-by-qdev-id.c | 13 +++++++
>  stubs/meson.build      |  1 +
>  4 files changed, 158 insertions(+)
>  create mode 100644 stubs/blk-by-qdev-id.c
>
> diff --git a/blockdev.c b/blockdev.c
> index ba7e90b06e..2190467022 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -3559,6 +3559,62 @@ void qmp_x_blockdev_set_iothread(const char *node_name, StrOrNull *iothread,
>      bdrv_try_change_aio_context(bs, new_context, NULL, errp);
>  }
>  
> +void qmp_blockdev_replace(BlockdevReplace *repl, Error **errp)
> +{
> +    BdrvChild *child = NULL;
> +    BlockDriverState *new_child_bs;
> +
> +    if (repl->parent_type == BLOCK_PARENT_TYPE_DRIVER) {
> +        BlockDriverState *parent_bs;
> +
> +        parent_bs = bdrv_find_node(repl->u.driver.node_name);
> +        if (!parent_bs) {
> +            error_setg(errp, "Block driver node with node-name '%s' not "
> +                       "found", repl->u.driver.node_name);
> +            return;
> +        }
> +
> +        child = bdrv_find_child(parent_bs, repl->u.driver.child);
> +        if (!child) {
> +            error_setg(errp, "Block driver node '%s' doesn't have child "
> +                       "named '%s'", repl->u.driver.node_name,
> +                       repl->u.driver.child);
> +            return;
> +        }
> +    } else {
> +        /* Other types are similar, they work through blk */
> +        BlockBackend *blk;
> +        bool is_qdev = repl->parent_type == BLOCK_PARENT_TYPE_QDEV;
> +        const char *id =
> +            is_qdev ? repl->u.qdev.qdev_id : repl->u.export.export_id;
> +
> +        assert(is_qdev || repl->parent_type == BLOCK_PARENT_TYPE_EXPORT);
> +
> +        blk = is_qdev ? blk_by_qdev_id(id, errp) : blk_by_export_id(id, errp);

blk_by_export_id() finds export @exp, and returns the associated block
backend exp->blk.  Fine.

blk_by_qdev_id() finds the device, and then searches @block_backends for
a blk with blk->dev == blk.  If a device has more than one block
backend, you get the one first in @block_backends.  I figure that's the
one created first.

Interface issue: when a device has multiple block backends, only one of
them can be replaced, and which one is kind of random.

Do such devices exist?

If no, could they exist?

If yes, what should we do about it now?

> +        if (!blk) {
> +            return;
> +        }
> +
> +        child = blk_root(blk);
> +        if (!child) {
> +            error_setg(errp, "%s '%s' is empty, nothing to replace",
> +                       is_qdev ? "Device" : "Export", id);
> +            return;
> +        }
> +    }
> +
> +    assert(child);
> +    assert(child->bs);
> +
> +    new_child_bs = bdrv_find_node(repl->new_child);
> +    if (!new_child_bs) {
> +        error_setg(errp, "Node '%s' not found", repl->new_child);
> +        return;
> +    }
> +
> +    bdrv_replace_child_bs(child, new_child_bs, errp);
> +}
> +
>  QemuOptsList qemu_common_drive_opts = {
>      .name = "drive",
>      .head = QTAILQ_HEAD_INITIALIZER(qemu_common_drive_opts.head),
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index df5e07debd..0a6f08a6e0 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -6148,3 +6148,91 @@
>  ##
>  { 'struct': 'DummyBlockCoreForceArrays',
>    'data': { 'unused-block-graph-info': ['BlockGraphInfo'] } }
> +
> +##
> +# @BlockParentType:
> +#
> +# @qdev: block device, such as created by device_add, and denoted by
> +#     qdev-id
> +#
> +# @driver: block driver node, such as created by blockdev-add, and
> +#     denoted by node-name

node-name and child?

> +#
> +# @export: block export, such created by block-export-add, and
> +#     denoted by export-id
> +#
> +# Since 9.1
> +##

I'm kind of unhappy with this doc comment.  I feel makes sense only in
the context of its use.  Let me try to avoid that:

   # @driver: the parent is a block node, the child is one of its
   #     children.
   #
   # @export: the parent is a block export, the child is its block
   #     backend.
   #
   # @qdev: the parent is a device, the child is its block backend.

> +{ 'enum': 'BlockParentType',
> +  'data': ['qdev', 'driver', 'export'] }

If you take my comment, change the order here as well.

> +
> +##
> +# @BdrvChildRefQdev:
> +#
> +# @qdev-id: the device's ID or QOM path
> +#
> +# Since 9.1
> +##
> +{ 'struct': 'BdrvChildRefQdev',
> +  'data': { 'qdev-id': 'str' } }
> +
> +##
> +# @BdrvChildRefExport:
> +#
> +# @export-id: block export identifier

block-export.json calls this "block export id" in some places, and
"block export identifier" in others.  *Sigh*

Nothing to see here, move on!

> +#
> +# Since 9.1
> +##
> +{ 'struct': 'BdrvChildRefExport',
> +  'data': { 'export-id': 'str' } }
> +
> +##
> +# @BdrvChildRefDriver:
> +#
> +# @node-name: the node name of the parent block node
> +#
> +# @child: name of the child to be replaced, like "file" or "backing"
> +#
> +# Since 9.1
> +##
> +{ 'struct': 'BdrvChildRefDriver',
> +  'data': { 'node-name': 'str', 'child': 'str' } }
> +
> +##
> +# @BlockdevReplace:
> +#
> +# @parent-type: type of the parent, which child is to be replaced

Suggest to scratch ", which child ..."

> +#
> +# @new-child: new child for replacement

Suggest "the new child".

> +#
> +# Since 9.1
> +##
> +{ 'union': 'BlockdevReplace',
> +  'base': {
> +      'parent-type': 'BlockParentType',
> +      'new-child': 'str'
> +  },
> +  'discriminator': 'parent-type',
> +  'data': {
> +      'qdev': 'BdrvChildRefQdev',
> +      'export': 'BdrvChildRefExport',
> +      'driver': 'BdrvChildRefDriver'
> +  } }
> +
> +##
> +# @blockdev-replace:
> +#
> +# Replace a block-node associated with device (selected by
> +# @qdev-id) or with block-export (selected by @export-id) or
> +# any child of block-node (selected by @node-name and @child)
> +# with @new-child block-node.

s/block-node/block node/ for consistency with existing usage.

Likewise, s/block-export/block export/.

> +#
> +# Features:
> +#
> +# @unstable: This command is experimental.
> +#
> +# Since 9.1
> +##
> +{ 'command': 'blockdev-replace', 'boxed': true,
> +  'features': [ 'unstable' ],
> +  'data': 'BlockdevReplace' }
> diff --git a/stubs/blk-by-qdev-id.c b/stubs/blk-by-qdev-id.c
> new file mode 100644
> index 0000000000..5ec9f755ee
> --- /dev/null
> +++ b/stubs/blk-by-qdev-id.c
> @@ -0,0 +1,13 @@
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "sysemu/block-backend.h"
> +
> +BlockBackend *blk_by_qdev_id(const char *id, Error **errp)
> +{
> +    /*
> +     * We expect this when blockdev-change is called with parent-type=qdev,
> +     * but qdev-monitor is not linked in. So no blk_ API is not available.
> +     */

The last sentence is confusing.

> +    error_setg(errp, "Parameter 'parent-type' does not accept value 'qdev'");

I suggested this message.  I must have suffered from tunnel vision then.

The error message is good when the caller is qmp_blockdev_replace().
Then parameter @parent-type exists, and parameter value "qdev" cannot
work for any value of parameter "qdev-id" (which is @id here).

There are several more callers.  They don't use the stub now (or else
they wouldn't link before this patch).  But future callers may well use
it, and then the error message will likely be misleading.

v8 had

       error_setg(errp, "blk '%s' not found", id);

instead.  No good, because @id is not a "blk" (whatever that may be),
it's a qdev ID.  You offered "devices are not supported".  Less than
ideal, since it doesn't point to the argument that's causing the error,
but I figure it's the best we can do without refactoring.  Maybe
"can't select block backend by device ID".  Up to you.

> +    return NULL;
> +}
> diff --git a/stubs/meson.build b/stubs/meson.build
> index 772a3e817d..068998c1a5 100644
> --- a/stubs/meson.build
> +++ b/stubs/meson.build
> @@ -15,6 +15,7 @@ if have_block
>    stub_ss.add(files('bdrv-next-monitor-owned.c'))
>    stub_ss.add(files('blk-commit-all.c'))
>    stub_ss.add(files('blk-exp-close-all.c'))
> +  stub_ss.add(files('blk-by-qdev-id.c'))
>    stub_ss.add(files('blockdev-close-all-bdrv-states.c'))
>    stub_ss.add(files('change-state-handler.c'))
>    stub_ss.add(files('get-vm-name.c'))


