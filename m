Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B47FCDB46F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 10:08:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wby33-0008PT-KF; Tue, 23 Jun 2026 06:08:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wby32-0008PK-Ap
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 06:08:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wby30-0005s9-GM
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 06:08:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782209281;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ANUkaGBxR1+gtz+M3qA/Frzu8wpnPBwtnDLcFXwJ64E=;
 b=f+kFp2OziwAaSuLLsla+CbnDYeW3Zp85AXZ99PEvjHMh2RqylJO7bEn16wIri4h60DUsqA
 zP1hewEv+CEF+LyVxK/kYqtoHfjkz65wL6F1Su192fzt0OYg8bPZr8z3juBJ+h/UTIm+Nr
 orU7h4KVOvvFk7k6zpYIKiw/52oUajE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-650-Uz5nBzSjN5aScWfBJZqQNw-1; Tue,
 23 Jun 2026 06:07:58 -0400
X-MC-Unique: Uz5nBzSjN5aScWfBJZqQNw-1
X-Mimecast-MFC-AGG-ID: Uz5nBzSjN5aScWfBJZqQNw_1782209277
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D80311955F14; Tue, 23 Jun 2026 10:07:55 +0000 (UTC)
Received: from redhat.com (unknown [10.44.34.133])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 29A9B1956041; Tue, 23 Jun 2026 10:07:49 +0000 (UTC)
Date: Tue, 23 Jun 2026 11:07:46 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Xu <peterx@redhat.com>,
 =?utf-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Aurelien Jarno <aurelien@aurel32.net>, Fabiano Rosas <farosas@suse.de>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [RFC 4/7] system: add memory_region_new / memory_region_new_io
Message-ID: <ajpa8kO1bfIhbNAw@redhat.com>
References: <20260616155554.264412-1-berrange@redhat.com>
 <20260616155554.264412-5-berrange@redhat.com>
 <aa4d417e-2e61-44ef-a695-31bc19dbafd1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aa4d417e-2e61-44ef-a695-31bc19dbafd1@redhat.com>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, Jun 17, 2026 at 02:49:57PM +0200, Paolo Bonzini wrote:
> On 6/16/26 17:55, Daniel P. Berrangé wrote:
> > Prepare for the move to dynamically allocated memory regions by
> > introducing memory_region_new and memory_region_new_io functions
> > which call through to object_new instead of object_initialize.
> > 
> > TBD: add "new" variants for all the other memory_region_init
> > variants.
> > 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> 
> Zoltan already proposed this, but I really think it's a bad idea.
> 
> MemoryRegionOps callback will certainly access fields in the parent. Having
> a separate object gives you no benefit because you still have the same
> use-after-free if the MemoryRegion outlives the device.  Likewise for buses.

I see the opposite rationale.  We needlessly have two ways of
allocating QOM objects. The embedding does not magically keep
the child object alive, and it introduces confusion and unexpected
behaviour as ref counts don't work.

> For buses, the fact that the parent and child live at the same time is
> explicitly tracked with mutual refcount and unparent.

If we get mutual ref counting correct, then there is not benefit
to having 2 different ways of allocating QOM objects. We should
eliminate the embedding as pointless extra complexity and focus
on getting ref counting done correctly.

>                                                      If it's not, we have
> the hack that Akihiko mentioned
> (https://lists.gnu.org/archive/html/qemu-devel/2026-06/msg03459.html):

That hack is too gross. 

> > However, this is insufficient to avoid calling object_ref() for all
> > embedded objects. For example, consider an embedded Device that has a
> > MemoryRegion. When referencing a MemoryRegion for guest memory access,
> > QEMU automatically references the owning Device to keep the MemoryRegion
> > alive. However, that reference is ineffective if the Device itself is
> > embedded, because object_ref() does not keep the containing storage
> > alive.
> 
> If the device itself is embedded, then all the invariants must hold
> recursively:
> 
> - the device must be kept alive by mutual references between the device
> itself and its parent;
> 
> - unparent for the device should wait for all guest memory accesses to be
> either completed or cancelled.
> 
> So, the problem is that "QEMU automatically references the owning Device to
> keep the MemoryRegion alive" is a hack that should die.  I added it, mea
> culpa.
> 
> The model is that if it makes sense to have B outlive A, you use new. If it
> doesn't, you use init.  For MemoryRegions or anything that has callbacks, it
> makes no sense to outlive the implementor of the callbacks.  There are
> exceptions if the number of objects is dynamic but they're very rare.
> 
> I agree that there's extra complexity added by embedding; but I disagree
> that removing embedding will fix any bugs, and because it will hide a
> relationship between objects, I believe the complexity is not accidental.

The relationship between objects does not need to be expressed with
embedding one inside another struct. This should be represented at
the class level with properties for the child relationships, which
would give us introspection via QMP too.  The embedding isn't adding
any real value IMHO.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


