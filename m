Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2317F419BB
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 13:30:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wD0JJ-0007Ex-3W; Wed, 15 Apr 2026 09:29:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wD0JH-0007EE-PQ
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 09:29:39 -0400
Received: from pv-2002f-snip4-11.eps.apple.com ([57.103.64.231]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wD0JG-000493-Da
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 09:29:39 -0400
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-11 (Postfix) with ESMTPS id
 7F2E31800373; Wed, 15 Apr 2026 13:29:36 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMHWwJACUgDTUQeDx5WFlZNRAJCTQFIHV8DWRxBAUkdXw9LVxQEFVwFVgZXFHkNXR1FDlYZWgxSD1sOHBZLWFUJCgZdGFgVVgl3HlwASx1XBFQfUxJVHR0LRUtAEwRNEwVSB11NVg1HD1geXBQXCEVDXgheH0wcHQ5YBhIATQoONgZZBV4JVgNDBTYSFF1FRgNHGVcUUBtHDFUHV15fChMAXg8PTAtIAVsHXwNFCEsBVAVdHEUBQARVGl4fHVYQUgBSD3IFVwhBCFMCUQRYGl8IGQ1AThkMSh1SVlEFSgxcAGgPXR1YEV0=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776259777; x=1778851777;
 bh=Yl0JdZN7K1dS8wO/C1JQWlTRVuBjUIl21ZEIdD6QW+U=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=EB2mW5rPkbrcbeyRDEkzzsH1MNCaiXVyD1X/XVus6MPO1vA7LCt8cu0bH5JVP2nBFU2vTXge7+A938RGc8sSk8rG3Q02yXW6qDOF0DygKswlrKRY0yTgkwqdDfmS2sYOgMjvu5CEt/2dw7xNdwwxmun58gqq1ZLveo5iVkyQOSrsQnwN3uPCrsKj/tWXGN3IayFQL9OidrKsQBe58mevrcm5K9/TZMM7ys8aqAgmZu4Jm+V+IGp0jblwjEbHOIzxqoTlcOQ+Hl9gnV69hRYzSoHT64ciVC3u8Q+ZpPPnZ2sMChWi7mkPawAwWsWufWZVU+WcxzhUZGywoBGvPr2MbA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-11 (Postfix) with ESMTPSA id
 45D911800110; Wed, 15 Apr 2026 13:29:35 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>
Subject: [PATCH v2 04/10] whpx: i386: tighten APIC base validity check
Date: Wed, 15 Apr 2026 15:29:20 +0200
Message-ID: <20260415132926.58878-5-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260415132926.58878-1-mohamed@unpredictable.fr>
References: <20260415132926.58878-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: _zBtD9wD8v6gs7VaIe4pV-ihNDJNy2fB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDEyNSBTYWx0ZWRfX2CI4k9tc1sDu
 Dq48e+Bk++t20P/pkBf3jwzBzBxDbmk7rWP7PbGQ86XFk5/qGnq49gTUQln11JacYoMasVyz9Do
 Tkz4brFD6Py05tqwVS9qAaG7rI8WaPJS/IF+C30zWBdt/06voPivJlB+pq5XUXwuWgkZ2DupEOL
 kMt+JZjpQ1P5Drobwdde0q41RHUGwT6p5jf6CIJ/doNtd1JVq/Gzodu9OItOVVu7MKVrb5iL+Us
 S11AFNBArqruT88frO+vn4oOEdVMVKZOxFhenyjam89NGs/WU6UQ/wYz7BF90y1jnMwXXX6aoHS
 rC+rq93DEG8MZEiu9upaRQthfdRQ4ufxPnDJE8ui0oydKGmCZ1lfVWStxCrGkM=
X-Authority-Info-Out: v=2.4 cv=Cu2ys34D c=1 sm=1 tr=0 ts=69df92c0
 cx=c_apl:c_pps:t_out a=azHRBMxVc17uSn+fyuI/eg==:117
 a=azHRBMxVc17uSn+fyuI/eg==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=uh2sygq7LFHjsVUyvz4A:9
X-Proofpoint-GUID: _zBtD9wD8v6gs7VaIe4pV-ihNDJNy2fB
Received-SPF: pass client-ip=57.103.64.231;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.pv.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
index 73066581d4..6c39168b06 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -1993,6 +1993,9 @@ int whpx_vcpu_run(CPUState *cpu)
 
             if (vcpu->exit_ctx.MsrAccess.MsrNumber == MSR_IA32_APICBASE) {
                 is_known_msr = 1;
+                if (val & MSR_IA32_APICBASE_RESERVED) {
+                    x86_emul_raise_exception(&X86_CPU(cpu)->env, EXCP0D_GPF, 0);
+                }
                 if (!vcpu->exit_ctx.MsrAccess.AccessInfo.IsWrite) {
                     /* Read path unreachable on Hyper-V */
                     abort();
-- 
2.50.1 (Apple Git-155)


