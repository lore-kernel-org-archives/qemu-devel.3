Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03F67E77199
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 22:40:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVeiv-0000o8-VU; Wed, 08 Jan 2025 17:40:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rob@landley.net>) id 1tVeit-0000o0-3B
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 17:40:23 -0500
Received: from iguana.tulip.relay.mailchannels.net ([23.83.218.253])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rob@landley.net>) id 1tVeiq-0001YF-Pi
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 17:40:22 -0500
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 87C57782513;
 Wed,  8 Jan 2025 22:40:18 +0000 (UTC)
Received: from pdx1-sub0-mail-a296.dreamhost.com
 (100-110-82-187.trex-nlb.outbound.svc.cluster.local [100.110.82.187])
 (Authenticated sender: dreamhost)
 by relay.mailchannels.net (Postfix) with ESMTPA id D28EC782564;
 Wed,  8 Jan 2025 22:40:17 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1736376017; a=rsa-sha256;
 cv=none;
 b=KLLGnNS07Aqs7ZDtHuNuETH6wJq1cr/3Yhpx2sBqXrPug2GUuT4OTegBmRzQyPzf59xdsV
 bhpChpq1uT9rw/Gvg+Md5tRohKMMPTurxOi9PN4hDKlrvimzIToNabvjJ/DeFRUVmVFldL
 8E1cE4x+Tp7ZMuYXDv0BTDgouNNJGQfKqwWgigSz92jYE/dnx16+sjyfPtiyu9ga+X7oaP
 ouBXd7EvOXbZvXibPLan+/NNsXfrFKIWeMBcr3WQi7rBDBKjf9u2uUgc7EL3txFy+TkZ5F
 e+gydDALBsZRC9itDfq8BnSOr+HuhrE26Vh+6y2qHEB1gzWSCPMJaFD2s7mrUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1736376017;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=CiLLIGrXROWnUE+7dov8gx0OCX6f8LLsvrqwNCwkm5w=;
 b=U5RGvA3bV8m5O6K1/EOM6wGG9uxBNMamaKBkMsBWKCgYU7wEQZ42CmxPl1U8Q9hcKQOgXR
 281wwuTgLm0vmEQZ5VhiW9QyJdbbBmbc7OXH5BXmo9oP8HOLC801HOKTQw5hLPKnSE0hOJ
 cX0hFI2N0tOwTHetRVpoRzDcxME9tRRHaodyrMr9ew3nWWHyf9/jPHPr2B5mM3WhWGMXt+
 N5PXsJLUNf4FBNEaxey1xz3+WOHRMHWbsNUixtUa7epXsNwwwAT+o1jappqA8Qkj/VQPqn
 FtGsmI/pdUEV3Ae4UB6uHMu6NM6A3qjk4QqxrgpWIPNitIAIsnNvXlNC3QgilQ==
