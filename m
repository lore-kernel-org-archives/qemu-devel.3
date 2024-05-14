Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEA6AC04FFE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 16:24:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6uwV-0005Zx-44; Tue, 14 May 2024 12:23:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1s6uw8-0005Ya-OQ
 for qemu-devel@nongnu.org; Tue, 14 May 2024 12:23:35 -0400
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1s6uw6-0003lo-1Q
 for qemu-devel@nongnu.org; Tue, 14 May 2024 12:23:31 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 0AE31612DA;
 Tue, 14 May 2024 16:23:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64A19C2BD10;
 Tue, 14 May 2024 16:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1715703807;
 bh=vMtHbj1Tdah9/fL5DjXdiJA4p7ugki8OTqtFgJ6Hv84=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=V1THuO1EQiClsiLDs9tK9Vzk4B6ddj36JAkEklP68RpQgKx41hfpdDbCsTkp7BJwS
 xA1l6MaUPx/h9ClGem60vh/yVxj3NLUGdDFx0vkfXgCeFQCHn0lekPUSN3c4+7ucX9
 Cp3/HuMinayDJhyIIoBT7GObBLSV+/vT0To3rP7XVT+OdRf40qaN6afWv1h4gx+doP
 INttK1kHMdMnuM6aBvVkL26Seh7g0hxadu7H5mHjjYc9EAREY9VVZ1FiT3qIw6AC/O
 hMGMJvs3EzLKZcCI2JSCq8Nz1YSPMu2ZLOXAT8eqmG5LzXLDU6A5FRsUeQmA/sBI0Q
 p1jFwPpzA2e8w==
Date: Tue, 14 May 2024 18:23:23 +0200
From: Helge Deller <deller@kernel.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, deller@gmx.de
Subject: Re: [PATCH v2 20/45] target/hppa: Use TCG_COND_TST* in do_cond
Message-ID: <ZkOP-487BgWEYDN9@carbonx1>
References: <20240513074717.130949-1-richard.henderson@linaro.org>
 <20240513074717.130949-21-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513074717.130949-21-richard.henderson@linaro.org>
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
> We can directly test bits of a 32-bit comparison without
> zero or sign-extending an intermediate result.
> We can directly test bit 0 for odd/even.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Helge Deller <deller@gmx.de>

