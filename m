Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB76FC87FCB
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 15:52:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uixTX-0001W3-GK; Mon, 04 Aug 2025 11:51:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1uiw72-0005jm-31
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 10:24:29 -0400
Received: from p-east3-cluster6-host3-snip4-10.eps.apple.com ([57.103.85.161]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1uiw6l-0000SK-7c
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 10:24:22 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-10-percent-0 (Postfix) with ESMTPS id
 BB06B1800323; Mon,  4 Aug 2025 14:24:04 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=uwKVDnGWx6+C+J+z4gjMgudEt/jnfRIQImNEr8u/c9I=;
 h=From:To:Subject:Date:Message-Id:MIME-Version:x-icloud-hme;
 b=TGzQbfYUBJFC2pAxB+bra5ryW54zTxrnGKQIt5M7sitLHAitw820F3+lO0DJOft+9gLb70lpfbCOr/JoOP4jqlj81WMH9BBukMLc1ytxeq9IPGMonjBbLfN57A8W8cYsP6yoFU1yeuwXcXPwwLqeSIBrO4CqBZr9GAAx0YY/Sl6cp9UfLp6ARMsE8ixZ3OKLOBID612ayQ7uSmoqJtH9DHESQdaTDOf5usfISt+S9v8Nm0DcteiemETpoKR8O2XylG/QfRxdsy70YjYAdypJLAUyyJuObwpYRwmAM0siYS2YNyBBdO/apBe3iiCh0Z/Y970uL46nKq4BNYSB2wUEVQ==
X-Client-IP: 46.189.47.18
Received: from localhost.localdomain (qs-asmtp-me-k8s.p00.prod.me.com
 [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-10-percent-0 (Postfix) with ESMTPSA id
 2D668180135E; Mon,  4 Aug 2025 14:24:01 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Shannon Zhao <shannon.zhaosl@gmail.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>, Igor Mammedov <imammedo@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, Mads Ynddal <mads@ynddal.dk>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v4 12/17] hw/arm: virt: cleanly fail on attempt to use the
 platform vGIC together with ITS
Date: Mon,  4 Aug 2025 16:23:21 +0200
Message-Id: <20250804142326.72947-13-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250804142326.72947-1-mohamed@unpredictable.fr>
References: <20250804142326.72947-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: o3xms7nH0xeZ8GolPNmofEn6MO1EfNVS
X-Proofpoint-ORIG-GUID: o3xms7nH0xeZ8GolPNmofEn6MO1EfNVS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDA4MCBTYWx0ZWRfX5rXj+l+NXMOl
 T+RvLlmoiMsoQBnz0vyJRNfSCZhZza2CMKBGSlh1ZjtVmg8YMnaez+UXOLvtKgJvcg20Kf+iJvN
 O7bsbbv13r55A1B5VgzLc4gApMoLX/oNyRsJRGoR0BjmT1vPsu7oHB5ZxDwgCR+7k5hGMka3Fwi
 f2ghhA8G4dy62maW/6wxAXianlL+WblA4/5G1DSoGrvyqHygTkQ+Rc5ZdgAZ1jSmLndFJIzYgVG
 gchoXsPwgavFqmDS0nD/QjI78tfWKCZkSkhbE5joizkPhhAbqxhV3q8lAGjFcV6VZOiLgzUsc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_06,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=0 clxscore=1030 phishscore=0 mlxlogscore=999 bulkscore=0
 malwarescore=0 adultscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2508040080
Received-SPF: pass client-ip=57.103.85.161;
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

Windows Hypervisor Platform's vGIC doesn't support ITS.
Deal with this by reporting to the user and not creating the ITS device.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
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


