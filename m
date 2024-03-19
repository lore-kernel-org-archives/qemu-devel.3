Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4D81CD11DC
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 16:20:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmcBg-0005YW-1l; Tue, 19 Mar 2024 12:19:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rmcBe-0005XY-II
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 12:19:38 -0400
Received: from kudu.cherry.relay.mailchannels.net ([23.83.223.97])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rmcBc-0004Ac-5D
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 12:19:38 -0400
X-Sender-Id: _forwarded-from|134.3.94.10
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id D1EB31438E6;
 Tue, 19 Mar 2024 16:19:34 +0000 (UTC)
Received: from outbound5h.eu.mailhop.org (unknown [127.0.0.6])
 (Authenticated sender: duocircle)
 by relay.mailchannels.net (Postfix) with ESMTPA id 1E7A9143928
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 16:19:33 +0000 (UTC)
ARC-Seal: i=2; s=arc-2022; d=mailchannels.net; t=1710865174; a=rsa-sha256;
 cv=pass;
 b=4MStel1Yfjimf1BLP4rQA1PtZj01EEOvmzDObLcNMfg21qXC+5mB2gdnts026FscUnvF1D
 HpG0xaKyCimH1JlK225NGjnGA1UXe/cXv3tweEiFfddfCcS3rZ4IoAOR7Qd0Gm2Bf8wiGd
 d4KVmSRB7JEPTCdv9Al7sxFc33Eapt3WmTHytdfmLJwm2pJdyoSHKFc/WQM3tN/1bhGqkM
 5PS7F8OO7RV027dMR0Nyku1cwyh149CPlOfD/Iw3C7BLyClZ+yfo+9lOeyMNmCATEKCxn0
 8hBguXyAkWJYAIUbML63ZZdC2086O27PWMGRopyexfWRpSjC6CY/drUusRnbeA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1710865174;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=ttyEA0+itqx5bj0YYDKwAEzgmyfASs7xeVqfmIShSNs=;
 b=smmDifAsN41IuPS4H7ubVovw5aaeA/Q2Z2YVxtGK0nwf2f9K7bSd1f0IHxF+Dr4E3kdoC+
 CBjyzrhOFeaSd0kCVvLJKBKkH7chcxgiQmnlRcIx6OFSiZCKgkD9KNxGvvK9O9g4yVRGff
 eZpfdaitGgAEU0qrMzWXLc0RhdRmLpFLmcFK2KOnnmKmcizNWkiqfB0WcTvNn7h8ICH2/y
 QibR9ppt6YZ/dBfIT/9vm9V+GPh1u5OyI+5Ol0kgpaXS5mJZOkYZYBdpPgb6AIxkP01yTo
 sWcL8Jk5O/2QD47MCFZI+uj5NDb7MrIwytHuZ0LC7HzV+vWk05GiZ+ip3/OqcQ==
ARC-Authentication-Results: i=2; rspamd-76c7995f89-gbclf;
 arc=pass ("outbound.mailhop.org:s=arc-outbound20181012:i=1");
 auth=pass smtp.auth=duocircle smtp.mailfrom=svens@stackframe.org
