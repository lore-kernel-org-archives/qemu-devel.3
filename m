Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16ACA1062899
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 13:06:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0JFu-00064e-V5; Wed, 11 Mar 2026 09:05:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w0JFr-00062s-W0
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 09:05:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w0JFo-0006c8-SG
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 09:05:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773234335;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vsSv4S/wdFecYhOHNRRkZWj+f24B0cWa6fpS1ZRcbjA=;
 b=c2WBcUt5HINWo+raSdfHYepHS++PJ3Tp0Vtws5yNr+A5oJIe4RSLczHhWwOU2omsF+LXuy
 7LYcS7LoucxYlMd2GsxdzMv9ixpsSHxF0cCRa9/dGUfw4izJPShXfjionj2I3Bc3KrvzBO
 ZAE1l5fgtsRjr17slP+3geQ6ncfnLBY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-159-XF2JdODENIKolEqux8jHbg-1; Wed,
 11 Mar 2026 09:05:30 -0400
X-MC-Unique: XF2JdODENIKolEqux8jHbg-1
X-Mimecast-MFC-AGG-ID: XF2JdODENIKolEqux8jHbg_1773234328
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 95B461956096; Wed, 11 Mar 2026 13:05:27 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.12])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 127E9195410D; Wed, 11 Mar 2026 13:05:26 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 727A121E681E; Wed, 11 Mar 2026 14:05:24 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,  Daniel P . =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9?=
 <berrange@redhat.com>,  Eduardo Habkost <eduardo@habkost.net>,  Thomas
 Huth <thuth@redhat.com>,  Igor Mammedov <imammedo@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Richard Henderson
 <richard.henderson@linaro.org>,  Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,  BALATON Zoltan
 <balaton@eik.bme.hu>,  Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,  Zide Chen
 <zide.chen@intel.com>,  Dapeng Mi <dapeng1.mi@linux.intel.com>,
 qemu-devel@nongnu.org,  devel@lists.libvirt.org
Subject: Re: [PATCH v2 00/21] qom: introduce property flags to track
 external user input
In-Reply-To: <20260210032348.987549-1-zhao1.liu@intel.com> (Zhao Liu's message
 of "Tue, 10 Feb 2026 11:23:27 +0800")
References: <20260210032348.987549-1-zhao1.liu@intel.com>
Date: Wed, 11 Mar 2026 14:05:24 +0100
Message-ID: <877bricy97.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

I can't find a good spot in the existing discussion where the following
would fit neatly as a reply, so I'm starting at the top again.

Fact: a huge part of our external interface is *accidental* and
virtually undocumented.

The sane way to do an external interface is to layer it on top of more
powerful internal interfaces.  The external interface exposes just the
functionality that's wanted there.  The internal interfaces can evolve
without affecting the external one.

QMP works that way.  QEMU code uses internal C interfaces.  QEMU doesn't
send QMP commands to itself.  If we need something internally, we add it
to a suitable internal interface.  There's no need to add it to the
external interface just for that.

QOM does not work that way.  The internal and the external object
configuration interface is one and the same.  So, if we add a property
for internal use, we can't *not* add it to the external interface.

This has led to an external interface that is frickin' huge: I count
~1000 device types with ~16000 properties in qemu-system-aarch64 alone.
The vast majority is undocumented.

Time and again we've found ourselves unsure whether certain properties
have external uses, or are even meant for external use.

We have been unable / unwilling to isolate the external interface from
internal detail.  This is madness.

As long as we persist in this madness, a sane, properly documented
external interface will remain impossible.

Do we care?  If yes, we should discuss how to isolate external and
internal interfaces.

This series attempts to create a bit of infrastructure for such
isolation: means to mark properties as internal.  Is it the right
infrastructure?  Is it enough to be a useful step?  Maybe not, but then
I'd like to hear better ideas.




Prior discussion in this thread:

    Subject: How to mark internal properties (was: Re: [PATCH v4 12/27]
        target/i386/cpu:  Remove CPUX86State::enable_cpuid_0xb field)
    Date: Fri, 9 May 2025 12:04:19 +0200
    Message-ID: <2f526570-7ab0-479c-967c-b3f95f9f19e3@redhat.com>
    https://lore.kernel.org/qemu-devel/2f526570-7ab0-479c-967c-b3f95f9f19e3@redhat.com


