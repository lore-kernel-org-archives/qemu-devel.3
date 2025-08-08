Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BAE2C87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 06:57:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukH1j-0002cy-IO; Fri, 08 Aug 2025 02:56:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ukH0M-0001HQ-J5
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 02:55:11 -0400
Received: from p-east3-cluster1-host8-snip4-10.eps.apple.com ([57.103.87.83]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ukH0K-000470-Nm
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 02:55:06 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-10 (Postfix) with ESMTPS id
 29FC91800110; Fri,  8 Aug 2025 06:55:00 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=tAMz6lMwfQrqOiME7sTBMz8prC5TBo0JdN8zol2zET4=;
 h=From:To:Subject:Date:Message-Id:MIME-Version:x-icloud-hme;
 b=Gbk5mDPPn/2MotbZqBLwn98WaNuc1IoyoTYVyLdzJYu8FacK+YP5zOq9jFBbx8vMCPXjNXUPwCeB5Pm4fkeTiEDyPgrXj1VjJq/7N9a/X39c4npkFXX3scXOS/wOFPJuaRVXJEoY97a8RNXpjlrNTxq/OzQTr+eTW7glJnBKJ8SOFDVNc9x/+bMw4pesydUTlKixSJgr78blRIL/BuvjmbnkRnyg85k0eg8ACVDaMG+3QshIC/B2GrdvgacwtC8gUYxjeU3dK2/momK+tbHo417Um+hoDyQv4hPlO5nqj1HYGKKTHEY0TQQTabNUrQZlJ6rUK+4hgOdTBxgVmnNAiQ==
X-Client-IP: 46.189.47.18
Received: from localhost.localdomain (qs-asmtp-me-k8s.p00.prod.me.com
 [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-10 (Postfix) with ESMTPSA id
 D77F91800117; Fri,  8 Aug 2025 06:54:56 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Ani Sinha <anisinha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 Peter Maydell <peter.maydell@linaro.org>, Mads Ynddal <mads@ynddal.dk>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, Zhao Liu <zhao1.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Cameron Esfahani <dirty@apple.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-arm@nongnu.org,
 Yanan Wang <wangyanan55@huawei.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5 12/18] hw/arm: virt: cleanly fail on attempt to use the
 platform vGIC together with ITS
Date: Fri,  8 Aug 2025 08:54:13 +0200
Message-Id: <20250808065419.47415-13-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250808065419.47415-1-mohamed@unpredictable.fr>
References: <20250808065419.47415-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: EYC1kpHbdBFqM53CyBXxOvEitx9dRAJp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA4MDA1NiBTYWx0ZWRfX+CxOYTCFPGKm
 qlofri66FgCstsxuaVnlxNCwTx8vLrF0GKOeKfYveY5MHwOWyIVhnIg/6d/202Q9P8g9nNFw/5f
 Lj6ousg3xlaNS7pHhSO5yiQ2Oub7Q2bXeIBlxHvW5x/u1Z9UDLNeAzzdtFAY/G0eDEP1vmhZjS2
 TqxXG2axiNitNqq8YUAcYseRU8Kfn4Tc040IuXq0ZEQMK0iuNNQfikt0BiRRQus81z4ito0oa7R
 TztkDRMQruI5HRNhw6srHuFY4i7ypIcrqo7sS/XWPUYmAjAYAMQ7Zy6QHu2PdEaXmQmDKrrJ4=
X-Proofpoint-ORIG-GUID: EYC1kpHbdBFqM53CyBXxOvEitx9dRAJp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_01,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0 spamscore=0
 clxscore=1030 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2508080056
Received-SPF: pass client-ip=57.103.87.83;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Windows Hypervisor Platform's vGIC doesn't support ITS.
Deal with this by reporting to the user and not creating the ITS device.

Regular configuration: GICv3 + ITS
Resulting configuration here: GICv3 with no MSIs
And its=off explicitly for the newest machine version: GICv3 + GICv2m

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/arm/virt.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 98a1c74c42..0039f6a12b 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -741,6 +741,16 @@ static void create_its(VirtMachineState *vms)
         return;
     }
 
+    if (whpx_enabled() && vms->tcg_its) {
+        /*
+         * Signal to the user when ITS is neither supported by the host
+         * nor emulated by the machine.
+         */
+        info_report("ITS not supported on WHPX.");
+        info_report("To support MSIs, use its=off to enable GICv3 + GICv2m.");
+        return;
+    }
+
     dev = qdev_new(its_class_name());
 
     object_property_set_link(OBJECT(dev), "parent-gicv3", OBJECT(vms->gic),
-- 
2.39.5 (Apple Git-154)


