Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D2D8CD11DB
	for <qemu-devel@archiver.kernel.org>; Sun, 24 Mar 2024 08:11:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1roIvk-0006gN-Vn; Sun, 24 Mar 2024 04:10:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1roIvg-0006fl-0R
 for qemu-devel@nongnu.org; Sun, 24 Mar 2024 04:10:08 -0400
Received: from cheetah.pear.relay.mailchannels.net ([23.83.216.34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1roIvd-0002w7-QH
 for qemu-devel@nongnu.org; Sun, 24 Mar 2024 04:10:07 -0400
X-Sender-Id: _forwarded-from|134.3.94.10
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id B90BB101CD0
 for <qemu-devel@nongnu.org>; Sun, 24 Mar 2024 08:09:58 +0000 (UTC)
Received: from outbound1g.eu.mailhop.org (unknown [127.0.0.6])
 (Authenticated sender: duocircle)
 by relay.mailchannels.net (Postfix) with ESMTPA id CBF4C101451
 for <qemu-devel@nongnu.org>; Sun, 24 Mar 2024 08:09:56 +0000 (UTC)
ARC-Seal: i=2; s=arc-2022; d=mailchannels.net; t=1711267797; a=rsa-sha256;
 cv=pass;
 b=bYz/RPYakjSL/6A/WCm9qrCBa6lolI0ABIC1FuagjKVffK0pa/QkSIPh/yesT1BeFCG0Jy
 t0HB9S0Bm3elgm/WVQaUaTUv/NC6P8XGMkLdnSkIUuRVryZ2NqVJsRAGfcpRWZcGH6nofX
 X2RkGZkiS/IW5RRI4fbw/RroJaDA2vAz9ygNB2p31p051UMtz1XRs/DIBBCOVjlQjtbrK6
 yixw6IfFFEydfj1kDzwAL3g1jh83HogkcRZjjEZVXDhoJygT1r03ex0M3SQYdweGR3P5cx
 KX/KV5pO9+k4w6TKQxDmPhel/LhLEV1mIWdYIQHqVATC44r7vI1m7QGHVBJQ3g==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1711267797;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:dkim-signature;
 bh=QfYSKeebuJlMn2cei+wpsQ5X+FsQsCyFrMIiZIgGiwQ=;
 b=RAdNM9/+ERuaXouo7taDl8BQabr2+G8F7Lr2RtmRBA7acTzP1bMgb2Rybkc2Y7mV/3qu7V
 s8l+pUT0quUnQa4gO6BddoMM2TVPEJW5Ou+dfVeHGKXBmn2jR0olUEZ7vP3jXpr6glPkTd
 OAGJ8dRox6HACIjYgonvFWakCj+ibdiKitE+FjEh1uxD49ROEISZpgBJQTnE2WWrQs33Cp
 WayvbHlo6JPejcHcJuAFO2vZZ5ZoZHuNZjF4CEXtAOdYHoDp8eFno7naigBXRQMgow0X6L
 OARtn3KxZH2I2xyYeWOeVgtgs93Xx3mMOcGYNO8vt+4pX7vnMocdzj3bHv0C+w==
ARC-Authentication-Results: i=2; rspamd-dbbfdf895-8wl4q;
 arc=pass ("outbound.mailhop.org:s=arc-outbound20181012:i=1");
 auth=pass smtp.auth=duocircle smtp.mailfrom=svens@stackframe.org
X-Sender-Id: _forwarded-from|134.3.94.10
X-MC-Relay: Forwarding
X-MailChannels-SenderId: _forwarded-from|134.3.94.10
X-MailChannels-Auth-Id: duocircle
X-Reign-Cooing: 72eafd931376559e_1711267797330_155791235
X-MC-Loop-Signature: 1711267797330:822904589
X-MC-Ingress-Time: 1711267797330
Received: from outbound1g.eu.mailhop.org (outbound1g.eu.mailhop.org
 [52.28.6.212]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.115.173.70 (trex/6.9.2); Sun, 24 Mar 2024 08:09:57 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1711267760; cv=none;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 b=q6NDnZEyrLCOWhiLwfliFK4wzAJjPIU6A1aOH7qUvZXGXj2stmMr5pIfF72E1047xTwvWyDPhoXnl
 ujUTi0z76EXcudGDY2yBkgqAzYvKA0g8DvSbZPYvI82tJNwUHNIYGBKrs2EoKn7IjP8emnCmjoVtHS
 3kflI7ulWj5VQelH6YJZWhA5debsLmLZz8hzByPc4KpPGscUxgfBk8SVUPQrk+GaHDSxBi8k/rhmKx
 Yq/mjGq4Dl75u52WcUOnvzGy/zXtj3XVT8xftVL1xXYqc5oWf8R8xr7oqfFMwdmT65/PwCS5CKeHzQ
 475BfQHCHAZQFZccnfR5Q9EteHrSJLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
 dkim-signature:dkim-signature:dkim-signature:from;
 bh=QfYSKeebuJlMn2cei+wpsQ5X+FsQsCyFrMIiZIgGiwQ=;
 b=JjAFv1A6/IlXVcHJGHgnLDYwnc6SWPC4PQOvvWDlZgZeNZT8KXNe1LCU4stTq7wKsE6nvzo8O6yWo
 IAHdYk9CtdE2t3smR+Vw0nyYHq+nb2ANZxLhtkrql1NDJZCyutr0vmHYSvf04cdB92/5q4/nhb3+1I
 NGtvMH5mnD5zCgASHW8Og7wxXWA2PG2OAp0mKHztbrzn7wTGM2QtspLPPIoLzGsAXqVvqCXiYQ1xMP
 YfWaUJA/UInpUDez68iBDwcFnj5odhGoPVeC/nCA5ISLbCKx/C1YVbyTMlZqxNWmZYQZlC9xhWXXfb
 4xzop2TBqNHd/jKO95LEZOnGFBZA9jQ==
ARC-Authentication-Results: i=1; outbound3.eu.mailhop.org;
 spf=pass smtp.mailfrom=stackframe.org smtp.remote-ip=130.180.31.158;
 dkim=pass header.d=stackframe.org header.s=dkim1 header.a=rsa-sha256
 header.b=L+cHFpEq; 
 dmarc=none header.from=stackframe.org;
 arc=none header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stackframe.org; s=duo-1634547266507-560c42ae;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
 from; bh=QfYSKeebuJlMn2cei+wpsQ5X+FsQsCyFrMIiZIgGiwQ=;
 b=FkRK+DtqC8FubDQn2eWnKHxeC05ddD8eMu58cQi08z2j4cuVPrlKUR3tJTsvrW7KUdHJJflzKVovS
 0kVBeMvjg4z8QdDHYYsw2QHED/X8ge62s2NlpJRYFgUdJxmntb80NjVjcZPsKb+jObgJpoibFe0qOO
 3/CUZQ9kSVlloFgo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=dkim-high;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
 from; bh=QfYSKeebuJlMn2cei+wpsQ5X+FsQsCyFrMIiZIgGiwQ=;
 b=nlkJGEAvX0mzqfKzbbhBdGszUg23nqBDTN7Ztmc3rHFNjyA26xcqvuiJNhkq88LF3ZX3Gv+mjidsT
 AqEhZGjK/gwyNcq7oZobDeXHds2PFTxCmnTx/h7fDWwocVy3E5uX0I6Bjw53CimQ97GDtDJg9/M8bJ
 1Yq4GVxodpvMDzN3RgC6d4RGQKW39rU3NJYavqwOEQ1IJLvHE7mK1xwIclic01LkYq7X1LUUwlhLmZ
 fE2WI5ijkKRMXUXtNQMz62JC072hKFFnogzaggEEDmjG4e3+LKSa2/8qe7HhcXLJ5wFRjndIek8crV
 DNuXuP/v/8m0y1nMKbZ03TYZbX9qI5Q==
X-Originating-IP: 130.180.31.158
X-MHO-RoutePath: dG9ta2lzdG5lcm51
X-MHO-User: cf2dc4f8-e9b5-11ee-b278-eda7e384987e
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from mail.duncanthrax.net (mail.duncanthrax.net [130.180.31.158])
 by outbound3.eu.mailhop.org (Halon) with ESMTPSA
 id cf2dc4f8-e9b5-11ee-b278-eda7e384987e;
 Sun, 24 Mar 2024 08:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=stackframe.org; s=dkim1; h=Content-Transfer-Encoding:MIME-Version:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QfYSKeebuJlMn2cei+wpsQ5X+FsQsCyFrMIiZIgGiwQ=; b=L+cHFpEq0gMlEgt1HVBb3YUd93
 Swi7Hbivm/7Se6zx+3l9tJv/z8Mh7OkKAViOzRh4pazBkJ7hdU81qOhYzF0bK1oXuTW1NNS91ckJd
 CyZlGEfjKWaZeNQ80eCLi+psOmIgntHgov2Pp96DHA/ChSJerRw+adcbPrhsFYKh1oaAn2nDPseW3
 of8oTvGRa3bKqOP94dI9rJLbWDbovRWGH5z3th4gvBc/VzIGYNV/u0MR56f0NdgXEFo8X3U/xkN2Q
 J1dUxNZ8OEr/x+/6xiAiujp4o3lnaCKnu2NgbSwb8YZtbA3AgotSmdOArDHda9FJ77u4OPb4r7yDX
 wIPm+0vQ==;
Received: from ip-134-003-094-010.um41.pools.vodafone-ip.de ([134.3.94.10]
 helo=t14.stackframe.org)
 by mail.duncanthrax.net with esmtpa (Exim 4.96)
 (envelope-from <svens@stackframe.org>) id 1roIvQ-005LYx-0Y;
 Sun, 24 Mar 2024 09:09:52 +0100
From: Sven Schnelle <svens@stackframe.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Helge Deller <deller@gmx.de>,
 Sven Schnelle <svens@stackframe.org>
Subject: [PATCH 0/3] few hppa fixes for 64bit mode
Date: Sun, 24 Mar 2024 09:09:42 +0100
Message-ID: <20240324080945.991100-1-svens@stackframe.org>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=23.83.216.34; envelope-from=svens@stackframe.org;
 helo=cheetah.pear.relay.mailchannels.net
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

Hi,

in preparation of getting 64bit HP-UX running in qemu, here are a few fixes
to make HP-UX progress a bit further.

Sven Schnelle (3):
  target/hppa: use gva_offset_mask() everywhere
  target/hppa: mask offset bits in gva
  target/hppa: fix building gva for wide mode

 target/hppa/cpu.h        | 11 +++++++++--
 target/hppa/mem_helper.c | 13 +++++++------
 target/hppa/translate.c  | 12 +++---------
 3 files changed, 19 insertions(+), 17 deletions(-)

-- 
2.43.2


