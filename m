Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D08AA1125837
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 14:12:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0KIO-0002OO-QA; Wed, 11 Mar 2026 10:12:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w0KI1-0002N5-CE
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 10:11:58 -0400
Received: from p-east2-cluster1-host6-snip4-6.eps.apple.com ([57.103.76.99]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w0KI0-0006Lx-1U
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 10:11:57 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-2 (Postfix) with ESMTPS id
 5C23118000B5; Wed, 11 Mar 2026 14:11:50 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1773238314; x=1775830314;
 bh=4icJ72AU1OOM5tOrqHPkWr3ogIPSAmTNwYbIOrNfOTo=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=YthNJZf/aMkp0lAUOtfcKWMtpxZDucsbfxvfkkNFW7n15JGGqqwcXs0WETwOYS3lUeryHVDTYA/kQZ/PYmzgVH0o8PzjzOLeskWtLfGJsMLe0L35eGrXKhGsNPaaYg8YoMMcIPEYyi3IuConTdtJrZKwqTKT8HY/g/r7a1jzVM4bQAMM4dzJHtH/dwI8rjY2d7IoXhpyx+YJDLDr/AzoO05EhHk3/UcWzAM5/m5OAxb3vz6r4ySfSBs94W5FdewWaP1SZrTziXbAv1qyqfXn4XzNOxc0Fuxs75OHHFgItYiMqa5B2IqzTPC7tYQifF+lYVVqxYo7e4dlhn76L3HoZA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-2 (Postfix) with ESMTPSA id
 D084D180031F; Wed, 11 Mar 2026 14:11:42 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 2/2] whpx: arm: add EC_DATAABORT assert for
 WHvRunVpExitReasonGpaIntercept/UnmappedGpa
Date: Wed, 11 Mar 2026 15:11:38 +0100
Message-ID: <20260311141138.30267-2-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260311141138.30267-1-mohamed@unpredictable.fr>
References: <20260311141138.30267-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: lQfZ6uG6xf6Q65Tk0v3dt2EIkHhdEIai
X-Proofpoint-GUID: lQfZ6uG6xf6Q65Tk0v3dt2EIkHhdEIai
X-Authority-Info-Out: v=2.4 cv=f+ZFxeyM c=1 sm=1 tr=0 ts=69b17826
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=iF5FY4ceKisILDQj2E8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDExOSBTYWx0ZWRfXyXkotXBnEPau
 7g8z9ajQfJvpXeXky3jrI50cYpSiT+z49XZBgHoc0yw7xo2h/o049EbpcmehrGd/PeT3fuPA+6b
 OnypQzrx0huKHBN7/llWQV010Tg9sruTQ+Y8Rat2WoLOKE6PoC8zUIZr4zN5LR2tiDAyrNTp2FO
 xsM6BW+AzokrV2mMPGovGBE1gu+9DN38I+o0juNT9hF1Cs7ExDRUFQwnVRc+lvRi4HbjKTuVnOf
 yS5e0qu+WflFAa+Kzjc8lnrNHyGLyB3TrCQ/vyMhGTWCWIuMWHCbGULbfEY5iRLYwK/msjHesps
 BF4wyBHZkJ058fr/2zMHnA/DyPNs4XdAHcgu0eU8kDSkiwza8SWfMGhk1ienOM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_01,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=659
 suspectscore=0 adultscore=0 bulkscore=0
 phishscore=0 lowpriorityscore=0
 clxscore=1030 mlxscore=0 spamscore=0 malwarescore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603110119
X-JNJ: AAAAAAABcIlyO+oxHWNVmjj6ne/mG5AAFJFDZ9WtESn3CJw5ZuHW1nu+6dJT46TY6tS/4x5QxUXP8r2Gsh9aFic3NNIdsMZdU781IjtKb7qeHGcH8ujlpzVDV6jJDlUwStcZMG1c0NRUiHyWBZBrLJOf44DOButaZEswhmUPfPnx8JU4gk6PhN/zirwekHPw3caVZKENY1yqA4df15ajH/seXimGCPZSjXo4qjmZ1GfPXLMJxTa45w4oT7hiGst02A82C8YaqoCkEHIYXgwfU5aBt/olyG8JqGZ/wz3/Yjq1CijM74cW8NiFSDeBHNG84DXcbrVvOSbeGRhW0li3ig7XwdRkHJG98qmnhWCZTrVzOi4Bsw7gfuNfAytVzzUj3gEQbz1n+nPBPOiqRibpP6v9uyOKbY3rDyR4RvGDTTO+uEVBGBO8PXNEidKKZuJzJDBd9f+/EvcPbjFNZJTurmnhsP6gEQT+kogpWhQaH0+VzBGWLU2xEqzBqCkMF8F1kO37ybwHLI3sTo9zRcKiByeaM9Le8EtSmtKC+rJe83QUW6D+L5tvqu9AW9KrdnoKXDZN7gOJRi+5U2PN+mDijQadX8ss9vmMfbA8FH0jJZZvZXh+z6qy1kUt1ZOs7Z/gv2sCwDY7olst/KyPl/lXlLRw6ZRqr4IJ4/UkYzc5McKFfe5itKawp8iRFFvniwM86lQCsxH5yWtcInpc
Received-SPF: pass client-ip=57.103.76.99;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

If we get anything else from Hyper-V there's a problem, so enforce this.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Suggested-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/whpx/whpx-all.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
index 513551bec1..3df60a950d 100644
--- a/target/arm/whpx/whpx-all.c
+++ b/target/arm/whpx/whpx-all.c
@@ -439,6 +439,7 @@ int whpx_vcpu_run(CPUState *cpu)
         switch (vcpu->exit_ctx.ExitReason) {
         case WHvRunVpExitReasonGpaIntercept:
         case WHvRunVpExitReasonUnmappedGpa:
+            assert(syn_get_ec(vcpu->exit_ctx.MemoryAccess.Syndrome) == EC_DATAABORT);
             advance_pc = true;
 
             if (vcpu->exit_ctx.MemoryAccess.Syndrome & BIT(8)) {
-- 
2.50.1 (Apple Git-155)


