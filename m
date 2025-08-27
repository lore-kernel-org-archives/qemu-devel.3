Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB61DCA0EFF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 06:38:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ur9nD-0008Q5-NJ; Wed, 27 Aug 2025 02:37:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ur9nB-0008Kw-PC
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 02:37:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ur9n5-00074S-U0
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 02:37:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756276662;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EQj2cmVlC1Zs70xoxGgNrsGcVQISQ3GrUFuIYZoGapQ=;
 b=XCkG9GrD51nlReSzbWVQj6Jadha1kFtaBuHWXb5GaAyvsovnzVmLChdnSENYIqIETSsOez
 5JE9XWCrGpK7mhDNbk2RLa0b7VajIEvUPEBHBvCSPYiI5knrgtSyJkqfV6fQNmlwwLxVUW
 8GTAdqUBObWPUrrK1dHXehp4+zqXzyI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-562-ULGo_1yHOWeoDr1tYXksiw-1; Wed,
 27 Aug 2025 02:37:34 -0400
X-MC-Unique: ULGo_1yHOWeoDr1tYXksiw-1
X-Mimecast-MFC-AGG-ID: ULGo_1yHOWeoDr1tYXksiw_1756276653
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7C5F2180028E; Wed, 27 Aug 2025 06:37:26 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.4])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C01B119560AB; Wed, 27 Aug 2025 06:37:25 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DEF1C21E6A27; Wed, 27 Aug 2025 08:37:22 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Jonah Palmer <jonah.palmer@oracle.com>
Cc: qemu-devel@nongnu.org,  peterx@redhat.com,  farosas@suse.de,
 eblake@redhat.com,  jasowang@redhat.com,  mst@redhat.com,
 si-wei.liu@oracle.com,  eperezma@redhat.com,  boris.ostrovsky@oracle.com
Subject: Re: [RFC 1/6] migration: Add virtio-iterative capability
In-Reply-To: <1636d435-d13d-489f-be59-5a225286b12a@oracle.com> (Jonah Palmer's
 message of "Tue, 26 Aug 2025 14:08:00 -0400")
References: <20250722124127.2497406-1-jonah.palmer@oracle.com>
 <20250722124127.2497406-2-jonah.palmer@oracle.com>
 <874iuihyxd.fsf@pond.sub.org>
 <5a8bb5ef-c500-4fac-b5fc-566408ae8ffc@oracle.com>
 <87h5xvsh9c.fsf@pond.sub.org>
 <2764b188-a4cd-40b8-95a7-ccec775d7db9@oracle.com>
 <87ecsypq85.fsf@pond.sub.org>
 <1636d435-d13d-489f-be59-5a225286b12a@oracle.com>
Date: Wed, 27 Aug 2025 08:37:22 +0200
Message-ID: <87sehdl17h.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

