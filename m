Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C58EAC88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 08:09:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6khm-0007aG-U1; Wed, 16 Sep 2026 04:09:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1x6khY-0007Zo-Gh
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 04:09:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1x6khV-0007bT-78
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 04:09:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789546144;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f9HqMfQ4OfCfr0464QurAYl6fp7pZmPKvUZYTBZ2AAQ=;
 b=evh3Od1Djy6HHTuFhBBFTg1wTVFbnq1UcC1KS8MOMOfXn1BaUOsFGVkLofDCNacZ5ZKdyW
 IwMix8zoBh+0hbN6eE9Z3nQXzDdHfqY20FNI5ReGZthlRzeE1YdoGxSm8As3Bk2GX7QNWa
 PAt6dDoaPstKNdYKAzAhoxtnyH5O2SU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-fKz1BTasOCGJFxRUm3iDiA-1; Wed, 16 Sep 2026 04:09:03 -0400
X-MC-Unique: fKz1BTasOCGJFxRUm3iDiA-1
X-Mimecast-MFC-AGG-ID: fKz1BTasOCGJFxRUm3iDiA_1789546142
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-4870a0fe60fso626817f8f.2
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 01:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789546142; x=1790150942; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=f9HqMfQ4OfCfr0464QurAYl6fp7pZmPKvUZYTBZ2AAQ=;
 b=FZqJiqa/VXmNyQf5FEmkxV12HYBBXVscpT2DXDunEazvzSObsaG/lLk+gDvixb4M/Q
 WTKxT26HU7XtJQHnoM2s9h64Q7Lg5ValAUW/rNkTn1jrRdGf3Sd2D3UrF/9pEHKaCxmG
 nJjSzqFnlVm5d2cX6CpFae4GuttPbUkK+g6Eyl10rmgRUZWWDwIyt3xyO2Y/qo1xgHjG
 hI8cLsp0qtCkCoy7jR3KOpoi5GzuB47bPF4BkGwL/EjX5CXRONaU7irCMg10CrbgcTX8
 M7fmSy/9RoPqm4CuRFh1S3tskrlu7cPk8QSl+uM8bQ5hwMHZch+Wh8UyaEsoKyVGflXF
 c6xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789546142; x=1790150942;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=f9HqMfQ4OfCfr0464QurAYl6fp7pZmPKvUZYTBZ2AAQ=;
 b=soY6NXzpZTRFpBI/0aE9p7zj3CS/X0I8CNXAJ+C++2IMyrfAOolOP+C01BOkj6qG3g
 nzKd6uIZhvbE01Dvb8OQLgz97Ln70Yi2vw94Au72lWgUFZdPW8R1xZkELj/sVet34Dyy
 1bD63dNlGZd+aca3/X81PO0yET+yVLJpsrqHEC3ZyAMTdVH7gNu/XqrAxVmrvyOrnq5F
 un97yaIUDhF4bpU+G5eWmKqO2Q2jcJUKTejFulZC/c06Q5I8LvLM5btjy1fczg+1ffi0
 U9Uci1HfZn6h+P+ciSZwgGuJ44nE/r1B7uHy5mSiH6KhLkvi4KC7OR/ubUC58GNC3Bjm
 FU7w==
X-Forwarded-Encrypted: i=1;
 AKwUvBw7bMlo5PDZqkPLIcE2DvpcK+AjN3XS2xlec3qi1mCKMFfu1KO0xHKGssbSOe2SeyaV372ZLQYrSWW8@nongnu.org
X-Gm-Message-State: AFuF++mpdSWOd++P8zDjwHT+7iVRC2nFwc881mI51dWjEX1Csksasb2c
 b90HO80s7I/k6tE105ECOGrJTzu2ZPL4iK46jxKXhHFqsZu5U9PkvoTRajWP2vPmqvWfU+WTdd0
 OQAehqvdq7j2V0IT3VOuj6hSo/OhvPLQTD7pCcUoZkSnQo7l5Sxvwuppj
