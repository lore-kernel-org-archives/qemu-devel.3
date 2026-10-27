Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB982606A31B
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 15:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=unpredictable.fr header.i=@unpredictable.fr header.a=rsa-sha256 header.s=sig1 header.b=cRAKVmoU
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLjZn-0001dM-E2; Tue, 27 Oct 2026 11:59:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xLjYy-0000zz-TR
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 11:58:14 -0400
Received: from ci-2002c-snip6-5.eps.apple.com ([2a01:b747:3005:206::1c]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xLjYt-0005oZ-Ny
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 11:58:12 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-8 (Postfix) with ESMTPS id
 82222180109F; Tue, 27 Oct 2026 15:58:02 +0000 (UTC)
X-ICL-RepId: 01a17e15-38c5-7b21-9d37-c62e5d003e7a
X-ICL-Out-Info: HUtFAUMEWwJACUgATUQeDx5WFlZNRAJCTQ1OHVwPUhxEDlYCVRcOVk1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIZHldQQgVCAlwcWg5DClAcXFZVHxcZUU0PWFsIWwQPH0wMUQJCBVZeWhEdBFQHXQVdVlACWktCBEtFaFwFXBxAF0gdX2pLVhQEDV0dRQ5WGVoMUg9bDhwWS1heBFNWDkIJSgVcB1kFQQxNBF4ARQdJC08CQAZdHx1WEFIAUg9yBVcIQQhTAlEEWBpfCBkNQE4ZDEodUlZRBUoMXABoD10dWBFd
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1793116684; x=1824652684;
 bh=O8SxAhY5ga/5D9Pp3Cq6ah+Izk2s9SZbclj0ZAbEgeg=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=cRAKVmoUQwV+EWI6dwh2KPnahDoTbpxzEi6vWSyeAe6ZUB4QDstf2tz1FkikkgSMKCkpuU9np09pSPz8OLNWxVi0W7962y9WuoUni3YIr34WnVx4Fx4ltnVhIwkx8ljCIBdFr2IvuKInQiYLHnLSTmqzhg1h1l0I7Zd1CDU0MgDRQvD+qtPB1Z7woZ4y3ZzbPBff83GrP0bkck8shg1lVGTWKrgcbH2EecWUZG0dzvTEXWFoXKWD/YGMV+tLRU9Ag6CIel76f7OGmaUpwNvO5MP7VnNYYLBOWM57zhd081zARtj/xPANOZy0+RV7QCEBXLiC9YGiSuKgoDdKr7nHCA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-8 (Postfix) with ESMTPSA id
 E87EB180016D; Tue, 27 Oct 2026 15:58:00 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Pedro Barbuda <pbarbuda@microsoft.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v2 15/18] multi-target: restrict whpx-accel-*-cpu to matching
 target
Date: Tue, 27 Oct 2026 16:57:34 +0100
Message-ID: <20261027155737.59271-16-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261027155737.59271-1-mohamed@unpredictable.fr>
References: <20261027155737.59271-1-mohamed@unpredictable.fr>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: WA0UW2S_OA-zFCShqHwDay0JIbpxYhCO
X-Proofpoint-ORIG-GUID: WA0UW2S_OA-zFCShqHwDay0JIbpxYhCO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA2MyBTYWx0ZWRfX9Ae/HTKso3gF
 zoFP2CfT0SpV+2y5hfR4EUQcxDYIuAcxBX/+Nh0LToZwO+crXCwgJBKLwGbBUUecqVdLPdt/whf
 R0tAFDbIcOGSQwKFN4Gub+MQcULdgh66sqvzonSnNjo/CL6B3yyPHOoiXEbAvSTHGBwuv8I0uPN
 +7NGwC0DOa0oq6LxGcfaluHAuhdhfe02So2Ok9xEKE4sz0dTSd8JTJXR5IjB5tMafBFTg/pCpyX
 mfrTzyc8oxAqHUwijMY0OHApl3tKaO/bDTVmAxZO1dqSbyXGKyXKse1R4mSjlxU8hO98kaVVEEo
 Puv+9ga9JHb4Wja44fbI4HxB2Fi5xpn1YlJarzuCitFetLvvdcJUDcoUpqVr34=
