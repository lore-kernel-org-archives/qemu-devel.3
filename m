Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A790BC25B75
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 18:04:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6wV6-00033F-BT; Tue, 14 May 2024 14:03:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1s6wV4-00032q-4V
 for qemu-devel@nongnu.org; Tue, 14 May 2024 14:03:42 -0400
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1s6wV1-0000iX-25
 for qemu-devel@nongnu.org; Tue, 14 May 2024 14:03:40 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 6A38561227;
 Tue, 14 May 2024 18:03:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7097C2BD10;
 Tue, 14 May 2024 18:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1715709817;
 bh=8wl4fHSAhPVNLvUHbxl3UdHkfY5RyZ+IvWGGsY0jm+o=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=CZxRgQ0liQ12V6kGP5ICKBBISSfVwvXe1Od5FJt2ThyBVRT4OebeyK83QBEWlGTHU
 wmdeR4O+4U/rnrWlYqfsMdrCwVq/6IZjQ/Q6GSF40Kp24+K/B3w7Sg4Gxbda9YWgBT
 HjkSaDVBVlY/m7zB810JjoKvVz+WweeHa6IfsbU59KKmi8HDtlGTb6589fnAsgV3Ru
 Bv4egFNcScYLpfOiRTIqhd3Kjwfp5UtQn5taF07/Z4441dUyj94VdVSo6ou+QhtkGv
 P4E5izOermnR1OsR3aq9a/Ftrny3lv/zNTqOHYZOR6sVnLpUaZVxnYyTGKWv37DY5C
 hBokQHzjYQsRA==
Date: Tue, 14 May 2024 20:03:32 +0200
From: Helge Deller <deller@kernel.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, deller@gmx.de
Subject: Re: [PATCH v2 25/45] target/hppa: Use registerfields.h for FPSR
Message-ID: <ZkOndPm3PbDKqofg@carbonx1>
References: <20240513074717.130949-1-richard.henderson@linaro.org>
 <20240513074717.130949-26-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513074717.130949-26-richard.henderson@linaro.org>
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
> Define all of the context dependent field definitions.
> Use FIELD_EX32 and FIELD_DP32 with named fields instead
> of extract32 and deposit32 with raw constants.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Helge Deller <deller@gmx.de>

> ---
>  target/hppa/cpu.h        | 25 +++++++++++++++++++++++++
>  target/hppa/fpu_helper.c | 26 +++++++++++++-------------
>  target/hppa/translate.c  | 18 ++++++++----------
>  3 files changed, 46 insertions(+), 23 deletions(-)

