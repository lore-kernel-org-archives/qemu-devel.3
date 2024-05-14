Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 074A4C04FFE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 20:23:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6yfU-0002Av-OP; Tue, 14 May 2024 16:22:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1s6yfS-0002Af-NA
 for qemu-devel@nongnu.org; Tue, 14 May 2024 16:22:34 -0400
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1s6yfQ-00078j-BE
 for qemu-devel@nongnu.org; Tue, 14 May 2024 16:22:34 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id B4EB4612FD;
 Tue, 14 May 2024 20:22:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1DA8C2BD10;
 Tue, 14 May 2024 20:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1715718150;
 bh=k7WURb36pYiAODExNA/OmcTrmL47ZjDuKIOjjWpqATE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=AeUCktDcoe0WHKL5ztWlGlMffoYlAgqh437qBPgYJeEqClOGsFklveG0rj1vL0+9i
 xIBO3rYQRRleYLsTIlpiKSAwpSSNt2dKhD9w8MmNcNUONH3wDVAMEyuKkW3qYHGmQ9
 kQIGaDA2tuvh9EUN3JEnzSq8fTq4lL84e/LRDoNq/JOaMgE1WukIAXcWxkTnfzXx76
 2r4mM7R4eNREE6pe970vnERg9jsXmkL+nzMhKCf9TTTNPKojEiQX1LW/1yoB59sDfY
 bM+ARl8xKRFr7I+pqW0D59+qEdpYB9uIw0BymfvCQZN8h9cxJ6fVmdPf0pg8hcQker
 1Q86Bo+3PsDYg==
Date: Tue, 14 May 2024 22:22:26 +0200
From: Helge Deller <deller@kernel.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, deller@gmx.de
Subject: Re: [PATCH v2 35/45] target/hppa: Split PSW X and B into their own
 field
Message-ID: <ZkPIAno5vS_ArhYQ@carbonx1>
References: <20240513074717.130949-1-richard.henderson@linaro.org>
 <20240513074717.130949-36-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513074717.130949-36-richard.henderson@linaro.org>
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
> Generally, both of these bits are cleared at the end of each
> instruction.  By separating these, we will be able to clear
> both with a single insn, instead of 2 or 3.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Helge Deller <deller@gmx.de>

