Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59F87CFA761
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Nov 2025 10:07:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMNzp-0004sx-Tp; Fri, 21 Nov 2025 05:04:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vMNzU-0004hY-Jf
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 05:03:45 -0500
Received: from p-east3-cluster3-host4-snip4-2.eps.apple.com ([57.103.86.35]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vMNzG-0007tp-Q4
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 05:03:42 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-4 (Postfix) with ESMTPS id
 631F218010F8; Fri, 21 Nov 2025 10:03:00 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=zNv66cYWOjcoM4iD8mPZ0d3N5D4+2q07Wwy2NtrQNPs=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=B7d+8HQSgmiqoR7nsrbtjnxxlmSzNIcrSX/ugClggBKtfEgYPuacwDNpaVbtDwCz4Z9jpWiiBCppWOEVcGQSMMLtDiQZvkbZjWbOiULMPlKLDhqa5m5vtFdo2B+BqhelIlT2xB6Ejk1AnokUaFfF66qka5UBEz1oAY2iiPUnM1g5vf0qX+Z2GGrs0xqIIy0YG6Y2EdRjXuIPlVESUFSyMetf/djL57yHklaMDazzXf3ObXWQ9U/jG6YvsLl/eO0B25SarnFN+Mcm0AvP1SStfB0WWITXYA4ATDqrMFj3+SV9vNsyt/NM5XYo6e+qTqQ9nNzTsl+kko4PCus9S3suTQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-4 (Postfix) with ESMTPSA id
 85FEF18006EB; Fri, 21 Nov 2025 10:02:58 +0000 (UTC)
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
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v11 09/28] whpx: common: add WHPX_INTERCEPT_DEBUG_TRAPS define
Date: Fri, 21 Nov 2025 11:02:21 +0100
Message-ID: <20251121100240.89117-10-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251121100240.89117-1-mohamed@unpredictable.fr>
References: <20251121100240.89117-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info: v=2.4 cv=GNQF0+NK c=1 sm=1 tr=0 ts=692038d4 cx=c_apl:c_pps
 a=bsP7O+dXZ5uKcj+dsLqiMw==:117 a=bsP7O+dXZ5uKcj+dsLqiMw==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8
 a=2psWIPzlEfUqwKpUe20A:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: kX4eJg4C0mLl03m3KkajKk3Y2ciQ2VF1
X-Proofpoint-ORIG-GUID: kX4eJg4C0mLl03m3KkajKk3Y2ciQ2VF1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIxMDA3NiBTYWx0ZWRfX78n6xLxKIYVh
 zbEQOl7IrqUan20vUu/o3JXh3a8FHHmPNCpohp5P3mmwa/kHHW28hYLEHym8tIj7O0qzUnsYsJq
 evYqWuvevPNC5L6gawEFSTNrCqVT/N+4T4FGhidv9yU0YxVwSt3EDHcjjpda/Y7QmrkHQD1JnjX
 n7zO7vcaK9tqzknHi5LK9va5kttkRFldZdbOzqn043V3qvv5GmEj0AMi/0RYkxzFUJh5pksPGtz
 epl4h97d1tKXB/ONOc3RCx2cXBrzeSCMmwl8xYzulnMTghu0zJYkd9vSns3PNX757UFy/TutDLe
 0IBZZ8o5kU9YApoXWHr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-21_03,2025-11-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0 suspectscore=0
 mlxlogscore=988 bulkscore=0 clxscore=1030 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511210076
X-JNJ: AAAAAAAB4dMvDnaWZLDlgyfRQm7CMxQf0xcFRnkiZ9fUm3bRUfN5wsEqbKORBmMVT9MNXVfIwohh3dgkg/eZLdKvnpxIjSdxvli+IidilBvLYM/O7Nnis65ZEedvID0IwH9p9lE+V22an999rs897X0DqaHBLcwhD+RnYYeJ20AXsChAqVI1lmW9DRallgJlyh46GglJPBV28n3jEhHWQxK2BBs8OW4CL2en0w0pD+CnORzTQO9Gwb2fp02b/CVH4uRmwFvyoptm/rGTvC5vL5E7hXBjRKPFWdUUZp28D5EemrWzpDm8PLmZGoZ2xzluMAcUzh2+ncBdmUO9RY3ZnTeneXKlI0vJX+qbkBgWfw2BUDT8yx6ppB56puBGgF7rhscMRRRe55BuUsMfcsbOvHBDfm031tPqoZA+oQ0zV7nlnQ/flA03O0XAqjgIEcIBy6uNr2aTR8clqMgbY9Sj2Vo6WUR/R9m8f3qaVAlEoObKSDKa7SKuK+bJF5I1dtt1ASSJVnHpVdGRaH+/VoNiHUGpbA/zwf9zlu79NMRwI9EkVfCuIaxk18Kc4iD7Rsozme1R3VSH7/It/h+8EmskZyNhw3GM6oy87j2OkLgWFmhS39EV/4Aznue2wQwNw8b/gRByrsLFLOETg9ah/PRZO2lBrtyCqd+kEwcvHGgLhyxjG3sUl7RZH+NHWLsGPBHixoZ2K+aP+ZmTIw/RHScX4hDX5jlGvJeLt6C1I5QVL6jiTfzmCeOImy8oVoM6py6afNMvF4s+Swqgifkb5A==
Received-SPF: pass client-ip=57.103.86.35;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