X-Gm-Gg: AYBFou1iZQYWBIDlaZ2oEOTwqfBqbZFZTmlsiWjd0GxR2BFNeuVslE4RIz9MiGKZKFV
 QGFmVE3LuBrC7wx342lWUtt2QoSvaAbTdy+Aw/s0vgYa2NynAxvl2jth4MnLsPSsXYn29S8igVM
 GopWHYSrPRzmrjk2CdSbcb7RJ+Y1Vvld8UEvBd95VgjQv3laC0tgHl73oux4FytYz964cwrEVni
 eLktapffkPegIJOl2fChhG4bDlIx5iei3w52MrPbDDu4HOnG6ee1tm1+6FSLskmbVoSoymyj9rH
 ED5FIM2JO71DM7UMNpW9Y/OMy9qnVJsIc5/UkuLTBkDMWhLBYPkP5hoXneyO8GDM5pLbhznjSh/
 wnR9ctzQ5cg0DagxoOoVT2yEw1r6/oBKRju+ZBZc3xWu9n3hdGlWppkisNKuE1tOK/0foBvd4nF
 TP9joU1W1CFE5lQUPfkhVKQUUJdjQ=
X-Received: by 2002:a05:6000:310a:b0:487:c4c:5613 with SMTP id
 ffacd0b85a97d-4870d043c2dmr1979176f8f.24.1789546141682; 
 Wed, 16 Sep 2026 01:09:01 -0700 (PDT)
X-Received: by 2002:a05:6000:310a:b0:487:c4c:5613 with SMTP id
 ffacd0b85a97d-4870d043c2dmr1979120f8f.24.1789546141108; 
 Wed, 16 Sep 2026 01:09:01 -0700 (PDT)
Received: from ?IPV6:2003:cf:d704:f6c1:9398:5dbc:cc8:753b?
 (p200300cfd704f6c193985dbc0cc8753b.dip0.t-ipconnect.de.
 [2003:cf:d704:f6c1:9398:5dbc:cc8:753b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bef7659sm5926655f8f.3.2026.09.16.01.09.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Sep 2026 01:09:00 -0700 (PDT)
Message-ID: <1ed2271a-a428-4996-bfac-ed18f6aec3a8@redhat.com>
Date: Wed, 16 Sep 2026 10:08:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] qapi/block: Add BLOCK_IO_DELAY event
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 "Denis V . Lunev" <den@openvz.org>, Eric Blake <eblake@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
References: <20260831135206.126184-1-hreitz@redhat.com>
 <20260831135206.126184-4-hreitz@redhat.com> <87a4pypfk4.fsf@pond.sub.org>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <87a4pypfk4.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 03.09.26 16:36, Markus Armbruster wrote:
> Hanna Czenczek <hreitz@redhat.com> writes:
>
>> This event will be emitted when a disk operation takes longer than a
>> pre-defined threshold (as set on the block device).
>>
>> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
>> ---
>>   qapi/block.json | 30 ++++++++++++++++++++++++++++++
>>   1 file changed, 30 insertions(+)
>>
>> diff --git a/qapi/block.json b/qapi/block.json
>> index 456118eb0b4..1cdaffd5520 100644
>> --- a/qapi/block.json
>> +++ b/qapi/block.json
>> @@ -625,3 +625,33 @@
>>   ##
>>   { 'enum': 'IoAccountingOperation',
>>     'data': [ 'read', 'write', 'flush', 'zone-append', 'unmap' ] }
>> +
>> +##
>> +# @BLOCK_IO_DELAY:
>> +#
>> +# Emitted when a disk operation takes longer than the pre-defined
>> +# threshold (as set via the delay-alert-ms property on the block
>> +# device).
> Double-quotes around delay-alert-ms, please.

Sure.

> "The block device" is the one at @qom-path?

Yes, exactly.

> As far as I can tell, this property doesn't yet exist at this point.
> Fine, but please mention the fact in the commit message.

I will!

Thanks for reviewing,

Hanna

>> +#
>> +# Note that delays deliberately incurred by throttling do count
>> +# towards the operation duration.
>> +#
>> +# @qom-path: path to the device object in the QOM tree
>> +#
>> +# @operation: I/O operation
>> +#
>> +# @duration: Ongoing duration of the operation (in seconds)
>> +#
>> +# @offset: Request offset in the guest disk (in bytes), if available
>> +#
>> +# @bytes: Request length
>> +#
>> +# Since: 11.2
>> +##
>> +{ 'event': 'BLOCK_IO_DELAY',
>> +  'data': {
>> +      'qom-path': 'str',
>> +      'operation': 'IoAccountingOperation',
>> +      'duration': 'number',
>> +      '*offset': 'uint64',
>> +      'bytes': 'uint64' } }


