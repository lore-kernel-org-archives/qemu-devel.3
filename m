Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D140DC28B20
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 13:53:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzyWZ-0000Ju-2Y; Wed, 02 Apr 2025 09:52:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1tzyWH-00008D-Uh
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 09:52:47 -0400
Received: from qs51p00im-qukt01072502.me.com ([17.57.155.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1tzyWF-0004bO-Lb
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 09:52:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ynddal.dk; s=sig1;
 bh=emBN9NkJBiCgg1V4uhxS2YHrjCK2dWMOn9FFfhjLBDk=;
 h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:x-icloud-hme;
 b=XCbYotU9FGGaBF1PmlgF7YmYSuY8s1Wqhw1EWMmgVFXQB/hnG4t6FPOmB1iXGs4W5
 G0Pok16a3/UUASxF+dI/OBLZAbTf10/528aj0HRSV7lpgz1xelRhMBz1TR1PEuMdi0
 M1a/7p0e/fckcHTBflDYX3ptfIV/Fv05EKU3IPv1TjwyOobc1/n9xhPxSkO3yNgw0D
 qbSvRyTd8nxZS2r4RW3U+EQiZLGY9B6MX12Hre8KHKHJKDpKZiGKsGw8JAqF8LgGKV
 uBYIAfL7jxHT3hOh3jWIK19/12EtFqvKlFmVePPkXkoL+7QJw0MOVojsgY3ph7S1JL
 vs4kWp3eQVi5g==
Received: from localhost.localdomain (qs51p00im-dlb-asmtp-mailmevip.me.com
 [17.57.155.28])
 by qs51p00im-qukt01072502.me.com (Postfix) with ESMTPSA id 994B86EC02F8;
 Wed,  2 Apr 2025 13:52:32 +0000 (UTC)
From: Mads Ynddal <mads@ynddal.dk>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Phil Dennis-Jordan <phil@philjordan.eu>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>,
 Mads Ynddal <m.ynddal@samsung.com>
Subject: [PATCH 0/2] Fix GDB support for macOS hvf
Date: Wed,  2 Apr 2025 15:52:27 +0200
Message-ID: <20250402135229.28143-1-mads@ynddal.dk>
X-Mailer: git-send-email 2.48.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Ga602eBLzBdCYQCMB_8sOH9rdSGrDU_Q
X-Proofpoint-ORIG-GUID: Ga602eBLzBdCYQCMB_8sOH9rdSGrDU_Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-02_05,2025-04-02_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=739
 phishscore=0 mlxscore=0
 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0 malwarescore=0
 clxscore=1030 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2504020088
Received-SPF: pass client-ip=17.57.155.15; envelope-from=mads@ynddal.dk;
 helo=qs51p00im-qukt01072502.me.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Mads Ynddal <m.ynddal@samsung.com>

In (recent versions of?) macOS, calls to hv_vcpu_set_sys_reg were failing if
they were issued outside of the specific thread that owns the vCPU.

This caused a crash when attaching a debugger through the GDB stub.

This GDB stub has worked before, so it is unclear if Apple changed the
behavior of the function in a release of macOS.

Mads Ynddal (2):
  hvf: avoid repeatedly setting trap debug for each cpu
  hvf: only update sysreg from owning thread

 accel/hvf/hvf-all.c  |  7 ++++++-
 target/arm/hvf/hvf.c | 27 +++++++++++----------------
 2 files changed, 17 insertions(+), 17 deletions(-)

-- 
2.48.1


