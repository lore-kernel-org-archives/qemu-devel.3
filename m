Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9AFAC88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 09:57:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6mOM-0007Tv-K4; Wed, 16 Sep 2026 05:57:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x6mOC-0007SJ-ON
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 05:57:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x6mOB-0004p6-94
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 05:57:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789552634;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8bq+0AwfztUkxAHm2LLZ6HVxMF9a8Is1pWDFUz0jHWo=;
 b=byyHsv+ahQKtUfvSFkPV5uGvA7H7Qk35UI3Dp0BAPigYoHyBZaXB/zYR7EDHGcnIklCOqn
 jllyKbsWdqasJwGAV5Q0zBj0bOAdZ6oDJSqVqMG3KmhGH8Ri6plNSNmElg0MpX/se+cR6h
 RTrXt4R6OSVcHUvlVI0MRRX7lTX6VQU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-628-NkKEe33NP56oW1jcBH_WHQ-1; Wed,
 16 Sep 2026 05:57:11 -0400
X-MC-Unique: NkKEe33NP56oW1jcBH_WHQ-1
X-Mimecast-MFC-AGG-ID: NkKEe33NP56oW1jcBH_WHQ_1789552630
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 838751800657; Wed, 16 Sep 2026 09:57:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3F965754; Wed, 16 Sep 2026 09:57:10 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B891321E6A04; Wed, 16 Sep 2026 11:57:07 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org,  qemu-devel@nongnu.org,  Kevin Wolf
 <kwolf@redhat.com>,  John Snow <jsnow@redhat.com>,  "Denis V . Lunev"
 <den@openvz.org>,  Eric Blake <eblake@redhat.com>,  Stefan Hajnoczi
 <stefanha@redhat.com>
Subject: Re: [PATCH 3/9] qapi/block: Add BLOCK_IO_DELAY event
In-Reply-To: <1ed2271a-a428-4996-bfac-ed18f6aec3a8@redhat.com> (Hanna
 Czenczek's message of "Wed, 16 Sep 2026 10:08:58 +0200")
References: <20260831135206.126184-1-hreitz@redhat.com>
 <20260831135206.126184-4-hreitz@redhat.com>
 <87a4pypfk4.fsf@pond.sub.org>
 <1ed2271a-a428-4996-bfac-ed18f6aec3a8@redhat.com>
Date: Wed, 16 Sep 2026 11:57:07 +0200
Message-ID: <87pkydbjt8.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hanna Czenczek <hreitz@redhat.com> writes:

> On 03.09.26 16:36, Markus Armbruster wrote:
>> Hanna Czenczek <hreitz@redhat.com> writes:
>>
>>> This event will be emitted when a disk operation takes longer than a
>>> pre-defined threshold (as set on the block device).
>>>
>>> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
>>> ---
>>>   qapi/block.json | 30 ++++++++++++++++++++++++++++++
>>>   1 file changed, 30 insertions(+)
>>>
>>> diff --git a/qapi/block.json b/qapi/block.json
>>> index 456118eb0b4..1cdaffd5520 100644
>>> --- a/qapi/block.json
>>> +++ b/qapi/block.json
>>> @@ -625,3 +625,33 @@
>>>   ##
>>>   { 'enum': 'IoAccountingOperation',
>>>     'data': [ 'read', 'write', 'flush', 'zone-append', 'unmap' ] }
>>> +
>>> +##
>>> +# @BLOCK_IO_DELAY:
>>> +#
>>> +# Emitted when a disk operation takes longer than the pre-defined
>>> +# threshold (as set via the delay-alert-ms property on the block
>>> +# device).
>> Double-quotes around delay-alert-ms, please.
>
> Sure.
>
>> "The block device" is the one at @qom-path?
>
> Yes, exactly.

Perhaps tweak @qom-path's description: "the block device object".

>> As far as I can tell, this property doesn't yet exist at this point.
>> Fine, but please mention the fact in the commit message.
>
> I will!
>
> Thanks for reviewing,
>
> Hanna
>
>>> +#
>>> +# Note that delays deliberately incurred by throttling do count
>>> +# towards the operation duration.
>>> +#
>>> +# @qom-path: path to the device object in the QOM tree
>>> +#
>>> +# @operation: I/O operation
>>> +#
>>> +# @duration: Ongoing duration of the operation (in seconds)
>>> +#
>>> +# @offset: Request offset in the guest disk (in bytes), if available
>>> +#
>>> +# @bytes: Request length
>>> +#
>>> +# Since: 11.2
>>> +##
>>> +{ 'event': 'BLOCK_IO_DELAY',
>>> +  'data': {
>>> +      'qom-path': 'str',
>>> +      'operation': 'IoAccountingOperation',
>>> +      'duration': 'number',
>>> +      '*offset': 'uint64',
>>> +      'bytes': 'uint64' } }


