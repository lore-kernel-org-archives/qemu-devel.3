Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB8C1CAC5B0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 10:45:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1Mye-00058y-56; Wed, 24 Sep 2025 06:44:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v1Myd-00058m-64
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 06:43:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v1MyW-0008SG-Aw
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 06:43:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758710627;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=q0e1wHU5VzOMqpwJCzrLVk1l0oeaYv9MFOEBaJu7UHg=;
 b=X5bS6JKEfiV0OhnetdgKX7CkvU9Q7irNTJ0DKk6o69jeHP+HFtpYKUpzC97AvTv9mPstQD
 92y8quNAvJDFcuXnUNQ/TGOPUDaKpdKD4AeDwTcXgEsAzdxJToRqlq9rAj2pSk+SjzOiYu
 42naR+qMh/ZzkqygZHJJUQytFUxpBEQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-590-HM_9uTkSPq61gmoiMNUvyA-1; Wed,
 24 Sep 2025 06:43:43 -0400
X-MC-Unique: HM_9uTkSPq61gmoiMNUvyA-1
X-Mimecast-MFC-AGG-ID: HM_9uTkSPq61gmoiMNUvyA_1758710623
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AEBBF180057F; Wed, 24 Sep 2025 10:43:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.33])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1DEAA1955F22; Wed, 24 Sep 2025 10:43:42 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4EEF721E6A27; Wed, 24 Sep 2025 12:43:39 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org,  hreitz@redhat.com,  eblake@redhat.com,
 qemu-devel@nongnu.org
Subject: Re: [PATCH 1/2] block: Expose block limits for images in QMP
In-Reply-To: <aNO0SZalsYn-AYCW@redhat.com> (Kevin Wolf's message of "Wed, 24
 Sep 2025 11:05:13 +0200")
References: <20250923163735.378254-1-kwolf@redhat.com>
 <20250923163735.378254-2-kwolf@redhat.com>
 <87o6r05qkf.fsf@pond.sub.org> <aNO0SZalsYn-AYCW@redhat.com>
Date: Wed, 24 Sep 2025 12:43:39 +0200
Message-ID: <87a52k2kro.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
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

Kevin Wolf <kwolf@redhat.com> writes:

> Am 24.09.2025 um 08:10 hat Markus Armbruster geschrieben:
>> Kevin Wolf <kwolf@redhat.com> writes:
>> 
>> > This information can be useful both for debugging and for management
>> > tools trying to configure guest devices with the optimal limits
>> > (possibly across multiple hosts). There is no reason not to make it
>> > available, so just add it to BlockNodeInfo.
>> >
>> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>> > ---
>> >  qapi/block-core.json             | 59 ++++++++++++++++++++++++++++++++
>> >  block/qapi.c                     | 34 ++++++++++++++++--
>> >  tests/qemu-iotests/184           |  3 +-
>> >  tests/qemu-iotests/184.out       |  8 -----
>> >  tests/qemu-iotests/common.filter |  3 +-
>> >  5 files changed, 94 insertions(+), 13 deletions(-)
>> >
>> > diff --git a/qapi/block-core.json b/qapi/block-core.json
>> > index dc6eb4ae23..eda041ac1c 100644
>> > --- a/qapi/block-core.json
>> > +++ b/qapi/block-core.json
>> > @@ -275,6 +275,62 @@
>> >        'file': 'ImageInfoSpecificFileWrapper'
>> >    } }
>> >  
>> > +##
>> > +# @BlockLimitsInfo:
>> > +#
>> > +# @request-alignment: Alignment requirement, in bytes, for offset/length of I/O
>> > +#     requests.
>> > +#
>> > +# @max-discard: Maximum number of bytes that can be discarded at once. If not
>> > +#     present, there is no specific maximum.
>> > +#
>> > +# @discard-alignment: Optimal alignment for discard requests in bytes. A power
>> > +#     of 2 is best, but not mandatory. If not present, discards don't have a
>> > +#     alignment requirement different from @request-alignment.
>> 
>> What does the second sentence try to convey?  As far as I can tell, QMP
>> has BlockLimitsInfo is only in the result of query-block and
>> query-named-block-nodes, i.e. it's not something the user picks.
>
> I copied these descriptions from the comments in struct BlockLimits,
> just leaving out things that are clearly internal. Their nature is the
> same there, we never configure block limits, we only detect them.
>
> What I think this sentence wants to tell us is that while you may
> intuitively expect power-of-two limits, you shouldn't be surprised to
> occasionally find other numbers here, too.

Well, I would be surprised, so having the doc mention it makes sense.

> Maybe "Note that this doesn't have to be a power of two" instead? Both
> in QAPI and the struct definition.

Works for me.

>> > +#
>> > +# @max-write-zeroes: Maximum number of bytes that can be zeroed out at once. If
>> > +#     not present, there is no specific maximum.
>> > +#
>> > +# @write-zeroes-alignment: Optimal alignment for write_zeroes requests in
>> > +#     bytes. A power of 2 is best, but not mandatory. If not present,
>> > +#     write_zeroes doesn't have a alignment requirement different from
>> > +#     @request-alignment.
>> 
>> Likewise.
>> 
>> > +#
>> > +# @opt-transfer: Optimal transfer length in bytes. If not present, there is no
>> > +#     preferred size.
>> > +#
>> > +# @max-transfer: Maximal transfer length in bytes. If not present, there is no
>> > +#     specific maximum.
>> > +#
>> > +# @max-hw-transfer: Maximal hardware transfer length in bytes.  Applies
>> > +#     whenever transfers to the device bypass the kernel I/O scheduler, for
>> > +#     example with SG_IO. If not present, there is no specific maximum.
>> > +#
>> > +# @max-iov: Maximum number of scatter/gather elements
>> > +#
>> > +# @max-hw-iov: Maximal number of scatter/gather elements allowed by the hardware.
>> 
>> Maximum number
>> 
>> > +#     Applies whenever transfers to the device bypass the kernel I/O scheduler,
>> > +#     for example with SG_IO. If not present, the hardware limits is unknown
>> > +#     and @max-iov is always used.
>> > +#
>> > +# @min-mem-alignment: memory alignment in bytes so that no bounce buffer is needed
>> > +#
>> > +# @opt-mem-alignment: memory alignment in bytes that is used for bounce buffers
>> 
>> Why is this "opt"?  I guess it means "optimal".
>
> Yes, I think so. How about this:
>
> @min-mem-alignment: Minimal required memory alignment in bytes for
> zero-copy I/O to succeed. For unaligned requrests, a bounce buffer will

requests

> be used.
>
> @opt-mem-alignment: Optimal memory alignment in bytes. This is the
> alignment used for any buffer allocations QEMU performs internally.

Good!

[...]


