Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64A82C79F80
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 04:39:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2Lgc-0003mK-Q5; Fri, 04 Sep 2026 00:37:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1x2Lgb-0003kV-5H
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 00:37:57 -0400
Received: from pv-2001i-snip6-2.eps.apple.com ([2a01:b747:3003:200::5c]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1x2LgZ-0003j6-C6
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 00:37:56 -0400
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-11 (Postfix) with ESMTPS id
 1B04A180020F; Fri, 04 Sep 2026 04:37:51 +0000 (UTC)
X-ICL-RepId: 01a06ab5-7536-7e55-807b-4e94ffb564ca
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQ1OHVwPUhxEDlYCVRcOVk1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIZHldQQgVCAlwcWg5DClAcXFZVHxcZUU0OWFsIWwQPH0wMUQJCBVZeSQ4dBFQHXQVdVlACWktCBEtFaFwFXBxAF0gdX2pLVhQEDV0dRQ5WGVoMUg9bDhwWS1heBFNWDkIJSgVdDlsGQA1LBFkFRQtGD0kAQANGXx9RGV4IUytHHkkKVgleCEYRWxRWQ1EZDFBNAUMICghHA00XXjJTBF8RUBY=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1788496672; x=1791088672;
 bh=SAAhJ3H2QVqXPxP9xFvzhrNwYU4tUA9Y/vVN9m1tCG0=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=pjFON/qOXCJlgKuKL4ydOmNPTYRHMsLXMGgA6DMeBiEkTjVM4WelAgF6S/XPuO0n5so/LKEy5T85EXHYqsfd3ZqZRD6hm10gERwAw4CAIsEMiPv9tsStQwZqcHxhnjl/LmC9Hlb6s8PbcOvsOrUNrY9wSkEd0ilvOuLZ/1gYQbWOqbOsGzCnnde4bq648m2b/cGDwP3WDHbG9lkQq92x9MispPvC2mSJkX16pA9BQfZpMIjmv8VmciDEFd09lKQGnbb+mKlCFHDTNm18a+RTc8X4cVd1eI9387eI7+vSUq72HjttmCjiM/gzUGnIJc/g4jfJ9kAKbsgpYYLoByQ2iA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.156.192.29])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-11 (Postfix) with ESMTPSA id
 3C72B18000B8; Fri, 04 Sep 2026 04:37:50 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v2 3/5] hvf: arm: advertise EL3 support when VHE is on
Date: Fri,  4 Sep 2026 06:37:40 +0200
Message-ID: <20260904043742.96613-4-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260904043742.96613-1-mohamed@unpredictable.fr>
References: <20260904043742.96613-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: aYlCJEV1Ldo1DHG2Vxm0uowtoWT51zlx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA0MSBTYWx0ZWRfX419UHtX+/I2H
 KPECiwrZ8PISk82AotX6qvl6MHN7NecOIKAWWAlA/adxtHdxQeZP8hd40Yz4WK/TvUyJdogTUDs
 dSHpKJXr9CBmjezUqRP0kmBnuFF7fNyLs/UePYgZ2AaZ52HwcG0GoWA9eKCDRsEZO3DYU+m8BKM
 XZbEG6Zu2CeadTGyVIcKmtlN9jjqTpFnoyd269VHnRw8rNX3isu4PII4miZT3s0OROJDfDPGLRL
 TuJy8J+PQNVgjAYQz7p4be2TbTEzRWKSfOD1WxgK9SgJj8rGeXnTqd/idp1Q2+VqcAkt0lyGYG/
 xWVUuqzA2nuOBdkuPGEKPQK2GCJWQ+LVcWbjz8KCsLaT7jnBudMwWHXr8pL5cw=
X-Proofpoint-GUID: aYlCJEV1Ldo1DHG2Vxm0uowtoWT51zlx
X-Authority-Info-Out: v=2.4 cv=VKDQXtPX c=1 sm=1 tr=0 ts=6a9a4b20
 cx=c_apl:c_pps:t_out a=aW9mcIavGNWWFvFFKOxBSA==:117
 a=aW9mcIavGNWWFvFFKOxBSA==:17 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=w2zTNQtwA0PefuM-ELcA:9
X-JNJ: AAAAAAABAL0tmaLyDzIw1BaTnc37Tf/lg6JTQSVVxE22rzQx7iBKvCAgDtbnj4buYyPpKpl5WgYoYEurQQdsXmTjvRj0/sDyYJc7MFC9xSkP2f+QoxXMrUDH9x3pemW4ov7YWoFzTgW8pCfLsRUOZKZ3OkW1kjn3mF3HSLIl4v9voERXocah6A5ufvfAtxOnCg4mt56hfGFHyQnFuNHYQ7lag2K390L2znNAUttXsebFvEp8rOymLRGB+okYM9tdXW6YJqZ+jKGuoA+APXF5ix0115Fd1+JXgmRcvW6nd/BfLeSi2KM21lAaN58y5eLgyWp9EmrmqGNCETaGAQH0hPIr9hJGHQyJe7RZXSK3bmvZIIVjdRkJLQ5qDv2VVfsasTJ6YvflbGHCRiM0mSVMYXWJLigHhsjMT3LwV9YM+PBQSofE04b/q3gyq0P74NRGWG/zNdxhzdyJ3NvwNgPqiPrf2ohxj97tFs2nwSDJHix1UmVnj8rhkBE8q+dS7P2/HumIHIgsnhFPLjFFc4C/ka4h5FIgT7Lvp5Wle1wdx9DM49L56kW1Qc9ZYmYbR/NKEWyzKUTAxaFbTjRUzx1spCjFadeZIgtkghLfMTmRAniiKb5jekQmNCfO+LBvT0y9qhG+BbxxeEmSiw+Y1YvmJcHF0Ywz2BcAtDrhDMauRPp2aOPeGHmKT7cKZPjzSTpcim7iWvzmahVINOvO2pQSWxD5c9e8xjGQVyYWau4DSuX90rBLglsqkJWfFyQysnfRDVeyXd+fuOZ+nmjn9+mwq0Rh6Yb33AWCog==
Received-SPF: pass client-ip=2a01:b747:3003:200::5c;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.pv.icloud.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This replicates the typical KVM configuration, and Hyper-V
wants it.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/arm/hvf/hvf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index b61554e108..c54a92c2aa 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1286,6 +1286,8 @@ static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
         if (hvf_get_vhe()) {
             FIELD_DP64_IDREG(&host_isar, ID_AA64MMFR1, VH, 0x1);
         }
+        /* Hyper-V doesn't launch if EL3 isn't advertised. */
+        FIELD_DP64_IDREG(&host_isar, ID_AA64PFR0, EL3, 0x1);
     }
 
     /*
-- 
2.54.0 (Apple Git-156)


