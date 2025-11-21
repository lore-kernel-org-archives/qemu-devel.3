Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C32DCFA761
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Nov 2025 10:08:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMNzP-0004eE-59; Fri, 21 Nov 2025 05:03:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vMNz4-0004Yr-9O
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 05:03:18 -0500
Received: from p-east3-cluster7-host5-snip4-10.eps.apple.com ([57.103.84.181]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vMNys-0007rN-6x
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 05:03:15 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-4 (Postfix) with ESMTPS id
 8A7AF18010CE; Fri, 21 Nov 2025 10:02:48 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=aRq3YU5535mG5uSPAFBSlmsbBJkL1R5+IAqIsTf/zZw=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=Vz1JZUk2fQzPWntCmktLG03tGBVAJIo+cN0LRiBjZSZtUJj7GX1Ca1BP3Yn8WzTOvDoAjXc79RURdTOCFNYqYL1VtYIt5E9xmpYqkT2KDQhi1HdRn5oZ3OoqMuLfbtSpohMkYaWHLeKshurrgpa/9amyevOc5Pu0sAHvSX7MuWPn0NYOkgM4BslDdh9o4Og49NuzdWU6ebjlUruYbPtNHJ5/CbW1DI+LcqEe3lJ+ei2SO5DYqCHkQ5lWl9yBxaMqwEU5UwwlHB2QQgatDhkS44BkLjcxVlUsyASnq+FF3UgH8t4YDXsTmWgYEDti0EZymOBnLomKHPgbXsbjCxKr4g==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-4 (Postfix) with ESMTPSA id
 4E49D18010C1; Fri, 21 Nov 2025 10:02:46 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org,
	mohamed@unpredictable.fr
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, Pedro Barbuda <pbarbuda@microsoft.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, Peter Xu <peterx@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v11 02/28] accel/system: Introduce hwaccel_enabled() helper
Date: Fri, 21 Nov 2025 11:02:14 +0100
Message-ID: <20251121100240.89117-3-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251121100240.89117-1-mohamed@unpredictable.fr>
References: <20251121100240.89117-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIxMDA3NiBTYWx0ZWRfX+PLJkgR1pqNF
 G0uJ2gnDMrOSWg9cHko1OtsgAHVK98g8BmtLk9UB3/BL9k+RLJahUcVnUEO3eUDPVDHznn8a6Mx
 6Q5gqRnI8HWc160Tns4zyXhKs4X3h/VfWKlIBixWo54fbcWVo9wwpm/d9udlRlJ/nHkA0QgpghV
 AiLravkk5YNFAeEmwPPFOcwFUI3UhS0rkJY6vJVTxa4IHEm5JHX4OBMC4ApvFwX52/TlM4TEy66
 aYlhfsfNtrFEerU1+cCqkuIYhy4EgPH6UUl+D7dwtlummRVxiT73Kpfmwwv5JJb4aXtmStXmFvV
 S0tIDQP6gYPYODU+kWS
X-Proofpoint-GUID: 8yv3uJwL7aBx02O25_5XxI0UMP55hlp0
X-Proofpoint-ORIG-GUID: 8yv3uJwL7aBx02O25_5XxI0UMP55hlp0
X-Authority-Info: v=2.4 cv=DLWCIiNb c=1 sm=1 tr=0 ts=692038c9 cx=c_apl:c_pps
 a=bsP7O+dXZ5uKcj+dsLqiMw==:117 a=bsP7O+dXZ5uKcj+dsLqiMw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=e3h0T9cBdxntahtQdW8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-21_03,2025-11-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0
 mlxscore=0 clxscore=1030
 malwarescore=0 adultscore=0 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2510240001 definitions=main-2511210076
X-JNJ: AAAAAAABL05m112SAuVGao9pjfBgCmjj+oZATzNjXYYNErUdKy9oFbxdOyf8qkBb+vASQGmIyE1ksmKzhLcS0jTjNBRCugyojlG1NmQIbTSZYPKuQTMTNfXBFXteCCiPkaz/Zu6Sqn1d8CS4ABOHKC3ojXdN4oioNmouhhRncL/nR8YYrkHDP7V4N6mpvKPgXqRj6dn6mC15iKdyi9XVGbS2dcZy6dq4mmhOuWMm9RdNOlG5a4ebqlVTvBKHplJgAeufpjP2UOOV3fZY2nDGDH+0dSNvCaKSy6788uM4fGqTgtLnQhiaD/SzHqPJrF7PjUcYvVEtQIdzrz/thTyjkt/whcjQH5IK0CM3Ky6cns+vWakZqyuxIit9qCd2Oudqamf8pK+v+F7kEtNh6oVThxdIYQ631vbgeLjCtcdMp69yAHkLfRFoT5Jhl1wRqKzTtVmuu36SC99akn0+d5ZS4gtiHHSCir4ZaIthlJwoo+zVnYrZtKrygJaFacjkkCxgvYB7+KiGMNMXNtw8NuK9BIx88D33TChmlCcX3+QKTD2kHY9CiRfg4U6rovN5OYGQqUCLNKYiM8TzbD2AWnXpkaluDQrkbUNFOhkyYGUso874GjHXQCxb8G4x96EMYHjXPhG+PwAx2DOgSPcpk2fa1de3uwEhaojtFIW5SnRK4AR9xCjzGmDN/mj4ThqHxEP/7swoIy1f33Ne6t5FbsLei1b4MJNENeYw8yK3HcqMAn7sf7q6PZYaNdLbwIxhvEPj7TL9CjJPtpjpfNp6Ok0JLS7wpeg=
Received-SPF: pass client-ip=57.103.84.181;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

hwaccel_enabled() return whether any hardware accelerator
is enabled.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


