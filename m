Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FD53C61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 15:42:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzcFS-0006HD-IX; Thu, 27 Aug 2026 11:42:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1wzcFQ-0006Gm-G0
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 11:42:36 -0400
Received: from mx1.catap.net ([162.55.82.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1wzcFO-000181-QS
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 11:42:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=vmXV2L1
 To3jylDIg63vKUf4pH3+ECk5ntVfdSgAeSZ9oq6cVaoAhCrTgO944g80lmSlLSqWTyGdTl
 c+ff3+28LH7vgBK6lnd8jk7JFUbNOs5IV/EP7HBSYoKCpauQfQ9VZ9UQOxxGMjSvXTr7VC
 xcYclj68F5AoqD29mczq2O7SSLfdx6fkhKdeMOan6nx9PkoBV5sTCn7VxxqeLAR6/mKw1Z
 0Z8T3f6vd5pLX64LVxUqUlJTCfug30ld54Qo4CMQvtwaJDMCz1aFr03M3b2xArgp3AKGqm
 VSFT/6Yy8pQWBmfyLbaPLFsNzwcyWzrB94HhsCh7YwK4aSIE2ulsuAg==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=h
 J9vp72jg1iSXDCUGIvRf4cTjynhIvAF7wSOgo00oQ0=;
 h=date:subject:cc:to:
 from:dkim-signature:dkim-signature; d=mx.catap.net; b=V85a2NSCECl+VG28
 35Go6rTF73QHW0vuchkTD9H5FPV9lXDqsyBS885DE7rGTzlULub0BLTxbvaeQthEODk0Xc
 8CXmA9ffUT++9yns1G8unjNmvBnTYXRlYiN5+9Doexmfg+RsE29nk6ejDA7KKMOOgbSoQm
 wAHMYuAxQX8XxUTbHRRgoYU6fXAfz29GJwrcm80uXpEZPKoZ7wAKnT9PrW1wH+Zq917saY
 dYHKJbl8aoBCZvFEXwtVt0NIs4BFyo+ZkLS0rV2k67rCCZV/7mEzivZTsb4B/JPiGdDFqe
 Jv198WvbY5THzVrhAwJevaAViA4I0KlmmnaLEUOqBaxDYw==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=b3gUDVYv; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=bsIm5HvR;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=hJ9vp72j
 g1iSXDCUGIvRf4cTjynhIvAF7wSOgo00oQ0=; h=date:subject:cc:to:from;
 d=korins.ky; b=b3gUDVYv2hSBGsqk4UX2uu6K44spZXfR3pCOPFr+82or280ssfK6vyF
 ZqX6/WqQoMI/2UP026jphm/z1Et9xmjvX89OhXgcFDRmyBGZmrSIlGBY3/NSSyutI3kem7
 /CZMSa9Uj/SXaOw7osY9T83KcN7Pu4HrGgwyX0STo7SwtpwjXlBLGUoEZbdKrUjiBsQvgX
 2D747b/igVdeAKL1OarIkUsql5j7HUN6hhqQ/t3L9iMMvL2OMuMVX3yKdXH/7ZnucFq8tA
 LoTaVP0jXeDifcw8xWOGDf5ruiyNQ6YGe2ltL1pSyovoUuRE1nhteimdvhciUIco7PwJ7Q
 ZbrQOxQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=hJ9vp72jg1iSXDCUGIvRf4cTjynhIvAF7wSOgo00oQ0=; h=date:subject:cc:to:
 from; d=korins.ky; b=bsIm5HvR90r1Txi5DXkn4T0nQyNYOyd0Sh4oiDYSCrR38HBdl
 W5ub5GQj+UiKtpL1xqsea4n2BWIEH1Bf3ASCg==
Received: by mx1.catap.net (OpenSMTPD) with ESMTPSA id 92b2555e
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Thu, 27 Aug 2026 17:42:30 +0200 (CEST)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id 12e7d250;
 Thu, 27 Aug 2026 17:42:29 +0200 (CEST)
From: "Kirill A. Korinsky" <kirill@korins.ky>
To: qemu-devel@nongnu.org
Cc: "Kirill A. Korinsky" <kirill@korins.ky>
Subject: mac99: Boot OpenBSD/macppc
Date: Thu, 27 Aug 2026 17:41:12 +0200
Message-ID: <20260827154220.84845-1-kirill@korins.ky>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=162.55.82.72; envelope-from=kirill@korins.ky;
 helo=mx1.catap.net
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Greetings,

OpenBSD/macppc does not complete early boot on mac99: OpenPIC can
reassert an interrupt still masked by CTPR; the edge triggered
decrementer does not raise on zero; successful CUDA ADB replies omit the
original command; and the fixed CUDA shift register delay can stretch
packet delivery past the guest timeout on hosts with coarse timers.

This series corrects these four behaviours and adds a functional test
which boots the official OpenBSD 7.9 macppc CD to the installer prompt.


