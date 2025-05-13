Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13A89C3ABCC
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 14:11:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEqLC-00071M-H1; Tue, 13 May 2025 10:10:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-louis@dupond.be>)
 id 1uEqLA-0006rq-N8; Tue, 13 May 2025 10:10:40 -0400
Received: from apollo.dupie.be ([2001:bc8:3f2a:101::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-louis@dupond.be>)
 id 1uEqL8-0004YT-8j; Tue, 13 May 2025 10:10:40 -0400
Received: from [IPV6:2a00:1c98:fff1:1001:aee7:ee9c:3ae8:78e2] (unknown
 [IPv6:2a00:1c98:fff1:1001:aee7:ee9c:3ae8:78e2])
 by apollo.dupie.be (Postfix) with ESMTPSA id A946C1520BB6;
 Tue, 13 May 2025 16:10:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dupond.be; s=dkim;
 t=1747145433;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=baTydLlSChKzG8EXUBjO5O4UVqzYCyK06ZNMp/qJWK0=;
 b=GDnXTBCd0I2t0TNiZ62wEUs5kjPALp22XhtB2h+JGKaSwESmjMJyg1WLBO0AvZOU0RDYGQ
 fHbccCR3hQCJWXnoIjYHtKQ79idsmQ3MBSX5Zit5v/O/GloNPmQqHVu7PEfhBNU/54Z/v4
 nj/rT2AqianWFf3kkXbFaMsKSwVDR6V+gkeA/x04uv4TrUXF7TDST3nolnEbuXV0x4/JKc
 bMi7abpOUoeeaxAKt7tzqh0IXlfdE0TR0NOSM3nHMaTM3bcznsoWfxJhDiZinRYlhpMfXQ
 0y8xHIk6DNEq6/Q9+5TJCsaj2N0bwDIVBtbHYlLavYJ+Eqrzht4O485iGvYNuQ==
Message-ID: <bd78687d-2be5-4ad1-9493-2513af223f6d@dupond.be>
Date: Tue, 13 May 2025 16:10:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] block: add for_commit option to measure
To: Hanna Czenczek <hreitz@redhat.com>, qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20250416071654.978264-1-jean-louis@dupond.be>
 <20250416071654.978264-2-jean-louis@dupond.be>
 <a1aa1173-5362-44f6-8b64-6d44f1b5eb82@redhat.com>
Content-Language: en-US
From: Jean-Louis Dupond <jean-louis@dupond.be>
In-Reply-To: <a1aa1173-5362-44f6-8b64-6d44f1b5eb82@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:bc8:3f2a:101::1;
 envelope-from=jean-louis@dupond.be; helo=apollo.dupie.be
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On 5/12/25 13:16, Hanna Czenczek wrote:
> On 16.04.25 09:16, Jean-Louis Dupond wrote:
>> To specify we use measure call for commit size calculations, we add a
>> new 'for_commit' option to the measure call.
>> This will be used in following commit to do a different measurement.
>
> Why not allow specifying the node name (or filename) of the commit 
> target instead of this just being a boolean?
Honestly didn't even thought about that option :)
>
> (That was my main problem with the original series, that it wasn’t 
> possible to specify the commit target (in an obvious way at least). 
> I’m not a fan of deferring to JSON parameters for this, although I’m 
> aware that to specify the node name of the commit target you would 
> have to use JSON again, unless qemu-img can do some translation on 
> behalf of the user: Looking at `commit -b`, that takes a filename; it 
> could make sense to have the internal QAPI parameter use a node name, 
> and qemu-img translating the filename parameter into a node name.  
> Actually, `measure` could just accept the same `-b` option as 
> `commit`, which it would then translate into the QAPI 
> `for-commit=<node-name>` option.)
And you will need to use JSON parameters if you want to specify 
something special, like for example to note that the commit target has 
discard-no-unref enabled.
I think not many people will call the command with the for_commit 
option, but it will be (always) called from code where the JSON 
parameters give much more flexibility to add some additional options 
(like discard-no-unref).

We could of course support both (JSON + for-commit=<node-name>).
But then we will also need to validate somehow that the for-commit 
node-name is equal to the target specified in the JSON somehow.
Or have something like for-commit=true/false + json or 
for-commit-node=<node-name> if you don't use a JSON?

Do you think it's worth the effort ? :)
>
> Hanna
>
>
Thanks for the review!
Jean-Louis
>
>> Signed-off-by: Jean-Louis Dupond <jean-louis@dupond.be>
>> ---
>>   block/qcow2.c                    | 16 +++++++++++++
>>   include/block/block_int-common.h |  4 ++++
>>   qapi/block-core.json             | 28 ++++++++++++++++++++++
>>   qemu-img.c                       | 40 ++++++++++++++++++++++++++++----
>>   4 files changed, 83 insertions(+), 5 deletions(-)
>

