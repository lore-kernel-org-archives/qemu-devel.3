Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DC3606A31B
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 06:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fGetx2fE
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLENw-0008QE-0a; Mon, 26 Oct 2026 02:40:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xLENh-0008Gm-Hj
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 02:40:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xLENd-0006Ws-KW
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 02:40:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792996823;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vRIexE8VLxz98e3hq8yzh3iz97cTQ18xLnnLBdc6gFY=;
 b=fGetx2fE41mqQ5xAm7QC0U9gK5S0uzoCkJ5ryTDFwzEcP7cdpzOF5nGzP0rU4+cZoKfheD
 S0x+QoueNyxrztDJfyz2ZB8ug8oh1T7mX6egv0KdACntBsBvQu7zs0CrAN21PkbcgXDYfk
 G3YEA0JrOs+LmHt3exWXeJxQd8jf4bI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-94-qjQUAzCFPNKn-DxhULrJOg-1; Mon,
 26 Oct 2026 02:40:15 -0400
X-MC-Unique: qjQUAzCFPNKn-DxhULrJOg-1
X-Mimecast-MFC-AGG-ID: qjQUAzCFPNKn-DxhULrJOg_1792996814
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4AD2D1800471; Mon, 26 Oct 2026 06:40:14 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E15C01800446; Mon, 26 Oct 2026 06:40:13 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 670EA21E6A04; Mon, 26 Oct 2026 07:40:11 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org,  qemu-devel@nongnu.org,  Kevin Wolf
 <kwolf@redhat.com>,  John Snow <jsnow@redhat.com>,  "Denis V . Lunev"
 <den@openvz.org>,  Eric Blake <eblake@redhat.com>,  Stefan Hajnoczi
 <stefanha@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 07/12] qapi/block: Add BLOCK_IO_DONE event
In-Reply-To: <e930ae0d-cf1e-4441-85ab-109db4a57fcf@redhat.com> (Hanna
 Czenczek's message of "Fri, 23 Oct 2026 16:38:08 +0200")
References: <20261019182028.45305-1-hreitz@redhat.com>
 <20261019182028.45305-8-hreitz@redhat.com>
 <871p9ksvx5.fsf@pond.sub.org>
 <e89f7bfb-8da2-495d-b9a4-0adf3fe58f80@redhat.com>
 <87ld7pgcsy.fsf@pond.sub.org>
 <e930ae0d-cf1e-4441-85ab-109db4a57fcf@redhat.com>
Date: Mon, 26 Oct 2026 07:40:11 +0100
Message-ID: <87ecdd6k38.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hanna Czenczek <hreitz@redhat.com> writes:

> On 23.10.26 08:18, Markus Armbruster wrote:
>> Hanna Czenczek <hreitz@redhat.com> writes:
>>
>>> On 20.10.26 08:55, Markus Armbruster wrote:
>>>> Hanna Czenczek <hreitz@redhat.com> writes:
>>>>
>>>>> This event is emitted when an operation completes, for which a
>>>>> BLOCK_IO_DELAY event has previously been emitted.
>>>>>
>>>>> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
>>>>> ---
>>>>>    qapi/block.json | 33 +++++++++++++++++++++++++++++++++
>>>>>    1 file changed, 33 insertions(+)
>>>>>
>>>>> diff --git a/qapi/block.json b/qapi/block.json
>>>>> index 5f9f5c28050..38f293dd32d 100644
>>>>> --- a/qapi/block.json
>>>>> +++ b/qapi/block.json

[...]

>>>>> @@ -686,3 +689,33 @@
>>>>>        'action': 'BlockErrorAction',
>>>>>        '*offset': 'uint64',
>>>>>        'bytes': 'uint64' } }
>>>>> +
>>>>> +##
>>>>> +# @BLOCK_IO_DONE:
>>>>> +#
>>>>> +# Emitted on completion for disk operations that previously emitted a
>>>>> +# `BLOCK_IO_DELAY` event.
>>>>
>>>> Can we have multiple operations in flight that previously emitted
>>>> BLOCK_IO_DELAY?
>>>>
>>>> If yes, might a management application need to connect the BLOCK_IO_DO=
NE
>>>> back to the BLOCK_IO_DELAY?
>>>>
>>>> If yes, how could it do that?
>>>
>>> Well, the combination of device, operation, offset, bytes.
>>>
>>> Do you think there should be an ID like a u64 counter per
>>> BlockBackend?
>>
>> I'm not overly particular on how exactly the connection can be made.  If
>> the quadruple you suggested always suffices, that's good enough for me.
>> Documentation should point it out, though.
>>
>> Can multiple operations with the same (device, operation, offset, bytes)
>> be in flight?
>
> Technically, sure.
>
> Adding an ID is quite ugly, I feel like, which is why I would need your i=
nput in how it would be least intrusive in QAPI.

First step is to get a clearer idea on what exactly management
applications need here.

> (Caveat, at this point: I=E2=80=99m afraid I=E2=80=99ll be quite far from=
 my notebook for around four weeks=E2=80=A6 Thank you for your help so far =
:))

No problem!

[...]

>>>>> +#
>>>>> +# @qom-path: path to the block device object in the QOM tree
>>>>> +#
>>>>> +# @operation: I/O operation
>>>>> +#
>>>>> +# @latency-ns: Full duration of the operation (in nanoseconds)
>>>>> +#
>>>>> +# @offset: Request offset in the guest disk (in bytes), if available
>>>>
>>>> Out of curiosity: when could @offset be unavailable?
>>>
>>> For flushes.
>>
>> Uh, what's @bytes then?
>
> 0. I found that natural. Any offset value is a valid offset, but a value =
of 0 for bytes sounded good to me.
>
> I now anticipate discomfort with this, so I can make @bytes optional, too=
, yes.

How much a flush writes and where is not known here.  We can use 0 for
"unknown" as long as we document it.  "Absent" feels like the more
obvious choice to me, though.  Advice, not a demand.

Same logic arguagbly applies to @offset, too.

Regardless, the special case "flush" needs to be documented.

[...]


