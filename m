Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B7EAD41D59
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 15:27:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTiZ8-0006FJ-1A; Thu, 11 Dec 2025 10:26:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vTiZ4-0006F2-2j
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 10:26:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vTiZ2-0005jb-Fp
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 10:26:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765466803;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=48UBrxOnHOIP/5uXpaqMxO+n46gvG40qT2l12FGAC2c=;
 b=FM9OKorX601oepsN6mZ1MBGydkjnnBnTDiluGc2BTX99Zj6zHcg2I1/BKRq5XsyE8Zyk4s
 2zQrRrhJdv6mFiJJLKmJYF+gLWokScu2eHCRp6BbRiRNAkZfpkwf/xPVpHnQxzXWJ8oAzb
 EjePm2c3TplSWiBZKEFN59DK2zehcyU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-67-xmymjUsDOMSdNZybxQnqrg-1; Thu,
 11 Dec 2025 10:26:39 -0500
X-MC-Unique: xmymjUsDOMSdNZybxQnqrg-1
X-Mimecast-MFC-AGG-ID: xmymjUsDOMSdNZybxQnqrg_1765466797
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B9EED19775A8; Thu, 11 Dec 2025 15:26:23 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.60])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E3C2D1800451; Thu, 11 Dec 2025 15:26:16 +0000 (UTC)
Date: Thu, 11 Dec 2025 15:26:13 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Juraj Marcin <jmarcin@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH RFC 00/10] QOM: Introduce OBJECT_COMPAT class
Message-ID: <aTricLooEPFJqZhe@redhat.com>
References: <20251209162857.857593-1-peterx@redhat.com>
 <aTlZIlgB20OpdSEl@redhat.com> <aTle5C2pN8ZslZX7@redhat.com>
 <aTmdJ5H67mk8qmSC@x1.local> <aTqTcM9zsGpW-F45@redhat.com>
 <aTrenNP7Vq4XO2DP@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aTrenNP7Vq4XO2DP@x1.local>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, Dec 11, 2025 at 10:09:16AM -0500, Peter Xu wrote:
> On Thu, Dec 11, 2025 at 09:48:32AM +0000, Daniel P. Berrangé wrote:
> > The appealing thing about machine types is that it is an opaque
> > collection of properties. The mgmt app does not need to know about
> > any of the properties being set, it can just let the machine type
> > do its magic.
> > 
> > Probing values for individual features which are supported on a host
> > means mgmt apps need to be made aware of all the properties that are
> > affected, and keep track of them for the life of the VM. This is a
> > significantly higher burden for the mgmt app to deal with that the
> > opaque collection machine types define, especially because apps won't
> > know ahead of time which objects/properties might need this facility
> > in future.
> 
> Yes, exactly.
> 
> IMHO we may still need "probing" of host features at some point, but we do
> have two completely different way to stable the guest ABI:
> 
>   (a) Machine types (like now)
>   (b) "probing" + "QMP set()s"
> 
> Here "QMP set()s" can be QMP updating a property of an object, or something
> like what Vladimir proposed in the other virtio-net/tap series, via a
> separate new QMP command.
> 
> Solution (b) has a major benefit of high flexibility - we do not need
> machine type versioning anymore (hence, we still need "q35", but not
> "q35-X.Y" etc.), because any QEMU can likely migrate to almost any QEMU:
> mgmt will probe both sides and apply mini subset for both sides, no matter
> how old it was.
> 
> To pay that off, mgmt needs to know every single trivial detail of QEMU
> change on every single device to make migration work.  When new things
> introduced to QEMU, it must be OFF, then mgmt turns it on until probing
> both sides have it.
> 
> That makes solution (b) less appealing.
> 
> The other thing is, since we stick with solution (a) for all these years,
> IMHO we should either stick with it, or if we really think (b) is better we
> should gradually obsolete (a) and use (b) all over.  I just don't see it
> coming, though.. as (a) is still working almost perfect - it enables
> feature slower only until a new machine type used (normally means a VM cold
> reboot), but it hides too many trivial details mgmt doesn't need to care,
> hence much less work needed.
> 
> IMHO we should be careful on making both (a)+(b) available (again, for (b)
> the probing is still fine, it's about offloading things to mgmt to set()
> via QMPs).  If so, it likely implies we didn't think all things through.

I don't believe that probing could ever be a placement for (a). Determining
what you want to use is not a decision that can be made in isolation of
the current host. You need to know the capabilities of hosts that you
intend to be able to migrate to.

Machine type versions facilitate this as an admin can express the
compatibility constraint in terms of this high level opaque definition,
and not have to understand 100's of properties and their supportability
across many hosts.

The same applies to non-guest host compatibility settings. I might be
runing on a RHEL-9.6 host, but I want to have compatibility with any
RHEL-9.2 host or newer. I can't probe QEMU on the 9.6 host to determine
what is acceptable for 9.2. We need to be able to express that cross
host compatibility as an admin, without having to list a huge set of
individual properties.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


