Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 784C0C54E6A
	for <qemu-devel@archiver.kernel.org>; Sun, 17 Mar 2024 22:16:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rlymi-0003hB-Ip; Sun, 17 Mar 2024 18:15:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rlymJ-0003bv-Bh
 for qemu-devel@nongnu.org; Sun, 17 Mar 2024 18:14:51 -0400
Received: from bactrian.maple.relay.mailchannels.net ([23.83.214.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rlymF-0005jQ-M5
 for qemu-devel@nongnu.org; Sun, 17 Mar 2024 18:14:51 -0400
X-Sender-Id: _forwarded-from|134.3.94.10
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 5C4E92C2A8D
 for <qemu-devel@nongnu.org>; Sun, 17 Mar 2024 22:14:42 +0000 (UTC)
Received: from outbound5b.eu.mailhop.org (unknown [127.0.0.6])
 (Authenticated sender: duocircle)
 by relay.mailchannels.net (Postfix) with ESMTPA id 87A9D2C2A8A
 for <qemu-devel@nongnu.org>; Sun, 17 Mar 2024 22:14:41 +0000 (UTC)
ARC-Seal: i=2; s=arc-2022; d=mailchannels.net; t=1710713681; a=rsa-sha256;
 cv=pass;
 b=3GP8KYShU8fJLICWwiLK2po5w/M/x0chFmXenKQG/GIBhrG6gsliXrW2DnRKiIzjwydpbE
 oihSeMd395pcKqOIfLHfDmfBg1bckSz19eTTW02vX8DJHhdHgDhC1UGTriPA9jjLMu6vbV
 mCu8O7W84s+3TjPZM46X9B8wZzeOEQZUkNVQRgXi5MlacPkLMLoexZk7SeXlUG5k/hPPEk
 OzPSjw0sxuThF6bvzyYPE4iwL1c9jJFKRKaaDxtbxEe0b9u8vrWdDCViFAUZPqyFIBa5Wf
 e9NidFXMwvj4u/iVsl2oUFaiT/2wqDL+6Ir6DG0hfjq4oETMrfpS45NZBq480g==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1710713681;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:dkim-signature;
 bh=gfOaOYtVD1xSV5JOr/JXGkFFmtnxp317sb22R5zK25U=;
 b=jgM2Q3vkykOqzxqcfgt2LA+EpsiL6StO749gTpWSlZwBx46kYczE+skoye0irFM5Pc/xPQ
 VkSbK56rWbaztaU3PhUe0waJTiE+FrW0SbW0v2VPXL6ioIghBpumwMqwUWFkN/S1tfN70P
 NlS3rQsrvILyHUd4PJy5cnPt37oQiCKe4+zYnKkHlswUBxlikeH9v0nhMrebsDArmXZg31
 /Sj9rx6sGDiQ7blTG8KMqCg738lTZiS07te0Bxv/Q0pBaHoy33FLO3xAwpfePl7pCH6+Vb
 lnSlEvA5ycqOR+HruNwqHCBBnQY1lfqxYwrVTXj5iZM1gjYeAyT9UtG1BxPbug==
ARC-Authentication-Results: i=2; rspamd-76c7995f89-cm8jn;
 arc=pass ("outbound.mailhop.org:s=arc-outbound20181012:i=1");
 auth=pass smtp.auth=duocircle smtp.mailfrom=svens@stackframe.org
X-Sender-Id: _forwarded-from|134.3.94.10
X-MC-Relay: Forwarding
X-MailChannels-SenderId: _forwarded-from|134.3.94.10
X-MailChannels-Auth-Id: duocircle
X-Company-Soft: 3e8bd75f76f93481_1710713682047_182298984
X-MC-Loop-Signature: 1710713682047:668868349
X-MC-Ingress-Time: 1710713682046
Received: from outbound5b.eu.mailhop.org (outbound5b.eu.mailhop.org
 [3.125.66.160]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.111.46.219 (trex/6.9.2); Sun, 17 Mar 2024 22:14:42 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1710713648; cv=none;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 b=oE936uzDFdiA8pwAeskWKO93y7ZNmDu9d8TiKR4NN1ITD8n8xXpDNuJnLN2MKdPym2iYff1kV7/zs
 CQcNf2Tm7OJomPoVBux41IjywLeBE8D6O33lCai0L2lo0rF4AqY+NbSElULxmleoPSjpvJ2dO1py6L
 xZEWq3x4IitZtqrKAMG1lzXD6etZqBpC6uS+WJjDLUoVl9sa3PTzPfWBweySvK6jH21SJiqmnDnSL8
 bK80rZNFd0fzDb9ewyH1XqE+ypS+FgmlTlC2zCQlMGeLcMwoHkG52vnVJYsFNDi/1+5H0/39nfv0I8
 Vh28R1veVc+aN1ChBSzkkm9BT+qdgLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
 dkim-signature:dkim-signature:dkim-signature:from;
 bh=gfOaOYtVD1xSV5JOr/JXGkFFmtnxp317sb22R5zK25U=;
 b=goNdDojAWtdDvAZl7LQJP5mvof0bd0YGWCPhWhC5m3zBcEktNZuxdDk4l93cdFtGRqB/bKDKNCKnb
 nGETV2LYxqr1mnurrcuLJgaoeYR6IHiPFxO68qO2i2mds8LeyOmk0EZz6S4CZkyHfFcmw6CqRKYnRQ
 gOjz4pDcY+ft6Hh/PL1vBvZs7+YqLoitD1g9n5831UZ035n+NvoKd97rOPwYBRP5MdysREFzSmP3M5
 cbeemn34SZ1Bt+l5JWIBOBQk3cKg82GE/1hPwzVBGLqekiHxa99bCt84YylKIWN8ywildWIGzs2Ppg
 o0pMXAM9jkuyoOgPBYgn3YqH7Vb/m2Q==
ARC-Authentication-Results: i=1; outbound3.eu.mailhop.org;
 spf=pass smtp.mailfrom=stackframe.org smtp.remote-ip=130.180.31.158;
 dkim=pass header.d=stackframe.org header.s=dkim1 header.a=rsa-sha256
 header.b=dcgmumF/; 
 dmarc=none header.from=stackframe.org;
 arc=none header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stackframe.org; s=duo-1634547266507-560c42ae;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
 from; bh=gfOaOYtVD1xSV5JOr/JXGkFFmtnxp317sb22R5zK25U=;
 b=qjtk5o2focklqGljDAqa0aubSjGeL1ohpimhqYUdCUNhv/9I8oeNLnq/uVuB7aXFYbKD4YAfUt50F
 gjPgE+ZNFo7O5dInl1JjSuLpJh3lsp2yn78qv4fTwSshvx+DTtUSRlBQ9sIELBR0xOOPW8tMunrCZj
 QGIj6qXvwqOKrJ2E=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=dkim-high;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
 from; bh=gfOaOYtVD1xSV5JOr/JXGkFFmtnxp317sb22R5zK25U=;
 b=RSNbFXG2C8hqWppYwzvlgvI8VnyPpv78ZKJPa89jj1Jd8MdWwskAxtsB5tvJJr1YMjDCsJw1/IGcW
 EIPYDtUgP/RP0KaCeqNOMdBw+5uRZz5l3I63/5/NLPFh/9YOT5SUOCS52CMmAGZXr0dg+JVIB1zYpF
 bv0ImNmXDTjFX/owPf6OSnuDrwkPyPcCEZgWmsvoMkYlOZPDocQVqk8HZ5c6rwXiBmo+izDq/lzXd9
 KaZWxDWfNbWJL/z8/i+4z0aNfm45ovm9P/yt2Le4yCBkPavlv8cys56Kp7MU4NeOSm+2Nn0WfOFgm8
 jWNo2uV387G3WMW7h3AjDOyY9WVpGrg==
X-Originating-IP: 130.180.31.158
X-MHO-RoutePath: dG9ta2lzdG5lcm51
X-MHO-User: aa7f8524-e4ab-11ee-b1ba-eda7e384987e
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from mail.duncanthrax.net (mail.duncanthrax.net [130.180.31.158])
 by outbound3.eu.mailhop.org (Halon) with ESMTPSA
 id aa7f8524-e4ab-11ee-b1ba-eda7e384987e;
 Sun, 17 Mar 2024 22:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=stackframe.org; s=dkim1; h=Content-Transfer-Encoding:MIME-Version:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gfOaOYtVD1xSV5JOr/JXGkFFmtnxp317sb22R5zK25U=; b=dcgmumF/jMWlpJN7anNGBxMox1
 ITpq41LLxmvZWyW9fOdCHO89PuepgGwyd9l6RySLg+uL7rp5cefdlILpnhKX7M34x6npVFLHORA7q
 RSzaUj7OJ/cylNEE7emo6cTWw/XNJC6pF9vNCB0GQJQhs2iLrzHbbetHlXVmHA7oyOCB4/PicWySX
 MMUFrl6wIj3wdbESjckoPWeflO5fj2dEZ+SyYqgH04zybJT+ycjwmCfcWTv7DfDKvtgOLc2S7c7wC
 p10FM46q4PYhOECTvo327ZIXGmqXlaCfqYNIlKEp0kPQg1w1MKlixdCAvp0zMP8c7DQNX5qhXkSrm
 n+Z7YDyg==;
Received: from ip-134-003-094-010.um41.pools.vodafone-ip.de ([134.3.94.10]
 helo=t14.stackframe.org)
 by mail.duncanthrax.net with esmtpa (Exim 4.96)
 (envelope-from <svens@stackframe.org>) id 1rlym4-004C3C-23;
 Sun, 17 Mar 2024 23:14:36 +0100
From: Sven Schnelle <svens@stackframe.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Helge Deller <deller@gmx.de>,
 Sven Schnelle <svens@stackframe.org>
Subject: [PATCH 0/7] few fixes for hppa target
Date: Sun, 17 Mar 2024 23:14:24 +0100
Message-ID: <20240317221431.251515-1-svens@stackframe.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Sven Schnelle (7):
  target/hppa: ldcw,s uses static shift of 3
  target/hppa: fix shrp for wide mode
  target/hppa: fix access_id check
  target/hppa: exit tb on flush cache instructions
  target/hppa: copy new_spc to iasq_f on be,n instruction
  target/hppa: mask privilege bits in mfia
  target/hppa: fix do_stdby_e()

 roms/SLOF                |  2 +-
 target/hppa/mem_helper.c | 67 +++++++++++++++++++++++++++++++++++-----
 target/hppa/op_helper.c  | 10 +++---
 target/hppa/translate.c  | 13 +++++---
 4 files changed, 74 insertions(+), 18 deletions(-)

-- 
2.43.2


