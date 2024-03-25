Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 029BCC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 19:34:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1roq4x-0002R0-QZ; Mon, 25 Mar 2024 15:33:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1roq4v-0002Qn-QP
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 15:33:54 -0400
Received: from kudu.cherry.relay.mailchannels.net ([23.83.223.97])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1roq4t-0000zZ-3H
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 15:33:53 -0400
X-Sender-Id: _forwarded-from|134.3.94.10
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 7635C8160A
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 19:33:46 +0000 (UTC)
Received: from outbound5f.eu.mailhop.org (unknown [127.0.0.6])
 (Authenticated sender: duocircle)
 by relay.mailchannels.net (Postfix) with ESMTPA id 9869F821AB
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 19:33:45 +0000 (UTC)
ARC-Seal: i=2; s=arc-2022; d=mailchannels.net; t=1711395225; a=rsa-sha256;
 cv=pass;
 b=+XLTkWVITnPdXrlpQkw4YEHpRa43O/mPjwjI07fELXEdfKQbLlHb+vD6jvqLsIe8sp/k4W
 ySjFxbZKw0X9ofTHxR4qMbEYf5rBaRWICI8/h8yleeBjRUxI3Q21wHSN4Q0ibXNStGVM/6
 I+LYuhOQK3wCuhfsSZLSfCxSDjf5RxPSF4tF/yyfS0tWa6zoS+2ZIDu2BXqZo/L834Bb1a
 yRnwofaAEivSEn3m47VLNNGPgh0R/1ApmHSRtx3qnYxohRIRwrCOCPA+IqFie3AqYI0BZL
 Ij7KJwIQRC/fjPu77EEuugNltt6A5wXPAUtKKFXm8ckpyuQ2KNptDIA57pTUfg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1711395225;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 dkim-signature; bh=psRoZgFZigZDw3Tp3DSaXWWC2KEsGjO1fakzzc7vjMM=;
 b=PsN+QrmvFkGhmQsxg1i4T+UQQmN7q5+lnkHgcw8Cg70N+FN6qCi3hYQfPww5qimmXfOPXr
 5i/ktXXptXTHGu6dDg8aklGJtC63hM/Dc1WluCJu3CTJUGUnxQh0m/xEsAW8qFsuAkCuSs
 kWw5SOcKAEHVOg58sRU9EtksoSQJ8SDvo0dCdQvMFOCk8Eac8VJEhuUFP8a3Xb9C0uA8Ou
 dWUH5cjj47y/JjzoTOun1oYLmJZInW96SipMeeNo9SGhf+6qjlKoPwVrHcxpWUmIoLreaF
 RD2Yzqt9ytmukzPI7Gy9dNDdlQTybdDe3gVxRSqkiKpzdZetTgm3D3YTzM89uA==
ARC-Authentication-Results: i=2; rspamd-6c65898bb7-fm9fv;
 arc=pass ("outbound.mailhop.org:s=arc-outbound20181012:i=1");
 auth=pass smtp.auth=duocircle smtp.mailfrom=svens@stackframe.org
