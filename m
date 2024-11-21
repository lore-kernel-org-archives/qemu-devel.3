Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD13DE64039
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 22:33:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEFjF-0007PN-BG; Thu, 21 Nov 2024 17:32:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rob@landley.net>) id 1tEFjB-0007NX-MJ
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 17:32:46 -0500
Received: from zebra.cherry.relay.mailchannels.net ([23.83.223.195])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rob@landley.net>) id 1tEFj7-0001fA-IR
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 17:32:43 -0500
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 8BB7843EB7;
 Thu, 21 Nov 2024 22:32:35 +0000 (UTC)
Received: from pdx1-sub0-mail-a315.dreamhost.com
 (100-118-20-128.trex-nlb.outbound.svc.cluster.local [100.118.20.128])
 (Authenticated sender: dreamhost)
 by relay.mailchannels.net (Postfix) with ESMTPA id E435443F0F;
 Thu, 21 Nov 2024 22:32:26 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1732228347; a=rsa-sha256;
 cv=none;
 b=iajx2u2V3pBVEVPvDGB3N/pNaehUUikrLNxC7YN8/4T08JS8m5xCr0nNGVrEwIZII1lcOB
 RKnWtwqd7bRZZFTsNwkHTWmsGGD2ITdtsQUqamc78rMsf077jN9Nv28R59FfVsJqZzUTZ4
 2DQ0U3GqTc4iFIUI5Sc9HqrGd8EzMmNgcK8Pq4QGGvZkxn4GnvaoAOcVg+NTsTfUJfp+1j
 Hg9uJng6kwnVnH5cp0qXhyR8YPPjOlB7YCiLoBdqvMmO//P+iFgDxG36BMKJZiKQ8NgU2b
 zuUwWbwGorMXCmQQIn1d/irAcS1mxX89PH8KLhEP68uI1oHQKOa/OB0AxFaKcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1732228347;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=IUyFMZpXlsiAza49FQh8+sfQgasUAed2cv+XvxtBzqw=;
 b=1G0PQTDmXCnoO5iHeJt4JIW+vCwBrXOGaJEF/IzsUJiHJX/3eDeiAs7XFq5MMQhtM3iwUa
 /ib8WzL/UCtHJRy/B0JBnJANqGzblhJhbOB6ProH39Q9O709LxR0/dP+/ma1n5GFWsbRAk
 SRL2QJtTeuQTKrfAz21fXYmvFdysUyNIqe9UQ9Y3ImTuDFq9s50coGUMtBE2ITkJaaFYBb
 jZ0oaljJghx0AVa1YuKcEw+HTz6+C8sTOclhLZ8NRlgvcf2oUQ0sPaxXuUZO7+PxS6+oru
 COd2Zuvm2lpiCzNm6oYRuQgLVzhZ7FreXhUk6WZkflhKQzAqiwi5VOv+VOY23A==
ARC-Authentication-Results: i=1; rspamd-868968d99d-5gt4k;
 auth=pass smtp.auth=dreamhost smtp.mailfrom=rob@landley.net
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|rob@landley.net
X-MailChannels-Auth-Id: dreamhost
X-Sponge-Cooing: 73db6f5329e25082_1732228347474_473107517
X-MC-Loop-Signature: 1732228347474:4139495536
X-MC-Ingress-Time: 1732228347473
Received: from pdx1-sub0-mail-a315.dreamhost.com (pop.dreamhost.com
 [64.90.62.162]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.118.20.128 (trex/7.0.2); Thu, 21 Nov 2024 22:32:27 +0000
Received: from [172.22.7.54] (unknown [198.232.126.195])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: rob@landley.net)
 by pdx1-sub0-mail-a315.dreamhost.com (Postfix) with ESMTPSA id 4XvXzZ1qGqz4f; 
 Thu, 21 Nov 2024 14:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=landley.net;
 s=dreamhost; t=1732228346;
 bh=IUyFMZpXlsiAza49FQh8+sfQgasUAed2cv+XvxtBzqw=;
 h=Date:Subject:To:Cc:From:Content-Type:Content-Transfer-Encoding;
 b=MS0vL0AQtGfB8MSPzGkPhxQoP3/jQVNJqVrC/pCPZzJeiHTyM77ZBa2W5VEhdsbiO
 xmfZ9GTlhf+rQv8pmFG9EvyBBi6fbHm17EaqMGKRKqHANWBNvCnF8jbdW0lgrgMyxM
 MBX5sNwwBhdE8H9HFhZI2xfC/42QEr9vN9Qv+L+h1RZh4NBQOb1yGKbbgnTx/AYn8x
 2srY95INgMTn4oJo5hZgkpla6dVgK7Wbi7OyHCvCK2rr7OzsRNXA3AOcqHjTS5fVI8
 jXPxT4rTXSPTNvOTevNqiPqByWAPyO74K4Hrh68/VJhtoebLE+7N4B7J4exn+YY51H
 IU3YUvSMSkjWw==
