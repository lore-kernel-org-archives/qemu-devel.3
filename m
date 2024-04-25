Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22BBCC4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 14:26:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s002i-0001XA-Uw; Thu, 25 Apr 2024 10:25:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s002f-0001Wv-2k
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 10:25:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s002d-0006Ls-36
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 10:25:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714055137;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=/t+Yt6w0d9ifieD2mf0NebCoP7j0rkPISsJsp2OMa6M=;
 b=HFC4cDWFUrldQB70qmyGTGkqD2qVceSgSvu0p715Bnua3s46drxUc9Nysnq3kEgSvAfBWO
 kfCI7zez3iUnKsPMckRLR1gWaRDCs7jBoPq5Wa9/Y3Bc/Rw8/pDvySF2usPm5ViyMgScxy
 4aOd+V6Tm4Kdyt0314oVXBBd4bju2DA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-132-C1u0I8xFNsiHCecuryZRSg-1; Thu, 25 Apr 2024 10:25:34 -0400
X-MC-Unique: C1u0I8xFNsiHCecuryZRSg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8B1CB104B504;
 Thu, 25 Apr 2024 14:25:33 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.102])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 21FE14024B5F;
 Thu, 25 Apr 2024 14:25:32 +0000 (UTC)
Date: Thu, 25 Apr 2024 15:25:30 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Hao Xiang <hao.xiang@linux.dev>
Cc: marcandre.lureau@redhat.com, peterx@redhat.com, farosas@suse.de,
 armbru@redhat.com, lvivier@redhat.com, qemu-devel@nongnu.org,
 Bryan Zhang <bryan.zhang@bytedance.com>
Subject: Re: [PATCH v4 03/14] util/dsa: Implement DSA device start and stop
 logic.
Message-ID: <Zipn2g2R2itbdlPc@redhat.com>
References: <20240425022117.4035031-1-hao.xiang@linux.dev>
 <20240425022117.4035031-4-hao.xiang@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240425022117.4035031-4-hao.xiang@linux.dev>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.669,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Apr 25, 2024 at 02:21:06AM +0000, Hao Xiang wrote:
> * DSA device open and close.
> * DSA group contains multiple DSA devices.
> * DSA group configure/start/stop/clean.
> 
> Signed-off-by: Hao Xiang <hao.xiang@linux.dev>
> Signed-off-by: Bryan Zhang <bryan.zhang@bytedance.com>
> ---
>  include/qemu/dsa.h |  72 +++++++++++
>  util/dsa.c         | 316 +++++++++++++++++++++++++++++++++++++++++++++
>  util/meson.build   |   1 +
>  3 files changed, 389 insertions(+)
>  create mode 100644 include/qemu/dsa.h
>  create mode 100644 util/dsa.c
> 
> diff --git a/include/qemu/dsa.h b/include/qemu/dsa.h
> new file mode 100644
> index 0000000000..f15c05ee85
> --- /dev/null
> +++ b/include/qemu/dsa.h
> @@ -0,0 +1,72 @@
> +#ifndef QEMU_DSA_H
> +#define QEMU_DSA_H
> +
> +#include "qemu/error-report.h"
> +#include "qemu/thread.h"
> +#include "qemu/queue.h"
> +
> +#ifdef CONFIG_DSA_OPT
> +
> +#pragma GCC push_options
> +#pragma GCC target("enqcmd")

You've tested in meson.build that the compiler supports
'enqcmd' which is good. I'm not seeing anything that
tests whether the host running this code supports 'enqcmd'.
There needs to be a CPUID check for this at runtime.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


