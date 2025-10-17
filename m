Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E102CCD1A4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 08:51:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9gAb-0001O9-Gp; Fri, 17 Oct 2025 04:50:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v9gAa-0001Ns-00
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 04:50:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v9gAT-0006AY-EP
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 04:50:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760691026;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sdmQ1CrMc7SegT8Utgk9OT5+nn7sWJi9aEv+cLB+b+E=;
 b=XLU0Tr8I/Tk5lq9cqzSyqXq3sPgPeNF2uPlyh0p6nxFgVeDsLW3DcvaoBaEZ74A+aFBVzL
 q/cxhQvKxCd8tLAN3llkbDdu2pzbIPfaN9dkILFGyrQLxja/abNj5QgkX2rxnkm8ksgQv1
 yfYPBqvM4wg5oNrZAUZ9bkFd6cVnP2A=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-351-9yuE5gOwPBqtM4zPLKN3Sw-1; Fri,
 17 Oct 2025 04:50:25 -0400
X-MC-Unique: 9yuE5gOwPBqtM4zPLKN3Sw-1
X-Mimecast-MFC-AGG-ID: 9yuE5gOwPBqtM4zPLKN3Sw_1760691023
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 15B4918002C9; Fri, 17 Oct 2025 08:50:23 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.139])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 47C0130001BC; Fri, 17 Oct 2025 08:50:16 +0000 (UTC)
Date: Fri, 17 Oct 2025 09:50:13 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: Peter Xu <peterx@redhat.com>, mst@redhat.com, jasowang@redhat.com,
 farosas@suse.de, sw@weilnetz.de, eblake@redhat.com,
 armbru@redhat.com, thuth@redhat.com, philmd@linaro.org,
 qemu-devel@nongnu.org, michael.roth@amd.com,
 steven.sistare@oracle.com, leiyang@redhat.com,
 davydov-max@yandex-team.ru, yc-core@yandex-team.ru,
 raphael.s.norwitz@gmail.com
Subject: Re: [PATCH v8 16/19] qapi: introduce backend-transfer migration
 parameter
Message-ID: <aPIDRft9RqtGvdVf@redhat.com>
References: <8c575b3a-7d1f-446d-8f6d-4b2e4b851731@yandex-team.ru>
 <aPCtkB-GvFNuqlHn@redhat.com>
 <29aa1d66-9fa7-4e44-b0e3-2ca26e77accf@yandex-team.ru>
 <aPE8Oo5D3oesB7sV@x1.local> <aPE-vmyg1mLDO4pf@redhat.com>
 <aPFHl3VWV0pCmzd1@x1.local> <aPFOHjl5BoWEMqSL@redhat.com>
 <aPFVWi1pwxS8yGay@x1.local> <aPH557l6YnXT-3r8@redhat.com>
 <7b6ad405-0dbe-41d7-8d29-e3e92d969647@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7b6ad405-0dbe-41d7-8d29-e3e92d969647@yandex-team.ru>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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

On Fri, Oct 17, 2025 at 11:26:59AM +0300, Vladimir Sementsov-Ogievskiy wrote:
> On 17.10.25 11:10, Daniel P. Berrangé wrote:
> > > Meanwhile, the admin will need to manage the list of devices even if the
> > > admin doesn't really needed to, IMHO.
> > We shouldn't need to list devices in every scenario.
> 
> Do you mean, we may make union,
> 
>    backend-transfer = true | false | [list of IDs]
> 
> Where true means, enable backend-transfer for all supporting devices?
> So that normally, we'll not list all devices, but just set it to true?

Well I was thinking separate parameters

   backend-transfer: bool
   backend-transfer-devices: [str]   (optional list of IDs)

but it amounts to the same thing

> But this way, migration will fail, if target version doesn't support
> backend-transfer for some of used devices, or support for some
> another, where source lack the support. So that's a way to create a
> situation, where two QEMUs, with same device options, same machine
> types, same configurations and same migration parameters / capabilities
> define incompatible migration states..

It is worse - the backend on both sides may support transfer,
but may none the less be incompatible due to changed configuration,
so this needs mgmt app input too.

The challenge we have is that whether or not a backend supports
transfer requires fairly detailed know of QEMU and the specific
configuration of the backend. It is pretty undesirable for mgmt
apps to have to that knowledge, as the matrix of possibilities
is quite large and liable to change over time.

If we consider 'backend transfer' to be a performance optimization,
then really we want QEMU to "do the right thing" as much as is
possible.

Source and dst QEMUs don't have a bi-directional channel though,
so they can't negotiate the common subset of backends they both
support - it'll need help from the mgmt app.

One possibility is a new QMP command "query-migratable-backends"
which lists all device IDs, whose current backend configuration
is reporting the ability to transfer state. The mgmt app could
run that on both sides of the migration, take the intersection
of the two lists, and then further subtract any devices where
it has delibrately changed the backend configuration on the dst.

If we had that, then we could always pass the ID list to the
migrate command, while also avoiding hardcoding knowledge of
QEMU backend impl details - it would largely "just work".

> > We need to focus on
> > the internal API design. We need to have suitable APIs exposed by backends
> > to allow us to query migratability and process vmstate a mere property
> > 'backend-transfer' is insufficient, whether set by QEMU code, or set by
> > the mgmt app.
> > 
> > If we have proper APIs each device should be able to query whether its
> > backend can be transferred, and so "do the right thing" if backend
> > transfer is requested by migration. The ability to list devices in the
> > migrate command is only needed to be able to exclude some backends if
> > the purpose of migration is to change a backend

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


