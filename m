Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22575EE57D0
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Dec 2025 08:05:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1varBz-0003IQ-86; Wed, 31 Dec 2025 03:04:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rob@landley.net>) id 1varBu-0003HA-3l
 for qemu-devel@nongnu.org; Wed, 31 Dec 2025 03:04:23 -0500
Received: from chocolate.elm.relay.mailchannels.net ([23.83.212.35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rob@landley.net>) id 1varBs-0004a3-1P
 for qemu-devel@nongnu.org; Wed, 31 Dec 2025 03:04:21 -0500
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id CC06D782646;
 Wed, 31 Dec 2025 08:04:16 +0000 (UTC)
Received: from pdx1-sub0-mail-a256.dreamhost.com
 (100-113-119-120.trex-nlb.outbound.svc.cluster.local [100.113.119.120])
 (Authenticated sender: dreamhost)
 by relay.mailchannels.net (Postfix) with ESMTPA id 438957826F4;
 Wed, 31 Dec 2025 08:04:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
 t=1767168254;
 b=hlMwThd6QmLIMNZ9+R6NFAQ7ffOJQf4jR22owqDcd8Aj8wO7EDCOKnQzh0erjhanGc5sNm
 7eECkH+UUq+R9Et0LpmxuE8rH86zTv1tm/7J+YzVQhWE3bDNrhrtu1I7wDC11f+lo4Xnnq
 WviH+oslvY9OqOQMSi5qn6WFlV8MSGzlo37nNsBG9K+qJFy89R04WPoss8G9L0YFSTTNvi
 2jdobFG23+sGdeAjVgbvwFGu5L/4TGnrC1W0IQcjNrAAlVfz5aDGAyqNIvrfEdvQ+wDa/A
 27q4SjxDEQh9U5tifuWVjby7ScNiUvTyiJEE5YfaTnzlEAeYktZtS//GlwS8UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1767168254;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=a/vGCNVRMBzR613XqxSZyPO2xpr4QIGt9uOM8K5zufk=;
 b=P9ZNsHSnZOG9QxauI3h/98n2fbcmrBSrwkBrinN7iW02JLzAiAqcJy63ddSW4Ag8eEQ0RC
 Vd4MFRYC6cWv8OHQ/c8KqtlR90pqNVDQ1v7OsGTtmOmQJEdX7ebUe6UztmmueAWKV92ZzY
 Lza1Wpn1YxXnmJnrm2wc8WxRVhiSvNPE9q2HvvSWlP1r4OksXUK4/0R83x6LURSqjVwAlf
 loHIcJiYxDGCab51prItJb+gsHS9oSMsOy3NdxV6ROT9yr+cC4mochHwdpYechRP605O2s
 2218goIpSpxYR64A/Az9C+FWqwTtO8A2hBsgCdzzQKhYm2g4UYBoBETNsaJ9NQ==
ARC-Authentication-Results: i=1; rspamd-85db7f4c96-bqrz9;
 auth=pass smtp.auth=dreamhost smtp.mailfrom=rob@landley.net
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
X-MC-Relay: Good
X-MailChannels-SenderId: dreamhost|x-authsender|rob@landley.net
X-MailChannels-Auth-Id: dreamhost
X-Celery-Tank: 627b7ec640042afe_1767168256566_4275684198
X-MC-Loop-Signature: 1767168256566:1705755685
X-MC-Ingress-Time: 1767168256564
Received: from pdx1-sub0-mail-a256.dreamhost.com (pop.dreamhost.com
 [64.90.62.162]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.113.119.120 (trex/7.1.3); Wed, 31 Dec 2025 08:04:16 +0000
Received: from [IPV6:2607:fb90:fa85:cea:c1aa:4813:f755:98f6] (unknown
 [172.56.10.2])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 (Authenticated sender: rob@landley.net)
 by pdx1-sub0-mail-a256.dreamhost.com (Postfix) with ESMTPSA id 4dh2Xs2VH4z106C;
 Wed, 31 Dec 2025 00:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=landley.net;
 s=dreamhost; t=1767168254;
 bh=a/vGCNVRMBzR613XqxSZyPO2xpr4QIGt9uOM8K5zufk=;
 h=Date:Subject:To:Cc:From:Content-Type:Content-Transfer-Encoding;
 b=dS/6W1i9sRXtWzTKqK6RoyLOJHYBBi5H3jDi11z1oAiwEDGuTybGhoHNawdtuZ5Lt
 FALEAMMpOh+FrGRE0O8BA5t3nvJ3h/5Aq+NXLZefmTjP1RHEghB49aVOdRoOGOhXeO
 12Zz1+/06GEbIrzsGfBrD0pIsaQeGcunAS6iRPfmHVfBlStswzDCARZPliBKucgxTK
 SFPTn/ktK774FE7aNBoiCWdjIo+53ITJpyuEdbGv7tL7RTjY6q+HKlo3Lfz9mEPTOE
 4C1glnhzX+OWyfT3XPM5rlRaaCRsty7p2hKiHyrt2DamI2GajYBzlBTNpRnSot+JP7
 MN91sl7kND/Lg==
Message-ID: <6b3fdecb-739b-4149-8736-2fb6bd209d10@landley.net>
Date: Wed, 31 Dec 2025 02:04:04 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: qemu-system-sh4eb build has something hinky in the ethernet
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Cc: Thorsten Glaser <tg@debian.org>, Michael Tokarev <mjt@tls.msk.ru>,
 security@debian.org,
 Debian QEMU Team <pkg-qemu-devel@lists.alioth.debian.org>,
 debian-ports@lists.debian.org
References: <aKi6IWVX2uIlGKnw@seger.debian.org>
 <Pine.BSM.4.64L.2508230023030.21591@herc.mirbsd.org>
 <6abe2750-5e2c-43a1-be57-1dc2ccabdd91@tls.msk.ru>
 <119d5858-52f4-ce1b-9ee7-9615ce2054b9@debian.org>
 <79f14fef-123f-4938-b069-10f07e7d0405@landley.net>
 <CAMuHMdXZNroJF=s8gXj_vguGPGjUvgLu7w2PZxQg9tcHtSkNyg@mail.gmail.com>
 <351ebd4d-8ec6-43fe-b308-a0e54801a33b@linaro.org>
Content-Language: en-US
From: Rob Landley <rob@landley.net>
In-Reply-To: <351ebd4d-8ec6-43fe-b308-a0e54801a33b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=23.83.212.35; envelope-from=rob@landley.net;
 helo=chocolate.elm.relay.mailchannels.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 11/24/25 01:18, Philippe Mathieu-Daudé wrote:
> On 1/9/25 09:47, Geert Uytterhoeven wrote:
> 
>> On Sun, 24 Aug 2025 at 20:40, Rob Landley <rob@landley.net> wrote:
>>> Anyway, this works fine on little endian, but the qemu-system-sh4eb
>>> build has something hinky in the ethernet, I haven't tackled it myself
>>> because I don't know whether the device emulation or the driver is
>>> what's missing an endian swap. (I don't want to fix it the "wrong way",
>>
>> That is using sh_eth, right?
>>
>> Last time I tried booting a big-endian ARM kernel on R-Car M2-W,
>> the Linux kernel booted fine, except for Ethernet.  So sh_eth is 
>> definitely
>> not big-endian clean.
> 
> qemu-system-sh4{eb} only emulates the R2D+ board, which AFAIK
> provides ethernet via a RTL8139 over PCI. While old, RTL8139
> is very tested and expected to have endianness well handled.

Expected, sure. In reality? Compare the sh4 vs sh4eb tarballs in 
https://landley.net/bin/mkroot/0.8.13/ (in each case extract and 
./run-qemu.sh should get you a shell prompt).

The sh4 one has working ethernet, the sh4eb one always reports link down 
and it doesn't seem to probe the mac address right. Built from almost 
the same configs, the only difference is:

https://github.com/landley/toybox/blob/0.8.13/mkroot/mkroot.sh#L297

Line 305 adds:
     [ "$CROSS" == sh4eb ] && KCONF+=,CPU_BIG_ENDIAN

When I tried to track it down, I didn't know if the kernel or qemu was 
what had it backwards, so it went back on the todo heap and composted...

>> [*] I didn't have a big-endian userspace.

That script builds one, the resulting binary tarball is at 
https://landley.net/bin/mkroot/0.8.13/sh2eb.tgz and the toolchain I used 
is at 
https://landley.net/bin/toolchains/25-03-2024/sh4eb-linux-musl-cross.tar.xz 
which was built with https://landley.net/toybox/faq.html#cross2

There might also be something wrong with -hda block device support, I'd 
have to check my notes. But I can work around lack of -hda with 
nbd-server, kinda hard to do it the other way...

Rob

