Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 949B8C6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 16:20:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmcBe-0005XM-8X; Tue, 19 Mar 2024 12:19:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rmcBd-0005Wv-E8
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 12:19:37 -0400
Received: from chocolate.pear.relay.mailchannels.net ([23.83.216.35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rmcBY-00049U-16
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 12:19:37 -0400
X-Sender-Id: _forwarded-from|134.3.94.10
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id C4FACC2796
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 16:19:29 +0000 (UTC)
Received: from outbound5e.eu.mailhop.org (unknown [127.0.0.6])
 (Authenticated sender: duocircle)
 by relay.mailchannels.net (Postfix) with ESMTPA id D61E1C251D
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 16:19:28 +0000 (UTC)
ARC-Seal: i=2; s=arc-2022; d=mailchannels.net; t=1710865169; a=rsa-sha256;
 cv=pass;
 b=ACuzpVKLMze8UpgRS2jvvv+ENJYO8Qq9faCB1WNM0MM1H6vczrAQoAln2AP1t4YndzIcPd
 tY/InIrmuivLH1+dykHCBnWoiVnL+M2FEeCxsQAhNHPxqmcpDV/JkuH1M6DAdHhrrPSKAp
 NFRIrdPb2x10pU7gJjCnNFHM0/oTTb3ioGtVK01B19Hs9/d+03VKluTLpyKJ6XoDavPKts
 1YeHqBv0q56qksB8ZZMxj1eJlDKM01LgQwxOgi/keQC+Qdh76U+vbMEO/VJtOOrrAPTc6Z
 IE0uMR0yqrJWMLDMCHThVxPdl6CzK+xFdC953DgbEJ5bkMHfaTyKfFv2a/CQBg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1710865169;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:dkim-signature;
 bh=xtUhlmHieXBvKY2FB76y3RHS7aWyjAXVPCowsKpqP/4=;
 b=0/bxhaHdsDN+8Pl3HWwp8PJA/NoJ/udWCvO0YdIeZvuAw8LfD4LYLqTVwUepOOROLJUQHz
 LtVK1iQvnm2JYmRu7envm0P6+yzXodG0oi2HaYujEupeTZ8YoWn3lsRtGu42A1yGJKr0LX
 rtOzQD8r+s0XNSTw6Z5jg9+dVAGeymJ2OKDa0FfwOWdbefptsvP3ln+nGc5F8N1gJuWOiB
 zwtX8Mzjx205vM7QZjDljYLgJOUFZ5kbY/41QMHBIMCa5gML+YytytkbHSNjLpHtywNrqD
 ZQYMrQJBjo7F4eMqlRYsGZFWcQ2m8kESm+4a7h0Bo4YbQeJv7Qu07AAFDwIqZw==
ARC-Authentication-Results: i=2; rspamd-76c7995f89-q5gwp;
 arc=pass ("outbound.mailhop.org:s=arc-outbound20181012:i=1");
 auth=pass smtp.auth=duocircle smtp.mailfrom=svens@stackframe.org
X-Sender-Id: _forwarded-from|134.3.94.10
X-MC-Relay: Forwarding
X-MailChannels-SenderId: _forwarded-from|134.3.94.10
X-MailChannels-Auth-Id: duocircle
X-Company-Gusty: 6f99310e27507db5_1710865169395_2940543518
X-MC-Loop-Signature: 1710865169395:3465272743
X-MC-Ingress-Time: 1710865169395
Received: from outbound5e.eu.mailhop.org (outbound5e.eu.mailhop.org
 [52.28.168.19]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.127.222.112 (trex/6.9.2); Tue, 19 Mar 2024 16:19:29 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1710865056; cv=none;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 b=LleU9Im7JtH7Q/6on9Y419wwXrI3vqzUM5EUucgMvSAregURcq8Ln6iYzE0tJ/uUH3PAwjxkI1FAZ
 QvD9qEGeJ/bjwghu7Mhj3JKunvRZhd/90vG0nMNLWtw7YVmS5MW/xOuMK31UO581vXKClCUkFJlmRr
 z4g+qY3Z/j09bqpJpQ59vBTkLdKPK+zv+IJ7tvAsfQ89SKF+ZqkpfdIGarxaGaksIv6xX2Q6VSY9SM
 a5tSQIbDn7hyg6rXr9yyyG7eQ4oG8aJuVJZ7pRixKJ1uVWf2D2m+tPwpLeFYRhAD0OpPx6VdXMmfWn
 MDijEvjpadt4dwFpcyma9JuEbzmDT/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
 dkim-signature:dkim-signature:dkim-signature:from;
 bh=xtUhlmHieXBvKY2FB76y3RHS7aWyjAXVPCowsKpqP/4=;
 b=d59VWSb8PCOYB3GUN3+ElGiOSGgy5RH24+p2wbaH2aHfrmb3k6gy8Lr7nU73XYKc5GryuHbDy1m4m
 MYbkEe6wof84vKxNZKYlIAEuOGX+2W0hKC5Xu0HWychDin+eX3N1wZAVnjIWIYuDCvv2x256B8SXOi
 RXkVWmcKcAo8ykc9zM3/PahgJSRt6K6IdFG/HORBjIyVoJ6y0Au837yQt0E7D4tbjeEoVtOCPn9KP5
 bZivnesJav6PoI/vV69qgJcAd4DCGLuqJjC8NcJCoZeDt3ws9YwhBQfJyMcKb+TIcqyaLGYenBBiSl
 WxDGwjUotuNX1aw2Q+V33Er7yt7AHDA==
ARC-Authentication-Results: i=1; outbound2.eu.mailhop.org;
 spf=pass smtp.mailfrom=stackframe.org smtp.remote-ip=130.180.31.158;
 dkim=pass header.d=stackframe.org header.s=dkim1 header.a=rsa-sha256
 header.b=XrjtaDNz; 
 dmarc=none header.from=stackframe.org;
 arc=none header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stackframe.org; s=duo-1634547266507-560c42ae;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
 from; bh=xtUhlmHieXBvKY2FB76y3RHS7aWyjAXVPCowsKpqP/4=;
 b=Tn2Df8pMD21kJrjYtda3cTPxLKUOwWKxYNH3ddRx/c6Lpim8Osd/xEBY0gNA9lIZq0y9u+OQ1kRU1
 iUNay74cRgkmdl6RalqncJPzMcjhMRjEFJX8jEXuqBx0KtKlykMGwG6NRyPmi6hSmfnZ5ahAv4HZpq
 YmuR4nlI9x9eIuMs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=dkim-high;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
 from; bh=xtUhlmHieXBvKY2FB76y3RHS7aWyjAXVPCowsKpqP/4=;
 b=Ii5JzwAm5mNLbu6iJz3UCngLpewN/z7pqdJci4bFCXal75ThA6BTVsdzBJRU3BXbDuqf7DCFpzx5o
 y+ARihg0TZaGF4doBi7YPHa9OuGqhBUWpZaWfq/LT2WsVMlG3z77eaQsKSU7IghPuqCB0zNo05yPHk
 B9bZps1LQAF7E4Nyrcc2y9YnNyGoxltzt/gYMwLijGu5jnx+WFSO80lr3E8+7GGBWEQYUe45Wj8clz
 /HpuGmTkvRGke1yz7d/igG0OtKW/A9ImOFhAIFeQv62uM31oTwjjxMo8fV5+Sre12bD7diInGhynhr
 lc0FPvMfYvef8KxTOoS9vqNo3NhH6/Q==
X-Originating-IP: 130.180.31.158
X-MHO-RoutePath: dG9ta2lzdG5lcm51
X-MHO-User: 30ca1d16-e60c-11ee-b7d4-9b9d9be6ef2c
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from mail.duncanthrax.net (mail.duncanthrax.net [130.180.31.158])
 by outbound2.eu.mailhop.org (Halon) with ESMTPSA
 id 30ca1d16-e60c-11ee-b7d4-9b9d9be6ef2c;
 Tue, 19 Mar 2024 16:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=stackframe.org; s=dkim1; h=Content-Transfer-Encoding:MIME-Version:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xtUhlmHieXBvKY2FB76y3RHS7aWyjAXVPCowsKpqP/4=; b=XrjtaDNzetvPWtSuSWTL3/gOKN
 GfQDPsVo0aOAwgQyEOywkuhCHnX5JxWQxJvNxdlMhN1IYUm8x5jFL7Tx/9IxT9BIAVVHhfTmEO3nh
 ZXN2UXbeXBujtXZpiJFkf8iROJMwbDP5bXvtCizaoCGt24nUUrS3KK3WzpcxhPUYBlG15izszaR1k
 Go/+5Zqtjs6PcnbmB79mD9+rHnJcfyLsRjMrIvm/iVKjZD3lWKVyy8mSTSwxpET5zTyA8b6PwBpJh
 vcVz1GstlDAUD/5pHrUYVagpMMHitwko+05tmwUMROm42sgSCQAXKIWKXcA0SMtZFKSITLCqQsL2H
 q6V5hYJw==;
Received: from ip-134-003-094-010.um41.pools.vodafone-ip.de ([134.3.94.10]
 helo=t14.stackframe.org)
 by mail.duncanthrax.net with esmtpa (Exim 4.96)
 (envelope-from <svens@stackframe.org>) id 1rmcBP-004VVI-22;
 Tue, 19 Mar 2024 17:19:23 +0100
From: Sven Schnelle <svens@stackframe.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Helge Deller <deller@gmx.de>,
 Sven Schnelle <svens@stackframe.org>
Subject: [PATCH v2 0/6] few fixes for hppa target
Date: Tue, 19 Mar 2024 17:19:15 +0100
Message-ID: <20240319161921.487080-1-svens@stackframe.org>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=23.83.216.35; envelope-from=svens@stackframe.org;
 helo=chocolate.pear.relay.mailchannels.net
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

Hi,

here are a few fixes for the hppa target i made while debugging
some wide mode issues.

Changes in v2:

- use Richards version for access id matching
- add trans_fic()

Sven Schnelle (6):
  target/hppa: ldcw,s uses static shift of 3
  target/hppa: fix shrp for wide mode
  target/hppa: fix access_id check
  target/hppa: exit tb on flush cache instructions
  target/hppa: mask privilege bits in mfia
  target/hppa: fix do_stdby_e()

 target/hppa/insns.decode |  6 ++--
 target/hppa/mem_helper.c | 59 +++++++++++++++++++++++++++++++++-------
 target/hppa/op_helper.c  | 10 +++----
 target/hppa/translate.c  | 19 ++++++++++---
 4 files changed, 72 insertions(+), 22 deletions(-)

-- 
2.43.2


