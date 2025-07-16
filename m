Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30BB3C83F1B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 15:50:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uc4Nu-00076B-A8; Wed, 16 Jul 2025 11:49:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uc4Nq-00071n-FA
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 11:49:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uc4Nm-0007m9-Gw
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 11:49:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752680961;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nVeVqgls8GgsVpcARq8KOp2YG2xHU0vsaAX/fq1PIZg=;
 b=BHCJea/S+OgoTfa4ItOt/G7ApqI8Ex7rk8DjCYFZ+2x/6qclZhBvTpKcrM328/dEj9+LMw
 JkGU9VGBeRM8xox5Cvr4YHPaIBBV9KO6pDT6apsqxuGbFks5VjCNrbRR/sCX4krxqVON5X
 8ndUPRpvFKzpepmiayt/6yzTN/2iULA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-645-mx_4n2qZNEChaUkJ-LOpmQ-1; Wed,
 16 Jul 2025 11:49:19 -0400
X-MC-Unique: mx_4n2qZNEChaUkJ-LOpmQ-1
X-Mimecast-MFC-AGG-ID: mx_4n2qZNEChaUkJ-LOpmQ_1752680958
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BC41D195608A; Wed, 16 Jul 2025 15:49:16 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.68])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A90E21954214; Wed, 16 Jul 2025 15:49:12 +0000 (UTC)
Date: Wed, 16 Jul 2025 16:49:07 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: marcandre.lureau@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 qemu-stable <qemu-stable@nongnu.org>
Subject: Re: [PULL v2 01/13] ui/vnc: Do not copy z_stream
Message-ID: <aHfJ84oz0a20vhgo@redhat.com>
References: <20250715063301.145191-1-marcandre.lureau@redhat.com>
 <20250715063301.145191-2-marcandre.lureau@redhat.com>
 <a400f4f4-b811-4043-8dea-4a301567b7fc@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a400f4f4-b811-4043-8dea-4a301567b7fc@tls.msk.ru>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Jul 16, 2025 at 06:07:31PM +0300, Michael Tokarev wrote:
> On 15.07.2025 09:32, marcandre.lureau@redhat.com wrote:
> > From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> > 
> > vnc_worker_thread_loop() copies z_stream stored in its local VncState to
> > the persistent VncState, and the copied one is freed with deflateEnd()
> > later. However, deflateEnd() refuses to operate with a copied z_stream
> > and returns Z_STREAM_ERROR, leaking the allocated memory.
> > 
> > Avoid copying the zlib state to fix the memory leak.
> > 
> > Fixes: bd023f953e5e ("vnc: threaded VNC server")
> > Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> > Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> > Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> > Message-Id: <20250603-zlib-v3-1-20b857bd8d05@rsg.ci.i.u-tokyo.ac.jp>
> > ---
> >   ui/vnc.h          |  2 +-
> >   ui/vnc-enc-zlib.c | 30 +++++++++++++++---------------
> >   ui/vnc.c          | 13 ++++++++++---
> >   3 files changed, 26 insertions(+), 19 deletions(-)
> 
> This looks like a qemu-stable material, is it not?

Yes, please cherry-pick this.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


