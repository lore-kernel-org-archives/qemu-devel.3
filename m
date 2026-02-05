Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A40BEA7955
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 15:26:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo1E4-0003lF-Ki; Thu, 05 Feb 2026 10:25:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vo1E3-0003ke-EZ
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 10:24:59 -0500
Received: from p-west2-cluster1-host5-snip4-10.eps.apple.com ([57.103.68.53]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vo1E1-0001US-SY
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 10:24:59 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-8 (Postfix) with ESMTPS id
 DC7EA180063A; Thu,  5 Feb 2026 15:24:52 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1770305096; x=1772897096;
 bh=rqevPYI5PNmYfO37aWp6zQDTk/Z3PG7nW7DuJwvRyUM=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=g0u2ajzyMoWO0b+hfaiU2gzIDP+0mGbuFzCV/K8siE/sEbs1x8fFrsZKBE539d4IfbO+rhVmHhJgViaggD5ReAM2z8c+cxfmGXLlVUUz38zMP3YWQrIfqUTJ2yHbolG5p9k6LI02dtCDhxNHJpOfNzmcy0GzX77Yen1DD8VUGmr2sUzCSNP5Th8cs4AUD0S7yKA5pEsMnFXDpMfoTiVrwJEtDvlKxRrGyofkKS6hJ+i3B8oFoWicGElQ3XAwNchr/NzE6qScukKQuUxH6wMYX3xKTjYPS1fUKEZz0uN/Q63v+toZt7YFsVq8Jlmu9z+INbAlyasGXIMlyY90Py5D7Q==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-8 (Postfix) with ESMTPSA id
 1AB481800632; Thu,  5 Feb 2026 15:24:47 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org,
	mohamed@unpredictable.fr
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Ani Sinha <anisinha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-arm@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Shannon Zhao <shannon.zhaosl@gmail.com>
Subject: [PATCH v22 02/22] accel/system: Introduce hwaccel_enabled() helper
Date: Thu,  5 Feb 2026 16:24:05 +0100
Message-ID: <20260205152432.78208-3-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260205152432.78208-1-mohamed@unpredictable.fr>
References: <20260205152432.78208-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: AlSDeaEzfbrrQKioJo_uPVAoTIeLtWtS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDExNiBTYWx0ZWRfX+UVDWcljjcW/
 ECrnNwNWLa4wMDQ7okfIXQzujQztdYYdFTb8G+7jlz5ZvFDxfmcS3hwsbGt1upMPQDwqsUdwgqM
 qIy4CT76fjMDxDXtmd7gtyYI3CddezjWFbSccu8r1E2R+mnvD2wva06m2AMnKSTF5AhrfPmVjh5
 y3RKnd5+1hQzWmkfen2APAszfWZPaYqv9C+l+G/Y5Tro4jHBGUjeZwk5wQVnmej3XSVeaaLdhMe
 NwegcAG54jpAnr4cF3yXT0KpQ2FB20sljmPFIIFQ0NIefA1lK1U3qalQZl1/de3fLezZn8wc582
 gsA2aHsqM5y/H2xK1OE7LTUO1ulJEKFWJVQcbMouxnY+XXofVFIVRbYWqvAmmM=
X-Authority-Info-Out: v=2.4 cv=AqDjHe9P c=1 sm=1 tr=0 ts=6984b648
 cx=c_apl:c_apl_out:c_pps a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=zYwLhoXY7WJC0OmO1EgA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: AlSDeaEzfbrrQKioJo_uPVAoTIeLtWtS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_03,2026-02-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxlogscore=999 spamscore=0 phishscore=0 mlxscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1030 malwarescore=0 suspectscore=0
 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.22.0-2601150000 definitions=main-2602050116
X-JNJ: AAAAAAABvSn2z5TjovZc2IXwNJloUR59FVqgqMpZCqGuaXPvs+9q+ze00o+HyWvrgiGOjX0kceeJU8LCV/pgO8dIoL1lZA6Hs+g8rUUQvisP4BaqEf318iarYV32wJFlRWaKkjn42JUESy9kHhQn498tW12DTfzUsVQ9SQ1my/eCPAUiSwTa4YiHjibrVQEFt/IhObbSYfzurBzSq8ss73rUOJJfehvhLJnmeII2XSRz/11s2MDl6wsSdU8S6w+bVTe2bMEatVteL8ygtGcDZ3kRpKKB9SQrDMIxiDCqmUM6VmzI9IKoTP9YyheOQFjM7vl//wpAQqY/R8bVVmIZHRq8WVnVzzeMIkyFz3vvlmT9kGlTr364J5f0HhmiuHG90wFlCeKEZOpAWis07sWq0gDjRTNoM6G1kYcZrM0t3J03N59d9v+MHtHvffdOcXbILgFd3gXTlP3IluugJ1h9C1EKo2XMrSzbE3Pt8gpDa0HCLhXKd6PbpH1DMCbf3qwQ9RYMO2+AG7XjeUhasirjwN7d1WA+PRBT93LBuMeavw4rj09SoUIXaGNyVRs8ePE51PG0RMg15amv1aSen53cGj05YxptFFs7GJj6C6BfKdqKO8A07bu1pSgciNnBatuef4+Ox4xWXXpwByZgXMahWI+ZpH5cPHINtWYpZPyS3Bj1WLlN9w4LFFUnEYJi89XE19cJoE7gj/4wqX26CDVPX+RgIYo+/xFWQVAd9xvKTl+xU/AKRnuPGXLEdH52FmzeVvCSspgCyMFK0foOvDUaAgV52bbGGEOZQLrtru8lJgWbXbcbkEOMqfBTzICa0MLBofndt/beJZFsHoS+nS0vJsifm/0V2NwdhDhtsQHOOrZiB6028gBHxLq4XJMNXcTbdIJwmmRco+SdP35sWIjGPJqXOKainVGnd4AwRiAuDUdBWXLqjzqfDMtPLFUjlJGrfdUEP5LiJ2j7bY8bLmYr
Received-SPF: pass client-ip=57.103.68.53;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

hwaccel_enabled() return whether any hardware accelerator
is enabled.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 include/system/hw_accel.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/system/hw_accel.h b/include/system/hw_accel.h
index 55497edc29..628a50e066 100644
--- a/include/system/hw_accel.h
+++ b/include/system/hw_accel.h
@@ -40,4 +40,17 @@ void cpu_synchronize_pre_loadvm(CPUState *cpu);
 void cpu_synchronize_post_reset(CPUState *cpu);
 void cpu_synchronize_post_init(CPUState *cpu);
 
+/**
+ * hwaccel_enabled:
+ *
+ * Returns: %true if a hardware accelerator is enabled, %false otherwise.
+ */
+static inline bool hwaccel_enabled(void)
+{
+    return hvf_enabled()
+        || kvm_enabled()
+        || nvmm_enabled()
+        || whpx_enabled();
+}
+
 #endif /* QEMU_HW_ACCEL_H */
-- 
2.50.1 (Apple Git-155)


