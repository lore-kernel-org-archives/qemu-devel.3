Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29522C88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 10:02:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6mSA-0008Of-Kh; Wed, 16 Sep 2026 06:01:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1x6mRh-000884-Kk
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 06:00:56 -0400
Received: from qs-2003j-snip6-1.eps.apple.com ([2a01:b747:3006:204::5e]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1x6mRe-0005Eb-H2
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 06:00:53 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-8 (Postfix) with ESMTPS id
 D4E831800BC5; Wed, 16 Sep 2026 10:00:43 +0000 (UTC)
X-ICL-RepId: 01a0a9a9-5bff-7cb3-b7cd-d334028d275d
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQ1OHVwPUhxEDlYCVRcOVk1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIZHldQQgVCAlwcWg5DClAcXFZVHxcZUU0IShMFUgddTVYNRw9YHlwUFwlAQ14IXh9MHB0OWAYSAE0KDjYGWQVeCVYDQwU2EhRdRUYDRxlXFFAbRwxVB1deXwoTAF4PD0wLSAFbB1IDRghIA10FWhxHCkABWBpcHx1WEFIAUg9yBVcIQQhTAlEEWBpfCBkNQE4ZDEodUlZRBUoMXABoD10dWBFd
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1789552846; x=1792144846;
 bh=KDf2DTW4By7UOzCqNMWGATcGpPtR9PyeQLUVDbCPI44=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=pJpQCW9VGXYCgN/eUJERmFaN24JmF0FI8OsGq2dKy6GtW8lSPSnv/AfuLleTlji1lI/v1yFPJYAjLPCit/kvxi8p7jvqxsNHb/FUYFmMQ8Saq4dpDw5m3SRI4CjiH+z9/OPsDVCEjO3F/2yXHJgtowwSB5EGdskZhDXoQYvnOx4+FiMew7JY6dNgl7NYiYI8jq8Mx7C7OOUrlTaUR+kZi2Y9TTxhOhpB6xre3EskxzAYnEHW8bcxqlrSnzil4cuPeyTSt4W2fshk632MXx90BKSTCUM78vmfl77Eq8UFYc653x23/+pAbe0d+Y0dm24t89EcCaFNS302Scux2w5zXQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-8 (Postfix) with ESMTPSA id
 B21F518009F4; Wed, 16 Sep 2026 10:00:41 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Phil Dennis-Jordan <phil@philjordan.eu>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Alexander Graf <agraf@csgraf.de>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [RFC PATCH v8 06/10] hw/vmapple: aes: convert MAX_LEN to a #define
Date: Wed, 16 Sep 2026 12:00:14 +0200
Message-ID: <20260916100021.73825-7-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260916100021.73825-1-mohamed@unpredictable.fr>
References: <20260916100021.73825-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=B9G0EetM c=1 sm=1 tr=0 ts=6aaa68cd
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=CNpkFlK3StMqgsPjqO8A:9
X-Proofpoint-ORIG-GUID: 4-ccaC-8I-h1vjB8vBubo6DDJYDpmUrJ
X-Proofpoint-GUID: 4-ccaC-8I-h1vjB8vBubo6DDJYDpmUrJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDEzMCBTYWx0ZWRfX9ioFqSTqtDfM
 0WSwI6zRKLPBF72zIusk5eorsjwx2MHL9J1E0anxwz/haFIsyw9/mc2hrZ8f5pBDGzPbkPqy3Qu
 XW9XvHkAwIXM7MhqbiWJAhu7PL7XyQCasyykqejxUk2olMkM/qQEguYJJC/a8FEeUthK++C6CEN
 ObPlfprY6jWTwgTES1iHpk6XXjlh/8aCcHOtRJ/+l68p0BJH1cFOMVTnp9nZ05ZRJgMQihpPLjk
 R7En31A15I+SFejsalMhs6/57DkFONVbx33C7rO50tvsOPk4kU0HmwV5wA810I26oUEkaoCvcKN
 H/IAWB56ONJNgIZhZ65mRQS1FbFlbxlBKpTwDmWoq2AK050sS+lrVieX4pguVo=
X-JNJ: AAAAAAAB0EL8hrIM4W/71g2/KqLkLr2OtMUovKIeMlWBnj7KahzoPu/iwH56r4zlBNijufbi7sFV9hHa057vQbZQ2RYe4AT9f3hSxefFk63goVpG2jBvE+htIux/s/fwKv+X/6VuAQYNkx4pBoz7StWiX43mEJct4KXMvxrV2rdXbtiwHn10l+HdHCTEdz/i/Jg9b19pIGAN8vVuSUz3380xNMDH3mwJTRZmq5SAFZMOAtgkIi+7p6GPOciAx73M59J835M4ZeNDwAM5AK4C1fgmVAzY60EEekzGD9O+e6k+7qhoYzqJ9gUDvxrxdU0PLkygIBGACvBGEZKBlLbX0MrGSR+N5VzZbpiYk9JYtW73m1j5D/7+NfOr9lTfjr4RPZK3ABGKYZs4gvOlV2WfDfZv/W2FzJBKhdVuTtk2shQawqa8KCQbgjP83JKhpgvX2pHsKDhvGjOupXroYe8pOlNCT4etp+fnv3nGVsaAgyBL7QdtdeB/wTlE072XI7VfshEbAKf1lbv+kcYSKNHiPpzvOOWPzsy17eF3qR59vYFdi6azCxNsaRELYZbVFXtNSrqBxnrSm0ms7VW6/fhx1j73U/AdTWOCGqt7WTaStfRscQt8QABGDMO5PIVik12FRQ2XuBz44Cp/Ti2H6l05/ilUVciHMEY/9HBbuHQQwPtAsAbi1yS2bSqHWNgAUkLkWDD4ujRz5zNL1EMJhUGQAHDTDlgT1bxLq044ImjtqDuxWjk3dZvhXJhow1t0eN7b06HISNI4Id3lMPLQXKUvUDXLxPgWQDtN8zRY+MJLwz2lFzDvdv3jNn6jsaLmPzPQns2jGjRozf55V6RHhB2V+IZPJ8abNJi8KQ==
Received-SPF: pass client-ip=2a01:b747:3006:204::5e;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Working around this compiler warning:

../hw/vmapple/aes.c:257:14: warning: variable length array folded to constant array as an extension [-Wgnu-folding-constant]
  257 |     char hex[MAX_LEN * 2 + 1] = "";
      |              ^~~~~~~~~~~~~~~
1 warning generated.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 hw/vmapple/aes.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/vmapple/aes.c b/hw/vmapple/aes.c
index 553e688adb..9d062d5a7f 100644
--- a/hw/vmapple/aes.c
+++ b/hw/vmapple/aes.c
@@ -253,7 +253,7 @@ static bool cmd_iv(AESState *s)
 
 static void dump_data(const char *desc, const void *p, size_t len)
 {
-    static const size_t MAX_LEN = 0x1000;
+#define MAX_LEN  0x1000
     char hex[MAX_LEN * 2 + 1] = "";
 
     if (len > MAX_LEN) {
@@ -262,6 +262,7 @@ static void dump_data(const char *desc, const void *p, size_t len)
 
     qemu_hexdump_to_buffer(hex, sizeof(hex), p, len);
     trace_aes_dump_data(desc, hex);
+#undef MAX_LEN
 }
 
 static bool cmd_data(AESState *s)
-- 
2.54.0 (Apple Git-157)


