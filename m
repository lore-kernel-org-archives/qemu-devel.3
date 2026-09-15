Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F6EBC88E53
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 13:59:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6TgV-0005xS-4a; Tue, 15 Sep 2026 09:58:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-louis@dupond.be>)
 id 1x6TgR-0005wT-Tw; Tue, 15 Sep 2026 09:58:51 -0400
Received: from apollo.dupie.be ([2001:bc8:3f2a:101::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-louis@dupond.be>)
 id 1x6TgO-0000eb-QN; Tue, 15 Sep 2026 09:58:51 -0400
Received: from [IPV6:2a02:a03f:fafb:301:46c3:62e6:fe62:23a1] (unknown
 [IPv6:2a02:a03f:fafb:301:46c3:62e6:fe62:23a1])
 by apollo.dupie.be (Postfix) with ESMTPSA id 8717F1520F75;
 Tue, 15 Sep 2026 15:58:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dupond.be; s=dkim;
 t=1789480723;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WbTXZL5FA7BF5ur3tu5wJODxVvkpmrIQ+gzqfbtaLdU=;
 b=D6VP37ljh9z2K1NWc+C+O22K+rLEUwOUmQpcdDGljvRxxzsyQH7ZvMB5RAfX5IF4zIzAei
 4jS8EGyWH59oIh2ufUV2mNgafdnVI4yTR/08A2ykBiR4CAJYuWPK5nk1uR0oe6nW0XGPnf
 oZo1ASXT1S0duCSJx3JRMaZ0AXLVPmpGVdOLM0qyfukokFaZCoRexSSyXSC5K/sbYkFn2C
 tCbrT0yYnNuBJQZBjHBDEsg/h/OG0vUntoJY8ZZiexTkqv6lDQYAibfDDbfL2myv97FXkq
 t2YTr9Gzrus6F5JXvbpGwlPjt9OJP4uOktANmJ3ddnDuVvCB1oNq55Q0Zx6Qjg==
Message-ID: <d60e4c1a-0d51-425f-b5b1-c84e91934548@dupond.be>
Date: Tue, 15 Sep 2026 15:58:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/1] qcow2: add functionality to repair bitmaps
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org,
 John Snow <jsnow@redhat.com>
References: <20260826101005.2345883-1-jean-louis@dupond.be>
 <20260826101005.2345883-2-jean-louis@dupond.be>
 <ee6e69df-673b-4859-8c77-e1f5b5552f68@yandex-team.ru>
Content-Language: en-US, en-GB, nl-BE
From: Jean-Louis Dupond <jean-louis@dupond.be>
In-Reply-To: <ee6e69df-673b-4859-8c77-e1f5b5552f68@yandex-team.ru>
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


On 26/08/2026 17:46, Vladimir Sementsov-Ogievskiy wrote:
> On 26.08.26 13:10, Jean-Louis Dupond wrote:
>> In some cases, it might happen that bitmaps become corrupt.
>> For example when adding/removing bitmaps on a live image.
>>
>> Of course this should not happen, but in case this happens, the image is
>> corrupt and even cannot be opened anymore. You'll get something like the
>> following:
>> qemu-img: Could not open 'disk.qcow2': Bitmap '' doesn't satisfy the 
>> constraints
>>
>> So the image becomes useless, and cannot be repaired. This while in fact
>> only (one) bitmap entry is corrupt, and the rest of the data is just
>> intact.
>>
>> This commit adds a way to fix this corruption, by just replacing the
>> bitmap list in the qcow2 image with the valid bitmaps, and dropping the
>> bitmaps that are corrupt.
>>
>> $ qemu-img check disk.qcow2
>> qemu-img: Check failed: Invalid argument
>> qemu-img: Lost persistent bitmaps during inactivation of node 
>> '#block147': Bitmap '' doesn't satisfy the constraints
>>
>> $ qemu-img check -r all disk.qcow2
>> qcow2_free_clusters failed: Invalid argument
>> Leaked cluster 3 refcount=1 reference=0
>> Leaked cluster 26 refcount=1 reference=0
>> ERROR cluster 983214 refcount=0 reference=1
>> Rebuilding refcount structure
>> Repairing cluster 1 refcount=1 reference=0
>> Repairing cluster 2 refcount=1 reference=0
>> Repairing cluster 32768 refcount=1 reference=0
>> ....
>> Repairing cluster 983214 refcount=1 reference=0
>> The following inconsistencies were found and repaired:
>>
>>      2 leaked clusters
>>      3 corruptions
>>
>> Double checking the fixed image now...
>> No errors were found on the image.
>> 983056/1048576 = 93.75% allocated, 0.05% fragmented, 0.00% compressed 
>> clusters
>> Image end offset: 64437878784
>>
>> And the image is valid again!
>> Worst case you lose all bitmaps, but at least the image and the data
>> itself is useable again.
>>
>> Signed-off-by: Jean-Louis Dupond<jean-louis@dupond.be>
>
> With accidental (I assume)  scripts/meson-buildoptions.sh.tmp file 
> removed:
Yea sorry for that, was accidental indeed.
I don't need to push a new version to fix that I suppose?
>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>

Thanks!
Jean-Louis


