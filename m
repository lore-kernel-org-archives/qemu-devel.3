Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC95DC04FFE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 21:33:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6zlY-0007Q1-2F; Tue, 14 May 2024 17:32:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1s6zlR-0007P1-7e
 for qemu-devel@nongnu.org; Tue, 14 May 2024 17:32:50 -0400
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1s6zlP-0005fw-4Z
 for qemu-devel@nongnu.org; Tue, 14 May 2024 17:32:48 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 9872E6129B;
 Tue, 14 May 2024 21:32:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 150E0C2BD10;
 Tue, 14 May 2024 21:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1715722365;
 bh=EjTwI7jckM+EEk5+fWJz6LOQ3cdJIyjwhGdlJ0XOdBk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=lkxYSF1NXpPVXVDbIhS8spuhgNqVtzUGQN/iVfSWm9Gq8tw7rmKw2UGPY4ioGxohf
 3uLzNEIQZvSCIW6n/F5OSlB4VQMXwIq0eX3SKjcDszjG4LQ4R1/Ur5cjF/6gfzcaka
 6+he47a6/MOKl7R3NKR9RWIuXN41STQhFd3HrO5DbhcsrqP/wzxegTMTrqzjMnenCp
 HkkBmOn+3Q7fhA3UFVT1o/uSRXb0wwpi8PrQpoLC7z3q6LA6hyDDbiQifWee96/V+r
 qZILLUxGC3nTCQmycmStqPD/oaRfbdZmpG1H9lfE+VUhD67E28+jNzDgq1d64XC9Dz
 V3ZWHuZ856aUg==
Date: Tue, 14 May 2024 23:32:41 +0200
From: Helge Deller <deller@kernel.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, deller@gmx.de
Subject: Re: [PATCH v2 41/45] target/hppa: Implement CF_PCREL
Message-ID: <ZkPYefXd3wVffmex@carbonx1>
References: <20240513074717.130949-1-richard.henderson@linaro.org>
 <20240513074717.130949-42-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513074717.130949-42-richard.henderson@linaro.org>
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
> Now that the groundwork has been laid, enabling CF_PCREL within the
> translator proper is a simple matter of updating copy_iaoq_entry
> and install_iaq_entries.
> 
> We also need to modify the unwind info, since we no longer have
> absolute addresses to install.
> 
> As expected, this reduces the runtime overhead of compilation when
> running a Linux kernel with address space randomization enabled.

Ah! I was wondering why you tried to convert to CF_PCREL at all.
So, that's the overall reason.

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Helge Deller <deller@gmx.de>

