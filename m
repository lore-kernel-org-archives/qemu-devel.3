Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E48FC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 09:07:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxkCh-0002yW-Gn; Fri, 19 Apr 2024 05:06:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-louis@dupond.be>)
 id 1rxkCe-0002xp-KA; Fri, 19 Apr 2024 05:06:40 -0400
Received: from apollo.dupie.be ([2001:bc8:3f2a:101::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-louis@dupond.be>)
 id 1rxkCb-0002EW-Ia; Fri, 19 Apr 2024 05:06:40 -0400
Received: from [IPV6:2a02:a03f:eaf7:ff01:ba43:94d2:9111:d35b] (unknown
 [IPv6:2a02:a03f:eaf7:ff01:ba43:94d2:9111:d35b])
 by apollo.dupie.be (Postfix) with ESMTPSA id 929B91520C65;
 Fri, 19 Apr 2024 11:06:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dupond.be; s=dkim;
 t=1713517589;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E8MMV1En0UZjPuJwbTvGnaCfx7oGSjbXO8+LehAcZZU=;
 b=SLeHR7IE8n8eQsSDDjzO9EEdieZaLUttzECoD/Ks7H9KDzKq4xKsoJKHsCVcAx67h3mZSD
 vY/DQBzmA/9GCS4DrrFV2I8Gji8f8Li0ztnG6andLyh1CVqlcPQkh48tsRVoKD6LU/07l1
 yiu+9GQ5uANKHO64sVqdhhJH+xXDCrKzF9Zp4kokruqfrg2yymvvcBNmvJUkBT1NcOiHsN
 vS5gN15SHT/FlUPkj8pSFqiv1TPTyYHL4B5Joj8M3eQlvNvYaeYf/SH2xrACUiKyjw7TVX
 ZdA1zXPeKkxXwN0+O+1pH//SVDD/d6feDHlnR7AI8pGOn9UkgvGgWL3d4hq2Yg==
Message-ID: <0ba81018-8512-40b8-917e-1ef1cf95ca72@dupond.be>
Date: Fri, 19 Apr 2024 11:06:29 +0200
MIME-Version: 1.0
User-Agent: Thunderbird Daily
Subject: Re: [PATCH 4/7] qcow2: make subclusters discardable
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 eblake@redhat.com, berto@igalia.com, den@virtuozzo.com
References: <20231020215622.789260-1-andrey.drobyshev@virtuozzo.com>
 <20231020215622.789260-5-andrey.drobyshev@virtuozzo.com>
 <b92c8ede-604f-4859-b3b8-7e2fd7824274@dupond.be>
 <9fcebaf5-bdac-435f-8582-0dab75ff7afc@virtuozzo.com>
Content-Language: en-US
From: Jean-Louis Dupond <jean-louis@dupond.be>
In-Reply-To: <9fcebaf5-bdac-435f-8582-0dab75ff7afc@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 16/04/2024 21:56, Andrey Drobyshev wrote:
> On 10/27/23 14:10, Jean-Louis Dupond wrote:
>> [...]
>>
>> I've checked all the code paths, and as far as I see it nowhere breaks
>> the discard_no_unref option.
>> It's important that we don't introduce new code paths that can make
>> holes in the qcow2 image when this option is enabled :)
>>
>> If you can confirm my conclusion, that would be great.
>>
>>
>> Thanks
>> Jean-Louis
>>
> Hi Jean-Louis,
>
> I've finally got to working on v2 for this series.  However I'm failing
> to get a grasp on what this option is supposed to be doing and what are
> we trying to avoid here.
The discard-no-unref option causes qemu to only zero the blocks/clusters 
that get discarded, but does NOT remove the reference of the cluster.
So the cluster stays allocated/referenced, but is just marked zero.

There are multiple scenario's where you would need this.
First of all when you have a pre-allocated image, you most likely 
created it because you don't want fragmentation.
But if you don't have discard-no-unref enabled, you will end up with a 
fragmented image anyway, because discard will create holes in your 
image, and will be randomly allocated. Ending up with a fragmented image.

Another scenario (and why we implemented it), is that with a sparse 
image, you allocate new blocks at the end of the 'allocation pointer' 
(which points to the first available blocks in your image).
But if you do discards, afaik the pointer is not moved to the freed 
cluster, but still allocates at the end until you reopen the image.
And even then, take you created a hole of 5 free clusters, and you need 
to allocate 4 new clusters, it will use those 5 and leave 1 empty cluster.
But the next allocation needs 2 clusters, it will jump to the next free 
space with at least 2 clusters. Leaving that 1 cluster unallocated.
And this caused us to have 'sparse' images of 110GB for 100GB images for 
example. Just because the qcow2 images was full of small empty clusters 
completely fragmented.
>
> Consider this simple example:
>
> # cd build
> # ./qemu-img create -f qcow2   unref.qcow2 192K
> # ./qemu-img create -f qcow2 nounref.qcow2 192K
> # ./qemu-io -c "write 0 192K"   unref.qcow2
> # ./qemu-io -c "write 0 192K" nounref.qcow2
> #
> # strace -fv -e fallocate ./qemu-io -c "discard 64K 64K" unref.qcow2
> [pid 887710] fallocate(9, FALLOC_FL_KEEP_SIZE|FALLOC_FL_PUNCH_HOLE,
> 393216, 65536) = 0
> discard 65536/65536 bytes at offset 65536
> 64 KiB, 1 ops; 00.00 sec (252.123 MiB/sec and 4033.9660 ops/sec)
> #
> # strace -fv -e fallocate ./qemu-io -c "reopen -o discard-no-unref=on"
> -c "discard 64K 64K" nounref.qcow2
> # [pid 887789] fallocate(9, FALLOC_FL_KEEP_SIZE|FALLOC_FL_PUNCH_HOLE,
> 393216, 65536) = 0
> discard 65536/65536 bytes at offset 65536
> 64 KiB, 1 ops; 00.00 sec (345.457 MiB/sec and 5527.3049 ops/sec)
> #
> # ./qemu-img check unref.qcow2
>
> No errors were found on the image.
> 2/3 = 66.67% allocated, 50.00% fragmented, 0.00% compressed clusters
> Image end offset: 524288
> # ./qemu-img check nounref.qcow2
> No errors were found on the image.
> 3/3 = 100.00% allocated, 0.00% fragmented, 0.00% compressed clusters
> Image end offset: 524288
> #
> # ls -la *.qcow2
>
> -rw-r--r-- 1 root root 524288 Apr 16 22:42 nounref.qcow2
> -rw-r--r-- 1 root root 524288 Apr 16 22:41 unref.qcow2
> # du --block-size=1 *.qcow2
> 397312  nounref.qcow2
> 397312  unref.qcow2
>
> I understand that by keeping the L2 entry we achieve that cluster
> remains formally allocated, but no matter whether "discard-no-unref"
> option is enabled fallocate(FALLOC_FL_KEEP_SIZE|FALLOC_FL_PUNCH_HOLE) is
> being called leaving a hole in the file (e.g. file becomes sparse).
> However you say in the comment above that we can't allow making new
> holes in the file when this option is enabled.  How does that correlate
> and what do we achieve?  And which logic do you think we need to follow
> when discarding separate subclusters?
>
> Andrey

