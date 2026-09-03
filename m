Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EF61C624DB
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 04:03:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1yeT-0003cG-1Y; Thu, 03 Sep 2026 00:02:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1x1yeR-0003b7-63
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 00:02:11 -0400
Received: from mr-2004c-snip6-11.eps.apple.com ([2a01:b747:3000:203::1f]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1x1yeP-0000Q6-5V
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 00:02:10 -0400
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-10 (Postfix) with ESMTPS id
 4AD5018001E6; Thu, 03 Sep 2026 04:02:07 +0000 (UTC)
X-ICL-RepId: 01a0656e-5f35-7daf-8154-df76a1ed0b2b
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQ1OHVwPUhxEDlYCVRcOVk1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIZHldQQgVCAlwcWg5DClAcXFZVHxcZUU0OWFsIWwQPH0wMUQJCBVZeVAodBFQHXQVdVlACWktCBEtFaFwFXBxAF0gdX2pLVhQEDV0dRQ5WGVoMUg9bDhwWS1heBFNWDkIJSgVdDlsBQA1IAlgARQVED0oEQANGXx9RGV4IUytHHkkKVgleCEYRWxRWQ1EZDFBNAUMICghHA00XXjJTBF8RUBY=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1788408128; x=1791000128;
 bh=SAAhJ3H2QVqXPxP9xFvzhrNwYU4tUA9Y/vVN9m1tCG0=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=f9ODRvycbRqtaI0dsE20HPeUZpg7bII6fxSbCDEuijtIjXYdQPutAu5Cvu0riM//BkSJ5ZUdxe71VS7OkKHvO21fUX3lxkwptMHwZ2tYntHOihoui+T7KrWjSSqU9o3FN7gAY92yrV8yH0auzdH+EDxgaLjnU3BTX02s/S5yZQL3VVwa0tPuDK/kTtCW9PFOPgI0v9JwLRaHrlfjvcoyVfl63YIMQfJqic+U73ELEQ47e80VRNORQY1VAGJlTCcaL+0UB1nUq6tsUKdnjLii3leNH7BGCNka3u7rTuj+4153jqD3qaB478ZKfecCzEKFuT9DN1HhXEGHJBvrDP/dxQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.156.200.36])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-10 (Postfix) with ESMTPSA id
 A6BAD1800150; Thu, 03 Sep 2026 04:02:05 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Phil Dennis-Jordan <phil@philjordan.eu>,
 Alexander Graf <agraf@csgraf.de>, Roman Bolshakov <rbolshakov@ddn.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH 3/3] hvf: arm: advertise EL3 support when VHE is on
Date: Thu,  3 Sep 2026 06:01:57 +0200
Message-ID: <20260903040157.74627-4-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260903040157.74627-1-mohamed@unpredictable.fr>
References: <20260903040157.74627-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=b4a/I9Gx c=1 sm=1 tr=0 ts=6a98f13f
 cx=c_apl:c_pps:t_out a=9mRn2PO/+PIrVdEbaIuMPg==:117
 a=9mRn2PO/+PIrVdEbaIuMPg==:17 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=w2zTNQtwA0PefuM-ELcA:9
X-Proofpoint-ORIG-GUID: W32LxrAdRgXUnYIyS2LACCtklybW15Il
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDAzMyBTYWx0ZWRfXy6/DDBxso14K
 +5nXFMkHsyy920GqLU5qpCRsltza16fZNYdJJSBTmNFJKn8Iu2eBNJIKGfQHPrw0aWcQCBkFLrS
 ZghViAAmvifCKlqHjS9Jlel+q9Z4MLgfPkHfDSngXdIszduiB6ajbmjEAIVmRkiyfX/mbfMicbF
 7n6nUO3cGI9VQMm1awIZ8REOnU/XYqFBkDoEPspD6AIH5fl1W+OCjOzpdiesBzgD5iKrRK7SCEC
 7m4C7U76iFU1fyXle5o544nt5QS4jpqK88Z0QkTGTAutvhBj4ZRdKkgbGGb7qqwZiDywe+VcZy8
 RG84S5cQmqvL5axSnZRuuXMwWFxmmgghCUzGy9sbTknbCav14YoOnAKWaIyIlE=
X-Proofpoint-GUID: W32LxrAdRgXUnYIyS2LACCtklybW15Il
X-JNJ: AAAAAAABg8XRJ+TXUsB3G9TrYE5xSr2FvEEFCIAcDu5Dm6MFZDmfUm4PV5iv+SWE3T2MQ042VpPhHsqcwOuDJIa0MNdW/9npF2WAt9hfmuo6wqH8XSCvhF0fMOS1H5+TpxrdAPs77TbARuD4gQTlmGt0zjoydK+MtQYpkEjVo41w9H3wW34RGgAq3pfMdwbvN/wd4yQhw6gWL9T/nZIIR7e5Qkr5Y7jklQVU/wi7hx8dhvc8thv0n2/CkX+TuGfXpMN++ofan0YliJheGwAciI6m4FpulNz6HUnKJJxIHNsb5XdaOH8bsNjN5TO/WYjIpjm5TT8NRrR27thpE5vUBI0uODgTSC2PBRYkFUODhh6lDNTdrvxeyNNk5O2JOQGNf2/2hqzAUdZkiqlYxMH1Rdv5lXGDobt5W9QOJC857285OYLhAOm2l4x82U4HgizvynLU52lmHxsnsEoO3gig1cFJj1KJU+zE7GZCb4/NBfMVELKAvzrZSV7jm71wabbgwq2rsL65XwXBUl9EGjRGHQT+DcZ4auO9C2RdayQlAju2aLvHISmPxKTjucUBZpLBqJ9kmsLS0OgWft9JwnHFdiKxVyU3Hci0ynNs+kfdcpoqfZ7+3gCPYlGI5G6GXG8SQxG4laMIA8TMXPJa8J3HgAkp35e0RHRNht+T/Hv7Vz4uci1GzKastqgZ2VDnWtB5rD6J6DFHn72PJelugFwaMtCrO6xwjSGyibbD2RAdUx0xKBZ3S2gMAAOB6rwmcsfzBDNaev4oU4/gCM/+A4eikxFwWhQmgo7pN4I=
Received-SPF: pass client-ip=2a01:b747:3000:203::1f;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
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


