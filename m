Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29FE7E81BC9
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 14:02:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpRq1-0004aJ-4S; Mon, 09 Feb 2026 09:02:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vpRpk-0004Y8-Ay
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 09:01:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vpRpg-0004hL-Jd
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 09:01:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770645699;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b8omTL/Q2D7P0BE2Jd0peC7Yv2e28e01vw3FhakdFHA=;
 b=FjGUTD6bihD1Ijx2205GUf4K4Ht9Py6dmZF3NF8HYe+tohc8BUSy7XBp0JS2Z/iOuSAHt2
 KtnxNQGc9XysiKD+0PGcieswhpPLrvChWHcwGAperWDiaT0sB5t+xgs97O843r8zOQ9uFI
 oiLu469+xjdfFhZ1BzJA1rF46hCmU08=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-580-DxBAMHtFNQOX0A3LFgxYKQ-1; Mon,
 09 Feb 2026 09:01:35 -0500
X-MC-Unique: DxBAMHtFNQOX0A3LFgxYKQ-1
X-Mimecast-MFC-AGG-ID: DxBAMHtFNQOX0A3LFgxYKQ_1770645693
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 003D5195608F; Mon,  9 Feb 2026 14:01:33 +0000 (UTC)
Received: from redhat.com (unknown [10.45.225.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5E00618003F6; Mon,  9 Feb 2026 14:01:28 +0000 (UTC)
Date: Mon, 9 Feb 2026 14:01:24 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>,
 qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 "open list:X86 KVM CPUs" <kvm@vger.kernel.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH] Add query-tdx-capabilities
Message-ID: <aYnotPEv3aJAClPm@redhat.com>
References: <aV41CQP0JODTdRqy@redhat.com> <87qzrzku9z.fsf@pond.sub.org>
 <aWDMU7WOlGIdNush@redhat.com> <87jyxrksug.fsf@pond.sub.org>
 <aWDTXvXxPRj2fs2b@redhat.com> <87cy3jkrj8.fsf@pond.sub.org>
 <aWDatqLQYBV9fznm@redhat.com> <871pjzkm4y.fsf@pond.sub.org>
 <CAJ+F1CLR4wt-bA+V+oV6N4iKTK_=Hn8TSD0pP7Uwj=jWHWvZRA@mail.gmail.com>
 <87343i71hm.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87343i71hm.fsf@pond.sub.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Feb 03, 2026 at 08:03:17AM +0100, Markus Armbruster wrote:
> Cc: machine core maintainers for an opinion on query-machines.
> 
> Marc-André Lureau <marcandre.lureau@gmail.com> writes:
> 
> > Hi
> >
> > On Fri, Jan 9, 2026 at 4:27 PM Markus Armbruster <armbru@redhat.com> wrote:
> >>
> >> Daniel P. Berrangé <berrange@redhat.com> writes:
> >>
> >> > On Fri, Jan 09, 2026 at 11:29:47AM +0100, Markus Armbruster wrote:
> >> >> Daniel P. Berrangé <berrange@redhat.com> writes:
> >> >>
> >> >> > On Fri, Jan 09, 2026 at 11:01:27AM +0100, Markus Armbruster wrote:
> >> >> >> Daniel P. Berrangé <berrange@redhat.com> writes:
> >> >> >>
> >> >> >> > On Fri, Jan 09, 2026 at 10:30:32AM +0100, Markus Armbruster wrote:
> >> >> >> >> Daniel P. Berrangé <berrange@redhat.com> writes:
> >> >> >> >>
> >> >> >> >> > On Tue, Jan 06, 2026 at 10:36:20PM +0400, marcandre.lureau@redhat.com wrote:
> >> >> >> >> >> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> >> >> >> >> >>
> >> >> >> >> >> Return an empty TdxCapability struct, for extensibility and matching
> >> >> >> >> >> query-sev-capabilities return type.
> >> >> >> >> >>
> >> >> >> >> >> Fixes: https://issues.redhat.com/browse/RHEL-129674
> >> >> >> >> >> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> [...]
> 
> >> >> >> Do management applications need to know more than "this combination of
> >> >> >> host + KVM + QEMU can do SEV, yes / no?
> >> >> >>
> >> >> >> If yes, what do they need?  "No" split up into serval "No, because X"?
> >> >> >
> >> >> > When libvirt runs  query-sev-capabilities it does not care about the
> >> >> > reason for it being unsupported.   Any "GenericError" is considered
> >> >> > to mark the lack of host support, and no fine grained checks are
> >> >> > performed on the err msg.
> >> >> >
> >> >> > If query-sev-capabilities succeeds (indicating SEV is supported), then
> >> >> > all the returned info is exposed to mgmt apps in the libvirt domain
> >> >> > capabilities XML document.
> >> >>
> >> >> So query-sev-capabilities is good enough as is?
> >> >
> >> > IIUC, essentially all QEMU errors that could possibly be seen with
> >> > query-sev-capabilities are "GenericError" these days, except for
> >> > the small possibility of "CommandNotFound".
> >> >
> >> > The two scenarios with lack of SEV support are covered by GenericError
> >> > but I'm concerned that other things that should be considered fatal
> >> > will also fall under GenericError.
> >> >
> >> > eg take a look at qmp_dispatch() and see countless places where we can
> >> > return GenericError which ought to be treated as fatal by callers.
> >> >
> >> > IMHO  "SEV not supported" is not conceptually an error, it is an
> >> > expected informational result of query-sev-capabilities, and thus
> >> > shouldn't be using the QMP error object, it should have been a
> >> > boolean result field.
> >>
> >> I agree that errors should be used only for "abnormal" outcomes, not for
> >> the "no" answer to a simple question like "is SEV available, and if yes,
> >> what are its capabilities?"
> >>
> >> I further agree that encoding "no" as GenericError runs the risk of
> >> conflating "no" with other errors.  Since query-sev itself can fail just
> >> one way, these can only come from the QMP core.  For the core's syntax
> >> and type errors, the risk is only theoretical: just don't do that.
> >> Errors triggered by state, like the one in qmp_command_available(), are
> >> a bit more worrying.  I think they're easy enough to avoid if you're
> >> aware, but "if you're aware" is admittedly rittle.
> >>
> >> Anyway, that's what we have.  Badly designed, but it seems to be
> >> workable.
> >>
> >> Is the bad enough to justify revising the interface?  I can't see how to
> >> do that compatibly.
> >>
> >> Is it bad enough to justify new interfaces for similar things to be
> >> dissimilar?
> >>
> >
> > Maybe query-{sev,tdx,*}-capabilities should only be called when the
> > host is actually capable, thus throwing an Error is fine.
> >
> > What about a new "query-confidential-guest-supports" command that
> > checks the host capability and returns ["sev", "tdx", "pef"...] then ?
> 
> Some similarity to query-accelerators.  Feels reasonable.

It feels like if we do that, then we would fold the -capbilities into
this command too:

{ 'enum': 'ConfidentialGuestType',
  'data': ['sev', 'sev-snp', 'tdx', .. ] }

{ 'union': 'ConfidentialGuestSupport',
  'base': { 'type': 'ConfidentialGuestType' },
  'discriminator': { 'type' },
  'data': { 'sev': 'SevCapabilities',
            'sev-snp': 'SevCapabilities' } }

{ 'command': 'query-confidential-guest-capabilities',
  'returns': 'ConfidentialGuestCapability' }



> > Or maybe this should be provided at the MachineInfo level instead
> > (query-machines).
> 
> Also reasonable, I think.  Machine core maintainers, got an opinion?

MachineInfo level seems interesting because of the 'confidential-guest-support'
property against the machine classes.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


