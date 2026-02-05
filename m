Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD5B5EC1EB5
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 13:13:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnzAL-0007tZ-Fb; Thu, 05 Feb 2026 08:13:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vnzAG-0007qj-Qh
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 08:12:57 -0500
Received: from p-west2-cluster1-host8-snip4-10.eps.apple.com ([57.103.68.103]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vnzAE-0001ac-Gh
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 08:12:56 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-8 (Postfix) with ESMTPS id
 14FCD1800147; Thu,  5 Feb 2026 13:12:53 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1770297173; x=1772889173;
 bh=c9xkU5JKUppgK3M6NvIGvHRbHv9MZvro5B1lYG+DJ2Y=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=R+4TN0PyFTmy872DNdc0lgL8rtNWemVSnd3+nGt37oQaklTZiFAPoKO7pNJevtTtioF+1nvJOfB2MnzYT5ozuJBGBvb9VWOZz2VbMlXMisBdS5AtvswK6vor1Q0UWRx9FeRl0mOKQb9SmoxIAudcJNgYrWaoa3wwcB8t9aVyBMXzUAjNEXnqy4Jp7zRphd4KBSKgRv2EBiYnnbwWD1nnCyYqazhM+EwszSr/CSBgaeaX/o+0rv6GJ8r3xmS3tGXcahbBnWOBL84jMS+GM/sZU3nBS4cb1+CK6dLr0Hix1cYdLsWNprLhL/FPzJlvEb1+rQVxDqsEjHMKVUJM5Qo/bg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-8 (Postfix) with ESMTPSA id
 B967D18013BC; Thu,  5 Feb 2026 13:12:48 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org,
	mohamed@unpredictable.fr
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, Alexander Graf <agraf@csgraf.de>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Pedro Barbuda <pbarbuda@microsoft.com>
Subject: [PATCH v20 11/22] whpx: common: add WHPX_INTERCEPT_DEBUG_TRAPS define
Date: Thu,  5 Feb 2026 14:11:40 +0100
Message-ID: <20260205131155.22780-12-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260205131155.22780-1-mohamed@unpredictable.fr>
References: <20260205131155.22780-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDA5OCBTYWx0ZWRfX5rckgfdcjhzg
 Co8zSuDP+rUfJQJuwaoYC2xqv7OYo2a8VwcneSXmiyg5e+GTdJUeyIb38ZB5RIQHYZoub6i57+E
 5WR0d0K/heK4RdQV4DGTnbiNXt7Ml6M+YIeVTT17m/reglhv/XaaeRGZv1A7aQzyBEzek21/0rK
 XSIB9crN4hM2KQS+s4sh3HxURwdmMmsGIUCpXKYmOP0bYd99+5wCeTC4BzuwhCwMR93lCoTwLm7
 t2bfjAPJeMeM9BcREnMmnlyO7kKzlGE2aAryqjgCDTWdtNLa82O/+SGDo9fiYHqH7nRV8qPt+BV
 ck0DTtEC1uZhoN2Ti9n5taWP1xRTlgZNRnRn9D0nZJRB9EYF3hl5jV9aODj/MI=
X-Proofpoint-GUID: ULiRNrJ1K4lFAGgE0VHug74wEu2DytDD
X-Proofpoint-ORIG-GUID: ULiRNrJ1K4lFAGgE0VHug74wEu2DytDD
X-Authority-Info-Out: v=2.4 cv=PtKergM3 c=1 sm=1 tr=0 ts=69849755
 cx=c_apl:c_apl_out:c_pps a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=2psWIPzlEfUqwKpUe20A:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_02,2026-02-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxlogscore=999 phishscore=0 adultscore=0
 spamscore=0 clxscore=1030
 mlxscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602050098
X-JNJ: AAAAAAABTBj/TrR2cj/erG1lN3QfwN7rRiew3rV4fqc52Xg41z15k1Xyowv4LSLPicHcwIP4eCUKFP6t9OqdWvaPI8gZSshMQHiYv9pCY6fSuDAob7z5jPtvBKD3mhuYwDc2KCR1JH77WO4sleEMHDwY3GaiWro++l7Sp4P+8N8M8HugAKdNzPKPJ9UR1jRR8R5F9+NiD/jbQjR/AjrXaK/HbEXv1gdZ3ObZy51Dydbi6+ICFoGMpkMmk2cP1TLEsnCigS3RhbDQ79r5bBM/q/ArjErLMuxr4jJzGUwJhwm+g2niCLR542PT30mDRGBQfEM2sarltBB4QABi7tcMBh0qjkeZQidiyQcjypHGl4b4fvXnvozaW2XoAJy4d1mO/GGdPo3LgmrFn2SSbnFoB25LTW8ERvrprrF2wxbbnaqZQqCISMgHf19vJ9hI3AvvEdBnqwuYYBhkhkCaUj0unhh7aJANEHcrNgItt6FwvPPTnBC9y8MjfLJVviVcDXyQieslwxugTxQuwXqfVKdc7TXgyajftyZlWS70u3niMz7BqB5ovTYm2JJXXpEKA/3BL7lr9+cFmVMFa1Ep+yravHvvuSrvJhUaL/vDMLEJL/AyGNiG4w/jylYrDmPU5cV9LVu6sIBkt9rBrNon2ZlFOMME6VYBQCe+JaXWFRftLwqG0AN2BGwzUBB7YV8/peD8jB7+5jVHEmH0SYtCXmerMqyHe596zaeaDNLS1FsJHXOqLiHWeLbJwaXTqn9ale8SiginNBRZNQG7CmfyOqI/gNgtNn+6GWWK3a6igxJUFAgZJ3xVZQMgFm70Wa5hqba7CZGUBIGC3ZA2QBzwWneXffhFJMreeBmHyhZhUmIV4uK6LcAdbR1OnRf/p+tnJujT7lT9CDvm4WkyHucUl2zLMKXVe2CU3yAyrBKjG4IyiRoxPJundWnAQ3IlUm3mmeozXlT71e/oGgBoEEAVBCoydCm9
Received-SPF: pass client-ip=57.103.68.103;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

As of why: WHPX on arm64 doesn't have debug trap support as of today.

Keep the exception bitmap interface for now - despite that being entirely unavailable on arm64 too.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 accel/whpx/whpx-common.c     | 2 +-
 include/system/whpx-common.h | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/accel/whpx/whpx-common.c b/accel/whpx/whpx-common.c
index c58344cb61..c0610815d9 100644
--- a/accel/whpx/whpx-common.c
+++ b/accel/whpx/whpx-common.c
@@ -119,7 +119,7 @@ int whpx_first_vcpu_starting(CPUState *cpu)
          * have one or more breakpoints enabled. Both require intercepting
          * the WHvX64ExceptionTypeBreakpointTrap exception.
          */
-        exception_mask = 1UL << WHvX64ExceptionTypeDebugTrapOrFault;
+        exception_mask = 1UL << WHPX_INTERCEPT_DEBUG_TRAPS;
     } else {
         /* Let the guest handle all exceptions. */
         exception_mask = 0;
diff --git a/include/system/whpx-common.h b/include/system/whpx-common.h
index 8f171d1397..b86fe9db6e 100644
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