X-Sender-Id: _forwarded-from|134.3.94.10
X-MC-Relay: Forwarding
X-MailChannels-SenderId: _forwarded-from|134.3.94.10
X-MailChannels-Auth-Id: duocircle
X-Minister-Industry: 7e14ee6f34f433e5_1711395226121_1749594877
X-MC-Loop-Signature: 1711395226121:1681028229
X-MC-Ingress-Time: 1711395226121
Received: from outbound5f.eu.mailhop.org (outbound5f.eu.mailhop.org
 [3.127.8.113]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.99.189.210 (trex/6.9.2); Mon, 25 Mar 2024 19:33:46 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1711395104; cv=none;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 b=I+Bm6kR7QKL0UiaMl1Bd6LYUR0ZccXyde4Dic8oLiz5uoc1ckCGG6/UxAwoS5Uzbjr3ZaxrZKQN1X
 aMUCQ89167eDdJCahZkEGMrPD+abLS/ObCnFoS1hc1vT0qmIlxH4XX6EtYfrOnvKwcepgu/vtEwwCa
 IAIQX8c/PVVcPXJEXJV1OwIEesh+b/sBFNtOq80UnuCLZO8SoQ4vApznpKJ2NTE00W1MMCQw82K9Bp
 0tVHYmAVRH1jyO4foLYS735KxZMf2TWSmnRqkRSD/nA4DaUISYpq3xv4iRzpaSt9IkAgvU0NHBrnaZ
 vw6PiM0otDkL8uXXCA9ObEcoGYFU8hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 h=content-type:mime-version:message-id:date:subject:cc:to:from:dkim-signature:
 dkim-signature:dkim-signature:from;
 bh=psRoZgFZigZDw3Tp3DSaXWWC2KEsGjO1fakzzc7vjMM=;
 b=beXxcJ94GyZZzSL824j+naBUx5uHdPlSJNQ+wbIjTZeBGpUCQyTTT4XSWnwNfNbGt3LKMhqw3xtLr
 icsw5PVjeb2Fvb9nxCa9scsIUHuSRoXhwYXS6XPImb9d2btXXZAluc8jnTb5pC+VubFND0HbOJpYX6
 GtE5+PMJOqquJ24ZWxITb99qeOmptolGC1JEdMAw/arZedgGVRpIOoriUvkO4sxNUmUjANYnvtZIM1
 fCwwwqska8OWklqMFi0K8FRFratW9K3/o7hnrbc8rb15IyZ/x9zXnJ31QV1D0T+RE184Ajg1MOn/tp
 JS5cjeTeZriMsv3uom8T8ZywoxzY68g==
ARC-Authentication-Results: i=1; outbound2.eu.mailhop.org;
 spf=pass smtp.mailfrom=stackframe.org smtp.remote-ip=130.180.31.158;
 dkim=pass header.d=stackframe.org header.s=dkim1 header.a=rsa-sha256
 header.b=K/txGz/L; 
 dmarc=none header.from=stackframe.org;
 arc=none header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stackframe.org; s=duo-1634547266507-560c42ae;
 h=content-type:mime-version:message-id:date:subject:cc:to:from:from;
 bh=psRoZgFZigZDw3Tp3DSaXWWC2KEsGjO1fakzzc7vjMM=;
 b=Phbzm2mf7UYsnAPeSVDd+QZ/+kx2m9UENPa/wFT9TX6zFX4oZCNCPFamslHCa7XwghPcuY2ZqpEl9
 rxHpwCp4gYeZkNJ0hSmvC5Fdrjyud5A3bnu1SvTNB/D9DrMhsA93IbDdTgORvWqtghUSQMl2gj273X
 PjA8d8FBLKpoiEHo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=dkim-high;
 h=content-type:mime-version:message-id:date:subject:cc:to:from:from;
 bh=psRoZgFZigZDw3Tp3DSaXWWC2KEsGjO1fakzzc7vjMM=;
 b=I1EI+4ufxFkYY9mYrBLp8r4i+X5kOk04bXTpZHh+KLWB4VlrW5lMQgmnvsDlejvE22OoRZ8nzuJ8Q
 kubXvKeSROfJT6IT4yBscxum+lxowF4BXBxHLDBdfSIRZbMmYN6CHyFqYaPxTr5DBoTUeWGgw2o7zQ
 wHKrSUMtSV+ZRaA+yXxNAklGwcuYPenIwSIcsd4boxiJGQLqufr++Z6ZPmJUuNi/wgGAa0btO3nf5C
 /LZu+3VjIcYnjLTBgVZxxT+bP/SYVL2nB5LWtLIiVlvgv8iS8M2YmYpgrwU7F7Qb+CkikYUr0/sEN3
 7M8JUIU7R2kJT4LUWBWHk9blx4kCa9w==
X-Originating-IP: 130.180.31.158
X-MHO-RoutePath: dG9ta2lzdG5lcm51
X-MHO-User: 4e5e37ed-eade-11ee-b864-9b9d9be6ef2c
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from mail.duncanthrax.net (mail.duncanthrax.net [130.180.31.158])
 by outbound2.eu.mailhop.org (Halon) with ESMTPSA
 id 4e5e37ed-eade-11ee-b864-9b9d9be6ef2c;
 Mon, 25 Mar 2024 19:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=stackframe.org; s=dkim1; h=Content-Type:MIME-Version:Message-ID:Date:
 Subject:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=psRoZgFZigZDw3Tp3DSaXWWC2KEsGjO1fakzzc7vjMM=; b=K/txGz/LKONZ8K02gnhc9ByXPs
 S6tmWrEzpktDCbaCkoTPiob93RnSW1RjR2RDKFZeFyDCFE+xpTLJ8HYrFWl5gqfpg3h2ICh+0sABA
 AyJ5iz71gBHyyY9kO8dHQGz/dI2pQbPazwJIVF0oN3me3COpxR5d608snNq88s05usR2ppCk6NQIH
 xEX+3HYXRHVV4i+rzzEAov1AKgmqdnNV6/DipZ+cNrEd6KPuizr5u3hPKPQ17XWbBaNpa3vO1EdyV
 5VwNGYKs4Z19JQSI8QAOIY9ITTQurNZTD0ypOONdKWavsK8mSUCcz8U/NPS+698R/QiSJBGoWFEAo
 AWzPPmdA==;
Received: from ip-134-003-094-010.um41.pools.vodafone-ip.de ([134.3.94.10]
 helo=t14.stackframe.org.stackframe.org)
 by mail.duncanthrax.net with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.96)
 (envelope-from <svens@stackframe.org>) id 1roq4h-005aug-2p;
 Mon, 25 Mar 2024 20:33:39 +0100
