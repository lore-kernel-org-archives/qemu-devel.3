Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85214606A31B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 09:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bq2ClUQG
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOXEl-0001de-6Q; Wed, 04 Nov 2026 04:24:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kaloz@kernel.org>) id 1xOXEf-0001ci-MT
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 04:24:49 -0500
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kaloz@kernel.org>) id 1xOXEZ-00009z-SK
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 04:24:48 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E5226605F0;
 Wed,  4 Nov 2026 09:24:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E8F01F000C1;
 Wed,  4 Nov 2026 09:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793784273;
 bh=figJHcuySpz1GB39yz8OG08hCGrIvr0KE0qkXXeikeo=;
 h=From:To:Cc:Subject:Date;
 b=bq2ClUQG2yvwM3B210ENRsZq1EgHhWdtJkXfe5GygkuwjrxZV2JN3rrnzy2c3q1lN
 r51hviD1JcXOtnbalAn6EEIv/3gx/HKdnf8Z3C67TyE/FJE+oHUlJYxfHxXeQylmp0
 whTMl7tpw8RShMsb76FrIIn2Q2EreSyJKveJBppuwFJoDPBumNFu7YowaZAsju2E3m
 6X/oYGt5G0CML03moMr73ofiNklJWOWFpLVIDx30uCeCIY7C7aihK/74l6+zHYN390
 95GIj5l/Y7dfpKBAJl/k3Lp+K+SZNHIdbvocPclxxdMPyPhBaC90OZ4LxOrA2iWaaW
 roHB9E1j7zyWw==
From: Imre Kaloz <kaloz@kernel.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 0/2] hw/sparc/sun4m: Limit max_mem to what the memory
 controllers decode
Date: Wed,  4 Nov 2026 10:23:14 +0100
Message-ID: <20261104092316.13052-1-kaloz@kernel.org>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=kaloz@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The SS-10, SS-20 and SPARCserver 600MP accept -m up to 60 GiB, and the
LX, SS-4, SPARCclassic, SPARCbook and Voyager 256 MiB, more than their
memory controllers decode. Above 4 GiB the sparc32 OpenBIOS reads only
the low 32 bits of the fw_cfg RAM size, so -m 5120 boots as -m 1024.

Patch 1 ends the empty slot for missing RAM at iommu_base instead of at
max_mem, which does not change the layout today. Patch 2 lowers max_mem
on each machine to the memory its controller decodes.

Changes in v2:
- Split the empty slot change out of the limits patch, as requested by
  Mark Cave-Ayland.
- Kept Philippe Mathieu-Daudé's Reviewed-by on both patches.
- No code change.

v1: https://lore.kernel.org/r/20260928112935.19447-1-kaloz@kernel.org

Imre Kaloz (2):
  hw/sparc/sun4m: End the empty slot at iommu_base
  hw/sparc/sun4m: Limit max_mem to what the memory controllers decode

 docs/system/target-sparc.rst |  6 ++++--
 hw/sparc/sun4m.c             | 24 ++++++++++++++----------
 2 files changed, 18 insertions(+), 12 deletions(-)


base-commit: 1c1f512972b25229d4b69ae7a3a7e5d7df30a6a6
-- 
2.47.3


