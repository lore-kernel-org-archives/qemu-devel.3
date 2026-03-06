Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29C47F01804
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 08:32:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyQbM-0007L0-8X; Fri, 06 Mar 2026 03:32:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyQam-00076O-L7
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 03:31:30 -0500
Received: from p-west2-cluster6-host9-snip4-3.eps.apple.com ([57.103.70.86]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyQal-0002RT-8f
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 03:31:28 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-10-percent-1 (Postfix) with ESMTPS id
 8A72618003C2; Fri,  6 Mar 2026 08:31:24 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772785885; x=1775377885;
 bh=tFjBgogMlPKjObzgC9NyXUV+/x9p26nb2g8GiPpnHM0=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=UZMrU9cQ5JREbcdBu0lMKpWzRDnpUby9lg19aPWJUD/GBP161nM8s3QrNh9AqCXMcydbDqA5Ar8/WDh36p8NjFdhSw0ZoDXg68fsPo6vklfdOOUvbUP4CB8HCGFwiAVpATxl4NQBNicznGsEtxHuxu+G3w0WI0dGPu7SRHubhr1PbVhPaqWkpbZ+pUgtjck2d9YvLBRzrTJ40HdZsDYZOx2SUG5qsyLYo7+4kqS7hx9F8mzq7xKu4X23qM7KgTRxt7Z21I39/JB5E8fRBPpMjVre8l/NCBGZNQjzwp6V+PoHhj/Dg14zKezYgAhHVGS0h2JuOwg09562H0k8aY4FyA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-10-percent-1 (Postfix) with ESMTPSA id
 BB61418000A9; Fri,  6 Mar 2026 08:31:21 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Mads Ynddal <mads@ynddal.dk>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Cameron Esfahani <dirty@apple.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Graf <agraf@csgraf.de>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v14 02/19] target/arm: cpu64: only include hvf_arm.h when HVF
 is enabled
Date: Fri,  6 Mar 2026 09:30:56 +0100
Message-ID: <20260306083113.74177-3-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260306083113.74177-1-mohamed@unpredictable.fr>
References: <20260306083113.74177-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: W_lQLqtJGBQknSi9mQCudQRbY92W0s9z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDA4MCBTYWx0ZWRfX3zxi+7kjKk7P
 pHDVATbtsYhEzRjHP+THGyIhL+IXw1W25w5eJn8o8FwzbRi1y+vxw5cUPMB13izZ9ZXusfIdY/W
 uR6MXaSGKhJ1Jckl6HT607nuaT6DmGOEbIj7puW1pNjPwfUTpF37Uo8mdDTdXkQhCUoEI9Qa0o2
 +egsHkhd0UYx9gipVaWHx45ythKr9UJgMYxuPj/opHN9sAUEVSJC5LIwzSXC+OADJxxj7DtnE0B
 6tkkYqq4gNCeudXZMEE/nuWd89cPl4cy6RFW6UK/rnFZ65MNMleW891yQVu313j0Qz5P+HolO/K
 GicHtZwyEVdW6vJfltZjzLEvqMEocvxRCykpT5DUVVG2K2HkejKpuWCMe42DDE=
X-Authority-Info-Out: v=2.4 cv=KNtXzVFo c=1 sm=1 tr=0 ts=69aa90dd
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Rf21QUdm1zEAKzvazGEA:9 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19
X-Proofpoint-GUID: W_lQLqtJGBQknSi9mQCudQRbY92W0s9z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_02,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=847 suspectscore=0 clxscore=1030
 phishscore=0 mlxscore=0 lowpriorityscore=0 spamscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603060080
X-JNJ: AAAAAAAB+hZ+YRyZ0lg7rU+LsBrIYe9vumD8Q1pXvyLagdA6o9Oy8SF+1itOrs69KdbSB+1Pu8kOwluUc1wTb8DaqCpVMpJ+UGe0ba558t7hKWqcJIwE8uGJiHo/806mq4JWsTJe4bOGuDCaPNJdg9oHIpWIis7VK7lryO47IEfMjqht0OnRDKu/ru2qykopxedGNkAnr6KkEyn/MBflPr2yFKxZqfwKxlV8ENqqWUYpT+eFuoBS1qTjWssKXeGh5oQQvhV9WbWqw3xm6dXVbcQ+VAOH+FLUzOFT+lxch+dSgYUGuSxAqNDv9LzP+yWo529hYzRcXP9XiSYxTUXHnsODkSYeWe91guJVvsN4OUF5A405Dpv7kK/Tr381IyZ8R/oFYGmGHVIZLZ7O8NjGuNFPq1ik/sV/QTdXFaYlXk05QS7v02dl/WCqQrKnH9Tv8kxga4tXEoKfsw4kcMyaY2JRjsNVJeyMhhVn11GNzwgix1BYl4+R5uOrJFVpdmrtfpgD9xt2MsyRhIOqAAZKQTW0lYT+kf+0hY9c+/z272wg2T+ksB2oQiw1+fa0ioW3fZX4w/vaBMcC6iJlPQxHT/t+kCE9DIOu/gMDRzgnRrMBBU+1UaYm8GtMDcuaa7Kn36+9Wfq72gPHyq7tlqCGM5QWbSfq7vDLzgjC2Etzy3kptX2qMCinI0eExq2ah0iyVFg8j8N+1H5ejOhtCcc3tmen9ZRyVDFbjflkzggOWjCLPpc5PjgH3SwSLFo+85aTBet1jRBXPcv0TgVhmuS7NbhW6J4xyfRo10v8NYU=
Received-SPF: pass client-ip=57.103.70.86;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
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
 target/arm/cpu64.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index d6feba220e..b4f3ed2abd 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -31,7 +31,9 @@
 #include "system/qtest.h"
 #include "system/tcg.h"
 #include "kvm_arm.h"
+#if defined(CONFIG_HVF)
 #include "hvf_arm.h"
+#endif
 #include "whpx_arm.h"
 #include "qapi/visitor.h"
 #include "hw/core/qdev-properties.h"
-- 
2.50.1 (Apple Git-155)


