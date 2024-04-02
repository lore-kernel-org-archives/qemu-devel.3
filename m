Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B954CD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 06:02:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrXDE-0005Vm-JS; Tue, 02 Apr 2024 02:01:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rrXDA-0005V0-LZ
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 02:01:32 -0400
Received: from cross.birch.relay.mailchannels.net ([23.83.209.46])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rrXD7-0004EF-9e
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 02:01:32 -0400
X-Sender-Id: _forwarded-from|134.3.94.10
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id D9D8D361F3D
 for <qemu-devel@nongnu.org>; Tue,  2 Apr 2024 06:01:26 +0000 (UTC)
Received: from outbound5a.eu.mailhop.org (unknown [127.0.0.6])
 (Authenticated sender: duocircle)
 by relay.mailchannels.net (Postfix) with ESMTPA id 31328362758
 for <qemu-devel@nongnu.org>; Tue,  2 Apr 2024 06:01:26 +0000 (UTC)
ARC-Seal: i=2; s=arc-2022; d=mailchannels.net; t=1712037686; a=rsa-sha256;
 cv=pass;
 b=rrVeDkf9iK2Bf9wuwX6asmGjGsJQag91wQn0uqs1Mozjt2XgTXlXieH6SyTfEaqED/uAG0
 gXeIyIRc5fVEtqBXchV2xD6ff6OHhYsSM5/LgERCjtFSkcyOyPH3kqyML8ctP6Sm1UPnvf
 /tmE4Q/24Z9kf1R1kgz/dZiNV75bcR1SsGpXJNfGdM6aofwS0tHFHbPRufLGNLuBl0ucUy
 EkywcIRMujI2hjRE+P8Vb9mQ5e5u5Eb1BvReAjXhD1KdCB4xEYGDVxGnqdd9FR5lbFdTzw
 SifGt+Lic47460CJLvZiRFkIU27KqpMtVuzb10Y+RsmJ86B73Eb8t+h2UPolpw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1712037686;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=fP35l6ELYxlWJBu/1QrwbVL97V9AMS7byIOUJK3speU=;
 b=Yax8QN3wiQQhPNmGJMtkYh2+TEw/AJwB6be1WFJ4X+oiWMaw60Je8z1LILmXcU0f7KDqCi
 Vx5UGm6xk3aIPtyvvj//88KR3VeZ8q7lLzDkBUuvbrjftYcbjpegsVia5DeHBGNbTb1I3V
 eV2KTQ/PyYxEBNnlV9bzJCX6fT+rruVl0VHsxCiAbNPq6CdbhjtipTQCcBezNzoRwkJD3l
 f37TqjRjGw1emK0uIa8ewUPkkDdTYmRcEdsT2IXSh0qVJtVFzaBNhtTfML2bEmPUbcBTsf
 PZeBo1Feg0SKEyfzJ7ScIJWxIwxeDaNawGDh1BpTwfdAaLek8zp/YcWzJeCT0A==
ARC-Authentication-Results: i=2; rspamd-6457dc597-7wg7w;
 arc=pass ("outbound.mailhop.org:s=arc-outbound20181012:i=1");
 auth=pass smtp.auth=duocircle smtp.mailfrom=svens@stackframe.org
