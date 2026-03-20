Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C6C41098782
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 12:59:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3ZRM-0000Z1-C1; Fri, 20 Mar 2026 08:59:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1w3ZRK-0000Ya-KC
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 08:58:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1w3ZRH-0003jt-Qs
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 08:58:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774011534;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=dNaHjMAb79y9Sv2tB5XUf+RShQ4AGA9fGzksAYGWbRA=;
 b=Twwgx5tckqTwWy8Zy0RMUcGwykUfaoociPwP+9xL7eYuOc/DGg9zWzYVcyAZW8hcs/tGpc
 xagS+NVWQD0eW0z6/g/7g+cGO8ERVlxQx+UoIald270DyMarzK5vEGtR9KqbxUlqanPfzA
 nnHBDspDI4Tj0gG0f/CV6ilPMnsu7Ns=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-518-Exbpen-NOsmE09y7AlXeDQ-1; Fri,
 20 Mar 2026 08:58:50 -0400
X-MC-Unique: Exbpen-NOsmE09y7AlXeDQ-1
X-Mimecast-MFC-AGG-ID: Exbpen-NOsmE09y7AlXeDQ_1774011530
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 03568195608A
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 12:58:50 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.255])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 60C131800351; Fri, 20 Mar 2026 12:58:48 +0000 (UTC)
Date: Fri, 20 Mar 2026 12:58:44 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Elizabeth Ashurov <eashurov@redhat.com>
Cc: qemu-devel@nongnu.org, kkostiuk@redhat.com, yvugenfi@redhat.com
Subject: Re: [PATCH v2 1/2] qga: replace slog() with standard GLib logging
Message-ID: <ab1EhBoyvM2YVftM@redhat.com>
References: <20260312141657.1701801-1-eashurov@redhat.com>
 <20260318154752.1880933-1-eashurov@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260318154752.1880933-1-eashurov@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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

On Wed, Mar 18, 2026 at 05:47:51PM +0200, Elizabeth Ashurov wrote:
> Replace qga-specific slog() calls with standard GLib logging APIs.
> Use g_info() for command execution messages and g_warning() for
> non-fatal failures, and remove the use of "syslog" as a log domain.
> 
> Rework ga_log() to route messages to the log file and
> syslog/Event Viewer, filtering by log level. Debug messages are
> excluded from syslog even with --debug.
> 
> - Default log level includes ERROR and CRITICAL
> - -v/--verbose enables WARNING, MESSAGE, and INFO

IMHO "WARNING" should be enabled by default too.

> - -g/--debug enables all levels including DEBUG

Since we can't use the natural '-d' short option, we can
probably do with only the the long option.

> 
> Signed-off-by: Elizabeth Ashurov <eashurov@redhat.com>
> ---
>  qga/commands-linux.c   |  6 ++---
>  qga/commands-posix.c   | 26 +++++++++---------
>  qga/commands-win32.c   | 60 +++++++++++++++++++++---------------------
>  qga/commands.c         | 29 ++++++--------------
>  qga/guest-agent-core.h |  1 -
>  qga/main.c             | 39 +++++++++++++++++++--------
>  6 files changed, 82 insertions(+), 79 deletions(-)


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


