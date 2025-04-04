Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05A07C36010
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 14:00:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0haV-0007h2-A2; Fri, 04 Apr 2025 10:00:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1u0haS-0007fv-FR
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 10:00:00 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1u0haP-0004WW-S1
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 09:59:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=QFJhP+r6IOMQTp9YbEdvJ6iOMOfvQZm06AWx1uegYR8=; b=o5lnSHLU/yai21ym2/L8ETsxZN
 nU2riEd9YkNMnO5vHCom3+LnG5QVu2Fv2g4GMzBbWbrcVkpS8f1ATkWsD/0bSW6o6X4zRaDdyxv/G
 9oZak0xFjlZCoC2g25S0zWYEy0ZBiYCj1MXKcdMkPyiGrxSFCUEKkPy6aoeF89RsYsJM+/GHCn6ia
 h052W7y4SR8C/VQ5I+eRTvMQc3FePDHNijJwdcFL57GBUWkaFs+PfQoNGpkJhMeshKZ+UHrhfCWbO
 DpXOKR8j5BCGsAfBbsW62IQkqPSYac/IZ8ZlY/8brBOxJUnA8NHLBGCSgyATIkbsNOWJ0DTwartQi
 DKFk/k1HCQLirAzWlR5r3C6IPzwnPXvPotJWDpnmYrzg4r/0LCs5E3IlHQg6H1xR6TGDQhcqH1mY1
 bIfXC/UsPCZZ8JcpC0mZa1/wLeAGQVZyLPKj3dDzwfAeY8N9vvolc2JkPeAi/q8dyiy1e4jnHrKQ4
 Dqa87afOkIRwXdJPJVBvYiwpTkXsNPrSg0awNyC3ep6OZQP7ukkmkCaB6If82U7sGskJCoy+0gK7O
 siED3sHEmXOoIRENZ2pQbW4D0rA+Fqo4PNlKFvJtjYt+aqC0LZgsJEBI8ops26XK9+derkUlc/Qni
 RIIhTj/WM/oqeZzoHL/tj0hLDgVdZPkDDkGg7fhW8=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Zheng Huang <hz1624917200@gmail.com>, Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH] hw/9pfs: add cleanup operation for 9p-synth
Date: Fri, 04 Apr 2025 15:59:54 +0200
Message-ID: <1998899.hlcO8rIAHV@silver>
In-Reply-To: <a4e34adc-a425-4183-bb4f-f1b8197125eb@gmail.com>
References: <a4e34adc-a425-4183-bb4f-f1b8197125eb@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Monday, March 31, 2025 3:52:31 PM CEST Zheng Huang wrote:
> Hi,

Hi!

> This patch adds a cleanup operation for 9p-synth, which fixes a memory
> leak bug in synth_init() and other related operations. 

Which other operations?

> All child nodes
> of synth_root need to be freed before the entire filesystem exits.

I assume this is a theoretical fix, because I currently don't see how this
could result in memory being leaked in practice. The synth fs driver is just
used for 9pfs's automated test cases. Shortly after cleanup handler would be
called, the entire process is torn down anyway, and with that all memory
being freed automatically.

> If you have any better ideas for the implementation, please feel free
> to share them.

By using two nested loops in synth_cleanup()? One loop for walking vertically
(child) and one loop for walking horizontally (sibling). Then you could just
open code everything within synth_cleanup() instead.

However I don't see a real reason for this patch in the first place.

> Signed-off-by: Zheng Huang <hz1624917200@gmail.com>
> 
> 
> ---
>  hw/9pfs/9p-synth.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/hw/9pfs/9p-synth.c b/hw/9pfs/9p-synth.c
> index 2abaf3a291..ead8b9e3be 100644
> --- a/hw/9pfs/9p-synth.c
> +++ b/hw/9pfs/9p-synth.c
> @@ -24,6 +24,7 @@
>  #include "qemu/rcu.h"
>  #include "qemu/rcu_queue.h"
>  #include "qemu/cutils.h"
> +#include "qobject/qlist.h"
>  #include "system/qtest.h"
>  
>  /* Root node for synth file system */
> @@ -136,6 +137,19 @@ int qemu_v9fs_synth_add_file(V9fsSynthNode *parent, int mode,
>      return 0;
>  }
>  
> +// Must call after get synth_mutex
> +static void v9fs_recursive_free_node(V9fsSynthNode *node)
> +{
> +    V9fsSynthNode *entry;
> +
> +    for (entry = QLIST_FIRST(&node->child); entry;) {
> +        V9fsSynthNode *next = QLIST_NEXT(entry, sibling);
> +        v9fs_recursive_free_node(entry);
> +        g_free(entry);
> +        entry = next;
> +    }
> +}
> +
>  static void synth_fill_statbuf(V9fsSynthNode *node, struct stat *stbuf)
>  {
>      stbuf->st_dev = 0;
> @@ -615,8 +629,22 @@ static int synth_init(FsContext *ctx, Error **errp)
>      return 0;
>  }
>  
> +
> +static void synth_cleanup(FsContext *ctx)
> +{
> +    // recursively free all child nodes of synth_root
> +    // V9fsSynthNode *tmp;
> +    QEMU_LOCK_GUARD(&synth_mutex);
> +    v9fs_recursive_free_node(&synth_root);
> +    // QLIST_FOREACH(tmp, &synth_root.child, sibling) {
> +    //     v9fs_recursive_free_node(tmp);
> +    // }

No commented code in patch submissions, please.

/Christian

> +    QLIST_INIT(&synth_root.child);
> +}
> +
>  FileOperations synth_ops = {
>      .init         = synth_init,
> +    .cleanup      = synth_cleanup,
>      .lstat        = synth_lstat,
>      .readlink     = synth_readlink,
>      .close        = synth_close,
> 



