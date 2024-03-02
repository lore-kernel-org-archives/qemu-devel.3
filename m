Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 864C0C54E49
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Mar 2024 17:29:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgTAK-0008Cz-3J; Sat, 02 Mar 2024 12:28:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rgTAG-0008Cb-Rr
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 12:28:49 -0500
Received: from bongo.birch.relay.mailchannels.net ([23.83.209.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rgTAD-0001e9-2O
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 12:28:48 -0500
X-Sender-Id: _forwarded-from|134.3.94.10
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id CA19AC14EE;
 Sat,  2 Mar 2024 17:28:41 +0000 (UTC)
Received: from outbound1a.eu.mailhop.org (unknown [127.0.0.6])
 (Authenticated sender: duocircle)
 by relay.mailchannels.net (Postfix) with ESMTPA id D9453C1B45
 for <qemu-devel@nongnu.org>; Sat,  2 Mar 2024 17:28:40 +0000 (UTC)
ARC-Seal: i=2; s=arc-2022; d=mailchannels.net; t=1709400521; a=rsa-sha256;
 cv=pass;
 b=sMRso6ieaCb401sIg5u2ZgQS4qr1rZqotDneqQwRxo8OoxelSkFpbSyQslbGf7VPKxGm9e
 xy4sj30ffvdXqwNlBDX7/BSoAcQsR7j8BYqum7ikZ3sIEx/aGXBGF++f1jCSwMB28FEPiA
 tSbJj+CIwXuIVbj+Sm0w0n1AffOq1z9chGgsk4eQM+5vE6wL/laKsbY3faEF3NvJDCedk4
 usqcwqD41RCUuVlKZczxkVhn/3RacklLQXhdxzjRC6/depVlRpbYUKUdXV5XdtqnS0iAQI
 kdkC6st6+DEcrPb83RgG8truPa3T+QS/UYrXXRp9QAyasjizICogJNasR8hjAg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1709400521;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=zRpUS3NzcFDLz/P2IvCqiWZMmhZ7r0QriGkPN0Sh05M=;
 b=OLcl9xuTXrC2SjCwYx7ZX4PuCVBruQEHKUiPWmWPiO2bvj6kA4Zd8NoqxfW8Xfwu2Vh6bR
 fntpD0aQyKeI4dSU86z1k1SHrhYgYIwjKhR27xOtJfy7+BtemWHbrH8nmzzlILX50L9HpJ
 4XOCeL2Q7X66SMi+JJH8Wi2cp0BhPO0ta3yJYNZWgtYCOEyoKuufF+lq8GJbtqUEF0Zse+
 hNJJD3qWmEYYbuCAsLoCk9bsAPVJhsXnNKX3BNofR8E4GDLwOO+1Isd4j60fqrMREsz/EB
 EIg7yFdqFHin2T7BR5Fmr/i6zwVZQvsm15dkD5+k/1FjsFQDUMN1B8gcmzniAA==
ARC-Authentication-Results: i=2; rspamd-55b4bfd7cb-xnzjk;
 arc=pass ("outbound.mailhop.org:s=arc-outbound20181012:i=1");
 auth=pass smtp.auth=duocircle smtp.mailfrom=svens@stackframe.org
X-Sender-Id: _forwarded-from|134.3.94.10
X-MC-Relay: Forwarding
X-MC-Copy: exfiltrated-credentials
X-MailChannels-SenderId: _forwarded-from|134.3.94.10
X-MailChannels-Auth-Id: duocircle
X-Stupid-Grain: 573ce71003b9398d_1709400521545_3435707454
X-MC-Loop-Signature: 1709400521545:3250966448
X-MC-Ingress-Time: 1709400521544
Received: from outbound1a.eu.mailhop.org (outbound1a.eu.mailhop.org
 [52.58.109.202]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.111.52.242 (trex/6.9.2); Sat, 02 Mar 2024 17:28:41 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1709400368; cv=none;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 b=PghvMkdXWVpyGJDQ/NqIY600L0BGBMSGUPx4QTJTQTj5wyx7lFpDDZAHr7be97KfoEfYmmOo1jyNZ
 j8pV8PbsDd8phCi44OTDtsDNSjm7YLOuxBjRt4lReEUKKd0pUHpIePP7PgcH7uIkI8ikFiB+myaqEH
 v9wGeLrh/1Xk/blcncxt01dsCLDtkfqb7YhWGRckHJI7BDiiJsx//yZ5sNxErsD47U1DOiU4+rl2JR
 +2WVyHWENftp1zab9oQTgtPL+C+hQjzae2PJz6j/QkjcOqs9WQQgiz2ukfZDzn2NFl/7QaKZ+A6HpZ
 pfkItkX5BQWf4nWa81yY6lbZCTHbDIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:dkim-signature:dkim-signature:dkim-signature:from;
 bh=zRpUS3NzcFDLz/P2IvCqiWZMmhZ7r0QriGkPN0Sh05M=;
 b=E/q/N88eMA2Cu4sqc5xLGs5LmzlmM8srXG4c/2Km2Bp1cGcd/z7ONPCdCct8gL7XH1E7X6h3IZdHj
 TMBNgxTHHerYzFfsIcKJ3bhTJuREdhz/u9gmwynOjfmOCMh6NNTIH8ckSyEBNBCBFLxeO3TD8oA6kb
 k28P/OhO2tWZtuoOgaybAuerZmwNfk+93qL0ayrAiQW3ODuZTMOiCLsJWRT64crc8hYU9av6/myjp2
 vDAfvKvmF5E5y5caE0aEow6QI3GUNxZZOKxndr3r/UTXhLxNnAWGCAh7xm+IOD50N+DUnSpT8upJqM
 LGG7wBaLhRqWpQ8bMQfhszlHIylDeHg==
ARC-Authentication-Results: i=1; outbound2.eu.mailhop.org;
 spf=pass smtp.mailfrom=stackframe.org smtp.remote-ip=130.180.31.158;
 dkim=pass header.d=stackframe.org header.s=dkim1 header.a=rsa-sha256
 header.b=eCXXMZXH; 
 dmarc=none header.from=stackframe.org;
 arc=none header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stackframe.org; s=duo-1634547266507-560c42ae;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:from;
 bh=zRpUS3NzcFDLz/P2IvCqiWZMmhZ7r0QriGkPN0Sh05M=;
 b=EB/ovAr4kCXB+jT+Oq98/iKVzJlBa52jtLjHw2iKUkk3BtbukGOfMzxVaV7Kj6pKoz0HzdiGuVIog
 VukopDbGhuo+lvDj15sSnHZEbuYRuNqHMUGqCk00sBr3Xk2u/QxFF4/LE8yR83t/zEpd6xBJv/qXMJ
 EXpuTkpSWZphHT4Q=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=dkim-high;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:from;
 bh=zRpUS3NzcFDLz/P2IvCqiWZMmhZ7r0QriGkPN0Sh05M=;
 b=B4sdFzojxGm4U1QY6tKjOCMYP/+1Wtnwj/7AGCB+xEtqHx/7z9yHX3MA5uMevOoe3RejNtbOuKxOQ
 lvXactBCZ3chWpROfx3n9f0pz4o29EEYyZpgIxOAdzGva0Oq0C67wKhuAV2fXPhA46rWhN7UbbKg08
 dU8OwOHFmCethJ+FkykY6JE7hrizt3TgFUUB6cGYCCxQlWLdlG2ok9qY/tkkE72ugfYutc9soJ1jQK
 gzSmUtqcUj+6pFwG6B1G+mMNlr1wy0xvOBV8t6FozHvg1PpHYcltyH/isZzptTdnyxPfUBB6uhk6X7
 nwLm44oveVUg9Sid393u6UIrQR6oklQ==
X-Originating-IP: 130.180.31.158
X-MHO-RoutePath: dG9ta2lzdG5lcm51
X-MHO-User: f2c03993-d8b9-11ee-b683-9b9d9be6ef2c
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from mail.duncanthrax.net (mail.duncanthrax.net [130.180.31.158])
 by outbound2.eu.mailhop.org (Halon) with ESMTPSA
 id f2c03993-d8b9-11ee-b683-9b9d9be6ef2c;
 Sat, 02 Mar 2024 17:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=stackframe.org; s=dkim1; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zRpUS3NzcFDLz/P2IvCqiWZMmhZ7r0QriGkPN0Sh05M=; b=eCXXMZXHvEBpCwIbf7TSa4Z5JJ
 ULPd9S0NhneFFrFjlQPEKJ7hKG+lOHeA5oSSlIvtEcuirBuvew4bXuPsC1ux24KgVfXA+d5o1+Nrq
 lgr3dMzqqOwoT3QaUSgNg0wXwLEB1iDjKoQobL0pVk+qReCnX6Di0bihOOBEef3R6goLelJcsdm3Q
 C3Er5UhzeIaUuzieO4FGAwWLUwJUDaML2JAxzhBR6bp8iY6Y9R2HtJCVXPu9gYUcpV0dqNVubEMEl
 SL0ZHizfSSABDicNfg9GnwZzUYIVRXVfV69BLs0xNJ0yMhKVSzAOPlcvoYb99JAICpYpwVVvDapAg
 YgcTUqEQ==;
Received: from ip-134-003-094-010.um41.pools.vodafone-ip.de ([134.3.94.10]
 helo=t14.stackframe.org)
 by mail.duncanthrax.net with esmtpa (Exim 4.96)
 (envelope-from <svens@stackframe.org>) id 1rgT95-000ljk-2B;
 Sat, 02 Mar 2024 18:27:35 +0100
From: Sven Schnelle <svens@stackframe.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: deller@gmx.de, qemu-devel@nongnu.org, Sven Schnelle <svens@stackframe.org>
Subject: [PATCH] target/hppa: add assemble_16()
Date: Sat,  2 Mar 2024 18:21:55 +0100
Message-ID: <20240302172727.2035011-2-svens@stackframe.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240302172727.2035011-1-svens@stackframe.org>
References: <20240302172727.2035011-1-svens@stackframe.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=23.83.209.21; envelope-from=svens@stackframe.org;
 helo=bongo.birch.relay.mailchannels.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Sven Schnelle <svens@stackframe.org>
---
 target/hppa/insns.decode | 99 ++++++++++++++++++++--------------------
 target/hppa/translate.c  | 22 +++++++++
 2 files changed, 72 insertions(+), 49 deletions(-)

diff --git a/target/hppa/insns.decode b/target/hppa/insns.decode
index f5a3f02fd1..8f17e18cd0 100644
--- a/target/hppa/insns.decode
+++ b/target/hppa/insns.decode
@@ -62,7 +62,7 @@
 ####
 
 # All insns that need to form a virtual address should use this set.
-&ldst           t b x disp sp m scale size
+&ldst           t b x disp sp m scale size w16
 
 &rr_cf_d        t r cf d
 &rrr            t r1 r2
@@ -138,7 +138,7 @@ getshadowregs   1111 1111 1111 1101 1110 1010 1101 0010
 ####
 
 @addrx          ...... b:5 x:5 .. ........ m:1 .....    \
-                &ldst disp=0 scale=0 t=0 sp=0 size=0
+                &ldst disp=0 scale=0 t=0 sp=0 size=0 w16=0
 
 nop             000001 ----- ----- -- 11001010 0 -----         # fdc, disp
 nop_addrx       000001 ..... ..... -- 01001010 . -----  @addrx # fdc, index
@@ -163,24 +163,24 @@ ixtlbt          000001 r2:5 r1:5 000 data:1 100000 0 00000    # idtlbt
 
 # pdtlb, pitlb
 pxtlb           000001 b:5 x:5 sp:2 01001000 m:1 ----- \
-                &ldst disp=0 scale=0 size=0 t=0
+                &ldst disp=0 scale=0 size=0 t=0 w16=0
 pxtlb           000001 b:5 x:5 ...   0001000 m:1 ----- \
-                &ldst disp=0 scale=0 size=0 t=0 sp=%assemble_sr3x
+                &ldst disp=0 scale=0 size=0 t=0 sp=%assemble_sr3x w16=0
 
 # ... pa20 local
 pxtlb_l         000001 b:5 x:5 sp:2 01011000 m:1 ----- \
-                &ldst disp=0 scale=0 size=0 t=0
+                &ldst disp=0 scale=0 size=0 t=0 w16=0
 pxtlb_l         000001 b:5 x:5 ...   0011000 m:1 ----- \
-                &ldst disp=0 scale=0 size=0 t=0 sp=%assemble_sr3x
+                &ldst disp=0 scale=0 size=0 t=0 sp=%assemble_sr3x w16=0
 
 # pdtlbe, pitlbe
 pxtlbe          000001 b:5 x:5 sp:2 01001001 m:1 ----- \
-                &ldst disp=0 scale=0 size=0 t=0
+                &ldst disp=0 scale=0 size=0 t=0 w16=0
 pxtlbe          000001 b:5 x:5 ...   0001001 m:1 ----- \
-                &ldst disp=0 scale=0 size=0 t=0 sp=%assemble_sr3x
+                &ldst disp=0 scale=0 size=0 t=0 sp=%assemble_sr3x w16=0
 
 lpa             000001 b:5 x:5 sp:2 01001101 m:1 t:5    \
-                &ldst disp=0 scale=0 size=0
+                &ldst disp=0 scale=0 size=0 w16=0
 
 lci             000001 ----- ----- -- 01001100 0 t:5
 
@@ -221,7 +221,7 @@ sub_b_tsv       000010 ..... ..... .... 110100 . .....  @rrr_cf_d
 
 ldil            001000 t:5 .....................        i=%assemble_21
 addil           001010 r:5 .....................        i=%assemble_21
-ldo             001101 b:5 t:5 -- ..............        i=%lowsign_14
+ldo             001101 b:5 t:5 s:2 ..............        i=%lowsign_14 w16=1
 
 addi            101101 ..... ..... .... 0 ...........   @rri_cf
 addi_tsv        101101 ..... ..... .... 1 ...........   @rri_cf
@@ -264,19 +264,19 @@ permh           111110 r1:5  r2:5  0 c0:2 0 c1:2 c2:2 c3:2 0 t:5
 @stim5          ...... b:5 t:5 sp:2 ......... .....     \
                 &ldst disp=%im5_0 x=0 scale=0 m=%ma_to_m
 
-ld              000011 ..... ..... .. . 1 -- 00 size:2 ......   @ldim5
-ld              000011 ..... ..... .. . 0 -- 00 size:2 ......   @ldstx
-st              000011 ..... ..... .. . 1 -- 10 size:2 ......   @stim5
-ldc             000011 ..... ..... .. . 1 -- 0111      ......   @ldim5 size=2
-ldc             000011 ..... ..... .. . 0 -- 0111      ......   @ldstx size=2
-ldc             000011 ..... ..... .. . 1 -- 0101      ......   @ldim5 size=3
-ldc             000011 ..... ..... .. . 0 -- 0101      ......   @ldstx size=3
-lda             000011 ..... ..... .. . 1 -- 0110      ......   @ldim5 size=2
-lda             000011 ..... ..... .. . 0 -- 0110      ......   @ldstx size=2
-lda             000011 ..... ..... .. . 1 -- 0100      ......   @ldim5 size=3
-lda             000011 ..... ..... .. . 0 -- 0100      ......   @ldstx size=3
-sta             000011 ..... ..... .. . 1 -- 1110      ......   @stim5 size=2
-sta             000011 ..... ..... .. . 1 -- 1111      ......   @stim5 size=3
+ld              000011 ..... ..... .. . 1 -- 00 size:2 ......   @ldim5 w16=0
+ld              000011 ..... ..... .. . 0 -- 00 size:2 ......   @ldstx w16=0
+st              000011 ..... ..... .. . 1 -- 10 size:2 ......   @stim5 w16=0
+ldc             000011 ..... ..... .. . 1 -- 0111      ......   @ldim5 size=2 w16=0
+ldc             000011 ..... ..... .. . 0 -- 0111      ......   @ldstx size=2 w16=0
+ldc             000011 ..... ..... .. . 1 -- 0101      ......   @ldim5 size=3 w16=0
+ldc             000011 ..... ..... .. . 0 -- 0101      ......   @ldstx size=3 w16=0
+lda             000011 ..... ..... .. . 1 -- 0110      ......   @ldim5 size=2 w16=0
+lda             000011 ..... ..... .. . 0 -- 0110      ......   @ldstx size=2 w16=0
+lda             000011 ..... ..... .. . 1 -- 0100      ......   @ldim5 size=3 w16=0
+lda             000011 ..... ..... .. . 0 -- 0100      ......   @ldstx size=3 w16=0
+sta             000011 ..... ..... .. . 1 -- 1110      ......   @stim5 size=2 w16=0
+sta             000011 ..... ..... .. . 1 -- 1111      ......   @stim5 size=3 w16=0
 stby            000011 b:5 r:5 sp:2 a:1 1 -- 1100 m:1   .....   disp=%im5_0
 stdby           000011 b:5 r:5 sp:2 a:1 1 -- 1101 m:1   .....   disp=%im5_0
 
@@ -285,20 +285,20 @@ stdby           000011 b:5 r:5 sp:2 a:1 1 -- 1101 m:1   .....   disp=%im5_0
 @fldstwi        ...... b:5 ..... sp:2 .       ....... .   ..... \
                 &ldst t=%rt64 disp=%im5_16 m=%ma_to_m x=0 scale=0 size=2
 
-fldw            001001 ..... ..... .. . 0 -- 000 . . .....      @fldstwx
-fldw            001001 ..... ..... .. . 1 -- 000 . . .....      @fldstwi
-fstw            001001 ..... ..... .. . 0 -- 100 . . .....      @fldstwx
-fstw            001001 ..... ..... .. . 1 -- 100 . . .....      @fldstwi
+fldw            001001 ..... ..... .. . 0 -- 000 . . .....      @fldstwx w16=0
+fldw            001001 ..... ..... .. . 1 -- 000 . . .....      @fldstwi w16=0
+fstw            001001 ..... ..... .. . 0 -- 100 . . .....      @fldstwx w16=0
+fstw            001001 ..... ..... .. . 1 -- 100 . . .....      @fldstwi w16=0
 
 @fldstdx        ...... b:5 x:5   sp:2 scale:1 ....... m:1 t:5 \
                 &ldst disp=0 size=3
 @fldstdi        ...... b:5 ..... sp:2 .       ....... .   t:5 \
                 &ldst disp=%im5_16 m=%ma_to_m x=0 scale=0 size=3
 
-fldd            001011 ..... ..... .. . 0 -- 000 0 . .....      @fldstdx
-fldd            001011 ..... ..... .. . 1 -- 000 0 . .....      @fldstdi
-fstd            001011 ..... ..... .. . 0 -- 100 0 . .....      @fldstdx
-fstd            001011 ..... ..... .. . 1 -- 100 0 . .....      @fldstdi
+fldd            001011 ..... ..... .. . 0 -- 000 0 . .....      @fldstdx w16=0
+fldd            001011 ..... ..... .. . 1 -- 000 0 . .....      @fldstdi w16=0
+fstd            001011 ..... ..... .. . 0 -- 100 0 . .....      @fldstdx w16=0
+fstd            001011 ..... ..... .. . 1 -- 100 0 . .....      @fldstdi w16=0
 
 ####
 # Offset Mem
@@ -314,34 +314,35 @@ fstd            001011 ..... ..... .. . 1 -- 100 0 . .....      @fldstdi
                 &ldst disp=%assemble_12a x=0 scale=0 m=%pos_to_m
 
 # LDB, LDH, LDW, LDWM
-ld              010000 ..... ..... .. ..............    @ldstim14  size=0
-ld              010001 ..... ..... .. ..............    @ldstim14  size=1
-ld              010010 ..... ..... .. ..............    @ldstim14  size=2
-ld              010011 ..... ..... .. ..............    @ldstim14m size=2
-ld              010111 ..... ..... .. ...........10.    @ldstim12m size=2
+ld              010000 ..... ..... .. ..............    @ldstim14  size=0 w16=1
+ld              010001 ..... ..... .. ..............    @ldstim14  size=1 w16=1
+ld              010010 ..... ..... .. ..............    @ldstim14  size=2 w16=1
+ld              010011 ..... ..... .. ..............    @ldstim14m size=2 w16=1
+ld              010111 ..... ..... .. ...........10.    @ldstim12m size=2 w16=1
 
 # STB, STH, STW, STWM
-st              011000 ..... ..... .. ..............    @ldstim14  size=0
-st              011001 ..... ..... .. ..............    @ldstim14  size=1
-st              011010 ..... ..... .. ..............    @ldstim14  size=2
-st              011011 ..... ..... .. ..............    @ldstim14m size=2
-st              011111 ..... ..... .. ...........10.    @ldstim12m size=2
+st              011000 ..... ..... .. ..............    @ldstim14  size=0 w16=1
+st              011001 ..... ..... .. ..............    @ldstim14  size=1 w16=1
+st              011010 ..... ..... .. ..............    @ldstim14  size=2 w16=1
+st              011011 ..... ..... .. ..............    @ldstim14m size=2 w16=1
+st              011111 ..... ..... .. ...........10.    @ldstim12m size=2 w16=1
+
 
 fldw            010110 b:5 ..... sp:2 ..............    \
-                &ldst disp=%assemble_12a t=%rm64 m=%a_to_m x=0 scale=0 size=2
+                &ldst disp=%assemble_12a t=%rm64 m=%a_to_m x=0 scale=0 size=2 w16=1
 fldw            010111 b:5 ..... sp:2 ...........0..    \
-                &ldst disp=%assemble_12a t=%rm64 m=0 x=0 scale=0 size=2
+                &ldst disp=%assemble_12a t=%rm64 m=0 x=0 scale=0 size=2 w16=1
 
 fstw            011110 b:5 ..... sp:2 ..............    \
-                &ldst disp=%assemble_12a t=%rm64 m=%a_to_m x=0 scale=0 size=2
+                &ldst disp=%assemble_12a t=%rm64 m=%a_to_m x=0 scale=0 size=2 w16=1
 fstw            011111 b:5 ..... sp:2 ...........0..    \
-                &ldst disp=%assemble_12a t=%rm64 m=0 x=0 scale=0 size=2
+                &ldst disp=%assemble_12a t=%rm64 m=0 x=0 scale=0 size=2 w16=1
 
-ld              010100 ..... ..... .. ............0.    @ldstim11
-fldd            010100 ..... ..... .. ............1.    @ldstim11
+ld              010100 ..... ..... .. ............0.    @ldstim11 w16=1
+fldd            010100 ..... ..... .. ............1.    @ldstim11 w16=1
 
-st              011100 ..... ..... .. ............0.    @ldstim11
-fstd            011100 ..... ..... .. ............1.    @ldstim11
+st              011100 ..... ..... .. ............0.    @ldstim11 w16=1
+fstd            011100 ..... ..... .. ............1.    @ldstim11 w16=1
 
 ####
 # Floating-point Multiply Add
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 01f3188656..b13334e763 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -144,6 +144,14 @@ static int assemble_6(DisasContext *ctx, int val)
     return (val ^ 31) + 1;
 }
 
+static int64_t assemble_16(DisasContext *ctx, int64_t i, int64_t s)
+{
+    if (ctx->tb_flags & PSW_W) {
+        i ^= s << 13;
+    }
+    return i;
+}
+
 /* Translate CMPI doubleword conditions to standard. */
 static int cmpbid_c(DisasContext *ctx, int val)
 {
@@ -3052,6 +3060,11 @@ static bool trans_ld(DisasContext *ctx, arg_ldst *a)
     } else if (a->size > MO_32) {
         return gen_illegal(ctx);
     }
+    if (a->w16) {
+        a->disp = assemble_16(ctx, a->disp, a->sp);
+        a->sp = 0;
+    }
+
     return do_load(ctx, a->t, a->b, a->x, a->scale ? a->size : 0,
                    a->disp, a->sp, a->m, a->size | MO_TE);
 }
@@ -3062,6 +3075,11 @@ static bool trans_st(DisasContext *ctx, arg_ldst *a)
     if (!ctx->is_pa20 && a->size > MO_32) {
         return gen_illegal(ctx);
     }
+    if (a->w16) {
+        a->disp = assemble_16(ctx, a->disp, a->sp);
+        a->sp = 0;
+    }
+
     return do_store(ctx, a->t, a->b, a->disp, a->sp, a->m, a->size | MO_TE);
 }
 
@@ -3220,6 +3238,10 @@ static bool trans_ldo(DisasContext *ctx, arg_ldo *a)
 {
     TCGv_i64 tcg_rt = dest_gpr(ctx, a->t);
 
+    if (a->w16) {
+        a->i = assemble_16(ctx, a->i, a->s);
+    }
+
     /* Special case rb == 0, for the LDI pseudo-op.
        The COPY pseudo-op is handled for free within tcg_gen_addi_i64.  */
     if (a->b == 0) {
-- 
2.43.2


