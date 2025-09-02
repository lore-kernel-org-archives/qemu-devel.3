Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7342CA100B
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 16:49:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utUBS-0006Am-BT; Tue, 02 Sep 2025 12:48:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1utUAf-0005M1-7g
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 12:47:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1utUAc-0003AU-UV
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 12:47:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756831661;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=LKmxJZqjTbidDyYIUNjv/j1bo6SpfX4VvRt/BOyAjlI=;
 b=ONCGVnYVkYJNp5z2Xy74WJMoYM1YZe+ViwxQRYD5eoy285AKL3xaL8GNlXQ5VduuZcF2ZD
 nDifvKjNRYWIOE7Gktl2aBMYqWEF6rBBHKz9lGjYpEIdxTJqnJse9GDK3GFVnXkhPKFdsw
 EU8v5KAn7179kYBjwspt8uuXtWLSayU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-384-NKEPvodzOfuORd96JAttXQ-1; Tue,
 02 Sep 2025 12:47:36 -0400
X-MC-Unique: NKEPvodzOfuORd96JAttXQ-1
X-Mimecast-MFC-AGG-ID: NKEPvodzOfuORd96JAttXQ_1756831655
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0134B18004D4; Tue,  2 Sep 2025 16:47:35 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.12])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8FF401956086; Tue,  2 Sep 2025 16:47:33 +0000 (UTC)
Date: Tue, 2 Sep 2025 18:47:29 +0200
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [RFC 0/4] util: qmessage_context followup
Message-ID: <aLcfja_1X18qeoQN@redhat.com>
References: <20250902103010.309094-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250902103010.309094-1-richard.henderson@linaro.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Sep 02, 2025 at 12:30:06PM +0200, Richard Henderson wrote:
> Hi Daniel,
> 
> I'm still not keen on qmessage_context allocating a string.
> 
> If we *did* allocate a string, it should be a GString so that we can
> easily append to that.  The only benefit I see from this is that we
> would collect all of the output and it would reach stderr atomically.
> 
> However, I think it's better to not collect the message and just
> output the pieces.  Something like the following.  The names are
> horrible and I didn't document the patches well.

Thanks for the suggestion, I'll have a look and see about merging
this, or something like it, into my series for a new posting.

> 
> 
> r~
> 
> 
> Richard Henderson (4):
>   util: Introduce LogOutput
>   util: Drop QMESSAGE_CONTEXT_SKIP_MONITOR
>   util/message: Use LogOutput
>   util/error-report: Use LogOutput in vreport
> 
>  include/monitor/monitor.h |  4 +++
>  include/qemu/log-output.h | 14 ++++++++
>  include/qemu/message.h    | 21 +++--------
>  monitor/monitor.c         | 54 +++++++++++++++++++++++------
>  stubs/error-printf.c      | 11 ++++++
>  util/error-report.c       | 73 +++++++++++++++++++--------------------
>  util/log.c                | 23 +++++-------
>  util/message.c            | 45 ++++++++++--------------
>  8 files changed, 139 insertions(+), 106 deletions(-)
>  create mode 100644 include/qemu/log-output.h
> 
> -- 
> 2.43.0
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


