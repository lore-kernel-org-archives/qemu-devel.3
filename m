Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06689CA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:29:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNDj-0002MW-8m; Sat, 30 Aug 2025 11:10:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1urvLL-0003pT-BX
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 05:24:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1urvLI-0007UP-Gu
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 05:24:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756459456;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KEPa4UeX4TI5AjgZwWaAERITttKUxrFo7p7xu/YwCqE=;
 b=c5OTCicLVhBhEJ36j3cOoyDvgPM1flT+TjSv8LHXhZr57yqSr4bq0AuHmVpIC9I/IjD4vg
 jb00vVmian6W/austjcD1r+vLxUNraYIm3Q/3cvX2lcan1qZZSVUHYjgNSk2oAdc5XL2YG
 +mz8KMHQ3TYW0T/ElWbLKtNI85k+tIY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-613-AcFO1_xMMra8qWg723Wr8w-1; Fri,
 29 Aug 2025 05:24:08 -0400
X-MC-Unique: AcFO1_xMMra8qWg723Wr8w-1
X-Mimecast-MFC-AGG-ID: AcFO1_xMMra8qWg723Wr8w_1756459447
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 148F2195C279; Fri, 29 Aug 2025 09:24:07 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.4])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6014630001BB; Fri, 29 Aug 2025 09:24:06 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B9BA921E6A27; Fri, 29 Aug 2025 11:24:03 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Jonah Palmer <jonah.palmer@oracle.com>
Cc: qemu-devel@nongnu.org,  peterx@redhat.com,  farosas@suse.de,
 eblake@redhat.com,  jasowang@redhat.com,  mst@redhat.com,
 si-wei.liu@oracle.com,  eperezma@redhat.com,  boris.ostrovsky@oracle.com
Subject: Re: [RFC 1/6] migration: Add virtio-iterative capability
In-Reply-To: <985602de-88a8-46a9-9b76-e494c9f4ac33@oracle.com> (Jonah Palmer's
 message of "Thu, 28 Aug 2025 11:29:50 -0400")
References: <20250722124127.2497406-1-jonah.palmer@oracle.com>
 <20250722124127.2497406-2-jonah.palmer@oracle.com>
 <874iuihyxd.fsf@pond.sub.org>
 <5a8bb5ef-c500-4fac-b5fc-566408ae8ffc@oracle.com>
 <87h5xvsh9c.fsf@pond.sub.org>
 <2764b188-a4cd-40b8-95a7-ccec775d7db9@oracle.com>
 <87ecsypq85.fsf@pond.sub.org>
 <1636d435-d13d-489f-be59-5a225286b12a@oracle.com>
 <87sehdl17h.fsf@pond.sub.org>
 <985602de-88a8-46a9-9b76-e494c9f4ac33@oracle.com>
Date: Fri, 29 Aug 2025 11:24:03 +0200
Message-ID: <87cy8efpl8.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Jonah Palmer <jonah.palmer@oracle.com> writes:

