Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01B00D0E6C9
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 08:27:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2nlD-0004i5-SZ; Mon, 21 Oct 2024 04:27:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t2nlC-0004hU-EN
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 04:27:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t2nlA-0004aM-R3
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 04:27:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729499248;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cXp0OcMFuLt5eev8vQ1rUvfnWtesgiHuMUGkG+sEkUA=;
 b=Rqs8nb/YqUeFKHw4qaxM6M0JBs3KejCcdDCs9FwzdLnDmgNdbjKGI/5t2Sd/wFQ9FyHb1D
 6EbI1egzRfgqSZNYk0xXadyejADy8yaiUt4Z5CnF1kN4zEVuWE9Z7vmZalQWJ9iRe9ZaOw
 fWNnjozDZ57+elgcaWku/dYoiWs+n6g=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-107-OfPYXmsbPPG6QAsfCcqFyA-1; Mon,
 21 Oct 2024 04:27:23 -0400
X-MC-Unique: OfPYXmsbPPG6QAsfCcqFyA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5811B19560A2; Mon, 21 Oct 2024 08:27:22 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.27])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EE7DF1956088; Mon, 21 Oct 2024 08:27:20 +0000 (UTC)
Date: Mon, 21 Oct 2024 09:27:17 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Dr. David Alan Gilbert" <dave@treblig.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] sockets: Remove deadcode
Message-ID: <ZxYQZUHmTRl-KN0w@redhat.com>
References: <20240918232633.463861-1-dave@treblig.org>
 <ZuwVLemC3hVirWGZ@redhat.com> <ZxOfuby9HY_nHqoB@gallifrey>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZxOfuby9HY_nHqoB@gallifrey>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.527,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.699,
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

On Sat, Oct 19, 2024 at 12:02:01PM +0000, Dr. David Alan Gilbert wrote:
> * Daniel P. Berrangé (berrange@redhat.com) wrote:
> > On Thu, Sep 19, 2024 at 12:26:33AM +0100, dave@treblig.org wrote:
> > > From: "Dr. David Alan Gilbert" <dave@treblig.org>
> > > 
> > > socket_remote_address hasn't been used since it was added in
> > >   17c55decec ("sockets: add helpers for creating SocketAddress from a socket")
> > > 
> > > inet_connect hasn't been used since 2017's
> > >   8ecc2f9eab ("sheepdog: Use SocketAddress and socket_connect()")
> > 
> > Excellent ! The more of sockets.h we can remove the better.
> > 
> > > 
> > > Remove them.
> > > 
> > > Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
> > > ---
> > >  include/qemu/sockets.h | 16 ----------------
> > >  util/qemu-sockets.c    | 35 -----------------------------------
> > >  2 files changed, 51 deletions(-)
> > 
> > Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> > 
> > and queued.
> 
> Hi Dan,
>   Just checking, I noticed this one and the crypto patch haven't made
> it to master yet.

Yeah, sorry, I still have them in a pending queue.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


