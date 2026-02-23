Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67316E98E06
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 08:43:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuRSW-0000jm-Ba; Mon, 23 Feb 2026 03:38:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vuRSU-0000aN-3e
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 03:38:26 -0500
Received: from p-east2-cluster3-host9-snip4-8.eps.apple.com ([57.103.77.139]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vuRSS-0002HY-Hd
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 03:38:25 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-12 (Postfix) with ESMTPS id
 56E571800170; Mon, 23 Feb 2026 08:38:20 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1771835903; x=1774427903;
 bh=XgFRpT3feuG6/cTAi1iAFTBe6D91Ph2uKDNsaSuHVhw=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=ZdZxqb+/uFsz9l8zJiK6qnmS0/4NcFMpzhrSgT0pYw2bPDmR2T0TtKQQaYWHlOR2isZca22Vlb9BdmfcfnOpIj3du2zolDIULChcS8daB9OzdWQOL34Y8n1Mm8LobKYgt21mY2M+FzTKXrp/mLAKwQkC+7SCyVlo4pSaecVXwbKO/E54dOnjo8FgUZLg7vOgPXx88Szln5gfTdnrhbYTlVfGzEnBM2Lbhdujy9qZDGHIULSuZ4FIPcm+Ys32r3ajmET6BCsaZlgjMfxHM1W4w1ZX953xtbkCh4mVs9vgEFvV6WVswqnCXEOkjp27kUtpHIVmkj1KyHqTY1pgDFn7Ig==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-12 (Postfix) with ESMTPSA id
 908B018000A4; Mon, 23 Feb 2026 08:38:17 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Wei Liu <wei.liu@kernel.org>, Roman Bolshakov <rbolshakov@ddn.com>,
 Magnus Kulke <magnus.kulke@linux.microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v5 17/27] target/i386: mshv,
 emulate: move the generic x86 helpers to target/i386/emulate
Date: Mon, 23 Feb 2026 09:37:23 +0100
Message-ID: <20260223083734.48533-18-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260223083734.48533-1-mohamed@unpredictable.fr>
References: <20260223083734.48533-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDA3NiBTYWx0ZWRfXzuiz5qm7sXRH
 cd+2+GkBFYO9pc9rwUYITV+yROnOt60f8FfGvz41oq4RI9r9JrySyGqNuFKU1UUCz8Q/Zzl6fr/
 vOIiIo3NOH12ALaRX+mxIIjOQfaqb/z8LO9awaxGrLyhWYXV61N8V34mC3wlRQ2kuAJ3OUnAcAV
 E8pS9PVikUWc5BKq5dUxaFhY4jAOZ8o2J/hcSZO1fbwIh4sN6j923iJBtFmjL3NZiSPAdv+nRvk
 KKrEFIWWGrVCoqpF4m1RPKLRII/667jfHKVuV8D1oQfH8gFNB5ihCfGZ5+ZCuH70GscbtnH0DPT
 34ncPDOotLmmCoxzPmWd09rBDTC2O37qkWpv0HxCaTsn5D6EkQKSb30N/pMZNc=
X-Authority-Info-Out: v=2.4 cv=NrTcssdJ c=1 sm=1 tr=0 ts=699c11fd
 cx=c_apl:c_apl_out:c_pps a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=BYAFF96DE6y5VNP45KIA:9
X-Proofpoint-ORIG-GUID: n-VTutPt0bIdWJwgLBviPR9XyLsI9S1e
X-Proofpoint-GUID: n-VTutPt0bIdWJwgLBviPR9XyLsI9S1e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_01,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=823
 phishscore=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1030 bulkscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602230076
