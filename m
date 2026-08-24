Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 234BCC5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 07:23:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyP1T-0002e2-Im; Mon, 24 Aug 2026 03:23:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wyP1R-0002bL-9I
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 03:23:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wyP1P-0001gB-9h
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 03:23:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787556186;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 resent-to:resent-from:resent-message-id:in-reply-to:in-reply-to:
 references:references; bh=P7yUEloMZb4stposY86CiIlPWN9A0ZvHR+9+jsGqBKY=;
 b=YqxD90BxvRfKnSXxESLMbu6QqUlqd1O+sbbjit+W/mLaBJzi99cNS7ScI/WfZlxieNL6q/
 AUwUMcdPtqXhNJYm36Gee4nhgeNg6u7yEnkIBGhEM19q7v51dKZ0AOXw15wbCxId8WTBn0
 AB/mGXxFZobnBY8BJXBqBpwoZ5TzEMo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-205-F2wgDI1WNlq1UAo_1un3aA-1; Mon,
 24 Aug 2026 03:23:02 -0400
X-MC-Unique: F2wgDI1WNlq1UAo_1un3aA-1
X-Mimecast-MFC-AGG-ID: F2wgDI1WNlq1UAo_1un3aA_1787556181
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BD5A8195DE35; Mon, 24 Aug 2026 07:23:00 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.12])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D9CC9180034C; Mon, 24 Aug 2026 07:22:59 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 52E7A21E6920; Mon, 24 Aug 2026 09:22:57 +0200 (CEST)
Resent-To: bchaney@akamai.com, qemu-devel@nongnu.org,
 dongli.zhang@oracle.com, joe.jin@oracle.com, maciej.szmigiero@oracle.com,
 mark.kanda@oracle.com, pierrick.bouvier@oss.qualcomm.com, farosas@suse.de
Resent-From: Markus Armbruster <armbru@redhat.com>
Resent-Date: Mon, 24 Aug 2026 09:22:57 +0200
Resent-Message-ID: <87mrucugmm.fsf@pond.sub.org>
From: Markus Armbruster <armbru@redhat.com>
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: qemu-devel@nongnu.org,  peterx@redhat.com,  farosas@suse.de,
 eblake@redhat.com,  maciej.szmigiero@oracle.com,  mark.kanda@oracle.com,
 bchaney@akamai.com,  pierrick.bouvier@oss.qualcomm.com, joe.jin@oracle.com
Subject: Re: [PATCH 1/5] migration/qapi: Add memfd migration transport
In-Reply-To: <a23d9e5b-d0ed-4e9d-95ae-e0fda4bb0453@oracle.com> (Dongli Zhang's
 message of "Fri, 21 Aug 2026 13:11:23 -0700")
References: <20260812232842.470225-1-dongli.zhang@oracle.com>
 <20260812232842.470225-2-dongli.zhang@oracle.com>
 <87a4qh46ao.fsf@pond.sub.org>
 <614160f2-2f3e-4489-ac4b-758f162be553@oracle.com>
 <87a4qg0wv9.fsf@pond.sub.org>
 <a23d9e5b-d0ed-4e9d-95ae-e0fda4bb0453@oracle.com>
Date: Mon, 24 Aug 2026 08:29:53 +0200
Message-ID: <87h5kkvxni.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
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

Dongli Zhang <dongli.zhang@oracle.com> writes:

