Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FAAECD11DF
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 21:04:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpwud-0006eV-5m; Thu, 28 Mar 2024 17:03:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rpwub-0006e7-D9
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 17:03:49 -0400
Received: from baboon.maple.relay.mailchannels.net ([23.83.214.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rpwuZ-0003ID-5O
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 17:03:49 -0400
X-Sender-Id: _forwarded-from|134.3.94.10
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id C7347802A72
 for <qemu-devel@nongnu.org>; Thu, 28 Mar 2024 21:03:39 +0000 (UTC)
Received: from outbound5d.eu.mailhop.org (unknown [127.0.0.6])
 (Authenticated sender: duocircle)
 by relay.mailchannels.net (Postfix) with ESMTPA id DFD98802B74
 for <qemu-devel@nongnu.org>; Thu, 28 Mar 2024 21:03:38 +0000 (UTC)
ARC-Seal: i=2; s=arc-2022; d=mailchannels.net; t=1711659819; a=rsa-sha256;
 cv=pass;
 b=qt7770ar3IBmWSgQ1rVhvoA+db4EDcUnQD16Bi0H5BDAmyyY+N68U6KVCBaJhg1UxFbkW4
 F7wrXH5mRBf7EhrIuVORlfG+AvbHeLCwWvIlvD6ZqP6gcTzhbav8DRqg0uesZqdtVqy7mI
 zweVQqZTeqSczcMLCKIk2u2mwz2uBVrvlVY3CNzh7w1j3EZF/cbCPi/SqxTBxMJe51Mp5l
 MziMmIkR6f6f1QYiEm95TOWtM0QveETJdbAlloW1Ag7cadLqMO0U4vlUrK7cjbZ3JM6NDn
 Orwc2B39lBZnzT1zeuVZ7eG4cFa3ZYLtfqJFmmc58Pl5nGIDjoWPjI7wS3kZiA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1711659819;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=7lg6m+ED3o0himtUb9PqC8sDaHKkKxEDbl3CnAZf4zM=;
 b=3s8VzOIG+6VJpN6g8YGqJxvSF7+sRpgYszcKvR8Pf0flQkDwhq19p5fQzYm3EmyeUbB4Cj
 BkUhftECjuJRzfRZ4Vy6JsdNvx2IeWXruDvpsNOst33q1w4P0sxjcepQfohPhuJuyYR31j
 Kjp5pAvLAxtNuUfNjdc2hRtahdINRKsipPRAsN9KWIlbBquglqsekpZhdJyC3FsMHvvEjg
 xAOibPVezuK+TvkCm7PDDpif1zbAfGVp8LwXL7d56GI02/ecAHPGWKDi+clH5TzHQzLXnD
 kXKvFn9CqbyTWtmv4ZWnK/xss++d/TV2W5/F2dC8J5BLrKfy18WEJMPJAQXPUg==
ARC-Authentication-Results: i=2; rspamd-699949c56f-5rhn9;
 arc=pass ("outbound.mailhop.org:s=arc-outbound20181012:i=1");
 auth=pass smtp.auth=duocircle smtp.mailfrom=svens@stackframe.org
X-Sender-Id: _forwarded-from|134.3.94.10
X-MC-Relay: Forwarding
X-MailChannels-SenderId: _forwarded-from|134.3.94.10
X-MailChannels-Auth-Id: duocircle
X-Supply-Gusty: 5db1231d19819635_1711659819397_865062672
X-MC-Loop-Signature: 1711659819397:2476100380
X-MC-Ingress-Time: 1711659819397
Received: from outbound5d.eu.mailhop.org (outbound5d.eu.mailhop.org
 [3.121.156.226]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.117.91.86 (trex/6.9.2); Thu, 28 Mar 2024 21:03:39 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1711659774; cv=none;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 b=exZ0QqGw/QZO3YqicoBd9GAyn8Q3TFXi/n5+DVe7RH6GnK96OelqZOmDMIi/L+hUML6ZIYZxk6DN5
 h9oK38B1nneSbez2DIv7vlvd+mfKugqJWhTw9vFbIdo+WG0Q8JiNplHZkuRYktg+YNGooUenVfPlf8
 ExynUq0XKFTDZUc+EfAAlfMdczjO4AiR07BM48kDLwLy9LhQXIpQgy0fpHSjQgax4tJwYrvHXOhedB
 XOBaH1F9PFNi7Yp8ihnqjIBpcvhLyk1BmzdlgZ1ikv33I259EqGNIKFh0FJDBIxZcTuo6kIUV/HReY
 2b3Wo8WIhMWsdxxeDGCW+JOX3orhDGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 h=content-type:mime-version:message-id:date:references:in-reply-to:subject:cc:
 to:from:dkim-signature:dkim-signature:dkim-signature:from;
 bh=7lg6m+ED3o0himtUb9PqC8sDaHKkKxEDbl3CnAZf4zM=;
 b=i1LfDzUj9TPTTKfCqiSBogiT6buyMPy6bs/Cxzvg1hV6FFAcy2vN4oz6GlIBw9q/uvTYm5azSwGOu
 UZqVY2qZMErsPs2ZfwCNDcfc5rf3heStIYh7nnKiOT7ry4bJEy8uqg62dfafk0z+9F6rHygPTaO9T8
 YxkddeJ7GehFri5Tg/hAmPeY2o63iZwxqJWDC31euaz8/Y3jmJoMMGVGyJNwA5u5F0teO+XY8xC1aM
 WH0qTpP0+jaS4SMOm8IIHu+qPEuLKwP+hdeWBlPoLAquQq5wyOxqxQk+e1NP802ti1G8nEWQOZEH29
 5+4aTH3VZhLqWJbZN7AonAJ2jYT+wrA==
ARC-Authentication-Results: i=1; outbound3.eu.mailhop.org;
 spf=pass smtp.mailfrom=stackframe.org smtp.remote-ip=130.180.31.158;
 dkim=pass header.d=stackframe.org header.s=dkim1 header.a=rsa-sha256
 header.b=VbZoOmhf; 
 dmarc=none header.from=stackframe.org;
 arc=none header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stackframe.org; s=duo-1634547266507-560c42ae;
 h=content-type:mime-version:message-id:date:references:in-reply-to:subject:cc:
 to:from:from; bh=7lg6m+ED3o0himtUb9PqC8sDaHKkKxEDbl3CnAZf4zM=;
 b=RhqPJxEnMqcKyejMNIUaY/w6Fz29/PRtX3fTIpil90yfy8kE8sybCOh+IIxJnxY/o2i/35rI+U859
 g7heh9a3Ol4ts2H5m8iHtQ/j10EDbdMqg4yCQ3NGRigfWVQjn101pYdqV2jxR1SL5954uVw+Vw2Gb0
 aCc3QLHapcwhJ1Qw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=dkim-high;
 h=content-type:mime-version:message-id:date:references:in-reply-to:subject:cc:
 to:from:from; bh=7lg6m+ED3o0himtUb9PqC8sDaHKkKxEDbl3CnAZf4zM=;
 b=o60w3TvgZMwMqz55Kt+oKhMOv57DQ+mU8zliWeO+5rzd8/oWMC0Mic7ssxStFT8lovRAHHkv/TTn2
 aRY457cV/29XP4fpRJSE/DqTZ8IXha93dJLs47OPNVOF7ttBJ2vD1w69wUTR+tqOPZ5gRiTNFLqvz5
 ZXIU1XB1jwrkQWGo2j9197CrdcoBV34PFwYjXt/X/vrl4DUBlyjY8YMjJcUmx7yNlRx5HS7enQ8am6
 dgffxtZbQyVod/l7szMikafVph7wLRO9ATF54jtgFUllCWPTCRpMhZ4VHWk9egyTK2PHutT64tvqmn
 YxHwJ8sVbiuELu26qivD+rIaQ11kFyw==
X-Originating-IP: 130.180.31.158
X-MHO-RoutePath: dG9ta2lzdG5lcm51
X-MHO-User: 89d73bee-ed46-11ee-b306-eda7e384987e
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from mail.duncanthrax.net (mail.duncanthrax.net [130.180.31.158])
 by outbound3.eu.mailhop.org (Halon) with ESMTPSA
 id 89d73bee-ed46-11ee-b306-eda7e384987e;
 Thu, 28 Mar 2024 21:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=stackframe.org; s=dkim1; h=Content-Type:MIME-Version:Message-ID:Date:
 References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7lg6m+ED3o0himtUb9PqC8sDaHKkKxEDbl3CnAZf4zM=; b=VbZoOmhfH88P7FUxitKpWPqE5e
 G7PzLfJVqim1YgmBBMS420zqbLzNBO312yc+IM+ZwgJclp8erFGa2bZsW8dNoTbGdZZONzcitAyF1
 51TqxJ3QIj9HM/jho7jqbxRKpcKn51BHLrQyM5OJfPviNeaOlhdIiuvP4AQWHMgeT/UxdNarndeod
 /uRmVhFpsfMHXoisdSuWRUH+6Ede2pZ1lqU1hMQVQwkSyQLPOlnBoznNZFV63b12iil4P8oWpV4Bp
 FlGYlfT7b0iKiSqiDOx14iVGA7aJE8+PptNaATkHdTdk4SjU/jHnQUotCxq3Cjhdd+rGrk3mGqCzq
 F56W0yWw==;
Received: from ip-134-003-094-010.um41.pools.vodafone-ip.de ([134.3.94.10]
 helo=t14.stackframe.org.stackframe.org)
 by mail.duncanthrax.net with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.96)
 (envelope-from <svens@stackframe.org>) id 1rpwuG-006Jor-2d;
 Thu, 28 Mar 2024 22:03:28 +0100
From: Sven Schnelle <svens@stackframe.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  Helge Deller <deller@gmx.de>
Subject: Re: [PATCH 2/3] target/hppa: mask offset bits in gva
In-Reply-To: <ec050630-a866-4a51-8878-d35844fb66a6@linaro.org> (Richard
 Henderson's message of "Sun, 24 Mar 2024 08:13:24 -1000")
References: <20240324080945.991100-1-svens@stackframe.org>
 <20240324080945.991100-3-svens@stackframe.org>
 <ec050630-a866-4a51-8878-d35844fb66a6@linaro.org>
Date: Thu, 28 Mar 2024 22:03:27 +0100
Message-ID: <87jzlm1334.fsf@t14.stackframe.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=23.83.214.8; envelope-from=svens@stackframe.org;
 helo=baboon.maple.relay.mailchannels.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Richard Henderson <richard.henderson@linaro.org> writes:

> On 3/23/24 22:09, Sven Schnelle wrote:
>> The CPU seems to mask a few bits in the offset when running
>> under HP-UX. ISR/IOR register contents for an address in
>> the processor HPA (0xfffffffffffa0000) on my C8000 and J6750:
>> running on Linux: 000000003fffffff c0000000fffa0500
>> running on HP-UX: 00000000301fffff c0000000fffa0500
>> I haven't found how this is switched (guess some diag in the
>> firmware), but linux + seabios seems to handle that as well,
>> so lets mask out the additional bits.
>> Signed-off-by: Sven Schnelle <svens@stackframe.org>
>> [..]
> [..]
> Though my argument would suggest the mask should be 0xff for the
> 40-bit physical address, which is not what you see at all, so perhaps
> the thing is moot.  I am at a loss to explain why or how HP-UX gets a
> 7-bit hole in the ISR result.
>
> On the other hand, there are some not-well-documented shenanigans (aka
> implementation defined behaviour) between Figure H-8 and Figure H-11,
> where the 62-bit absolute address is expanded to a 64-bit logical
> physical address and then compacted to a 40-bit implementation
> physical address.
>
> We've already got hacks in place for this in hppa_abs_to_phys_pa2_w1,
> which just truncates everything down to 40 bits.  But that's probably
> not what the processor is really doing.

I looked into this again, and it's caused by Space-ID hashing. HP-UX asks
PDC/Firmware how many bits are used for the hashing. seabios returns
zero, in which case HP-UX uses a default mask of 0xf01fffffffffffff.
By modifying seabios, i can make HP-UX use the appropriate mask, but
switching of SpaceID hashing entirely is impossible. The reason why
the CPU doesn't strip the bits when running linux is that Linux switches
of Space-ID hashing early in the startup code (before mm gets
initialized).

My J6750 Firmware only returns two values: 0 when Space-ID hashing is
off, 0xfe0 when it is enabled. This is hardcoded in the firmware - the
only thing PDC checks is a bit in Debug Register 2, which enables
Space-ID hashing. 0xfe0 matches the 0xf01f... mask used by HP-UX
pretty well.

So if qemu wants to run 64 Bit HP-UX the proper way, i guess it needs
to implement Space-ID hashing.

