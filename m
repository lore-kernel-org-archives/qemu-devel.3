Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68600C369CB
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 06:01:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9e1Z-0006eb-BF; Tue, 29 Apr 2025 02:00:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u9e1T-0006dp-R3
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 02:00:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u9e1Q-0004E4-6K
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 02:00:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745906447;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DsGeOpTdHCwYrEMdQ0GaAk04goDxdBIB970E3YM4HCs=;
 b=by4IXYdXhp4QNvoLgaEYT53qOFiodJUhSHTE8/24aXf64/LiEEhpCb+3hMw705SHpUH28v
 P5ZtNZPypL4RtUrEFrqgSCe9VZs7gdekw2qC8Xijx2SW7cq0D4wa/gpVknlF3Uo0IxMGUZ
 kY9ca/hC81hG30h6Di1FOU3r8wsJM0c=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-526-1ItqQZe1O8CmBiKkSPNgIw-1; Tue,
 29 Apr 2025 02:00:43 -0400
X-MC-Unique: 1ItqQZe1O8CmBiKkSPNgIw-1
X-Mimecast-MFC-AGG-ID: 1ItqQZe1O8CmBiKkSPNgIw_1745906442
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 439EA1956087; Tue, 29 Apr 2025 06:00:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.27])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5452730001A2; Tue, 29 Apr 2025 06:00:41 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E05B621E66C2; Tue, 29 Apr 2025 08:00:38 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: Nir Soffer <nirsof@gmail.com>,  qemu-devel@nongnu.org,  Hanna Reitz
 <hreitz@redhat.com>,  qemu-block@nongnu.org,  Fam Zheng <fam@euphon.net>,
 Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH 2/2] block/null: Add read-pattern option
