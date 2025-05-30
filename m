Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 547CAC5B549
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 10:14:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKwkD-00069s-4a; Fri, 30 May 2025 06:13:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uKwkA-00069J-Al
 for qemu-devel@nongnu.org; Fri, 30 May 2025 06:13:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uKwk7-00012c-4D
 for qemu-devel@nongnu.org; Fri, 30 May 2025 06:13:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748600018;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S+/OYNGGuhonnz2htV5sktCCYBUtqpcXVuH372MH+es=;
 b=QG/42QNuEx28ac/r+g4X87x9qrNrzDtgP0afs+N2QNLBGcHpOgpjwHef0pf2aR/irf+jH6
 pmI3NzT2lYj9Wmn5CEFZtuN6NmyDp0THxOKRcigCISq01gkw8aGlbTAINIWvMM5H+x+/9c
 KcoGIR8qq0lkXacLhQ00meajj0ff2Vs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-136-yO4hMGW_N56rq0yc8Y1iTw-1; Fri,
 30 May 2025 06:13:35 -0400
X-MC-Unique: yO4hMGW_N56rq0yc8Y1iTw-1
X-Mimecast-MFC-AGG-ID: yO4hMGW_N56rq0yc8Y1iTw_1748600014
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 432051800366; Fri, 30 May 2025 10:13:33 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.173])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 14E1B30001B7; Fri, 30 May 2025 10:13:29 +0000 (UTC)
Date: Fri, 30 May 2025 11:13:26 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-stable <qemu-stable@nongnu.org>
Subject: Re: [PATCH v2 0/3] ui/vnc: fix some endian problems
Message-ID: <aDmExrPVuuwSfZHA@redhat.com>
References: <20250514111931.1711390-1-berrange@redhat.com>
 <3371b5fc-80ad-4873-b914-21e8af9690fe@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3371b5fc-80ad-4873-b914-21e8af9690fe@tls.msk.ru>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.902,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Sat, May 24, 2025 at 01:32:45PM +0300, Michael Tokarev wrote:
> On 14.05.2025 14:19, Daniel P. Berrangé wrote:
> > This fixes some edge cases in endian handling in the VNC server. These
> > bugs are rarely going to be visible by default, since most servers will
> > negotiate encoding formats / framebuffer formats that avoid hitting
> > the problem scenarios.
> > 
> > In v2:
> > 
> >   - Rename 'client_bo' to 'client_endian' for reviewer clarity
> >   - Rename 'native' to 'native_endian' for code consistency
> > 
> > Daniel P. Berrangé (3):
> >    ui/vnc.c: replace big endian flag with byte order value
> >    ui/vnc: take account of client byte order in pixman format
> >    ui/vnc: fix tight palette pixel encoding for 8/16-bpp formats
> 
> Hi!
> 
> Is there anything in there which is relevant for qemu-stable?

I've not seen anyone raise these issues, since basically every serious
VNC client supports 'tight' encoding and it is very rare to run anything
other than true colour mode these days.

None the less these are clear bug fixes, so valid to pull all three
patches into stable if desired.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


