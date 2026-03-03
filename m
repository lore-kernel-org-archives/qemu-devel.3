Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC421EDEBF0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 20:53:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxWim-0000cV-L0; Tue, 03 Mar 2026 15:52:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vxWid-0008JF-Qa
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 15:51:52 -0500
Received: from p-east2-cluster3-host3-snip4-5.eps.apple.com ([57.103.77.156]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vxWib-0001WA-N7
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 15:51:51 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-10-percent-0 (Postfix) with ESMTPS id
 711A61800140; Tue,  3 Mar 2026 20:51:48 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772571108; x=1775163108;
 bh=gBxNQ3TjAYTeogiJbh69cd5jTUQ5SWnQGrtlwC8PRBY=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=feYb3wJb3G1znL26OULT+J6QWRYfVA1mMCfng2vtH6SpoxWLgzVTu8Tu6bhDn7VuMiWPEYPcJQ7udCYMH8Yluk4XhABRvRGXIuDBxA4mMMYYYzW7ErvbzGEMif8tfwEF/RwDs31dKZJWpsYi5FHmmUmukHb0O6E5gJZmvIOod6PkzVqlEDPVdnF6qiJ3kAghyZ6LcaHa6xb5FYV6P5YhsqZvgVJxEsQNMv9Ml6FccgLMjLKH/Z19F/FxI3+6sEILpklsBIs8VYs1HybTCDs2p9PiN2/KY2LXRh0acCWLN07zUJQgy2XMatoW9PkK71B3jRCjF/qh0gwM0L7Mt30ygw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-10-percent-0 (Postfix) with ESMTPSA id
 A1896180065D; Tue,  3 Mar 2026 20:51:46 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Pedro Barbuda <pbarbuda@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Zhao Liu <zhao1.liu@intel.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH v4 3/7] target/i386: emulate: LA57 fix
Date: Tue,  3 Mar 2026 21:51:34 +0100
Message-ID: <20260303205138.32450-4-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260303205138.32450-1-mohamed@unpredictable.fr>
References: <20260303205138.32450-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=ZN3aWH7b c=1 sm=1 tr=0 ts=69a749e4
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=AJrqCOfVdMXzVqk_6-kA:9
X-Proofpoint-GUID: 56s56PR42YWj-Xmplcibw13BhcL05A1d
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDE3MSBTYWx0ZWRfX469etj//BEv5
 PxAmjr1qZAcIb5DYnsPqVUzpiyYw8FHoZEHNnjt5IswyNIokwK9Rsqg2zJzHaOFP0m52tf9KlqW
 n3axp0H4rxNgouGYzhm3MVB5/Vd8gIljsLlQNZsfZJNDBEBkYmGqMrozX0kXyMZOh2fjGgJVMmP
 n9OsH3fbdamAD6PdtnXvR4Tn154VcEACgjCUi3KwAA2NG+NqhNmAX/5XK7hbRCqn45D5mtgKaGH
 Zb8uazGjuaEeS6Yiew2yxt6UXqcnH7pqRTOA424+pZ+qx2LQb7D83V2TgBMU2Wc9XrOukyjhc31
 XZ2ReY4KGbovmTdwLRmQBM5OlKKhTAR06qbWHUGaeBkkAIrd7HpCIeyXxxlWpU=
X-Proofpoint-ORIG-GUID: 56s56PR42YWj-Xmplcibw13BhcL05A1d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-03_03,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=896
 lowpriorityscore=0 spamscore=0 malwarescore=0
 adultscore=0 suspectscore=0
 bulkscore=0 mlxscore=0 phishscore=0 clxscore=1030 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603030171
X-JNJ: AAAAAAABmkP7pxwbdG1+Uv7CmH8hLdgQGOdsuEYrfqNdAzjptyRX28gOiKObnRhdj/OkFfZHg+RCXYr/94T+mPgCHsM8OAMsrIP57mfMCWXyscXNXuALJDeTKM3E+00QvNFlH6Y821LZzqFFJLkTLSxKhYMr+weIZxKfg1KMdQY8tMUarW3gliWbk3q5F5GtTmuYDawfnDpUa1QiUnC3RYLbYeYm1R5BEYEbo0tr8ySydUVZGpG030RhjeI5iASSfqBfhhmLrOSwiIxCRzsjGQv9Wm5p+50Y7g0Ms3yg6yYsezV0sDtcStM63UKmT7XnIXgG24EQsfH40vygEr6+Z8/nJksZqdJzvSZ5XayJvCcnNQ2vzBo+5AlnlgTpVstOBk3dYkcQoMg0ZY8pXPLESn43ZsNHdsnyQzJVdgoCrmlvsikVOBv9wMUW8zLOntGN5vNTlBI6dgfIVnTdC3ToqWuBhp7SmBXbTGciEtkulGObCKjaJ8OE+opT/gb90kEyeyUbHsj7PRrhs4OKkFtTc1hmnvrfVyDRx0QsWJ80b8q+yMmxwU+mNeOqbntfq0bVbSVpsHWOKt8F4dsS0NIZh1Iu0Q1fw2YrgtnUPl11Yinonq8Iy1/p2Gb6fS1UfSK6Zn8KW3jhXEgu7IzMtLfGAiz2YlaKyyYl2OAl1VXVPpFvd4uk3ujy2Vj6teg6khKYY44Q8GnMvFbhbl2g7XQVomHQ3FWbQAuxMR4lxXcCDyJVM5NR3ZEgUL3S6Q==
Received-SPF: pass client-ip=57.103.77.156;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
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

Seen on a Sapphire Rapids box with LA57.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/emulate/x86_mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/emulate/x86_mmu.c b/target/i386/emulate/x86_mmu.c
index 8261ca1635..4e39bae025 100644
--- a/target/i386/emulate/x86_mmu.c
+++ b/target/i386/emulate/x86_mmu.c
@@ -56,7 +56,7 @@ static bool is_user(CPUState *cpu)
 struct gpt_translation {
     target_ulong  gva;
     uint64_t gpa;
-    uint64_t pte[5];
+    uint64_t pte[6];
 };
 
 static int gpt_top_level(CPUState *cpu, bool pae)
-- 
2.50.1 (Apple Git-155)


