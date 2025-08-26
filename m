Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08408CA0EE4
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 06:13:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqmu9-0003UA-3U; Tue, 26 Aug 2025 02:11:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uqmu4-0003TB-Ki
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 02:11:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uqmtu-0002eo-Ah
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 02:11:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756188673;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NfgGO2Kr8TuxewRI5AqbtyXP3dkRsvCWIw5wnsxpplM=;
 b=CtqmzveT9WWYLqpxBQDO13Rwbvjaku1CoExmifARCXo7J0/AS/wSbV7R4Imm7dS8wQQO3y
 PdP4LwM6xY8sy/+xpgc+knKK2jRVf4rmXBTdwJ+QyUa3k6G1SHpeprtF+g17LGQxWYTHyc
 K2JqrZiGtmrEQySo654ORCw3JAwH96c=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-146-DEtakiW4N2mnm1ODv1SmVA-1; Tue,
 26 Aug 2025 02:11:11 -0400
X-MC-Unique: DEtakiW4N2mnm1ODv1SmVA-1
X-Mimecast-MFC-AGG-ID: DEtakiW4N2mnm1ODv1SmVA_1756188670
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 029281956089; Tue, 26 Aug 2025 06:11:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.4])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 427481955F24; Tue, 26 Aug 2025 06:11:09 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6ED7C21E6A27; Tue, 26 Aug 2025 08:11:06 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Jonah Palmer <jonah.palmer@oracle.com>
Cc: qemu-devel@nongnu.org,  peterx@redhat.com,  farosas@suse.de,
 eblake@redhat.com,  jasowang@redhat.com,  mst@redhat.com,
 si-wei.liu@oracle.com,  eperezma@redhat.com,  boris.ostrovsky@oracle.com
Subject: Re: [RFC 1/6] migration: Add virtio-iterative capability
In-Reply-To: <2764b188-a4cd-40b8-95a7-ccec775d7db9@oracle.com> (Jonah Palmer's
 message of "Mon, 25 Aug 2025 10:57:47 -0400")
References: <20250722124127.2497406-1-jonah.palmer@oracle.com>
 <20250722124127.2497406-2-jonah.palmer@oracle.com>
 <874iuihyxd.fsf@pond.sub.org>
 <5a8bb5ef-c500-4fac-b5fc-566408ae8ffc@oracle.com>
 <87h5xvsh9c.fsf@pond.sub.org>
 <2764b188-a4cd-40b8-95a7-ccec775d7db9@oracle.com>
Date: Tue, 26 Aug 2025 08:11:06 +0200
Message-ID: <87ecsypq85.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

> On 8/25/25 8:44 AM, Markus Armbruster wrote:

[...]

>> Jonah Palmer <jonah.palmer@oracle.com> writes:
>> 
>>> On 8/8/25 6:48 AM, Markus Armbruster wrote:

[...]

>>>> Jonah Palmer <jonah.palmer@oracle.com> writes:
>>>>> Adds a new migration capability 'virtio-iterative' that will allow
>>>>> virtio devices, where supported, to iteratively migrate configuration
>>>>> changes that occur during the migration process.
>>>>
>>>> Why is that desirable?
>>>
>>> To be frank, I wasn't sure if having a migration capability, or even
>>> have it toggleable at all, would be desirable or not. It appears though
>>> that this might be better off as a per-device feature set via
>>> --device virtio-net-pci,iterative-mig=on,..., for example.
>> 
>> See below.
>> 
>>> And by "iteratively migrate configuration changes" I meant more along
>>> the lines of the device's state as it continues running on the source.
>> 
>> Isn't that what migration does always?
>
> Essentially yes, but today all of the state is only migrated at the end, once the source has been paused. So the final correct state is always sent to the destination.

As far as I understand (and ignoring lots of detail, including post
copy), we have three stages:

1. Source runs, migrate memory pages.  Pages that get dirtied after they
are migrated need to be migrated again.

2. Neither source or destination runs, migrate remaining memory pages
and device state.

3. Destination starts to run.

If the duration of stage 2 (downtime) was of no concern, we'd switch to
it immediately, i.e. without migrating anything in stage 1.  This would
minimize I/O.

Of course, we actually care for limiting downtime.  We switch to stage 2
when "little enough" is left for stage two to migrate.

> If we're no longer waiting until the source has been paused and the initial state is sent early, then we need to make sure that any changes that happen is still communicated to the destination.

So you're proposing to treat suitable parts of the device state more
like memory pages.  Correct?

Cover letter and commit message of PATCH 4 provide the motivation: you
observe a shorter downtime.  You speculate this is due to moving "heavy
allocations and page-fault latencies" from stage 2 to stage 1.  Correct?

