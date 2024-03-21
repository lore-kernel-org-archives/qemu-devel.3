Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 224CDC54E58
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Mar 2024 18:43:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnNNP-0003YE-Vt; Thu, 21 Mar 2024 14:42:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rnNNK-0003Ws-J5
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 14:42:50 -0400
Received: from bongo.birch.relay.mailchannels.net ([23.83.209.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rnNND-0006ao-Hl
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 14:42:49 -0400
X-Sender-Id: _forwarded-from|134.3.94.10
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 474C7C20FC
 for <qemu-devel@nongnu.org>; Thu, 21 Mar 2024 18:42:41 +0000 (UTC)
Received: from outbound5f.eu.mailhop.org (unknown [127.0.0.6])
 (Authenticated sender: duocircle)
 by relay.mailchannels.net (Postfix) with ESMTPA id 9244EC21AF
 for <qemu-devel@nongnu.org>; Thu, 21 Mar 2024 18:42:40 +0000 (UTC)
ARC-Seal: i=2; s=arc-2022; d=mailchannels.net; t=1711046560; a=rsa-sha256;
 cv=pass;
 b=5draw1tdoXCsrQ3Nf7sNsCzlT9OTuNu3n85tAnt79+7jj+3yhCMZMhevv21jPl9/GMHOwB
 eeXlbxq4oXwSwlzivTxPRlMPJPRoPgasRG5NxLhZOK8YXQMJ0w6fedA5xNpDkRC5W4G7ER
 EFNqnBH4+kge2fWrQnvYA97RpVoAYRJai84yC1yGDvJG+PeoPHadzW+LCDZAPj/VfXuecw
 GmlElW9d7KXzivZWWteaUHBSKx/aaE3BaCDu0MXXzIvTGfJMIiAb9qk6uWDEMO0+M5YaFX
 bpUoK0guzd70b6dKNz12QXQaQlERM8ij9dKx8jRg78+cRl7EOLQMAvjech2VDA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1711046560;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=Xtf50j+DlfNozbMDgzegCVRznHt1CNihl0mHsKkCUmk=;
 b=syj3m8d+L0l3EAO9mBh0BaLEb1oWqNdqg4IZcW9V0Wfqf1+0gE/Yff61DbjSgmoy9gtOJZ
 xiZldlvpvpBwItbSKgefAAER0p6jV8mAOl6Am96ssONCpLA82bOnga4mwcm04WtRiiCpI7
 5qvp+wKXaGrEoWHRx3Hn2Gfn76ejQW/M54t/3NSFoXhiYdkrQcQFtWrtZOsuIPgoJ93bZ4
 UsoBm0lGMjNTZEquKTpFK3Xdu9EwTvssLDdogvOAiVbSndbn9D3mGt0Id80V62rReviFsa
 P22tw6HV//32qPS0degm2xoT9zHcNYkUhjoAuPZrlJ+A5+dMhDTd3SDeeifWYQ==
ARC-Authentication-Results: i=2; rspamd-b46fcdc5-v5kc4;
 arc=pass ("outbound.mailhop.org:s=arc-outbound20181012:i=1");
 auth=pass smtp.auth=duocircle smtp.mailfrom=svens@stackframe.org
X-Sender-Id: _forwarded-from|134.3.94.10
X-MC-Relay: Forwarding
X-MailChannels-SenderId: _forwarded-from|134.3.94.10
X-MailChannels-Auth-Id: duocircle
X-Cold-Lonely: 2ae42426480f3eba_1711046561113_2795044585
X-MC-Loop-Signature: 1711046561113:836880450
X-MC-Ingress-Time: 1711046561112
Received: from outbound5f.eu.mailhop.org (outbound5f.eu.mailhop.org
 [3.127.8.113]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.126.173.87 (trex/6.9.2); Thu, 21 Mar 2024 18:42:41 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1711046441; cv=none;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 b=BeNG4z20k2ESSjAGsC6T34sYRxKiY8D6U79J2HaAVWrRo46JX8ABs76+xXxdNGgOchdvReiK+Anjq
 vIPK1G3oj1TweOgpt0TTFHSfggHSNdcQEHkOX50i54lCSE2wjdZgCqxAFMLji+KoFzz9bLL+PBbgYv
 0MM5sdvg98NYt54F609P2gjhb7s1Ggnfj0RGsmIk9qOPWPMQxHhLYYYPtcU4F4tT5q2NeAEXsE7hSd
 u4NaJRoNxL6WRl8uozd8YF9FxcVujnptNcokINRAWyaN3aKvgApoS3WuDrDa7t7iroINVygRORKCi2
 j0gqLS+FKzxxuX6wp4NUJG+eRs+BJhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:dkim-signature:dkim-signature:dkim-signature:from;
 bh=Xtf50j+DlfNozbMDgzegCVRznHt1CNihl0mHsKkCUmk=;
 b=eQcSlxuXplvwWKt2HvcsZRF6ar9wn7ROgNvrPoo30dSTawMDmGcBYz1btKjd93WCVU0P+cDR+VAj8
 FI+LIMxmzPRni38LXStrIqT1m1SeJg4SuUHzjPxAdBr1HZXoXeW8+vh5BqmiRSK/J8amPUs1qYAXcS
 ttxCdYKX1+VYCP+Dw0VTHmYn3zoScHBNEVyDLbE60ag40WRE2jJuLP3aqkB6yefYYfhxmSajxOUM7n
 hk7jXWppKl+25E3U/rI8mnEASEniRgfJyPHQ9t0HqZsWUQlo7utWTxwSv/3AhT8h5g7N6961/4n4Fl
 ioiPLsQSUYsfVxskRY59ErwHb035hvQ==
ARC-Authentication-Results: i=1; outbound2.eu.mailhop.org;
 spf=pass smtp.mailfrom=stackframe.org smtp.remote-ip=130.180.31.158;
 dkim=pass header.d=stackframe.org header.s=dkim1 header.a=rsa-sha256
 header.b=mFpD3jl2; 
 dmarc=none header.from=stackframe.org;
 arc=none header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stackframe.org; s=duo-1634547266507-560c42ae;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:from;
 bh=Xtf50j+DlfNozbMDgzegCVRznHt1CNihl0mHsKkCUmk=;
 b=gwcD1+4RyzaO6hwjXq4BZgeuPGn7BA4ryQj+kDtD9rrLEzCuQb0nZ6zWHdUH7R7XQeCtJN3krO8V5
 qEUk1d7hmxJ9RzdbGbjH790hZV3TeQ9zIUfwq6NlwDx8X7T5gyE3UHMNyCDT72gtIofEiZJ5AQmxmk
 g8STz7OckRDlv+no=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=dkim-high;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:from;
 bh=Xtf50j+DlfNozbMDgzegCVRznHt1CNihl0mHsKkCUmk=;
 b=iEy/Pj6Bv4WnUkGNCEruHpFD/EXY/W7R2zxdAewZ5m8NYvxBhsKCv+/Jkqe9+Y++qXnTLtCaPEnGZ
 3tSa58tyQScjYirB/2LxL6YhfjmrNKOm3DcBsrUflidV4eMFeZfEQLv9xmsvBKfkMbZldScUywyZ+r
 Wm4Jr0OeDeE2qxlBtX3ds1qXiZtblyUVHsSfbMsVO8OfzR1Wh9Dn4HC7iOiM2wfL2Ss1/O0+t9mpWf
 gab7tUqiuyL7LTjxOCkZ/oVip7DKVWQOWaXjA3ertyDlPGktZw/Uc/tUQy+Eh3v4bvl6gGtuaIMGQ2
 PqJH/IbYHwZj86XhR1EKUBipKKEemeA==
X-Originating-IP: 130.180.31.158
X-MHO-RoutePath: dG9ta2lzdG5lcm51
X-MHO-User: 8343f0f2-e7b2-11ee-b810-9b9d9be6ef2c
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from mail.duncanthrax.net (mail.duncanthrax.net [130.180.31.158])
 by outbound2.eu.mailhop.org (Halon) with ESMTPSA
 id 8343f0f2-e7b2-11ee-b810-9b9d9be6ef2c;
 Thu, 21 Mar 2024 18:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=stackframe.org; s=dkim1; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Xtf50j+DlfNozbMDgzegCVRznHt1CNihl0mHsKkCUmk=; b=mFpD3jl29P7lHhkQrDyDLh6/iR
 LRTdAlXpxaolNlv0kv+/IC43BoZuCqpGpfKBzrj6G1XRcxXbwLd0RW2HVCxgy9P/PXcbQ9Bf5nDo3
 6VYMJUMz3tInu2UranVRmTx2vgxb4Tm7bgxdSLyyCkFjuBQmh3j8pFnr6QjJurxIiPFp82lLGhApT
 l3QLIbXb/0boppWc6ZwMwte7ZVmO5BungrzKZkzkknEfU8ZtBK15rF1oSsUTYhMwNWUeDcwWVI7UV
 UwW4nk/DRPYZdf4L67bR4WT6sbpJH8fueuh+wB1scTJIi0MXmBHlZMlfi9mppo2s44Bhz3Ae7ckbi
 xMP3gCBA==;
Received: from ip-134-003-094-010.um41.pools.vodafone-ip.de ([134.3.94.10]
 helo=t14.stackframe.org)
 by mail.duncanthrax.net with esmtpa (Exim 4.96)
 (envelope-from <svens@stackframe.org>) id 1rnNN2-004uGo-1I;
 Thu, 21 Mar 2024 19:42:32 +0100
From: Sven Schnelle <svens@stackframe.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Helge Deller <deller@gmx.de>,
 Sven Schnelle <svens@stackframe.org>
Subject: [PATCH 2/3] target/hppa: sub: fix trap on overflow for narrow mode
Date: Thu, 21 Mar 2024 19:42:27 +0100
Message-ID: <20240321184228.611897-2-svens@stackframe.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240321184228.611897-1-svens@stackframe.org>
References: <20240321184228.611897-1-svens@stackframe.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=23.83.209.21; envelope-from=svens@stackframe.org;
 helo=bongo.birch.relay.mailchannels.net
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

Signed-off-by: Sven Schnelle <svens@stackframe.org>
---
 target/hppa/translate.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index f493e207e1..4d2b96f876 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -1213,6 +1213,9 @@ static void do_sub(DisasContext *ctx, unsigned rt, TCGv_i64 in1,
     if (is_tsv || cond_need_sv(c)) {
         sv = do_sub_sv(ctx, dest, in1, in2);
         if (is_tsv) {
+            if (!d) {
+                tcg_gen_ext32s_i64(sv, sv);
+            }
             gen_helper_tsv(tcg_env, sv);
         }
     }
-- 
2.43.2


