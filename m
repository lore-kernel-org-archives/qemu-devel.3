Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6B160A380E
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 12:03:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLft9-0003SF-9r; Tue, 27 Oct 2026 08:02:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xLfsF-0003G2-2k
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 08:01:59 -0400
Received: from ci-2005h-snip6-11.eps.apple.com ([2a01:b747:3005:202::53]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xLfsB-0007y1-FE
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 08:01:50 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-8 (Postfix) with ESMTPS id
 5F2821801A77; Tue, 27 Oct 2026 12:01:42 +0000 (UTC)
X-ICL-RepId: 01a17d3c-d959-7a5c-a142-8e95544d2eca
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQ1OHVwPUhxEDlYCVRcOVk1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIZHldQQgVCAlwcWg5DClAcXFZVHxcZUU0MWFsIWwQPH0wMUQJCBVZeWhEdBFQHXQVdVlACWktCBEtFaFwFXBxAF0gdX2pLVhQEDV0dRQ5WGVoMUg9bDhwWS1heBFNWDkIJSgVcB1kFQQtIAl4CRQdDCUwLQAVGXx9RGV4IUytHHkkKVgleCEYRWxRWQ1EZDFBNAUMICghHA00XXjJTBF8RUBY=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1793102504; x=1824638504;
 bh=i1q5oAa1VJqtKWCduTnVIouk5uzrslKrCLPJJCKmq6I=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=qiKx8V+QbAqHrGa6Vpyhmgm3vXP3UmRPe3c6SombebyFQ/rJazNh77tXK+WilCp4k/GdBrVWDmajyYqDuU0EyJ+DA4qcNgvA+W3q324yU3sYVRGF7WBKNdyNlJQ1GheuznkyIGeTYYq0SMjtcuSr+fxfn2g8BfBXjois3pX3ZOI4MrRrSbq7KuZ+XcLLyW0Uf2SlnoablAczOFkkYCfFJf3ybnAZI4S48snUJKJul2wQb9ESyNiv+3QamuIZVEU0Ry9tQezFa0rUXhzXa0V8OaWCV9eentNwx2j4vguFdgYU4PQjJpZ2221taHvXaWb0jCgwcK0qlvQdzJi5+T58IA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-8 (Postfix) with ESMTPSA id
 485391808305; Tue, 27 Oct 2026 12:01:40 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v2 1/6] hvf: arm: save/restore SME state only when SME on
Date: Tue, 27 Oct 2026 13:01:30 +0100
Message-ID: <20261027120135.53048-2-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261027120135.53048-1-mohamed@unpredictable.fr>
References: <20261027120135.53048-1-mohamed@unpredictable.fr>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=Jpz8bc4C c=1 sm=1 tr=0 ts=6ae092a7
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=-CzlRYDX7S5ZMYLRV08A:9
X-Proofpoint-GUID: O548y_AytylfjBf7oEoIR1aVpWHplUGM
X-Proofpoint-ORIG-GUID: O548y_AytylfjBf7oEoIR1aVpWHplUGM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA0NyBTYWx0ZWRfXw/kKZiULwdnV
 Vpgir65mQlLyqZ9DfSsQcXifTVStjDrYPSilyecZJLIgVnGHW7+LPhgN4WfK8mno2H2SJ23OdE/
 ILelqv+uGlvce00fWla97eB8fm1ntIUs+aWOhvSr2Xgba3J5Mh6Z/CITZgs+v2rexgRX6/gR54S
 6vJrPqWdBLfUWc4EX/7ZkED9YQNOD/HFT4uCpDnnY2diUATD1yZWtWcDpo64y9ezb1LcgWjTgj6
 0YFInys5BbAKuOGBBSWnLANaYgDWtJwdcUoOuKwUeb+hO/AqN9P8/+lZvQnEwj4fViC2TkCvV0T
 oKNOpPVbCqZxhVsxOmiAKGUi1vmQ7CLFcN7dx5V0ulVDmguAS5mmyzwI72711Y=
X-JNJ: AAAAAAABU7rEiBHvyAWmybFkcQ/jOm1mFm6JyOiQfFz3gMEqMmqxnBz8yMJTJD+CNkY6DKAumnMm+zSQ+kI6KlvmH5tpDWueCJPrh3NoYpSL8eb7eifH5SDJTwQA12jCjMPaCgnD5uSjiWZAeOsAlxzfezVIJidl6liZiZnf8eFZ6fJ/x3q2C9aepajJwnFy9jp/L/WZj9hVChmUM06PJWCbolcjDXQ3HFp/qbmWHrdeCJCDZ7ObGLE8UAiU0dRJwS5RnHzVty/hpKgPtbDV3F6EhWCWmikxsfoAs8Iagek2BspICAtv0AyIwso+zfIfSlgEmcVfzaqUSY8toX7GLNCEbkNHMRNQtr5Xu5sdI4T3zBf/HshNYKFzqGN7c8RZggWDSkAQqxLu0fDpYOyqXDlEolcHV0EAlknUpU0QOhQhSaoJfclGUwL+x0e3ziXB+asSAxG0IZArqjS0l+c/I1DEWAxfJxLj24w1I0yCvXdaJRwiPLKF/CB/jeBElml504bd1MVNW14buEmeXP22riU/ywy8o1XZyYtQr+cM5gqkgKw8+NBvGSeDPjL51N2tkrwVUGYQAwHK+C/HVPN51fzcp1wV3JMp8NZSZJCnUswT9uMbKQ3iLBZJkg9G0+dBZl7okoMKldbqsrYgty8VOhEYgH+KPDRfUROTzsBTMia0q0Z3oEkWY+39v6VdxTxrhsZE0LohyuiPg3PUUMkfrtbqbvQ3acYJJbg/yKBzW68uO4Mb
Received-SPF: pass client-ip=2a01:b747:3005:202::53;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

When SME is disabled as part of the CPU configuration, do not restore SME state.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/arm/hvf/hvf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index b00a7e1a84..6085ac2284 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1394,7 +1394,7 @@ int hvf_arch_init_vcpu(CPUState *cpu)
     int i;
 
     if (__builtin_available(macOS 15.2, *)) {
-        if (hvf_arm_sme2_supported()) {
+        if (cpu_isar_feature(aa64_sme, arm_cpu)) {
             sregs_match_len += ARRAY_SIZE(hvf_sreg_list_sme2) + 1;
         }
 
@@ -1444,7 +1444,7 @@ int hvf_arch_init_vcpu(CPUState *cpu)
         }
     }
     if (__builtin_available(macOS 15.2, *)) {
-        if (hvf_arm_sme2_supported()) {
+        if (cpu_isar_feature(aa64_sme, arm_cpu)) {
             for (i = 0; i < ARRAY_SIZE(hvf_sreg_list_sme2); i++) {
                 hv_sys_reg_t hvf_id = hvf_sreg_list_sme2[i].sreg;
                 uint64_t kvm_id = HVF_TO_KVMID(hvf_id);
-- 
2.54.0 (Apple Git-157)


