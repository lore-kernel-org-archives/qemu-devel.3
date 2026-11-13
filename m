Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B2C606A336
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 21:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=A4y5kQUE
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRywP-00021E-5j; Fri, 13 Nov 2026 16:36:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christianslima@proton.me>)
 id 1xRywN-00020k-9x
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 16:36:11 -0500
Received: from mail-05.mail-europe.com ([85.9.206.169])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christianslima@proton.me>)
 id 1xRywK-0001g3-7I
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 16:36:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail2; t=1794605754; x=1794864954;
 bh=GAJE+eWh4rrScORZFB9KExeP1bLyOlgZOjCcYxtjXJU=;
 h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=A4y5kQUEWkLE4GoP75qeF2skYFdFxLPQnbFcJJoWlZeNiLr72/Alce5eCF7PiIW0Q
 /3ZB0je/qqBK0xsQz0FuCZz/2csZdWo1s20Xs7loVB6WOv4x1+4eaToVDSoBuaGREL
 xH65X8F62cFeu/uYCwyZta0sIh00oyumprAfH/gBlcq+uKonvivb8zkGt5KO1o8HUI
 z+JCTi+jqZhhnJGWCQx2BY0ho5z3h6ErKtTSZk5FeRKzz0+XdlrYlTDbN3YW0IbqQP
 DruGDW++AEos9vdNW2/mh0qDo59F8spuDT2VxpBbxKEbXfQZNpxcb/bsSE96tNm42T
 YfsOzJ92ki2Ow==
Date: Fri, 13 Nov 2026 21:35:48 +0000
To: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
From: "Christian S. Lima" <christianslima@proton.me>
Subject: [PATCH] Change mstatus bits to read-only based on modes
Message-ID: <20261113213542.37925-1-christianslima@proton.me>
Feedback-ID: 169431447:user:proton
X-Pm-Message-ID: dea07f26c8e7efffed68fa7501172e01cc2108a3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=85.9.206.169;
 envelope-from=christianslima@proton.me; helo=mail-05.mail-europe.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

This series change mstatus bits based if S mode or U mode is present.

Initially, I sent two separate patches, but to avoid problems by closing th=
e referenced issue in Gitlab and both patches change a similar file, they'r=
e a patch series now.=20


Christian S. Lima (2):
  target/riscv: change mstatus bits for read-only if S or U unsupported
  target/riscv: make mstatus.SPELP read-only when S-mode is not present

 target/riscv/cpu.c     | 12 ++++++++++--
 target/riscv/tcg/csr.c | 22 ++++++++++++++++------
 2 files changed, 26 insertions(+), 8 deletions(-)

--=20
2.56.0



