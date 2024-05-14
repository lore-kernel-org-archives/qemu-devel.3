Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B4EFC04FFE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 18:16:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6wgp-0006MC-G9; Tue, 14 May 2024 14:15:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1s6wgk-0006KC-Jq
 for qemu-devel@nongnu.org; Tue, 14 May 2024 14:15:49 -0400
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1s6wgi-0003bF-9I
 for qemu-devel@nongnu.org; Tue, 14 May 2024 14:15:45 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id BB4416123F;
 Tue, 14 May 2024 18:15:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41D8AC2BD10;
 Tue, 14 May 2024 18:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1715710541;
 bh=ajjjk9DiL5dXrD63BYg/M9wXJOIqWFMcjcdggc9UZak=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=AMrca+OGmnRFNCTw9c8z9r6VMCozNNKIcNNzTlHDv/HeTivw8N0Dtb/fGg3ISmKWP
 Y9LQHPXdW1MoE9Jogte/5lYP2NOG9W6kJULSpTvfujd2GtcsrUt9H4HyW2L3jeXBnl
 pBfP0/p0df9azPaH4GvsRc7jP4A49C6CQkEflYoIDJSH/y0d7K2gj2fMOQT+2Ik5Dr
 Z9HQ6WDzVSrM7W4dtOheYgB7MvSv2dVznbTP9Mft/5mdYFx8V1njwb4unmncbdZdMJ
 BE3P+MhFkSZADK1cTjIsCz/QXonJAQp/wu80RjA5xCwsT/nyWyiYxQbcQFhsdl+SIQ
 S7KDKTYw0bGfg==
Date: Tue, 14 May 2024 20:15:37 +0200
From: Helge Deller <deller@kernel.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, deller@gmx.de
Subject: Re: [PATCH v2 27/45] target/hppa: Remove cond_free
Message-ID: <ZkOqSfg9NYp0762t@carbonx1>
References: <20240513074717.130949-1-richard.henderson@linaro.org>
 <20240513074717.130949-28-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513074717.130949-28-richard.henderson@linaro.org>
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
> Now that we do not need to free tcg temporaries, the only
> thing cond_free does is reset the condition to never.
> Instead, simply write a new condition over the old, which
> may be simply cond_make_f() for the never condition.
> 
> The do_*_cond functions do the right thing with c or cf == 0,
> so there's no need for a special case anymore.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/hppa/translate.c | 102 +++++++++++-----------------------------
>  1 file changed, 27 insertions(+), 75 deletions(-)

Reviewed-by: Helge Deller <deller@gmx.de>

