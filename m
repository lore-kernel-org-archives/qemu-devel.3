Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 272F0D11718
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 07:38:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4EuE-0001dk-Eb; Fri, 25 Oct 2024 03:38:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1t4EuD-0001dN-41
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 03:38:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1t4EuA-0005Up-Ix
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 03:38:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729841920;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mn4Ct/v+dJhO8b/mJEUPK2FsdpdVJuwgSY0+xeWLfnM=;
 b=TmI8rRcHKE11vNrIfYGClaRR3sjIcdYvCa3es+RVonbAf1rQh9KaXuxBs/hfER4oS3ar1a
 D3jOJJ+PW6IwEx2mXthZ0WibvWWaWvWGgPB9ja77Z6TgzYgG6Q/zyisiyns+3KTf9F0HRE
 bx7L/qqgo0ewnKGSKXLMi1P1U2HS6Fw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-393-VMlqU0gsNH6FJ38FFbnBaw-1; Fri,
 25 Oct 2024 03:38:36 -0400
X-MC-Unique: VMlqU0gsNH6FJ38FFbnBaw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 924C819560B2; Fri, 25 Oct 2024 07:38:35 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.150])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0BE421956088; Fri, 25 Oct 2024 07:38:33 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 898D921E6A28; Fri, 25 Oct 2024 09:38:31 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org,  Fabiano Rosas <farosas@suse.de>,  Igor Mammedov
 <imammedo@redhat.com>,  Juraj Marcin <jmarcin@redhat.com>,  "Michael S .
 Tsirkin" <mst@redhat.com>,  "Dr . David Alan Gilbert" <dave@treblig.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,  Markus Armbruster
 <armbru@redhat.com>,  Eduardo Habkost <eduardo@habkost.net>,  Daniel P .
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Alex Williamson
 <alex.williamson@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Peter
 Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 0/4] QOM: Singleton interface
In-Reply-To: <20241024165627.1372621-1-peterx@redhat.com> (Peter Xu's message
 of "Thu, 24 Oct 2024 12:56:23 -0400")
References: <20241024165627.1372621-1-peterx@redhat.com>
Date: Fri, 25 Oct 2024 09:38:31 +0200
Message-ID: <87h690my2w.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.263,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.697,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Peter Xu <peterx@redhat.com> writes:

> This patchset introduces the singleton interface for QOM.
>
> The singleton interface is as simple as "this class can only create one
> instance".
>
> We used to have similar demand when working on all kinds of vIOMMUs,
> because in most cases that I am aware of, vIOMMU must be a singleton as
> it's closely bound to the machine and also the root PCIe systems.  We used
> to have a bunch of special code guarding those, for example, X86 has
> pc_machine_device_pre_plug_cb() just to detect when vIOMMU is created more
> than once.
>
> There is a similar demand raising recently (even if the problem existed
> over years) when we were looking at a migration bug, that part of it was
> involved with the current_migration global pointer being referenced
> anywhere, even after the migration object was finalize()ed.  So far without
> singleton support, there's no way to reset the variable properly.
> Declaring migration object to be a singleton also just makes sense, e.g.,
> dynamically creating migration objects on the fly with QMP commands doesn't
> sound right..
>
> The idea behind is pretty simple: any object that can only be created once
> can now declare the TYPE_SINGLETON interface, then QOM facilities will make
> sure it won't be created more than once.  For example, qom-list-properties,
> device-list-properties, etc., will be smart enough to not try to create
> temporary singleton objects now.

QOM design assumption: object_new() followed by object_unref() is always
possible and has no side effect.

QOM introspection relies on this.  Your PATCH 1 makes non-class
properties of singletons invisible in introspection.  Making something
with such properties a singleton would be a regression.

Anything that violates the design assumption must be delayed to a
suitable state transition.  For devices (subtypes of TYPE_DEVICE), this
is ->realize().  For user-creatable objects (provide interface
TYPE_USER_CREATABLE), this is ->complete().  For anything else, it's
something else that probably doesn't even exist, yet.  See "Problem 5:
QOM lacks a clear life cycle" in

    Subject: Dynamic & heterogeneous machines, initial configuration: problems
    Date: Wed, 31 Jan 2024 21:14:21 +0100
    Message-ID: <87o7d1i7ky.fsf@pond.sub.org>
    https://lore.kernel.org/qemu-devel/87o7d1i7ky.fsf@pond.sub.org/

>                                   Meanwhile, we also guard device-add paths
> so that it'll fail properly if it's created more than once (and iff it's a
> TYPE_DEVICE first).

[...]


