Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56A03C28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 14:35:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvGzC-00077F-T4; Thu, 20 Mar 2025 10:35:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1tvGye-0006uV-M3
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 10:34:39 -0400
Received: from smtpout3.mo529.mail-out.ovh.net ([46.105.54.81])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1tvGyX-0003WQ-Dm
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 10:34:30 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.176.7])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 4ZJSkz5sGlz10Hr;
 Thu, 20 Mar 2025 14:34:19 +0000 (UTC)
Received: from kaod.org (37.59.142.114) by DAG6EX1.mxp5.local (172.16.2.51)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Thu, 20 Mar
 2025 15:34:19 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-114S0081d61ae98-660f-4e7b-9baf-ff2dbf30c11d,
 634753926966D39EDD754D066B00D0F2EFF7B06B) smtp.auth=groug@kaod.org
X-OVh-ClientIp: 88.179.9.154
Date: Thu, 20 Mar 2025 15:34:12 +0100
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
CC: <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2] 9pfs: fix 'total_open_fd' decrementation
Message-ID: <20250320153412.0cfda7c2@bahia>
In-Reply-To: <E1tvEyJ-004dMa-So@kylie.crudebyte.com>
References: <E1tvEyJ-004dMa-So@kylie.crudebyte.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.114]
X-ClientProxiedBy: DAG5EX1.mxp5.local (172.16.2.41) To DAG6EX1.mxp5.local
 (172.16.2.51)
X-Ovh-Tracer-GUID: 59f8c335-9e5e-4964-8065-6f8f9e0d48dd
X-Ovh-Tracer-Id: 2840363992157755802
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeekgeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpeffhffvvefukfgjfhfogggtgfhisehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeegkeejtdevgeekieelffdvtedvvdegtdduudeigffhhffgvdfhgeejteekheefkeenucfkphepuddvjedrtddrtddruddpfeejrdehledrudegvddruddugedpkeekrddujeelrdelrdduheegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdpnhgspghrtghpthhtohepvddprhgtphhtthhopehqvghmuhgpohhsshestghruhguvggshihtvgdrtghomhdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdfovfetjfhoshhtpehmohehvdelmgdpmhhouggvpehsmhhtphhouhht
DKIM-Signature: a=rsa-sha256; bh=fcEF2l3r3o1ZWU9cAlbVUaNph6xFRWLAimR2hrID0Sk=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1742481260; v=1;
 b=sezKNdfsgKXIJfKaLqyA60IMGBNHa3AKIpA3J5PuAcRZs9tsI3a6Hc7PQdQIx20J+GM7+WhA
 ku1DviGNrCi1MuWZqDgWM/xEawVA5gAWQ0QZESiStyO/JXt2/W03FHQAOVr2XCc6AMcNp3/0J/X
 +kHF86heDN0Vl85b4nYmKpT25iC5ET4Zve0WGqhBcRn/7IB0XoB85wn+MOHJwtr73XqNjbhbWOQ
 T/VFHlwqVuB+Zu5UcWZJAmRTFXClWHXjTO10tnqVq4fET/TSb1W0DZM/uf4cM51t7w9oAYcRDzJ
 u+LAlvPu3w/G102tt+J5z4cJ8HmcIXVyvfn43EK/Q7Ung==
