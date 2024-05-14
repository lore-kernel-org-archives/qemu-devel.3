Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0284EC04FFE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 15:36:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6uBz-0007X6-VY; Tue, 14 May 2024 11:35:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1s6uBg-0007FB-EV
 for qemu-devel@nongnu.org; Tue, 14 May 2024 11:35:34 -0400
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1s6uBY-0001JN-SQ
 for qemu-devel@nongnu.org; Tue, 14 May 2024 11:35:30 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 89EE9CE12A2;
 Tue, 14 May 2024 15:35:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CAE0C2BD10;
 Tue, 14 May 2024 15:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1715700920;
 bh=L3D4wx8lGcmxqYwGEpL0YIRH6cT9xndOxLHmGGUHNg4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ZkE/xQVPIRkEQAwXSqTYGk0bNtkUoqG60MbKkhggjr9L6C58Vw9d7AE90/9TWGdIy
 K7XZTtE9OmKQhi4sFlbY4VewKJXX+3MUn8eYUNFpeQcuHTpJGiOTCWG7mhOeuoxZcV
 3dGyTMPMznxscqZQuVeOAvwk5ct/B+4s0D0x3bB6cxJtRHz+Xq3ksf2A9DQbwEhfMx
 hTLZcW/jcAT23N3HivWKNgl81zwUgBtbkYS0ATqHaTfrr50GACnrr3gZwIdFij8SkN
 KBoLW0EhWcF8Mm+3METCCzGWCQMM5r3ywci0BVLHYXyF0rvLeLSfkhtkp+sEEvC/9j
 3+jj9ThlSMEQg==
Date: Tue, 14 May 2024 17:35:16 +0200
From: Helge Deller <deller@kernel.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, deller@gmx.de
Subject: Re: [PATCH v2 14/45] target/hppa: Add space argument to do_ibranch
Message-ID: <ZkOEtODUIQekp7EE@carbonx1>
References: <20240513074717.130949-1-richard.henderson@linaro.org>
 <20240513074717.130949-15-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513074717.130949-15-richard.henderson@linaro.org>
Received-SPF: pass client-ip=2604:1380:40e1:4800::1;
 envelope-from=deller@kernel.org; helo=sin.source.kernel.org
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
> This allows unification of BE, BLR, BV, BVE with a common helper.
> Since we can now track space with IAQ_Next, we can now let the
> TranslationBlock continue across the delay slot with BE, BVE.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Helge Deller <deller@gmx.de>

