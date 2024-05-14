Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A255C04FFE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 18:56:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6xJZ-0000Ks-QZ; Tue, 14 May 2024 14:55:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1s6xJV-0000KX-IZ
 for qemu-devel@nongnu.org; Tue, 14 May 2024 14:55:49 -0400
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1s6xJU-0006qp-3Z
 for qemu-devel@nongnu.org; Tue, 14 May 2024 14:55:49 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id A729F61325;
 Tue, 14 May 2024 18:55:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 022A9C2BD10;
 Tue, 14 May 2024 18:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1715712946;
 bh=T4HRJtZwoChUL6hqIh9ojLqavl94+kuu2KZTXk966K8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=daliXrx3bs22BduEGk1bg1cUBaV8+mj/YgvIngdbN2Fiu9bH14aUOfuu5WUNQ8xGW
 EtaMY0yZSnaqPORAHBV4jIfzfNzpNVyRlgXho4nIuuo6+KZki8gtQLZ5UY0gVK90TA
 NRt+ss1lW3oUDzYsqkxW9CwbwLCmrkK2Lm2OwQBpNf9E+uRDlrcDV7u1T4brrLHzD3
 JJ5aN711H8+Ka/sxltFK66gmYq205GLVFgnRDt5nMvHmeXRE2zaLw5YCY8Huzxe3sU
 KPuvonmAvN4dTOoYG4sV9LUEBP2JZpkNBaPCKx+ThOL6M6CplqsPJ18otGPz3Hq2Ex
 yrGP5Jh38k3vw==
Date: Tue, 14 May 2024 20:55:41 +0200
From: Helge Deller <deller@kernel.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, deller@gmx.de
Subject: Re: [PATCH v2 29/45] target/hppa: Use delay_excp for conditional traps
Message-ID: <ZkOzrajJeK1E0YXq@carbonx1>
References: <20240513074717.130949-1-richard.henderson@linaro.org>
 <20240513074717.130949-30-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513074717.130949-30-richard.henderson@linaro.org>
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
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Helge Deller <deller@gmx.de>

>  target/hppa/helper.h     |  1 -
>  target/hppa/int_helper.c |  2 +-
>  target/hppa/op_helper.c  |  7 -------
>  target/hppa/translate.c  | 41 ++++++++++++++++++++++++++++++----------
>  4 files changed, 32 insertions(+), 19 deletions(-)

