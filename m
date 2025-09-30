Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20BF1CCA470
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 13:04:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3a0H-0001ME-JA; Tue, 30 Sep 2025 09:02:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cp0613@linux.alibaba.com>)
 id 1v3XEN-0007E6-SD; Tue, 30 Sep 2025 06:05:11 -0400
Received: from [115.124.30.101] (helo=out30-101.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cp0613@linux.alibaba.com>)
 id 1v3XEB-00031p-Lo; Tue, 30 Sep 2025 06:05:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1759226671; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=aUdLrT+iVgq95+lSK7IeL/ys+YabbNel8o+D0C30PHE=;
 b=nhHcVcyAk3u0zG0YxB4xHBobpyKoahjOt7Bt3CJT/biDObdHvHXqQhNXoDWs4IIhv3v9+MDnyAdQaMSrebNtwyAkSu2NCYz7osGC8GvS4nCt+XVeKRlf9HqQiqb7pPFu+8gQ8vDbnI/X1i0Mtzfb9jT9OfQlc97Gu0ieGv0F6FI=
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com
 fp:SMTPD_---0WpB.CLb_1759226335 cluster:ay36) by smtp.aliyun-inc.com;
 Tue, 30 Sep 2025 17:58:59 +0800
From: cp0613@linux.alibaba.com
To: guoren@kernel.org
Cc: alistair.francis@wdc.com, liujingqi@lanxincomputing.com,
 liwei1518@gmail.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 qemu-stable@nongnu.org, seb@rivosinc.com, tjeznach@rivosinc.com,
 zhiwei_liu@linux.alibaba.com, Chen Pei <cp0613@linux.alibaba.com>
Subject: Re: [PATCH V3] hw/riscv/riscv-iommu: Fixup PDT Nested Walk
Date: Tue, 30 Sep 2025 17:58:43 +0800
Message-ID: <20250930095843.62128-1-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250913041233.972870-1-guoren@kernel.org>
References: <20250913041233.972870-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.101 (deferred)
Received-SPF: pass client-ip=115.124.30.101;
 envelope-from=cp0613@linux.alibaba.com;
 helo=out30-101.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 30 Sep 2025 09:02:21 -0400
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

On Sat, 13 Sep 2025 00:12:33 -0400, guoren@kernel.org wrote:

> Changes in V3:
>  - Fixup inner non-leaf walking for 4KB-align.
>  - Add two Reviewed-by tags.> 

> Changes in V2:
>  - Remove nested param to make patch clearer.
> ---
>  hw/riscv/riscv-iommu.c | 141 ++++++++++++++++++++
>  1 file changed, 139 insertions(+), 2 deletions(-)

Tested-by: Chen Pei <cp0613@linux.alibaba.com>

Thanks,
Pei