> On 8/27/25 2:37 AM, Markus Armbruster wrote:
>> Jonah Palmer <jonah.palmer@oracle.com> writes:
>> 
>>> On 8/26/25 2:11 AM, Markus Armbruster wrote:
>>>> Jonah Palmer <jonah.palmer@oracle.com> writes:
>>>>
>>>>> On 8/25/25 8:44 AM, Markus Armbruster wrote:
>>>>
>>>> [...]
>>>>
>>>>>> Jonah Palmer <jonah.palmer@oracle.com> writes:
>>>>>>
>>>>>>> On 8/8/25 6:48 AM, Markus Armbruster wrote:
>>>>
>>>> [...]
>>>>
>>>>>>>> Jonah Palmer <jonah.palmer@oracle.com> writes:
>>>>>>>>> Adds a new migration capability 'virtio-iterative' that will allow
>>>>>>>>> virtio devices, where supported, to iteratively migrate configuration
>>>>>>>>> changes that occur during the migration process.
>>>>>>>>
>>>>>>>> Why is that desirable?
>>>>>>>
>>>>>>> To be frank, I wasn't sure if having a migration capability, or even
>>>>>>> have it toggleable at all, would be desirable or not. It appears though
>>>>>>> that this might be better off as a per-device feature set via
>>>>>>> --device virtio-net-pci,iterative-mig=on,..., for example.
>>>>>>
>>>>>> See below.
>>>>>>
>>>>>>> And by "iteratively migrate configuration changes" I meant more along
>>>>>>> the lines of the device's state as it continues running on the source.
>>>>>>
>>>>>> Isn't that what migration does always?
>>>>>
>>>>> Essentially yes, but today all of the state is only migrated at the end, once the source has been paused. So the final correct state is always sent to the destination.
>>>>
>>>> As far as I understand (and ignoring lots of detail, including post
>>>> copy), we have three stages:
>>>>
>>>> 1. Source runs, migrate memory pages.  Pages that get dirtied after they
>>>> are migrated need to be migrated again.
>>>>
>>>> 2. Neither source or destination runs, migrate remaining memory pages
>>>> and device state.
>>>>
>>>> 3. Destination starts to run.
>>>>
>>>> If the duration of stage 2 (downtime) was of no concern, we'd switch to
>>>> it immediately, i.e. without migrating anything in stage 1.  This would
>>>> minimize I/O.
>>>>
>>>> Of course, we actually care for limiting downtime.  We switch to stage 2
>>>> when "little enough" is left for stage two to migrate.
>>>>
>>>>> If we're no longer waiting until the source has been paused and the initial state is sent early, then we need to make sure that any changes that happen is still communicated to the destination.
>>>>
>>>> So you're proposing to treat suitable parts of the device state more
>>>> like memory pages.  Correct?
>>>>
>>>
>>> Not in the sense of "something got dirtied so let's immediately re-send
>>> that" like we would with RAM. It's more along the lines of "something
>>> got dirtied so let's make sure that gets re-sent at the start of stage 2".
>> 
>> Or is it "something might have dirtied, just resend in stage 2"?
>> 
>
> Exactly. This is better wording since it doesn't necessarily have to be 
> sent at the "start" of stage 2. Just at some point during it.

Got it.

>>> The entire state of a virtio-net device (even with vhost-net /
>>> vhost-vDPA) is <10KB I believe. I don't believe there's much to gain by
>>> "iteratively" re-sending changes for virtio-net. It should be suitable
>>> enough to just re-send whatever changed during stage 1 (after the
>>> initial state was sent) at the start of stage 2.
>> 
>> Got it.
>> 
>>> This is why I'm currently looking into a solution that uses VMSD's
>>> .early_setup flag (that Peter recommended) rather than implementing a
>>> suite of SaveVMHandlers hooks (like this RFC does). We don't need this
>>> iterative capability as much as we need to start migrating the state
>>> earlier (and doing corresponding config/prep work) during stage 1.
>>>
>>>> Cover letter and commit message of PATCH 4 provide the motivation: you
>>>> observe a shorter downtime.  You speculate this is due to moving "heavy
>>>> allocations and page-fault latencies" from stage 2 to stage 1.  Correct?
>>>
>>> Correct. But again I'd like to stress that this is just one part in
>>> reducing downtime during stage 2. The biggest reductions will come from
>>> the config/prep work that we're trying to move from stage 2 to stage 1,
>>> especially when vhost-vDPA is involved. And we can only do this early
>>> work once we have the state, hence why we're sending it earlier.
>> 
>> This is an important bit of detail I've been missing so far.  Easy
>> enough to fix in a future commit message and cover letter.
>> 
>
> Ack.
>
>>>> Is there anything that makes virtio-net particularly suitable?
>>>
>>> Yes, especially with vhost-vDPA and configuring VQs. See Eugenio's
>>> comment here
>>> https://urldefense.com/v3/__https://lore.kernel.org/qemu-devel/CAJaqyWdUutZrAWKy9d=ip*h*y3BnptUrcL8Xj06XfizNxPtfpw@mail.gmail.com/__;Kys!!ACWV5N9M2RV99hQ!MHkMmGR7j2n9i2We6Mh3xXX03yEve90Bhs0aEDCVYU4Z0n-op-0aDlpWMBGZ7CpjDOBnhTkDVJjx8QcQ$ .
>> 
>> Such prep work commonly depends only on device configuration, not state.
>> I'm curious: what state bits exactly does the prep work need?
>> 
>> Device configuration is available at the start of stage 1, state is
>> fully available only at the end of stage 2.
>> 
>
> We pretty much need, more or less, all of the state of the VirtIODevice 
> itself as well as the bits of the VirtIONet device. Essentially, barring 
> ring indices, we'd need whatever is required throughout most of the 
> device's startup routine.
>
> In this series, we get everything we need from the vmstate_save_state(f, 
> &vmstate_virtio_net, ...) and vmstate_load_state(f, &vmstate_virtio_net, 
> ...) calls early during stage 1 (see patch 4/6).
>
> Once we've gotten this data, we can start on the prep work that's 
> normally done today during stage 2.

