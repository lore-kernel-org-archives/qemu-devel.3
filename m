Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F805CAC59A
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 14:46:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzFt9-0002Qo-MQ; Thu, 18 Sep 2025 10:45:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uzFt7-0002Q8-O5
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 10:45:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uzFt5-00052p-S0
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 10:45:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758206730;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=GccWsFP/YkEObU3YQe5mvdiRyi2djt3zw64iO9qxNsU=;
 b=Fgf6Ig8eKyuoBwftDLRF5mbwvIiXQf/dNhmm61bWNxdwXLopWF48Ze7M9e5TeuuNT67eas
 yIDH+KLlPTyI3C0e97Ech9vBEBtJKCqFFuLEpSX1SUgc8pqur/Ahc/+HJBNCT2qZ5VdIYa
 NETUX0hXza9SJa0+EFzVUOI46/H2jNQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-587-AaGCM-ddMQCpM_hDUJPq8Q-1; Thu,
 18 Sep 2025 10:45:27 -0400
X-MC-Unique: AaGCM-ddMQCpM_hDUJPq8Q-1
X-Mimecast-MFC-AGG-ID: AaGCM-ddMQCpM_hDUJPq8Q_1758206726
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 484E31955D77; Thu, 18 Sep 2025 14:45:26 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.161])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 54ABC1800447; Thu, 18 Sep 2025 14:45:24 +0000 (UTC)
Date: Thu, 18 Sep 2025 15:45:21 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Juraj Marcin <jmarcin@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Jiri Denemark <jdenemar@redhat.com>
Subject: Re: [PATCH] migration: Apply migration specific keep-alive defaults
 to inet socket
Message-ID: <aMwbAdKQLzLaf4Hd@redhat.com>
References: <20250909150127.1494626-1-jmarcin@redhat.com>
 <aMBDIwKDxTVrBJBQ@redhat.com> <aMCjGVUiM3MY-RM3@x1.local>
 <aMEkY3N9ITwH_Y8Z@redhat.com> <aMGpHBGth05JY2hl@x1.local>
 <aMPz0WFmstNmKBQc@redhat.com> <aMQ19NmgFkLs8jkA@x1.local>
 <aMhZn-fbq67WQX8u@redhat.com>
 <r2tnbymosv7kxj7h4x6mnrczy7jdn66voiodlakivovu7lhwv4@eudkicvqwefc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <r2tnbymosv7kxj7h4x6mnrczy7jdn66voiodlakivovu7lhwv4@eudkicvqwefc>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.005,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Sep 18, 2025 at 04:16:56PM +0200, Juraj Marcin wrote:
> If there is no outgoing traffic from the destination side (this can be
> caused for example by a workload with no page faults or paused machine),
> QEMU has no way of knowing if the connection is still working or not.
> The TCP stack doesn't treat no incoming traffic as a sign of a broken
> connection. Therefore, QEMU would stay in postcopy-active waiting for
> pages indefinitely.
> 
> Also, libvirt might not be aware of a connection dropout between QEMUs,
> if libvirt's connection is intact, especially if libvirt daemons are
> communicating through some central entity that is managing the migration
> and not directly. And to do postcopy migration recovery, libvirt needs
> both sides to be in postcopy-paused state.

Whether keepalive timeouts are at the QEMU level or global kernel
level, there will always be situations where the timeouts are too
long. Apps/admins can have out of band liveliness checks between
hosts that detect a problem before the keepalives will trigger
and shouldn't have to wait to recover migration, once they have
resolved the underlying network issue.

There needs to be a way to initiate post-copy recovery regardless
of whether we've hit a keepalive timeout. Especially if we can
see one QEMU in postcopy-paused, but not the other side, it
doesn't appear to make sense to block the recovery process.

The virDomainJobCancel command can do a migrate-cancel on the
src, but it didn't look like we could do the same on the dst.
Unless I've overlooked something, Libvirt needs to gain a way
to explicitly force both sides into the postcopy-paused state,
and thus be able to immediately initiate recovery.

> Alternatively, there also might be an issue with the connection between
> libvirt daemons, but not the migration connection. Even if the libvirt
> connection fails, the migration is not paused, rather libvirt lets the
> migration finish normally. Similarly, if the libvirt connection is
> broken up due to, for example, libvirt daemon restart, the ongoing
> migration is not paused, but after the libvirt daemon starts again, it
> sees an ongoing migration and lets it finish.

Whole this is a reliability issue for libvirt, this doesn't have
any bearing on migration keepalive timeouts, as we're only concerned
about QEMU connections.

> Additionally, libvirt uses its own internal keep-alive packets with much
> more aggressive timeouts, waiting 5 - 10 seconds idle before sending a
> keep-alive packet and then killing the connection if there is no
> response in 30 seconds.

Yep, this keepalive is very aggressive and has frequently caused
problems with libvirt connections being torn down inappropriately.
We get away with that because most libvirt APIs don't need to have
persistent state over the duration of a connection. The migration
APIs are there area where this isn't true, and the keepalives on
libvirt conmnections have resulted in us breaking otherwise still
functional migrations. IOW, I wouldn't point to libvirt as an
illustration of keepalives being free of significant downsides.

> I think, if we enable keep-alive in QEMU, but let the default timeouts
> be longer, for example idle time of 5 minutes and 15 retries in 1 minute
> intervals (which would mean, that connection would be considered broken
> after 20 minutes of unsuccessful communication attempts), that would be
> an acceptable solution.

I'm fine with turning on keepalives on the socket, but IMHO the
out of the box behaviour should be to honour the kernel default
tunables unless the admin decides they want different behaviour.
I'm not seeing a rational for why the kernel defaults should be
forceably overridden in QEMU out of the box.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