> On 8/26/25 2:11 AM, Markus Armbruster wrote:
>> Jonah Palmer <jonah.palmer@oracle.com> writes:
>> 
>>> On 8/25/25 8:44 AM, Markus Armbruster wrote:
>> 
>> [...]
>> 
>>>> Jonah Palmer <jonah.palmer@oracle.com> writes:
>>>>
>>>>> On 8/8/25 6:48 AM, Markus Armbruster wrote:
>> 
>> [...]
>> 
>>>>>> Jonah Palmer <jonah.palmer@oracle.com> writes:
>>>>>>> Adds a new migration capability 'virtio-iterative' that will allow
>>>>>>> virtio devices, where supported, to iteratively migrate configuration
>>>>>>> changes that occur during the migration process.
>>>>>>
>>>>>> Why is that desirable?
>>>>>
>>>>> To be frank, I wasn't sure if having a migration capability, or even
>>>>> have it toggleable at all, would be desirable or not. It appears though
>>>>> that this might be better off as a per-device feature set via
>>>>> --device virtio-net-pci,iterative-mig=on,..., for example.
>>>>
>>>> See below.
>>>>
>>>>> And by "iteratively migrate configuration changes" I meant more along
>>>>> the lines of the device's state as it continues running on the source.
>>>>
>>>> Isn't that what migration does always?
>>>
>>> Essentially yes, but today all of the state is only migrated at the end, once the source has been paused. So the final correct state is always sent to the destination.
>> 
>> As far as I understand (and ignoring lots of detail, including post
>> copy), we have three stages:
>> 
>> 1. Source runs, migrate memory pages.  Pages that get dirtied after they
>> are migrated need to be migrated again.
>> 
>> 2. Neither source or destination runs, migrate remaining memory pages
>> and device state.
>> 
>> 3. Destination starts to run.
>> 
>> If the duration of stage 2 (downtime) was of no concern, we'd switch to
>> it immediately, i.e. without migrating anything in stage 1.  This would
>> minimize I/O.
>> 
>> Of course, we actually care for limiting downtime.  We switch to stage 2
>> when "little enough" is left for stage two to migrate.
>> 
>>> If we're no longer waiting until the source has been paused and the initial state is sent early, then we need to make sure that any changes that happen is still communicated to the destination.
>> 
>> So you're proposing to treat suitable parts of the device state more
>> like memory pages.  Correct?
>> 
>
> Not in the sense of "something got dirtied so let's immediately re-send 
> that" like we would with RAM. It's more along the lines of "something 
> got dirtied so let's make sure that gets re-sent at the start of stage 2".

Or is it "something might have dirtied, just resend in stage 2"?

> The entire state of a virtio-net device (even with vhost-net / 
> vhost-vDPA) is <10KB I believe. I don't believe there's much to gain by 
> "iteratively" re-sending changes for virtio-net. It should be suitable 
> enough to just re-send whatever changed during stage 1 (after the 
> initial state was sent) at the start of stage 2.

Got it.

> This is why I'm currently looking into a solution that uses VMSD's 
> .early_setup flag (that Peter recommended) rather than implementing a 
> suite of SaveVMHandlers hooks (like this RFC does). We don't need this 
> iterative capability as much as we need to start migrating the state 
> earlier (and doing corresponding config/prep work) during stage 1.
>
>> Cover letter and commit message of PATCH 4 provide the motivation: you
>> observe a shorter downtime.  You speculate this is due to moving "heavy
>> allocations and page-fault latencies" from stage 2 to stage 1.  Correct?
>
> Correct. But again I'd like to stress that this is just one part in 
> reducing downtime during stage 2. The biggest reductions will come from 
> the config/prep work that we're trying to move from stage 2 to stage 1, 
> especially when vhost-vDPA is involved. And we can only do this early 
> work once we have the state, hence why we're sending it earlier.

This is an important bit of detail I've been missing so far.  Easy
enough to fix in a future commit message and cover letter.

>> Is there anything that makes virtio-net particularly suitable?
>
> Yes, especially with vhost-vDPA and configuring VQs. See Eugenio's 
> comment here 
> https://lore.kernel.org/qemu-devel/CAJaqyWdUutZrAWKy9d=ip+h+y3BnptUrcL8Xj06XfizNxPtfpw@mail.gmail.com/.

Such prep work commonly depends only on device configuration, not state.
I'm curious: what state bits exactly does the prep work need?

Device configuration is available at the start of stage 1, state is
fully available only at the end of stage 2.

Your patches make *tentative* device state available in stage 1.
Tentative, because it may still change afterwards.

You use tentative state to do certain expensive work in stage 1 already,
in order to cut downtime in stage 2.

Fair?

Can state change in ways that invalidate this work?

If yes, how do you handle this?

If no, do you verify the "no change" design assumption holds?

