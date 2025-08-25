Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 187DFCA0EFA
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Aug 2025 12:46:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqWZ9-0003Wp-3w; Mon, 25 Aug 2025 08:44:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uqWYr-0003TB-Bq
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 08:44:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uqWYi-0004ss-4M
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 08:44:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756125861;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QL4wSjC3PMMjVosQZlyktL0aiVxvonrjr1R4odKzRrs=;
 b=g3lDYXRxcp6MUMcuygQK1MNmS0nNoEO1Nn9rVhBqrCwzDvDdPLEU21JVPg7sYQ7IIykaGD
 oPc0y8u8+ck3nnUd//31NfTn12hq2WBsLt2KZsNsCOuZ7lcply98b6kY5lWXmWcHE7L6KE
 dHo5xUzAbfxww+DLxFYcOQNLM7eINVU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-534-G1jLcwv0PE-mJg-LcVgmHQ-1; Mon,
 25 Aug 2025 08:44:19 -0400
X-MC-Unique: G1jLcwv0PE-mJg-LcVgmHQ-1
X-Mimecast-MFC-AGG-ID: G1jLcwv0PE-mJg-LcVgmHQ_1756125858
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AAF9819560AA; Mon, 25 Aug 2025 12:44:18 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.4])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ED9BC1955F24; Mon, 25 Aug 2025 12:44:17 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3DC4521E6A27; Mon, 25 Aug 2025 14:44:15 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Jonah Palmer <jonah.palmer@oracle.com>
Cc: qemu-devel@nongnu.org,  peterx@redhat.com,  farosas@suse.de,
 eblake@redhat.com,  jasowang@redhat.com,  mst@redhat.com,
 si-wei.liu@oracle.com,  eperezma@redhat.com,  boris.ostrovsky@oracle.com
Subject: Re: [RFC 1/6] migration: Add virtio-iterative capability
In-Reply-To: <5a8bb5ef-c500-4fac-b5fc-566408ae8ffc@oracle.com> (Jonah Palmer's
 message of "Mon, 11 Aug 2025 08:18:17 -0400")
References: <20250722124127.2497406-1-jonah.palmer@oracle.com>
 <20250722124127.2497406-2-jonah.palmer@oracle.com>
 <874iuihyxd.fsf@pond.sub.org>
 <5a8bb5ef-c500-4fac-b5fc-566408ae8ffc@oracle.com>
Date: Mon, 25 Aug 2025 14:44:15 +0200
Message-ID: <87h5xvsh9c.fsf@pond.sub.org>
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Please excuse the delay, I was on vacation.

Jonah Palmer <jonah.palmer@oracle.com> writes:

> On 8/8/25 6:48 AM, Markus Armbruster wrote:
>> I apologize for the lateness of my review.

Late again: I was on vacation.

>> Jonah Palmer <jonah.palmer@oracle.com> writes:
>> 
>>> Adds a new migration capability 'virtio-iterative' that will allow
>>> virtio devices, where supported, to iteratively migrate configuration
>>> changes that occur during the migration process.
>> 
>> Why is that desirable?
>
> To be frank, I wasn't sure if having a migration capability, or even 
> have it toggleable at all, would be desirable or not. It appears though 
> that this might be better off as a per-device feature set via
> --device virtio-net-pci,iterative-mig=on,..., for example.

See below.

> And by "iteratively migrate configuration changes" I meant more along 
> the lines of the device's state as it continues running on the source.

Isn't that what migration does always?

> But perhaps actual configuration changes (e.g. changing the number of 
> queue pairs) could also be supported mid-migration like this?

I don't know.

>>> This capability is added to the validated capabilities list to ensure
>>> both the source and destination support it before enabling.
>> 
>> What happens when only one side enables it?
>
> The migration stream breaks if only one side enables it.

How does it break?  Error message pointing out the misconfiguration?

> This is poor wording on my part, my apologies. I don't think it's even 
> possible to know the capabilities between the source & destination.
>
>>> The capability defaults to off to maintain backward compatibility.
>>>
>>> To enable the capability via HMP:
>>> (qemu) migrate_set_capability virtio-iterative on
>>>
>>> To enable the capability via QMP:
>>> {"execute": "migrate-set-capabilities", "arguments": {
>>>       "capabilities": [
>>>          { "capability": "virtio-iterative", "state": true }
>>>       ]
>>>    }
>>> }
>>>
>>> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
>>> ---
>>>  migration/savevm.c  | 1 +
>>>  qapi/migration.json | 7 ++++++-
>>>  2 files changed, 7 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/migration/savevm.c b/migration/savevm.c
>>> index bb04a4520d..40a2189866 100644
>>> --- a/migration/savevm.c
>>> +++ b/migration/savevm.c
>>> @@ -279,6 +279,7 @@ static bool should_validate_capability(int capability)
>>>      switch (capability) {
>>>      case MIGRATION_CAPABILITY_X_IGNORE_SHARED:
>>>      case MIGRATION_CAPABILITY_MAPPED_RAM:
>>> +    case MIGRATION_CAPABILITY_VIRTIO_ITERATIVE:
>>>          return true;
>>>      default:
>>>          return false;
>>> diff --git a/qapi/migration.json b/qapi/migration.json
>>> index 4963f6ca12..8f042c3ba5 100644
>>> --- a/qapi/migration.json
>>> +++ b/qapi/migration.json
>>> @@ -479,6 +479,11 @@
>>>  #     each RAM page.  Requires a migration URI that supports seeking,
>>>  #     such as a file.  (since 9.0)
>>>  #
>>> +# @virtio-iterative: Enable iterative migration for virtio devices, if
>>> +#     the device supports it. When enabled, and where supported, virtio
>>> +#     devices will track and migrate configuration changes that may
>>> +#     occur during the migration process. (Since 10.1)
>> 
>> When and why should the user enable this?
>
> Well if all goes according to plan, always (at least for virtio-net). 
> This should improve the overall speed of live migration for a virtio-net 
> device (and vhost-net/vhost-vdpa).

So the only use for "disabled" would be when migrating to or from an
older version of QEMU that doesn't support this.  Fair?

What's the default?

>> What exactly do you mean by "where supported"?
>
> I meant if both source's Qemu and destination's Qemu support it, as well 
> as for other virtio devices in the future if they decide to implement 
> iterative migration (e.g. a more general "enable iterative migration for 
> virtio devices").
>
> But I think for now this is better left as a virtio-net configuration 
> rather than as a migration capability (e.g. --device 
> virtio-net-pci,iterative-mig=on/off,...)

Makes sense to me (but I'm not a migration expert).

[...]


