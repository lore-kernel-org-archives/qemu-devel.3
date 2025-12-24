Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F18DE75453
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 13:49:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYPDO-0006Np-GW; Wed, 24 Dec 2025 08:47:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vYPD8-0006Jw-8l
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 08:47:32 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vYPD4-0003iC-F2
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 08:47:28 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 47721596A0B;
 Wed, 24 Dec 2025 14:47:22 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id wt3wnJuyeV6l; Wed, 24 Dec 2025 14:47:20 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 4BB91596A07; Wed, 24 Dec 2025 14:47:20 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 49FCE596A03;
 Wed, 24 Dec 2025 14:47:20 +0100 (CET)
Date: Wed, 24 Dec 2025 14:47:20 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 philmd@linaro.org
Subject: Re: [PATCH 0/6] Implement memory_region_new_* functions
In-Reply-To: <3a1bf99d-e011-4589-b7e9-662107befdc1@rsg.ci.i.u-tokyo.ac.jp>
Message-ID: <a9a43db6-1a1f-58f1-39c8-06213e9e610e@eik.bme.hu>
References: <cover.1766525089.git.balaton@eik.bme.hu>
 <3a1bf99d-e011-4589-b7e9-662107befdc1@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

On Wed, 24 Dec 2025, Akihiko Odaki wrote:
> On 2025/12/24 6:49, BALATON Zoltan wrote:
>> Our documentation says that memory regions are automatically freed
>> when the owner dies and the reference counting to do this is also
>> implemented. However this relies on the QOM free funtion that can only
>> be set by creating objects with object_new but memory API only
>> provides constructors that call object_initialize which clears the
>> free function that prevents QOM to manage the memory region lifetime.
>> Implement corresponding memory_region_new_* functions that do the same
>> as the memory_region_init_* functions but create the memory region
>> with object_new so the lifetime can be automatically managed by QOM as
>> documented.
>
> The documentation explains the existing functions so the discrepancy between 
> them you see should be fixed by updating them, not adding new ones.

Do you mean replacing memory_region_init_* with these memory_region_new_* 
functions? The memory_region_init_* is still useful for embedded memory 
regions that are managed by some other way which is also mentioned in the 
documentation as an alternative so I think both of them are useful for 
different cases. If you mean we need to update docs to refer to 
memory_region_new instead of memory_region_init at some places then I 
think you're right, the docs may also need to be updated or clarified.

Regards,
BALATON Zoltan

