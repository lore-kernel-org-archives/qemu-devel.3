Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2819FFD0046
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Feb 2026 21:48:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwS9l-0004D8-2F; Sat, 28 Feb 2026 16:47:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vwS9d-0004Ak-KA
 for qemu-devel@nongnu.org; Sat, 28 Feb 2026 16:47:18 -0500
Received: from qs-2005d-snip4-11.eps.apple.com ([57.103.86.171]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vwS9c-0002Tv-5G
 for qemu-devel@nongnu.org; Sat, 28 Feb 2026 16:47:17 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-20-percent-1 (Postfix) with ESMTPS id
 3D9BC1800133; Sat, 28 Feb 2026 21:47:13 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772315235; x=1774907235;
 bh=gWqREj2PmGRoTAKiY4qI6uX1E9aTXQTeVV/xFA3kCyI=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=WMRNYrOtqWt68rKvbN9nHLNLlGfoh7zFOBjCt+vNZx4rzUJp8wE7FLI0byFZo1pCcZcWi+7sPm7zLOZ3Ahv79S6NX3pFW14MoCx0P4PrZJxyGomdKbjx718ygEWzS3SOOnVdgfUUl2NURnb3DAjLh7adCLAeXWyMrqW5UFTDc9yuvdQZHC9BHoF4hl28J/aSAVqu90hbCixJLuDiFFumqzszo2hrMgqmFoQeo3dw+xQ9huS1Seh90ZbdksycIHhMhQNIQWbr6QlG7DmOMXvCiCTMGABXe/IzNj3p/5aSc8XJpXb3YKDoB3LcQ82sMbB1rg9Bqy//yfwRSPjhV7hr8g==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-20-percent-1 (Postfix) with ESMTPSA id
 B7B001800195; Sat, 28 Feb 2026 21:47:11 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>, Wei Liu <wei.liu@kernel.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v2 4/8] whpx: i386: warn on unsupported MSR access instead of
 failing silently
Date: Sat, 28 Feb 2026 22:47:00 +0100
Message-ID: <20260228214704.19048-5-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260228214704.19048-1-mohamed@unpredictable.fr>
References: <20260228214704.19048-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: PtqXedeKtml2sL2rEx6S8IIp3zLmpsJ9
X-Proofpoint-ORIG-GUID: PtqXedeKtml2sL2rEx6S8IIp3zLmpsJ9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI4MDIwMyBTYWx0ZWRfXw3Gouq/bC27/
 ls069K7AFcsJkRYgY8mpdPw9IP7oFWz7g8NcARItYbRDlW8cpGiuwxacCZcydiZFFOjIvkyiMKg
 hWRKJ0FpMj0n+seTpYsDVk1BEEzkbv4wCcczJRxOZA3VvQdPMK8uAcooz4TaGPdW2P6rNbwkE3u
 seLY+xFTGoEdEPHkc7g93I9he8nk1TCSkHG+/ozZS/wEhZ0j08+Y2yKUz+tClODGr7+1jq+qbi5
 0Es4s7rau6MDMAWHNDt2XruLWO4BsH/BKcuU73lmRTJMt/wzBvp0aBH7f4/dXaDDNZmqDAgaj6h
 sIex1l64IwMFEQuXXZQhNCPVFiLiHZTcMsyR3cRt0t86VXgfTwzHmZme192HyM=
X-Authority-Info-Out: v=2.4 cv=Rs3I7SmK c=1 sm=1 tr=0 ts=69a36261
 cx=c_apl:c_apl_out:c_pps a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=qc3z_Y1wnV_HfSY8uEAA:9
 a=zZCYzV9kfG8A:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-28_07,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 bulkscore=0 spamscore=0 phishscore=0 suspectscore=0
 mlxlogscore=643
 lowpriorityscore=0 clxscore=1030 adultscore=0 mlxscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602280203
X-JNJ: AAAAAAAB2a6drLWsSTWK+d2ycSEC91tutEgetwWbbWOO70nGU8H+c22LkIY8pTv8rmAKXwtWK4214k1I1xqSaiUvpqKWuovxMa6KZFiywqcjko/I/k3SAS0PgQkg7fw2WxH0/wqu0KwbWCCDYUseqG2dodepkHEw2fyD7f+lAw10Y+pxn/UmLc3MVZb2J5PwlHjOlZMHl9RwUm56dOzDgwQRF3gqxClGjQaxcSn8/1cDZy+09xQJt65d7LsAomeYy7HjXJ4UqOIFza6vKK9Bjps+fEgj41qBP8rLrkKurd8KqInD+86g44eL/dXEPiguoegSew+kaDKwRzrbT8GFVpZ6l7IbjFPgQrGkQDW0RA/If3FAWOLBDlIGgRSAw5kBmsUkEutAEsERSKn30W5/ewbKYogcHml1GY7NTXXi0FrdZB51fud/Mi49F0qynAsXIOLfl4XTb63caUxlqoJjhs4P1k7X9kjUEXrj3ljWVqoExVMdswJE1VeKx7fj4YcFHRyygR2sSvUAB2gmtkDBxjZnlWYCo4zJscxvZq4VHr1NjKh1XskPiKj41H8poG+y3EIhtgB8CqQcEkM5+d72G5FNs2Buh67w/wLGSv975qm90Jax3AYKg6v1v4MTPIvnU5GpCCvCxWlj+mPt2uZJJk09GESZfL463NHvefIIsiYWSydtkUku3MGrueMKLo/GQZ8ba7ehlCKGGZ0HonHb6MlGSw==
Received-SPF: pass client-ip=57.103.86.171;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.966,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.722, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index e7e0a50da6..5aa8baa4a2 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -1804,6 +1804,9 @@ int whpx_vcpu_run(CPUState *cpu)
             reg_count = vcpu->exit_ctx.MsrAccess.AccessInfo.IsWrite ?
                         1 : 3;
 
+            warn_report("WHPX: Unsupported MSR access (0x%x), IsWrite=%i", 
+                vcpu->exit_ctx.MsrAccess.MsrNumber, vcpu->exit_ctx.MsrAccess.AccessInfo.IsWrite);
+
             hr = whp_dispatch.WHvSetVirtualProcessorRegisters(
                 whpx->partition,
                 cpu->cpu_index,
-- 
2.50.1 (Apple Git-155)


