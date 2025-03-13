Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68827C282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 11:55:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsh95-0003tO-Gx; Thu, 13 Mar 2025 07:54:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tsh8M-0003jV-PR
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 07:53:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tsh8J-0006HP-R5
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 07:53:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741866826;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xvX7a4L0b/CLmDK1Na/9ChZa+YrjIaqwA4lmIS6QAxs=;
 b=adq4txWyyPO7H3xiKT71d5CX91UHCx2hrat4QyrzeceWZW0tjCIA/s6BLrbDEVVz7l3Xpa
 Z0eUxO2X56sgQYni2uI/ZYTNeixgCOKpKWFlgvDTMXnkPiCQJQ2eP92F+Xc4r7c0ueLU7o
 Ei9JxPRhOArDwpjx+gLlatH+b+1rHzI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-365--5LX4dwIMuqxwLBhWmaMlw-1; Thu,
 13 Mar 2025 07:53:44 -0400
X-MC-Unique: -5LX4dwIMuqxwLBhWmaMlw-1
X-Mimecast-MFC-AGG-ID: -5LX4dwIMuqxwLBhWmaMlw_1741866824
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DBDD01800EC5; Thu, 13 Mar 2025 11:53:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.22.74.4])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1FE9F19560AB; Thu, 13 Mar 2025 11:53:41 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 723B921E66C1; Thu, 13 Mar 2025 12:53:37 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org,  qemu-block@nongnu.org,  hreitz@redhat.com,
 vsementsov@yandex-team.ru
Subject: Re: [PATCH] block: Fix bdrv_activate() not to fail without medium
In-Reply-To: <Z9KwszV4pQ-Kw0es@redhat.com> (Kevin Wolf's message of "Thu, 13
 Mar 2025 11:17:23 +0100")
References: <20250312143758.1660177-1-armbru@redhat.com>
 <Z9KwszV4pQ-Kw0es@redhat.com>
Date: Thu, 13 Mar 2025 12:53:37 +0100
Message-ID: <87tt7x87um.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Kevin Wolf <kwolf@redhat.com> writes:

> Am 12.03.2025 um 15:37 hat Markus Armbruster geschrieben:
>> bdrv_activate() returns failure without setting an error when
>> !bs->drv.  This is suspicious.  Turns out it used to succeed then,
>> until commit 5416645fcf82 changed it to return -ENOMEDIUM.
>> 
>> Return zero instead.
>> 
>> Fixes: 5416645fcf82 (block: return error-code from bdrv_invalidate_cache)
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>
> The commit message sounds more theoretical. Did you find this only by
> code inspection? Do we know what the effect on real-world cases is, so
> we could add a sentence about it to the commit message? Maybe we could
> even have a qemu-iotests case to show the effect?
>
> I absolutely agree that returning -ENOMEDIUM while not setting errp is
> wrong. But without an example of what is affected, it's not obvious to
> me which part of it needs to be fixed.

Code inspection.

Here's my somewhat extended rationale for my fix.

The code of interest used to be in bdrv_invalidate_cache().  Have a look
at commit 5a8a30db477:

    commit 5a8a30db4771675480829d7d3bf35a138e9c35f1
    Author: Kevin Wolf <kwolf@redhat.com>
    Date:   Wed Mar 12 15:59:16 2014 +0100

        block: Add error handling to bdrv_invalidate_cache()

        If it returns an error, the migrated VM will not be started, but qemu
        exits with an error message.

        Signed-off-by: Kevin Wolf <kwolf@redhat.com>
        Reviewed-by: Juan Quintela <quintela@redhat.com>
        Reviewed-by: Eric Blake <eblake@redhat.com>
        Reviewed-by: Benoit Canet <benoit@irqsave.net>

    [...]

    diff --git a/block.c b/block.c
    index 53f5b44fbb..acb70fde3d 100644
    --- a/block.c
    +++ b/block.c
    @@ -4781,27 +4781,43 @@ flush_parent:
         return bdrv_co_flush(bs->file);
     }

    -void bdrv_invalidate_cache(BlockDriverState *bs)
    +void bdrv_invalidate_cache(BlockDriverState *bs, Error **errp)
     {
    +    Error *local_err = NULL;
    +    int ret;
    +
         if (!bs->drv)  {
             return;
         }

         if (bs->drv->bdrv_invalidate_cache) {
    -        bs->drv->bdrv_invalidate_cache(bs);
    +        bs->drv->bdrv_invalidate_cache(bs, &local_err);
         } else if (bs->file) {
    -        bdrv_invalidate_cache(bs->file);
    +        bdrv_invalidate_cache(bs->file, &local_err);
    +    }
    +    if (local_err) {
    +        error_propagate(errp, local_err);
    +        return;
         }

    -    refresh_total_sectors(bs, bs->total_sectors);
    +    ret = refresh_total_sectors(bs, bs->total_sectors);
    +    if (ret < 0) {
    +        error_setg_errno(errp, -ret, "Could not refresh total sector count");
    +        return;
    +    }
     }

    [...]

Not failing the function on !bs->drv is clearly intentional.

Behavior stayed this way for more than six years.  Then commit
5416645fcf8 (block: return error-code from bdrv_invalidate_cache)
changed the function to return zero on success, a negative errno on
failure.  According to the commit message, the patch is mere cleanup,
and not supposed to change behavior.

Since the first return was a success before the patch (no error set),
the correct value to return was zero.  The patch used -ENOMEDIUM
instead.  This is a clear regression.

My patch restores previous behavior.


