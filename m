Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 673C4CD128A
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Apr 2024 21:32:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrPFZ-0005Ls-Lm; Mon, 01 Apr 2024 17:31:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rrPFQ-0005LU-PY
 for qemu-devel@nongnu.org; Mon, 01 Apr 2024 17:31:26 -0400
Received: from chameleon.oak.relay.mailchannels.net ([23.83.215.33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rrPFN-0002lO-NI
 for qemu-devel@nongnu.org; Mon, 01 Apr 2024 17:31:20 -0400
X-Sender-Id: _forwarded-from|134.3.94.10
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id B2D93C2038
 for <qemu-devel@nongnu.org>; Mon,  1 Apr 2024 21:31:14 +0000 (UTC)
Received: from outbound5i.eu.mailhop.org (unknown [127.0.0.6])
 (Authenticated sender: duocircle)
 by relay.mailchannels.net (Postfix) with ESMTPA id DE103C2028
 for <qemu-devel@nongnu.org>; Mon,  1 Apr 2024 21:31:13 +0000 (UTC)
ARC-Seal: i=2; s=arc-2022; d=mailchannels.net; t=1712007074; a=rsa-sha256;
 cv=fail;
 b=XU5FB1VzgyBDBj4bbpBx55Hk7Ni25qqMs8o11OiZ76OR+b1b4DpHda0oIL7pXvM26FEvaH
 X3+HdsUm5oCe16thtbehl5EkRv90lPBUoZJGKmNMGg5l87oDIjJcQ/cXPtcirMV+v6VueP
 Wq8qL5NmmTKiFEK6MMRB8vFmDdBWW972SoZwVKcYLBBNI7ZXH0iHCDKjGsFdGhh4zT1rRF
 0wXvTKT4DEJ83sedm0x01G3K1AElBdk1X28kKIyCPnsoQLgSb3EjLhqAG6KCLrEB0t2oov
 1YyJtqe7A1Ru+SwusZ3S74VKXchCSm+ep9BcgmELVT6pKJfDjBRAac56FC/r1Q==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1712007074;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=hjCIhKSUxqB6SwYPMVyKrjKywDar818iiV37vjVFaOQ=;
 b=7jzTJFarkyhCFDDBKIoEfJJrXSRW/5Ywbim7bH2wF+0iVc7WE9LoPSmMXzPO0t3vKruO77
 zxnQ75cJz0iT3c/yXEPmv7miY5HuQi6sC2yPvcxa6UpJ7FC6LyLOYBREZFpn0fTYUOurtl
 fU30+GiaxsHbPLD29ubYNtvUmJ2ZamfrbMNxhGYrQLYkhMhQu+8ajxAnTJTQ0M26gQ5yKy
 v7a6ciabfHFDnrc6u6VP55UpAfjj5UmDIvwydiJDGlLEPW+hVtJPmoXojBRqq/b/mBPct9
 3t+JD57ZDI/ZdhBWRwD8NTln98SIGbJOORpaVYS1Mfk0X53Yz8ZOkNZBdDVusg==
ARC-Authentication-Results: i=2; rspamd-6457dc597-dlj9r;
 arc=reject ("signature check failed: fail, {[1] =
 sig:outbound.mailhop.org:reject}");
 auth=pass smtp.auth=duocircle smtp.mailfrom=svens@stackframe.org
X-Sender-Id: _forwarded-from|134.3.94.10
X-MC-Relay: Forwarding
X-MailChannels-SenderId: _forwarded-from|134.3.94.10
X-MailChannels-Auth-Id: duocircle
X-Army-Well-Made: 6f85c2723647b6fe_1712007074420_1390461208
X-MC-Loop-Signature: 1712007074420:4053290765
X-MC-Ingress-Time: 1712007074420
Received: from outbound5i.eu.mailhop.org (outbound5i.eu.mailhop.org
 [35.156.234.212]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.123.121.28 (trex/6.9.2); Mon, 01 Apr 2024 21:31:14 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1712006945; cv=none;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 b=Iu1IOCgbYYjuIcwq1umpr0nAYvbTx12h8+rinIbBWxZoTDfz0exJ18rlfV6qR+dmbEuYkIxmp6z2Y
 HYumiEmE8bnf6SnLeWOD9f9JfG7qseAe5bgGPt+7aijAwkDkAa0d9+GSkwOEnmj+opCVckejksTOwj
 9RLiq9es45T0CzNm9b0P30TDcUAXYuvSkmnotBMoWI9gwhk/fj1gQu9L6LZSuWIWVxLBgbGGxheeER
 0wVxqykp69F/rlp313mZBrdf7pluG5QwWfOOX5mUCm6ku0CpM+620XafT9RgBKKiuLzBo3VX8FmjL3
 4kejOIZ+6MMxHsWyoeKpJF4hMuZZVkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 h=content-type:mime-version:message-id:date:references:in-reply-to:subject:cc:
 to:from:dkim-signature:dkim-signature:dkim-signature:from;
 bh=Z2jXM3+qCbtOvmOkXVzWAsLlaEJwnms+yl2SKjNv0Ac=;
 b=SSKKXWgZBRlHQ4LgY/z8aocm5hUMvsc/jJZi32l8Zp9W8ZqhJxd4ZhBY882VDZf3DOHqueNd4pa/Q
 Q0wV2OyCL+r+s8/V0mlAUYWY8oTSDbN8s4a0zvnBSRSkPmkX9V+13zT6x/gbtelSWdU5TxVBZHCKjU
 nkUg+yKOq2BrMi5uN1uiw6S3t6HDGqZeohFQCxiltTf4rcs4s3k0Vdcjiu9f8Udp89N/8QpBTZ2CcZ
 8wshpMkWzqyiRtO/KYzDyPryXtvLnpJpQ1nhoa5twvJ62L8vhYbP4eCDdHqS1hwMTqC13HrtkwPtz0
 k1hNqi5oSOjnJFyMHASRX/APzJklGeQ==
ARC-Authentication-Results: i=1; outbound2.eu.mailhop.org;
 spf=pass smtp.mailfrom=stackframe.org smtp.remote-ip=130.180.31.158;
 dkim=pass header.d=stackframe.org header.s=dkim1 header.a=rsa-sha256
 header.b=aYtGYj8R; 
 dmarc=none header.from=stackframe.org;
 arc=none header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stackframe.org; s=duo-1634547266507-560c42ae;
 h=content-type:mime-version:message-id:date:references:in-reply-to:subject:cc:
 to:from:from; bh=Z2jXM3+qCbtOvmOkXVzWAsLlaEJwnms+yl2SKjNv0Ac=;
 b=AnPmexX9CVcE7G0CHDg4NnCgKnaTw6sUJkF7977UBlefK60YLyS3T42BFT8TZbDlNWuljeqi+bXx6
 kyIKAtcC3kBm4wnF+T/RTIuocPBqvg0wzOmQcse33ujhafRIkWFUcZPYdBfXbWnLANzcuiTgv4nNuU
 54sTgIJuxHhrZltE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=dkim-high;
 h=content-type:mime-version:message-id:date:references:in-reply-to:subject:cc:
 to:from:from; bh=Z2jXM3+qCbtOvmOkXVzWAsLlaEJwnms+yl2SKjNv0Ac=;
 b=PFBgfJftJX2eZRm1AWIxqo50IMv1hQXbMv6Ho8Hh3Grv0HD/xJfd30Td/gO/8UJVqVxWtR/O04XD0
 5rPHwuc8ix3bT6ZnyFvETTeRJmgHtHoibFwknP/1Viqk/dNH97uA8YxX2/yKcoWNFshp7bFtcXjF0h
 +bLUwgV82BdDAaccvoXfxcUolfK+LKKLPN+eCRt93/PvEHslSZaWaWubZFtlBvcoaMSn7ZtzXdzecp
 hsIRgUo3l+FLEPeAkR7H61caMaJqYF2N5mI0YhdB1OJbJu75P0V+1U0q5D4hb7nMA7zpyqN/kS/9Zn
 SXkXyG9qmUhBQ5I51VWRrSA2EU9itgQ==
X-Originating-IP: 130.180.31.158
X-MHO-RoutePath: dG9ta2lzdG5lcm51
X-MHO-User: dc0a41e8-f06e-11ee-b8f0-9b9d9be6ef2c
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from mail.duncanthrax.net (mail.duncanthrax.net [130.180.31.158])
 by outbound2.eu.mailhop.org (Halon) with ESMTPSA
 id dc0a41e8-f06e-11ee-b8f0-9b9d9be6ef2c;
 Mon, 01 Apr 2024 21:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=stackframe.org; s=dkim1; h=Content-Type:MIME-Version:Message-ID:Date:
 References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Z2jXM3+qCbtOvmOkXVzWAsLlaEJwnms+yl2SKjNv0Ac=; b=aYtGYj8R8BYytWwW4oOOn4FXRQ
 9t79jRvQjGx31KWBMBpGxTDZNfHZHX5nVluobnGuaDfNfDV3BLmKYx2YoFXc2If950yN1UVd2zjYl
 DTuQXiINO4Web6d6TSFzWRqDl0JV5+C1uPSCShQxixNftulV4m2s7wd3k31uLO/Ytspa5LHLoKPO9
 5BEb3Kql6u08BreLEjviH97NVSe6b7Abl+zz6Rus9ggGnI5TCkBczQxUPcinhDA7SEdetlC2Pl7uI
 3e6mzHztCnkcqRUYHDlIWh49KhDOXDYtm+dayI4XedwnBspscJooW77oykBelQx8mnr5J9T22OI8/
 aKI+4BIA==;
Received: from ip-134-003-094-010.um41.pools.vodafone-ip.de ([134.3.94.10]
 helo=t14.stackframe.org.stackframe.org)
 by mail.duncanthrax.net with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.96)
 (envelope-from <svens@stackframe.org>) id 1rrPFF-0076Up-1V;
 Mon, 01 Apr 2024 23:31:09 +0200
From: Sven Schnelle <svens@stackframe.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  Helge Deller <deller@gmx.de>
Subject: Re: [PATCH] target/hppa: mask upper iaoq bits when returning to
 narrow mode
In-Reply-To: <f7e67270-5ff1-4d93-979c-3b501d8fca98@linaro.org> (Richard
 Henderson's message of "Mon, 1 Apr 2024 11:21:02 -1000")
References: <20240401145201.2175873-1-svens@stackframe.org>
 <0f5697e6-da79-424b-866d-40d11b4db0bb@linaro.org>
 <87msqczujz.fsf@t14.stackframe.org>
 <f7e67270-5ff1-4d93-979c-3b501d8fca98@linaro.org>
Date: Mon, 01 Apr 2024 23:31:08 +0200
Message-ID: <87a5mczs6b.fsf@t14.stackframe.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=23.83.215.33; envelope-from=svens@stackframe.org;
 helo=chameleon.oak.relay.mailchannels.net
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

Richard Henderson <richard.henderson@linaro.org> writes:

> On 4/1/24 10:39, Sven Schnelle wrote:
>> Richard Henderson <richard.henderson@linaro.org> writes:
>>>> For unknown reasons, Java 1.5 on 64-bit HP-UX 11.11 does signed
>>>> computation of the new IAOQ value in the signal handler. In the
>>>> current code these bits are not masked when returning to narrow
>>>> mode, causing java to crash.
>>>> Signed-off-by: Sven Schnelle <svens@stackframe.org>
>> INT   3530: instruction tlb miss fault @ 0000000000000000:ffffffffc0000007 for 0000000000000000:40000000c0000004
>> INT   3531: external interrupt @ 0000000000000000:ffffffffc0000007 for 0000000000000000:40000000c0000004
>> INT   3532: instruction tlb miss fault @ 0000000000000000:ffffffffc0000007 for 0000000000000000:40000000c0000004
>> INT   3533: external interrupt @ 0000000000000000:ffffffffc0000007 for 0000000000000000:40000000c0000004
>> So the PSW indicates narrow mode, but IAOQ seems to contain all the
>> ffff... bits.
>
> I believe that the IAOQ *should* contain all of the bits.  The bits
> should only be discarded when we form the GVA -- exactly like "ldb
> 0(r2)", where r2 contains all of the offset bits.  In particular, I
> believe that "b,l .+8,r2" should copy all of those bits to r2 from
> IAOQ_Back+4 and the fact that mainline crops those bits is a bug.
>
>
>> Also interesting is that the second TLB miss (INT 3530)
>> misses the Space ID.
>
> That is a bit curious, yes.
>
>> Any thoughts? Otherwise i need to investigate and make a wrong patch
>> again :-)
>> The only patch i have on top which touches target/hppa is the space
>> id
>> hashing mask patch:
>
> Ok.  I do have an hppa 11.11 iso -- for clarity, what is your command-line?

I'm using:

./build/qemu-system-hppa -M C3700 -m 1024 -cdrom /home/svens/parisc/hpux/11.11/HP-UX 11.11 (2004-12) - TCOE - Core OS, Install and Recovery - DVD.iso -bios /home/svens/seabios-hppa/out-64/hppa-firmware64.img -nographic -hda /home/svens/parisc/hpux1111.img -boot d


The qemu i'm using is: https://github.com/svenschnelle/qemu/tree/devel

You also need a special seabios-hppa version, because a special console
driver is needed:

https://github.com/hdeller/seabios-hppa/tree/devel

