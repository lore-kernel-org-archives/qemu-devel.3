Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88E80CA5FD9
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 23:02:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCPmW-0004T2-RW; Thu, 01 Oct 2026 19:01:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>)
 id 1xCPmD-0004No-US; Thu, 01 Oct 2026 19:01:23 -0400
Received: from mx2.catap.net ([65.21.79.163])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>)
 id 1xCPmB-0007j6-6d; Thu, 01 Oct 2026 19:01:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=oLvcy91
 6Zrm3p3lNsJ5YSMrApPJMDsbPzDO9ykXfSFl+s+U5bK07CAntal8vgp+6tvwWIddqvQu7P
 YsAyaCnkAzV8kLa8QS8/F6jyQ01WpsnSD/3pf71Wv7lzhWfX/X4j78F+ChRXMpwQgwTvvs
 aAw4ETNCClWQ7NC9oU2hF0iEoArcNoXzPl3Dhi/GolcaNqZknbyusRhFVcy818GqYNME2O
 gVS5S+YcA4vWLNFJrN1OY9/kQv7cLLkrn67mOIl4JrcFk9GyeLtIsz8yEOzPp3TpNlbeBK
 S8rHp+RRXJPCBgTgX/syXUNh/crxPRbdkB5I+ZsF1epIewNjID/lBgg==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=E
 qHMsD07ijabZjxI5PNG9FDX08Et3qQ2lL3yHz8x/v4=;
 h=date:subject:to:from:
 dkim-signature:dkim-signature; d=mx.catap.net; b=Q/wPHvE9zyYNpxqCVzF28
 Oj6D6nZH4Wni3Pjj8Ha6hzVChMtZtF5HEJfUKB9EDTK8XayEmlpXQ2tfkzzRFUXOLXoTGn
 t0POYMoSjlx6SMkdtmZPftHJ1kByldg/2YZUigIwofBioS0sN5xAsv1CkqI5S/kKn1mGNg
 DSJKHKliZFBIoMsj1WonOChlcordsBKavGoZGt7JbQ66soT1fi33UtiKDWmTDXE4qBLxkS
 pc2svP2X5ZA9Q2sDyEWdfzAcf1+pu93lDO2UKIk45pR5kaDBkJIuw/y1165Ve6/8EbRoD8
 TAJMZbUr0NuXYOzHt6Of+16fuaUFvQIQu2t8PjdWQ==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=iYEk0kmt; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=oHFr2k09;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=EqHMsD07
 ijabZjxI5PNG9FDX08Et3qQ2lL3yHz8x/v4=; h=date:subject:to:from; 
 d=korins.ky;
 b=iYEk0kmt0i86nbwaOFzTdh2RjWnI5ApDNmUmWkfORp9Bo67PONhxMHt
 UhwxjMQvknVqUhhIP4VMkVIW99Dpyn5RK6qKwPQZ8q9dFmmYk94zJortxbSdffUqxN2FwF
 crigR+mU4DQ0qNBJo/KTOnT7KCFM0jVPsveu80GecnzuFaQwLuB34jhRnVJgcIot4ksIAX
 UgBkuaY5M9sGCtsiaXdGHwdHXgBaP9eQ1YRdft6lnV/pTvkRK4LAJMszD69IzuRitG0bra
 nKZznc7TPaoNVojjAnYk27bdH24N9W+peH9V8j6nug1HLIT+xdHXBV1VlWOe3u4lryx527
 BpDlyYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=EqHMsD07ijabZjxI5PNG9FDX08Et3qQ2lL3yHz8x/v4=; h=date:subject:to:
 from; d=korins.ky; b=oHFr2k0981dOg03mMVm8pij6sh+flchtkyTslcUsQs2iyWm/w
 0kNe89HYzVdmtYS1sgTuq3RUpDm//Wxj+tHDw==
Received: by mx2.catap.net (OpenSMTPD) with ESMTPSA id 40273242
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Fri, 2 Oct 2026 01:01:08 +0200 (CEST)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id 60c58c4d;
 Fri, 2 Oct 2026 01:01:06 +0200 (CEST)
From: Kirill A. Korinsky <kirill@korins.ky>
To: Harsh Prateek Bora <harshpb@linux.ibm.com>,
 "Kirill A. Korinsky" <kirill@korins.ky>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Chinmay Rath <rathc@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Anushree Mathur <anushree.mathur@linux.ibm.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Miles Glenn <milesg@linux.ibm.com>
Subject: [PATCH v3 0/5] mac99: Boot OpenBSD/macppc
Date: Fri,  2 Oct 2026 00:58:59 +0200
Message-ID: <20261001230058.11465-1-kirill@korins.ky>
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

This is the third version of patch series to boot OpenBSD/macppc.

OpenBSD/macppc does not complete early boot on mac99: OpenPIC can
reassert an interrupt still masked by CTPR; the edge triggered
decrementer does not raise on zero; successful CUDA ADB replies omit the
original command; and the fixed CUDA shift register delay can stretch
packet delivery past the guest timeout on hosts with coarse timers.

This series corrects these four behaviours and adds a functional test
which boots the official OpenBSD 7.9 macppc CD to the installer prompt.

-- 
wbr, Kirill