> On Fri, Aug 21, 2026 12:13:30AM -0700, Markus Armbruster wrote:
>> Dongli Zhang <dongli.zhang@oracle.com> writes:
>> 
>>> On Thu, Aug 20, 2026 12:09:19AM -0700, Markus Armbruster wrote:
>>>> Dongli Zhang <dongli.zhang@oracle.com> writes:
>>>> 
>>>>> Add a memfd migration transport to the MigrationAddress QAPI schema. The
>>>>> new transport has no user-supplied arguments because QEMU creates and
>>>>> passes the backing memfd internally.
>>>>>
>>>>> The initial user is cpr-exec, where the main VM/device migration stream can
>>>>> be stored in an inherited memfd instead of an external file.
>>>>>
>>>>> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
>>>>> ---
>>>>>  qapi/migration.json | 32 +++++++++++++++++++++++++++-----
>>>>>  1 file changed, 27 insertions(+), 5 deletions(-)
>>>>>
>>>>> diff --git a/qapi/migration.json b/qapi/migration.json
>>>>> index b1eaf7b054..1505c201ca 100644
>>>>> --- a/qapi/migration.json
>>>>> +++ b/qapi/migration.json
>>>>> @@ -702,9 +702,11 @@
>>>>>  # @cpr-exec: The migrate command stops the VM, saves state to the
>>>>>  #     migration channel, directly exec's a new version of QEMU on the
>>>>>  #     same host, replacing the original process while retaining its
>>>>> -#     PID, and loads state from the channel.  Guest RAM is preserved
>>>>> -#     in place.  Devices and their pinned pages are also preserved for
>>>>> -#     VFIO and IOMMUFD.
>>>>> +#     PID, and loads state from the channel.  With the @memfd
>>>>> +#     migration transport, QEMU saves VM/device state to an internal
>>>>> +#     memfd instead of an external main migration channel.  Guest RAM
>>>>> +#     is preserved in place.  Devices and their pinned pages are also
>>>>> +#     preserved for VFIO and IOMMUFD.
>>>>>  #
>>>>>  #     Old QEMU starts new QEMU by exec'ing the command specified by
>>>>>  #     the @cpr-exec-command parameter.  The command may be a direct
>>>>> @@ -716,6 +718,13 @@
>>>>>  #     as a file, that accepts all data before old QEMU exits.
>>>>>  #     Otherwise, old QEMU may quietly block writing to the channel.
>>>>>  #
>>>>> +#     Alternatively, use the @memfd migration transport to save
>>>>> +#     VM/device state to an internal memfd inherited by new QEMU.
>>>>> +#
>>>> 
>>>> Any guidance on when to use @memfd?
>>>
>>> My objective is to avoid using disks, or running QEMU with writable storage.
>>>
>>> Both guest I/O and networking can go through VFIO, and everything remains in memory.
>>>
>>> When I was testing these CPR features, my favorite was cpr-exec because it does
>>> not require creating an additional QEMU instance.
>>>
>>> Based on my understanding, the best approach to live update a running binary is
>>> to replace only the code section while keeping everything else in memory, i.e.
>>> guest memory, device fds, and device state.
>>>
>>> Unfortunately, device state cannot simply remain in memory across exec(), so we
>>> need to migrate it from the old instance to the new instance. I was thinking:
>>> why not use memory instead of storage?
>>>
>>> Initially, I added the change only for cpr-exec. Later, I reworked the change to
>>> make memfd a new migration transport. As a side benefit for me, I also practiced
>>> how to add a new transport to the QEMU migration code :)
>> 
>> This is why you wrote the feature.  Please work it into the commit
>> message.
>
> Sure.
>
>> 
>> We should also help users decide whether to use the feature.  I gather
>> it's useful with migration mode cpr-exec.  Any other use cases?  Does it
>> even work with other migration modes?  If yes, which ones, and what
>> happens when you try with another one?
>
> So far I only added support for cpr-exec. I have not tried othe modes.

What happens when you try to use it with other migration modes?

> In my opinion, cpr-transfer could also use a memfd-backed channel, but I am not
> sure it is necessary.
>
> For cpr-transfer, the source and destination are separate QEMU processes. If we
> want to pass a memfd between them, we still need an IPC mechanism that can
> transfer file descriptors, such as a Unix domain socket with SCM_RIGHTS. That
> reduces the value of using memfd as the migration channel, because we need at
> least one Unix domain socket anyway to pass the memfd fd and coordinate the handoff.
>
> If a Unix domain socket is already required, the main benefit of memfd would
> likely be performance, especially when the device state is large.

We'd want to measure the performance impact to see whether it's worth
complicating configuration and code.

> cpr-exec is different. The new QEMU is started via exec(), so the memfd fd can
> be preserved across exec by clearing CLOEXEC and passing the fd number through
> an environment variable. This allows us to add a memfd-backed migration channel
> without needing an external file or socket for the device state.

What are the actual user-visible benefits?

Performance?  Provide measurements, please.

Simpler configuration?  Not sure that would be worth the special case.

Anything else?

> One potential future use case is LUO/KHO support for QEMU. In that case, device
> state could be preserved in memory as a memfd and potentially survive across a
> KHO kexec. We won't need to preserve anything on storage. Indeed, I did some
> internal tests using memfd to preserve device state across kexec although using
> different implementation, and it worked.
>
> For other live migration modes, or even local migration, I do not think this is
> useful. For example, saving to and loading from a file won't use memfd, as the
> QEMU processes are terminated during the this process.

User documentation should spell out when memfd can be used.  I recommend
to make it usable only when it's known to improve things in at least
some scenario that matters.  Code should cleanly reject attempts to use
memfd when it's not usable.

User documentation should help users decide whether to use it.

The commit message(s) may need to provide additional detail on how
things improve.

> Thank you very much!
>
> Dongli Zhang

You're welcome!

[...]


