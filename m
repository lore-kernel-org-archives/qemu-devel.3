Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A6D6D68BD5
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 21:16:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tC3fD-0002iM-2t; Fri, 15 Nov 2024 16:15:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rob@landley.net>) id 1tC3f9-0002i9-IJ
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 16:15:32 -0500
Received: from fly.ash.relay.mailchannels.net ([23.83.222.61])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rob@landley.net>) id 1tC3f3-0006ZT-8G
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 16:15:31 -0500
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 8AF07A439F;
 Fri, 15 Nov 2024 21:15:22 +0000 (UTC)
Received: from pdx1-sub0-mail-a230.dreamhost.com
 (trex-4.trex.outbound.svc.cluster.local [100.111.109.20])
 (Authenticated sender: dreamhost)
 by relay.mailchannels.net (Postfix) with ESMTPA id 017BAA4419;
 Fri, 15 Nov 2024 21:15:21 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1731705322; a=rsa-sha256;
 cv=none;
 b=HSOhYvbRVHwKZ7/K7ldlZJLxF94EuGd2vdzPdeTyW1yW8jJPTX3j6hoyAK5+OW9GV7uYIB
 5KMHYW6UYLslc3y/UUoCefpuSE5WuhrXHtMC3eJnkU6U2pcAX6pSZzWo5AZu9uiKjlzxlZ
 3fhBXEpd6NA6Bv/8w9tjhyl/a6P32JyvFOCOgjZU7FnPMAOpuBI/xbNU3f6Kn5IG8XME1T
 VX8QRpjMaqVSeWc9t8aVuzqkjXCL4sDiihR76ZxBKjBu4wnH4ZFWaeGVzMSXoh9L3XcCn/
 jZKsudrgZ+rLnuO131S4m6oGbNlYr0tdCNSPx9udHB/hPwLmlxfIS4KzKDx1Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1731705322;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=bnHDJj3FSMqdql4wKDMLP8seJIDIUf77rpVDcN9pyO0=;
 b=rNlu+CQUwh3lYMvdgX4NjQDZASMoQNoDDjmaE+GkMpK1uYZVqxd4JGnjSd0MgfysGjfcq9
 pjKMUX7usFOvQgDq5GiDcfcI+3eye3WKkQFnpW3r/B3X/SRGfjSbGv2Rc8hpS+6Ou5MXJB
 dIowv3qbVO31MmpgqFHCiiv63gwh4lgWHdw6df9h2iMYIH1ixUJ6KlxlJQ/ns4BXXipzNp
 PbqX8atPFFzGP941TZBB6zdNfp0yw9JI45NrtWjVZg4DnxvSEmwDJewA2C/7QPKiCAP82+
 1u3saTjZMYApZmuT9ow33RKUHrEkUceAcipV1+Wt+9q6xo3tl2SacSu+WWSMbg==
ARC-Authentication-Results: i=1; rspamd-645676964-hs78m;
 auth=pass smtp.auth=dreamhost smtp.mailfrom=rob@landley.net
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|rob@landley.net
X-MailChannels-Auth-Id: dreamhost
X-Tangy-Industry: 586817b56d429dc3_1731705322257_1742206103
X-MC-Loop-Signature: 1731705322257:1683565785
X-MC-Ingress-Time: 1731705322256
Received: from pdx1-sub0-mail-a230.dreamhost.com (pop.dreamhost.com
 [64.90.62.162]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.111.109.20 (trex/7.0.2); Fri, 15 Nov 2024 21:15:22 +0000
Received: from [172.22.7.54] (unknown [198.232.126.195])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 (Authenticated sender: rob@landley.net)
 by pdx1-sub0-mail-a230.dreamhost.com (Postfix) with ESMTPSA id 4XqqYP3GRJzNT; 
 Fri, 15 Nov 2024 13:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=landley.net;
 s=dreamhost; t=1731705321;
 bh=bnHDJj3FSMqdql4wKDMLP8seJIDIUf77rpVDcN9pyO0=;
 h=Date:Subject:To:From:Content-Type:Content-Transfer-Encoding;
 b=WRsRdsNyX0rmO9Z0dImCb4COp82WHQz2bSA0+Hg8rGpyF2r+kpiPHftvDQiQtSoZU
 GbBq8mnydStMfYElnaATsim2RgAzm0nvfL0CRn8BLHOSaF8uFwzdNVnyw2izK5jajv
 C6iinydxti8oAMQWyidm1VgHwwtn5vixw9psdBTgwuPyZl+s+awzfu9Q+nf4NWtrQM
 +cLHK+V/JFq81ittJIC6yZZyJEciD4b2MsTutwePqJtI9SZEPE2FFqvmG1PCqS/Hxf
 By3Ie2rwqH4eZV+hOeXn9eZX6wMB2PGZbZ1XV8A5IITxd2SUFaMObvyCzVOghYCktn
 wbOG6+vSDJ54A==
Message-ID: <a3778af5-5f69-4a6c-b24a-a72b35b88a01@landley.net>
Date: Fri, 15 Nov 2024 15:15:20 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: "make clean" after "git pull" runs configure before cleaning.
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>
References: <86871f60-983e-4172-a6e6-1bd4b1e4e5c0@landley.net>
 <8f168636-3468-4dc7-9de2-a5958df97c2d@redhat.com>
Content-Language: en-US
From: Rob Landley <rob@landley.net>
In-Reply-To: <8f168636-3468-4dc7-9de2-a5958df97c2d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=23.83.222.61; envelope-from=rob@landley.net;
 helo=fly.ash.relay.mailchannels.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 11/14/24 17:33, Paolo Bonzini wrote:
> On 11/15/24 00:10, Rob Landley wrote:
>> Seems a _bit_ awkward to do that (and potentially fail on a random new 
>> dependency) just to delete it all again?
> 
> That's just how Make works.

Linux and busybox and so on use make, and I've never seen "make clean" 
trigger a "make defconfig" there.

(Or do you mean "Make" is different from "gmake" the way "kbuild" is 
different from "make" and you distinguish your build system from the 
make command by capitalizing it? Alas the last time I understood 
everything qemu was doing was probably 2008, pace of change got too fast 
sometime after dyngen was replaced by tcg...)

> If it finds that Makefile is old, it first 
> regenerates Makefile and only then looks at the target.

I'm pretty sure the make command doesn't internally know how to run the 
configure script, the Makefile would have to include plumbing to make 
that decision, and it at least LOOKS like it's trying not to in the top 
level Makefile line 336:

   # Don't try to regenerate Makefile or configure
   # We don't generate any of them
   Makefile: ;
   configure: ;

I note that if you run "make clean" twice in a row, it doesn't re-run 
configure in between. It's only when a stale target exists, which seems 
to involve dependencies making a decision. (The file NOT existing 
doesn't trigger action, but the file being "old" does.)

>  See "How 
> Makefiles Are Remade" in GNU Make's manual:

I've read it, albeit not recently. (I have a probably post-1.0 todo item 
to write a gmake compatible make for toybox, long story.)

> "After reading in all 
> makefiles 'make' will consider each as a goal target, in the order in 
> which they were processed, and attempt to update it. [...] After all 
> makefiles have been checked, if any have actually been changed, 'make' 
> starts with a clean slate and reads all the makefiles over again".

So it's an artifact of the way you're using make, and hard to fix then?

*shrug* I'd use 'git clean -fdx' instead but I'm not sure how that 
interacts with multiple submodules.

>> And I dunno what it's saying about the meson version
> 
> QEMU bundles a copy of Meson because it needs a very new one.

Ok.

> Paolo

Rob

