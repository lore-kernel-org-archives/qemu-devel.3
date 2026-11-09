Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD56606A31C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 04:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rispop.dev header.i=@rispop.dev header.a=rsa-sha256 header.s=protonmail header.b=ANASI1KZ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQH78-0006cV-Ii; Sun, 08 Nov 2026 23:36:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rishab@rispop.dev>) id 1xQH77-0006cD-8P
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 23:36:13 -0500
Received: from mail-244106.protonmail.ch ([109.224.244.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rishab@rispop.dev>) id 1xQH75-0001PR-3F
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 23:36:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rispop.dev;
 s=protonmail; t=1794198967; x=1794458167;
 bh=w/NUIvC+l8C0eO4zefmXuNb8VhqpO2O90y9NrJYOK5Y=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=ANASI1KZZZ49a0ATp6H3zcBHbL6A1GBhJ6Sl/EX80HvZ2ZDSE81ZlVVrNIL13iTXO
 1F0YIG0RaMdX0/HIoTSvSXLW2id0IZosJxDOvVU+vm3S58oK7lCwj3+qywgCwdkMvZ
 eZhTQKdAjAFp4konyCsNIOHiNWv3XWqpY0j4JokuasrAD1DGSO4byNss1/R7Ihu6h6
 aba0WAdVxrAi3ldKa5N686lsgS9sP2gGRxJ0aOi7d6pxGhHOpbm1z3X+YSHRZ+HSZS
 /H6g5sLDTjGWdRanhQzK6QNCXiEd0s92D1e2KapuUbNhuFAjSW+DSqeyoFn9wVK2f/
 soGo2mBjzOkyw==
X-Pm-Submission-Id: 4jNH6B0MkHz2ScmZ
From: Rishab Pradeep <rishab@rispop.dev>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Tarun Patanjali <tarun.patanjali@utexas.edu>,
 Chris Elwood <christopher.elwood2024@gmail.com>
Subject: Re: [PATCH v2 2/2] target/riscv: Apply pointer masking to
 SSPUSH/SSPOPCHK addresses
Date: Sun,  8 Nov 2026 22:35:21 -0600
Message-ID: <20261109043521.15730-1-rishab@rispop.dev>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261108064641.179764-3-rishab@rispop.dev>
References: <20261108064641.179764-3-rishab@rispop.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=109.224.244.106; envelope-from=rishab@rispop.dev;
 helo=mail-244106.protonmail.ch
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Sashiko suggested a Fixes tag pointing at f06bfe3dc38c ("target/riscv:
implement zicfiss instructions"). I agree this needs a Fixes tag, but
I think the right target is the pointer-masking commit rather than the
zicfiss one. Zicfiss predates it, and its ssp accesses were correct
until get_address() started applying the ignore transformation without
covering ssp:

Fixes: 4d501a7a7fb4 ("target/riscv: Update address modify functions to take into account pointer masking")

Alistair, could you add this when applying, or would you prefer a v3?

Thanks,
Rishab

