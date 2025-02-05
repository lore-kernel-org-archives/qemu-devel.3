Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C6FDC02192
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 21:29:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfmwo-0003Jm-6h; Wed, 05 Feb 2025 16:28:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tfmwm-0003HX-Ue
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 16:28:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tfmwl-0000hA-8u
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 16:28:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738790911;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xp/UdexfbeGTePAm9p5ljBLF3ZkTipyYEfiIbxs6n/4=;
 b=jTZTeWsthhfkMJxw97qqI0e1zcou/0kk1M9cUzV3PulsVLOZVNYImZxbwxk1LYIZKxi6Ps
 2lPuvNo2en4Rahn/tLUo/MdFR0t6XZiQIaOC/AHIpH1VuuJkEDc0cl40E91qerGMhDJoDa
 3cahcwUw7VtrSFNL9IpsfAVCdRspHZU=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-o0NKVgFRPNmxXrha8NJDrw-1; Wed, 05 Feb 2025 16:28:30 -0500
X-MC-Unique: o0NKVgFRPNmxXrha8NJDrw-1
X-Mimecast-MFC-AGG-ID: o0NKVgFRPNmxXrha8NJDrw
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4679becb47eso6610551cf.3
 for <qemu-devel@nongnu.org>; Wed, 05 Feb 2025 13:28:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738790909; x=1739395709;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xp/UdexfbeGTePAm9p5ljBLF3ZkTipyYEfiIbxs6n/4=;
 b=c3KN1GPKVnKYxHp4vIxKpsyRcRTxr9bULJtN4jQnb91DhETUwsVH38ByvlMDDOSs4k
 SSuCKkO2A1+Q94I/B+ex8+g8FOoS6uQ3zRiXv0sdeRtr6n6jSIXVkcl5pC0aq4WfwNWu
 BKPx/uaHcLkL++U0oTCGPO4kGgaZYxuHh/6XUlq8bnAA08e7TRmCxq8a4ZauspgmhlIc
 TOHqyEhU74Vy3L7iAbyDwGcak9owFyPce2CzQHDn0BbzD21BAKT6ThDRjOIiGwuVLlVX
 IcTZEx+Q08hN7ZlG8w80Fxj8Zhu3AjEMjE7H0Xd2WA/yLhJ7kbrmpEy2WltEf3bLlP88
 Gezw==
X-Gm-Message-State: AOJu0YxFqqTOsJvIIjrxcm4J/m7Byqnu898PfIFP2fUA9O8hiZZlz2fN
 5On5ILT4xG8xF8QkBYEfcdTHI2FEBewIBAFnJm8BpCHwogFB/x9p0vtmO1L4J/rWrlUCri0pvty
 NggGkQzL+mE9bawxpmvBuzqdsUf4j4hV6C/RJT4XoI8/exej1uy0fAP9U9sBZ
X-Gm-Gg: ASbGnctZxfq7ld2NUCQE3J0JxNEvT4+SaxbBjJrM0A9t6RvIFYxFEMwfV8PEQ502/JM
 gjp69nMSoo4/zt9tdJzNGlLEYAZZi4Xvcl3PUmJwWwPI5axR77t6ZTrSEh6A7wfQdjm7ogQK8Gm
 2QxzIYf+n7gcmkPCBOSr3A8/3W9G+QL/C3a+aJh+JpJFS06PJcAtmj/Z7R4oiKEmQCf++x3cAr3
 KXaUf3gxCwwtlBoGd17FfPcxVJaIx8hXrz44n7fYpY3mqvuZgFmEuB0FEvcg2rMcwaRRw1dqMw5
 txhet4pxgzkLuJr0q63iphOIrrF7s2hGCVTA6pRRnHczWJ8s
X-Received: by 2002:a05:622a:7c91:b0:467:b7de:da8a with SMTP id
 d75a77b69052e-470303cfc2dmr24326581cf.6.1738790909503; 
 Wed, 05 Feb 2025 13:28:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEGarPdTmxD3Ww7hnoYHSaJYBokkUYN2DYA9uvcW+HmTjfYOuZB8QU2qvh84h0ZYeycn9L+fQ==
X-Received: by 2002:a05:622a:7c91:b0:467:b7de:da8a with SMTP id
 d75a77b69052e-470303cfc2dmr24326441cf.6.1738790909248; 
 Wed, 05 Feb 2025 13:28:29 -0800 (PST)
Received: from x1.local (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46fdf1728c8sm74451961cf.56.2025.02.05.13.28.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2025 13:28:28 -0800 (PST)
Date: Wed, 5 Feb 2025 16:28:25 -0500
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] migration: use parameters.mode in cpr_state_save
Message-ID: <Z6PX-Shf7UREfLD7@x1.local>
References: <1738788841-211843-1-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1738788841-211843-1-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Wed, Feb 05, 2025 at 12:54:01PM -0800, Steve Sistare wrote:
> qmp_migrate guarantees that cpr_channel is not null for
> MIG_MODE_CPR_TRANSFER when cpr_state_save is called:
> 
>     qmp_migrate()
>         if (s->parameters.mode == MIG_MODE_CPR_TRANSFER && !cpr_channel) {
>             return;
>         }
>         cpr_state_save(cpr_channel)
> 
> but cpr_state_save checks for mode differently before using channel,
> and Coverity cannot infer that they are equivalent in outgoing QEMU,
> and warns that channel may be NULL:
> 
>     cpr_state_save(channel)
>         MigMode mode = migrate_mode();
>         if (mode == MIG_MODE_CPR_TRANSFER) {
>             f = cpr_transfer_output(channel, errp);
> 
> To make Coverity happy, use parameters.mode in cpr_state_save.
> 
> Resolves: Coverity CID 1590980
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  migration/cpr.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/migration/cpr.c b/migration/cpr.c
> index 584b0b9..7f20bd5 100644
> --- a/migration/cpr.c
> +++ b/migration/cpr.c
> @@ -8,6 +8,7 @@
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
>  #include "migration/cpr.h"
> +#include "migration/migration.h"
>  #include "migration/misc.h"
>  #include "migration/options.h"
>  #include "migration/qemu-file.h"
> @@ -132,7 +133,7 @@ int cpr_state_save(MigrationChannel *channel, Error **errp)
>  {
>      int ret;
>      QEMUFile *f;
> -    MigMode mode = migrate_mode();
> +    MigMode mode = migrate_get_current()->parameters.mode;

Are we sure this can make coverity happy?

Another more straightforward change is caching migrate mode in
qmp_migrate() and also check that before invoking cpr_state_save().

Thanks,

>  
>      trace_cpr_state_save(MigMode_str(mode));
>  
> -- 
> 1.8.3.1
> 

-- 
Peter Xu


