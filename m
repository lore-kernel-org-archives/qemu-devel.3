Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A9DAC6FD1F
	for <qemu-devel@archiver.kernel.org>; Sun, 24 Mar 2024 08:11:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1roIvk-0006gP-Ur; Sun, 24 Mar 2024 04:10:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1roIvh-0006g0-CM
 for qemu-devel@nongnu.org; Sun, 24 Mar 2024 04:10:10 -0400
Received: from cockroach.apple.relay.mailchannels.net ([23.83.208.37])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1roIvf-0002zW-JT
 for qemu-devel@nongnu.org; Sun, 24 Mar 2024 04:10:09 -0400
X-Sender-Id: _forwarded-from|134.3.94.10
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id B8EF81429E4
 for <qemu-devel@nongnu.org>; Sun, 24 Mar 2024 08:10:05 +0000 (UTC)
Received: from outbound5d.eu.mailhop.org (unknown [127.0.0.6])
 (Authenticated sender: duocircle)
 by relay.mailchannels.net (Postfix) with ESMTPA id 26E04142847
 for <qemu-devel@nongnu.org>; Sun, 24 Mar 2024 08:10:05 +0000 (UTC)
ARC-Seal: i=2; s=arc-2022; d=mailchannels.net; t=1711267805; a=rsa-sha256;
 cv=pass;
 b=1PWFfD8ipqQvWycwtDzEDEb4Vd3mw3Kf3wuFKsrhzJbADv4d88IceToZ6x25o1mta3u7YH
 WWi4vI/YDayWOVrYqYnzjqGjcDkUy3QxjLFFG2l7qicDPaiy2wEJb05X2GbMVXOZ62v/LX
 1an6GWJSBunT63o9QPsA/j/yILlLMlzsi1tjc88gG00bAPPnH9uLK2MD4W6uiMPFJ7sr0T
 //J6/+y+uid90wzBNPmJJoZA9HpJJg9LCZaL8NJDi5lJp9YoMMvZGbHKx+KnPaJ9lSWFLG
 nO2ppeKVyxKi+jH+3ZArlUUbPDMiQRng4ipA2FhnoQM3C4sviElEGe2LMzTm7A==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1711267805;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=ClS6vphcdqI+UsbA/jmfTkKJBpNB4dzj8tRJKeWSSKA=;
 b=BLbciIosQXpl/EGeenFOndwna0ERQEOp2I10qws7k6+TbooBQUcZedrpwM6m7dpOhZ6b+f
 SQilcYsmyWP0s5ZQDQjX6pSjma46XtDPwieI/NIcqpUfNwP/tCWTwSjT9eVp4+IL71g1Mg
 mitD8fMu4H8cOi//5zKy9jKPkM8zrAcCh8eBzmmanUn5otvAIwIoTWCvbDZarkMsS2Qq/W
 R1fDAnGEtVO/kv1OaP0rT5fsEL3WMBKm22kmsaza9U8S9iUOatDQ2xdlRA/Zm3suCUga52
 6PDt+NxGKpU4cHpqSG4G6ytNilg/7YFMytFrEQPyZhlvtnN1M8wFM8UdiM1ZQA==
ARC-Authentication-Results: i=2; rspamd-dbbfdf895-ck4qv;
 arc=pass ("outbound.mailhop.org:s=arc-outbound20181012:i=1");
 auth=pass smtp.auth=duocircle smtp.mailfrom=svens@stackframe.org
