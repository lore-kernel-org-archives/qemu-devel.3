Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7C61C04FFE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 21:20:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6zZB-0001iO-W3; Tue, 14 May 2024 17:20:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1s6zZ9-0001hu-Ll
 for qemu-devel@nongnu.org; Tue, 14 May 2024 17:20:07 -0400
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1s6zZ7-0001D5-2V
 for qemu-devel@nongnu.org; Tue, 14 May 2024 17:20:07 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 16B9BCE1331;
 Tue, 14 May 2024 21:20:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B5F9C2BD10;
 Tue, 14 May 2024 21:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1715721600;
 bh=f8w3DqZWItf2dEa4nyxbN5tccxOxGTk3URlmif37NwY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=DfBwqyYeO4eJCZiTNA4e9NETbgII9rhFzCRZizl2uFrTNNQzyuWWENeg3nYKf6aX3
 Rdeq2bFgyj9Q1PKZgJ6cFizaNHWEofevjz9hvLmZ9rp/jAHr8JlSaNxzNarcnb1nmC
 UN6BGZnEwEUfr9XMIQ90OIVj4OaSTw7B9gG8uLIvMgYWUsiUY2C5EY8yMUoBP3WvTe
 3gb898k81WuloOi1iJQjMt1RA1bJ2MhfpedxH2hbDQdVPfulAnwNCHG15Es8ct6nwH
 eDOpejJzFTnYH7sxGvUIHrE62tSVyLEY/iOhUY5lTfRWbDqDGkm07b0sX9suwhJLcU
 dbKAbwG9sy3Ww==
Date: Tue, 14 May 2024 23:19:56 +0200
From: Helge Deller <deller@kernel.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, deller@gmx.de
Subject: Re: [PATCH v2 37/45] target/hppa: Implement PSW_B
Message-ID: <ZkPVfHmxbCpYkUm4@carbonx1>
References: <20240513074717.130949-1-richard.henderson@linaro.org>
 <20240513074717.130949-38-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513074717.130949-38-richard.henderson@linaro.org>
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
> PSW_B causes B,GATE to trap as an illegal instruction, removing
> the sequential execution test that was merely an approximation.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Helge Deller <deller@gmx.de>