Received-SPF: pass client-ip=46.105.54.81; envelope-from=groug@kaod.org;
 helo=smtpout3.mo529.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, 20 Mar 2025 13:16:20 +0100
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> According to 'man 2 close' errors returned by close() should only be used
> for either diagnostic purposes or for catching data loss due to a previous
> write error, as an error result of close() usually indicates a deferred
> error of a previous write operation.
> 
> Therefore not decrementing 'total_open_fd' on a close() error is wrong
> and would yield in a higher open file descriptor count than actually the
> case, leading to 9p server reclaiming open file descriptors too soon.
> 
> Based-on: <20250312152933.383967-7-groug@kaod.org>
> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> ---
>  V2: log a warning message on unexpected close() -> EBADF case
> 
>  hw/9pfs/9p.c     | 10 +++++++++-
>  hw/9pfs/codir.c  |  7 ++++++-
>  hw/9pfs/cofile.c |  7 ++++++-
>  3 files changed, 21 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> index b22df3aa2b..8b001b9112 100644
> --- a/hw/9pfs/9p.c
> +++ b/hw/9pfs/9p.c
> @@ -510,7 +510,15 @@ void coroutine_fn v9fs_reclaim_fd(V9fsPDU *pdu)
>              err = (f->fid_type == P9_FID_DIR) ?
>                  s->ops->closedir(&s->ctx, &f->fs_reclaim) :
>                  s->ops->close(&s->ctx, &f->fs_reclaim);
> -            if (!err) {
> +
> +            /* 'man 2 close' suggests to ignore close() errors except of EBADF */
> +            if (unlikely(err && errno == EBADF)) {
> +                /*
> +                 * unexpected case as FIDs were picked above by having a valid
> +                 * file descriptor
> +                 */
> +                error_report("9pfs: v9fs_reclaim_fd() WARNING: close() failed with EBADF");

Reviewed-by: Greg Kurz <groug@kaod.org>

I just hope there isn't a way to reach this 100% or we'll end up
saturating the logs. ;-)

> +            } else {
>                  /* total_open_fd must only be mutated on main thread */
>                  nclosed++;
>              }
> diff --git a/hw/9pfs/codir.c b/hw/9pfs/codir.c
> index 2068a4779d..bce7dd96e9 100644
> --- a/hw/9pfs/codir.c
> +++ b/hw/9pfs/codir.c
> @@ -20,6 +20,7 @@
>  #include "fsdev/qemu-fsdev.h"
>  #include "qemu/thread.h"
>  #include "qemu/main-loop.h"
> +#include "qemu/error-report.h"
>  #include "coth.h"
>  #include "9p-xattr.h"
>  #include "9p-util.h"
> @@ -353,7 +354,11 @@ int coroutine_fn v9fs_co_closedir(V9fsPDU *pdu, V9fsFidOpenState *fs)
>                  err = -errno;
>              }
>          });
> -    if (!err) {
> +    /* 'man 2 close' suggests to ignore close() errors except of EBADF */
> +    if (unlikely(err && errno == EBADF)) {
> +        /* unexpected case as we should have checked for a valid file handle */
> +        error_report("9pfs: WARNING: v9fs_co_closedir() failed with EBADF");
> +    } else {
>          total_open_fd--;
>      }
>      return err;
> diff --git a/hw/9pfs/cofile.c b/hw/9pfs/cofile.c
> index 71174c3e4a..6e775c8e41 100644
> --- a/hw/9pfs/cofile.c
> +++ b/hw/9pfs/cofile.c
> @@ -20,6 +20,7 @@
>  #include "fsdev/qemu-fsdev.h"
>  #include "qemu/thread.h"
>  #include "qemu/main-loop.h"
> +#include "qemu/error-report.h"
>  #include "coth.h"
>  
>  int coroutine_fn v9fs_co_st_gen(V9fsPDU *pdu, V9fsPath *path, mode_t st_mode,
> @@ -197,7 +198,11 @@ int coroutine_fn v9fs_co_close(V9fsPDU *pdu, V9fsFidOpenState *fs)
>                  err = -errno;
>              }
>          });
> -    if (!err) {
> +    /* 'man 2 close' suggests to ignore close() errors except of EBADF */
> +    if (unlikely(err && errno == EBADF)) {
> +        /* unexpected case as we should have checked for a valid file handle */
> +        error_report("9pfs: WARNING: v9fs_co_close() failed with EBADF");
> +    } else {
>          total_open_fd--;
>      }
>      return err;



-- 
Greg

