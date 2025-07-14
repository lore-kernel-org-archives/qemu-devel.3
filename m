Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CAD7C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 08:51:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubEsW-00046g-VB; Mon, 14 Jul 2025 04:49:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1ubEU5-0007Gp-7h
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 04:24:26 -0400
Received: from p-east1-cluster6-host10-snip4-3.eps.apple.com ([57.103.90.224]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1ubEU3-0006jb-67
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 04:24:24 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by outbound.ci.icloud.com (Postfix) with ESMTPS id 4CA0B18001E1;
 Mon, 14 Jul 2025 08:24:18 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ynddal.dk; s=sig1;
 bh=3HNl1XRwXoKAkX0cmOsH9ur/HirNWHt2xH48gEitwfk=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=OeBhwY8lp32/NPJT5uD5N3PW51c3p0a/DKCMr+Q8OmAZ0nzE9ggpmLZbPv2qDbY8CCm4i1W61SFEF5oclZCtuYKrdSxzbNj3qC9JEKO/SfaSFouGRlh6VDeeTGzNV24DwgLmc1au4fn/eIDFROHVnbSF1R5QLxqD0Cd5WIqRN/O2XvWv2zwHiRT6KRxHOr7Vbqie/pZxd83EUGAW5RBNX5ZkJTY30iaQ9oQZyVqW5hMQXfK7gplNHodnkO+uPFfqZ8TfSrFbgD5aAt7RTjfXnDf2rK8/oKsWL0yS1ullLg2fcg+z10U1MZoK0e0v6WtPpoUsggWaWyymePKED4gekw==
Received: from smtpclient.apple (ci-asmtp-me-k8s.p00.prod.me.com
 [17.57.156.36])
 by outbound.ci.icloud.com (Postfix) with ESMTPSA id 28F2D18001AB;
 Mon, 14 Jul 2025 08:24:17 +0000 (UTC)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH] hvf: arm: Remove $pc from trace_hvf_data_abort()
From: Mads Ynddal <mads@ynddal.dk>
In-Reply-To: <20250713154719.4248-1-zenghui.yu@linux.dev>
Date: Mon, 14 Jul 2025 10:24:04 +0200
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, agraf@csgraf.de,
 peter.maydell@linaro.org
Content-Transfer-Encoding: 7bit
Message-Id: <29299A8B-CF64-4D61-97E6-23EE6BA00E15@ynddal.dk>
References: <20250713154719.4248-1-zenghui.yu@linux.dev>
To: Zenghui Yu <zenghui.yu@linux.dev>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-Proofpoint-ORIG-GUID: Qwt-Be2CQ6vCJ5_Xa2GnD7zowCgZcubc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDA0OSBTYWx0ZWRfXyIgusRhrjhCb
 io/ERNEYQogNbnJo5O6ltdVfHOMME0VxJ2zX4+HE7g+dB+BqAxuKTn8Ze9YUVQQ8Lt+OR1FElrH
 VtwoG8cmM12sVe5AS+ttP5Z+zEu3nEM+Q3/QrthhMnxIF35daBJoPvuXhc4jqvDP9k//I66P19F
 gjwbcWZU7rbl+KQ1dM3pV9xZd7Sb1KMQdwztmrENccCzTd6E9tDCbzmX/4XO9ic9W3r+7e31fI6
 OubGU8q4tKSG6np6AZOfbWhgyuBpa9XSW9w/1iKafXBQ9lx16p7zxqVXqXS0jTyYNnE97gq2c=
X-Proofpoint-GUID: Qwt-Be2CQ6vCJ5_Xa2GnD7zowCgZcubc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0 mlxscore=0 clxscore=1030 phishscore=0 mlxlogscore=691
 suspectscore=0 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506060001 definitions=main-2507140049
Received-SPF: pass client-ip=57.103.90.224; envelope-from=mads@ynddal.dk;
 helo=outbound.ci.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


> On 13 Jul 2025, at 17.47, Zenghui Yu <zenghui.yu@linux.dev> wrote:
> 
> We don't synchronize vcpu registers from the hardware accelerator (e.g., by
> cpu_synchronize_state()) in the Dabort handler, so env->pc points to the
> instruction which has nothing to do with the Dabort at all.
> 
> And it doesn't seem to make much sense to log PC in every Dabort handler,
> let's just remove it from this trace event.
> 
> Signed-off-by: Zenghui Yu <zenghui.yu@linux.dev>

I agree. Unless cpu_synchronize_state(cpu) is called, the value in env->pc is
stale.

Reviewed-by: Mads Ynddal <mads@ynddal.dk>

