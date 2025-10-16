Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4096FCCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 20:01:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9U9b-0005qT-8X; Thu, 16 Oct 2025 16:00:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v9U9P-0005nu-3V
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 16:00:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v9U9I-0006dX-5G
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 16:00:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760644830;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2ptAYzZTByvIFXFSmnEJDlbalMqQ0HX0+OaeL5uN8yg=;
 b=M9c5rQLeFpx1+2j4B1YzAYYPpjmwag6NVlGwpVPdlckQqiG31n6+JhWWKOHZFM+tTIYGLe
 nyqa2uf7ODCsSEwHT+9IUr/i5h7uAytANEXW0C0EwYr7+OdZuZ+UhawJHtd2JR23yWXf/s
 +hmsPW2F90VLEvt5XELH5/lGqDoqBDI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-362-Ew8SxEQwMXOG9j52AF9y0A-1; Thu,
 16 Oct 2025 16:00:26 -0400
X-MC-Unique: Ew8SxEQwMXOG9j52AF9y0A-1
X-Mimecast-MFC-AGG-ID: Ew8SxEQwMXOG9j52AF9y0A_1760644825
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A212319560B8; Thu, 16 Oct 2025 20:00:24 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.46])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4795519560B4; Thu, 16 Oct 2025 20:00:18 +0000 (UTC)
Date: Thu, 16 Oct 2025 21:00:15 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 mst@redhat.com, jasowang@redhat.com, farosas@suse.de,
 sw@weilnetz.de, eblake@redhat.com, armbru@redhat.com,
 thuth@redhat.com, philmd@linaro.org, qemu-devel@nongnu.org,
 michael.roth@amd.com, steven.sistare@oracle.com, leiyang@redhat.com,
 davydov-max@yandex-team.ru, yc-core@yandex-team.ru,
 raphael.s.norwitz@gmail.com
Subject: Re: [PATCH v8 16/19] qapi: introduce backend-transfer migration
 parameter
Message-ID: <aPFOz8sb41ON8UHr@redhat.com>
References: <aO_ll4Lf0bq6vgdm@x1.local>
 <3b9f1da4-6264-45d4-ade1-a6273cc6fa1e@yandex-team.ru>
 <aO_--QWDJO7iOhR4@x1.local>
 <8c575b3a-7d1f-446d-8f6d-4b2e4b851731@yandex-team.ru>
 <aPCtkB-GvFNuqlHn@redhat.com>
 <29aa1d66-9fa7-4e44-b0e3-2ca26e77accf@yandex-team.ru>
 <aPE8Oo5D3oesB7sV@x1.local> <aPE-vmyg1mLDO4pf@redhat.com>
 <aPFFSVJ8iCn8zaSV@redhat.com> <aPFJ16QZ7m_7h_kM@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aPFJ16QZ7m_7h_kM@x1.local>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Thu, Oct 16, 2025 at 03:39:03PM -0400, Peter Xu wrote:
> On Thu, Oct 16, 2025 at 08:19:37PM +0100, Daniel P. Berrangé wrote:
> > On Thu, Oct 16, 2025 at 07:51:42PM +0100, Daniel P. Berrangé wrote:
> > > On Thu, Oct 16, 2025 at 02:40:58PM -0400, Peter Xu wrote:
> > > > On Thu, Oct 16, 2025 at 12:23:35PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> > > > > On 16.10.25 11:32, Daniel P. Berrangé wrote:
> > > > > > On Thu, Oct 16, 2025 at 12:02:45AM +0300, Vladimir Sementsov-Ogievskiy wrote:
> > > > > > > 1. Remote migration: we can't reuse backends (files, sockets, host devices), as
> > > > > > > we are moving to another host. So, we don't enable "backend-transfer". We don't
> > > > > > > transfer the backend, we have to initialize new backend on another host.
> > > > > > > 
> > > > > > > 2. Local migration to update QEMU, with minimal freeze-time and minimal
> > > > > > > extra actions: use "backend-transfer", exactly to keep the backends
> > > > > > > (vhost-user-server, TAP device in kernel, in-kernel vfio device state, etc)
> > > > > > > as is.
> > > > > > > 
> > > > > > > 3. Local migration, but we want to reconfigure some backend, or switch
> > > > > > > to another backend. We disable "backend-transfer" for one device.
> > > > > > 
> > > > > > This implies that you're changing 'backend-transfer' against the
> > > > > > device at time of each migration.
> > > > > > 
> > > > > > This takes us back to the situation we've had historically where the
> > > > > > behaviour of migration depends on global properties the mgmt app has
> > > > > > set prior to the 'migrate' command being run. We've just tried to get
> > > > > > away from that model by passing everything as parameters to the
> > > > > > migrate command, so I'm loathe to see us invent a new way to have
> > > > > > global state properties changing migration behaviour.
> > > > > > 
> > > > > > This 'backend-transfer' device property is not really a device property,
> > > > > > it is an indirect parameter to the 'migrate' command.
> > > > 
> > > > I was not seeing it like that.
> > > > 
> > > > I was treating per-device parameter to be a flag showing whether the device
> > > > is capable of passing over FDs, which is more like a device attribute.
> > 
> > Whether a backend is technically capable of transfer shouldn't require a
> > user specified property - there should be an internal API to query whether
> > the current backend configuration is transferrable or not, based on the
> > code implementation. Allowing a mgmt app to specify this can only lead
> > to mistakes, because they don't know the internal constraints of the
> > implementation.
> > 
> > The mgmt app should only be concerned with whether they want to transfer
> > a backend or not which is a time-of-use decision rather than launch time
> > decision.
> 
> IMHO the per-device property, when available, should always mean it fully
> support the feature, when it is turned ON.

That can't be expressed in a property in the device.

Consider the virtio-net device.  The backend transfer is only
possible of the virtio-net is associated with a netdev using
the vhost-user backend, and the vhost-user backend must be
using a chardev with a socket backend, and the socket backend
must not have TLS or websockets enabled.

Migratability of the backend requires an API against the
NetClientInfo object, which will in turn require calling
out to an API against the Chardv object.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


