Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39D87CD128A
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Apr 2024 20:40:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrORj-0002Rv-OI; Mon, 01 Apr 2024 16:40:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rrORh-0002RO-1G
 for qemu-devel@nongnu.org; Mon, 01 Apr 2024 16:39:57 -0400
Received: from bee.elm.relay.mailchannels.net ([23.83.212.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rrORe-000151-D7
 for qemu-devel@nongnu.org; Mon, 01 Apr 2024 16:39:56 -0400
X-Sender-Id: _forwarded-from|134.3.94.10
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 02064824C4
 for <qemu-devel@nongnu.org>; Mon,  1 Apr 2024 20:39:52 +0000 (UTC)
Received: from outbound5c.eu.mailhop.org (unknown [127.0.0.6])
 (Authenticated sender: duocircle)
 by relay.mailchannels.net (Postfix) with ESMTPA id 63B4C8281B
 for <qemu-devel@nongnu.org>; Mon,  1 Apr 2024 20:39:50 +0000 (UTC)
ARC-Seal: i=2; s=arc-2022; d=mailchannels.net; t=1712003990; a=rsa-sha256;
 cv=pass;
 b=7ilGqg+D19KjTEUZ4YnWr3xpHvcE7OD0CzdhicpWbqVvJV6NQVGXYmjnM485olAWcqg2ts
 fxw9bypHDQAUCxPyuQfodL14Tk8Ee81TdsPI5hPwuSlaWYpRzEzQZP67q9bNvH1fOlM2AI
 V8cEyQEihH801ok5OvxUObyGIqSO8DkShPo4rPev/cO3Eii7Y9dST/XSd86n+xR1bfCTrv
 5/awfUfz6dP+jgfe9aFpVcPiMSkgmeTaaMfRXN4OzdbMhghvkFdQabeXtM/L/PCW1qLPJv
 ecCmowOUV+KX1we5B1p2cceLnv0dSMzFbSUezqz+gNVCb1OhdMqUIReK12+T+w==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1712003990;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=+xDuqM1y+9afx6G2VEVPqcC9IF23PPcFvskFFGvXNbo=;
 b=H+3vBWG9tSQPLgYzRGgT+LsTEh7rrqHlQLHwSwXqNV+bahQw3Hohe/qn4M2f6qMlIaoU8E
 mKh9jkp3ZP2AOGGneKHn7UsDVLF13Wwn2gDwb9qqCnwcMoYipalH747aD9BmtmhlK8H3ZQ
 0PxrHjRYyRzevdWoesPtqHo/HnnuRpi/fJPMqUlklV7HnWReWaHjAdy9L74q5CrQEqfteK
 L/JWzQtJ5Gxk7J+MnR/XPvU/T48/C+J9dvPhVc2Vy5h5FVXtDLT6QPqf8zLz+qhrnhoQdz
 g18rXqgT/eGv/wAF0XnO7mgpCp4XDGJnxXwomuYNHsMDCP34JPMYI1YGU83gYg==
ARC-Authentication-Results: i=2; rspamd-5ffc56d49c-wk9jg;
 arc=pass ("outbound.mailhop.org:s=arc-outbound20181012:i=1");
 auth=pass smtp.auth=duocircle smtp.mailfrom=svens@stackframe.org
X-Sender-Id: _forwarded-from|134.3.94.10
X-MC-Relay: Forwarding
X-MailChannels-SenderId: _forwarded-from|134.3.94.10
X-MailChannels-Auth-Id: duocircle
X-Wiry-Suffer: 267523d965d0c6b2_1712003991784_3783055491
X-MC-Loop-Signature: 1712003991784:3799853324
X-MC-Ingress-Time: 1712003991784
Received: from outbound5c.eu.mailhop.org (outbound5c.eu.mailhop.org
 [3.125.148.246]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.125.113.83 (trex/6.9.2); Mon, 01 Apr 2024 20:39:51 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1712003949; cv=none;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 b=J0fYdP8iQaPiCfXSw/qJSj5V71YuvSf6THh4QsDftH5dZJ7sXRgmy/yz+36ATpke7yqWaV6N3tqM/
 NNQR/YEuYgvk9MkFKPfbfje0BCz9SVn+Aj+CCenznSphEwfGYRp1i6wHNhIYv4x45hBE6gtwE4PyJn
 ch0YFgQVmEBaOb0s6GesUQw94rxpoPdqVlsrcTpbjEsU5GkpN3m77R7DN4Heenv94RX5gTqwYF9u7O
 8HHeS509+Kt0FVKbdZomwGk0kljwDK+P5rnx5jO6/WvTM9bDtfRWi/YQTYu1U/GrgYf2FrZ7G8KXOG
 bKJ8u3HCBAQAqkSjJo/4iJqgbRjaVmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 h=content-type:mime-version:message-id:date:references:in-reply-to:subject:cc:
 to:from:dkim-signature:dkim-signature:dkim-signature:from;
 bh=+xDuqM1y+9afx6G2VEVPqcC9IF23PPcFvskFFGvXNbo=;
 b=AhJqsWAIPWMl+++1mUeqSai+S3Irlo5IpW3EGgLMJpYZmVPIhnNZUm+7fjZ5dSj/YR2qVTeW7aLg3
 cogowZb05iZS76DzYzeysV1xAWLzskuBo0oE/8QF7k9UrMk6RxM3WsHkVuZyC7K5SdIXwrN1StW/2g
 cixlawgYj4rJRKF7FD59si9xOkHWZA6VNJWtocBZH+7I0ORf9y9RHKLzMOhblvvAJJAcTeZ2lKpL2y
 ZUCHUhiCw9r/OAG4JQzni2qYWa1T9G2Rp5XK+jJhhyjUoSCjaHy7+q/NdlTGyGA4U7URp2lA6ey5pL
 l4n0i7AlpqusLpizuY6KVNDMgzgGhlQ==
ARC-Authentication-Results: i=1; outbound3.eu.mailhop.org;
 spf=pass smtp.mailfrom=stackframe.org smtp.remote-ip=130.180.31.158;
 dkim=pass header.d=stackframe.org header.s=dkim1 header.a=rsa-sha256
 header.b=QS8LgNXX; 
 dmarc=none header.from=stackframe.org;
 arc=none header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stackframe.org; s=duo-1634547266507-560c42ae;
 h=content-type:mime-version:message-id:date:references:in-reply-to:subject:cc:
 to:from:from; bh=+xDuqM1y+9afx6G2VEVPqcC9IF23PPcFvskFFGvXNbo=;
 b=mSy0wkoKv9PYM5n2gv4z8XXuLIzjOCMhC56zOzxEtiNismpCbSHr/u/DAHGlAwji4BKN+q60PL5J8
 VSpmSYt2y2ZfGAH6V2mer+Iwt+lSuAiwCcOkWAO5RM3hIXebhUKgTNKzxEAeun7/D4jqPDT0UnOprY
 cA4UcCMx4t3Swqf0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=dkim-high;
 h=content-type:mime-version:message-id:date:references:in-reply-to:subject:cc:
 to:from:from; bh=+xDuqM1y+9afx6G2VEVPqcC9IF23PPcFvskFFGvXNbo=;
 b=BxDX3NtPVBtNk7egNnhkEnub42sPATkWyYVYfQZePBIB6rjl7d3nznq1r/yQILDZMtMI7w6YvzESS
 3b9hu0judZuATX5p3rm7IqBC28mLorGFFDDb08t4HgbyWaijy2RnpdxjS61NyIDtv9wA2v8lf1B2qA
 ckv3G8+9jMqJI5nG7v1Lf6eaht1FsgBCJiGVP6G9dCMb8lGIsEw3+03USBogLU4D2AQyyXJb3NcMCs
 YY9KI9U1VWbYThpyn1YEGQVs3qfhWzL18IJDqHwkzyVjTCvw2Owe9ONgG0CLvcVlUy4vRypXBtTc0f
 yC1+IOylAfXPfEA8Nf9q6e8aAic789w==
X-Originating-IP: 130.180.31.158
X-MHO-RoutePath: dG9ta2lzdG5lcm51
X-MHO-User: e2158c5d-f067-11ee-b348-eda7e384987e
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from mail.duncanthrax.net (mail.duncanthrax.net [130.180.31.158])
 by outbound3.eu.mailhop.org (Halon) with ESMTPSA
 id e2158c5d-f067-11ee-b348-eda7e384987e;
 Mon, 01 Apr 2024 20:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=stackframe.org; s=dkim1; h=Content-Type:MIME-Version:Message-ID:Date:
 References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+xDuqM1y+9afx6G2VEVPqcC9IF23PPcFvskFFGvXNbo=; b=QS8LgNXXEi1g2xVmKJ1JLaKV99
 LKRjNIG2U/zictVCO1sXk0h0ykf0NnYQi2x0HSlySXcbDt8NIAz2IbFKc/EROu5XtPGpCus1NGKho
 56m9lJJ6HyIr+/OYZwUj1pQLHBd9tGgvOKkFMYu/gIebvk/oHB2/1PFx62AActC6Aahp1IQF4lyMR
 PQmbqVS+HTkhMpH8A4rkIUvQXxiCNsL/lzdvndhE+56BJrYDdbh3lqsFl+5pjsiOJw5fN4TB32/zY
 nTy6SRKiBnum9PIa5DBBbXWKqH3M+lwWO2sgHfkdqNOJ6WADn8nCEmlK4MsQNT/VokkyyyQFCzfHe
 pGpdrV/g==;
Received: from ip-134-003-094-010.um41.pools.vodafone-ip.de ([134.3.94.10]
 helo=t14.stackframe.org.stackframe.org)
 by mail.duncanthrax.net with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.96)
 (envelope-from <svens@stackframe.org>) id 1rrORV-00769S-2Y;
 Mon, 01 Apr 2024 22:39:45 +0200
From: Sven Schnelle <svens@stackframe.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  Helge Deller <deller@gmx.de>
Subject: Re: [PATCH] target/hppa: mask upper iaoq bits when returning to
 narrow mode
In-Reply-To: <0f5697e6-da79-424b-866d-40d11b4db0bb@linaro.org> (Richard
 Henderson's message of "Mon, 1 Apr 2024 08:43:58 -1000")
References: <20240401145201.2175873-1-svens@stackframe.org>
 <0f5697e6-da79-424b-866d-40d11b4db0bb@linaro.org>
Date: Mon, 01 Apr 2024 22:39:44 +0200
Message-ID: <87msqczujz.fsf@t14.stackframe.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=23.83.212.14; envelope-from=svens@stackframe.org;
 helo=bee.elm.relay.mailchannels.net
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

> On 4/1/24 04:52, Sven Schnelle wrote:
>> For unknown reasons, Java 1.5 on 64-bit HP-UX 11.11 does signed
>> computation of the new IAOQ value in the signal handler. In the
>> current code these bits are not masked when returning to narrow
>> mode, causing java to crash.
>> Signed-off-by: Sven Schnelle <svens@stackframe.org>
>> ---
>>   target/hppa/sys_helper.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>> diff --git a/target/hppa/sys_helper.c b/target/hppa/sys_helper.c
>> index 208e51c086..3bbc2da71b 100644
>> --- a/target/hppa/sys_helper.c
>> +++ b/target/hppa/sys_helper.c
>> @@ -83,6 +83,10 @@ void HELPER(rfi)(CPUHPPAState *env)
>>       env->iaoq_f = env->cr[CR_IIAOQ];
>>       env->iaoq_b = env->cr_back[1];
>>   +    if (!(env->cr[CR_IPSW] & PSW_W)) {
>> +        env->iaoq_f &= 0xffffffff;
>> +        env->iaoq_b &= 0xffffffff;
>> +    }
>
> This shouldn't be needed, because we are already masking these bits
> later, in cpu_get_tb_cpu_state.  But I do have some cleanups in this
> area, and perhaps one of them matters.

Ouch. Appologies, i removed that masking to make 64 bit work, but forgot
about that. Sorry. I tried your branch, but i'm not able to boot 64 bit HP-UX
(it wasn't working before without additional changes, so your branch
doesn't break it). However, i would like to get your oppinion before
debugging. The code is:

IN: 
0xef4680000002c18:   20 20 08 01   ldil L%-40000000,r1
0xef4680000002c1c:   e4 20 e0 08   be,l 4(sr7,r1),sr0,r31
0xef4680000002c20:   34 16 00 72   ldi 39,r22

IA_F 0ef46800:0000000000002c23 (0ef4680000002c23)
IA_B 01e27c00:ffffffffc0000007 (01e27c00c0000007)
PSW  000000000004000f CB   0000000000000000 ---------C----QPDI
GR00 0000000000000000 GR01 ffffffffc0000000 GR02 0000000000002ac3 GR03 000000007a000000
GR04 0000000000000002 GR05 000000007a000034 GR06 000000007a000040 GR07 000000007a000050
GR08 000000007a0000e0 GR09 8000000040001000 GR10 0000000000000003 GR11 0000000000000006
GR12 00000000001ecee8 GR13 00000000ffffffff GR14 0000000000000801 GR15 0000000000000006
GR16 80000000400020c0 GR17 000000000001e720 GR18 0000000000000008 GR19 0000000000000000
GR20 000000000ef46800 GR21 000000007a000060 GR22 0000000000000000 GR23 000000007a000050
GR24 0000000000000000 GR25 0000000000000000 GR26 000000007a0020f0 GR27 0000000040008410
GR28 0000000000000002 GR29 0000000000000000 GR30 000000007a002160 GR31 0000000000002c27
RC   000000007fffffff CR1  0000000000000000 CR2  0000000000000000 CR3  0000000000000000
CR4  0000000000000000 CR5  0000000000000000 CR6  0000000000000002 CR7  fffffffffffb0000
PID1 000000000000256f PID2 0000000000007306 CCR  00000000000000c0 SAR  0000000000000004
PID3 0000000000000000 PID4 0000000000000000 IVA  000000000002a000 EIEM ffffffffffffffff
ITMR 00000005d637f804 ISQF 000000000ef46800 IOQF 0000000000002aab IIR  000000006bc23fd9
ISR  0000000004d0d000 IOR  400000007a0020cc IPSW 000000000004000f EIRR 0000000000000000
TR0  0000000000abfe68 TR1  000000000465d1d6 TR2  0000000000000002 TR3  0000000000000000
TR4  0000000000000000 TR5  00000001757973bb TR6  00000000000021eb TR7  000000007a0020e0
ISQB 000000000ef46800 IOQB 0000000000002aaf
SR00 0ef46800 SR01 00000000 SR02 00000000 SR03 00000000
SR04 0ef46800 SR05 04d0d000 SR06 01e27c00 SR07 01e27c00

INT   3529: instruction tlb miss fault @ 0000000001e27c00:ffffffffc0000007 for 0000000001e27c00:40000000c0000004
INT   3530: instruction tlb miss fault @ 0000000000000000:ffffffffc0000007 for 0000000000000000:40000000c0000004
INT   3531: external interrupt @ 0000000000000000:ffffffffc0000007 for 0000000000000000:40000000c0000004
INT   3532: instruction tlb miss fault @ 0000000000000000:ffffffffc0000007 for 0000000000000000:40000000c0000004
INT   3533: external interrupt @ 0000000000000000:ffffffffc0000007 for 0000000000000000:40000000c0000004

So the PSW indicates narrow mode, but IAOQ seems to contain all the
ffff... bits. Also interesting is that the second TLB miss (INT 3530)
misses the Space ID.

Any thoughts? Otherwise i need to investigate and make a wrong patch
again :-)

The only patch i have on top which touches target/hppa is the space id
hashing mask patch:

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 66cae795bd..b35c7fa688 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -311,12 +311,13 @@ static inline int HPPA_BTLB_ENTRIES(CPUHPPAState *env)

 void hppa_translate_init(void);

+#define HPPA_GVA_OFFSET_MASK64 0x301fffffffffffff
 #define CPU_RESOLVING_TYPE TYPE_HPPA_CPU

 static inline uint64_t gva_offset_mask(target_ulong psw)
 {
     return (psw & PSW_W
-            ? MAKE_64BIT_MASK(0, 62)
+            ? HPPA_GVA_OFFSET_MASK64
             : MAKE_64BIT_MASK(0, 32));
 }

But that hoppefully isn't causing the issue here.

