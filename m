Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 423FCD2FFE6
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 10:02:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1joU-00070v-Ip; Fri, 18 Oct 2024 06:02:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t1joH-0006z0-Qp
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 06:02:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t1joE-0003kz-6f
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 06:02:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729245732;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w/CpKBfaz9C0RHQwCnJdYh6QHgQqNoCHbz9nz9DVYR4=;
 b=SNduhbObVWhmAyH8GIBag3EzdkUMRgVP7xmWfN4iKqLCMhRE4AFka5E/JbvppzzlYQimmU
 3JplIcjrz/WR6qbCEeZY4dSUF4eR7hF7kHyzxrIe0Ph04R7yuJ2Pp4CsIbI04q6bj103Nl
 6LO8n80HAPdhPuPqw0mZhLTjyQhFJG4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-526-s7OpmVB8OC-rCHAfmj6Ndg-1; Fri,
 18 Oct 2024 06:02:09 -0400
X-MC-Unique: s7OpmVB8OC-rCHAfmj6Ndg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D95F61955F45; Fri, 18 Oct 2024 10:02:07 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.61])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 69CAB19560AD; Fri, 18 Oct 2024 10:02:06 +0000 (UTC)
Date: Fri, 18 Oct 2024 11:02:03 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 23/31] system: adapt to new import path for qobject
 data type headers
Message-ID: <ZxIyG6kr1nXCLWD9@redhat.com>
References: <20241017113344.883424-1-berrange@redhat.com>
 <20241017113344.883424-24-berrange@redhat.com>
 <ZxIzGtYb6nsk38A5@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZxIzGtYb6nsk38A5@intel.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.068,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Oct 18, 2024 at 06:06:18PM +0800, Zhao Liu wrote:
> Hi Daniel,
> 
> On Thu, Oct 17, 2024 at 12:33:35PM +0100, Daniel P. Berrangé wrote:
> > Date: Thu, 17 Oct 2024 12:33:35 +0100
> > From: "Daniel P. Berrangé" <berrange@redhat.com>
> > Subject: [PATCH v2 23/31] system: adapt to new import path for qobject data
> >  type headers
> > 
> > The qobject data type headers have moved from qapi/qmp/ to
> > qobject/.
> > 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >  system/device_tree.c       | 2 +-
> >  system/dirtylimit.c        | 2 +-
> >  system/qdev-monitor.c      | 6 +++---
> >  system/rtc.c               | 1 +
> >  system/runstate-hmp-cmds.c | 2 +-
> >  system/vl.c                | 6 +++---
> >  6 files changed, 10 insertions(+), 9 deletions(-)
> > 
> > diff --git a/system/rtc.c b/system/rtc.c
> > index 216d2aee3a..e3bc2095f9 100644
> > --- a/system/rtc.c
> > +++ b/system/rtc.c
> > @@ -25,6 +25,7 @@
> >  #include "qemu/osdep.h"
> >  #include "qemu/cutils.h"
> >  #include "qapi/error.h"
> > +#include "qapi/qmp/qerror.h"
> 
> Is this a typo?

Yes, a rebase mistake. This was originally present, but since
removed.

> 
> >  #include "qemu/error-report.h"
> >  #include "qemu/option.h"
> >  #include "qemu/timer.h"
> 
> Regards,
> Zhao
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


