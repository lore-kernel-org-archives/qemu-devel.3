Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA06606A323
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 21:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=sxnmD8vU
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRcem-0001eM-Me; Thu, 12 Nov 2026 16:48:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christianslima@proton.me>)
 id 1xRceh-0001dr-VK
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 16:48:29 -0500
Received: from mail-24416.protonmail.ch ([109.224.244.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christianslima@proton.me>)
 id 1xRcef-0006uQ-8N
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 16:48:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail2; t=1794520100; x=1794779300;
 bh=JH+WnO081/WbiPZjcg+vUX0QQmXDXLTKD0WWZPfPhvQ=;
 h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=sxnmD8vUkn2Oup2YtdDQLBp6QuVzWvQ1lBzPjRSGj+vLF03GWrvnW6kNCrQ8cfdXz
 7oYkzmHv7J+5uQm4RR6iuB1whMECgq7wFNpxO5CBRPZzGDRfnl0gUJQpHPXIPp9Jx9
 R9xbwdGt7Y2KMh4Es9UKw6rILAYQPRToMbd3r+5OP88h/md/vNXL5viWBtOSPkeuRf
 J5S4TET+vDdcOFZsuuH3uu4ITTBt+2f1IeXdTvS6x6N17kRW3larSRhnJVzbO3e+HO
 77nJQpXCECW4Nk6szfl6NsJHeBeol16840VoR0F2qUuq92HDlgy7oGiOFB4e2MXNor
 QOC9HbEXWsR8A==
Date: Thu, 12 Nov 2026 21:48:15 +0000
To: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
From: "Christian S. Lima" <christianslima@proton.me>
Subject: [PATCH 0/1] target/riscv: make mstatus.SPELP read-only when S-mode is
 not present
Message-ID: <20261112214810.78747-1-christianslima@proton.me>
Feedback-ID: 169431447:user:proton
X-Pm-Message-ID: 806c2a07246265958f4732493444944bfeca54af
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=109.224.244.16;
 envelope-from=christianslima@proton.me; helo=mail-24416.protonmail.ch
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Based-on: 20261110232614.83050-1-christianslima@proton.me
("target/riscv: change mstatus bits for read-only if S or U unsupported")

Hi,

This patch fixes an issue in the same way as "[PATCH v3] target/riscv: chan=
ge mstatus bits for read-only if S or U
unsupported", but an additional comment was added later in the issue, so I =
thought it deserved a separate patch.

And in addition use "[PATCH 0/1] target/riscv: do not write SXL < UXL [GL48=
21]" too, in order to avoid breaking things as described in the cover lette=
r.


Christian S. Lima (1):
  target/riscv: make mstatus.SPELP read-only when S-mode is not present

 target/riscv/tcg/csr.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--=20
2.56.0



