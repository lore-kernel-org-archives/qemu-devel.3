Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5A80EEC2AB
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 23:43:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vufXV-0006wo-B9; Mon, 23 Feb 2026 18:40:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vufXT-0006wF-Ko
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 18:40:31 -0500
Received: from qs-2002i-snip4-1.eps.apple.com ([57.103.87.212]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vufXS-0004R0-5N
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 18:40:31 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-6 (Postfix) with ESMTPS id
 5DAE7180039A; Mon, 23 Feb 2026 23:40:28 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1771890029; x=1774482029;
 bh=XgFRpT3feuG6/cTAi1iAFTBe6D91Ph2uKDNsaSuHVhw=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=OxRZ20k+JhdCKnlMR4OnBp81CfxLlfnW6+aY2X/Sf85N4d/dfyvK4Upls+U6Le4NkRjqc3fuU/BtgCW+ktU5sDmYy/VUNZ6C0V2vQYfsjJUV2HuSljpaks3c3GnxN2FnZihbWvWa24r9BAoH7M6Q8FuQ9S47aiMA1CfSonugYnkeBUy2nZ7gWsvr2qtrIOT5K+NynE3IyAmQNBc7FW+dzhP1lRjhqVMIOKYCrQuuRVgzFA73eIW5EoLBX50/Gn1JLMAVnfkMc+rYC8j0h9p2YLv7F4QqU34jb+3oRobcuhjacLVwG26IwYdX05TJS+DMIVLuWF7/HJuSdhkhDsWwbg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-6 (Postfix) with ESMTPSA id
 69A9C180013D; Mon, 23 Feb 2026 23:40:26 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Bernhard Beschow <shentey@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Wei Liu <wei.liu@kernel.org>,
 Roman Bolshakov <rbolshakov@ddn.com>
Subject: [PATCH v6 17/28] target/i386: mshv,
 emulate: move the generic x86 helpers to target/i386/emulate
Date: Tue, 24 Feb 2026 00:39:39 +0100
Message-ID: <20260223233950.96076-18-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260223233950.96076-1-mohamed@unpredictable.fr>
References: <20260223233950.96076-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=Crqys34D c=1 sm=1 tr=0 ts=699ce56c
 cx=c_apl:c_apl_out:c_pps a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=BYAFF96DE6y5VNP45KIA:9
X-Proofpoint-GUID: YUN_NCllnVhhLAc4TovCUQiBNteu-2Ft
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDIwNiBTYWx0ZWRfX7nronBddq1L9
 IMhbZ9qbd83CI6HhPzn8ISc8PTC8xqE+8VfaKu9T95AZOBPyPS+CEu+N917YWSHKJL+kJE5mBwf
 3XIoKgG91uPpeaTFawYmCoyWfxngUtuTHKT7ffCaFn4+wDcEviJ2qjTZ9UkpTDCAtFtypnkjPoh
 HDYzg+vWXOndIWLQ393ytcHC6fEqfSicTmPpW9kXiDpRo2axwZJPJrUtpQRD41UZ0IQguq44mvH
 KdNlje0Sjyr7u3SK7tolr/vJHkr0+PPF49+T048GMnQvkjo72pwv81fj6UJczzeIuDec52PGsCO
 zK3poCIDsMtXaTbHKjgueq3d9nT77Q7ZSe5rlckpupL9kbZ8CrGLMCLK1PyfmA=
X-Proofpoint-ORIG-GUID: YUN_NCllnVhhLAc4TovCUQiBNteu-2Ft
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_05,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 mlxscore=0 spamscore=0
 malwarescore=0 mlxlogscore=823 clxscore=1030 bulkscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602230206
X-JNJ: AAAAAAABv08g9+VQC3IZ2/cSsk/z28NZRv1isvvML1DpbgeROqY3ZpsEPBprUBb6jijk7WTZCZBTZcgL+GctoZe4EJrcw+NOrx9NwDF2Wh8EKO4p9K6LQP9TXYy9553ppUiv3A4lQN9XFvJeaqfJDJh2WzXMpcMXpVGJV0uSonHg+ZeodudlT9cRkpp5ULRZO6Vz4zVHtqKmi9gL/iS/Gee7j8cVTKhUZyV20XNn/kfLC1YNfnqbb+Znt9zRushxzMHeEGz3LC9zgIzJqb8wvTzCfGkq1HZpR+gnXEss4cOAs3z/+8PpQMcdQ78xL6kRZlykojNKKYOHrEO8/hPCkH919QMyPARNeWdOXMKteifXUVEpOXGQ11/wZKlZNjZLzFZ+wfAUcSv04z992q1ZnPNbuOmdjIPkRHq6pn0VWgkupPiBknwNNNwMqbNSio23ZI2kSfc1gogTdFnfbxei0ieG16sL9E026C+pGAtxLrMKJdVRcug5TujVafiGl2UggFRpt4H4l0evZpXG8JABnoT9HBGnrQuU+CTlSRqvRwYt9e6uDZjR+7XbF7X8ZRhsAXq6eeJpGjjvgkK8zhdD5LIRAHp4ZbXmx1vfe+TIB1iEKjh7GkxUVc9wi39p5H+4JR8P4LuZD/rxNPP6g1+DKiXvnZ2mC8poWOYifq7jI2QclFpbg+4nYyPBvwIRAxVVbdwKxWhQWTyGV5gV90cKq+rJ9iYVtQiyTFaNtjMAX5cTR6Im5kdNaK6HQTv4xqz7qnW6kvQ/mDZtVqYt3JtvwQO2is8JIWCQrJ52LlEol8M1jQ==
Received-SPF: pass client-ip=57.103.87.212;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1.179, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.717,
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


