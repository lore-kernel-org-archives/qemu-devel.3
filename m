Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFB84FCB606
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 14:53:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyWXz-0008Lh-FH; Fri, 06 Mar 2026 09:53:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyWXx-0008KT-0V
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 09:52:57 -0500
Received: from qs-2003c-snip4-2.eps.apple.com ([57.103.86.25]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyWXv-0001Iq-Bv
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 09:52:56 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-7 (Postfix) with ESMTPS id
 9AF9C18000AA; Fri,  6 Mar 2026 14:52:50 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772808772; x=1775400772;
 bh=i5Z3FaQ3PZL5FR3YbtcTuPrIbZMkfcJmcFWynUHXOR4=;
 h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:x-icloud-hme;
 b=WnkjPzxScvqpos4EjwaHMFbUs+zUc6qbbJ6oMgV7syWqvvtIMgUb6tPXCf0jfyoUmARezaYQ+QI4yuIDckXW6OLFbeUDuZkGKEd3sQw5HePAi+gZR6iqiLdac/2CWJk5DgbhhdTZSaSOfLq7mI2CulR9PV6rJ7SBJqUSjUVYytyqJQPae2II9ejA6zsnFjtLyTzQlMJWMiCz1o5+BWsMyt1wwp7f3c/+A0xA8OFU2C5/2YhO7tpT1p6/f3E7qtdOVll66Zsl7KGIZsEFHu1C3viOMiH6rIDNrQn229+mcSGsq1O+rbh4QQQ60MqccajEmYjnHGou5JPNqyrDXwoeWw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-7 (Postfix) with ESMTPSA id
 DA58918000A3; Fri,  6 Mar 2026 14:52:48 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>, Mads Ynddal <mads@ynddal.dk>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Alexander Graf <agraf@csgraf.de>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v5 0/2] vmapple: making it work on the latest macOS host
 releases
Date: Fri,  6 Mar 2026 15:52:44 +0100
Message-ID: <20260306145246.10274-1-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: vZuz9HqkWR9hxzCh7s0xjQ9FWfpGe5pJ
X-Proofpoint-ORIG-GUID: vZuz9HqkWR9hxzCh7s0xjQ9FWfpGe5pJ
X-Authority-Info-Out: v=2.4 cv=TZObdBQh c=1 sm=1 tr=0 ts=69aaea42
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=PWwuWOSklEzM4Y2Y:21 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=hPhA3OiWSYROIRs07GQA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDE0MyBTYWx0ZWRfXzquykPTaOEYb
 k+Kezbqhk6R72a9G2yNn70XTJ0NWP4HVJfWzfTtghGptVreEkdc5EOzW9n5hDWbou7IgTpKeu29
 MP9q1X9D9z7a7xqeRrctyKPRsj1FS/fQJ5Vu4RTF8SjXmVfP1HSktayCI89mhA5lcG8R2tiEh1R
 xgTTUUXNxR5iwrlfVSjTV6C5NJhphoWv00MEVoId5u1xofeS7uDzTaOjasq5Hs08fPP2fK1NQ22
 eluMuOajtmKtrvH0mcUACTjBeN7eFhHqe+BNnJAMXb5oOJGFFkS1YBkCK5EqWsf7l/S2+MvKf6E
 e4RwkxFfr/skgDtgA8Xeb+k7QwvcIexapSeiH0ZiLEu4yDn9tiQpUE4QBaI0rI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_04,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030
 mlxscore=0 bulkscore=0 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 mlxlogscore=534 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603060143
X-JNJ: AAAAAAABkqDcuRfwvwOt2GeRjls6M6iGcb+Rw2Orpb9Lh5Lu4ZUFlr3cHRNNMeXp9lHUITQAvD09wVs3KThQe50o4bV4rkLxxt4Xr5hX5gRKTL8KTnlefk8IfkkcQcKNoZ9tkilegKbLEEjTZkvsdgdL52hb18ti8gcAO9xtmIgEIC2Ck0+hDOPChvINfPRRaDCUmzAv5xMncjyayW74dCDKgFGaUJUbKuezC+pNbvC8GRRIspqb4/NbTt5LoFI52TMmgTWbVBu6xP4Uqy5k6bd4XP6Br2y7P3KUozH4Rft7rxoCwvSk05lMO1zahjxZtkBa1IpvX65RZbv75jYj0+xB/T5J50g8VX0Pu8KNCmnhk5nB+LdafB+FJLY8gObZPSoqO1H44SFSnB5JIDyE/sZlpCWuPRzLHJW5v8ZGaKCQ5Nm8kAjSDcdMWrnSVvn3RilwDOYhAQzYfgc0E5E0nd/Y7vlvgwaOdEg/5+MGZqitMML8GDUfeHYAvSwEU3CfzHJzCSmtF1Y2QUXnUClxpQues7m2G8yCjCVePxdBIfrBld5VKVL9L+hTZzhTAz4jBbq9tgw6CQfiUutudIVskp40xK4tPBLSTsWvtEVYCfW6If+PFz7bU/Rk0Qr4SFMsZQdBuKEy33JHHQJtx/Dn0++M1NafdAiHi4xdT/JeoQF8GDIvjg/gwFIqyDRNLUm702yA0cZ+FHaQotGnBc9ek3A2rkunmKDdM27H5snFM5vnMmtjk81N1RZcQ9bBpb1Hzg==
Received-SPF: pass client-ip=57.103.86.25;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.411, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.679,
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

Support for newer guest OSes isn't part of this series.

v5:
Address review comments and rebase.

v4:
Rebase and resend without the RFC tag as I didn't get feedback.
Drop patch 1 (version I posted was incomplete anyways). Last patch isn't worth it too tbh.

v2->v3:
Remove the Apple M4 support workaround part for now, to be part of another patchset perhaps
Address comments

v1->v2:
Remove some lines that shouldn't have been present...

Mohamed Mediouni (2):
  vmapple: apple-gfx: make it work on the latest macOS release
  Revert "hw/arm: Do not build VMapple machine by default"

 configs/devices/aarch64-softmmu/default.mak |  1 -
 hw/display/apple-gfx-mmio.m                 | 62 ++++++++++++++++-----
 hw/display/apple-gfx.h                      | 18 ++++++
 hw/display/apple-gfx.m                      | 43 +++++++++++++-
 4 files changed, 107 insertions(+), 17 deletions(-)

-- 
2.50.1 (Apple Git-155)


