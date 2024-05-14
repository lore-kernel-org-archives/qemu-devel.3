Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 497ACC04FFE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 16:18:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6uqT-0003Qp-G2; Tue, 14 May 2024 12:17:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1s6uqR-0003Qh-Pa
 for qemu-devel@nongnu.org; Tue, 14 May 2024 12:17:39 -0400
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1s6uqQ-0002SS-6I
 for qemu-devel@nongnu.org; Tue, 14 May 2024 12:17:39 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id A112161280;
 Tue, 14 May 2024 16:17:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42F41C2BD11;
 Tue, 14 May 2024 16:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1715703455;
 bh=sx8jwbtKKseQ9rrXAE1bjfYzXFJoC5vIpP169engWZ4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Cf9hIVzmhS9iNp+tU7jT4HtitlccKK8lCXisyTQ+hyzOqf8S4df/qKHTKtjsBDcbz
 0/1G2S+Npog9//TR0lEqw9NtgvDr8YcIH2RcDnzfmZHZxKz0IOZ3Ylb5YWdIsznDae
 PTGY4Vt+Tw8C3kZ7hgLawTTJcJ4zOXJz7W/o2cH/vTXeCM9Q1uiyiiRD5l/GzfvEQO
 2bE10XdiTexHS2W8h/A+fp+vBswkdTRcC0G1m1DsFfmWwDi4SHFfjWAoMyS3CIeC33
 5dAoGr7dNYrNFlO4casCsgKCfz0lyohVwZE072myt0edXE2AuYhAl8PbTQpyEllK+R
 95jtNn400uE9g==
Date: Tue, 14 May 2024 18:17:31 +0200
From: Helge Deller <deller@kernel.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, deller@gmx.de
Subject: Re: [PATCH v2 19/45] target/hppa: Rename cond_make_* helpers
Message-ID: <ZkOOmx2d18Sgxqtk@carbonx1>
References: <20240513074717.130949-1-richard.henderson@linaro.org>
 <20240513074717.130949-20-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513074717.130949-20-richard.henderson@linaro.org>
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
> Use 'v' for a variable that needs copying, 't' for a temp that
> doesn't need copying, and 'i' for an immediate, and use this
> naming for both arguments of the comparison.  So:
> 
>    cond_make_tmp -> cond_make_tt
>    cond_make_0_tmp -> cond_make_ti
>    cond_make_0 -> cond_make_vi
>    cond_make -> cond_make_vv
> 
> Pass 0 explictly, rather than implicitly in the function name.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Helge Deller <deller@gmx.de>