>> I think this patch's commit message should at least hint at the
>> motivation at a high level.  Details like measurements are best left to
>> PATCH 4.
>
> You're right, this was my bad for not framing this RFC more clearly and 
> the true motivations behind it. I will certainly be more direct and 
> descriptive in the next RFC for this effort.
>
>>> This RFC handles this by just re-sending the entire state again once the source has been paused. But of course this isn't optimal and I'm looking into how to better optimize this part.
>> 
>> How much is the entire state?
>
> I'm not exactly sure how large it is but it should be <10KB even with 
> vhost-vDPA. It could be slightly larger if we really up the number of 
> queue pairs and/or have huge MAC/multicast lists.

No worries then.

>>>>> But perhaps actual configuration changes (e.g. changing the number of
>>>>> queue pairs) could also be supported mid-migration like this?
>>>>
>>>> I don't know.
>>>>
>>>>>>> This capability is added to the validated capabilities list to ensure
>>>>>>> both the source and destination support it before enabling.
>>>>>>
>>>>>> What happens when only one side enables it?
>>>>>
>>>>> The migration stream breaks if only one side enables it.
>>>>
>>>> How does it break?  Error message pointing out the misconfiguration?
>>>>
>>>
>>> The destination VM is torn down and the source just reports that migration failed.
>> 
>> Exact same failure as for other misconfigurations, like missing a device
>> on the destination?
>
> I hesitate to say "exact" but for example, when missing a device on one 
> side you might see something like below (I removed a serial device):
>
> qemu-system-x86_64: Unknown ramblock "0000:00:03.0/virtio-net-pci.rom", 
> cannot accept migration
> qemu-system-x86_64: error while loading state for instance 0x0 of device 
> 'ram'
> qemu-system-x86_64: load of migration failed: Invalid argument
> ...

Aside: ugly error cascade due to migration's well-known failure to
propagate errors up properly.

> The expected order gets messed up and eventually the wrong data will end 
> up somewhere else. In this case it was the RAM.

It's messy.  If we started on a green field today, we'd do better, I
hope.

What error message do you observe when only one side enables
@virtio-iterative?  Question is moot if you plan to switch to a
different interface.  Answer it for that interface in a commit message
then.

