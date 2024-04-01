Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A56BCD1292
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Apr 2024 14:53:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrJ1H-0001WH-M0; Mon, 01 Apr 2024 10:52:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rrJ1F-0001W8-Qy
 for qemu-devel@nongnu.org; Mon, 01 Apr 2024 10:52:18 -0400
Received: from bactrian.maple.relay.mailchannels.net ([23.83.214.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rrJ1E-0004Zm-0B
 for qemu-devel@nongnu.org; Mon, 01 Apr 2024 10:52:17 -0400
X-Sender-Id: _forwarded-from|134.3.94.10
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id D21657A2666
 for <qemu-devel@nongnu.org>; Mon,  1 Apr 2024 14:52:11 +0000 (UTC)
Received: from outbound5a.eu.mailhop.org (unknown [127.0.0.6])
 (Authenticated sender: duocircle)
 by relay.mailchannels.net (Postfix) with ESMTPA id 2FAAB7A1161
 for <qemu-devel@nongnu.org>; Mon,  1 Apr 2024 14:52:11 +0000 (UTC)
ARC-Seal: i=2; s=arc-2022; d=mailchannels.net; t=1711983131; a=rsa-sha256;
 cv=pass;
 b=Y6labTQYXfHuTb2FIP51xaztQ+bL3E7kPM414XO3rCtoQCfXURTpQfJh1v85pzb5be/RcV
 /j/f3+3PiCBOGQrk+hDK1Wl5NqOeAwdANat4F/TKhMuUww5NGjxqGvfhpH12g64C/eWcgy
 oAfvrwpViFqj7axvwHqxR8I7I6CK6Y3+Erxhcd5H8dnXcPp0dEBxE1gmByjS48js4R1uGf
 KNZbUQFowCil7KJZSUTaXxijz3jdAiI/mdH6b1EmD0JqP2C68PEj4U5mmTsDHI3Ig6B0ar
 7gPwIiBpalaRQaNhEFIws9vtMaPjgMxw4fO/WpdoXKdCFUZdYpX3Nw8xfJMc6g==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1711983131;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:dkim-signature;
 bh=HWJnCoY7GrncxW5amyomlj83ANcOxfDOyqLODQE8+QI=;
 b=nm+LFiJJa63DnX6jOgDE0B+GxLYqeHjMHgj70zWM0IoR1KFnJqgslaL4PEo/r8K2eZFJZR
 5EswI1lJl7g8Acb1YGCfENdTOsgyN9HV+vQLojPSEFAXQImv05uYrMJrCHN4GvWf3195mS
 N4HC3fvx4HPJzGvlYqiGAZtB4nEhHktdyvuK/LRgyShtXFitOAuFwgLR1l1G0KPLbd/PGs
 aPN2jNQLzULW7mbUP//fPrcebwVdM1r6UzBFQgxnG/pSSvezr7lMMh/t4VoWTCkKWO3jmy
 IXsy/kmLlTGeToRrkjRPKAUI67fVxKD5ltLBPF+lMoycJAkCfQhtfwqwqJsJKg==
ARC-Authentication-Results: i=2; rspamd-699949c56f-xw7sd;
 arc=pass ("outbound.mailhop.org:s=arc-outbound20181012:i=1");
 auth=pass smtp.auth=duocircle smtp.mailfrom=svens@stackframe.org
X-Sender-Id: _forwarded-from|134.3.94.10
X-MC-Relay: Forwarding
X-MailChannels-SenderId: _forwarded-from|134.3.94.10
X-MailChannels-Auth-Id: duocircle
X-Descriptive-Whimsical: 103dba363df2ca9d_1711983131681_2363136333
X-MC-Loop-Signature: 1711983131681:2558726576
X-MC-Ingress-Time: 1711983131681
Received: from outbound5a.eu.mailhop.org (outbound5a.eu.mailhop.org
 [3.124.88.253]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.118.210.220 (trex/6.9.2); Mon, 01 Apr 2024 14:52:11 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1711983086; cv=none;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 b=d13+un062vlJn64qXfbQCI6x3ZbwGKbugkqnfO+37uB3EDdPbdy1LzISuIfkQq04uSBjPbOMcttW7
 IaYd/E2xNmyRxRaUkGvfKcdHrHiHxoBbBOyZpFYO59Jytsd3GSiS40CYE+OdpGXFBCpKmm75xy/1P4
 Qn3OevEmUCosKCObd3oPFTs4P7dRJgXMY8Dxubdl3cI9KxVJvOnhFsSuxvPsp+O4zqn9n+6LYxF3u8
 QWWQj+itT/kKcKmN+UMVbxFqvxl9OMBBeUOvqpzwN4I4JunDPPxPdbRxcb43CHa996IFwAWdqEIf1L
 3a6qPiSZF8vjQTGmwnI0j/fbvT3BS0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
 dkim-signature:dkim-signature:dkim-signature:from;
 bh=HWJnCoY7GrncxW5amyomlj83ANcOxfDOyqLODQE8+QI=;
 b=koa+W4mw2Na31UhDQQV+jmkEKAjpGXO2VYeHwTS+J09brEtsG5qnabJ27vfh4c/dzbMX182WjaqO9
 v+F5rmtTvluOt4R5R3xhxiFY5oWNtMUC7m8+JH5z6cgSF6R6c0Z8gM/cBq6ll4ct99b/ghatLMTqjf
 LPYiHgmx+mIS043o9xxf/hKKav1HTJvPY6S6B5Ta97+cN2qJoJS8bIuZLhilmtmJU1tufc2oBbawlm
 qvpJKIj2QeN16WAUbkKbEgVMJZZXOCW9+SIWeQwo3p7sRM3IhNj1DAm6B9NtKV21iX2m+0ToU9OZoc
 RV7ViN1vXy4c7h4Z2A9pRVhWkSQpOWA==
ARC-Authentication-Results: i=1; outbound3.eu.mailhop.org;
 spf=pass smtp.mailfrom=stackframe.org smtp.remote-ip=130.180.31.158;
 dkim=pass header.d=stackframe.org header.s=dkim1 header.a=rsa-sha256
 header.b=fIqRhROW; 
 dmarc=none header.from=stackframe.org;
 arc=none header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stackframe.org; s=duo-1634547266507-560c42ae;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
 from; bh=HWJnCoY7GrncxW5amyomlj83ANcOxfDOyqLODQE8+QI=;
 b=g5+5yaT+WpnRQ5eSCZiSKi2aQ2t5UKRLslipS9ys8+yDv6OnDo6hJPULLngirHRFXMCkvbwNjyfnq
 aKxYaF2TvkapJ8h/n5/zosPg3QXcCzP+fadjjugzGGZur1t7T/m6MzEu1vO/+2LcAg7xwkGEsoDOKD
 HAr5ReO4AiijlCVI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=dkim-high;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
 from; bh=HWJnCoY7GrncxW5amyomlj83ANcOxfDOyqLODQE8+QI=;
 b=X53vqD23t7s14yLiw3+imf3oGtU2ZjUUh9WRwwCFjclKAPPttd0jWqe7kcJFkUhMdz8LWA40svqvh
 ZzIT8Nr6arkdJ7LAkXON+ShPdMrTgcXP2UO0Auhar7mbkSYZ+7DF+Now9V+mGvc3PF/Bh+cZGMltVa
 jktDPcMPcxj+/+XBw9oK/HdKGQ1PXqVBbubdS+Lz7JVaKW1TW6PZR6NHVLH001lIV3dmRV5GZmDpJv
 VaYBAm5XHBj1oYHbct5t4pJhEjS36c2lId7+U5v8BDNZTeWb4DK+MGW0fUXhWuOrLsM5nga19eANzG
 XVZY408Cex6whbu+Z6DZw98RPujkolg==
X-Originating-IP: 130.180.31.158
X-MHO-RoutePath: dG9ta2lzdG5lcm51
X-MHO-User: 4f23c30f-f037-11ee-b347-eda7e384987e
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from mail.duncanthrax.net (mail.duncanthrax.net [130.180.31.158])
 by outbound3.eu.mailhop.org (Halon) with ESMTPSA
 id 4f23c30f-f037-11ee-b347-eda7e384987e;
 Mon, 01 Apr 2024 14:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=stackframe.org; s=dkim1; h=Content-Transfer-Encoding:MIME-Version:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HWJnCoY7GrncxW5amyomlj83ANcOxfDOyqLODQE8+QI=; b=fIqRhROWjQSMxOmmpLXCzcdzCC
 4DZZ8NIYijPuXLpZT6o1frUO+WLwtn5QsRDJqSMreHhJ4aj9pIklIClgJ6JrJyP1Kvb85VWkeRiru
 Se7+c3AHu01r3I4wWs1yhggnhmp3qGvnJcIbQIVlhCxbHS0IJ8mb5fIGklMTl1OF+XXNGVLvZkTCq
 15W79s+7D7hRxFuohwbMrWx8Ga+R2uKGrbWp9pKkwytOMow1DPAanAIdt+V4cGBTi/qufquIcWMoV
 MNkG8Kn+DcoMEMZh6wMTHsQGNUgxV0r7B72gCNOcOxs4tKAd0LoXzjyQK6fTlYOu+rsevv7DwQzJk
 5fcEiMbA==;
Received: from ip-134-003-094-010.um41.pools.vodafone-ip.de ([134.3.94.10]
 helo=t14.stackframe.org)
 by mail.duncanthrax.net with esmtpa (Exim 4.96)
 (envelope-from <svens@stackframe.org>) id 1rrJ11-0073ml-0Z;
 Mon, 01 Apr 2024 16:52:03 +0200
From: Sven Schnelle <svens@stackframe.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Helge Deller <deller@gmx.de>,
 Sven Schnelle <svens@stackframe.org>
Subject: [PATCH] target/hppa: mask upper iaoq bits when returning to narrow
 mode
Date: Mon,  1 Apr 2024 16:52:01 +0200
Message-ID: <20240401145201.2175873-1-svens@stackframe.org>
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

For unknown reasons, Java 1.5 on 64-bit HP-UX 11.11 does signed
computation of the new IAOQ value in the signal handler. In the
current code these bits are not masked when returning to narrow
mode, causing java to crash.

Signed-off-by: Sven Schnelle <svens@stackframe.org>
---
 target/hppa/sys_helper.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/hppa/sys_helper.c b/target/hppa/sys_helper.c
index 208e51c086..3bbc2da71b 100644
--- a/target/hppa/sys_helper.c
+++ b/target/hppa/sys_helper.c
@@ -83,6 +83,10 @@ void HELPER(rfi)(CPUHPPAState *env)
     env->iaoq_f = env->cr[CR_IIAOQ];
     env->iaoq_b = env->cr_back[1];
 
+    if (!(env->cr[CR_IPSW] & PSW_W)) {
+        env->iaoq_f &= 0xffffffff;
+        env->iaoq_b &= 0xffffffff;
+    }
     /*
      * For pa2.0, IIASQ is the top bits of the virtual address.
      * To recreate the space identifier, remove the offset bits.
-- 
2.43.2


