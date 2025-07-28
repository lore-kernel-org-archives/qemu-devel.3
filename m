Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E522AC87FC9
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 13:44:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugO7P-000054-9s; Mon, 28 Jul 2025 09:42:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ugO6q-0004wB-8a
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 09:41:45 -0400
Received: from p-east3-cluster4-host7-snip4-10.eps.apple.com ([57.103.84.73]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ugO6n-0004J4-0m
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 09:41:43 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-3 (Postfix) with ESMTPS id
 A5BC61819D34; Mon, 28 Jul 2025 13:41:33 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=S3ZBNHI1pU1dOel9dX+AYwGkdx57h3gION5nK4yFHyQ=;
 h=From:To:Subject:Date:Message-Id:MIME-Version:x-icloud-hme;
 b=IROxKtTBgMRcFJTXgj1nJijDlH7ApzQSZxZmC3SDDsMcFSEOrBYagNhfnSv03rUTdzFBF09K+KldS1GNcxNJsbJpphSbATtJ0KC2yrh0vC6Hx+p0Qx2MsSrvClpVVbuINr4DBMZj84EEG+Zi//Nr6aHr5NClfmBIw0tytvUJe+3RPZ7y5awyk1P10wMdwTUalwfOYJ5FklZkmM40awuSuyNITqlOFI366xkDCnwF3W8mmB3GYdLw9TbPLcvjBMy2+nw9WB96dMzfbFicDbymK5Zc7BI0FNplRcGasOAlJYipjewh+Citx17E0V4lpYL2QmqtCtGflv6qnYNGkP/7nQ==
X-Client-IP: 46.189.47.18
Received: from localhost.localdomain (qs-asmtp-me-k8s.p00.prod.me.com
 [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-3 (Postfix) with ESMTPSA id
 30280180023D; Mon, 28 Jul 2025 13:41:31 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>, Paolo Bonzini <pbonzini@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Igor Mammedov <imammedo@redhat.com>, qemu-arm@nongnu.org,
 Alexander Graf <agraf@csgraf.de>, Roman Bolshakov <rbolshakov@ddn.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Cameron Esfahani <dirty@apple.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v5 08/13] hw/arm: virt: cleanly fail on attempt to use the
 platform vGIC together with ITS
Date: Mon, 28 Jul 2025 15:41:09 +0200
Message-Id: <20250728134114.77545-9-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250728134114.77545-1-mohamed@unpredictable.fr>
References: <20250728134114.77545-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI4MDEwMSBTYWx0ZWRfXwwUaBYlV/YvV
 PTvo4RJqI2f/WpoYVYyBxJGZAk/ujktDzbDt26VoR8c5xNmFWiB0tv2qhiXkfn5XzbPEhYoeETk
 C+ApqdOOnZSXJv9mBSetC3HGOhZTR15z5lDYiN9uClfdPRIqJuZZNYPKD/X9/MmyykVAnfNarzz
 d6MqaQ1xQHXZkKxmt/zG04hRfpGBatYwuANTBG9TFjNmC8Q4QhXpptstmquflLLyeVWrL8XQlus
 UkD79V5Xscim8KRiFVyTYhNbsfM7yXHaOgCszDahUti1j9I4/bEcQkcl7r8VJgaB3gWtmfmZo=
X-Proofpoint-GUID: cc6peUVDvD9J9IhEie9tVw1GigIk7ENC
X-Proofpoint-ORIG-GUID: cc6peUVDvD9J9IhEie9tVw1GigIk7ENC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_03,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 phishscore=0 clxscore=1030
 mlxlogscore=881 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2507280101
Received-SPF: pass client-ip=57.103.84.73;
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