From: Sven Schnelle <svens@stackframe.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org
Subject: target/hppa: be,n nullifying first insn at branch target?
Date: Mon, 25 Mar 2024 20:33:38 +0100
Message-ID: <875xxa14z1.fsf@t14.stackframe.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=23.83.223.97; envelope-from=svens@stackframe.org;
 helo=kudu.cherry.relay.mailchannels.net
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

Hi Richard,

one of the last issue i'm seeing with 64bit HP-UX 11.11 is a crash
of ld64 while building (linking) the kernel. The program is killed
due to a unaligned access. I've wrote a logfile, and it looks like
be,n is nullifying the first instruction at the branch target:

IN: 
0x9d4a4000016d4fc:  cmpiclr,<> c,r31,r0
0x9d4a4000016d500:  addi,tr 13,r0,ret1
0x9d4a4000016d504:  ldi 0,ret1
0x9d4a4000016d508:  ldi 0,ret0
0x9d4a4000016d50c:  ldsid (rp),r31
0x9d4a4000016d510:  mtsp r31,sr0
0x9d4a4000016d514:  be,n 0(sr0,rp)

Trace 0: 0x7efd7f9d75c0 [9d4a40000000004/09d4a4000016d4fc/00040306/ff000000] 
IA_F 09d4a4000016d4ff IA_B 09d4a4000016d503 IIR 000000004afc3ff9
PSW  000000ff0004ff1f CB   1111111111111111 ---------C---RQPDI
GR00 0000000000000000 GR01 0000000009d4a400 GR02 0000000000107573 GR03 00000000003c79b8
GR04 0000000000419f50 GR05 0000000000410a30 GR06 000000007a0005c8 GR07 0000000000419f50
GR08 00000000004122f8 GR09 000000000000000b GR10 00000000001db1b8 GR11 00000000001c81f8
GR12 00000000001c81f8 GR13 00000000001c81f8 GR14 0000000000000000 GR15 00000000001dbf18
GR16 0000000000000000 GR17 0000000000000001 GR18 00000000001d5278 GR19 00000000001c5000
GR20 0000000000416a40 GR21 000000000000006a GR22 000000000016d4e8 GR23 000000000000004a
GR24 000000000000029c GR25 0000000000000000 GR26 0000000000419f50 GR27 00000000001e65f8
GR28 0000000000000001 GR29 00000000001db1b8 GR30 000000007a029510 GR31 000000000000000c
SR00 09d4a400 SR01 00000000 SR02 00000000 SR03 00000000
SR04 09d4a400 SR05 09d4a400 SR06 01eea400 SR07 01eea400

----------------
IN: 
0x9d4a40000107570:  ldw 0(r4),r19
0x9d4a40000107574:  ldw 58(r19),r22
0x9d4a40000107578:  ldo 0(ret1),r7
0x9d4a4000010757c:  ldo 0(r4),r26
0x9d4a40000107580:  b,l 0x9d4a400001074d8,r31
0x9d4a40000107584:  ldo 0(r31),rp