X-Sender-Id: _forwarded-from|134.3.94.10
X-MC-Relay: Forwarding
X-MC-Copy: exfiltrated-credentials
X-MailChannels-SenderId: _forwarded-from|134.3.94.10
X-MailChannels-Auth-Id: duocircle
X-Macabre-Inform: 0b7041685b281673_1710865174668_104288648
X-MC-Loop-Signature: 1710865174668:1499908159
X-MC-Ingress-Time: 1710865174667
Received: from outbound5h.eu.mailhop.org (outbound5h.eu.mailhop.org
 [18.156.94.234]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.122.162.95 (trex/6.9.2); Tue, 19 Mar 2024 16:19:34 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1710865056; cv=none;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 b=Hb0ShrSpVnwr8B7S2b444FLXsfM6eLOOsMQ3pQx25l+Lgcy216FN6FZOxaMDnQyRYoE12Cc5m55tI
 cBMU1KXi8RcsidKstbFb893XBvzl/V8lBRutLYk3AsxRyPixXWXAGOeWo22W1H3V7IDTeFKlevIi1J
 8VvwbWi4rLH4pjXeKIj+4u0FsAo1Pfrw+R1DyPNOpPQY/C/R8D+MjrAQEHr2A/QNp4Jd3EjR7hNbb+
 lgibPg8YQGWA34pCW9d/3axAayoA32Jvpv1oqTThGJrfavB+2xPczzHsepFmDrxQ/8GAz71T0R4h1c
 tOVLt2/poznLNfJDuXpybdqA/4zb8Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:dkim-signature:dkim-signature:dkim-signature:from;
 bh=ttyEA0+itqx5bj0YYDKwAEzgmyfASs7xeVqfmIShSNs=;
 b=oVgo/2IlrZMU2KHTxWdePCiyeYT0gi6Hc0vnq7InBqJ9L2C7c4+vxrvqPJ4G1MvTBmuEX7t1IY9YW
 W2YTPNDXR38vnt2C/0o4OIyvgP0B0zkZ0+h0ArlyZKJC0dbfdXu4nmOc2KsasCYm5KtWq10SwK4q9B
 tCbOI1X4GawFQbCMJHHZrCH+TcP+XROqUvZD7a7H78oLzLNQBfdxpVMH7q4iuKv/yhlPb2BliudhXx
 04POne5ud5YyKwQue6TouA8WguYDG3967a4aTJgDSMTT5JEQoM1hSSrvX44fkFG7ofTWYmIgSHRmeH
 aSRCkA5yq90cMNdzCP79yYlsgfxjTVQ==
ARC-Authentication-Results: i=1; outbound2.eu.mailhop.org;
 spf=pass smtp.mailfrom=stackframe.org smtp.remote-ip=130.180.31.158;
 dkim=pass header.d=stackframe.org header.s=dkim1 header.a=rsa-sha256
 header.b=B/GKnclm; 
 dmarc=none header.from=stackframe.org;
 arc=none header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stackframe.org; s=duo-1634547266507-560c42ae;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:from;
 bh=ttyEA0+itqx5bj0YYDKwAEzgmyfASs7xeVqfmIShSNs=;
 b=BwYTuYnvWkioC4BWzUKBiZHjhYHHUWy/hgh3tJBwYcX8RNQrD0wX8kQ9UkSt5AWWbIEAr5egZ4oeo
 V0/cdsP/w+ezKzCb2NhGiAr+uO5xWIgpvKabYpjMnVWzuh6eazyXNhfYFhxZrLnHw+YLGu91SaEzl9
 PYDuPJZzfNiRj+Mw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=dkim-high;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:from;
 bh=ttyEA0+itqx5bj0YYDKwAEzgmyfASs7xeVqfmIShSNs=;
 b=p83fsFAqdVn0owjFBQcbzHqODeBuVBXQT6kkrhxoaCw/KdK5VoVSHVvuUmjLjujoCP17HzL7x8T4F
 EPuz+UUD0uvEvxKHHoU6sn6qEWnvV8P3itVppXK2qNK+BnUfx+FU/paqtOzncCKQcxc6ChyLC1U4+A
 gWqT0A7HLUZGHhKKhz6oRoTDEADd9Ji7uZHfrTNy/LSD0R/ceG5FLNgEqcRXDoKOHU4SivCsYfbKn6
 yaP4Z+56c5AqgIZRmO9RFr5GkiRL7ctgUuVovkOgOrR81R8xKTkWN+YnCS2pjSe91lYo95ZqtZLiyG
 vqMFeDdEIfGejnZjhuUJDtGn3E1/yUg==
X-Originating-IP: 130.180.31.158
X-MHO-RoutePath: dG9ta2lzdG5lcm51
X-MHO-User: 3120a9a4-e60c-11ee-b7d4-9b9d9be6ef2c
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from mail.duncanthrax.net (mail.duncanthrax.net [130.180.31.158])
 by outbound2.eu.mailhop.org (Halon) with ESMTPSA
 id 3120a9a4-e60c-11ee-b7d4-9b9d9be6ef2c;
 Tue, 19 Mar 2024 16:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=stackframe.org; s=dkim1; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ttyEA0+itqx5bj0YYDKwAEzgmyfASs7xeVqfmIShSNs=; b=B/GKnclmLdPXyw95UJJIQvKjYF
 5tHByChEdbQO0AfWABgZk7zlyE90RNtqkJBnskkLZiuVu+O540rpm9zzYufpH3hkZ6lv9OK4DaUyf
 Oc1Wba+YZpjasinXW8ZJTWKUm+Czpj5djpaLATPy1XRmuyRv3R8x0IsP1Gf7qmbzb0aCk0+Dswjw/
 ohyuC8hlzP5QXZ83dcTwP2D3wZJZ02WjJacirUK2Qxf2zuDUsesBvG4GhSx7xGUEYf1l0t5b/noI6
 3DDasiLHp7OESfyANuwHNZBLSbRcTjWsy0ayOTYbg+TMch2ofLTa5VVVXLO5M8BcSTiLRvNWablCT
 +GFmREbg==;
Received: from ip-134-003-094-010.um41.pools.vodafone-ip.de ([134.3.94.10]
 helo=t14.stackframe.org)
 by mail.duncanthrax.net with esmtpa (Exim 4.96)
 (envelope-from <svens@stackframe.org>) id 1rmcBQ-004VVI-23;
 Tue, 19 Mar 2024 17:19:24 +0100
From: Sven Schnelle <svens@stackframe.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Helge Deller <deller@gmx.de>,
 Sven Schnelle <svens@stackframe.org>
Subject: [PATCH v2 4/6] target/hppa: exit tb on flush cache instructions
Date: Tue, 19 Mar 2024 17:19:19 +0100
Message-ID: <20240319161921.487080-5-svens@stackframe.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240319161921.487080-1-svens@stackframe.org>
References: <20240319161921.487080-1-svens@stackframe.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=23.83.223.97; envelope-from=svens@stackframe.org;
 helo=kudu.cherry.relay.mailchannels.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

When the guest modifies the tb it is currently executing from,
it executes a fic instruction. Exit the tb on such instruction,
otherwise we might execute stale code.

Signed-off-by: Sven Schnelle <svens@stackframe.org>
---
 target/hppa/insns.decode |  6 +++---
 target/hppa/translate.c  | 11 +++++++++++
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/target/hppa/insns.decode b/target/hppa/insns.decode
index f5a3f02fd1..409e3ea9c9 100644
--- a/target/hppa/insns.decode
+++ b/target/hppa/insns.decode
@@ -143,9 +143,9 @@ getshadowregs   1111 1111 1111 1101 1110 1010 1101 0010
 nop             000001 ----- ----- -- 11001010 0 -----         # fdc, disp
 nop_addrx       000001 ..... ..... -- 01001010 . -----  @addrx # fdc, index
 nop_addrx       000001 ..... ..... -- 01001011 . -----  @addrx # fdce
-nop_addrx       000001 ..... ..... --- 0001010 . -----  @addrx # fic 0x0a
-nop_addrx       000001 ..... ..... -- 01001111 . 00000  @addrx # fic 0x4f
-nop_addrx       000001 ..... ..... --- 0001011 . -----  @addrx # fice
+fic             000001 ..... ..... --- 0001010 . -----  @addrx # fic 0x0a
+fic             000001 ..... ..... -- 01001111 . 00000  @addrx # fic 0x4f
+fic             000001 ..... ..... --- 0001011 . -----  @addrx # fice
 nop_addrx       000001 ..... ..... -- 01001110 . 00000  @addrx # pdc
 
 probe           000001 b:5 ri:5 sp:2 imm:1 100011 write:1 0 t:5
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 8ba31567e8..46da546eb9 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -2293,6 +2293,17 @@ static bool trans_nop_addrx(DisasContext *ctx, arg_ldst *a)
     return true;
 }
 
+static bool trans_fic(DisasContext *ctx, arg_fic *a)
+{
+    arg_ldst b;
+
+    b.b = a->b;
+    b.x = a->x;
+    b.m = a->m;
+    ctx->base.is_jmp = DISAS_IAQ_N_STALE;
+    return trans_nop_addrx(ctx, &b);
+}
+
 static bool trans_probe(DisasContext *ctx, arg_probe *a)
 {
     TCGv_i64 dest, ofs;
-- 
2.43.2


