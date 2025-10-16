Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5995ECCD199
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 17:01:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9RIm-0001DM-Ne; Thu, 16 Oct 2025 12:58:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1v9RIk-0001CY-9B
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 12:58:06 -0400
Received: from p-east2-cluster1-host6-snip4-10.eps.apple.com ([57.103.76.103]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1v9RIG-0001eN-BE
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 12:58:04 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-2 (Postfix) with ESMTPS id
 1262618004AB; Thu, 16 Oct 2025 16:57:08 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=zNv66cYWOjcoM4iD8mPZ0d3N5D4+2q07Wwy2NtrQNPs=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=Hd3sta3GaVRNz92RcL4nm9rqJ7Ho/uokvK2HVmFI7XrQ+i+twA2Shvatl7OHG3r3hSCulm82tsbpUgzNf0k3XrCVI74zyE+3LGg5v6ZP/aX7cgmg19jh35aYmNNGo8hcF5ZHGnpGH1ZkcKHRJiqm6BBg8rwsZbsmpxH+g6BJM/sapn7qKxTttxzzkdG3sKg9hemOHJ6mWgQSBI4rLe6WGyJemIzPz5oywseV1+3slQcDMRZJwefe7HPAPQZ1z7OPgee1BLmLG7foTw91r/f84GZKLMRvItJjBLbpCwFOlce0e7WcHTR0FsVNp9cPmSZLNDoQhXjqxmAs47dYGu8Hig==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-2 (Postfix) with ESMTPSA id
 BB51318024C4; Thu, 16 Oct 2025 16:55:53 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Mads Ynddal <mads@ynddal.dk>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Eduardo Habkost <eduardo@habkost.net>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Zhao Liu <zhao1.liu@intel.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v7 09/24] whpx: common: add WHPX_INTERCEPT_DEBUG_TRAPS define
Date: Thu, 16 Oct 2025 18:55:05 +0200
Message-ID: <20251016165520.62532-10-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251016165520.62532-1-mohamed@unpredictable.fr>
References: <20251016165520.62532-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDEyMiBTYWx0ZWRfX/Se7HJt5ynqq
 roJse5cXmIDGwIRZMaWA6H1I5UTUJqK+cKTCvbOJGuujitBOmO+06nJXJRBTtJ/GPuX3o8VSY0I
 o1QhBe1fQMrTUSoJ95DOq7V8kGvVITsd+wpV287dm2aTTKjdp/zwYz/kYWe5Bwv/KG8YZJFdXdL
 n7M0XiF8UL6PNIknHnlRqQWWQvt5Ii6cMk1UEELm43EorttynVXy7PtcmKJTCJrBusi3pfUKnlH
 ma6xq+181+P77RAzK729cfyK1jCZYw/8z/FDUJHxs8Od8/FZWM4V2Qkm9q/pQkK51G0ozdk4g=
X-Proofpoint-GUID: IhWrKx3FAqHIMTyMmBewRi40WIQl1-Xm
X-Proofpoint-ORIG-GUID: IhWrKx3FAqHIMTyMmBewRi40WIQl1-Xm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 adultscore=0 clxscore=1030 phishscore=0
 malwarescore=0 mlxscore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.22.0-2506270000 definitions=main-2510160122
X-JNJ: AAAAAAABKQbKhGNJsKWtHaM0uPJhTwSnS1oTiWx3YNJODY4fPbxw6apQMVH9n6rgjIZYhRnDazA9zfU0QuI7MvErSkMGrX4AHqmAipWgO4R4KIoC/D8OIPWD8OGAaMmElA0pK9Jo0Y+LLxYCu67FV5xpToXLT65oO3GMCZvLhJGF4MOehOPqRJgV18RmyAW8vQkx6MKMSqZfDfVWHrRJcL22VCTtPFOcxIuLNJGfQ9kHBQJTqCay1ISlMgSDJz+OJveXzNQmmO94XV47yDocXtPmg9yMCf8mQ9dyvFJsuNzGDhUT+3LCENHQbwvBIQiVbCn6NHq7L7S3BgajNKbHXJv366j2irUA4cddJ9f0eyxsG/DMd+CEE3sbCRr9DXpqUwaBNklT42IHI/2WwxEUhYUklzLj9gzt1VnwKPLGKS/5HZwgHplfbD1N8r344/R2v351zRSxraQ3m+9ZHVeWGTaKA309Lh+FcwYJUvcbrc4dO+9HDsRHU4crxTWW9t2/UZ/f8AH5zPZUwvTMicfRw0+gwG2d8wNrNr30dn54hEhOG+Hzjhs03uVFekIjtAB4pLgfJ/QNjcg9xBPYBfT0+hlt6qx1GBzFUjHOnYk7MBfTTrGWSDW+pwXgP+Wdt8pAjF1t7OO2P0JICIoYJuIrGQN2awX6w4xxZ+fWRMHqgSYmmLvZlXL25634Aglv8dAzN6mefl9xnqOxoohX30P4rc9X2ZMCgQAdBjZSdGKvYlgG2LFtjj3UJWt2VTbA1zoVJ7o1Q/aXFE45C1eXoyEzANGCrzMF6jOCByHPZo8fMzKMv7+XsXUeP2/+SUnohPJpFFzTwmnd/xCJ9PoejLIMt6JI/oUUsH/yZ44vJwB/btZULfN6a8jw/hQ7d6ZTcvzJt28OCukPIASSKpWl61jcLF2uZs5fnPXqSsISg5FGwyhj
Received-SPF: pass client-ip=57.103.76.103;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_SPF_HELO=1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

As of why: WHPX on arm64 doesn't have debug trap support as of today.

Keep the exception bitmap interface for now - despite that being entirely unavailable on arm64 too.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 accel/whpx/whpx-common.c     | 2 +-
 include/system/whpx-common.h | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/accel/whpx/whpx-common.c b/accel/whpx/whpx-common.c
index 95664a1df7..c0ff6cacb8 100644
--- a/accel/whpx/whpx-common.c
+++ b/accel/whpx/whpx-common.c
@@ -123,7 +123,7 @@ int whpx_first_vcpu_starting(CPUState *cpu)
          * have one or more breakpoints enabled. Both require intercepting
          * the WHvX64ExceptionTypeBreakpointTrap exception.
          */
-        exception_mask = 1UL << WHvX64ExceptionTypeDebugTrapOrFault;
+        exception_mask = 1UL << WHPX_INTERCEPT_DEBUG_TRAPS;
     } else {
         /* Let the guest handle all exceptions. */
         exception_mask = 0;
diff --git a/include/system/whpx-common.h b/include/system/whpx-common.h
index 7a7c607e0a..73b9f7c119 100644
--- a/include/system/whpx-common.h
+++ b/include/system/whpx-common.h
@@ -20,4 +20,7 @@ int whpx_first_vcpu_starting(CPUState *cpu);
 int whpx_last_vcpu_stopping(CPUState *cpu);
 void whpx_memory_init(void);
 struct whpx_breakpoint *whpx_lookup_breakpoint_by_addr(uint64_t address);
+
+/* On x64: same as WHvX64ExceptionTypeDebugTrapOrFault */
+#define WHPX_INTERCEPT_DEBUG_TRAPS 1
 #endif
-- 
2.50.1 (Apple Git-155)