ARC-Authentication-Results: i=1; rspamd-7df4dcbd86-b2l9f;
 auth=pass smtp.auth=dreamhost smtp.mailfrom=rob@landley.net
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|rob@landley.net
X-MailChannels-Auth-Id: dreamhost
X-Cellar-Lyrical: 45dd5af342f03663_1736376018112_2612468967
X-MC-Loop-Signature: 1736376018112:688906521
X-MC-Ingress-Time: 1736376018111
Received: from pdx1-sub0-mail-a296.dreamhost.com (pop.dreamhost.com
 [64.90.62.162]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.110.82.187 (trex/7.0.2); Wed, 08 Jan 2025 22:40:18 +0000
Received: from [172.16.32.88] (unknown [198.232.126.202])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 (Authenticated sender: rob@landley.net)
 by pdx1-sub0-mail-a296.dreamhost.com (Postfix) with ESMTPSA id 4YT2tT17Jfz7h; 
 Wed,  8 Jan 2025 14:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=landley.net;
 s=dreamhost; t=1736376017;
 bh=CiLLIGrXROWnUE+7dov8gx0OCX6f8LLsvrqwNCwkm5w=;
 h=Date:Subject:To:Cc:From:Content-Type:Content-Transfer-Encoding;
 b=KQV3cwhIBPD7cLyGxJKQLQHw+sr70u7NGM7Fo+OMG8MtRxDp93vTEOHG11NYsPEI+
 utP83hPqE7821m6k3ThxXhyJfvYYk0iC38sg8I7zD4qw8MTX1AEk0Mdhy7ElwnPJ0R
 XD/MLsx5glaO3+C8GMI7TGiybb80MyZzMs7Xkog8rbZJ7MBOivA1y/0spEnRODN99h
 0qJ+2DgvQEz23k9NNM1N/8A15BWf+BtmdkqtHUoIndfqv1MIwF7tmyylVMLEHWA4hc
 9pKT1iDtYv+lFHfY09FpkuIzONkI8yITaKykxC3mSS3q1tIxRVd5ResBTQXBQSyzNV
 xc/+1je576RlA==
Message-ID: <4b9b20a0-ab3a-4ef5-9ae5-5a32a2eb6be7@landley.net>
Date: Wed, 8 Jan 2025 16:40:16 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: or1k -M virt -hda and net.
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Stafford Horne <shorne@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Jason A. Donenfeld" <Jason@zx2c4.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Linux OpenRISC <linux-openrisc@vger.kernel.org>
References: <9b2761aa-8ee0-4399-b237-31e70e3ed165@landley.net>
 <Z0Cyx3i3z7Zl7XPm@antec> <31fa6255-8e0c-4d05-bad9-dd843c676244@landley.net>
 <Z0GSETLeT5w8B2DX@antec> <87a6b910-5af6-47ad-ad8d-b79f11a7cbf2@landley.net>
 <Z0LMqEqcdjkAxnN-@antec> <57c5207c-3aca-47cd-bfd3-3d7eb7be3c0f@landley.net>
 <Z2lgL31ZeSkO59MZ@antec> <8807078a-0673-4b27-8d58-4a2a3ce4987d@landley.net>
 <39511711-b86a-4ac6-8bd6-8dab824b693e@landley.net> <Z31k3zNN3pOdGWWK@antec>
 <0d2df37a-a167-445f-aacf-714a29587511@landley.net>
 <CAMuHMdU2XT=xHr3D4kWVSU=h4jJSoQj1RAdeXDNGEDXdOaqBjQ@mail.gmail.com>
 <ecdf9e8a-9886-43e6-bb02-bf04fc1e88a4@landley.net>
 <CAMuHMdVDhdkLEc-YuDCXHaCpkdtj0QL6wudXDFi0E=PqXyJDtA@mail.gmail.com>
Content-Language: en-US
From: Rob Landley <rob@landley.net>
In-Reply-To: <CAMuHMdVDhdkLEc-YuDCXHaCpkdtj0QL6wudXDFi0E=PqXyJDtA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=23.83.218.253; envelope-from=rob@landley.net;
 helo=iguana.tulip.relay.mailchannels.net
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_SBL_A=0.1 autolearn=ham autolearn_force=no
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

On 1/8/25 10:26, Geert Uytterhoeven wrote:
> Hi Rob,
> 
> On Wed, Jan 8, 2025 at 5:23 PM Rob Landley <rob@landley.net> wrote:
>> On 1/8/25 02:24, Geert Uytterhoeven wrote:
>>> On Tue, Jan 7, 2025 at 11:53 PM Rob Landley <rob@landley.net> wrote:
>>>> Microblaze has no /dev/?da (as in there's no device I could attach it to
>>>> even with the long option, I'd have to use NBD), sh4eb has -hda is
>>>> working but it's having some endianness hiccup with the network card
>>>> (works in sh4 but not sh4eb, I'm trying to track it down, I thought this
>>>> worked at one point), and the two "No kernel" ones legitimately have no
>>>
>>> That's using sh_eth, right?
>>
>> 8139cp: 8139cp: 10/100 PCI Ethernet driver v1.3 (Mar 22, 2004)
>> 8139cp 0000:00:02.0: enabling device (0000 -> 0003)
>> 8139cp 0000:00:02.0 eth0: RTL-8139C+ at 0x(ptrval), 52:54:00:12:34:56,
>> IRQ 128
>>
>> Is there a different driver I should use? That one works on sh4 little
>> endian with almost the same config.
> 
> Oh, you're using an SH4 SoC without internal Ethernet (sh7751 in landisk
> or rts7751r2d, I guess?). That indeed doesn't use sh_eth.

That's the driver used by qemu-system-sh4eb (I.E. -M r2d -cpu sh7751r) 
which has the advantage that it's _really_ easy to test. (Nightly cron 
job even, when I can get a proper server set up to run that...)

The sh2eb turtle board uses JCORE_EMAC which is still an out of tree 
driver. It's not secret, just too ugly to go upstream: done by a 
contractor and never cleaned up, full of half-finished IEEE-1588 support 
and so on. It used to be on 
https://web.archive.org/web/20200812035510/http://git.musl-libc.org/cgit/linux-sh/ 
but alas Rich purged his trees when he stopped being maintainer and 
archive.org didn't crawl that far down.

I have the patch locally if you care, but without the corresponding 
hardware, not much point attaching 1600 lines. (We sent several turtle 
boards to Glaubitz and his assistants last year, and at least one of the 
recipients asked for a copy of the ethernet driver patch, which I sent. 
Still applies and works as of the last kernel I updated on the board, 
6.18 I think? The update is a "pop the sd card, stick in laptop, copy 
files, move sd card back" kinda thing. I should do a linux image that 
can wget and kexec, but haven't yet... Anyway, doesn't help with this 
issue.)

All my other superh boards are A) little endian, B) still in storage 
from the move last may.

Rob

