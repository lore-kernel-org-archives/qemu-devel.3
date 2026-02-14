Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F0AFEF99FF
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Feb 2026 08:07:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrAfq-0002og-Qa; Sat, 14 Feb 2026 03:06:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rppt@kernel.org>) id 1vrAfl-0002oH-Su
 for qemu-devel@nongnu.org; Sat, 14 Feb 2026 03:06:39 -0500
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rppt@kernel.org>) id 1vrAfk-0003gB-C2
 for qemu-devel@nongnu.org; Sat, 14 Feb 2026 03:06:37 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 16B1440377;
 Sat, 14 Feb 2026 08:06:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A3D1C19421;
 Sat, 14 Feb 2026 08:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1771056387;
 bh=fdgtcRtwikKxnqnTtahBc6VNdcurB3e7aq8Qt62VdnY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=RiqnQ0YwbFCmi/UgGdKaC5NuHtK4q4fmvHnp6zwfakKnIrTXKPn2h1x6z8dFWKyLb
 PEt7yimS//1tDzC6x3kpVkTQfk/yUAh8L92tzn3AbRDRcCfsuPqw5acK7RMu+cj5Eo
 Dy8FlD5IDH7FUXYEoV2dghFKJxwfHIEHU5weAfcxKLOw9xm1CB3GfFeYRiaKP8ggkU
 arF2YL7/7hqPfLy2pQu6c8uxy31g2LOFrLEgheR/Lev9YbysToxBPv8oytFYEajUYG
 S9k6Mqamqns9rBP2+cewdf54gI006+24Zef53jzpiTixwES9gzV11Oj+vtFXbSWK8c
 qGnfjy+qqYDOA==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
 Cui Chao <cuichao1753@phytium.com.cn>
Cc: Mike Rapoport <rppt@kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Wang Yinfeng <wangyinfeng@phytium.com.cn>, dan.j.williams@intel.com,
 Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>,
 Gregory Price <gourry@gourry.net>, David Hildenbrand <david@kernel.org>,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 0/1] Identify the accurate NUMA ID of CFMW
Date: Sat, 14 Feb 2026 10:06:07 +0200
Message-ID: <177105633005.4117909.8876622423781862717.b4-ty@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260213060347.2389818-1-cuichao1753@phytium.com.cn>
References: <20260213060347.2389818-1-cuichao1753@phytium.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=rppt@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, 13 Feb 2026 14:03:46 +0800, Cui Chao wrote:
> Changes in v4:
> - Condensed the impact description in changelog.
> - Added Gregory's Reviewed-by tag.
> - Added Dan's Reviewed-by tag.
> - Added Cc: <stable@vger.kernel.org> tag
> 
> Cui Chao (1):
>   mm: numa_memblks: Identify the accurate NUMA ID of CFMW
> 
> [...]

Applied to fixes branch of memblock.git tree, thanks!

[1/1] mm: numa_memblks: Identify the accurate NUMA ID of CFMW
      commit: f043a93fff9e3e3e648b6525483f59104b0819fa

tree: https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock
branch: fixes

--
Sincerely yours,
Mike.