X-Sender-Id: _forwarded-from|134.3.94.10
X-MC-Relay: Forwarding
X-MailChannels-SenderId: _forwarded-from|134.3.94.10
X-MailChannels-Auth-Id: duocircle
X-Obese-Chemical: 772e73be2bdfefc8_1712037686703_2811674782
X-MC-Loop-Signature: 1712037686703:715304454
X-MC-Ingress-Time: 1712037686702
Received: from outbound5a.eu.mailhop.org (outbound5a.eu.mailhop.org
 [3.124.88.253]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.118.210.220 (trex/6.9.2); Tue, 02 Apr 2024 06:01:26 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1712037645; cv=none;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 b=VbN3p1U/GJGZ9sIhLqNdHNvPg3br1nqmgnzdK6bvbwQ2a4WmWsA1kvCdC0nVO8K7fSVenA7WHkAe3
 l3CXJ1rbAszA5INjcKt1uE7U9LWEETagnoIWcLrnCuNaswfiRKAVzwN7a5m2JP6gUPzpJbJqaXh29L
 OTc5Y81+4DqfOcI2EO3HPDRCuaPemCqhmMWPpETQ2AdrKdW6Md7EHL+BJc4K7ljTpdQAS2Xmx+v2zL
 9h3KDSVCdWxJ8KTY/awygRhj4Gfha0ouopXu48j8h28i8MelBf9AtqJuy+1PZsSGqbiXCNidYnHWJz
 X+3gyzkpiLay9qLacbAgJex2zWN5rmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 h=content-type:mime-version:message-id:date:references:in-reply-to:subject:cc:
 to:from:dkim-signature:dkim-signature:dkim-signature:from;
 bh=fP35l6ELYxlWJBu/1QrwbVL97V9AMS7byIOUJK3speU=;
 b=Di3rqQHhMFR4uI4lHxew+P9052IicHyMK4s2gzwfbhTfNqPbpn2JjS2UGfiKWC6CSYQbYW93a0ssO
 2C1Hb9pLAeHlme6qlqtxQ7z0c5VmA1SCLku9rVQvd7TF266dlCJYL/VEQmgPXqMGwiOTskBt36/4i7
 fKuLlOG7e6CRxUyzHZ1tcoXQ+kGdxpJ/tGKUNW8sIPDjG/JTXXtdnBaYR4TeMv1RqVdcwodWtHAPuS
 YpJ3iEGH6Al+s4XtrAx0tUlB9gQ/JmYUvRoiIV0iY0vQAASgeWx1zVe1QGMYe9jp7t3TGosdaL6eur
 qotRhLl2NGt7nouM7QEfcpwkPBcaSDg==
ARC-Authentication-Results: i=1; outbound3.eu.mailhop.org;
 spf=pass smtp.mailfrom=stackframe.org smtp.remote-ip=130.180.31.158;
 dkim=pass header.d=stackframe.org header.s=dkim1 header.a=rsa-sha256
 header.b=i2BRJoRG; 
 dmarc=none header.from=stackframe.org;
 arc=none header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stackframe.org; s=duo-1634547266507-560c42ae;
 h=content-type:mime-version:message-id:date:references:in-reply-to:subject:cc:
 to:from:from; bh=fP35l6ELYxlWJBu/1QrwbVL97V9AMS7byIOUJK3speU=;
 b=LmFvRMdl8id9gUnUKn5uwur+wNeceMQvC7DMi2zBkDeGE+7S4KNUaYQ8EbdjWddY+UlX8vLYd6Hzh
 +PF5euNCeBnKlaVA9GOkiUb5TNdRsJFo91DX6FoDL4kWtkwnu7VOE4GEEtDOF/JTxMPl7ESUOKvDcs
 4NOaT/65zi0UZPlc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=dkim-high;
 h=content-type:mime-version:message-id:date:references:in-reply-to:subject:cc:
 to:from:from; bh=fP35l6ELYxlWJBu/1QrwbVL97V9AMS7byIOUJK3speU=;
 b=QHwgmcW15dB/X2xPnT6+TPnlO0+30VnQcpPiZe+Zy44dO5bGyo6gv+4MC0CCRcWB6QBNkq5FKG/90
 W/qv4DnPsNj1N4pzJxZjrvGup5jqlLIso7aPahwZ6e6GpM3FZvgd/QM7vdPuySfx8Kr+LGe2Q8pxLH
 Ar6FKL5fwy4Hsrkhe1oFNCVjIsmNKfDg3ADtRWHcFS5MWqWD/IO1LmbpBJ5ZasqNW/tmn7lnsU88Qd
 EaGfK8t8pzr1iyxI4KAKep0ViT68sMsMPwnMJJfpOwHpfUMKsyLz8EDhgnMVdIoGh5Vh54Y9MVOcYM
 BtTQkXIG6eeZ31gzkh8lWUgAklYGUSg==
X-Originating-IP: 130.180.31.158
X-MHO-RoutePath: dG9ta2lzdG5lcm51
X-MHO-User: 567eaccb-f0b6-11ee-b34b-eda7e384987e
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from mail.duncanthrax.net (mail.duncanthrax.net [130.180.31.158])
 by outbound3.eu.mailhop.org (Halon) with ESMTPSA
 id 567eaccb-f0b6-11ee-b34b-eda7e384987e;
 Tue, 02 Apr 2024 06:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=stackframe.org; s=dkim1; h=Content-Type:MIME-Version:Message-ID:Date:
 References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fP35l6ELYxlWJBu/1QrwbVL97V9AMS7byIOUJK3speU=; b=i2BRJoRGPoYosk5ZNsaDYZY1RC
 dqRXdFqHDb/McuT1eCI5UY4AJoEN0nDjgvglhvgKO3aXsnL8mgcSVegb9QRIuOys/tGnJm9+OF/0C
 h5wmyXYWpUka9pN7NXIYGudNCyq5cudBAVzNcrVFN6xYTGFb2QeXVagGXyX65+0xfMo4ZuD14t/94
 MTVNEHDFbCKDHC40VnO7VTppTBcRhs4yO/gkRIcuOTyaNfwJo1PaZg9VXQi0us+gujwC9NJ3+nz8O
 3DOoYz/nJgqqI3cQ2dBWunOF2QDVfFW8okwNOEeHdXoauxDvbKnQNuI3KmB7e6dUFgFVKGQom/FlN
 +03KCnEA==;
Received: from ip-134-003-094-010.um41.pools.vodafone-ip.de ([134.3.94.10]
 helo=t14.stackframe.org.stackframe.org)
 by mail.duncanthrax.net with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.96)
 (envelope-from <svens@stackframe.org>) id 1rrXCz-0079vE-3C;
 Tue, 02 Apr 2024 08:01:22 +0200
