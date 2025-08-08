Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE3B2C87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 07:02:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukH79-00069c-Lh; Fri, 08 Aug 2025 03:02:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ukH73-00063y-6h
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 03:02:01 -0400
Received: from p-east3-cluster7-host12-snip4-10.eps.apple.com ([57.103.84.251]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ukH71-0005Ey-FE
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 03:02:00 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-5 (Postfix) with ESMTPS id
 D6A6E180017D; Fri,  8 Aug 2025 07:01:57 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=h50IOS2CA6o4I9OlrTaWeva2AjGiCu/lzeLRcMS3+go=;
 h=From:To:Subject:Date:Message-Id:MIME-Version:x-icloud-hme;
 b=dmo0P5m5gt8h2u8KNwGjVyjOVtJnqj3ehx3dQnqsP31RmDgIwY203BTFK3qzfmBN0YAtiLG5STwtuFx3Chsw1UGegDYeM8KgPQ/m8jRU0AkYngCFcBzBZSdcnHfBRPoKkaZDhPYRBGm0J5853BGXYL0hi2vaAmugVVDMlb3bEQY5lFkDOHTXiW0XD2oqZEi7CR0Z2vK1CsaMAbSmScMT9+euqXLx2bPU45t/20/GA9lr7CL4nMwYt+iEiZxY8LTjbXNZm4uzQKYR1Ps4v+9OHs43q7a2wjc3gJUbFSwHAFASSKO5Gn4RSaNaEKNIDE89fsOrwaXV1t830T1O0RZYdw==
X-Client-IP: 46.189.47.18
Received: from localhost.localdomain (qs-asmtp-me-k8s.p00.prod.me.com
 [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-5 (Postfix) with ESMTPSA id
 0C321180013E; Fri,  8 Aug 2025 07:01:55 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Igor Mammedov <imammedo@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Alexander Graf <agraf@csgraf.de>,
 Mads Ynddal <mads@ynddal.dk>, Cameron Esfahani <dirty@apple.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v6 09/13] hvf: only call hvf_sync_vtimer() when running
 without the platform vGIC
Date: Fri,  8 Aug 2025 09:01:33 +0200
Message-Id: <20250808070137.48716-10-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250808070137.48716-1-mohamed@unpredictable.fr>
References: <20250808070137.48716-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: tYzoptkF8mIvRllIFLvulEgnA0IFY6yf
X-Proofpoint-ORIG-GUID: tYzoptkF8mIvRllIFLvulEgnA0IFY6yf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA4MDA1NyBTYWx0ZWRfX3r3pnp3nN/pw
 qOwFcTRyZrIpHPnGur4JgMvCaFD3q8dVgIpP6iIZBxaSP/nu6JikVyci+toG6cHvrhh+2eHfci3
 hB5nVk2+0xDir2Zxnz+DxeMyabasv9be05Lw1nsl3lOyKj7733gJSczV98r9LDzN1bUi6MUuf7p
 6FW1aL2OrABi45ZXVBU24Wx/inWtwpVElccmEBgRzHdjLZudPetF10yaTYEPyG06ABuD6cHUUCg
 8oqEC0PEP/+Re7yhgD1r1CZBD2RSYOticU4IRb2yKMO41au/cVwB925IHvPs3m2HBoJmsTAfU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_01,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=0 bulkscore=0 clxscore=1030 mlxscore=0 malwarescore=0
 mlxlogscore=894 phishscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2508080057
Received-SPF: pass client-ip=57.103.84.251;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

When running with the Apple vGIC, the EL1 vtimer is handled by the platform.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/arm/hvf/hvf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 788d0d41f4..d8741f942d 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -2008,7 +2008,8 @@ int hvf_vcpu_exec(CPUState *cpu)
         g_assert_not_reached();
     }
 
-    hvf_sync_vtimer(cpu);
+    if (!hvf_irqchip_in_kernel())
+        hvf_sync_vtimer(cpu);
 
     switch (ec) {
     case EC_SOFTWARESTEP: {
-- 
2.39.5 (Apple Git-154)


