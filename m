Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C800FC04FFE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 18:50:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6xDP-0007L0-Td; Tue, 14 May 2024 14:49:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1s6xDA-0007GE-OJ
 for qemu-devel@nongnu.org; Tue, 14 May 2024 14:49:18 -0400
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1s6xD3-00032z-12
 for qemu-devel@nongnu.org; Tue, 14 May 2024 14:49:13 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 4BAD76130D;
 Tue, 14 May 2024 18:49:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F4BDC2BD10;
 Tue, 14 May 2024 18:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1715712546;
 bh=g0d8dLiwwWiFkRKC7OcmQ2YeqFT9KCf5I9mJsmVUv1k=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=dQYYoqxTT799XuAvHLXfo6Eyq06RuywegSw+ScrB/+1deKsJWPlfhnjfJPN4cqwfi
 vZ2POiFRt6bHLFnhh6jRZ2Zod3KO6dCD4yDFp9H4JXXWrl/91IFSMJx515j7WB28L7
 tFL1AiiErpi7o8e5R4P7qSW1Um3hKgQfmUpgJ/8QP9ZaLHyT/2C67XsZfdzsp56xVn
 PAqauqwHUsx/k1qI3LYaUHAZOzeSHpSSE7/1Dy6/E3SSjsx9V+6wgMOFgi7ulVIVxh
 kKcVV2vwcc7bhb+YtN6dvnEtxz0/nWfLOMlcNUa396rmc9MzQLRJE/xsYWrBVYKoyn
 UV0gRvPr+eR7w==
Date: Tue, 14 May 2024 20:49:01 +0200
From: Helge Deller <deller@kernel.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, deller@gmx.de
Subject: Re: [PATCH v2 28/45] target/hppa: Introduce DisasDelayException
Message-ID: <ZkOyHQPJvSiP_xNN@carbonx1>
References: <20240513074717.130949-1-richard.henderson@linaro.org>
 <20240513074717.130949-29-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513074717.130949-29-richard.henderson@linaro.org>
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=deller@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
> Allow an exception to be emitted at the end of the TranslationBlock,
> leaving only the conditional branch inline.  Use it for simple
> exception instructions like break, which happen to be nullified.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/hppa/translate.c | 60 +++++++++++++++++++++++++++++++++++++----
>  1 file changed, 55 insertions(+), 5 deletions(-)

Reviewed-by: Helge Deller <deller@gmx.de>

