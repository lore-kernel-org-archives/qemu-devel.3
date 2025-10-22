Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31DC5CCD1BB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 12:53:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBYLM-0008Oj-RZ; Wed, 22 Oct 2025 08:53:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vBYLL-0008OX-3w
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 08:53:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vBYLI-0002Rs-Rn
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 08:53:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761137607;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cgYbzdIy5gl8hCcIyq9fcZu+4mckK5ao5yEDtHzgFMI=;
 b=F04Q+75KYdYCTRb+A5cdinPVcX8YItvUxJlcGrVv7GS4SoIrkr59GiYhOgrnY6FEWsRYto
 GwvjMpJf1dHXrn10Ql0f+byidAj2WAJagvCsd3O8UuCTamGKl/Wf2xVaGyxLMSlCHrMXnU
 5iONlwjSpsLKVz3AXwrQEgiJ5G6Kxeo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-222--KWC1anXMl-xcytXQW6oAA-1; Wed,
 22 Oct 2025 08:53:26 -0400
X-MC-Unique: -KWC1anXMl-xcytXQW6oAA-1
X-Mimecast-MFC-AGG-ID: -KWC1anXMl-xcytXQW6oAA_1761137605
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 44EB618001D1; Wed, 22 Oct 2025 12:53:25 +0000 (UTC)
Received: from redhat.com (unknown [10.45.225.168])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 418DD1956056; Wed, 22 Oct 2025 12:53:22 +0000 (UTC)
Date: Wed, 22 Oct 2025 14:53:19 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Brian Song <hibriansong@gmail.com>
Subject: Re: [PATCH v3 15/21] fuse: Process requests in coroutines
Message-ID: <aPjTv2Mf1ToeFqHT@redhat.com>
References: <20250701114437.207419-1-hreitz@redhat.com>
 <20250701114437.207419-16-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250701114437.207419-16-hreitz@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Am 01.07.2025 um 13:44 hat Hanna Czenczek geschrieben:
> Make fuse_process_request() a coroutine_fn (fuse_co_process_request())
> and have read_from_fuse_fd() launch it inside of a newly created
> coroutine instead of running it synchronously.  This way, we can process
> requests in parallel.
> 
> These are the benchmark results, compared to (a) the original results
> with libfuse, and (b) the results after switching away from libfuse
> (i.e. before this patch):
> 
> file:                  (vs. libfuse / vs. no libfuse)
>   read:
>     seq aio:   120.6k ±1.1k (+ 53 % / + 58 %)
>     rand aio:  113.3k ±5.9k (+188 % / +325 %)
>     seq sync:   52.4k ±0.4k (+ 61 % / + 10 %)
>     rand sync:  10.4k ±0.4k (+  6 % / +  3 %)
>   write:
>     seq aio:    79.8k ±0.8k (+ 29 % / + 37 %)
>     rand aio:   79.0k ±0.6k (+ 29 % / + 36 %)
>     seq sync:   41.5k ±0.3k (+ 49 % / + 15 %)
>     rand sync:  41.4k ±0.2k (+ 50 % / + 15 %)
> null:
>   read:
>     seq aio:   266.1k ±1.5k (+ 24 % / -  1 %)
>     rand aio:  264.1k ±2.5k (+ 24 % / ±  0 %)
>     seq sync:  135.6k ±3.2k (+ 50 % / +  1 %)
>     rand sync: 134.7k ±3.0k (+ 50 % / +  2 %)
>   write:
>     seq aio:   281.0k ±1.8k (+ 38 % / +  2 %)
>     rand aio:  288.1k ±6.1k (+ 43 % / +  6 %)
>     seq sync:  142.2k ±3.1k (+ 65 % / +  9 %)
>     rand sync: 141.1k ±2.9k (+ 66 % / + 11 %)
> 
> So for non-AIO cases (and the null driver, which does not yield), there
> is little change; but for file AIO, results greatly improve, resolving
> the performance issue we saw before (when switching away from libfuse).
> 
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> ---
>  block/export/fuse.c | 194 ++++++++++++++++++++++++++------------------
>  1 file changed, 113 insertions(+), 81 deletions(-)
> 
> diff --git a/block/export/fuse.c b/block/export/fuse.c
> index 8ea590ba67..0648b5bc7d 100644
> --- a/block/export/fuse.c
> +++ b/block/export/fuse.c
> @@ -27,6 +27,7 @@
>  #include "block/qapi.h"
>  #include "qapi/error.h"
>  #include "qapi/qapi-commands-block.h"
> +#include "qemu/coroutine.h"
>  #include "qemu/error-report.h"
>  #include "qemu/main-loop.h"
>  #include "system/block-backend.h"
> @@ -86,6 +87,12 @@ typedef struct FuseExport {
>      gid_t st_gid;
>  } FuseExport;
>  
> +/* Parameters to the request processing coroutine */
> +typedef struct FuseRequestCoParam {
> +    FuseExport *exp;
> +    int got_request;
> +} FuseRequestCoParam;

This type is unused.

Kevin