Is there anything that makes virtio-net particularly suitable?

I think this patch's commit message should at least hint at the
motivation at a high level.  Details like measurements are best left to
PATCH 4.

> This RFC handles this by just re-sending the entire state again once the source has been paused. But of course this isn't optimal and I'm looking into how to better optimize this part.

How much is the entire state?

>>> But perhaps actual configuration changes (e.g. changing the number of
>>> queue pairs) could also be supported mid-migration like this?
>>
>> I don't know.
>> 
>>>>> This capability is added to the validated capabilities list to ensure
>>>>> both the source and destination support it before enabling.
>>>>
>>>> What happens when only one side enables it?
>>>
>>> The migration stream breaks if only one side enables it.
>>
>> How does it break?  Error message pointing out the misconfiguration?
>> 
>
> The destination VM is torn down and the source just reports that migration failed.

Exact same failure as for other misconfigurations, like missing a device
on the destination?

> I don't believe the source/destination could be aware of the misconfiguration. IIUC the destination reads the migration stream and expects certain pieces of data in a certain order. If new data is added to the migration stream or the order has changed and the destination isn't expecting it, then the migration fails. It doesn't know exactly why, just that it read-in data that it wasn't expecting.
>
>>> This is poor wording on my part, my apologies. I don't think it's even
>>> possible to know the capabilities between the source & destination.
>>>
>>>>> The capability defaults to off to maintain backward compatibility.
>>>>>
>>>>> To enable the capability via HMP:
>>>>> (qemu) migrate_set_capability virtio-iterative on
>>>>>
>>>>> To enable the capability via QMP:
>>>>> {"execute": "migrate-set-capabilities", "arguments": {
>>>>>        "capabilities": [
>>>>>           { "capability": "virtio-iterative", "state": true }
>>>>>        ]
>>>>>     }
>>>>> }
>>>>>
>>>>> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>

[...]

>>>>> diff --git a/qapi/migration.json b/qapi/migration.json
>>>>> index 4963f6ca12..8f042c3ba5 100644
>>>>> --- a/qapi/migration.json
>>>>> +++ b/qapi/migration.json
>>>>> @@ -479,6 +479,11 @@
>>>>>  #     each RAM page.  Requires a migration URI that supports seeking,
>>>>>  #     such as a file.  (since 9.0)
>>>>>  #
>>>>> +# @virtio-iterative: Enable iterative migration for virtio devices, if
>>>>> +#     the device supports it. When enabled, and where supported, virtio
>>>>> +#     devices will track and migrate configuration changes that may
>>>>> +#     occur during the migration process. (Since 10.1)
>>>>
>>>> When and why should the user enable this?
>>>
>>> Well if all goes according to plan, always (at least for virtio-net).
>>> This should improve the overall speed of live migration for a virtio-net
>>> device (and vhost-net/vhost-vdpa).
>> 
>> So the only use for "disabled" would be when migrating to or from an
>> older version of QEMU that doesn't support this.  Fair?
>
> Correct.
>
>> What's the default?
>
> Disabled.

Awkward for something that should always be enabled.  But see below.

Please document defaults in the doc comment.

>>>> What exactly do you mean by "where supported"?
>>>
>>> I meant if both source's Qemu and destination's Qemu support it, as well
>>> as for other virtio devices in the future if they decide to implement
>>> iterative migration (e.g. a more general "enable iterative migration for
>>> virtio devices").
>>>
>>> But I think for now this is better left as a virtio-net configuration
>>> rather than as a migration capability (e.g. --device
>>> virtio-net-pci,iterative-mig=on/off,...)
>> 
>> Makes sense to me (but I'm not a migration expert).

A device property's default can depend on the machine type via compat
properties.  This is normally used to restrict a guest-visible change to
newer machine types.  Here, it's not guest-visible.  But it can get you
this:

* Migrate new machine type from new QEMU to new QEMU (old QEMU doesn't
  have the machine type): iterative is enabled by default.  Good.  User
  can disable it on both ends to not get the improvement.  Enabling it
  on just one breaks migration.

  All other cases go away with time.

* Migrate old machine type from new QEMU to new QEMU: iterative is
  disabled by default, which is sad, but no worse than before.  User can
  enable it on both ends to get the improvement.  Enabling it on just
  one breaks migration.

* Migrate old machine type from new QEMU to old QEMU or vice versa:
  iterative is off by default.  Good.  Enabling it on the new one breaks
  migration.

* Migrate old machine type from old QEMU to old QEMU: iterative is off

I figure almost all users could simply ignore this configuration knob
then.

>> [...]