From: Sven Schnelle <svens@stackframe.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  Helge Deller <deller@gmx.de>
Subject: Re: [PATCH 2/3] target/hppa: mask offset bits in gva
In-Reply-To: <87jzlm1334.fsf@t14.stackframe.org> (Sven Schnelle's message of
 "Thu, 28 Mar 2024 22:03:27 +0100")
References: <20240324080945.991100-1-svens@stackframe.org>
 <20240324080945.991100-3-svens@stackframe.org>
 <ec050630-a866-4a51-8878-d35844fb66a6@linaro.org>
 <87jzlm1334.fsf@t14.stackframe.org>
Date: Tue, 02 Apr 2024 08:01:21 +0200
Message-ID: <87sf04xpzi.fsf@t14.stackframe.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=23.83.209.46; envelope-from=svens@stackframe.org;
 helo=cross.birch.relay.mailchannels.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Richard,

Sven Schnelle <svens@stackframe.org> writes:

> Richard Henderson <richard.henderson@linaro.org> writes:
>
>> On 3/23/24 22:09, Sven Schnelle wrote:
>>> The CPU seems to mask a few bits in the offset when running
>>> under HP-UX. ISR/IOR register contents for an address in
>>> the processor HPA (0xfffffffffffa0000) on my C8000 and J6750:
>>> running on Linux: 000000003fffffff c0000000fffa0500
>>> running on HP-UX: 00000000301fffff c0000000fffa0500
>>> I haven't found how this is switched (guess some diag in the
>>> firmware), but linux + seabios seems to handle that as well,
>>> so lets mask out the additional bits.
>>> Signed-off-by: Sven Schnelle <svens@stackframe.org>
>>> [..]
>> [..]
>> Though my argument would suggest the mask should be 0xff for the
>> 40-bit physical address, which is not what you see at all, so perhaps
>> the thing is moot.  I am at a loss to explain why or how HP-UX gets a
>> 7-bit hole in the ISR result.
>>
>> On the other hand, there are some not-well-documented shenanigans (aka
>> implementation defined behaviour) between Figure H-8 and Figure H-11,
>> where the 62-bit absolute address is expanded to a 64-bit logical
>> physical address and then compacted to a 40-bit implementation
>> physical address.
>>
>> We've already got hacks in place for this in hppa_abs_to_phys_pa2_w1,
>> which just truncates everything down to 40 bits.  But that's probably
>> not what the processor is really doing.
>
> I looked into this again, and it's caused by Space-ID hashing. HP-UX asks
> PDC/Firmware how many bits are used for the hashing. seabios returns
> zero, in which case HP-UX uses a default mask of 0xf01fffffffffffff.
> By modifying seabios, i can make HP-UX use the appropriate mask, but
> switching of SpaceID hashing entirely is impossible. The reason why
> the CPU doesn't strip the bits when running linux is that Linux switches
> of Space-ID hashing early in the startup code (before mm gets
> initialized).
>
> My J6750 Firmware only returns two values: 0 when Space-ID hashing is
> off, 0xfe0 when it is enabled. This is hardcoded in the firmware - the
> only thing PDC checks is a bit in Debug Register 2, which enables
> Space-ID hashing. 0xfe0 matches the 0xf01f... mask used by HP-UX
> pretty well.
>
> So if qemu wants to run 64 Bit HP-UX the proper way, i guess it needs
> to implement Space-ID hashing.

I wonder wether it would be acceptable to implement this masking in a
switchable way?

This would mean:

Implement dr2 and the mfdiag/mtdiag instructions. dr2 contains a bit
which enables/disables space id hashing. Seabios would then set
this bit when booting. Linux would disable it again during boot (this
would be the same like on real hardware), while HP-UX would leave it
enabled.

