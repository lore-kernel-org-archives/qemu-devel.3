Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3942EC5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:41:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu8ho-0007KG-0Y; Wed, 12 Aug 2026 09:09:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wu8hb-0006PU-NQ
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 09:09:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wu8hZ-0005cI-Ll
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 09:09:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786540140;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I9w4Xuan0B19KVpqRZ4Yd3iVY5QkM7GXn0KI61qRHVE=;
 b=RmAwmSFR80pVwaBYavXHmE7Nswp3+k/NBcF3bGojTUO3OMCajbdQ9wpIshhjio4DU/wEkS
 ywr+aJ5vW+4FwQW3/mXqcoc1S79EiEfBG0NToiMHNTT9OYZ92SCOmX0JPnVEYGJ0Ub3uSm
 hqQ7pDmAArDzioHuueaVcp9W7VN79gU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-41-_wBAiVTyMU6_zB0eHC0MHQ-1; Wed,
 12 Aug 2026 09:08:46 -0400
X-MC-Unique: _wBAiVTyMU6_zB0eHC0MHQ-1
X-Mimecast-MFC-AGG-ID: _wBAiVTyMU6_zB0eHC0MHQ_1786540125
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 881B919560AE; Wed, 12 Aug 2026 13:08:45 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EE70F1800348; Wed, 12 Aug 2026 13:08:43 +0000 (UTC)
Date: Wed, 12 Aug 2026 14:08:40 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Juraj Marcin <jmarcin@redhat.com>, Feifan Qian <bea1e@proton.me>
Subject: Re: [PATCH v3] migration: Fix rare hang of
 migration_channel_read_peek()
Message-ID: <anxwWIvC8Xkk9bOm@redhat.com>
References: <20260812124327.2572363-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260812124327.2572363-1-peterx@redhat.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
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

On Wed, Aug 12, 2026 at 08:43:27AM -0400, Peter Xu wrote:
> In an unlikely case, when a migration stream is attached to the destination
> QEMU and only send <4 bytes to the channel as magic, it's possible that
> migration_channel_read_peek() may spin forever.
> 
> Fix it by adding a manual sleep for partial read.
> 
> Since the path isn't attached to a coroutine, it means when partial read
> happens, there's yet not much we can do but hang the main thread, it will
> happen even for len==0 case.  It means monitors can hang due to this,
> either partial read or no data arrived (but connection established).
> 
> Leave this for later, the hope is this is extremely rare in production.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3889
> Reported-by: Feifan Qian <bea1e@proton.me>
> Cc: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/channel.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


