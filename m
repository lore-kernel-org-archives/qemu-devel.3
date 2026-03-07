Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4E83F5141C
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 15:42:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vytms-0000v8-7X; Sat, 07 Mar 2026 10:41:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vytmQ-0000m5-Lm
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 10:41:27 -0500
Received: from qs-2002i-snip4-6.eps.apple.com ([57.103.87.217]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vytmP-0001wR-8l
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 10:41:26 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-0 (Postfix) with ESMTPS id
 3B1D31800AB6; Sat,  7 Mar 2026 15:41:19 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772898084; x=1775490084;
 bh=hU9b4QgrAVOJZL2ae+ekCv8Jv6hLyKsDZdmc9E/YO7k=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=HNq2crs+OmgZCxbQ5wY1eDfUpkBeQj4sSDBAfyhhJQOVEzInUCduP7oD99TK8y3w9uHA5px3GxlkuJVkSvGl76GewSPKrY/etEWv5fFYRNP+OtQ80WTyFqq1M7zylfirFFUkrzWatsDljzsHLAbjCycAM4AFEP3ZhdQUm19Qct4aPXo9aJs6CNswAIk1/bvW+vD9+NRT+3jSclR8dty/EKy0yZSXeL/69jJQ80tAroxeyErux5DtscKfrPBX8SQgECZ7CvfFwmipSwoT5ggATAvOagFuuMT0bH2xX2tj7QojRMcrVTIdfexqH8+5vbXsjL8Fl/kbMzSUMu0paAxiOg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-0 (Postfix) with ESMTPSA id
 999781825304; Sat,  7 Mar 2026 15:41:17 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Wei Liu <wei.liu@kernel.org>, Pedro Barbuda <pbarbuda@microsoft.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v5 6/9] whpx: i386: enable some more enlightenments
Date: Sat,  7 Mar 2026 16:41:01 +0100
Message-ID: <20260307154104.84567-7-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260307154104.84567-1-mohamed@unpredictable.fr>
References: <20260307154104.84567-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=fuLRpV4f c=1 sm=1 tr=0 ts=69ac4722
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=lWQTlSF5RC17BzGQrLAA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA3MDE0OSBTYWx0ZWRfXxKwKIDIZYqtO
 bpcsnm6S/Wj1vngMG4Bh3E+n7CyKIsjhMJVdTPCJxIkMSQl9lXs3timtM1zLODApFViEzLgibrh
 PyRKzVbXELHpJO8sZAx+0MA4b/cgr2mgZTgSuO943eGkwQgBBX7ET0A8U6MauKt4w1Z5LaSy6k2
 QCrUvZ4Hp7APHmsAHOlPwO/NeH2THbWmVbSJWe97MgiGORuvHRQfOqwp5x508madsp4zd8fd/j1
 7G5KC6IlubwO0A7B/2gZNsuKaElXaewSJo8PayT/Nw73qZ8+XlZlmDFIYjlZUZogP7zr73Gs+fm
 q1AT5PnoXXYiial/a3qIwqX1V3fBL5gstL8HFEgcv5CgjRdr0L1bYTJLYbDg2Y=
X-Proofpoint-GUID: zpoUmwZjgcj_dQzpZ3zTb2BdzC6NpzkC
X-Proofpoint-ORIG-GUID: zpoUmwZjgcj_dQzpZ3zTb2BdzC6NpzkC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-07_05,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 mlxlogscore=871 mlxscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1030 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603070149
X-JNJ: AAAAAAABpxHmNcaiyzl+mZ35UPPkjk1G+v4K9vAG3yJO+qEXhDSxATWdjGZmwODZ3LyxfaJkcQtSRA8Vs5TrsFvIZ0QFZ2TQZkpOkqoNTsDsk/wIhZD6ciNcsLnc4xNGCrx7UGq2hngG8QJCPoMtjpcRDCUmwryVY5vTrwWrjairtXbFMpxgWfg+GCmpGY0wgwyUgeIRVWddJLn2IckauegMlIXeXe4owOh8M2o/UmNiHGkZ7tf7NDJ1OkFxkTsr3vetMGVpwZ3HBDugjlOJ9kO+ECwFqA8GgwSigFYBV/mJpwKArajI/h/N8TyYF9ztEgJsUO60wANXwKnlabXD9GBBAjqQO8zgBQRu9B/jCRSDGr+fmnyToZQNMQsUCWZmalVCniQbOwjZUalTrsahmmk1OwkgZQwqBlFn/7JgxflIMYQ5evxoY3IbnCtKqdiYnWOF7T/IpBNbwtMUODqqKhYzHqHCDWJAtUMoLpkinpva+enRvoh8ChLVVUi1CbuZ18iJScu394T2Sy8eln9bfLZtq0zW3NsXs8pfQNvQXOsy3kefMtpdvzUXjmjFaxFFiuL4iDFJ2K+xb3377Ay524SdTqYtmgvfZg8foQtTAfwNzvCOlmykta5a4PCphngPReVRVBbJq3aE2bmRHlfgvgBKbHdGHE+1H1rgOGwetgEoH3nuQYJOKD9d78TuoUtb2Vp6XU9Z+K116zPjoRk+vIzfYg2gI7fFX5o1k0bNIzLdpdTshZ0mQuky54kF6hc1ZKSF3p2Z6PARFTe3gG8F1g==
Received-SPF: pass client-ip=57.103.87.217;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
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

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 9c60295d55..bc82995b33 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2214,9 +2214,12 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
 
     synthetic_features.Bank0.HypervisorPresent = 1;
     synthetic_features.Bank0.Hv1 = 1;
+    synthetic_features.Bank0.AccessVpRunTimeReg = 1;
     synthetic_features.Bank0.AccessPartitionReferenceCounter = 1;
     synthetic_features.Bank0.AccessPartitionReferenceTsc = 1;
+    synthetic_features.Bank0.AccessHypercallRegs = 1;
     synthetic_features.Bank0.AccessFrequencyRegs = 1;
+    synthetic_features.Bank0.EnableExtendedGvaRangesForFlushVirtualAddressList = 1;
     synthetic_features.Bank0.AccessVpIndex = 1;
     synthetic_features.Bank0.AccessHypercallRegs = 1;
     synthetic_features.Bank0.TbFlushHypercalls = 1;
-- 
2.50.1 (Apple Git-155)


