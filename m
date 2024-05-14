Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91473C04FFE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 20:17:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6yZT-0008Fu-OC; Tue, 14 May 2024 16:16:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1s6yZO-0008Dq-5V
 for qemu-devel@nongnu.org; Tue, 14 May 2024 16:16:19 -0400
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1s6yZM-0005TF-AN
 for qemu-devel@nongnu.org; Tue, 14 May 2024 16:16:17 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id D2DE86134C;
 Tue, 14 May 2024 20:16:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1837CC32782;
 Tue, 14 May 2024 20:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1715717773;
 bh=0w9F375nwxfO72+RnVy8XSroSVtUptNeyDU9/semxHQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=bnMz9i1y6xppsIJkMLJvNWYbI05OZ+o1J+4n+ZkSWXOWHAV8cIA1pi0W9BEWnxcsb
 x3ssRew5aArfP6Yr9GYN5XZXmRhlar62DcGxjTfC7XuBbNmv3205iQw8aGVwWyGOiJ
 Y4K1kwK4t2UGBc4CG7Wvp9H371WeeW039XLUH4ACEPXzC7w4TzOksHqbxS9QsA+HHX
 zYYTGG9fUDtvbjsbz/owbHZln2jyS2YNcgE8JgEFsPpzSgdA0LRXWISM4pFWhh2+dk
 Jdlhx0/88B5PmoSnuk0Q1ZhQAEsMJGKoVh3CoHkD9IkAS5SboEoNy+jlu4OqUNWV+U
 j15r+WO1A/VHQ==
Date: Tue, 14 May 2024 22:16:09 +0200
From: Helge Deller <deller@kernel.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, deller@gmx.de
Subject: Re: [PATCH v2 34/45] target/hppa: Improve hppa_cpu_dump_state
Message-ID: <ZkPGiQfiPBq5D3jE@carbonx1>
References: <20240513074717.130949-1-richard.henderson@linaro.org>
 <20240513074717.130949-35-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513074717.130949-35-richard.henderson@linaro.org>
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=deller@kernel.org; helo=dfw.source.kernel.org
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
> Print both raw IAQ_Front and IAQ_Back as well as the GVAs.
> Print control registers in system mode.
> Print floating point register if CPU_DUMP_FPU.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Helge Deller <deller@gmx.de>

