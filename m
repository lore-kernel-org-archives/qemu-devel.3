Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F76CC47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 16:06:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfMRM-0005Co-Mj; Wed, 28 Feb 2024 11:05:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rfMRJ-0005Bz-US
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 11:05:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rfMRI-0008Up-DC
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 11:05:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709136345;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kBNwXc67SiFORFG1LmOX7laS8eO6UYP0egl136423HU=;
 b=AUGXjnwVeLOhVk6TVpDGG/O3/RFJTA8IuGHHXAWe6OsQ962YtSbsiXdAL5b85ezyy+iXor
 i4Z4JtaZM8/bzFYiMD+TvSRUfbIGkD2z6vg6NV+nhR43myXK5IEMDFWIWHSfIPHfjPxpgA
 l5lQAaaU8EzeNHIYPbfQBZwtXPSAsd0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-QGcBvzGUMZ-IQZ2h6C-IAg-1; Wed, 28 Feb 2024 11:05:41 -0500
X-MC-Unique: QGcBvzGUMZ-IQZ2h6C-IAg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4A023868670;
 Wed, 28 Feb 2024 16:05:41 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.4])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0D96640C94AB;
 Wed, 28 Feb 2024 16:05:40 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A39C821E66F4; Wed, 28 Feb 2024 17:05:39 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Fabiano Rosas
 <farosas@suse.de>,  "Michael S. Tsirkin" <mst@redhat.com>,  Jason Wang
 <jasowang@redhat.com>,  Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>,  Gerd Hoffmann <kraxel@redhat.com>,
 Marc-Andre Lureau <marcandre.lureau@redhat.com>,  David Hildenbrand
 <david@redhat.com>
Subject: Re: [PATCH V4 14/14] migration: options incompatible with cpr
In-Reply-To: <d54495fa-063d-4cb0-9e6a-4a57a312237d@oracle.com> (Steven
 Sistare's message of "Wed, 28 Feb 2024 08:23:01 -0500")
References: <1708622920-68779-1-git-send-email-steven.sistare@oracle.com>
 <1708622920-68779-15-git-send-email-steven.sistare@oracle.com>
 <87cysh3vg0.fsf@pond.sub.org>
 <d54495fa-063d-4cb0-9e6a-4a57a312237d@oracle.com>
Date: Wed, 28 Feb 2024 17:05:39 +0100
Message-ID: <87il28vajw.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Steven Sistare <steven.sistare@oracle.com> writes:

> On 2/28/2024 2:21 AM, Markus Armbruster wrote:
>> Steve Sistare <steven.sistare@oracle.com> writes:
>> 
>>> Fail the migration request if options are set that are incompatible
>>> with cpr.
>>>
>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

[...]

>>> diff --git a/qapi/migration.json b/qapi/migration.json
>>> index 0990297..c6bfe2e 100644
>>> --- a/qapi/migration.json
>>> +++ b/qapi/migration.json
>>> @@ -657,6 +657,8 @@
>>>  #     shared backend must be be non-volatile across reboot, such as by backing
>>>  #     it with a dax device.
>>>  #
>>> +#     cpr-reboot may not be used with postcopy, colo, or background-snapshot.
>>> +#
>> 
>> @cpr-reboot
>> 
>> COLO
>> 
>> Wrap the line:
>> 
>>    #     @cpr-reboot may not be used with postcopy, COLO, or
>>    #     background-snapshot.
>> 
>> This doesn't tell the reader what settings exactly do not work with
>> @cpr-reboot.
>> 
>> For instance "background-snapshot" is about enabling migration
>> capability @background-snapshot.  We could write something like "is
>> incompatible with enabling migration capability @background-snapshot".
>> 
>> Same for the other two.  Worthwhile?
>
> I initially was more precise exactly as you suggest, but I realized that
> postcopy encompasses multiple capabilities, and I did not want to enumerate
> them, nor require new capabilities related to these 3 to be listed here 
> if/when they are created, so I generalized.  A keyword search in this file 
> gives unambiguous matches.
>
> Peter pushed the patch a few hours before you sent this.

Okay.

A followup patch to correct @cpr-reboot, COLO and line wrapping would be
nice.


