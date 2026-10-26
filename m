Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D798B606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 12:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PvfuxWVC
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLK4o-0003CR-6f; Mon, 26 Oct 2026 08:45:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kaloz@kernel.org>) id 1xLK4l-0003Bo-U0
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 08:45:19 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kaloz@kernel.org>) id 1xLK4k-0001YG-BK
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 08:45:19 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 874F043AF8;
 Mon, 26 Oct 2026 12:45:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8113E1F01825;
 Mon, 26 Oct 2026 12:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793018715;
 bh=tkztSN7txHgLtFviIMAb++hZDk6IvkxkCCNKEbaxXL4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=PvfuxWVCqwgKObybLOIMWhvwRT33AscFxgNxvU0UCsajA0Hu3AMDigXWFMB5u5Lny
 rVshPvko0zKE/n6rdbCp4jLXX5c/oLnNWYlKEAR0MgiSBQ50eY9Hrssgr20Yi5X5o4
 EhatGrWtqsCGTHjkmu/3jPn1fE2y2lW0SrKDF2sSkkJPnJnZ5cCLCQLA5TABxfm96q
 EMa9K5COoqR6B564WlMH2tFSmxLAkMSb4tpuEYcQkYHxH+uu6mcVtbAfI3McldCm3g
 XFZFci2DuGlSlx12wYnaXzE2fv/FzUbu8qoP6UioGDx6x/0L0bLAbbeKS6J4TRWlGS
 k3NGMlNa/3NkA==
From: Imre Kaloz <kaloz@kernel.org>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: Re: [PATCH] hw/sparc/sun4m: Limit max_mem to what the memory
 controllers decode
Date: Mon, 26 Oct 2026 13:44:03 +0100
Message-ID: <20261026124404.11019-1-kaloz@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <863cd051-1fb7-461f-aa04-64f941200077@ilande.co.uk>
References: <20260928112935.19447-1-kaloz@kernel.org>
 <863cd051-1fb7-461f-aa04-64f941200077@ilande.co.uk>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=kaloz@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Mark,

Thanks for taking a look!

On 22/10/2026 22:35, Mark Cave-Ayland wrote:
> It feels like this may be worth a separate commit, just in case there
> is any detectable behaviour change that needs to be bisected.

Good idea, I'll split the empty slot change out in v2.

> This looks sensible to me. My only concern is if anyone is (ab)using
> this feature to create super-duper 32-bit SPARC machines that could
> never exist in real life? Adding these lower limits would effectively
> introduce a migration break, which although migration compatibility
> isn't guaranteed with the SPARC machines, can still be inconvenient
> at times.

Fair point. Only sizes the real machines couldn't hold are affected,
and anything above 4GB never worked properly with OpenBIOS anyway.
The one default that changes is the Voyager, which drops from 128MB
to 80. Happy to leave it at 128MB like the SPARCbook if you
prefer.

Philippe, would you be OK with me keeping your Reviewed-by on both
patches after the split?


Thanks,
Imre

