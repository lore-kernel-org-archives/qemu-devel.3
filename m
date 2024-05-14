Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3FF7C04FFE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 18:06:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6wXN-0003nS-4W; Tue, 14 May 2024 14:06:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1s6wXK-0003mv-Ie
 for qemu-devel@nongnu.org; Tue, 14 May 2024 14:06:03 -0400
Received: from sin.source.kernel.org ([145.40.73.55])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1s6wXG-0001AQ-9D
 for qemu-devel@nongnu.org; Tue, 14 May 2024 14:06:01 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id D14B5CE1267;
 Tue, 14 May 2024 18:05:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43450C2BD10;
 Tue, 14 May 2024 18:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1715709953;
 bh=bvaaibBBVzbeQPqHnT5CuzCYGE7fqB/tFCQpVFfVMbc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=UHgQUhJkfB5p8O9Njezmm8OPgiYEQwpngSlGdBS1f7k4wuINBEqCojNMkwEVjy2Cu
 8VCiaYZkTe5CYNUTmP5LXXH1ObojToZdownZBVMWcKyTwtcjWgNpwabDFxTKgzuz8m
 3blD2FFkt9qTBWT3bywTWrYQ4D7YA206IvXOsdCkDf/kEC58BA6zewX2kZYW/BThm/
 jhhlTlfG0aPu/zOccKqh5T8eyTG82PfB/OvoQUnXH87iw80uXJkztHG5Ox8/5Q2U3j
 Ru1in9LSrqwwdTpFS9D0aN3EBDiGt3kCkxoUSqIXvvsCuuiwH4s67L5A6Kp65HUEQY
 u7E4HtMuXqmeQ==
Date: Tue, 14 May 2024 20:05:48 +0200
From: Helge Deller <deller@kernel.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, deller@gmx.de
Subject: Re: [PATCH v2 26/45] target/hppa: Use TCG_COND_TST* in trans_ftest
Message-ID: <ZkOn_B2MRfctlood@carbonx1>
References: <20240513074717.130949-1-richard.henderson@linaro.org>
 <20240513074717.130949-27-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513074717.130949-27-richard.henderson@linaro.org>
Received-SPF: pass client-ip=145.40.73.55; envelope-from=deller@kernel.org;
 helo=sin.source.kernel.org
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/hppa/translate.c | 22 ++++++----------------
>  1 file changed, 6 insertions(+), 16 deletions(-)

Reviewed-by: Helge Deller <deller@gmx.de>

