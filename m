Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C92E9F483CC
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 16:46:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4iPc-0006tM-BV; Mon, 23 Mar 2026 12:45:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1w4iP4-0006qO-QL
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 12:45:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1w4iP2-0007h8-MJ
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 12:45:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774284318;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yg6BrdDzDNYXgfi0+Bh+yfybqWoy6BK5skjvprap/8o=;
 b=IsJURR1Ud+rc7zYrpPqpqOw0q6E8gt1Wmu22XDeOVx0ndKbKxVLW5x5YKQzc8xxougpKv7
 7iAGfTn6htFZER5uT9Ml1IHzB+MWPgqE5fKTSiirkW2VD8TxjlMOGqZZqqGfTyLK86hSet
 d5QcL00T70bNAcgktF2A7VW6QBot5z0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-655-ouFqSHMXNjiNa03VhWRFkw-1; Mon,
 23 Mar 2026 12:45:15 -0400
X-MC-Unique: ouFqSHMXNjiNa03VhWRFkw-1
X-Mimecast-MFC-AGG-ID: ouFqSHMXNjiNa03VhWRFkw_1774284314
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4894B19560B1; Mon, 23 Mar 2026 16:45:14 +0000 (UTC)
Received: from redhat.com (unknown [10.45.224.227])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BDCB9180058B; Mon, 23 Mar 2026 16:45:09 +0000 (UTC)
Date: Mon, 23 Mar 2026 16:45:06 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Junjie Cao <junjie.cao@intel.com>, qemu-devel@nongnu.org,
 jasowang@redhat.com, qemu-stable@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH] virtio-net: validate RSS indirections_len in post_load
Message-ID: <acFuEmRbTTvatBye@redhat.com>
References: <20260323131531.1976-1-junjie.cao@intel.com>
 <acFDFHsh8Rjhfncc@redhat.com>
 <CAFEAcA88mHqmM8Pmm0Gbbeu4ugBV8snenZh7bvjSSruUtRcywQ@mail.gmail.com>
 <20260323095706-mutt-send-email-mst@kernel.org>
 <acFUnqeSF2RMDiIe@redhat.com>
 <CAFEAcA_QV3k9bbayQh76-ASdHiJeWNSGY32DeDZJ0UrrC-WXLg@mail.gmail.com>
 <acFjLhpXlo2fv9Z6@redhat.com>
 <CAFEAcA-kuHOhsYEBUi3ty8eaK86+nE7jKHp=cXCungO6S0NE=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA-kuHOhsYEBUi3ty8eaK86+nE7jKHp=cXCungO6S0NE=w@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, Mar 23, 2026 at 04:15:56PM +0000, Peter Maydell wrote:
> On Mon, 23 Mar 2026 at 15:58, Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > On Mon, Mar 23, 2026 at 03:25:10PM +0000, Peter Maydell wrote:
> > > On Mon, 23 Mar 2026 at 14:56, Daniel P. Berrangé <berrange@redhat.com> wrote:
> > > >
> > > > On Mon, Mar 23, 2026 at 09:57:24AM -0400, Michael S. Tsirkin wrote:
> > > > > On Mon, Mar 23, 2026 at 01:53:53PM +0000, Peter Maydell wrote:
> > > > > > On Mon, 23 Mar 2026 at 13:43, Daniel P. Berrangé <berrange@redhat.com> wrote:
> > > > > > >
> > > > > > > On Mon, Mar 23, 2026 at 09:15:31PM +0800, Junjie Cao wrote:
> > > > > > > > virtio_net_handle_rss() enforces that indirections_len is a non-zero
> > > > > > > > power of two no larger than VIRTIO_NET_RSS_MAX_TABLE_LEN, but
> > > > > > > > virtio_net_rss_post_load() applies none of these checks to values
> > > > > > > > restored from the migration stream.
> > > > > > > >
> > > > > > > > A crafted migration stream can set indirections_len to 0.  Even if it
> > > > > > >
> > > > > > > The migration stream originating from the source QEMU is trusted.
> > > > > >
> > > > > > Is it? In https://www.qemu.org/docs/master/system/security.html we say:
> > > > > >
> > > > > > # The following entities are untrusted, meaning that they may be buggy
> > > > > > # or malicious:
> > > > > >
> > > > > > #  * Guest
> > > > > > #  * User-facing interfaces (e.g. VNC, SPICE, WebSocket)
> > > > > > #  * Network protocols (e.g. NBD, live migration)
> > > > > > #  * User-supplied files (e.g. disk images, kernels, device trees)
> > > > > > #  * Passthrough devices (e.g. PCI, USB)
> > > > > >
> > > > > > which explicitly lists "live migration" as an untrusted entity.
> > > > > >
> > > > > > I would definitely be extremely cautious about having a threat
> > > > > > model where I had to distrust inbound migration data, but the
> > > > > > above does suggest we aim to handle that, and we have I think
> > > > > > in the past taken patches which add sanity-checking to the
> > > > > > migration data.
> > > > >
> > > > > And we even assigned a low priority CVEs to these.
> > > >
> > > > Do you have an example of that ?
> > >
> > > Here's one from last year:
> > > https://access.redhat.com/security/cve/cve-2025-54566
> >
> > I think this one is valid, because it involves incorrect handling
> > of settings that are controlled by the guest OS. There's no
> > external party claimed to be modifying the migration stream IIUC
> 
> I think the "guest OS sets things wrongly" is CVE-2025-54567,
> and 54566 is specifically for the "migration stream is malicious"
> case. The commit fixing them:
> https://gitlab.com/qemu-project/qemu/-/commit/cad9aa6fbdccd95e56e10cfa57c354a20a333717
> fixes both at the same time, by providing a validation function
> and calling it both (a) when the guest OS writes the settings
> and (b) in post_load. If we trust migration data then we don't need
> to validate it in post-load, we could just say "make sure your
> source QEMU has the fix for (a) and that you've restarted the guest".

