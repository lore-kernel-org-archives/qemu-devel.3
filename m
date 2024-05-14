Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E20B9C25B75
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 12:10:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6qyi-0002Qq-Jv; Tue, 14 May 2024 08:09:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s6qyU-0002Pv-NS
 for qemu-devel@nongnu.org; Tue, 14 May 2024 08:09:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s6qyT-0003XV-39
 for qemu-devel@nongnu.org; Tue, 14 May 2024 08:09:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715688580;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SdH2oCWLw8fgRh6/vz9PBkTef5IH4LgKT4Jmvp4q2y8=;
 b=C0Y/XRG4FiKkHDerc+5y0Q/IkX0vHvU1XddfnyrYFZ+gaX2tgrlDOytzhoevxZiWlOYFGe
 rZfY3HXgf6l/sdcHUMu2kzA3OQ3pdFCowE9ewEt2VCexPVl0Nji75pTZtCAnYwZEI6xb4f
 zSeeWe+jA5g5IhIuMhtYzX1OjjbRsVY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-218-6W3o0yShMhKIo5uI7AgRKA-1; Tue,
 14 May 2024 08:09:36 -0400
X-MC-Unique: 6W3o0yShMhKIo5uI7AgRKA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 60045380009E;
 Tue, 14 May 2024 12:09:36 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CDF0940C6EB7;
 Tue, 14 May 2024 12:09:35 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DB24D21E5E72; Tue, 14 May 2024 14:09:34 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org,  qemu-block@nongnu.org,  eblake@redhat.com,
 hreitz@redhat.com,  kwolf@redhat.com,  vsementsov@yandex-team.ru,
 jsnow@redhat.com
Subject: Re: [PATCH 1/2] copy-before-write: allow specifying minimum cluster
 size
In-Reply-To: <1acd096c-5ec9-411d-b06e-cd64fb898852@proxmox.com> (Fiona Ebner's
 message of "Mon, 13 May 2024 15:24:28 +0200")
References: <20240308155158.830258-1-f.ebner@proxmox.com>
 <20240308155158.830258-2-f.ebner@proxmox.com>
 <875xx9s6pp.fsf@pond.sub.org>
 <1acd096c-5ec9-411d-b06e-cd64fb898852@proxmox.com>
Date: Tue, 14 May 2024 14:09:34 +0200
Message-ID: <87plto1toh.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Fiona Ebner <f.ebner@proxmox.com> writes:

> Am 26.03.24 um 10:06 schrieb Markus Armbruster:
>>> @@ -365,7 +368,13 @@ BlockCopyState *block_copy_state_new(BdrvChild *source, BdrvChild *target,
>>>  
>>>      GLOBAL_STATE_CODE();
>>>  
>>> -    cluster_size = block_copy_calculate_cluster_size(target->bs, errp);
>>> +    if (min_cluster_size && !is_power_of_2(min_cluster_size)) {
>> 
>> min_cluster_size is int64_t, is_power_of_2() takes uint64_t.  Bad if
>> min_cluster_size is negative.  Could this happen?
>
> No, because it comes in as a uint32_t via the QAPI (the internal caller
> added by patch 2/2 from the backup code also gets the value via QAPI and
> there uint32_t is used too).

Good.

Is there a practical way to tweak the types so it's more obvious?

>>> +        error_setg(errp, "min-cluster-size needs to be a power of 2");
>>> +        return NULL;
>>> +    }
>>> +
>>> +    cluster_size = block_copy_calculate_cluster_size(target->bs,
>>> +                                                     min_cluster_size, errp);
>>>      if (cluster_size < 0) {
>>>          return NULL;
>>>      }
>
> ---snip---
>
>>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>>> index 0a72c590a8..85c8f88f6e 100644
>>> --- a/qapi/block-core.json
>>> +++ b/qapi/block-core.json
>>> @@ -4625,12 +4625,18 @@
>>>  #     @on-cbw-error parameter will decide how this failure is handled.
>>>  #     Default 0. (Since 7.1)
>>>  #
>>> +# @min-cluster-size: Minimum size of blocks used by copy-before-write
>>> +#     operations.  Has to be a power of 2.  No effect if smaller than
>>> +#     the maximum of the target's cluster size and 64 KiB.  Default 0.
>>> +#     (Since 9.0)
>>> +#
>>>  # Since: 6.2
>>>  ##
>>>  { 'struct': 'BlockdevOptionsCbw',
>>>    'base': 'BlockdevOptionsGenericFormat',
>>>    'data': { 'target': 'BlockdevRef', '*bitmap': 'BlockDirtyBitmap',
>>> -            '*on-cbw-error': 'OnCbwError', '*cbw-timeout': 'uint32' } }
>>> +            '*on-cbw-error': 'OnCbwError', '*cbw-timeout': 'uint32',
>>> +            '*min-cluster-size': 'uint32' } }
>> 
>> Elsewhere in the schema, we use either 'int' or 'size' for cluster-size.
>> Why the difference?
>
> The motivation was to disallow negative values up front and have it work
> with block_copy_calculate_cluster_size(), whose result is an int64_t.

Let's see whether I understand.

cbw_open() passes the new member @min-cluster-size to
block_copy_state_new().

block_copy_state_new() checks it, and passes it on to
block_copy_calculate_cluster_size().  This is the C code shown above.

block_copy_calculate_cluster_size() uses it like

    return MAX(min_cluster_size, BLOCK_COPY_CLUSTER_SIZE_DEFAULT);

and

    return MAX(min_cluster_size,
               MAX(BLOCK_COPY_CLUSTER_SIZE_DEFAULT, bdi.cluster_size));

BLOCK_COPY_CLUSTER_SIZE_DEFAULT and bdi.cluster_size are int.  The
return type is int64_t.

Correct?

I don't like mixing signed and unsigned in MAX() like this.  Figuring
out whether it's safe takes a C language lawyer.  I'd rather avoid such
subtle code.  Can we please compute these maxima entirely in the
destination type int64_t?

>                                                                       If
> I go with 'int', I'll have to add a check to disallow negative values.
> If I go with 'size', I'll have to add a check for to disallow too large
> values.
>
> Which approach should I go with?

For me, reducing the need for manual checking is important, but
cleanliness of the external interface trumps it.  I'd use 'size'.

Not the first time I see friction between QAPI 'size' or 'uint64' and
the block layer's use of int64_t.

The block layer likes to use int64_t even when the value must not be
negative.  There are good reasons for that.

Perhaps a QAPI type for "non-negative int64_t" could be useful.  Weird,
but useful.


