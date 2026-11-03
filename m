Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E76F606A326
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 01:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m4sLTEEE
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xO3Xi-0004CS-HP; Mon, 02 Nov 2026 20:42:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>)
 id 1xO3Xe-0004BS-4a; Mon, 02 Nov 2026 20:42:27 -0500
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>)
 id 1xO3Xc-0004cE-Gr; Mon, 02 Nov 2026 20:42:25 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D6DA741859;
 Tue,  3 Nov 2026 01:42:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D69C1F000C1;
 Tue,  3 Nov 2026 01:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793670142;
 bh=D0qYDYr/Kx5HgJyEgnZ7B6YNnHUaui3yRKk4x1APDmA=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=m4sLTEEEcJZ4wvUAmfo64ZvqHH9GqPFmUH7/Crjw3+KqC0zZYFz2/IARJd75M8QeD
 zLx5UDKz60QCxxkgiRdNtHJMnNHm6XlcbpNLr5PNhvHGeirQbUTBTePtzj1TwQED7I
 1aWdw5eS41eC+CHM+4hUpWTKsc2j1BdmD0y95AKHx3lcK4AMMAZVpAPeUJ3kHIdlPO
 Fr6L+bdaaT6dr3meyNo1/oY0JPi6Cf7C1WwTMtiDkG8WerBW6XdVHbqAx53dUFxNxi
 CWXD+Gc8Wd/7DuXuaZqxysRboeKlf85Wcl4ClR0bgSewIdxH7YDX9QRZLTomVGkitC
 7JelnUR27gDqg==
Date: Tue, 3 Nov 2026 01:42:14 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jinjie Ruan <2118537295@qq.com>
Cc: anisinha@redhat.com, armbru@redhat.com, eblake@redhat.com,
 imammedo@redhat.com, michael.roth@amd.com, mst@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, ruanjinjie@huawei.com
Subject: Re: [PATCH 15/37] hw/arm/mpam: Add ECR/ESR and error MSI register
 storage
Message-ID: <20261103014214.7afae818@jic23-hlaptop>
In-Reply-To: <tencent_8DD3E62650105B6EF1A4F266B88ED1569E09@qq.com>
References: <20261016094733.1898485-1-2118537295@qq.com>
 <tencent_8DD3E62650105B6EF1A4F266B88ED1569E09@qq.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=jic23@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 16 Oct 2026 17:47:09 +0800
Jinjie Ruan <2118537295@qq.com> wrote:

> From: Jinjie Ruan <ruanjinjie@huawei.com>
> 
> Add read/write handling for the error report surface as plain
> per-RIS storage: MPAMF_ECR (INTEN write mask), MPAMF_ESR and the
> ERR_MSI configuration block.  Error recording semantics, the MSC-
> global ESR view and the interrupt outputs arrive with the error
> reporting patches.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

