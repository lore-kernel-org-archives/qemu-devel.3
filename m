Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82453D3940B
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 10:06:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8Ew0-0006sx-B1; Thu, 02 Apr 2026 06:05:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w8Evr-0006ol-DV
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 06:05:48 -0400
Received: from qs-2004h-snip4-2.eps.apple.com ([57.103.84.75]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w8Evo-0003la-EL
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 06:05:46 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-10-percent-1 (Postfix) with ESMTPS id
 C69863000125; Thu, 02 Apr 2026 10:05:39 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1775124342; x=1777716342;
 bh=zX7DSrQHeZtUblbih3QinByPvmcPTArQFV53928sTm0=;
 h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:x-icloud-hme;
 b=FL8nl9WUwm+j3i+G6R9VPwTH+jRj/LZBbmV6CQbwK0eS+deectby54plkTE9mOxHHsLwykWx2g11Wm5w8QhFGc/Wx+mcgrOX+qcbXoun5Km/WMxl2Mrp4x/qiXhUpz/jgHH44HIfRTALX/z/A5G7u59FfAxSzkmQlOVoumeslOOYqMcga42P8pcZ+y0BSR5ReJsgFfFuK88d1LhHwQe4wtiEQP2mW8lhSvKWmp0aWCX+iERCEBx1BYjwXX0F28oMh9y5k/Y4/I/JQ7jKUIswmr2YHztlouzWml2S+zkgGV1U/dVDmNu5Vb1x+P4n8mLZbjFxiIdBFb23XMn9mfDamQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-10-percent-1 (Postfix) with ESMTPSA id
 09EA230000CD; Thu, 02 Apr 2026 10:05:37 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 Pedro Barbuda <pbarbuda@microsoft.com>
Subject: [PATCH 0/2] whpx: x2apic emulation for kernel-irqchip=off follow-up
Date: Thu,  2 Apr 2026 12:05:33 +0200
Message-ID: <20260402100535.42960-1-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDA5MCBTYWx0ZWRfX57D/r0rVscRB
 /8yd10ZUuor9rX9HQ1sOTEKFbRwbbuk1eVSFLOLfj5Do0xMOb/y7/qMTB4mRu0/q3ontHg0Vvwm
 LwqYrhcKmxj4UIdDjFKpjAnvliy0a5okG75ww+Rp9yZWtslJr5V4Ez2+F/c+/dNNK9ykvPCYjNW
 0xFLXutBdv2oYiJ2WfZjPNSOixdTYUL7PGBJcCbcVj6gHQq+FirYzfk92hpm/UsjZa+ozAQYhu6
 M8wnd5FoxrdyRYUk+wL+8E80VM0Xtuu94tCorfKp1xhJ/jt/l4AFkY75J78v1OBqJTMgPsNDxe7
 jf13Wbh2I0CYisW0z+Y/YF/eD+IIU9JHR50cqPQFL0yn0VT6sjYp2ZG/TLzHRs=
X-Authority-Info-Out: v=2.4 cv=MLttWcZl c=1 sm=1 tr=0 ts=69ce3f74
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=GaQpPoNlAAAA:8 a=G0_dvICC93hMFENa4wgA:9
 a=QEXdDO2ut3YA:10 a=xF5q_uoM5gZT5J3czcBi:22
X-Proofpoint-GUID: BTqj5MlK3TlsWtw8gw3REnG85tPp53eo
X-Proofpoint-ORIG-GUID: BTqj5MlK3TlsWtw8gw3REnG85tPp53eo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 mlxlogscore=561 mlxscore=0
 malwarescore=0 adultscore=0 bulkscore=0 clxscore=1030 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604020090
Received-SPF: pass client-ip=57.103.84.75;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
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

Small follow up for "whpx: i386: x2apic emulation for kernel-irqchip=off, feature probing"
, depends on that series.

https://patchew.org/QEMU/20260402053326.23402-1-mohamed@unpredictable.fr/

Based-on: <20260402053326.23402-1-mohamed@unpredictable.fr>

Mohamed Mediouni (2):
  whpx: i386: enable x2apic by default for user-mode LAPIC
  whpx: i386: reintroduce enlightenments for Windows 10

 target/i386/whpx/whpx-all.c | 71 ++++++++++++++++++++++++++++++++-----
 1 file changed, 63 insertions(+), 8 deletions(-)

-- 
2.50.1 (Apple Git-155)