X-Sender-Id: _forwarded-from|134.3.94.10
X-MC-Relay: Forwarding
X-MailChannels-SenderId: _forwarded-from|134.3.94.10
X-MailChannels-Auth-Id: duocircle
X-Minister-Abortive: 57e16d2b56bbfd67_1711267805657_2352266157
X-MC-Loop-Signature: 1711267805657:367955536
X-MC-Ingress-Time: 1711267805657
Received: from outbound5d.eu.mailhop.org (outbound5d.eu.mailhop.org
 [3.121.156.226]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.126.216.73 (trex/6.9.2); Sun, 24 Mar 2024 08:10:05 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1711267760; cv=none;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 b=J5+BENlweXs5NkxugDm+t5y4r0ijMlfEv+Gzkoyg0YWY6xMcQXxzIGpQUkdXsm2c03+tMAstDvvIv
 F0utm6uVdbE91HqAEmuw1UPl6q+NER0+PPKEUAxot/a7xdtGTTE5uR7yNx1jESAomEDBCe5ME+2L8t
 MzbvhRAnNBiSyOhnzjr3zlYP0900W4VAlPo035gzioTh1/z3Aer4JBhJkHwafuYWbCtLF1oJ2pK14A
 TY1sTOYrynxUZQKnpVdmLpbkwIpmlVofO4YC9hjkIABkzRflPpYuWsfTDLiQitBiQ64Ka5iq4FSsna
 n3elvAiImA8qRu2RE2vfpFKyxO2B+MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:dkim-signature:dkim-signature:dkim-signature:from;
 bh=ClS6vphcdqI+UsbA/jmfTkKJBpNB4dzj8tRJKeWSSKA=;
 b=PB1hBSkRcpLBp3CCU4a4za/CVQSPVPmkV0NFczx3G9xghDmKyaMh0Q92NotDLgUXEYm7n+kLi2c9P
 7NsqCHJwJFRhAfNXHGG8nlV5WILe1ThoQzOJaiVa89CTlzak0b+ujlgfjbZMj9yzEnVzLQfv/djk1X
 r9RTzuhJwE+iE5agbBTSlJYuvtbJXXC/joH5n6dPIjZF2bYSg7METHZk+v/V5bTjjyX8wNSZjzK0JW
 wBa0gO0ca8x9Q7a4+T+ETp3UT1yyh1K5AwGhZr758xWMKt8ieyf2VVX1X+H5HPOudS/h7bFHsLklS0
 86PdNoKwd97gty9uBXHXMy8PvJEeIPg==
ARC-Authentication-Results: i=1; outbound3.eu.mailhop.org;
 spf=pass smtp.mailfrom=stackframe.org smtp.remote-ip=130.180.31.158;
 dkim=pass header.d=stackframe.org header.s=dkim1 header.a=rsa-sha256
 header.b=Ej3EXbLp; 
 dmarc=none header.from=stackframe.org;
 arc=none header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stackframe.org; s=duo-1634547266507-560c42ae;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:from;
 bh=ClS6vphcdqI+UsbA/jmfTkKJBpNB4dzj8tRJKeWSSKA=;
 b=mt6J3yLAR/e3SPP6aROhntFrfGkXU9PTW87adHW2w6g4ZQHiWYR0jG5SWwwnX+HrWVelm/ypQIuFt
 U01Bjr3dc4fj8AcPfQFaqmO3OaJKPMAoPwbhFz/TT3Sc+G5RHdL0bq3fX/cEEHx9UsgQosvax/vati
 Jgvkth5XsRKAAsYE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=dkim-high;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:from;
 bh=ClS6vphcdqI+UsbA/jmfTkKJBpNB4dzj8tRJKeWSSKA=;
 b=d9UDXBwYRPbbC7kvtB7t8ziPRrCW5HeLNjf6S9hwFUL25uB7YZdMcSSCBdRtAB1Lx7gJXOByS0oe0
 d05P1cfSb4o2XIcZ5T/l5sd6ybb8VEHmriCtTf4oAhJzmOefwVgVJqklql8vwbWIB2qJHRziCOp/JL
 Yji8Cz3Vcs18Bgp+9p+6mjz/OhMcdKn5SmV/cE2vCL5IekKbTguI05/tWjScg7Xy6AaHusT35ZNd4O
 hsRY/wpDOLizihNRzrdJk4vq0WtWAy3RLsvGQ7ssOJHW1bOBILKywgjjgZtcRY5THczthzPA0q++0G
 bziwOY0dF5WnKeSuMa4+Laau1zJvJzw==
X-Originating-IP: 130.180.31.158
X-MHO-RoutePath: dG9ta2lzdG5lcm51
X-MHO-User: cfa4121b-e9b5-11ee-b278-eda7e384987e
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from mail.duncanthrax.net (mail.duncanthrax.net [130.180.31.158])
 by outbound3.eu.mailhop.org (Halon) with ESMTPSA
 id cfa4121b-e9b5-11ee-b278-eda7e384987e;
 Sun, 24 Mar 2024 08:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=stackframe.org; s=dkim1; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ClS6vphcdqI+UsbA/jmfTkKJBpNB4dzj8tRJKeWSSKA=; b=Ej3EXbLp7K2/5sOG7RZVjLv4Ls
 AyncSz7agw3ST9teWCmk8NIZR5MkPGp9y62nPGigt92EdjfDaDRldd1V+rnqdYe1p+fvq2YRB/CmP
 q3G1G2wLDeJYX9iTNLpWVDeFIaFebcHKNgihvfRdpFzzboy2OlLkKfgn1k4DiNcx/j33XRrpGKW82
 wjOrSmXB3mG0PVZkEpwWUnbO5eekhJea0KANGVAYuUPy+rTspjXTc10xENz66uHSAOOqzeBHmV7Pm
 VSOlGDhQqvuUHvOexo0+BUeb185BMTdoZWWElEQ0laJbAYQWZkMW+i1cdaBDe1qjS/u1uL6MtChvQ
 +fw885fA==;
Received: from ip-134-003-094-010.um41.pools.vodafone-ip.de ([134.3.94.10]
 helo=t14.stackframe.org)
 by mail.duncanthrax.net with esmtpa (Exim 4.96)
 (envelope-from <svens@stackframe.org>) id 1roIvR-005LYx-09;
 Sun, 24 Mar 2024 09:09:53 +0100
From: Sven Schnelle <svens@stackframe.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Helge Deller <deller@gmx.de>,
 Sven Schnelle <svens@stackframe.org>
Subject: [PATCH 2/3] target/hppa: mask offset bits in gva
Date: Sun, 24 Mar 2024 09:09:44 +0100
Message-ID: <20240324080945.991100-3-svens@stackframe.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240324080945.991100-1-svens@stackframe.org>
References: <20240324080945.991100-1-svens@stackframe.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=23.83.208.37; envelope-from=svens@stackframe.org;
 helo=cockroach.apple.relay.mailchannels.net
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

The CPU seems to mask a few bits in the offset when running
under HP-UX. ISR/IOR register contents for an address in
the processor HPA (0xfffffffffffa0000) on my C8000 and J6750:

running on Linux: 000000003fffffff c0000000fffa0500
running on HP-UX: 00000000301fffff c0000000fffa0500

I haven't found how this is switched (guess some diag in the
firmware), but linux + seabios seems to handle that as well,
so lets mask out the additional bits.

Signed-off-by: Sven Schnelle <svens@stackframe.org>
---
 target/hppa/cpu.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index a072d0bb63..9bc4d208fa 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -283,12 +283,13 @@ static inline int HPPA_BTLB_ENTRIES(CPUHPPAState *env)
 
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
 
-- 
2.43.2


