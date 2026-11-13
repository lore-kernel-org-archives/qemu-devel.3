Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E4E606A884
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 21:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=V7boXxAO
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRz14-00078m-GH; Fri, 13 Nov 2026 16:41:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christianslima@proton.me>)
 id 1xRz0o-0006wF-QL
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 16:40:48 -0500
Received: from mail-4322.protonmail.ch ([185.70.43.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christianslima@proton.me>)
 id 1xRz0n-0004Or-Cq
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 16:40:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail2; t=1794606043; x=1794865243;
 bh=L90ARSA7BJpJldk+Mjh4wESUdUl7M1RmpOxMemnOar8=;
 h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=V7boXxAOBjQdFPO2FQhQJfetYjBSSMqw6iV8Ko8VlYWWuOkGYl0MrdP+L9fMv3oCQ
 118ctSud/aua3Cfw9l6DtP1KnMfm8R/4ZqA7G6nVkw2tCpv9OOgxGmc6bksYeYMCzy
 CRsWNG6y03zyj0VDSupB/f7IYzp+Is/iBmFpXfYar3Nw1EptmjG3NV+yM1Y33lUhb0
 pl1NcQW7ZxMSWjC7ZqGpPnSSTkKOM8Fhd1DHzHwVl2pxHR4RinfceDIi8+bxkBqVJM
 l/0q47PJJ0u3yFBtyxuO6jJBbg6aNOFM6FVQCJPSvO93LYft11GuxUO4EqClfxoG4v
 PbZBwGFM/iRJg==
Date: Fri, 13 Nov 2026 21:40:38 +0000
To: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
From: Christian <christianslima@proton.me>
Subject: Re: [PATCH] Change mstatus bits to read-only based on modes
Message-ID: <BhI-SxJQ460eT0BYPfS32e8ttzUHG6hqm3KXagaH-P4N-qPiZd_czmfQm_gEVyYmDI9xap2856-ea6dvEzGTQm2qEBpQy67f6DVFTkkp8GE=@proton.me>
In-Reply-To: <20261113213542.37925-1-christianslima@proton.me>
References: <20261113213542.37925-1-christianslima@proton.me>
Feedback-ID: 169431447:user:proton
X-Pm-Message-ID: dc21065c78b561fa66c5bcf8a153f61f9616a5c9
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=185.70.43.22;
 envelope-from=christianslima@proton.me; helo=mail-4322.protonmail.ch
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Sorry for the mistake sending the series, I'll resend the patchs correctly,=
 please ignore these emails.=20

Thanks,
Christian

> Hi,
>=20
> This series change mstatus bits based if S mode or U mode is present.
>=20
> Initially, I sent two separate patches, but to avoid problems by closing =
the referenced issue in Gitlab and both patches change a similar file, they=
're a patch series now.=20
>=20
>=20
> Christian S. Lima (2):
>   target/riscv: change mstatus bits for read-only if S or U unsupported
>   target/riscv: make mstatus.SPELP read-only when S-mode is not present
>=20
>  target/riscv/cpu.c     | 12 ++++++++++--
>  target/riscv/tcg/csr.c | 22 ++++++++++++++++------
>  2 files changed, 26 insertions(+), 8 deletions(-)
>=20
> --=20
> 2.56.0
>=20
> 