Message-ID: <9b2761aa-8ee0-4399-b237-31e70e3ed165@landley.net>
Date: Thu, 21 Nov 2024 16:32:25 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: QEMU commit 0a923be2f642 broke my or1k image.
To: Stafford Horne <shorne@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Jason A. Donenfeld" <Jason@zx2c4.com>,
 QEMU Developers <qemu-devel@nongnu.org>
References: <afac091f-08cb-0f6d-4c01-bfa4421e7a47@landley.net>
 <Zufcf4iAqosZ7VBf@antec>
Content-Language: en-US
From: Rob Landley <rob@landley.net>
In-Reply-To: <Zufcf4iAqosZ7VBf@antec>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=23.83.223.195; envelope-from=rob@landley.net;
 helo=zebra.cherry.relay.mailchannels.net
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On 9/16/24 02:21, Stafford Horne wrote:
> On Wed, Sep 11, 2024 at 12:42:58AM -0500, Rob Landley wrote:
>> Grab this tarball, extract it, and ./run-qemu.sh. It's a simple
>> linux+initramfs image that boots to a shell prompt.
>>
>>    https://landley.net/bin/mkroot/latest/or1k.tgz
>>
>> QEMU 7.0.0 ran that linux-or1k image, but newer qemu does not. I besected the
>> issue to qemu commit 0a923be2f642, and it's still broken in current tip of tree.
> 
> Patch is:
> 
>   0a923be2f6 ("hw/openrisc: page-align FDT address")
> 
>> Rebuilding the image with current linux-git doesn't seem to make a difference?
>> Either way I get serial output with old qemu and don't with current qemu.
> 
> The bisect looks strange as it's only moving a page boundary, it could be
> correct but it seems harmeless.  There is another commit close by that was
> causing issues with serial output for the barebox guys and this is a patch I am
> working on to fix it.
> 
> https://lore.kernel.org/qemu-devel/20240908062756.70514-1-shorne@gmail.com/
> 
> I will try to get time today to look at your tarball and run it, but if not have
> a look at this patch.

I just regression tested linux-6.12 against qemu-9.2.0-rc1 and I'm still 
getting no output from or1k, with the current image or the old or1k 
release image that worked under old qemu versions.

I tried applying your serial patch to current qemu, and it made no 
difference: still no output booting the image.

Alas I can no longer test that reverting the commit I identified (git 
show $HASH | patch -p1 -r) makes it work again in current qemu (although 
it did at one point, that's a standard sanity check at the end of bisect 
for me), and I can't fix it up by hand either because 
hw/openrisc/openrisc_sim.c no longer contains the string "load_sim", 
looks like it got collated with common code for other architectures.

I'm happy to tweak the kernel config if qemu changed in a way that broke 
compatibility with old images (I assume _you_ have a kernel that boots), 
but I was hoping "this week's kernel release" would have any necessary 
patches to work with QEMU's changed ABI.

Thanks,

Rob

