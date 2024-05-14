Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29F9DC04FFE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 21:24:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6zck-0003RG-Jv; Tue, 14 May 2024 17:23:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1s6zci-0003Qz-KV
 for qemu-devel@nongnu.org; Tue, 14 May 2024 17:23:48 -0400
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1s6zcd-0002YI-78
 for qemu-devel@nongnu.org; Tue, 14 May 2024 17:23:46 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 821B1CE118C;
 Tue, 14 May 2024 21:23:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72ADAC2BD10;
 Tue, 14 May 2024 21:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1715721819;
 bh=dFk92RaWO2RCEnoHy9UlN1Dg27XRsO2Y/LbB0mxbB5w=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=a3pKinfJOLtdlUPtu2FvoB0JP/rsX6Ls2hd4UDv3fzLb9mZiDgePabyQg38s53t/5
 lcdqGZJBpS3F9etXuOkQ+8VC9cZC+55OEhb2c0N+rIrIw6+HsQaiM9+B3IIMtMAAwt
 T8JKv3u84501OnSjAPXub1UkJ2A131xZr1hPoHACE9zaPiDAhu3MQ5o18QBMD0VQwp
 Pv2SOrj91ao78Owmof7x32DJG6egw5OxBdu2EKfUKsYw5X+PI+jNXOGJzfwoLfDNBW
 n6OSI4tb2s+w+/ZqjCyipF+Wv+aPKFRv1LhvuWpqVkrZulAUctl1Sn30UeeA4Ih6Ov
 5pPrkcNdsGRRg==
Date: Tue, 14 May 2024 23:23:34 +0200
From: Helge Deller <deller@kernel.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, deller@gmx.de
Subject: Re: [PATCH v2 39/45] target/hppa: Drop tlb_entry return from
 hppa_get_physical_address
Message-ID: <ZkPWVh1EwShLeZfj@carbonx1>
References: <20240513074717.130949-1-richard.henderson@linaro.org>
 <20240513074717.130949-40-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513074717.130949-40-richard.henderson@linaro.org>
Received-SPF: pass client-ip=2604:1380:40e1:4800::1;
 envelope-from=deller@kernel.org; helo=sin.source.kernel.org
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
> The return-by-reference is never used.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Helge Deller <deller@gmx.de>

