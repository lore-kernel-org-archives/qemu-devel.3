Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E4D7C47DD9
	for <qemu-devel@archiver.kernel.org>; Sun, 24 Mar 2024 18:42:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1roSmu-0008UG-HH; Sun, 24 Mar 2024 14:41:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1roSms-0008Tk-0q
 for qemu-devel@nongnu.org; Sun, 24 Mar 2024 14:41:42 -0400
Received: from bactrian.maple.relay.mailchannels.net ([23.83.214.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1roSmo-0007FS-HF
 for qemu-devel@nongnu.org; Sun, 24 Mar 2024 14:41:41 -0400
X-Sender-Id: _forwarded-from|134.3.94.10
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 7608DC1D8D
 for <qemu-devel@nongnu.org>; Sun, 24 Mar 2024 18:41:36 +0000 (UTC)
Received: from outbound5c.eu.mailhop.org (unknown [127.0.0.6])
 (Authenticated sender: duocircle)
 by relay.mailchannels.net (Postfix) with ESMTPA id C0796C26F6
 for <qemu-devel@nongnu.org>; Sun, 24 Mar 2024 18:41:33 +0000 (UTC)
ARC-Seal: i=2; s=arc-2022; d=mailchannels.net; t=1711305694; a=rsa-sha256;
 cv=pass;
 b=kJSQTA1abBERRFNBUhaiWO8ZaxH6U98ZKbfsB/DwlyHY3OW6pb5K27FXmbt28WTtzXl8sw
 mwVIXRVw0ocKi8n76zRcqCrJMCmGEJNsSryRhQfQVS0Kj/RxzS7La+RwnxhENjMZeYz0hR
 5wtZchtrikHZGmC6sZLYk2X0SXY/+ht189AGXPgOxhhfFc1xUVX+J1R4UU8DncqhLPJVlL
 VXIT16sRJY/20Dl3OXo7c+gq1OiIW3pVUk1gws1kQv6Rx5qUwpgmhqSH4jZXeCMUR4xcgr
 vZ/fXBGVfwfifKH2Tw6T91Pj9fviofKuEzeVm/CAC6XkpRKPThoi9WdJR1+pdw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1711305694;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=nNId6ju5oP30/hQ7n3Lv5eDWwDzswxSJpae50FQjs8A=;
 b=TO5WetISDO6xyV7QQyFqSAnbBS+Dv4OML8PlkHqomZaULZYo3vb6+djWywBB/opJZclrcr
 9sH8/6su0u9ZlH5qk2/5SJtIB/uwM26D9Av6LZYUnNO7LHw0vRvOJQE7fuzlj4J5CWYJ98
 U+NLvXLCwlI7LhtWeELHEJCnKgXH4HspsTtMoUxUPgEZ/GQ1raguytmLazAnBewHyETEKC
 c5udfi82DVMWIxbEQAuYykcSve92pHnMRVYuHDWF5/1ptcqmp1TgPfqu/t2DNFuyZzQZlF
 5XA8g9Nsc2ppEW60Y/VhYE1xb8LrVNCPUP2GbpJ9dH/zUULyYAAJtOCh73abyw==
ARC-Authentication-Results: i=2; rspamd-6c65898bb7-xldnv;
 arc=pass ("outbound.mailhop.org:s=arc-outbound20181012:i=1");
 auth=pass smtp.auth=duocircle smtp.mailfrom=svens@stackframe.org
X-Sender-Id: _forwarded-from|134.3.94.10
X-MC-Relay: Forwarding
X-MailChannels-SenderId: _forwarded-from|134.3.94.10
X-MailChannels-Auth-Id: duocircle
X-Towering-Dime: 4724b5e128c2d0ae_1711305695169_2910126653
X-MC-Loop-Signature: 1711305695169:2129013992
X-MC-Ingress-Time: 1711305695168
Received: from outbound5c.eu.mailhop.org (outbound5c.eu.mailhop.org
 [3.125.148.246]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.99.130.176 (trex/6.9.2); Sun, 24 Mar 2024 18:41:35 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1711305656; cv=none;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 b=BTBZpjIqe4Z1ef27rP86q4YmDNvhWXmn6O3YvKzkYTttASo7LiT+eKDZ15n3RFtRCAhKc/EYXMcnY
 OjzN40QBLDRGhCREG+rr4X1XxEohqrLJ5EY39I1l2D9gFDyBXgsWA8qETir1PPfKXRP+kA1QOEsEmo
 eiT+o5B/HN5awa+9tFsfKT8n6VQh4DIOLGM6b1j3h9gu8K9hpQkL69uohmOtMQ9eDc1LI9PmNcIrxZ
 8jDfp4P86Huc4eGp0NplVnRkrPD2CRKO4DsRjbmiOHl20FL8q1c4VcRJRuE6vi5iIU+xtPgS5QQRrK
 HcqwskQEURNayxjaeTIuQshzEUHbrfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 h=content-type:mime-version:message-id:date:references:in-reply-to:subject:cc:
 to:from:dkim-signature:dkim-signature:dkim-signature:from;
 bh=nNId6ju5oP30/hQ7n3Lv5eDWwDzswxSJpae50FQjs8A=;
 b=gu3kSjaovkS10sSM3r/go63iyQTVBPWuYZssii4jsJNQgdrFV1OjgD+onCl8qF6A7z06Wb9r5aeII
 xZThswMu8oc9B4CzB/RnX+QPfXMWK0CClztfcl/r1x/y9rUy56PjyEhQSP3LzdTg5GJfmQ+0t6kkNo
 BNIk503FQ04HI2iFK3yJAbFP93XTRocDdjhqcgfytIVTg5DXaBCt9abd2Asb0xO/3XFhxd+s703wi4
 /1XF3FJJ1BrzSAvKsv55TSbBeHOwICnT1s6CTpH0WSuSlTQa20PWe/dHXomXM0javMCrFaG102jt4r
 vxVXuRZwABheZXAdVVoPAgzi+9GZpew==
ARC-Authentication-Results: i=1; outbound3.eu.mailhop.org;
 spf=pass smtp.mailfrom=stackframe.org smtp.remote-ip=130.180.31.158;
 dkim=pass header.d=stackframe.org header.s=dkim1 header.a=rsa-sha256
 header.b=E+qaJzHi; 
 dmarc=none header.from=stackframe.org;
 arc=none header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stackframe.org; s=duo-1634547266507-560c42ae;
 h=content-type:mime-version:message-id:date:references:in-reply-to:subject:cc:
 to:from:from; bh=nNId6ju5oP30/hQ7n3Lv5eDWwDzswxSJpae50FQjs8A=;
 b=S2bgvZNuN22VdpOiwJERWEu7aCps7eW/vyMTGguyZo50fstEzJqv6p7HDtBCZ+i13n4ZFKo5qt8G/
 kobX4dkG/kEgGhapcrzm7CZxzaYLyzPLx5LWi0+ym8CNtvvxkF5ml4F+WRtpMf9L2BOM2oRZgZeA1F
 juL1w3Dj3CTCVAXE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=dkim-high;
 h=content-type:mime-version:message-id:date:references:in-reply-to:subject:cc:
 to:from:from; bh=nNId6ju5oP30/hQ7n3Lv5eDWwDzswxSJpae50FQjs8A=;
 b=Y6OvKIde9Rv8oT7B3UGbL+x1Iol5ExIFZvrSCHpMBKNA7ZPGRYdyNXtg9GE8ImaoCqbjySY2srRI9
 VTgyDLHv24w0xXiDI5GvtXKlvf6fxZedGwuM1kDlukFHBa/oKx+WlKsCs96VRyeOeRBohJ+KvzYtu9
 D0RmlEjNfGUm7pFpXu6KNj5/eQc5svz5I12+9D+aIXtXUKDAkBwr1EpW4ze7skrwYsJv3mKOLkQTmI
 i4fSLsgGEBRpZuw5gF8Q7Csxthc/3ClTHvfCv74yIeilhEvV3atP0KNlVWbLBdCTnGxfw0QzmVy5ug
 H0ZUnPTn5W7vhXOzTJTgQ04UqCpB2DA==
X-Originating-IP: 130.180.31.158
X-MHO-RoutePath: dG9ta2lzdG5lcm51
X-MHO-User: 0b3bd118-ea0e-11ee-b285-eda7e384987e
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from mail.duncanthrax.net (mail.duncanthrax.net [130.180.31.158])
 by outbound3.eu.mailhop.org (Halon) with ESMTPSA
 id 0b3bd118-ea0e-11ee-b285-eda7e384987e;
 Sun, 24 Mar 2024 18:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=stackframe.org; s=dkim1; h=Content-Type:MIME-Version:Message-ID:Date:
 References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nNId6ju5oP30/hQ7n3Lv5eDWwDzswxSJpae50FQjs8A=; b=E+qaJzHiIXizv3bZcSy7hmbsBf
 Z56H5PHK7Qm5sOU3AxfpmWgugGKhnm70QkNLBOCXAMNZ/KsqEIiqwrvppXwkl4bBd9R2tqemFoaqz
 9D0LZGtl3Do+rj4BZE0ANFjWhuT3fdJVgfB8oNkHyAUz/MiOzIPotto39g3bJ23C3iP7iFOkrse9Q
 KlGIhXNZq24zV8fIlu2TCdPt2m27bBofYW6NjdVlrdF2uDnLtxSNcOt/34Wfh7RcaXVX/rdeyW+6e
 V+ZbcMj/w1gohygT0/7S+Eb/YiMKYYdKSsMtJh8prvHNTenpV/+oQFypT5RyhM3k4s43P06ZF/GqO
 S0urLyzA==;
Received: from ip-134-003-094-010.um41.pools.vodafone-ip.de ([134.3.94.10]
 helo=t14.stackframe.org.stackframe.org)
 by mail.duncanthrax.net with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.96)
 (envelope-from <svens@stackframe.org>) id 1roSmf-005Po8-09;
 Sun, 24 Mar 2024 19:41:29 +0100
From: Sven Schnelle <svens@stackframe.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  Helge Deller <deller@gmx.de>
Subject: Re: [PATCH 2/3] target/hppa: mask offset bits in gva
In-Reply-To: <ec050630-a866-4a51-8878-d35844fb66a6@linaro.org> (Richard
 Henderson's message of "Sun, 24 Mar 2024 08:13:24 -1000")
References: <20240324080945.991100-1-svens@stackframe.org>
 <20240324080945.991100-3-svens@stackframe.org>
 <ec050630-a866-4a51-8878-d35844fb66a6@linaro.org>
Date: Sun, 24 Mar 2024 19:41:28 +0100
Message-ID: <87o7b31nhj.fsf@t14.stackframe.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=23.83.214.9; envelope-from=svens@stackframe.org;
 helo=bactrian.maple.relay.mailchannels.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Hi Richard,

Richard Henderson <richard.henderson@linaro.org> writes:

> In particular Figure 2-14 for "data translation disabled" may be
> instructive.  Suppose the cpu does not implement all of the physical
> address lines (true for all extant pa-risc cpus; qemu implements 40
> bits to match pa-8500 iirc).  Suppose when reporting a trap with
> translation disabled, it is a truncated physical address that is used
> as input to Figure 2-14.
>
> If that is so, then the fix might be in hppa_set_ior_and_isr.  Perhaps
>
> -    env->cr[CR_ISR] &= 0x3fffffff;
> +    env->cr[CR_ISR] &= 0x301fffff;
>
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
>
> Anyhow, will you please try the hppa_set_ior_and_isr change and see if
> that fixes your HP-UX problems?

The problem occurs with data address translation - it's working without,
which is not suprising because no exception can happen there. But as
soon as the kernel enables address translation it will hit a data tlb
miss exception because it can't find 0xfffffffffffb0500 in the page
tables. Trying to truncate the ISR in hppa_set_ior_and_isr() for the
data translation enabled case leads to this loop:

hppa_tlb_fill_excp env=0x55bf06e976e0 addr=0x3ffffffffffb0500 size=4 type=0 mmu_idx=9
hppa_tlb_find_entry env=0x55bf06e976e0 ent=0x55bf06e97b30 valid=1 va_b=0x200000 va_e=0x2fffff pa=0x200000
hppa_tlb_get_physical_address env=0x55bf06e976e0 ret=-1 prot=5 addr=0x26170c phys=0x26170c
hppa_tlb_flush_ent env=0x55bf06e976e0 ent=0x55bf06e97bf0 va_b=0x301ffffffffb0000 va_e=0x301ffffffffb0fff pa=0xfffffffffffb0000
hppa_tlb_itlba env=0x55bf06e976e0 ent=0x55bf06e97bf0 va_b=0x301ffffffffb0000 va_e=0x301ffffffffb0fff pa=0xfffffffffffb0000
hppa_tlb_itlbp env=0x55bf06e976e0 ent=0x55bf06e97bf0 access_id=0 u=1 pl2=0 pl1=0 type=1 b=0 d=0 t=0

So qemu is looking up 0x3ffffffffffb0500 in the TLB, can't find it,
raises an exception, HP-UX says: "ah nice, i have a translation for
you", but that doesn't match because we're only stripping the bits
in the ISR.

As i was a bit puzzled in the beginning what's going on, i dumped the
pagetables and wrote a small dump program:

680000: val=000f47ff301fffff r2=110e0f0000000001 r1=01ffffffffe8ffe0 phys=fffffffff47ff000 4K aid=1 pl1=0, pl2=0 type=1 (DATA RW)
680020: val=000f47fe301fffff r2=110e0f0000000001 r1=01ffffffffe8ffc0 phys=fffffffff47fe000 4K aid=1 pl1=0, pl2=0 type=1 (DATA RW)
680060: val=000f47fc301fffff r2=110e0f0000000001 r1=01ffffffffe8ff80 phys=fffffffff47fc000 4K aid=1 pl1=0, pl2=0 type=1 (DATA RW)
7d5860: val=000fed3c301fffff r2=010e000000000001 r1=01fffffffffda780 phys=fffffffffed3c000 4K aid=1 pl1=0, pl2=0 type=1 (DATA RW)
7d58e0: val=000fed38301fffff r2=010e000000000001 r1=01fffffffffda700 phys=fffffffffed38000 4K aid=1 pl1=0, pl2=0 type=1 (DATA RW)
7d59a0: val=000fed32301fffff r2=010e000000000001 r1=01fffffffffda640 phys=fffffffffed32000 4K aid=1 pl1=0, pl2=0 type=1 (DATA RW)
7d59e0: val=000fed30301fffff r2=110e0f0000000001 r1=01fffffffffda600 phys=fffffffffed30000 4K aid=1 pl1=0, pl2=0 type=1 (DATA RW)
7d5a00: val=000fed2f301fffff r2=010e000000000001 r1=01fffffffffda5e0 phys=fffffffffed2f000 4K aid=1 pl1=0, pl2=0 type=1 (DATA RW)
7d5a20: val=000fed2e301fffff r2=010e000000000001 r1=01fffffffffda5c0 phys=fffffffffed2e000 4K aid=1 pl1=0, pl2=0 type=1 (DATA RW)
7d5a40: val=000fed2d301fffff r2=010e000000000001 r1=01fffffffffda5a0 phys=fffffffffed2d000 4K aid=1 pl1=0, pl2=0 type=1 (DATA RW)
7d5a60: val=000fed2c301fffff r2=010e000000000001 r1=01fffffffffda580 phys=fffffffffed2c000 4K aid=1 pl1=0, pl2=0 type=1 (DATA RW)
7d5a80: val=000fed2b301fffff r2=010e000000000001 r1=01fffffffffda560 phys=fffffffffed2b000 4K aid=1 pl1=0, pl2=0 type=1 (DATA RW)
7d5aa0: val=000fed2a301fffff r2=010e000000000001 r1=01fffffffffda540 phys=fffffffffed2a000 4K aid=1 pl1=0, pl2=0 type=1 (DATA RW)
7d5ac0: val=000fed29301fffff r2=010e000000000001 r1=01fffffffffda520 phys=fffffffffed29000 4K aid=1 pl1=0, pl2=0 type=1 (DATA RW)
7d5ae0: val=000fed28301fffff r2=010e000000000001 r1=01fffffffffda500 phys=fffffffffed28000 4K aid=1 pl1=0, pl2=0 type=1 (DATA RW)
7d5b00: val=000fed27301fffff r2=010e000000000001 r1=01fffffffffda4e0 phys=fffffffffed27000 4K aid=1 pl1=0, pl2=0 type=1 (DATA RW)
7d5b20: val=000fed26301fffff r2=010e000000000001 r1=01fffffffffda4c0 phys=fffffffffed26000 4K aid=1 pl1=0, pl2=0 type=1 (DATA RW)
7d5b40: val=000fed25301fffff r2=010e000000000001 r1=01fffffffffda4a0 phys=fffffffffed25000 4K aid=1 pl1=0, pl2=0 type=1 (DATA RW)
7d5b60: val=000fed24301fffff r2=010e000000000001 r1=01fffffffffda480 phys=fffffffffed24000 4K aid=1 pl1=0, pl2=0 type=1 (DATA RW)
7d5b80: val=000fed23301fffff r2=010e000000000001 r1=01fffffffffda460 phys=fffffffffed23000 4K aid=1 pl1=0, pl2=0 type=1 (DATA RW)
7d5ba0: val=000fed22301fffff r2=110e0f0000000001 r1=01fffffffffda440 phys=fffffffffed22000 4K aid=1 pl1=0, pl2=0 type=1 (DATA RW)
7d5bc0: val=000fed21301fffff r2=010e000000000001 r1=01fffffffffda420 phys=fffffffffed21000 4K aid=1 pl1=0, pl2=0 type=1 (DATA RW)
7d5be0: val=000fed20301fffff r2=010e000000000001 r1=01fffffffffda400 phys=fffffffffed20000 4K aid=1 pl1=0, pl2=0 type=1 (DATA RW)
7d5de0: val=000fed10301fffff r2=010e000000000001 r1=01fffffffffda200 phys=fffffffffed10000 4K aid=1 pl1=0, pl2=0 type=1 (DATA RW)
7d5fe0: val=000fed00301fffff r2=110e0f0000000001 r1=01fffffffffda000 phys=fffffffffed00000 4K aid=1 pl1=0, pl2=0 type=1 (DATA RW)
7f07e0: val=000fffc0301fffff r2=010e000000000001 r1=01fffffffffff800 phys=fffffffffffc0000 4K aid=1 pl1=0, pl2=0 type=1 (DATA RW)
7f09e0: val=000fffb0301fffff r2=110e0f0000000001 r1=01fffffffffff600 phys=fffffffffffb0000 4K aid=1 pl1=0, pl2=0 type=1 (DATA RW)

'val' is the value constructed from IOR/ISR, r1/r2 are the args for the
idtlbt instructions, while the GVA just stays in IOR/ISR. If you look
at the val value, you'll recognize the 0301ffff... part. First i was
assuming some bug when creating the pagetables, but dumping pagetables
on my C3750/J6750 showed the same values.

The fastpath of the fault handler is:

         $i_dtlb_miss_2_0      
$TLB$:0002a1e0 02 a0 08 a9    mfctl      IOR,r9
$TLB$:0002a1e4 d9 21 0a 6c    extrd,u,*  r9,51,20,r1
$TLB$:0002a1e8 02 80 08 a8    mfctl      ISR,r8
$TLB$:0002a1ec 35 18 00 00    copy       r8,r24
$TLB$:0002a1f0 f0 28 06 96    depd,*     r8,43,10,r1
$TLB$:0002a1f4 d9 11 1a aa    extrd,u,*  r8,53,54,r17
         dtlb_bl_patch_2_0                     
$TLB$:0002a1f8 e8 00 18 80    b          dtlbmss_PCXU
$TLB$:0002a1fc 0a 21 02 91    xor        r1,r17,r17
         dtlbmss_PCXU                              
$TLB$:0002ae40 d9 19 03 e0    extrd,u,*  r8,31,32,r25
$TLB$:0002ae44 0b 21 02 99    xor        r1,r25,r25
$TLB$:0002ae48 f3 19 0c 0c    depd,*     r25,31,20,r24
         pdir_base_patch_017                            
$TLB$:0002ae4c 20 20 00 0a    ldil       0x500000,r1
         pdir_shift_patch_017
$TLB$:0002ae50 f0 21 00 00    depd,z,*   r1,0x3f,0x20,r1
         pdir_mask_patch_017
$TLB$:0002ae54 f0 31 04 a8    depd,*     r17,58,24,r1
$TLB$:0002ae58 0c 20 10 d1    ldd        0x0(r1),r17
$TLB$:0002ae5c bf 11 20 5a    cmpb,*<>,n r17,r24,d_target_miss_PCXU
$TLB$:0002ae60 50 29 00 20    ldd        0x10(r1),r9
$TLB$:0002ae64 0c 30 10 c8    ldd        0x8(r1),r8
$TLB$:0002ae68 d9 10 02 de    extrd,u,*  r8,0x16,0x2,r16
$TLB$:0002ae6c 8e 06 20 12    cmpib,<>,n 0x3,r16,make_nop_if_split_TLB_2_0_7
$TLB$:0002ae70 05 09 18 00    idtlbt     r9,r8
$TLB$:0002ae74 00 00 0c a0    rfi,r
$TLB$:0002ae78 08 00 02 40    nop

So the patch above was the only thing i could come up with - if you have
any better idea, let me know.

I also patched linux to execute exactly the same instruction with the
same address (space is 0), and i've seen different ISR/IOR values
compared to the values presented when HPUX is running. I think the
only explanation is that HPUX or firmware switches the behaviour
during runtime.