X-Authority-Info-Out: v=2.4 cv=CuCys34D c=1 sm=1 tr=0 ts=6ae0ca0b
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=3mmYAVufMbg0zkDCPNAA:9
X-JNJ: AAAAAAAB55v906BzVv/lEZgjDAtLRGb7BJms8EGklxVASAIp/fn/nZJwhZ9a4n++Iu4eV0GK5Cw7FIpMyAHfvmM3gPLaC+Jb57QID7LUHYT68gmTM9zxshgPkfa7Cbnfk3VfnGxQg4E+91CpQJ4sff95oz42ASK0Ow9l5sLrXNM99QYkLcKo7o0zU67KjQhERNUwtVuF70hGlAxaUdfjgqRjyQrX/6x+5VQMTmOmTRRfIOhrSh6BtRe1aecEPTYqx8kTD6QAx4rPkmQ3UDc/7qs6thZMqSeUyBbI8Cv9YDw6jrBhHTUiCnQcca82XcY6jHOHPfKWXl9Yj9zEn+lc5RSMwKj4ckO4hRFbFzfT+Whx7eeAiQ9IyXk46Aw1kzVvIkwIADKzDOfkChPi49yauy0h10MXaQJ0W0OK3SLmh62vL9rKvv/G5J/C+0D921A6DudKhNRp9sIYqOnKuJPdoqjsm+yumVxWVI5+aMkTbw4yMBbTYPyhzrb4/c1M5bmhk+Sm+195udOhU5TIq+35L7Qo6itQ/saYgega3VJR69T3WXJzW3pmZrJwW/CQTpp3xJFvh0XY1TcBJ5jrHbdKRkQxN04dsWpPoLQXIgPDFpZ6KdzQS8+4NWYZ8CepgjME6HzXa340jMrhn4pPDgFfm3bMxPW9EpRz9rFQ/2W74W/eIxZA6lapN9jkJZfj+dMDriPAdHZarR0fQ2trEF8x5ny6+S7tfupp/Ro1oqCAcREJ6Pmw1NjHt7Kef1bou3+yW9JsxmbvKsfmqTnBVYvhRZOyvM0/tj1OP9ek/m844R8pyB+BwJh0oSd0jGkOjgoLUGbKElDA
Received-SPF: pass client-ip=2a01:b747:3005:206::1c;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

On windows x64 host:
$ ./build/tests/unit/test-multi-target
Type 'whpx-accel-x86_64-cpu' is missing its parent 'accel-x86_64-cpu'
(same for windows-arm64 hosts and whpx-accel-aarch64-cpu)

Parent type is conditionally registered from current target:
register_accel_target_type uses '"accel-" + target_cpu_type()' as type
name. Since whpx-common.c is shared between arm and x86_64 targets,
only register whpx accelerator cpu type when current target cpu type
matches the one it was compiled for.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 accel/whpx/whpx-common.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/accel/whpx/whpx-common.c b/accel/whpx/whpx-common.c
index 247e12db81..b7a3249f33 100644
--- a/accel/whpx/whpx-common.c
+++ b/accel/whpx/whpx-common.c
@@ -20,6 +20,7 @@
 #include "hw/core/boards.h"
 #include "hw/intc/ioapic.h"
 #include "qemu/error-report.h"
+#include "qemu/target-info.h"
 #include "qapi/error.h"
 #include "qapi/qapi-types-common.h"
 #include "qapi/qapi-visit-common.h"
@@ -512,11 +513,18 @@ static void whpx_cpu_accel_class_init(ObjectClass *oc, const void *data)
     acc->cpu_instance_init = whpx_cpu_instance_init;
 }
 
+/* TYPE_ACCEL_CPU is only registered for current target cpu type */
+static bool whpx_cpu_accel_is_available(void)
+{
+    return !strcmp(target_cpu_type(), CPU_RESOLVING_TYPE);
+}
+
 static const TypeInfo whpx_cpu_accel_type = {
     .name = ACCEL_CPU_NAME("whpx"),
 
     .parent = TYPE_ACCEL_CPU,
     .class_init = whpx_cpu_accel_class_init,
+    .is_available = whpx_cpu_accel_is_available,
     .abstract = true,
 };
 
-- 
2.54.0 (Apple Git-157)


