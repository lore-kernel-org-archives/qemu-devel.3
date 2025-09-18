Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A9DACA1013
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 15:53:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzGwC-0006s3-Is; Thu, 18 Sep 2025 11:52:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uzGw9-0006rV-R3
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 11:52:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uzGw7-0006mi-Kk
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 11:52:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758210762;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J2SF7btJxVeohr0vewYvPCSWQbbVw+SiGQo4tYA5B6I=;
 b=EctAOWk+9e5iKmS7bnECaMzw9I8FcrzRhMuuSmuIufEtnveLz2dUK16bJcn+6hF8vsijHw
 DdTlKiop3XoZwmr8+vSmUyKXMZKI4oYWakFCHIFVni3PkKz10K9u39MCkjI59nqUqJt2+t
 xmcK7jejwvJjItHhw4viIMBgssLhG18=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-682-nH6pB2EkOIO8JDGCZt0tFQ-1; Thu,
 18 Sep 2025 11:52:35 -0400
X-MC-Unique: nH6pB2EkOIO8JDGCZt0tFQ-1
X-Mimecast-MFC-AGG-ID: nH6pB2EkOIO8JDGCZt0tFQ_1758210754
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1908918002C1; Thu, 18 Sep 2025 15:52:34 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.161])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 85C3319560BB; Thu, 18 Sep 2025 15:52:32 +0000 (UTC)
Date: Thu, 18 Sep 2025 16:52:29 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Juraj Marcin <jmarcin@redhat.com>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Jiri Denemark <jdenemar@redhat.com>
Subject: Re: [PATCH] migration: Apply migration specific keep-alive defaults
 to inet socket
Message-ID: <aMwqvbFzGlsX23C7@redhat.com>
References: <aMBDIwKDxTVrBJBQ@redhat.com> <aMCjGVUiM3MY-RM3@x1.local>
 <aMEkY3N9ITwH_Y8Z@redhat.com> <aMGpHBGth05JY2hl@x1.local>
 <aMPz0WFmstNmKBQc@redhat.com> <aMQ19NmgFkLs8jkA@x1.local>
 <aMhZn-fbq67WQX8u@redhat.com>
 <r2tnbymosv7kxj7h4x6mnrczy7jdn66voiodlakivovu7lhwv4@eudkicvqwefc>
 <aMwbAdKQLzLaf4Hd@redhat.com> <aMwg-ROjbDL_z_EM@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aMwg-ROjbDL_z_EM@x1.local>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.005,
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

On Thu, Sep 18, 2025 at 11:10:49AM -0400, Peter Xu wrote:
> On Thu, Sep 18, 2025 at 03:45:21PM +0100, Daniel P. Berrangé wrote:
> > There needs to be a way to initiate post-copy recovery regardless
> > of whether we've hit a keepalive timeout. Especially if we can
> > see one QEMU in postcopy-paused, but not the other side, it
> > doesn't appear to make sense to block the recovery process.
> > 
> > The virDomainJobCancel command can do a migrate-cancel on the
> > src, but it didn't look like we could do the same on the dst.
> > Unless I've overlooked something, Libvirt needs to gain a way
> > to explicitly force both sides into the postcopy-paused state,
> > and thus be able to immediately initiate recovery.
> 
> Right, if libvirt can do that then problem should have been solved too.
> 
> > I'm fine with turning on keepalives on the socket, but IMHO the
> > out of the box behaviour should be to honour the kernel default
> > tunables unless the admin decides they want different behaviour.
> > I'm not seeing a rational for why the kernel defaults should be
> > forceably overridden in QEMU out of the box.
> 
> IMHO the rational here is that the socket here is in a special state and
> for special purpose. So we're not trying to change anything globally for
> qemu (without knowing what the socket is), but only this specific type of
> socket that is used for either precopy or postcopy live migrations.
> 
> It's special because it's always safe to have a more aggresive
> disconnection, and might be preferred versus very lengthy hangs (if
> assuming libvirt doesn't yet have way to stop the hang), especially for a
> postcopy phase.

I've already described up-thread that it is not guaranteed safe to
have aggressive disconnection. It is often safe, but there is
definitely non-negligible risk in prematurely terminating a migration
connection.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