>>> I don't believe the source/destination could be aware of the misconfiguration. IIUC the destination reads the migration stream and expects certain pieces of data in a certain order. If new data is added to the migration stream or the order has changed and the destination isn't expecting it, then the migration fails. It doesn't know exactly why, just that it read-in data that it wasn't expecting.
>>>
>>>>> This is poor wording on my part, my apologies. I don't think it's even
>>>>> possible to know the capabilities between the source & destination.
>>>>>
>>>>>>> The capability defaults to off to maintain backward compatibility.
>>>>>>>
>>>>>>> To enable the capability via HMP:
>>>>>>> (qemu) migrate_set_capability virtio-iterative on
>>>>>>>
>>>>>>> To enable the capability via QMP:
>>>>>>> {"execute": "migrate-set-capabilities", "arguments": {
>>>>>>>         "capabilities": [
>>>>>>>            { "capability": "virtio-iterative", "state": true }
>>>>>>>         ]
>>>>>>>      }
>>>>>>> }
>>>>>>>
>>>>>>> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
>> 
>> [...]
>> 
>>>>>>> diff --git a/qapi/migration.json b/qapi/migration.json
>>>>>>> index 4963f6ca12..8f042c3ba5 100644
>>>>>>> --- a/qapi/migration.json
>>>>>>> +++ b/qapi/migration.json
>>>>>>> @@ -479,6 +479,11 @@
>>>>>>>   #     each RAM page.  Requires a migration URI that supports seeking,
>>>>>>>   #     such as a file.  (since 9.0)
>>>>>>>   #
>>>>>>> +# @virtio-iterative: Enable iterative migration for virtio devices, if
>>>>>>> +#     the device supports it. When enabled, and where supported, virtio
>>>>>>> +#     devices will track and migrate configuration changes that may
>>>>>>> +#     occur during the migration process. (Since 10.1)
>>>>>>
>>>>>> When and why should the user enable this?
>>>>>
>>>>> Well if all goes according to plan, always (at least for virtio-net).
>>>>> This should improve the overall speed of live migration for a virtio-net
>>>>> device (and vhost-net/vhost-vdpa).
>>>>
>>>> So the only use for "disabled" would be when migrating to or from an
>>>> older version of QEMU that doesn't support this.  Fair?
>>>
>>> Correct.
>>>
>>>> What's the default?
>>>
>>> Disabled.
>> 
>> Awkward for something that should always be enabled.  But see below.
>> 
>> Please document defaults in the doc comment.
>
> Ack.
>
>>>>>> What exactly do you mean by "where supported"?
>>>>>
>>>>> I meant if both source's Qemu and destination's Qemu support it, as well
>>>>> as for other virtio devices in the future if they decide to implement
>>>>> iterative migration (e.g. a more general "enable iterative migration for
>>>>> virtio devices").
>>>>>
>>>>> But I think for now this is better left as a virtio-net configuration
>>>>> rather than as a migration capability (e.g. --device
>>>>> virtio-net-pci,iterative-mig=on/off,...)
>>>>
>>>> Makes sense to me (but I'm not a migration expert).
>> 
>> A device property's default can depend on the machine type via compat
>> properties.  This is normally used to restrict a guest-visible change to
>> newer machine types.  Here, it's not guest-visible.  But it can get you
>> this:
>> 
>> * Migrate new machine type from new QEMU to new QEMU (old QEMU doesn't
>>    have the machine type): iterative is enabled by default.  Good.  User
>>    can disable it on both ends to not get the improvement.  Enabling it
>>    on just one breaks migration.
>> 
>>    All other cases go away with time.
>> 
>> * Migrate old machine type from new QEMU to new QEMU: iterative is
>>    disabled by default, which is sad, but no worse than before.  User can
>>    enable it on both ends to get the improvement.  Enabling it on just
>>    one breaks migration.
>> 
>> * Migrate old machine type from new QEMU to old QEMU or vice versa:
>>    iterative is off by default.  Good.  Enabling it on the new one breaks
>>    migration.
>> 
>> * Migrate old machine type from old QEMU to old QEMU: iterative is off
>> 
>> I figure almost all users could simply ignore this configuration knob
>> then.
>
> Oh, that's interesting. I wasn't aware of this. But couldn't this 
> potentially cause some headaches and confusion when attempting to 
> migrate between 2 guests where one VM is using a machine type does 
> support it and the other isn't?
>
> For example, the source and destination VMs both specify '-machine 
> q35,...' and the q35 alias resolves into, say, pc-q35-10.1 for the 
> source VM and pc-q35-10.0 for the destination VM. And say this property 
> is supported on >= pc-q35-10.1.

In my understanding, migration requires identical machine types on both
ends, and all bets are off when they're different.

> IIUC, this would mean that iterative is enabled by default on the source 
> VM but disabled by default on the destination VM.
>
> Then a user attempts the migration, the migration fails, and then they'd 
> have to try and figure out why it's failing.

Migration failures due to mismatched configuration tend to be that way,
don't they?

> Furthermore, since it's a device property that's essentially set at VM 
> creation time, either the source would have to be reset and explicitly 
> set this property to off or the destination would have to be reset and 
> use a newer (>= pc-q35-10.1) machine type before starting it back up and 
> perform the migration.

You can use qom-set to change a device property after you created the
device.  It might even work.  However, qom-set is a deeply problematic
and seriously underdocumented interface.  Avoid.

But will you need to change it?

If you started the source with an explicit property value, start the
destination the same way.  Same as for any number of other configuration
knobs.

If you started the source with the default property value, start the
destination the same way.  Values will match as long as the machine type
matches, as it should.

> Am I understanding this correctly?
>
>>>> [...]


