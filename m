Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7C05CCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 11:00:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDhQX-0006au-QZ; Tue, 28 Oct 2025 06:59:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vDhQV-0006XM-VO
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 06:59:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vDhQP-0007Eh-AH
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 06:59:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761649173;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=D0y7+yRmrUBKB9I70LkodNrHLtl7Y6VyZpXN7BqG3yc=;
 b=KMplcjS5p8Tp9bYHpDkE8ob1L4WcvaskRx3yd0tWlxJY33k9gANmb9HW7wmmPMy4379GL4
 yNn8+7wJ0owCxL50VubJJe7uML+/mPaaN+a8ErphrcE6ijW8gttaxR8u+i59O5mbneO9NI
 cz5/D8IxhStu57ox21Jk9gpkIK21EUw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-675-jWYyvOjNOiOyoJVBIcwdUg-1; Tue,
 28 Oct 2025 06:59:30 -0400
X-MC-Unique: jWYyvOjNOiOyoJVBIcwdUg-1
X-Mimecast-MFC-AGG-ID: jWYyvOjNOiOyoJVBIcwdUg_1761649169
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C70E21800345; Tue, 28 Oct 2025 10:59:28 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.86])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 55DEA30001BF; Tue, 28 Oct 2025 10:59:26 +0000 (UTC)
Date: Tue, 28 Oct 2025 10:59:22 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 marcandre.lureau@redhat.com, eduardo@habkost.net, philmd@linaro.org
Subject: Re: [PATCH 2/3] qdev: Fix "info qtree" to show links
Message-ID: <aQCiCi5wsBA4Jq5V@redhat.com>
References: <20251022101420.36059-1-armbru@redhat.com>
 <20251022101420.36059-3-armbru@redhat.com>
 <58177628-7349-4450-a4c0-58bd44b39586@redhat.com>
 <87qzuniadg.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87qzuniadg.fsf@pond.sub.org>
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

On Tue, Oct 28, 2025 at 11:33:31AM +0100, Markus Armbruster wrote:
> Paolo Bonzini <pbonzini@redhat.com> writes:
> 
> > On 10/22/25 12:14, Markus Armbruster wrote:
> >> qdev_print_props() retrieves a property's value from its legacy
> >> property if it exists.  A legacy property is created by
> >> qdev_class_add_legacy_property() when the property has a print()
> >> method or does not have a get() method.
> >>
> >> If it has a print() method, the legacy property's value is obtained
> >> from the property's print() method.  This is used to format PCI
> >> addresses nicely, i.e. like 01.3 instead of 11.
> >>
> >> Else, if doesn't have a get() method, the legacy property is
> >> unreadable.  "info qtree" silently skips unreadable properties.
> >>
> >> Link properties don't have a get() method, and are therefore skipped.
> >> This is wrong, because the underlying QOM property *is* readable.
> >>
> >> Change qdev_print_props() to simply use a print() method directly if
> >> it exists, else get the value via QOM.
> >>
> >> "info qtree" now shows links fine.  For instance, machine "pc" onboard
> >> device "PIIX4_PM" property "bus" is now visible.
> >
> > It's been many years, but I think the original idea was that dc->props_ would be replaced with walking QOM properties.
> >
> > I'm not opposed to the patch, but it would put the plan in the coffin so I thought I'd point that out.
> 
> I'd argue that legacy properties are a questionable hack to preserve a
> specific solution to a problem.
> 
> The problem: PCI addresses are integers in C and in QOM.  Makes sense.
> But "info qtree" has always displayed PCI addresses in the form DEV.FN,
> which also makes sense.
> 
> The pre-QOM solution: qdev property method .get() returns the integer,
> .print() formats it for humans.  "info qtree" used the latter.
> 
> Aside: "format for humans" may well be more widely applicable, if we
> care.

The scope of the DEV.FN hack is worse than that - with PCI addresses,
while most of the time we just pass DEV, the QAPI also accepts it in
DEV.FN format for the 'addr' property and libvirt relies on that.

Here are two example CLIs that libvirt would generate when configuring
multi-function PCI placement:

For PCI-E (q35)

  -device '{"driver":"pcie-root-port",
            "port":19,
            "chassis":16,
            "id":"pci.16",
            "bus":"pcie.0",
            "multifunction":true,
            "addr":"0x2.0x3"}'

For PCI (i440fx)

  -device '{"driver":"lsi",
            "id":"scsi2",
            "bus":"pci.0",
            "multifunction":true,
            "addr":"0x4.0x1"}'

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


