Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56CA0C02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 17:01:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thX9B-0008Ez-GD; Mon, 10 Feb 2025 12:00:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1thX8q-00087t-Tb; Mon, 10 Feb 2025 12:00:18 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1thX8o-0000mu-FC; Mon, 10 Feb 2025 12:00:16 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 905B44E600E;
 Mon, 10 Feb 2025 18:00:10 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id Yq3XppFdbPmm; Mon, 10 Feb 2025 18:00:08 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id A78344E6033; Mon, 10 Feb 2025 18:00:08 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id A548774577D;
 Mon, 10 Feb 2025 18:00:08 +0100 (CET)
Date: Mon, 10 Feb 2025 18:00:08 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Bernhard Beschow <shentey@gmail.com>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Subject: Re: [PATCH] hw/ppc/e500: Partial implementation of local access
 window registers
In-Reply-To: <69e08a66-b146-4d76-080f-7fa6f4a0a13f@eik.bme.hu>
Message-ID: <9998591d-9cdc-6e80-aa09-ba922bacb235@eik.bme.hu>
References: <20250115211544.307124E602F@zero.eik.bme.hu>
 <22e114ac-2c3f-76f1-2172-9adf0c50ad5f@eik.bme.hu>
 <DE6FAB3B-F994-47B8-95A5-9D1BFD6B621F@gmail.com>
 <06F97BE3-057D-4D9D-AAAF-2B7438358BB8@gmail.com>
 <69e08a66-b146-4d76-080f-7fa6f4a0a13f@eik.bme.hu>
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

On Sun, 2 Feb 2025, BALATON Zoltan wrote:
> On Sat, 1 Feb 2025, Bernhard Beschow wrote:
>>> I've implemented that in my e500-fdt branch which I want to send as an 
>>> RFC. I still need to clean it up. Once it's on the list we could make a 
>>> plan how to turn it into a p10xx. Would that work for you?
>
> Sure, I can try to test your patches once they are submitted to the list and 
> rebase my changes on top if they still needed. I've just submitted these so 
> you can incorporate them in your tree so I have less to rebase but I see you 
> already have most of these. I'm OK to wait until your tree is cleaned and 
> submitted but it seems there are a lot of patches so it might take a while. I 
> don't expect that you can get it merged before the next release. Some of the 
> patches may need several versions or alternative approaches until they can be 
> merged. For example I expect problems with allowing ',' in device names as 
> this is something that was removed before to avoid the need of quoting or 
> something like that. But I'm not in a hurry as I don't have much free time 
> for it anyway so only come back to this time to time and it's far from 
> anything useful yet.

To solve the problem of needing reintroducing ',' in type names and adding 
a new subclass for every compatible device variant (which might also be 
wasteful if this creates a new type struct for these) maybe you'd have to 
attach a string array to classes or type info instead with all the 
compatible names and then look for the type to instantiate based on that. 
I don't know what the best way would be for that, adding a class property 
or adding this array to type? And maybe you need a new funcion to find the 
type instead of qdev_try_new().

I don't know how this works but the types seem to be stored in a hash 
table so instead of an array of compatible names maybe all that's needed 
is to allow adding alternative names for the same type in this type hash 
table or add another hash table for those alternative names then types 
could be looked up the same way from that by the compatible names without 
needing to subclass them multiple times. If these are separated hash 
tables then ',' may be allowed in the compatible names table or if it's 
the same types table then maybe the names can be encoded in some way to 
separate them from normal type names and avoid the need to reintroduce 
','. These are just vague ideas but maybe gives you some inspiration for 
which way to go to get closer to be able to upstream it.

Regards,
BALATON Zoltan

