Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 327DEC25B79
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 21:19:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6zXw-00014V-2K; Tue, 14 May 2024 17:18:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1s6zXk-00013K-0h
 for qemu-devel@nongnu.org; Tue, 14 May 2024 17:18:41 -0400
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1s6zXi-0000tS-IG
 for qemu-devel@nongnu.org; Tue, 14 May 2024 17:18:39 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 181E2612D8;
 Tue, 14 May 2024 21:18:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B3E0C2BD10;
 Tue, 14 May 2024 21:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1715721516;
 bh=TnAiUFg0qEb01vKiee4cU61AwfIk2xpuEF46Gb4CtzY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KLqFzwlSh681xuaeufSPyNGY77YQ65VC3kV2Ogi/H5gwcg7Dqj2dJKsTsCvecUYLr
 XYJvEhA989yn8ot/YfAAXx7tDiYRa4a1VTkkeCQASPNskg2/mmvh018xbYuO8NoXIR
 nTmtTczYB2g2dCC7b8lsA/30Iwq39xBegtwTkf6wRHOGdbFdCq/ZWEhbBSbCP4wbUe
 jwtfLpe+dsw0sWddkd2oYEqa4IahN1wGHsbKLhcQGsW2+YMwq8fvieewtEb6LHSPvj
 n3xFXnPklWxb5wats8i1SYpV+FH9ADq9izA28HmbFAImT/Yr4gIfGHQ4ubUuBPefcM
 wLRVIBz7AVHGA==
Date: Tue, 14 May 2024 23:18:32 +0200
From: Helge Deller <deller@kernel.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, deller@gmx.de
Subject: Re: [PATCH v2 36/45] target/hppa: Manage PSW_X and PSW_B in translator
Message-ID: <ZkPVKFVvgLb2_9cm@carbonx1>
References: <20240513074717.130949-1-richard.henderson@linaro.org>
 <20240513074717.130949-37-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513074717.130949-37-richard.henderson@linaro.org>
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
> PSW_X is cleared after every instruction, and only set by RFI.
> PSW_B is cleared after every non-branch, or branch not taken,
> and only set by taken branches.  We can clear both bits with a
> single store, at most once per TB.  Taken branches set PSW_B,
> at most once per TB.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Helge Deller <deller@gmx.de>

