Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA7C606A331
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 17:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=wsGa/rsO
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOekE-0000wB-QT; Wed, 04 Nov 2026 12:25:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@linux.dev>)
 id 1xOekB-0000vO-BZ
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 12:25:52 -0500
Received: from out-152.mta1.migadu.com ([95.215.58.152] helo=mta1.migadu.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <junjie.cao@linux.dev>)
 id 1xOek8-0005bF-MU
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 12:25:49 -0500
X-Envelope-To: qemu-devel@nongnu.org
DKIM-Signature: a=rsa-sha256; bh=MxR3c48AzklxPRyTJpjhZAtl2/Qg2f+G50G0qs7v1Wg=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793813146; v=1; x=1794417946;
 b=wsGa/rsO78jClay5d3sxcOBtHBBN7fBmbamLWxfNz/pDSw19IMIKaInaViyCVPHdH/m+QTSI
 J/PJQpPdlQAnuBe2LYF+MOFeG3KwuGMoSHDvAnowVNyWhGn0u59PF0GtB2I5Hp5aolMBM92naHc
 DySQ7WwtxOYvO5Zj1JNblSYo=
X-Envelope-To: qemu-devel@nongnu.org
Received: by smtp.migadu.com with ESMTPS id 9815f4b0805190e0;
 Wed, 04 Nov 2026 17:25:46 +0000
X-Mizu-Trace-ID: 9815f4b0805190e0
X-Migadu-Flow: FLOW_OUT
From: Junjie Cao <junjie.cao@linux.dev>
To: shrihari.s@samsung.com
Cc: jic23@kernel.org, linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
 qemu-devel@nongnu.org, anisa.su887@gmail.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, arun.george@samsung.com, cpgs@samsung.com,
 dave@stgolabs.net, dongjoo.seo1@samsung.com, gost.dev@samsung.com,
 s.neeraj@samsung.com, vikash.k5@samsung.com, anisa.su@samsung.com,
 junjie.cao@linux.dev
Subject: Re: [PATCH qemu v1 5/8] hw/pci: Wire SVC initialization into port
 realize functions
Date: Wed,  4 Nov 2026 11:25:26 -0600
Message-ID: <20261104172527.2172366-3-junjie.cao@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <360067785.01793792402254.JavaMail.epsvc@epcpadp1new>
References: <20261104115242.2035807-1-shrihari.s@samsung.com>
 <360067785.01793792402254.JavaMail.epsvc@epcpadp1new>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=95.215.58.152; envelope-from=junjie.cao@linux.dev;
 helo=mta1.migadu.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Tested port capability enumeration and CXL RP/USP UIO gating on q35
at cold boot and after system reset, with the full series on
3c99db7705c1. The ioh3420,x-svc=on case reports an error instead of
aborting.

Also checked the CXL capability chains and USP HDM UIO advertisement
on aarch64 virt using qtest.

Tested-by: Junjie Cao <junjie.cao@linux.dev>

