Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DCA0FCB61D
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 16:17:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyXqD-0004Gx-TO; Fri, 06 Mar 2026 11:15:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyXqC-0004GY-C4
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 11:15:52 -0500
Received: from p-west3-cluster3-host7-snip4-10.eps.apple.com ([57.103.72.201]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyXq9-0007Ao-5L
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 11:15:52 -0500
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-20-percent-2 (Postfix) with ESMTPS id
 3BF1718007AD; Fri,  6 Mar 2026 16:15:46 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772813748; x=1775405748;
 bh=NdAr8jiFn5AzUO3NtlP3Dsyqnl3XhiX8i1jilhhmbwg=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=eNbTOfblgoyTvghVKXtTZq4hrIJER11vCHuA7HUQO0yx5QfqfC+qjLFq8BidJvjVb3T+9kFW4brrrbQahJB4c+hXXe5KXa1JEYxS6hcsm3AsOeGwbTGJHBpj08gTybMr4EYiJcsUcmWygr9H8UKjrpWFphgMYM6D9QX+Ml9AtgsmuFRVCBq6abUNTF3sydaiX47R3rF/fw5JjGukn7muPlyvwmFywo0gtkgx43/mM6b8mMCtzseO2XDLQpl6OtuYT+dakPdd+DqnIMvTWmgUHMqXb8jM4cxn5yetl3YrnHbeWyWKgHiBfMnbcykB31S0MTWZEg7XeP0J2ydfYI792A==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-20-percent-2 (Postfix) with ESMTPSA id
 B51C01800794; Fri,  6 Mar 2026 16:15:43 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>, Mads Ynddal <mads@ynddal.dk>,
 Cameron Esfahani <dirty@apple.com>, Alexander Graf <agraf@csgraf.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v16 12/17] hvf: arm: allow exposing minimal PMU when running
 with nested virt on
Date: Fri,  6 Mar 2026 17:15:04 +0100
Message-ID: <20260306161509.79712-13-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260306161509.79712-1-mohamed@unpredictable.fr>
References: <20260306161509.79712-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: -_IFDDqr0C2MFIK9-OlgC2BuhvWpMXxE
X-Authority-Info-Out: v=2.4 cv=PZzyRyhd c=1 sm=1 tr=0 ts=69aafdb3
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8
 a=DEZpVyLLCdwXg5o-P5sA:9 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: -_IFDDqr0C2MFIK9-OlgC2BuhvWpMXxE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDE1NCBTYWx0ZWRfX0vkxhxB60niH
 SuF2hFIbPepqTuhpUbDgQL6+C1vbpj+T4NVGiJnhsrYyLDBcEC4UTxhFzfjk/P++iGYEuYIDOEp
 EZ7sjo49bYtQYzRwvq6qogQ9BM20efXiGpSJHKXfN1FjtGvlCaZ9N4s0ikm7HpFgJwnF/mgodt0
 70YCL4nfWbJWqb3k7w0VX631NiZlQtGHCCNpSpHog5lsFHQkW03yVkzhPOz/zCY7Q8W28gHYWc6
 PDUxDBd/dDXPko25Tyc1lUxC4YUuOnRP6pJo+/EWNK5vr5VrkCGd5EQbilL52RqgudZItrY8YVg
 P6tCdEY6oXTuPiOAEUGhlvbF/MN5hCWrc4Fo++JR2p/lDDgGOeKOiIbiJ8NC8w=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_05,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 lowpriorityscore=0 mlxlogscore=673 phishscore=0 suspectscore=0
 spamscore=0 clxscore=1030 malwarescore=0 bulkscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603060154
X-JNJ: AAAAAAABEV/a3bG1RgewmSf8ZszZHHu26FGxQn/OEB8Y4tJDwiZ3bNDoYtU0b2x/O/4aMCYPkEU5TJUXKoq8A/PBqYtvGJfC6A/lt40V5oio00wdvB7I7MnsW3mg6MsSi64fcYIjHfeUF115Is8l+v19r/35NikE9z5Xfv/iRlDziHfLVoTjPwc7hZeovFqOBFRFdWWmRgUT6L9fJvuVxI2xUdVHT7wX+RRvZGbEyj94Qpks85fyKsq5HeoF8nH4wWpqk0iFSgmJ0fD7cbxSW6EUzRjZO0Rey09i0/eeCzHDXuwgXO/MagNI45rBuYdJpIY22UI74t8MDN8rwDx7w8aUj3YoQ+r0ePWKCEcHZJMNblukP747wj4iPYBHrUSoCmZIpz+hAI/ALsBoIWG8H4+ituOHUFP4ixdrdfH6QHDTf49l8RFY/9LHFhFv30W9znya8M/JGMpzTtd4qMuCouOPa6sKDOCP1Bt4bYqbVAcjfQAb30HUkeMQfYBQNvC9+jWdJL4Bq2XEUD2n5q8gE8mAtS2XW0CQxAXZqJP5F3cTXfjBx5nLcgFlFtIcNZzoPMp527mj0ie20WIKPsaqSxSzjEXMcWzr2QJC7fu4+s+APsVuZMprqhAuDx1Ar22BZZertTCbnCzkkuok4ApQdBYS7c8HtoJDldXsQfTM1IIYNZzBWnOAeclsMnYwndBE1SGkci0dKKyV+zgWAK1NCX98WklPmcs+DBFeL9A+jzHyXfm5SziVKBzuy8h4SxjE2XOmfUtlM4wjNHTFyQqnOBTOGQewYii3Tg==
Received-SPF: pass client-ip=57.103.72.201;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.411, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.679,
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

When running with nested virt on, a minimum PMU is exposed by Hypervisor.framework
if a valid PMUVer register value is set. That PMU isn't exposed otherwise.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/hvf/hvf.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 926a88ce9d..2daa2ab132 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1145,6 +1145,10 @@ static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
 
     clamp_id_aa64mmfr0_parange_to_ipa_size(&host_isar);
 
+    if (hvf_nested_virt_enabled()) {
+        FIELD_DP64_IDREG(&host_isar, ID_AA64DFR0, PMUVER, 0x1);
+    }
+
     ahcf->isar = host_isar;
 
     /*
-- 
2.50.1 (Apple Git-155)