This is unusual.  I'd like to understand it better.

Non-migration startup:

1. We create the device.  This runs its .init().

2. We configure the device by setting device properties.

3. We realize the device.  This runs its .realize(), which initializes
the device state according to its configuration.

4. The guest interacts with the device.  Device state changes.

When is the expensive prep work we've been discussing done here?

>> Your patches make *tentative* device state available in stage 1.
>> Tentative, because it may still change afterwards.
>> 
>> You use tentative state to do certain expensive work in stage 1 already,
>> in order to cut downtime in stage 2.
>> 
>> Fair?
>
> Correct.

Got it.

>> Can state change in ways that invalidate this work?
>> 
>
> If, for some reason, the guest wanted to change everything during 
> migration (specifically during stage 1), then it'd more or less negate 
> the early prep work we'd've done. How impactful this is would depend on 
> which route we go (see below). God forbid the guest just wait until 
> migration is complete.

So the answer is yes.

>> If yes, how do you handle this?
>> 
>
> So it depends on the route this series goes. That is, whether we go the 
> truly iterative SaveVMHandlers hooks route (which this series uses) or 
> if we go the early_setup VMSD route (which Peter recommended).
>
> ---
>
> If we go the truly iterative route, then technically we can still handle 
> these changes during stage 1 and still keep the work out of stage 2.
>
> However, given the nicheness of such a corner case (where things are 
> being changed last minute during migration), handling these changes 
> iteratively might be overdesign.
>
> And we'd have to guard against the scenario where the guest acts 
> maliciously by constantly changing things to prevent migration from 
> continuing.

Yes.

> ---
>
> If we go the early_setup VMSD route, where we get one shot early to do 
> stuff during stage 1 and one last shot to do things later during stage 
> 2, then the more that gets changed means the less beneficial this early 
> work becomes. This is because any changes made during stage 1 could only 
> be handled during stage 2, which is what this overall effort is trying 
> to minimize.

Stupidest solution that could possibly work: if anything impacting the
prep work changed, redo it from scratch.

>> If no, do you verify the "no change" design assumption holds?
>> 
>
> When it comes to early migration for devices, we can never support a "no 
> change" design assumption. The difference in the design lies in how (and 
> when) such changes are handled during migration.

Just checking :)

[...]

