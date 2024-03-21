Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE4BBC6FD1F
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Mar 2024 18:43:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnNNM-0003XZ-Gu; Thu, 21 Mar 2024 14:42:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rnNNK-0003Wt-Jt
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 14:42:50 -0400
Received: from bactrian.maple.relay.mailchannels.net ([23.83.214.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rnNND-0006ae-I8
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 14:42:49 -0400
X-Sender-Id: _forwarded-from|134.3.94.10
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id D571DC217E
 for <qemu-devel@nongnu.org>; Thu, 21 Mar 2024 18:42:38 +0000 (UTC)
Received: from outbound5e.eu.mailhop.org (unknown [127.0.0.6])
 (Authenticated sender: duocircle)
 by relay.mailchannels.net (Postfix) with ESMTPA id 1148EC2A86
 for <qemu-devel@nongnu.org>; Thu, 21 Mar 2024 18:42:36 +0000 (UTC)
ARC-Seal: i=2; s=arc-2022; d=mailchannels.net; t=1711046557; a=rsa-sha256;
 cv=pass;
 b=vXmvc9XITKM80bpVL9s/t2sVlr7BN/S0GedMJK4qrGCj7wnTGSkl8oKNAzVmBSxFeEjqHo
 XKtglO4lzyA0BBFL6sX7PC+gQxaTSwHHIGaBlj1y+jl1IMLe5jjMYBZLXb6dtcXda6CP0R
 +ELVL2RBD/BGvlB9iFE3hSNFy6HiOr35rv44cWHTMDbGVGZWhICrmPkqwpuhYMBMWVGVO6
 QjAk6NySM4gDp5YeF4gVqk+pqIPQueW2+hMIGqfUsjt2P8q3J50oGpdT9Yy47oSh58JJez
 3TWDoXyw6jCaQLs1tCqNFKwBpfWK3S1f4W/65Ii5jjwQRg9/dcFcL7+FW/pmrw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1711046557;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:dkim-signature;
 bh=XdxHOAgwmqYTQml5USShe9l976I9+XzBLbbeeGuDPug=;
 b=3hvM17NSI/7fd2qxLeSvCKRx87szEQWIi77qfVY9IsiJDCu9O2vPHnzVhy6BThFkjGvU23
 HBqWtA8/ZskwyBmDdThYqkQXuJ6uFb37wvMnzknvQio7o4nt4NU6CafHW585lTc95sg6aL
 cNwc+W9cXvYuib9IRnZmo0SJMJqPX3q/Gxj1veI3inZQYieqJSToalzOC+lxbKYSIvTToy
 bJSgMB7T2mU9KD49olHBxIYsJcK5TzlYW1XKf7RPQJg2R70DpNarbSa30j/JbS56bgYoDx
 PAZRZrkgmQ4BNJhNIwxi0T3aB7tDnQ//X57O4JR2XG/5nnNjjDY6rjgKgmvIwg==
ARC-Authentication-Results: i=2; rspamd-b46fcdc5-7drxb;
 arc=pass ("outbound.mailhop.org:s=arc-outbound20181012:i=1");
 auth=pass smtp.auth=duocircle smtp.mailfrom=svens@stackframe.org
X-Sender-Id: _forwarded-from|134.3.94.10
X-MC-Relay: Forwarding
X-MailChannels-SenderId: _forwarded-from|134.3.94.10
X-MailChannels-Auth-Id: duocircle
X-Befitting-Tart: 36ecf81f0da7910d_1711046558583_939074144
X-MC-Loop-Signature: 1711046558583:846670743
X-MC-Ingress-Time: 1711046558583
Received: from outbound5e.eu.mailhop.org (outbound5e.eu.mailhop.org
 [52.28.168.19]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.99.130.139 (trex/6.9.2); Thu, 21 Mar 2024 18:42:38 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1711046441; cv=none;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 b=vWzQLiVwjp8CZP84igREVIzOgWAmUxoUFed8iVAQvSWBFGNzhen0sLVIdKXgI3kkeY5oscHjeYSob
 l31AGsN/vSMHgegmOl5i7MdF7wZSigc2kyDLAHm2A31pvF+vrpRLAgqZWMtrU1WddPn53wfg6rFxiE
 OvauWNS6DuXiHya/EB+iB83DqMGVkj3tdqwYr1wcZR4lwLObWBLtSO2Fl6t70JQ4qk7LDJ9ftebiUz
 G6u7WC521+kOiIHIw8OsS5yaojQM4mZ6RT/E8vppdt1Ie0RyG4Mt9tOmf6ZzoqvG+keQaw6WNzqAq8
 GanV0IS9bYJdF/K+PD69/3GDDTw4F2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
 dkim-signature:dkim-signature:dkim-signature:from;
 bh=XdxHOAgwmqYTQml5USShe9l976I9+XzBLbbeeGuDPug=;
 b=m/ujMYNSAQHh/BM2H5pCeGOxcCQAfOec+v9fHLZdIcnB2SMvSMmPdPRYkfysOoZ2eMKtWDrgegGLG
 mxg//GPpnRM0KorQaZLnWFC7VoIpwjcHe8iSKtrAuw9pNTTlanqDKvLks8FZGXhC2jb+9YMuzXgFzg
 kkTtigu2YSlVRB4RFpC0Zuw+FhjAcBIjll30gyvaaOHvkd+OUhoDYDNRaSPMuY91+d4AgO7RsIJ+hL
 3Q0/NN/yM1Sll1QmZjlJFrqE1DHU/4Pdnhe8V6+j0mhWG+XHj500GLE65zRxIOjueGYiyE2l/QGAst
 j9HOVKdIyDqb8/hcm8ne71EvBhfb8hA==
ARC-Authentication-Results: i=1; outbound2.eu.mailhop.org;
 spf=pass smtp.mailfrom=stackframe.org smtp.remote-ip=130.180.31.158;
 dkim=pass header.d=stackframe.org header.s=dkim1 header.a=rsa-sha256
 header.b=Ca5vA2AY; 
 dmarc=none header.from=stackframe.org;
 arc=none header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stackframe.org; s=duo-1634547266507-560c42ae;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
 from; bh=XdxHOAgwmqYTQml5USShe9l976I9+XzBLbbeeGuDPug=;
 b=p2bL/NMrjip7GB9Z0wnw17vfSiS8UroXpGBKzoEESwT7nYC/NNxy0XJVRbQ1n1sECchGnQHdvzV83
 S9kYRSa1XadIYcmZgoWug/9dbO4YS0tEaoOU5NjXcLp+HXvdn07DRQnscJtNY/4aUWCxY4SI/dbYna
 gxq9+cCV++jgJ8M4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=dkim-high;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
 from; bh=XdxHOAgwmqYTQml5USShe9l976I9+XzBLbbeeGuDPug=;
 b=nMH6aRndIQVm9Xf4frY4YChtFjOysUvku7FPl+HHPiBYhjQ9uMDgtL2X3Vgg01NSFNqpl7GYdprtS
 MXdQAmF4W7gTXEHAeiYsY0GysFuZOSDI9NbnMJNCD4nBNxtLlQ1S7a5kLdDknYfLuf18ALPVNfXy8A
 OV8I68Ix86AcmD4VRiZ4ED68sux1tqBRAte46VGbUtz+FGbBKG6xAvGPe/My7BJOTf5YCZ2uhOnr0z
 PaRUY/Kr0/u0WU58KG3bSzbJKfzJtqD75KJeJT3G3yGa/QOWD0I1XZ8kYEGjsInE5i8Wmq9q6SBDL1
 I/zYezjdRQCNphtU74dpZoRWbBCJUMA==
X-Originating-IP: 130.180.31.158
X-MHO-RoutePath: dG9ta2lzdG5lcm51
X-MHO-User: 831a7241-e7b2-11ee-b810-9b9d9be6ef2c
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from mail.duncanthrax.net (mail.duncanthrax.net [130.180.31.158])
 by outbound2.eu.mailhop.org (Halon) with ESMTPSA
 id 831a7241-e7b2-11ee-b810-9b9d9be6ef2c;
 Thu, 21 Mar 2024 18:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=stackframe.org; s=dkim1; h=Content-Transfer-Encoding:MIME-Version:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XdxHOAgwmqYTQml5USShe9l976I9+XzBLbbeeGuDPug=; b=Ca5vA2AY/mcSkU/1HDjh2BroAo
 os8TK743rGm3wZdNKUDywKK0Z2TU3duxYhcnPpXqNTD+zEsgRnk+bpnHy7+SHx84FhyXnZEHHnpYd
 fLues2iP5NVUoUNb2FDWqjvuBNPvyqOAhKjAI+Wwvb9s7jlVgnD1MqZSNvBhGS9ICe/OM3ScOw6PA
 VhDRu6NxLkG8+yB5wCDLmk6eB4v3J/J5DWrySpzlwrhB9Z84HgmDdYy4AexjoBe2qMBwkdjIykLPR
 tWUnPnYqNbY7QthfoKE7x7rs+kYzQbeLz0lOLZVkQtOFJdfyZqrKMEtanPVYVjN8oXXbfeK+X05kG
 wKJwqeEg==;
Received: from ip-134-003-094-010.um41.pools.vodafone-ip.de ([134.3.94.10]
 helo=t14.stackframe.org)
 by mail.duncanthrax.net with esmtpa (Exim 4.96)
 (envelope-from <svens@stackframe.org>) id 1rnNN2-004uGo-0X;
 Thu, 21 Mar 2024 19:42:32 +0100
From: Sven Schnelle <svens@stackframe.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Helge Deller <deller@gmx.de>,
 Sven Schnelle <svens@stackframe.org>
Subject: [PATCH 1/3] target/hppa: add unit conditions for wide mode
Date: Thu, 21 Mar 2024 19:42:26 +0100
Message-ID: <20240321184228.611897-1-svens@stackframe.org>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=23.83.214.9; envelope-from=svens@stackframe.org;
 helo=bactrian.maple.relay.mailchannels.net
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

Wide mode provides two more conditions, add them.

Signed-off-by: Sven Schnelle <svens@stackframe.org>
---
 target/hppa/translate.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 8a87996fc1..f493e207e1 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -963,11 +963,22 @@ static DisasCond do_unit_cond(unsigned cf, bool d, TCGv_i64 res,
 
     switch (cf >> 1) {
     case 0: /* never / TR */
-    case 1: /* undefined */
-    case 5: /* undefined */
         cond = cond_make_f();
         break;
 
+    case 1:
+        if (d) {
+            tmp = tcg_temp_new_i64();
+            tcg_gen_subi_i64(tmp, res, d_repl * 0x00000001u);
+            tcg_gen_andc_i64(tmp, tmp, res);
+            tcg_gen_andi_i64(tmp, tmp, d_repl * 0x80000000u);
+            cond = cond_make_0(TCG_COND_NE, tmp);
+        } else {
+            /* undefined */
+            cond = cond_make_f();
+        }
+        break;
+
     case 2: /* SBZ / NBZ */
         /* See hasless(v,1) from
          * https://graphics.stanford.edu/~seander/bithacks.html#ZeroInWord
@@ -992,6 +1003,16 @@ static DisasCond do_unit_cond(unsigned cf, bool d, TCGv_i64 res,
         cond = cond_make_0(TCG_COND_NE, cb);
         break;
 
+    case 5:
+        if (d) {
+            tcg_gen_andi_i64(cb, cb, d_repl * 0x80000000u);
+            cond = cond_make_0(TCG_COND_NE, cb);
+        } else {
+            /* undefined */
+            cond = cond_make_f();
+        }
+        break;
+
     case 6: /* SBC / NBC */
         tcg_gen_andi_i64(cb, cb, d_repl * 0x80808080u);
         cond = cond_make_0(TCG_COND_NE, cb);
-- 
2.43.2


