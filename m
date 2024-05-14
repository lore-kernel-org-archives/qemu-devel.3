Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE727C04FFE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 20:13:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6yWe-0006u9-8i; Tue, 14 May 2024 16:13:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1s6yWc-0006ps-LP
 for qemu-devel@nongnu.org; Tue, 14 May 2024 16:13:26 -0400
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1s6yWb-0004dI-1q
 for qemu-devel@nongnu.org; Tue, 14 May 2024 16:13:26 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id C8C7B61280;
 Tue, 14 May 2024 20:13:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19C9CC2BD10;
 Tue, 14 May 2024 20:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1715717603;
 bh=ZSBZiaIhPUsvsqwHLW572YDv703U6/vVbLdt2UR/lA4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=VWXtCxT5v6nQ91eZ9eRHu3BlPfIP3sG48meHPoYlHMyJhre/yNr0ISyKiBBVwHB43
 ZrJrsHCGEUo/NVrcfXI4kebJXtzW/6GuP95+ask4CX4DgMCypdqUGO92TSIXW0gRdQ
 TNwxFR11re/AmPSaU5fLJhncE0EqnfGDMvNiWFZMbc6M8j1kV5AswHrJw0tfGKnUWk
 hie1Rpn07PAOYwVOCNM3N+tw/Xo0f7HGj+HPH1bW/B7sGtH8260bqf2PUhIR7R5TOc
 c0hNgjVHHYonRimEWvfvLFf89APYBi600pKvfxD3g7s9Tl3aDXGDS0POEA2RANQMa1
 Z8ZKO1SmpMvxg==
Date: Tue, 14 May 2024 22:13:19 +0200
From: Helge Deller <deller@kernel.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, deller@gmx.de
Subject: Re: [PATCH v2 33/45] target/hppa: Do not mask in copy_iaoq_entry
Message-ID: <ZkPF3zVk5x8Hb5Vc@carbonx1>
References: <20240513074717.130949-1-richard.henderson@linaro.org>
 <20240513074717.130949-34-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513074717.130949-34-richard.henderson@linaro.org>
Received-SPF: pass client-ip=139.178.84.217; envelope-from=deller@kernel.org;
 helo=dfw.source.kernel.org
X-Spam_score_int: -80
X-Spam_score: -8.1
X-Spam_bar: --------
X-Spam_report: (-8.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

* Richard Henderson <richard.henderson@linaro.org>:
> As with loads and stores, code offsets are kept intact until the
> full gva is formed.  In qemu, this is in cpu_get_tb_cpu_state.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Helge Deller <deller@gmx.de>

