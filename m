Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08EB5C6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 16:20:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmcBe-0005XK-2L; Tue, 19 Mar 2024 12:19:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rmcBd-0005Wy-EV
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 12:19:37 -0400
Received: from gorilla.birch.relay.mailchannels.net ([23.83.209.75])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rmcBY-00049i-IG
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 12:19:37 -0400
X-Sender-Id: _forwarded-from|134.3.94.10
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id E9D137A3500
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 16:19:30 +0000 (UTC)
Received: from outbound5i.eu.mailhop.org (unknown [127.0.0.6])
 (Authenticated sender: duocircle)
 by relay.mailchannels.net (Postfix) with ESMTPA id 312537A353C
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 16:19:30 +0000 (UTC)
ARC-Seal: i=2; s=arc-2022; d=mailchannels.net; t=1710865170; a=rsa-sha256;
 cv=pass;
 b=M46xgwfGciaat+C9HPVS3jOPUMFiNWute+KgSY5HZ76zNdZj+utVu/At9MB/ArXXKF8+EK
 ct7dyWskisL276i1Pfboa2QszwUttnvqx/GLlqgwESUyObtpg1AnV61ejyF+ohrP7MyNl3
 68SpkxxNYSFOLO18zepiAOJsQPDIlhek2uT14IXMI34QVrz3zhhxuJ/2bPan6IB/EdeIRu
 cQ3qO3LkHlTlACYN9kJOPUBGzFt7OX8GOuveK8GdQk0E1zce430cRL3DU+99VM3ZSTPs9g
 YjvTSBgnLqc9I/Mu7ZZr0hqJ5sYBJm7xV8FNlBrAVzeFmDbRuBDQY1sdyxYS4g==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1710865170;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=nsOg+Lt96eeBmszLlwUQV+iZJr8zqRhhGNXUkFLNdCc=;
 b=HjuT+a4UjaZ+qGaiHNUX6MSrME5doUlyXY47/oin6FLX/pSGFRb0TonE0gMBIJozPS3XrH
 uxJNLFvqLRRgyOrpaLdYgrBNTGno4X6ydvQAM72aouKRs9Ua34zLKWKRilxNBfGXh28xR5
 0A2rf1CwDQrFbnCiyAQJk3HXRzGWMvMaOiy0x9e96O3HS6RQuo+SpfeIV+BbZ5Cia9TWev
 ruRfh3hjeJgt8qmgP0VkmlfMEqju8ds7q+Q6PgUgqzBHDO+EwKAdAo4pxN2NB80U03dpDc
 5A9U67fzRGATwF0/adt7wUgpu8PsGE15tteR3EFUoXfqk8FhUY7TzNncjFnKoQ==
ARC-Authentication-Results: i=2; rspamd-76c7995f89-dkjsh;
 arc=pass ("outbound.mailhop.org:s=arc-outbound20181012:i=1");
 auth=pass smtp.auth=duocircle smtp.mailfrom=svens@stackframe.org