Trace 0: 0x7efd7f9d77c0 [9d4a40000000004/09d4a40000107570/00240306/ff000000] 
IA_F 09d4a40000107573 IA_B 09d4a40000107577 IIR 000000004afc3ff9
PSW  000000000024001f CB   0000000000000000 ------N--C---RQPDI
GR00 0000000000000000 GR01 0000000009d4a400 GR02 0000000000107573 GR03 00000000003c79b8
GR04 0000000000419f50 GR05 0000000000410a30 GR06 000000007a0005c8 GR07 0000000000419f50
GR08 00000000004122f8 GR09 000000000000000b GR10 00000000001db1b8 GR11 00000000001c81f8
GR12 00000000001c81f8 GR13 00000000001c81f8 GR14 0000000000000000 GR15 00000000001dbf18
GR16 0000000000000000 GR17 0000000000000001 GR18 00000000001d5278 GR19 00000000001c5000
GR20 0000000000416a40 GR21 000000000000006a GR22 000000000016d4e8 GR23 000000000000004a
GR24 000000000000029c GR25 0000000000000000 GR26 0000000000419f50 GR27 00000000001e65f8
GR28 0000000000000000 GR29 0000000000000013 GR30 000000007a029510 GR31 0000000009d4a400
SR00 09d4a400 SR01 00000000 SR02 00000000 SR03 00000000
SR04 09d4a400 SR05 09d4a400 SR06 01eea400 SR07 01eea400

Trace 0: 0x7efd7f9adb80 [9d4a40000000004/09d4a400001074d8/00040306/ff000000] 
IA_F 09d4a400001074db IA_B 09d4a400001074df IIR 000000004afc3ff9
PSW  000000000004001f CB   0000000000000000 ---------C---RQPDI
GR00 0000000000000000 GR01 0000000009d4a400 GR02 000000000010758b GR03 00000000003c79b8
GR04 0000000000419f50 GR05 0000000000410a30 GR06 000000007a0005c8 GR07 0000000000000013
GR08 00000000004122f8 GR09 000000000000000b GR10 00000000001db1b8 GR11 00000000001c81f8
GR12 00000000001c81f8 GR13 00000000001c81f8 GR14 0000000000000000 GR15 00000000001dbf18
GR16 0000000000000000 GR17 0000000000000001 GR18 00000000001d5278 GR19 00000000001c5000
GR20 0000000000416a40 GR21 000000000000006a GR22 0000000024000000 GR23 000000000000004a
GR24 000000000000029c GR25 0000000000000000 GR26 0000000000419f50 GR27 00000000001e65f8
GR28 0000000000000000 GR29 0000000000000013 GR30 000000007a029510 GR31 000000000010758b
SR00 09d4a400 SR01 00000000 SR02 00000000 SR03 00000000
SR04 09d4a400 SR05 09d4a400 SR06 01eea400 SR07 01eea400

The problem is the 0x1c5000 value in r19, which is the value of an old
instruction. At 0x9d4a4000016d514 is a be,n and at 09d4a40000107570 the
N bit is set. First i thought it might be just a display issue with the
log, but the following change to confirm the issue makes the kernel
linking succeed:


diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 7546a5f5a2..56c68a7cbe 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -3847,7 +3849,7 @@ static bool trans_be(DisasContext *ctx, arg_be *a)
         copy_iaoq_entry(ctx, cpu_gr[31], ctx->iaoq_n, ctx->iaoq_n_var);
         tcg_gen_mov_i64(cpu_sr[0], cpu_iasq_b);
     }
-    if (a->n && use_nullify_skip(ctx)) {
+    if (0 && a->n && use_nullify_skip(ctx)) {
         copy_iaoq_entry(ctx, cpu_iaoq_f, -1, tmp);
         tcg_gen_addi_i64(tmp, tmp, 4);
         copy_iaoq_entry(ctx, cpu_iaoq_b, -1, tmp);


So i think the problem is caused by this optimization. Does this ring a
bell? Debugging this is rather hard, alone the logfile above is 6GB in
size...

Thanks,
Sven

