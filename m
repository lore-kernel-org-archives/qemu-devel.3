Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDDE606A32D
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 03:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XjLpQOVq
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xO563-0001ip-JR; Mon, 02 Nov 2026 22:22:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>)
 id 1xO55p-0001fb-1L; Mon, 02 Nov 2026 22:21:50 -0500
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>)
 id 1xO55m-0005PP-Ja; Mon, 02 Nov 2026 22:21:48 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CBBEC4365F;
 Tue,  3 Nov 2026 03:21:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1AA91F000C1;
 Tue,  3 Nov 2026 03:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793676104;
 bh=VwJ67fxmQRM68Xr0kITu0aZXbN6J7uf9vljDpuM4Yzg=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=XjLpQOVqAyoQIVzCG9Do5KJSEHH4ovYQ+b8dnXmqJcZrWZfSplYLaMIUN774+YeYD
 UrIsz90o6ZkR6R6wCau4HUMS2xp3zroWLWYht+P/dPYYURLE8i7sQcDsvbBdxwrnZv
 uyqn0ilMlWyr/J87NbAJ9v0HBMqGCaf0pqgBLbn15v5KfHtoTwRw3tZf3U0Dbfk8IT
 FvYrWoq0eAkZQbFlFS8YeFep/DEPeawvxNc6hN87331gj2NvuEAxiGUH51U5gZUvXK
 fi4XrBG+Lgc5QFvFayKPRDifpVvXEj6xY4ew1abXcZ0jZiMonnKWNUtWhGnTio0kM4
 mY+Ovqy6vw0AQ==
Date: Tue, 3 Nov 2026 03:21:37 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jinjie Ruan <2118537295@qq.com>
Cc: anisinha@redhat.com, armbru@redhat.com, eblake@redhat.com,
 imammedo@redhat.com, michael.roth@amd.com, mst@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, ruanjinjie@huawei.com
Subject: Re: [PATCH 30/37] hw/arm/mpam: Handle ECR/ESR as MSC-global registers
Message-ID: <20261103032137.480b15d2@jic23-hlaptop>
In-Reply-To: <tencent_091C67ACF8A6E14D582142DD224A35CCC80A@qq.com>
References: <20261016101058.1900808-1-2118537295@qq.com>
 <tencent_091C67ACF8A6E14D582142DD224A35CCC80A@qq.com>
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

On Fri, 16 Oct 2026 18:10:50 +0800
Jinjie Ruan <2118537295@qq.com> wrote:

> From: Jinjie Ruan <ruanjinjie@huawei.com>
> 
> MPAMF_ECR and MPAMF_ESR are single per-MSC registers (IHI 0099
> 4.3), independent of the RIS selection, but the model stored them
> per RIS.  Move the live copy to MSC level: ECR/ESR reads and the
> extended ESR upper half (guarded on MPAMF_IDR.EXT) come from the
> MSC-global view, ECR writes store masked and ESR writes deposit
> into either half, and mpam_msc_sync_esr_ecr() keeps the per-RIS
> export copies (used by the QMP introspection) in sync.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>