X-JNJ: AAAAAAABkykzqFoYr9rko3N4BO/WIAX99mXTHfCu5Hb/k8ErBhb4MBqitOj8N/wz5ecF/lo+EG06oJcJ0oy7eHGRt7akODdC2WL4dz/8mzDLLg2mjYtQUnvQGgHdDfg7Y5h6PnVIHFm5w3TluinxNqd1nC4EuQI2qDT94CMT1QsSU5QPbuvwd64jkvrRRpjgJOWJMkWA6fk3S4f5JFvVLpXn/SZQCI0FV6ZPHOjeD6VvPi/gSK7K7FA+U+cKNW63KkipKJ4CBoLyYIpmgFdSuT8kl043DAzzhDVaOcHP/ZImGB60vfC+qLtMMHe0fMLVEVq8iBKUL5L4qMMWskEHOgqBhPyb3cViAzeUgmHawQW61TYNbhfRRZBqoJYljANEPUecMMx34tfbOB28eNtFX/9CqTwNf4/9o5BfVhxhZB+o1me+4QbBMyPvgT/jsAPnnsAXe84WKNk+6WkeBQjTDYIIrw4OLMovgszMGIJlMTm21VvSjYV9eqnCCkx48Y1PnVn1dgiZbAGmdRBkxHU8KRZiRjeHrJKVSYVE/++3T6pqNg+F3qI/OdyVzS4DuLNhlOvfnIXhrGJAY501R+s7XqCwXyH7/RcJMxIiX/TOI7pPBG90WPJ5DGk6s6cnPn6yyNUCXwqk28YrS66aT3qezDpHH98i9No/vUfaQjsM5Uxq/FMjk+2uiiWrh+Q7Qm540U0zrOwimV7i5iOvqkZ2OV9m7rzQNpNnj2TmHH4Vgk4DwsyBaBekIlQRJleMgZBgJM13qCXoDex7uRGqH5bCzAQVr1CSdCSA3TgaOWsTzFUIjAZRh+e6x4aevVGnpXw=
Received-SPF: pass client-ip=57.103.77.139;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.798, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.79,
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

HVF doesn't use them at this point, but move them to common code as that's what they are.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/emulate/meson.build                   | 7 +++++++
 target/i386/{mshv/x86.c => emulate/x86_helpers.c} | 0
 target/i386/mshv/meson.build                      | 4 ----
 3 files changed, 7 insertions(+), 4 deletions(-)
 rename target/i386/{mshv/x86.c => emulate/x86_helpers.c} (100%)

diff --git a/target/i386/emulate/meson.build b/target/i386/emulate/meson.build
index 1bb3516249..1fa1a8e8ec 100644
--- a/target/i386/emulate/meson.build
+++ b/target/i386/emulate/meson.build
@@ -5,6 +5,13 @@ emulator_files = files(
   'x86_mmu.c'
 )
 
+emulator_helper_files = files(
+  'x86_helpers.c'
+)
+
 i386_system_ss.add(when: [hvf, 'CONFIG_HVF'], if_true: emulator_files)
 i386_system_ss.add(when: 'CONFIG_MSHV', if_true: emulator_files)
 i386_system_ss.add(when: 'CONFIG_WHPX', if_true: emulator_files)
+
+i386_system_ss.add(when: 'CONFIG_MSHV', if_true: emulator_helper_files)
+i386_system_ss.add(when: 'CONFIG_WHPX', if_true: emulator_helper_files)
diff --git a/target/i386/mshv/x86.c b/target/i386/emulate/x86_helpers.c
similarity index 100%
rename from target/i386/mshv/x86.c
rename to target/i386/emulate/x86_helpers.c
diff --git a/target/i386/mshv/meson.build b/target/i386/mshv/meson.build
index 3fadd4598a..49f28d4a5b 100644
--- a/target/i386/mshv/meson.build
+++ b/target/i386/mshv/meson.build
@@ -2,11 +2,7 @@ i386_mshv_ss = ss.source_set()
 
 i386_mshv_ss.add(files(
   'mshv-cpu.c',
-  'x86.c',
 ))
 
 i386_system_ss.add_all(when: 'CONFIG_MSHV', if_true: i386_mshv_ss)
 
-i386_system_ss.add(when: 'CONFIG_WHPX', if_true: files(
-  'x86.c',
-))
-- 
2.50.1 (Apple Git-155)


