Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 532731062897
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 13:15:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0JP3-0000Sx-OX; Wed, 11 Mar 2026 09:15:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1w0JP1-0000Rm-Da
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 09:15:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1w0JOu-00008b-Un
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 09:15:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773234898;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=BbYMrbJBCOUzEnhwnBhdghW6AdWMtvyonoWEILwoxcQ=;
 b=RTHHfSYmvN7sRYulJciZa8LpfcX/bbp0QWvaOOWCuKy5eRCd78JNn7WyGiSG5TyXUHBp2h
 Z58J+2ZBnrbSo9UGCc7eG8tkoPSHUDIKtN/TZ4elgirWj2HYZIcRuuA0k8XVxf+6H2T8Ss
 16BAj0SyTiN1fIh6Rz71r4xDd1semyA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-152-5gY0Qi2nPS-Z42sA1kavjQ-1; Wed,
 11 Mar 2026 09:14:54 -0400
X-MC-Unique: 5gY0Qi2nPS-Z42sA1kavjQ-1
X-Mimecast-MFC-AGG-ID: 5gY0Qi2nPS-Z42sA1kavjQ_1773234892
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9923019560B3; Wed, 11 Mar 2026 13:14:51 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.160])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3B06B1956095; Wed, 11 Mar 2026 13:14:44 +0000 (UTC)
Date: Wed, 11 Mar 2026 13:14:41 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Thomas Huth <thuth@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Zide Chen <zide.chen@intel.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, qemu-devel@nongnu.org,
 devel@lists.libvirt.org
Subject: Re: [PATCH v2 00/21] qom: introduce property flags to track external
 user input
Message-ID: <abFqwbCCf7rNDEWs@redhat.com>
References: <20260210032348.987549-1-zhao1.liu@intel.com>
 <877bricy97.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <877bricy97.fsf@pond.sub.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, Mar 11, 2026 at 02:05:24PM +0100, Markus Armbruster wrote:
> I can't find a good spot in the existing discussion where the following
> would fit neatly as a reply, so I'm starting at the top again.
> 
> Fact: a huge part of our external interface is *accidental* and
> virtually undocumented.
> 
> The sane way to do an external interface is to layer it on top of more
> powerful internal interfaces.  The external interface exposes just the
> functionality that's wanted there.  The internal interfaces can evolve
> without affecting the external one.
> 
> QMP works that way.  QEMU code uses internal C interfaces.  QEMU doesn't
> send QMP commands to itself.  If we need something internally, we add it
> to a suitable internal interface.  There's no need to add it to the
> external interface just for that.
> 
> QOM does not work that way.  The internal and the external object
> configuration interface is one and the same.  So, if we add a property
> for internal use, we can't *not* add it to the external interface.
> 
> This has led to an external interface that is frickin' huge: I count
> ~1000 device types with ~16000 properties in qemu-system-aarch64 alone.
> The vast majority is undocumented.
> 
> Time and again we've found ourselves unsure whether certain properties
> have external uses, or are even meant for external use.
> 
> We have been unable / unwilling to isolate the external interface from
> internal detail.  This is madness.
> 
> As long as we persist in this madness, a sane, properly documented
> external interface will remain impossible.
> 
> Do we care?  If yes, we should discuss how to isolate external and
> internal interfaces.
> 
> This series attempts to create a bit of infrastructure for such
> isolation: means to mark properties as internal.  Is it the right
> infrastructure?  Is it enough to be a useful step?  Maybe not, but then
> I'd like to hear better ideas.

For -object / object_add  we introduced formal QAPI modelling of
all Object subclasses which implement the UserCreatable interface.
IIUC, that gives us the desired separation between internal and
external views, as only properties declared in qapi/qom.json are
publically settable.

This work did not apply to the Device classes because the historical
baggage with qdev being grafted onto qom, means we don't have that
working via the UserCreatable inteface or -object/object_add.

Can we bring Device into the same world though ?

Adding 1000 device types to QAPI is a huge job, so it would need to
be a long incremental job, unless perhaps we auto-generate QAPI
descriptions for everything that already exists ?

More generally anything we can do to bring qdev & qom closer together
feels desirable. I dream of a future where -device/device_add are
obsolete....

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


