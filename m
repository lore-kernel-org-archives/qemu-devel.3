Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8C0DC624A4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 11:53:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2602-0003iq-07; Thu, 03 Sep 2026 07:52:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>)
 id 1x2600-0003hy-6n; Thu, 03 Sep 2026 07:52:56 -0400
Received: from mx2.catap.net ([65.21.79.163])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>)
 id 1x25zy-0002h1-GH; Thu, 03 Sep 2026 07:52:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=KibzkjB
 9dwC44tIAC3QtdWy4a6hsj7CF2jXy0VJreugNuxkJ+S+Xca5Pz+erJeKvsT5rflBcBajFS
 ZJ9KX3FKPV2ddF6a2v2VTVSLPRrk2AeiNJ1aV+4ym6wMl29jq1huRlQ5BawVOmNQMNQS7Q
 MCSnT3yTcOotKXf0ynJ1MQkrSYeAPPiphmhI4iyYlvAwHrGgxLmyGi+rf4OhFu1bc9xWZJ
 Rtfu+ttnJWypRdesjD/utnO8V3tpfjCckfTcIEyVXqT0P1KUoY90ZBfh97ARVC6cLVkTou
 Eohee6GXj1fCmyadeU4ZZ4ru+h8o7vd6BU5ufKVsF55dlB61/rUnegw==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=U
 M9TIdNYpcJwpd//cCLt4Xnjxdqq6NNYIyTN07t6gwI=;
 h=date:subject:cc:to:
 from:dkim-signature:dkim-signature; d=mx.catap.net; b=hKfq2y4It4fZKlkg
 8rdMjOM8fsGQQJdMe7MKcNsK2Cr4Zk9xZjRdLA3+DvZRaqy/+nNZ8TXJnIaNhdvtshy3E+
 8212hfD9zCHRNfQu5zPfgcnN2KhN67BFuizonvkAiRAI85d5/+ct/upKD5+mpE7lmlsXcV
 G4h4Fq61vzB0QjhOHSzvJ/3XauQLqe8duxLc7lISZrNpa9kQcFENRSLCYhXTbgO8atZoMz
 MeWzcd1DApqI4NuAHopThoZ44zN0619I98TISTNIcJyLRkdoVKJdB8zyFlAkwsQEHBnosy
 quvqSzkNSsLYOwR4tYLGfYDk0feqz09IhBQH3Xbfl0y97g==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=dmr/oZSh; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=aHKF+6qC;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=UM9TIdNY
 pcJwpd//cCLt4Xnjxdqq6NNYIyTN07t6gwI=; h=date:subject:cc:to:from;
 d=korins.ky; b=dmr/oZShCBXg4+rF+seTN89KFczjoDzAkjTQQm+3b7iEGqDh7cQZasx
 kkBA5r7D0nS06ym3d7WGMXIYJLYYeQz7hy3GHZYGWJwRx5cNLVsV0i0rj/OPYi3tXFLpmV
 Ljq3UCHEGd64vcYfGQBUEwX5sBWULN8SXDsaNCQ4fcBr/5H3UGs4r9h23H++pE/HWS8Co0
 4UA43nbC73/dD3Uep2v0xkBuQl6Nc80tQ7gytBvEs4+a0A2uB5lNEsyRNClHGyEdQtAW/d
 TIDkFIuEpLZpwRzyPhvkX5miKPz4zM2pSzrusZpRlnAV2W0BJkgAsCjeGQ40kuVUnyLHC+
 g2L3oKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=UM9TIdNYpcJwpd//cCLt4Xnjxdqq6NNYIyTN07t6gwI=; h=date:subject:cc:to:
 from; d=korins.ky; b=aHKF+6qC5/38OX2oma7fMBNVFOpmbF896qkGUI6GutwbIE61A
 2rlt9esx61fZbun1yR8BmRS1Y3wi0roOitQBg==
Received: by mx2.catap.net (OpenSMTPD) with ESMTPSA id 2b671b9b
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Thu, 3 Sep 2026 13:52:49 +0200 (CEST)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id 075e6d37;
 Thu, 3 Sep 2026 13:52:47 +0200 (CEST)
From: "Kirill A. Korinsky" <kirill@korins.ky>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Chinmay Rath <rathc@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: "Kirill A. Korinsky" <kirill@korins.ky>
Subject: [PATCH 0/5] mac99: Boot OpenBSD/macppc
Date: Thu,  3 Sep 2026 13:50:25 +0200
Message-ID: <20260903115229.95811-1-kirill@korins.ky>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=65.21.79.163; envelope-from=kirill@korins.ky;
 helo=mx2.catap.net
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

P.S. this is second third to send the same patch because previous one
had missed maintainers.


