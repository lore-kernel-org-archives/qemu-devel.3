Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B026C04FFE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 20:12:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6yVM-0006BH-Ic; Tue, 14 May 2024 16:12:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1s6yVK-0006Ap-UA
 for qemu-devel@nongnu.org; Tue, 14 May 2024 16:12:07 -0400
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1s6yVJ-0004PJ-CO
 for qemu-devel@nongnu.org; Tue, 14 May 2024 16:12:06 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id E84B1612D8;
 Tue, 14 May 2024 20:12:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54A98C2BD10;
 Tue, 14 May 2024 20:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1715717523;
 bh=eyan/mkv6l2Qfk0/QbfrHZ4KF9wi1EIj9BBwGO5Jtb8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=XjQcaa2ENuhRr6AYeNMkJB1icNFLulBD/AZAG6fTeh+EoTA43JOC50wofQf8UCvVX
 lcTJiEabgo1Fw7NBY/fNKmxwgsZE9HKw8A91JMGgRQRu8TkrdDCT07wh5fkxDz94+0
 T5KU5YTM+egCKi416qd3yivuByDiSHg3mcqygBC7E0VDS8j+KwpGiLZtM7OuAfsZ0i
 UcETkdG82a+AQrVGPjpaFDbbbZ291GuyyOBcQDxzcUaoQ702JBjvz7IZmvMIoIx9gv
 8GFRpSSnVcnwy4RcJkC44VI/W/aW3bOfjTWtwGCtC1WaT+MdjaENYk5ODbWANC+g53
 UyB8oiJbpr3Qw==
Date: Tue, 14 May 2024 22:11:59 +0200
From: Helge Deller <deller@kernel.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, deller@gmx.de
Subject: Re: [PATCH v2 32/45] target/hppa: Store full iaoq_f and page offset
 of iaoq_b in TB
Message-ID: <ZkPFj4AUfzL5t0wZ@carbonx1>
References: <20240513074717.130949-1-richard.henderson@linaro.org>
 <20240513074717.130949-33-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513074717.130949-33-richard.henderson@linaro.org>
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
> In preparation for CF_PCREL. store the iaoq_f in 3 parts: high
> bits in cs_base, middle bits in pc, and low bits in priv.
> For iaoq_b, set a bit for either of space or page differing,
> else the page offset.
> 
> Install iaq entries before goto_tb. The change to not record
> the full direct branch difference in TB means that we have to
> store at least iaoq_b before goto_tb.  But we since we'll need
> both updated before goto_tb for CF_PCREL, do that now.

Does this sentence make sense? ^^
For me as non-native english speaker it sounds wrong, or missing commas,
but maybe I'm just wrong...?
Other than that...:

Reviewed-by: Helge Deller <deller@gmx.de>

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>


