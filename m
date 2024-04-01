Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42F2DCD128A
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Apr 2024 20:50:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrOat-00056Y-N3; Mon, 01 Apr 2024 16:49:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rrOar-000568-Uf
 for qemu-devel@nongnu.org; Mon, 01 Apr 2024 16:49:25 -0400
Received: from chameleon.pear.relay.mailchannels.net ([23.83.216.33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rrOap-0003Oh-P6
 for qemu-devel@nongnu.org; Mon, 01 Apr 2024 16:49:25 -0400
X-Sender-Id: _forwarded-from|134.3.94.10
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id DB3F1843383
 for <qemu-devel@nongnu.org>; Mon,  1 Apr 2024 20:49:21 +0000 (UTC)
Received: from outbound5e.eu.mailhop.org (unknown [127.0.0.6])
 (Authenticated sender: duocircle)
 by relay.mailchannels.net (Postfix) with ESMTPA id D1CA6843A94
 for <qemu-devel@nongnu.org>; Mon,  1 Apr 2024 20:49:20 +0000 (UTC)
ARC-Seal: i=2; s=arc-2022; d=mailchannels.net; t=1712004561; a=rsa-sha256;
 cv=pass;
 b=idC41QJsUUFWc4Y5RNupVya3yOlDZ2BthacstK6jjLXmZpjtRpphtyN3Wo5c2ixUZ1MGiY
 mKdMPiX/HYVF0Wn0Jdy1DHHJmpuVj1RE9EaW/vejwGfkGQLLj8GvDlfSgLxcamA+1rZ2y4
 x2EBZRxk62agYdeontYryDaFphLeYVmX5wBJFTtC22QNI4qcZHhTs+SYEvsMHgZSAquDob
 x54thmh9Rng4pXbZiAiCZ6fZd2uLszjnzBaowIM+WB6/2KJxteR3VP7KsKyHE4gviV/Ed5
 gEjEsGAeDVgR/oCuiW1zXCTmVvZVwhqaCs5E8JOGqNOvA+q89ALBRJXHBT04Qw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1712004561;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=lSEV96rduvJoPxg8k/ZAWR4h13a+YMmA3vQucGv1wFo=;
 b=FUMliNwtZMaLo+cs4elSvhfxoAHjxQUj9FSERpZnO8Hv82Jf4Pldib3UVSTPBggZ/nzdf0
 1duD4QLGG54YfNpKBT5nHlKvIlYld6L8ZS4ET4fx8wGhrb7ZvNz7TkN5jSHCnq4S2xjyrK
 qfcRk0wrQh6zVXkCGBhXbOhPoAueWNhVoaMrCG8TFAO3+9PQygEXEFjOr4RgKeMEY6k+Bf
 IrAOTGpEmbckublRPU67GTRnbgG7wT0oZxqzHVVhlich3zNfD4CBrKSuNpDovj7iTTJRWR
 /COWsRvzoAGsM1vLm4ECyvhR3YQx8xq3msRiHdcfufHY0Nlf09SQ5BQcrc11ng==
ARC-Authentication-Results: i=2; rspamd-5ffc56d49c-98b7l;
 arc=pass ("outbound.mailhop.org:s=arc-outbound20181012:i=1");
 auth=pass smtp.auth=duocircle smtp.mailfrom=svens@stackframe.org
X-Sender-Id: _forwarded-from|134.3.94.10
X-MC-Relay: Forwarding
X-MailChannels-SenderId: _forwarded-from|134.3.94.10
X-MailChannels-Auth-Id: duocircle
X-Hysterical-Drop: 5faa3a664faa4163_1712004561365_1747794758
X-MC-Loop-Signature: 1712004561365:1501417061
X-MC-Ingress-Time: 1712004561365
Received: from outbound5e.eu.mailhop.org (outbound5e.eu.mailhop.org
 [52.28.168.19]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.102.225.137 (trex/6.9.2); Mon, 01 Apr 2024 20:49:21 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1712004430; cv=none;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 b=XPXRH4ARQ/HETetZ5eY8yNHC0yDWrdueoC4eeWB1vQh6fnx8Mta6VyK5N2DInVxFYcPb5Z5WdkXxr
 1eoMomWBkIoq58rNpORWTT3vD0SOj1XORJ0OW3npSHZTAGD9dpqhi2JysMGj3c0I44YKCeab7Ny2MR
 0uMKTHgMgEiRq0Yt+R6TyOhyXE6ZJ11leRd80Kb9U05xMDAay4X7RkRRtemCk41J36q8ToUJsCN2OX
 NYrEvUyBAcNcxHVH4SW2TMSE/sio2mfUPD4aG7W3kDSrBkciAaTd0L75BaTawUC5At0+5LYMHa3RjV
 ImkrP3yOCRb3fzOoNDLfRMALLaH1siw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 h=content-type:mime-version:message-id:date:references:in-reply-to:subject:cc:
 to:from:dkim-signature:dkim-signature:dkim-signature:from;
 bh=lSEV96rduvJoPxg8k/ZAWR4h13a+YMmA3vQucGv1wFo=;
 b=t01Rz1qQAxw/AhvOixH8fJExKgojyZSTHGPUenAVvaAOcXx8T6zhd9uUOenSAqbOU5YpAvTYsPTdt
 bH3rGsKh8gymFVqAuZLQWOXbFA6XSVA1NjxxocI63feVrOmi41bEZHtoaBe+neFG+qnKPlB+VrNtJS
 cGRaplBZXDx85XNYPirG0Bjqw8gj/SKXCe26YeSPbh50OxeYxIn7oI/mPBPVl4q9+R4m50ML+tZocm
 IorYoZ1y/dd5m0OrEEDQZ9j/3jLlkHzwItIkEcuuwD8e8p4AqUAnkYcyfpYi2zoENlPgDmdEawCPdb
 ABBEvHoMknWHubereNijqrRpqMdSjaQ==
ARC-Authentication-Results: i=1; outbound2.eu.mailhop.org;
 spf=pass smtp.mailfrom=stackframe.org smtp.remote-ip=130.180.31.158;
 dkim=pass header.d=stackframe.org header.s=dkim1 header.a=rsa-sha256
 header.b=hddeorsw; 
 dmarc=none header.from=stackframe.org;
 arc=none header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stackframe.org; s=duo-1634547266507-560c42ae;
 h=content-type:mime-version:message-id:date:references:in-reply-to:subject:cc:
 to:from:from; bh=lSEV96rduvJoPxg8k/ZAWR4h13a+YMmA3vQucGv1wFo=;
 b=AeVwxqlg1LbWoBCuxP+wq2/iVJNXxbS+dX3dBZnzYnucfvBpIw+qYcoHS//bF/S5l2aj79VCs6cew
 9Dmg8anqEF/c5qrrjwCCjKFpvcUg0pMt7oe9mRbiL/S4ziNiOFQC8JZqEDf0JaG+oJs3/e9KI8JDdT
 ucmqZYcJFA1lCQbs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=dkim-high;
 h=content-type:mime-version:message-id:date:references:in-reply-to:subject:cc:
 to:from:from; bh=lSEV96rduvJoPxg8k/ZAWR4h13a+YMmA3vQucGv1wFo=;
 b=D6ud8PXHsbagiILYm9KKoX5E2fsFtCJ72A4RpL65YcCxMKRPrA1HlNsDXHyIr6RqrjPXPyCWX3cbT
 6w5vlbZK4t/ewsWjBOagCEZ4/MfSYwTHBIwEq/oFjdwmkzcx701jVfjosQ782aa3xiZ6AFkacpJoYT
 fndgj3SzBYupM+0mO67WpD55Bvf6OQ0RhcB+veqfi/ZQqECcd65Hto2oX9vBa4GQhpJG838BMDyOaU
 JubU3Gqxxyq5GppySgOxtWuEADSPHjSQ2A7/+STVz5g2NSzB5H2EgGZahE+uphtBQvj7vBI6K/yObs
 XVR2k4hHSZp3t1ea5lBRgLwlyWtlrCw==
X-Originating-IP: 130.180.31.158
X-MHO-RoutePath: dG9ta2lzdG5lcm51
X-MHO-User: 00780847-f069-11ee-b8f0-9b9d9be6ef2c
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from mail.duncanthrax.net (mail.duncanthrax.net [130.180.31.158])
 by outbound2.eu.mailhop.org (Halon) with ESMTPSA
 id 00780847-f069-11ee-b8f0-9b9d9be6ef2c;
 Mon, 01 Apr 2024 20:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=stackframe.org; s=dkim1; h=Content-Type:MIME-Version:Message-ID:Date:
 References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lSEV96rduvJoPxg8k/ZAWR4h13a+YMmA3vQucGv1wFo=; b=hddeorsw4LcyAMxoXKcNLco9Db
 lVWuHNE18hNKPbs7bv8lNZYaR5TxpZvomYDwBr0Og/NvneAdcV0RX/uXOlhOr4/ej2hRVOGOOp7TH
 sexi1II7PtTqobXdemr+JlpMopfHl1a6QwpkC0k0iIcyzSaS723V8ofEGLclLbKZ7e/feB9EhPIwa
 MKLob9ZB0H77NZ/MITTwtD4m0RHNfQtYgp447H/kHZiKn3RgzXTT6tkbPl4hTMghWSNgAlO4jc2cy
 TqKhd5UG/Qz4pTJD3sa94It2FJ0tSV+ybzLDTVe6lUuuzXaGKNrI01YxBrvV+eFB5urfrXXl7FP3o
 5jdyoJ8w==;
Received: from ip-134-003-094-010.um41.pools.vodafone-ip.de ([134.3.94.10]
 helo=t14.stackframe.org.stackframe.org)
 by mail.duncanthrax.net with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.96)
 (envelope-from <svens@stackframe.org>) id 1rrOaf-0076D4-24;
 Mon, 01 Apr 2024 22:49:13 +0200
From: Sven Schnelle <svens@stackframe.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  Helge Deller <deller@gmx.de>
Subject: Re: [PATCH] target/hppa: mask upper iaoq bits when returning to
 narrow mode
In-Reply-To: <87msqczujz.fsf@t14.stackframe.org> (Sven Schnelle's message of
 "Mon, 01 Apr 2024 22:39:44 +0200")
References: <20240401145201.2175873-1-svens@stackframe.org>
 <0f5697e6-da79-424b-866d-40d11b4db0bb@linaro.org>
 <87msqczujz.fsf@t14.stackframe.org>
Date: Mon, 01 Apr 2024 22:49:13 +0200
Message-ID: <87il10zu46.fsf@t14.stackframe.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=23.83.216.33; envelope-from=svens@stackframe.org;
 helo=chameleon.pear.relay.mailchannels.net
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

Sven Schnelle <svens@stackframe.org> writes:

> Richard Henderson <richard.henderson@linaro.org> writes:
>
>> On 4/1/24 04:52, Sven Schnelle wrote:
>>> For unknown reasons, Java 1.5 on 64-bit HP-UX 11.11 does signed
>>> computation of the new IAOQ value in the signal handler. In the
>>> current code these bits are not masked when returning to narrow
>>> mode, causing java to crash.
>>> Signed-off-by: Sven Schnelle <svens@stackframe.org>
>>> ---
>>>   target/hppa/sys_helper.c | 4 ++++
>>>   1 file changed, 4 insertions(+)
>>> diff --git a/target/hppa/sys_helper.c b/target/hppa/sys_helper.c
>>> index 208e51c086..3bbc2da71b 100644
>>> --- a/target/hppa/sys_helper.c
>>> +++ b/target/hppa/sys_helper.c
>>> @@ -83,6 +83,10 @@ void HELPER(rfi)(CPUHPPAState *env)
>>>       env->iaoq_f = env->cr[CR_IIAOQ];
>>>       env->iaoq_b = env->cr_back[1];
>>>   +    if (!(env->cr[CR_IPSW] & PSW_W)) {
>>> +        env->iaoq_f &= 0xffffffff;
>>> +        env->iaoq_b &= 0xffffffff;
>>> +    }
>>
>> This shouldn't be needed, because we are already masking these bits
>> later, in cpu_get_tb_cpu_state.  But I do have some cleanups in this
>> area, and perhaps one of them matters.
>
> Ouch. Appologies, i removed that masking to make 64 bit work, but forgot
> about that. Sorry. I tried your branch, but i'm not able to boot 64 bit HP-UX
> (it wasn't working before without additional changes, so your branch
> doesn't break it). However, i would like to get your oppinion before
> debugging. The code is:
>
> IN: 
> 0xef4680000002c18:   20 20 08 01   ldil L%-40000000,r1
> 0xef4680000002c1c:   e4 20 e0 08   be,l 4(sr7,r1),sr0,r31
> 0xef4680000002c20:   34 16 00 72   ldi 39,r22
>
> IA_F 0ef46800:0000000000002c23 (0ef4680000002c23)
> IA_B 01e27c00:ffffffffc0000007 (01e27c00c0000007)
> PSW  000000000004000f CB   0000000000000000 ---------C----QPDI
> GR00 0000000000000000 GR01 ffffffffc0000000 GR02 0000000000002ac3 GR03 000000007a000000
> GR04 0000000000000002 GR05 000000007a000034 GR06 000000007a000040 GR07 000000007a000050
> GR08 000000007a0000e0 GR09 8000000040001000 GR10 0000000000000003 GR11 0000000000000006
> GR12 00000000001ecee8 GR13 00000000ffffffff GR14 0000000000000801 GR15 0000000000000006
> GR16 80000000400020c0 GR17 000000000001e720 GR18 0000000000000008 GR19 0000000000000000
> GR20 000000000ef46800 GR21 000000007a000060 GR22 0000000000000000 GR23 000000007a000050
> GR24 0000000000000000 GR25 0000000000000000 GR26 000000007a0020f0 GR27 0000000040008410
> GR28 0000000000000002 GR29 0000000000000000 GR30 000000007a002160 GR31 0000000000002c27
> RC   000000007fffffff CR1  0000000000000000 CR2  0000000000000000 CR3  0000000000000000
> CR4  0000000000000000 CR5  0000000000000000 CR6  0000000000000002 CR7  fffffffffffb0000
> PID1 000000000000256f PID2 0000000000007306 CCR  00000000000000c0 SAR  0000000000000004
> PID3 0000000000000000 PID4 0000000000000000 IVA  000000000002a000 EIEM ffffffffffffffff
> ITMR 00000005d637f804 ISQF 000000000ef46800 IOQF 0000000000002aab IIR  000000006bc23fd9
> ISR  0000000004d0d000 IOR  400000007a0020cc IPSW 000000000004000f EIRR 0000000000000000
> TR0  0000000000abfe68 TR1  000000000465d1d6 TR2  0000000000000002 TR3  0000000000000000
> TR4  0000000000000000 TR5  00000001757973bb TR6  00000000000021eb TR7  000000007a0020e0
> ISQB 000000000ef46800 IOQB 0000000000002aaf
> SR00 0ef46800 SR01 00000000 SR02 00000000 SR03 00000000
> SR04 0ef46800 SR05 04d0d000 SR06 01e27c00 SR07 01e27c00
>
> INT   3529: instruction tlb miss fault @ 0000000001e27c00:ffffffffc0000007 for 0000000001e27c00:40000000c0000004
> INT   3530: instruction tlb miss fault @ 0000000000000000:ffffffffc0000007 for 0000000000000000:40000000c0000004
> INT   3531: external interrupt @ 0000000000000000:ffffffffc0000007 for 0000000000000000:40000000c0000004
> INT   3532: instruction tlb miss fault @ 0000000000000000:ffffffffc0000007 for 0000000000000000:40000000c0000004
> INT   3533: external interrupt @ 0000000000000000:ffffffffc0000007 for 0000000000000000:40000000c0000004
>
> So the PSW indicates narrow mode, but IAOQ seems to contain all the
> ffff... bits. Also interesting is that the second TLB miss (INT 3530)
> misses the Space ID.
>
> Any thoughts? Otherwise i need to investigate and make a wrong patch
> again :-)

This seems to be caused by IIAOQ's containing the upper bits. With the
patch below i'm able to boot. Not sure whether it's correct though.

diff --git a/target/hppa/int_helper.c b/target/hppa/int_helper.c
index 58c13d3e61..f7c4cca8f1 100644
--- a/target/hppa/int_helper.c
+++ b/target/hppa/int_helper.c
@@ -123,8 +123,14 @@ void hppa_cpu_do_interrupt(CPUState *cs)
         env->cr[CR_IIASQ] = 0;
         env->cr_back[0] = 0;
     }
-    env->cr[CR_IIAOQ] = env->iaoq_f;
-    env->cr_back[1] = env->iaoq_b;
+    if (old_psw & PSW_W) {
+        env->cr[CR_IIAOQ] = env->iaoq_f;
+        env->cr_back[1] = env->iaoq_b;
+    } else {
+        env->cr[CR_IIAOQ] = (env->iaoq_f & 0xffffffff);
+        env->cr_back[1] = env->iaoq_b & 0xffffffff;
+    }
+

