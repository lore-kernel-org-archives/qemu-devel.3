Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A815606AC16
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 21:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=QFBqnN71
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRz93-0007YU-NG; Fri, 13 Nov 2026 16:49:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christianslima@proton.me>)
 id 1xRz90-0007LU-5q; Fri, 13 Nov 2026 16:49:14 -0500
Received: from mail-43101.protonmail.ch ([185.70.43.101])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christianslima@proton.me>)
 id 1xRz8x-0002eJ-RC; Fri, 13 Nov 2026 16:49:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail2; t=1794606545; x=1794865745;
 bh=GAJE+eWh4rrScORZFB9KExeP1bLyOlgZOjCcYxtjXJU=;
 h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=QFBqnN71qdFNh3zfCETTnTytGaS0hGLmjFg+3bW/nDZcWWSgLIs3JNYM9+ZcPUcdO
 AbEss9pwzAUxk5Cm20azhm24H6e8q7xcLoa3XZujir8hWBJgilxoK/UyGR8Rf9Kq12
 QgHvbF/beInduYBDlVUq3QJXoSqoem4Fr8U4Zy5I+45QxmvM9mGyuXqNcvOqhBcGAw
 R8mTS9evNJkrkxaJH9j2srfD03MwuXkJCkD3ijMEsY5P94uOiMRiEwUBohf1WWSkW3
 ON7YLmhv8Ox6t9i/H1DnbJ0Egbu5o37SDrHpKfnGONZTU+9F35fDSBF1t34hVUNX9g
 jw0teQ2fpWqQw==
Date: Fri, 13 Nov 2026 21:48:59 +0000
To: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
From: "Christian S. Lima" <christianslima@proton.me>
Subject: [PATCH 0/2] Change mstatus bits to read-only based on modes
Message-ID: <20261113214854.40425-1-christianslima@proton.me>
Feedback-ID: 169431447:user:proton
X-Pm-Message-ID: c097ac24259962483817cd5161b6f8eb5788ef49
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=185.70.43.101;
 envelope-from=christianslima@proton.me; helo=mail-43101.protonmail.ch
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