Ah, yes, the pairing of CVEs is key here.

Our users expect their workloads to execute without interruption.
Thus our story for fixing CVEs bugs without guest impact is to
live migrate the guest onto the fixed CVE.

So in this case, I think we do need the fix in post_load as a
way to mitigate the root cause CVE in existing workloads that
cannot be restarted. 

> > > I vaguely recall we had a set of them some years ago too
> > > (probably somebody specifically looking for flaws in the
> > > category). https://access.redhat.com/security/cve/cve-2013-4536
> > > might be an example of that.
> >
> > I think this one is probably issued in error.
> >
> > If we're considering that the migration data stream is modifiable
> > by an attacker, the implication is that the attacker has arbitrary
> > read and write over the entire of guest RAM. That in turn implies
> > no guest OS can ever be trusted after a migration has been performed,
> 
> > That is certainly not the case though.
> 
> Trusted by whom? If I'm a cloud vendor then I don't trust the
> guest OS in the first place. QEMU itself should consider everything
> in guest RAM untrusted data, because it's guest-controlled.
> You can probably have setups where the user who owns the VM might
> be able to modify the migration stream but no third party can
> (e.g. if you give them the ability to vmsave/vmload to a file
> that they own), in the same way you can give the VM owner the
> ability to directly write to the disk images the VM is using
> without that being a way for them to escape to the host.

Hmm, yes, load/save into a file that the guest owner controls
is a good point. I'm fairly sure I recall that OpenStack allows
for exactly that scenario. So the host owner would need to
treat the vmstate as potentially hostile in that case.

IOW, bugs that affect handling of vm state that merely result
in an assert are merely self-inflicted DoS by the guest owner.
Bugs that could be leveraged to exploit QEMU itself should be
CVE worthy.

So even if the migration stream can be considerd trusted, we
can't trust vmstate in general due to the load/save scenario.

This is probably a case where we ought to have had a host
controlled digital signature over vmstate data to validate
its integrity.


> > I don't accept scope for CVEs in QEMU for an external attacker modifying
> > the migration data stream or saved state file contents though. AFAICS,
> > such possibilities imply gross misconfiguration of QEMU by the mgmt app,
> > and should be CVEs in the mgmt app instead.
> 
> I agree that you have a pretty weird threat/operating model if
> you allow the migration-stream to be considered untrusted, because
> it's reasonable and sensible to secure it. But I have a vague
> recollection that this language is in the doc precisely because
> at least one person/party has argued in the past in favour of
> treating the migration stream as on the security boundary. I don't
> object to our deciding we want to call the migration-stream trusted --
> but I do think this is a policy change from our current stance.

Possibly we should clarify the language to say that the vmstate
format is untrusted due to the load/save possibility to guest
owner controlled storage.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


