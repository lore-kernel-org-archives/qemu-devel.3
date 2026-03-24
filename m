Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B45E1F54ACE
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 15:16:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w53Tv-0006oR-6i; Tue, 24 Mar 2026 11:15:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w53Su-0005tg-2d
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 11:14:44 -0400
Received: from p-east2-cluster2-host11-snip4-1.eps.apple.com ([57.103.78.84]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w53Sn-0005su-9j
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 11:14:38 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-7 (Postfix) with ESMTPS id
 D471618000A3; Tue, 24 Mar 2026 15:14:27 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1774365270; x=1776957270;
 bh=uAJ51zR7R15wIVlC530LHyYmi+UTEudXXGcCdwby+0E=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=Xi8EI4ibCqtLsDfRxicfqt0cuC4WlO45WmhfYAdf69vac5IRrzyWPLxANMd2IunQHUPq20JcqBntld4e2JQoJnw5hCEfBarLU/MhnCBCrehEa4Wl+XSVogssfeJNsGGry6+T8vvS0BppJW7f1evzMZewf5IVb9z2hp0Hj4cONDTz5GYmutZsTBFqLKJQy//n3DarvcJqHWmWk9GpY2PBjM0RzacXDM2uTJHoRE+iF4EEgOjzJxuF0dJp1hJHZ0ButxsmiosXKF/GHpOPDlZHU1R60elfIjM6iuUpzfCYpYYEngjqP3YOq9TTq9P+T+lGRoFRoZoZse9nSTOH2fES2g==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-7 (Postfix) with ESMTPSA id
 1C7C91803135; Tue, 24 Mar 2026 15:13:45 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Roman Bolshakov <rbolshakov@ddn.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, Wei Liu <wei.liu@kernel.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Pedro Barbuda <pbarbuda@microsoft.com>
Subject: [PATCH v3 05/12] whpx: i386: don't restore segment registers after
 MMIO handling
Date: Tue, 24 Mar 2026 16:13:16 +0100
Message-ID: <20260324151323.74473-6-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260324151323.74473-1-mohamed@unpredictable.fr>
References: <20260324151323.74473-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: bG_tUR_rnm_VIMF5oAiwCZ2oZRT9PLLn
X-Authority-Info-Out: v=2.4 cv=K6Qv3iWI c=1 sm=1 tr=0 ts=69c2aa54
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=-4eTQGsHVEe5RITbnwAA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDExOSBTYWx0ZWRfX5zb0LkH7ZmxT
 TmCR/nT1Vbn2IyWxV+w5fq50N7Ln4t+KPR0gMI2OILebCGoJLdlhFm5HVsAt/4RM1Fa8+uicKiq
 ABvg6e4wMkVEms729pEAY1JHmNGBypqwPHZsd/6TRBlwWWzXrIjWvbwx8d5qFtAccaU982FoA4Y
 gojbz3q7rn9uS4kvJAguSLgPp6Mbt+9pVZ1G+z88/+6Zd0adfVr1QGWzUvKTPefpRexYKOv7Naa
 x+cDR5AOgozvRpCo6ZJ+FN4dg/SAlchbJtZQfELQ0Chj+M3B+RWVETM1GXtR7i87iWRi45k889D
 pqqD0Phr39+pmh4/rjctNtgJTPljlNXzQUTnPFo5U3CjYvdzZKns6h/C8i7lMc=
X-Proofpoint-ORIG-GUID: bG_tUR_rnm_VIMF5oAiwCZ2oZRT9PLLn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 mlxlogscore=830 clxscore=1030 bulkscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603240119
Received-SPF: pass client-ip=57.103.78.84;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 target/i386/whpx/whpx-all.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index c0c7ba9177..69d141e7cc 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -416,19 +416,21 @@ void whpx_set_registers(CPUState *cpu, WHPXStateLevel level)
     assert(whpx_register_names[idx] == WHvX64RegisterRflags);
     lflags_to_rflags(env);
     vcxt.values[idx++].Reg64 = env->eflags;
-
-    /* Translate 6+4 segment registers. HV and QEMU order matches  */
     assert(idx == WHvX64RegisterEs);
-    for (i = 0; i < 6; i += 1, idx += 1) {
-        vcxt.values[idx].Segment = whpx_seg_q2h(&env->segs[i], v86, r86);
-    }
 
-    assert(idx == WHvX64RegisterLdtr);
-    /*
-     * Skip those registers for synchronisation after MMIO accesses
-     * as they're not going to be modified in that case.
-     */
     if (level > WHPX_LEVEL_FAST_RUNTIME_STATE) {
+
+        /* Translate 6+4 segment registers. HV and QEMU order matches  */
+        for (i = 0; i < 6; i += 1, idx += 1) {
+            vcxt.values[idx].Segment = whpx_seg_q2h(&env->segs[i], v86, r86);
+        }
+
+        assert(idx == WHvX64RegisterLdtr);
+        /*
+         * Skip those registers for synchronisation after MMIO accesses
+         * as they're not going to be modified in that case.
+         */
+
         vcxt.values[idx++].Segment = whpx_seg_q2h(&env->ldt, 0, 0);
 
         assert(idx == WHvX64RegisterTr);
-- 
2.50.1 (Apple Git-155)


