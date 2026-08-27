Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78127C5DF9D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 08:24:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzVOw-0004O6-Tf; Thu, 27 Aug 2026 04:23:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wzVOu-0004Nl-WB
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 04:23:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wzVOt-0003Vu-7n
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 04:23:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787819034;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fTPnv6PNq+8w3nGIOY8S9Bac1+7qp08v3A/P0zS17g0=;
 b=AafUdhK1f9HXS3MlJMjvm1CLl1NltGabFb8ygWVl3U15yTc2GZUotmPcO1rmXorFE7GWGG
 ZIXduiQfkYBMc/Z+3V0HdxTiV/sszyBJ7qxCjcYYOneVNMrZgSWMclrl5MCiQgXs9aLxsU
 7FtKBbdpX28fnXMo+3Zm+B/p1fNRKwI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-550-Ls1VOmuGO-ev2lhLW-vgPg-1; Thu,
 27 Aug 2026 04:23:51 -0400
X-MC-Unique: Ls1VOmuGO-ev2lhLW-vgPg-1
X-Mimecast-MFC-AGG-ID: Ls1VOmuGO-ev2lhLW-vgPg_1787819028
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 35CDD180216B; Thu, 27 Aug 2026 08:23:48 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 47ED930002E9; Thu, 27 Aug 2026 08:23:47 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BD0A521E6920; Thu, 27 Aug 2026 10:23:44 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: qemu-devel@nongnu.org,  peterx@redhat.com,  farosas@suse.de,
 eblake@redhat.com,  maciej.szmigiero@oracle.com,  mark.kanda@oracle.com,
 bchaney@akamai.com,  pierrick.bouvier@oss.qualcomm.com, joe.jin@oracle.com
Subject: Re: [PATCH 1/5] migration/qapi: Add memfd migration transport
In-Reply-To: <7d7496c2-79f0-444d-a843-5f5bba467560@oracle.com> (Dongli Zhang's
 message of "Wed, 26 Aug 2026 10:45:09 -0700")
References: <20260812232842.470225-1-dongli.zhang@oracle.com>
 <20260812232842.470225-2-dongli.zhang@oracle.com>
 <87a4qh46ao.fsf@pond.sub.org>
 <614160f2-2f3e-4489-ac4b-758f162be553@oracle.com>
 <87a4qg0wv9.fsf@pond.sub.org>
 <a23d9e5b-d0ed-4e9d-95ae-e0fda4bb0453@oracle.com>
 <87h5kkvxni.fsf@pond.sub.org>
 <7d7496c2-79f0-444d-a843-5f5bba467560@oracle.com>
Date: Thu, 27 Aug 2026 10:23:44 +0200
Message-ID: <87zey8ezu7.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Dongli Zhang <dongli.zhang@oracle.com> writes:

> On Sun, Aug 23, 2026 11:29:53PM -0700, Markus Armbruster wrote:
> Dongli Zhang <dongli.zhang@oracle.com> writes:
>> 
>>> On Fri, Aug 21, 2026 12:13:30AM -0700, Markus Armbruster wrote:
>>>> Dongli Zhang <dongli.zhang@oracle.com> writes:
>>>> 
>>>>> On Thu, Aug 20, 2026 12:09:19AM -0700, Markus Armbruster wrote:
>>>>>> Dongli Zhang <dongli.zhang@oracle.com> writes:
>
> [snip]
>
>>>> message.
>>>
>>> Sure.
>>>
>>>> 
>>>> We should also help users decide whether to use the feature.  I gather
>>>> it's useful with migration mode cpr-exec.  Any other use cases?  Does it
>>>> even work with other migration modes?  If yes, which ones, and what
>>>> happens when you try with another one?
>>>
>>> So far I only added support for cpr-exec. I have not tried othe modes.
>> 
>> What happens when you try to use it with other migration modes?
>
> If I use memfd transport without cpr-exec mode, it will be denied.
>
> The code checks that only cpr-exec mode is supported.
>
> (qemu) migrate -d memfd:
> Error: memfd transport is only supported with cpr-exec

Good.

>>> In my opinion, cpr-transfer could also use a memfd-backed channel, but I am not
>>> sure it is necessary.
>>>
>>> For cpr-transfer, the source and destination are separate QEMU processes. If we
>>> want to pass a memfd between them, we still need an IPC mechanism that can
>>> transfer file descriptors, such as a Unix domain socket with SCM_RIGHTS. That
>>> reduces the value of using memfd as the migration channel, because we need at
>>> least one Unix domain socket anyway to pass the memfd fd and coordinate the handoff.
>>>
>>> If a Unix domain socket is already required, the main benefit of memfd would
>>> likely be performance, especially when the device state is large.
>> 
>> We'd want to measure the performance impact to see whether it's worth
>> complicating configuration and code.
>
> I may create a VM with many virtio devices to maximize the storage overhead of
> the VM device state. However, I don't think the goal is to improve performance.

As long as that's the case, enabling memfd for cpr-transfer makes no
sense.

>>> cpr-exec is different. The new QEMU is started via exec(), so the memfd fd can
>>> be preserved across exec by clearing CLOEXEC and passing the fd number through
>>> an environment variable. This allows us to add a memfd-backed migration channel
>>> without needing an external file or socket for the device state.
>> 
>> What are the actual user-visible benefits?
>
> The goal is to avoid the VM state file used during live update with cpr-exec.
> So, the user-visible benefit is that the file is no longer required. Live update
> with cpr-exec no longer relies on a file on disk.

Got it.

>> Performance?  Provide measurements, please.
>
> Not performance.

If we accept memfd for its other benefits, performance measurements
might be interesting.  Not now.

>> Simpler configuration?  Not sure that would be worth the special case.
>
> Yes. No file required.
>
> "migrate -d memfd:" vs. "migrate -d file:vm.state".
>
> "migrate_incoming memfd:" vs. "migrate_incoming file:vm.state".

Got it.

>> Anything else?
>
> No. Writable storage is no longer required to cache the VM device state file.
> That's the only explicit benefit so far.

Benefits of the new MigrationAddressType @memfd: we gain a zero-config
migration channel for MigMode cpr-exec.

Costs: we gain yet another kind of migration channel, useful only with
cpr-exec.  Feels niche.

Are the benefits worth the costs?  Migration maintainers decide, not me.

In my (relatively ignorant) opinion, migration already suffers from too
many features.  Hard to understand, painful test matrix, expensive to
maintain.

>>> One potential future use case is LUO/KHO support for QEMU. In that case, device
>>> state could be preserved in memory as a memfd and potentially survive across a
>>> KHO kexec. We won't need to preserve anything on storage. Indeed, I did some
>>> internal tests using memfd to preserve device state across kexec although using
>>> different implementation, and it worked.
>>>
>>> For other live migration modes, or even local migration, I do not think this is
>>> useful. For example, saving to and loading from a file won't use memfd, as the
>>> QEMU processes are terminated during the this process.
>> 
>> User documentation should spell out when memfd can be used.

It does: "This transport is currently only valid with cpr-exec migration
mode."

>>                                                              I recommend
>> to make it usable only when it's known to improve things in at least
>> some scenario that matters.  Code should cleanly reject attempts to use
>> memfd when it's not usable.

You showed above that it does.

>> User documentation should help users decide whether to use it.

It does not so far.

>> The commit message(s) may need to provide additional detail on how
>> things improve.
>> 
> Thank you very much for feedback!
>
> Dongli Zhang

You're welcome!


Tangent, pardon my ignorance...  We have MigMode @cpr-exec and we have
MigrationAddressType @exec.  Both involve starting a new instance of
QEMU.  How do their use cases differ?


