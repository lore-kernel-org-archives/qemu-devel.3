Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10CF8EF587C
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Feb 2026 16:26:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrewg-00074i-TM; Sun, 15 Feb 2026 11:26:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vrewf-00074W-Kw; Sun, 15 Feb 2026 11:26:05 -0500
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vrewb-0002UN-48; Sun, 15 Feb 2026 11:26:05 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1771172744; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=L/1axPoYRqvCsQ/M4+D4tLLNDi1KWKMvo+3OM7d/qQMZgUxVkI4Jytvt4S5LDnL8K2nJhl2JES2R6tJP6ggXHETEXXaR1ORbTd1R1xp8DT15to8DiTyi93YZYuxEjpruAEQAw42FevPd1z0g2fOnxhVjCADdV4IiO/WEe/IfcLE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1771172744;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=aOvVkAGMmDGRmpaiO3a7tqVK6PaSxhkzluwEG5HBouA=; 
 b=j8ZvYFjCBVflEGI14Hoc4uVD37PSHcsIMrQfPu7hvuvA9nAN4oCDPAgfGo0+8qUe/NwmpsNNEZCjuVij7vPA5LYpeXAETlChcIGOD0FgMFArZuBOPwE9YTso231BRKZrYMqoSFE0Qh3nzpbHw5clNho9dtscICeZy6B/y4gQZlU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1771172744; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=aOvVkAGMmDGRmpaiO3a7tqVK6PaSxhkzluwEG5HBouA=;
 b=JFVKdwNwYU6tmlxU1KnJeARmmZKRVpx3jUQpeUpPKSCNI3ysija4Uni2JSQh2lIj
 T4Gz0Qw6okvKKUQp7nrc90Pa5K6Eo2s5fW/7fswRNIsKEOMo09715W+NAYEs8imKXVK
 1+FySafSXZeFSZXTAuFizow3d1Kaw26WEiaUhIfY=
Received: by mx.zohomail.com with SMTPS id 1771172742794433.89339055545463;
 Sun, 15 Feb 2026 08:25:42 -0800 (PST)
Message-ID: <f5db498b-40e5-4141-b3cb-e36a624a838c@collabora.com>
Date: Sun, 15 Feb 2026 19:25:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio-gpu-virgl: Add virtio-gpu-virgl-hostmem-region type
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Joelle van Dyne <j@getutm.app>, Michael Tokarev <mjt@tls.msk.ru>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-stable@nongnu.org
References: <20260214-region-v1-1-229f00ae1f38@rsg.ci.i.u-tokyo.ac.jp>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <20260214-region-v1-1-229f00ae1f38@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender4-pp-f112.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hello Akihiko,

On 2/14/26 07:33, Akihiko Odaki wrote:
> Commit e27194e087ae ("virtio-gpu-virgl: correct parent for blob memory
> region") made the name member of MemoryRegion unset, causing a NULL
> pointer dereference[1]:
>> Thread 2 "qemu-system-x86" received signal SIGSEGV, Segmentation fault.
>> (gdb) bt
>> #0  0x00007ffff56565e2 in __strcmp_evex () at /lib64/libc.so.6
>> #1  0x0000555555841bdb in find_fd (head=0x5555572337d0 <cpr_state>,
>> name=0x0, id=0) at ../migration/cpr.c:68
>> #2  cpr_delete_fd (name=name@entry=0x0, id=id@entry=0) at
>> ../migration/cpr.c:77
>> #3  0x000055555582290a in qemu_ram_free (block=0x7ff7e93aa7f0) at
>> ../system/physmem.c:2615
>> #4  0x000055555581ae02 in memory_region_finalize (obj=<optimized out>)
>> at ../system/memory.c:1816
>> #5  0x0000555555a70ab9 in object_deinit (obj=<optimized out>,
>> type=<optimized out>) at ../qom/object.c:715
>> #6  object_finalize (data=0x7ff7e936eff0) at ../qom/object.c:729
>> #7  object_unref (objptr=0x7ff7e936eff0) at ../qom/object.c:1232
>> #8  0x0000555555814fae in memory_region_unref (mr=<optimized out>) at
>> ../system/memory.c:1848
>> #9  flatview_destroy (view=0x555559ed6c40) at ../system/memory.c:301
>> #10 0x0000555555bfc122 in call_rcu_thread (opaque=<optimized out>) at
>> ../util/rcu.c:324
>> #11 0x0000555555bf17a7 in qemu_thread_start (args=0x555557b99520) at
>> ../util/qemu-thread-posix.c:393
>> #12 0x00007ffff556f464 in start_thread () at /lib64/libc.so.6
>> #13 0x00007ffff55f25ac in __clone3 () at /lib64/libc.so.6
> 
> The intention of the aforementioned commit is to prevent a MemoryRegion
> from parenting itself while its references is counted indendependently
> of the device. To achieve the same goal, add a type of QOM objects that
> count references and parent MemoryRegions.
> 
> [1] https://lore.kernel.org/qemu-devel/4eb93d7a-1fa9-4b3c-8ad7-a2eb64f025a0@collabora.com/
> 
> Cc: qemu-stable@nongnu.org
> Fixes: e27194e087ae ("virtio-gpu-virgl: correct parent for blob memory region")
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> ---
>  hw/display/virtio-gpu-virgl.c | 54 +++++++++++++++++++++++++++++++------------
>  1 file changed, 39 insertions(+), 15 deletions(-)

Thanks a lot for the fix:

Tested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

-- 
Best regards,
Dmitry