X-Sender-Id: _forwarded-from|134.3.94.10
X-MC-Relay: Forwarding
X-MailChannels-SenderId: _forwarded-from|134.3.94.10
X-MailChannels-Auth-Id: duocircle
X-Grain-Battle: 662f78654ab1ea52_1710865170805_1737999124
X-MC-Loop-Signature: 1710865170805:3847895272
X-MC-Ingress-Time: 1710865170804
Received: from outbound5i.eu.mailhop.org (outbound5i.eu.mailhop.org
 [35.156.234.212]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.122.162.95 (trex/6.9.2); Tue, 19 Mar 2024 16:19:30 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1710865057; cv=none;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 b=d2OUNpPNM1uvjY37sk7VzBQhPZQchRL9szWOi17FwU+TLSmJMy3n50aE0mcSdiGHAlO5k0ZUs4oFG
 uwWJxGsI3ackzLDc1ZNtof4Gg+aRbUU831JwhsNsnpR4E0aDNm4Wh0muoHMSxuyvS/rpZMrjNlEf3E
 tUAS8TsoLw4J02JQNwSrN9lwoOwIoONwh9gY8UfeaXBvlVCEqHPkGfAqEr8gsdnOTw3eipKDbWTQ3J
 rZjQzKHQGYExC5bJXtfx7MDk8tMRoclip/sBSUnK2NF32g07OQfaFxe0giYIIFpldJbqPznsZ7sLJ1
 oR90RsIFngMel3kEAuXRqwqGI2Nc1ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:dkim-signature:dkim-signature:dkim-signature:from;
 bh=nsOg+Lt96eeBmszLlwUQV+iZJr8zqRhhGNXUkFLNdCc=;
 b=Ewg5qvIapJjlEWeEWZw51mpu/xZahQQiBC1tG9AqSKdU6FRqlJCT/20llj8fizRmrIgIg6OKfK9lK
 SJiP1Q2C4QzyOd/kgKs4ZsC9f3gILj5ESNUB4VwladhZMPsZ2jUX11BbvUkjTMw6vd1Nzn2XGUH+N1
 3cZK9tFGoArAf7rMFuBndwRMJFa+GqkHS/Z2ZBbcOaXcajBiiNTkfQznmfiyu99PxBhz6cxhQIM5ay
 +TYsdjnh6V1sNxadfdu1G8Tk950I4Vlx9GBF1AWEZWW+8r4uMf+eIVNBFTWU2TVx3fTVtPFlOqA7nR
 WbaGnSS+PRJOFQ3tVXp8WLycCyu135Q==
ARC-Authentication-Results: i=1; outbound2.eu.mailhop.org;
 spf=pass smtp.mailfrom=stackframe.org smtp.remote-ip=130.180.31.158;
 dkim=pass header.d=stackframe.org header.s=dkim1 header.a=rsa-sha256
 header.b=G8MUa3+h; 
 dmarc=none header.from=stackframe.org;
 arc=none header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stackframe.org; s=duo-1634547266507-560c42ae;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:from;
 bh=nsOg+Lt96eeBmszLlwUQV+iZJr8zqRhhGNXUkFLNdCc=;
 b=VwuBi4YOTmewbomCukoV2T78w8M74absEuLX9zmCPrgj+5CbPE9fuuwHWfwr5hORFF9kpoGwkukWD
 g8Hitzz3UvW98uMuh+2o8Lrs+5Ep3UFMgXD4JDxrLYNuGP9QFMdMN9qmrmWTY9DY921wvxaJwik47M
 LYBi5yCQkcOyoEig=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=dkim-high;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:from;
 bh=nsOg+Lt96eeBmszLlwUQV+iZJr8zqRhhGNXUkFLNdCc=;
 b=t/s7kKQmAX1PqbkNV+cagjvfjgLfq0Ua/RnJSRnetUHEPwKagLaCMYvIVAJoUZ6acwGJFRgxhPOLi
 R7AQjjfbGZm6oNzX7b7Sz0Uj3Gtf66taTkdhcgsK7lSN69nrVaze8Nl040xxidJU24xfhuHYR6D6f+
 M67cmJlJDt7A5I/eONFLEbFvRWlfp7CED8ATfiRhnprz1N6KoF79satY6etbxcUFP4h/RBMibu7FQ5
 nqeeL8aDuEncu1RXptrmuEPLZTmb3/Aw0anATPRTzeknDtoUD/HHCwXldrfsBKPruUWFF/cYbpDmtV
 rQ9+lQKqkSL/d6kBVA6b9trgDq31Skw==
X-Originating-IP: 130.180.31.158
X-MHO-RoutePath: dG9ta2lzdG5lcm51
X-MHO-User: 31a04ee3-e60c-11ee-b7d4-9b9d9be6ef2c
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from mail.duncanthrax.net (mail.duncanthrax.net [130.180.31.158])
 by outbound2.eu.mailhop.org (Halon) with ESMTPSA
 id 31a04ee3-e60c-11ee-b7d4-9b9d9be6ef2c;
 Tue, 19 Mar 2024 16:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=stackframe.org; s=dkim1; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nsOg+Lt96eeBmszLlwUQV+iZJr8zqRhhGNXUkFLNdCc=; b=G8MUa3+hH5APLvWl2BOoWx4n5j
 ZvaCkPhtM7ttXkdjRwB5ad4r0vNROkMv6KlSV7OEpYyMMrXoqvSrnboShl5Yd6BTXGoXOhuNUZMp0
 jcU+uaUxg0WlYL7qYlQF7s6Cj6TAaUb5F0vn0AlmvWGlegv3qhpR1w0TwlemAVP4mDzYKvSIU7Ny9
 3/br1HOqGwNH3UZFxwXFJr39+lwvEa0Sp/jVr97JVamCGYXUnxAN4/h8wRFWjcmfa/N4rsgC4KP+X
 W5/3nYUVcA7V+ECVTUzrpU8UEU+sBBaLC6U+MVltw9+ToB4i7EMdYgFhLTh5sg0mhxCgzD+jk7Gi+
 kc8eRBSA==;
Received: from ip-134-003-094-010.um41.pools.vodafone-ip.de ([134.3.94.10]
 helo=t14.stackframe.org)
 by mail.duncanthrax.net with esmtpa (Exim 4.96)
 (envelope-from <svens@stackframe.org>) id 1rmcBR-004VVI-1D;
 Tue, 19 Mar 2024 17:19:25 +0100
From: Sven Schnelle <svens@stackframe.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Helge Deller <deller@gmx.de>,
 Sven Schnelle <svens@stackframe.org>
Subject: [PATCH v2 6/6] target/hppa: fix do_stdby_e()
Date: Tue, 19 Mar 2024 17:19:21 +0100
Message-ID: <20240319161921.487080-7-svens@stackframe.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240319161921.487080-1-svens@stackframe.org>
References: <20240319161921.487080-1-svens@stackframe.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=23.83.209.75; envelope-from=svens@stackframe.org;
 helo=gorilla.birch.relay.mailchannels.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

stdby,e,m was writing data from the wrong half of the register
into memory for cases 0-3.

Fixes: 25460fc5a71 ("target/hppa: Implement STDBY")
Signed-off-by: Sven Schnelle <svens@stackframe.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/op_helper.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/hppa/op_helper.c b/target/hppa/op_helper.c
index 480fe80844..6cf49f33b7 100644
--- a/target/hppa/op_helper.c
+++ b/target/hppa/op_helper.c
@@ -281,17 +281,17 @@ static void do_stdby_e(CPUHPPAState *env, target_ulong addr, uint64_t val,
     case 3:
         /* The 3 byte store must appear atomic.  */
         if (parallel) {
-            atomic_store_mask32(env, addr - 3, val, 0xffffff00u, ra);
+            atomic_store_mask32(env, addr - 3, val >> 32, 0xffffff00u, ra);
         } else {
-            cpu_stw_data_ra(env, addr - 3, val >> 16, ra);
-            cpu_stb_data_ra(env, addr - 1, val >> 8, ra);
+            cpu_stw_data_ra(env, addr - 3, val >> 48, ra);
+            cpu_stb_data_ra(env, addr - 1, val >> 40, ra);
         }
         break;
     case 2:
-        cpu_stw_data_ra(env, addr - 2, val >> 16, ra);
+        cpu_stw_data_ra(env, addr - 2, val >> 48, ra);
         break;
     case 1:
-        cpu_stb_data_ra(env, addr - 1, val >> 24, ra);
+        cpu_stb_data_ra(env, addr - 1, val >> 56, ra);
         break;
     default:
         /* Nothing is stored, but protection is checked and the
-- 
2.43.2


