Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 608BCC83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 06:00:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugGtC-0000yo-O2; Mon, 28 Jul 2025 01:59:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ugGrZ-0007J1-Cp
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 01:57:30 -0400
Received: from p-east3-cluster6-host11-snip4-10.eps.apple.com ([57.103.85.241]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ugGrX-0007FD-4C
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 01:57:29 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-7 (Postfix) with ESMTPS id
 DBBC71800107; Mon, 28 Jul 2025 05:57:24 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=S3ZBNHI1pU1dOel9dX+AYwGkdx57h3gION5nK4yFHyQ=;
 h=From:To:Subject:Date:Message-Id:MIME-Version:x-icloud-hme;
 b=XfespWzdNxMbHSC06EWwbwLonyZAkdZWTxAEaDWD672+aY7Maw8LOqyc/pyzLqEOQMecdmYdim60tbA2OFuaclVok0xCPEZciJ5BhWys0iuOiforjsTJEWdCrGnvdVPwiRbExOhuJG7MPtzM/f4pTkB2c+MUNSi0T+pMZeXXWXLXwUApbuisDTI57wEYVG8IXZxmvIltvjZEdqcT2TcP+ml1toDni0GhB44zgumc0o2YZcqV3d1dHRRo0mfpVCQDSBE/VuJ9nK2SOyVYkLvvOtaRwfui3nfUS/RWlvRQF567yIy2jgv2S+hX+r0fR7+dOruURE/Xgvo//oUPliky/w==
X-Client-IP: 46.189.47.18
Received: from localhost.localdomain (qs-asmtp-me-k8s.p00.prod.me.com
 [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-7 (Postfix) with ESMTPSA id
 DAD361800139; Mon, 28 Jul 2025 05:57:22 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 Mads Ynddal <mads@ynddal.dk>, "Michael S. Tsirkin" <mst@redhat.com>,
 Cameron Esfahani <dirty@apple.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Igor Mammedov <imammedo@redhat.com>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v4 10/15] hw/arm: virt: cleanly fail on attempt to use the
 platform vGIC together with ITS
Date: Mon, 28 Jul 2025 07:56:56 +0200
Message-Id: <20250728055701.38975-11-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250728055701.38975-1-mohamed@unpredictable.fr>
References: <20250728055701.38975-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: rFjSwuNaRyaY7ZzVL56WM8XNBBq-EynG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI4MDA0MyBTYWx0ZWRfXx6JuD9XF/zEu
 LgyFWgKV6ia0No0E5lkbm4Ltw4bvP3zZkfhFQKhAwAX2cGD2aH1efV48bppFrL+adMK0mOr0wZz
 okCF6K1G5YPIxz78v95m60z8mt3aPviXeYxoKtOppMQIGSO+OVxlzH5fqBTGnDP1vy4/nmvhPBn
 Te0FPkyAeHCh+BhLPdrwd2pZw6g8D/kWXSg6y2tPoSm1YvmHpbhdGrTRP/EBW5Zk4mIOyZDC+8O
 DZEJijq9YR2Rifj5ETZDHyzh7a970CXQoCtGTmtkw/G3XzM+BAzGyhsTW8T9AVfJ8xCWDFYKQ=
X-Proofpoint-ORIG-GUID: rFjSwuNaRyaY7ZzVL56WM8XNBBq-EynG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_02,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=881
 malwarescore=0 clxscore=1030 mlxscore=0 spamscore=0
 adultscore=0 bulkscore=0
 phishscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.22.0-2506270000 definitions=main-2507280043
Received-SPF: pass client-ip=57.103.85.241;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Apple's platform vGIC doesn't support ITS. Deal with this by reporting to the user and not creating the ITS device.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 hw/arm/virt.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 91d8cd9363..005e923a22 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -740,6 +740,16 @@ static void create_its(VirtMachineState *vms)
         return;
     }
 
+    if (hvf_enabled() && hvf_irqchip_in_kernel() && vms->tcg_its) {
+        /*
+         * In the HVF case, inform the user that they can use the
+         * user-mode GIC if they want to have an ITS.
+         */
+        info_report("ITS not supported without kernel-irqchip=off on HVF");
+        info_report("Disabling ITS");
+        return;
+    }
+
     dev = qdev_new(its_class_name());
 
     object_property_set_link(OBJECT(dev), "parent-gicv3", OBJECT(vms->gic),
-- 
2.39.5 (Apple Git-154)