In-Reply-To: <pykbbqg7om2ahqs7h7gfstgvvlbfjc2gx3yobvbego6jrnqo6p@zohvnrrpfwce>
 (Eric Blake's message of "Mon, 28 Apr 2025 16:55:06 -0500")
References: <20250427225900.24316-1-nirsof@gmail.com>
 <20250427225900.24316-3-nirsof@gmail.com>
 <pykbbqg7om2ahqs7h7gfstgvvlbfjc2gx3yobvbego6jrnqo6p@zohvnrrpfwce>
Date: Tue, 29 Apr 2025 08:00:38 +0200
Message-ID: <87zffzpkvt.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.484,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Eric Blake <eblake@redhat.com> writes:

> On Mon, Apr 28, 2025 at 01:59:00AM +0300, Nir Soffer wrote:
>> When the `read-zeroes` is set, reads produce zeroes, and block status
>> return BDRV_BLOCK_ZERO, emulating a sparse image.
>> 
>> If we don't set `read-zeros` we report BDRV_BLOCK_DATA, but image data
>> is undefined; posix_memalign, _aligned_malloc, valloc, or memalign do
>> not promise to zero allocated memory.
>> 
>> When computing a blkhash of an image via qemu-nbd, we want to test 3
>> cases:
>> 
>> 1. Sparse image: skip reading the entire image based on block status
>>    result, and use a pre-computed zero block hash.
>> 2. Image full of zeroes: read the entire image, detect block full of
>>    zeroes and skip block hash computation.
>> 3. Image full of data: read the entire image and compute a hash of all
>>    blocks.
>> 
>> This change adds `read-pattern` option. If the option is set, reads
>> produce the specified pattern. With this option we can emulate an image
>> full of zeroes or full of non-zeroes.
>> 
>> Specifying both `read-zeroes` and `read-pattern != 0` is not useful
>> since `read-zeroes` implies a sparse image.  In this case `read-zeroes`
>> wins and we ignore the pattern. Maybe we need to make the options mutual
>> exclusive.
>
> I would lean towards an error.  It's easier to remove an error later
> if we find it was too strict, than to be lax up front and then regret
> it down the road when we wish we had been more strict.

Seconded.  Silently "fixing" the user's nonsensical instructions is
commonly a bad idea.

>> The following examples shows how the new option can be used with blksum
>> (or nbdcopy --blkhash) to compute a blkhash of an image using the
>> null-co driver.
>> 
>> Sparse image - the very fast path:
>> 
>>     % ./qemu-nbd -r -t -e 0 -f raw -k /tmp/sparse.sock \
>>         "json:{'driver': 'raw', 'file': {'driver': 'null-co', 'size': '100g', 'read-zeroes': true}}" &
>> 
>>     % time blksum 'nbd+unix:///?socket=/tmp/sparse.sock'
>>     300ad1efddb063822fea65ae3174cd35320939d4d0b050613628c6e1e876f8f6  nbd+unix:///?socket=/tmp/sparse.sock
>>     blksum 'nbd+unix:///?socket=/tmp/sparse.sock'  0.05s user 0.01s system 92% cpu 0.061 total
>> 
>> Image full of zeros - same hash, 268 times slower:
>> 
>>     % ./qemu-nbd -r -t -e 0 -f raw -k /tmp/zero.sock \
>>         "json:{'driver': 'raw', 'file': {'driver': 'null-co', 'size': '100g', 'read-pattern': 0}}" &
>> 
>>     % time blksum 'nbd+unix:///?socket=/tmp/zero.sock'
>>     300ad1efddb063822fea65ae3174cd35320939d4d0b050613628c6e1e876f8f6  nbd+unix:///?socket=/tmp/zero.sock
>>     blksum 'nbd+unix:///?socket=/tmp/zero.sock'  7.45s user 22.57s system 183% cpu 16.347 total
>> 
>> Image full of data - difference hash, heavy cpu usage:
>> 
>>     % ./qemu-nbd -r -t -e 0 -f raw -k /tmp/data.sock \
>>         "json:{'driver': 'raw', 'file': {'driver': 'null-co', 'size': '100g', 'read-pattern': -1}}" &
>> 
>>     % time blksum 'nbd+unix:///?socket=/tmp/data.sock'
>>     2c122b3ed28c83ede3c08485659fa9b56ee54ba1751db74d8ba9aa13d9866432  nbd+unix:///?socket=/tmp/data.sock
>>     blksum 'nbd+unix:///?socket=/tmp/data.sock'  46.05s user 14.15s system 448% cpu 13.414 total
>> 
>> Tested on top of
>> https://lists.gnu.org/archive/html/qemu-devel/2025-04/msg05096.html.
>> 
>> Signed-off-by: Nir Soffer <nirsof@gmail.com>
>> ---
>>  block/null.c         | 17 +++++++++++++++++
>>  qapi/block-core.json |  9 ++++++++-
>>  2 files changed, 25 insertions(+), 1 deletion(-)
>
> Should block status return ZERO|DATA when read-pattern=0 is present?
>
   diff --git a/qapi/block-core.json b/qapi/block-core.json
   index b1937780e1..7d576cccbb 100644
   --- a/qapi/block-core.json
   +++ b/qapi/block-core.json
   @@ -3297,10 +3297,17 @@
    # @read-zeroes: if true, reads from the device produce zeroes; if
    #     false, the buffer is left unchanged.
    #     (default: false; since: 4.1)

The commit message explains "read-zeroes": true behaves like a sparse
image.  The existing doc comment does not.  I suspect it should.

    #
>> +# @read-pattern: if set, reads from the device produce the specified
>> +#     pattern; if unset, the buffer is left unchanged.
>> +#     (since: 10.1)
>> +#
>>  # Since: 2.9
>>  ##
>>  { 'struct': 'BlockdevOptionsNull',
>> -  'data': { '*size': 'int', '*latency-ns': 'uint64', '*read-zeroes': 'bool' } }
>> +  'data': { '*size': 'int',
>> +            '*latency-ns': 'uint64',
>> +            '*read-zeroes': 'bool',
>> +            '*read-pattern': 'int' } }
>
> Should this be 'uint8' instead of 'int', so that we aren't silently
> truncating spurious upper bits when passing it to memset()?

Yes, please.

Without this, the doc comment does not sufficiently specify the contents
of the image.  "The specified pattern" could be read as

* Four bytes given by the 32 bit value of @read-pattern in big endian

* or in little endian

* or in host endian

In fact, it's none of the above, it's the least significant byte.

Please try to clarify the doc comment in addition to narrowing the type.


