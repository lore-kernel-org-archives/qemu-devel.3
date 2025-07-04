Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A9FDC8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 04:25:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXXze-0001j7-QB; Fri, 04 Jul 2025 00:25:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uXXzc-0001gj-Ni
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 00:25:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uXXzZ-0006Ls-PS
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 00:25:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751603139;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Yh4zhxGaWB6xbSoKAp92VKZHv5BDibySclvXnsdk7Ak=;
 b=HlWIm69mA5t9V1yZ2pBsdRkEIJPfI6qBtNcBJ2oP2HiNd5kMPB8gwaSPk5wzqnKunCK+YG
 6GH8dh5E9sAZQBRKcsecDbBT0z1CAgf+qebB6VziP1Dl1o3/aYRwwVBGiinOI7JDf6IoxP
 sTAo0vHDcOzqM7Kn39x3BXQtauK5mcU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-517-X0rTe81iNVmLOFdlgOvqqw-1; Fri,
 04 Jul 2025 00:25:37 -0400
X-MC-Unique: X0rTe81iNVmLOFdlgOvqqw-1
X-Mimecast-MFC-AGG-ID: X0rTe81iNVmLOFdlgOvqqw_1751603136
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B373518011CD; Fri,  4 Jul 2025 04:25:36 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.10])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 623F2180045B; Fri,  4 Jul 2025 04:25:36 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A361021E6A27; Fri, 04 Jul 2025 06:25:33 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  berrange@redhat.com,  Peter Xu
 <peterx@redhat.com>,  Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v2 04/24] migration: Remove MigrateSetParameters
In-Reply-To: <87pleh3w6j.fsf@suse.de> (Fabiano Rosas's message of "Thu, 03 Jul
 2025 16:34:44 -0300")
References: <20250630195913.28033-1-farosas@suse.de>
 <20250630195913.28033-5-farosas@suse.de> <87jz4s1gt6.fsf@pond.sub.org>
 <87pleh3w6j.fsf@suse.de>
Date: Fri, 04 Jul 2025 06:25:33 +0200
Message-ID: <87ldp4twea.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Fabiano Rosas <farosas@suse.de> writes:

> Markus Armbruster <armbru@redhat.com> writes:
>
>> Fabiano Rosas <farosas@suse.de> writes:
>>
>>> Now that the TLS options have been made the same between
>>> migrate-set-parameters and query-migrate-parameters, a single type can
>>> be used. Remove MigrateSetParameters.
>>>
>>> The TLS options documentation from MigrationParameters were replaced
>>> with the ones from MigrateSetParameters which was more complete.
>>>
>>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>>
>> [...]
>>
>>> diff --git a/qapi/migration.json b/qapi/migration.json
>>> index 97bb022c45..3788c39857 100644
>>> --- a/qapi/migration.json
>>> +++ b/qapi/migration.json

[...]

>>> @@ -1205,8 +1011,8 @@
>>>  # @downtime-limit: set maximum tolerated downtime for migration.
>>>  #     maximum downtime in milliseconds (Since 2.8)
>>>  #
>>> -# @x-checkpoint-delay: the delay time between two COLO checkpoints.
>>> -#     (Since 2.8)
>>> +# @x-checkpoint-delay: the delay time between two COLO checkpoints in
>>> +#     periodic mode.  (Since 2.8)
>>>  #
>>>  # @multifd-channels: Number of channels used to migrate data in
>>>  #     parallel.  This is the same number that the number of sockets
>>
>> Please add
>>
>>    ##
>>    # @query-migrate-parameters:
>>    #
>>   -# Return information about the current migration parameters
>>   +# Return information about the current migration parameters.
>>   +# Optional members of the return value are always present.
>>    #
>>    # Returns: @MigrationParameters
>>    #
>>    # Since: 2.4
>>    #
>>
>> and double-check "always" is actually true.
>
> It's not, block-bitmap-mapping needs to be kept optional for
> compatibility.
>
> What about:
>
> # Return information about the current migration parameters.  Optional
> # members of the return value are always present, except for
> # block-bitmap-mapping that's only present if it has been previously
> # set.

Suggest "except @block-bitmap-mapping is only present if" or "execpt for
@block-bitmap-mapping, which is only present if".

>> With that, QAPI schema
>> Acked-by: Markus Armbruster <armbru@redhat.com>