>>>>>>> But I think for now this is better left as a virtio-net configuration
>>>>>>> rather than as a migration capability (e.g. --device
>>>>>>> virtio-net-pci,iterative-mig=on/off,...)
>>>>>>
>>>>>> Makes sense to me (but I'm not a migration expert).
>>>>
>>>> A device property's default can depend on the machine type via compat
>>>> properties.  This is normally used to restrict a guest-visible change to
>>>> newer machine types.  Here, it's not guest-visible.  But it can get you
>>>> this:
>>>>
>>>> * Migrate new machine type from new QEMU to new QEMU (old QEMU doesn't
>>>>     have the machine type): iterative is enabled by default.  Good.  User
>>>>     can disable it on both ends to not get the improvement.  Enabling it
>>>>     on just one breaks migration.
>>>>
>>>>     All other cases go away with time.
>>>>
>>>> * Migrate old machine type from new QEMU to new QEMU: iterative is
>>>>     disabled by default, which is sad, but no worse than before.  User can
>>>>     enable it on both ends to get the improvement.  Enabling it on just
>>>>     one breaks migration.
>>>>
>>>> * Migrate old machine type from new QEMU to old QEMU or vice versa:
>>>>     iterative is off by default.  Good.  Enabling it on the new one breaks
>>>>     migration.
>>>>
>>>> * Migrate old machine type from old QEMU to old QEMU: iterative is off
>>>>
>>>> I figure almost all users could simply ignore this configuration knob
>>>> then.
>>>
>>> Oh, that's interesting. I wasn't aware of this. But couldn't this
>>> potentially cause some headaches and confusion when attempting to
>>> migrate between 2 guests where one VM is using a machine type does
>>> support it and the other isn't?
>>>
>>> For example, the source and destination VMs both specify '-machine
>>> q35,...' and the q35 alias resolves into, say, pc-q35-10.1 for the
>>> source VM and pc-q35-10.0 for the destination VM. And say this property
>>> is supported on >= pc-q35-10.1.
>> 
>> In my understanding, migration requires identical machine types on both
>> ends, and all bets are off when they're different.
>> 
>
> Ah, true.
>
>>> IIUC, this would mean that iterative is enabled by default on the source
>>> VM but disabled by default on the destination VM.
>>>
>>> Then a user attempts the migration, the migration fails, and then they'd
>>> have to try and figure out why it's failing.
>> 
>> Migration failures due to mismatched configuration tend to be that way,
>> don't they?
>> 
>
> Right.
>
> So if we pin this feature to always be enabled for machine type, say, >= 
> pc-q35-XX.X, then can we assume that both guests can actually support 
> this feature?
>
> In other words, conversely, is it possible in production that both 
> guests use pc-q35-XX.X but one build supports this early migration 
> feature and the other doesn't?

I'd call that a bug.

Here's how we commonly code property defaulds depending on the machine
type.

The property defaults to the new default (here: feature enabled).

Machine types older than the current (unreleased) one use a compat
property to change it the old default (here: feature disabled).  With
this value, the device must be compatible with its older versions in
prior release of QEMU, both for guest and for migration.

Once you got that right, it's fairly unlikely to break accidentally.

The current machine type then defaults the feature to enabled in the
current and all future versions of QEMU.  The machine type doesn't exist
in older versions of QEMU.

Older machine types default it to disabled in the current and all future
versions of QEMU, which is compatible with older versions of QEMU.

> If we can assume that, then this would probably be the right approach 
> for something like this.
>
>>> Furthermore, since it's a device property that's essentially set at VM
>>> creation time, either the source would have to be reset and explicitly
>>> set this property to off or the destination would have to be reset and
>>> use a newer (>= pc-q35-10.1) machine type before starting it back up and
>>> perform the migration.
>> 
>> You can use qom-set to change a device property after you created the
>> device.  It might even work.  However, qom-set is a deeply problematic
>> and seriously underdocumented interface.  Avoid.
>> 
>> But will you need to change it?
>> 
>> If you started the source with an explicit property value, start the
>> destination the same way.  Same as for any number of other configuration
>> knobs.
>> 
>> If you started the source with the default property value, start the
>> destination the same way.  Values will match as long as the machine type
>> matches, as it should.
>> 
>
> Given that migration can only be done with matching machine types and if 
> we can assume that guests using pc-q35-XX.X, for example, will always 
> have this support, then my concerns about this are allayed.

Glad I was able to assist here!

>>> Am I understanding this correctly?
>>>
>>>>>> [...]
>> 


