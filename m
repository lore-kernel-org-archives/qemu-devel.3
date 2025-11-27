Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2E79D111A8
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Nov 2025 20:52:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOixk-0007mc-Qf; Thu, 27 Nov 2025 15:51:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vOixh-0007iF-OI
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 15:51:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vOixf-0001Hq-8l
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 15:51:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764276689;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=DHQczyzjMq0+M5d+QTbLjM2DkWsIDlvNPLfY2lpmnI0=;
 b=cdyBcBhNSksAc2XJTPBGNoMsstgMn3B/4Q/jLQ1/VY3/zOWHdIxRErGjxYxm8NuojIzA/H
 BqQWNqBMH1t5dZ0XZhYzhYBGZQah3wezczdQaF1mTpWEH7cVma2IMtGOTB7E85bp5ZqiPT
 Zjz6MdQGEVLzEaKhLKqJiGEsYD8+JGo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-635-FrZtIdeBOc2wc2gHQBhEnQ-1; Thu,
 27 Nov 2025 15:51:26 -0500
X-MC-Unique: FrZtIdeBOc2wc2gHQBhEnQ-1
X-Mimecast-MFC-AGG-ID: FrZtIdeBOc2wc2gHQBhEnQ_1764276685
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 26F15195608F; Thu, 27 Nov 2025 20:51:25 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.2])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7198E195608E; Thu, 27 Nov 2025 20:51:21 +0000 (UTC)
Date: Thu, 27 Nov 2025 20:51:18 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: dave@treblig.org, armbru@redhat.com, pbonzini@redhat.com,
 marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH for-11.0 0/5] some improvements around error reporting
Message-ID: <aSi5xrJrlI9W_MJk@redhat.com>
References: <20251127173352.283731-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251127173352.283731-1-vsementsov@yandex-team.ru>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.224,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Nov 27, 2025 at 08:33:47PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> Hi all. The main thing I wanted to do is to enable timestamps
> for errer_report() and friends when QMP monitor is active.
> Analyzing logs without timestamps is painful.
> 
> And some enhancements here and there around.

This is significantly overlapping  with what I've been working on here:

  https://lists.nongnu.org/archive/html/qemu-devel/2025-09/msg05222.html

I had to pause that temporarily but intend to post a v5 for 11.0 dev
cycle

> 
> Vladimir Sementsov-Ogievskiy (5):
>   ui/vnc: don't use of error_printf_unless_qmp()
>   monitor: remove unused error_printf_unless_qmp() function
>   monitor: rework monitor_cur_is_qmp() into monitor_cur_is_hmp()
>   error: print error_report timestamp when QMP monitor is active
>   error-report: fix doc for vreport()
> 
>  include/monitor/monitor.h      |  5 +----
>  monitor/monitor.c              | 30 +++---------------------------
>  stubs/error-printf.c           |  5 -----
>  stubs/monitor-core.c           |  5 +++++
>  tests/unit/test-util-sockets.c |  1 +
>  ui/vnc.c                       |  9 ++++-----
>  util/error-report.c            | 25 +++++++++++++++----------
>  7 files changed, 29 insertions(+), 51 deletions(-)
> 
> -- 
> 2.48.1
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


