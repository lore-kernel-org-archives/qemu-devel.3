Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5AEACCD1AB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 06:15:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBS7f-00066S-Is; Wed, 22 Oct 2025 02:14:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vBS7d-00065m-Qx
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 02:14:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vBS7b-0001lb-CT
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 02:14:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761113691;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I5ixQfNhfT+e5PbUTPDynB03zItav8ExQy1fDr5oi+k=;
 b=R65AbF+PIKwQzHJYXaoKPmopRDdLkaVAxY1ETpUiWSriLZKUqn1UeWGp4gLmOHii1sB4z4
 DZPSbSyl0Krcb6BGTLjqq56dZ6eN2P3VoLzi6Mqi557Up5Rty4Osxs6trUVsgwvBO+XBAt
 Bk/VqhGrUnjYncxbjmpSgJdjYd/aXoU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-632-d8Mg4sxcPu6pl7Ai8RAtkw-1; Wed,
 22 Oct 2025 02:14:49 -0400
X-MC-Unique: d8Mg4sxcPu6pl7Ai8RAtkw-1
X-Mimecast-MFC-AGG-ID: d8Mg4sxcPu6pl7Ai8RAtkw_1761113688
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 89368195422D; Wed, 22 Oct 2025 06:14:48 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.19])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D5B8330001BF; Wed, 22 Oct 2025 06:14:47 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3802021E6A27; Wed, 22 Oct 2025 08:14:45 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: peterx@redhat.com,  stefanb@linux.vnet.ibm.com,  farosas@suse.de,
 qemu-devel@nongnu.org,  armbru@redhat.com,  berrange@redhat.com
Subject: Re: [PATCH v2 2/2] migration: vmsd errp handlers: return bool
In-Reply-To: <9064223d-6f35-4023-b5b6-99b8d766f506@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Tue, 21 Oct 2025 14:50:36 +0300")
References: <20251020160344.2401137-1-vsementsov@yandex-team.ru>
 <20251020160344.2401137-3-vsementsov@yandex-team.ru>
 <9064223d-6f35-4023-b5b6-99b8d766f506@yandex-team.ru>
Date: Wed, 22 Oct 2025 08:14:45 +0200
Message-ID: <87ecqviht6.fsf@pond.sub.org>
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

Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:

> On 20.10.25 19:03, Vladimir Sementsov-Ogievskiy wrote:
>> Recently we moved to returning errp. Why to keep int return value?
>> Generally it doesn't help: you can't use in a logic of handling
>> an error, as you are never sure, that in future the logic in
>> the stack will not change: it may start to return another error
>> code in the same case, or return same error code in another case.
>> Actually, we can only rely on concrete errno code when get it
>> _directly_ from documented library function or syscall. This way we
>> handle for example EINTR. But later in a stack, we can only add
>> this errno to the textual error by strerror().
>> Let this new, recently added API be simpler and clearer, let it
>> return simple boolean value, so we shouldn't think:
>>    - should we handle different error codes differently
>>      (if yes - how exactly, if no - why do we need this information?)
>>    - should we add it to errp, or it was already added earlier in
>>      the stack
>
>
> Less aggressive commit message may be:
>
> Switch the new API to simple bool-returning interface, as return value
> is not used otherwise than check is function failed or not. No logic
> depend on concrete errno values.

Good, except it isn't quite accurate: callers include the return value
in error messages.

They format it as a number, which is inappropriate.

If they formatted it appropriately, with strerror(), would that be
helpful?  I *think* the answer is no.  The functions set an Error, and
their callers prepend to that Error's message.  The original Error
should suffice to tell what went wrong.  The prepended text's purpose is
to add context.

I think the easiest way to make this argument is to split this patch
into a part changing the error messages, and a part changing the return
type.


