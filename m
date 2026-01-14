Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66E79D37E3A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 13:44:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vg1AS-0003hb-RW; Wed, 14 Jan 2026 08:44:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vg19v-0002Ec-OF
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 08:43:40 -0500
Received: from p-east2-cluster1-host5-snip4-10.eps.apple.com ([57.103.76.93]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vg19u-0000rf-8J
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 08:43:39 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-2 (Postfix) with ESMTPS id
 A6ED81800740; Wed, 14 Jan 2026 13:43:34 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=8BCQd7Pm/bl3RBBACCAJWlsvec2RfbtyFInvh6wrHr0=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=VQkxYNsZI3/pH/Dza32og3Y8yN/6n/pi/GlOvJnWPRVfgiD4TkIHRsa6POBuyNZD2yGQm2FWClgWl1AbBqTv3+qq5tuD/6c2sx4xxT8vFY133odQ6wzfyJv1o5nFYoV3A2gj9V8lTKrw6y5gUXff3Ucljqskg/0FVSvhjhEBM84nqQylyfyGOBr3T+xBTI62lK1LzxQWGPWv1Wl89yWdCiGpZp1fvRix0r6f9jxp4SfKvU8QUG6KeUzaUg/5XkcbjKBnseu7Vkcpx5inX/GMM0vywiUgRUuKaVI0GOIfeRuqFZRQcyAs57OnstM2PGQyunp/hm+otSTCIulBpXxfNg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-2 (Postfix) with ESMTPSA id
 D883318004A5; Wed, 14 Jan 2026 13:43:29 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: mohamed@unpredictable.fr,
	qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Yanan Wang <wangyanan55@huawei.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Igor Mammedov <imammedo@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Cameron Esfahani <dirty@apple.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v14 25/26] whpx: arm64: add partition-wide reset on the reboot
 path
Date: Wed, 14 Jan 2026 14:41:42 +0100
Message-ID: <20260114134143.26198-26-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260114134143.26198-1-mohamed@unpredictable.fr>
References: <20260114134143.26198-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: _B0qRhueegl6KS3v5-dfDj5EJBGD8gVz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDExNCBTYWx0ZWRfX4NiyUlCHD2dp
 3l1NK4ZPrc34oQNJhiyjzzu028VKOnV/GP6ifhRyVTsJ+h+bQjEfyJ7nB5DvhMy4qTaZbpfCmpC
 hK4csZuC3anzx7vaqHUqS1nXEb3OOE28+Q61MOa8NQK/GAEM6SsCx5FXTN1eF/hUcZZpAwaVWq0
 n8n8ZitgBHJUuiJxNR/we/CvdpvRUN6AG3dgG2KDJOyF4B/8B1xBYB7YtdmIsT28l7+RWR8ipa5
 DUK/cpzSYuufBCujZfgU5lD+HrHNO+dOBwTWaeqJPWR4d9GPL5q4nrjnsxPboUswciGPtKlw5WM
 Yh6TN4fBEENP+HD+JZJ
X-Authority-Info: v=2.4 cv=GZYaXAXL c=1 sm=1 tr=0 ts=69679d88
 cx=c_apl:c_apl_out:c_pps a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=h5GvOLqLgfJ3vAEETv4A:9 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: _B0qRhueegl6KS3v5-dfDj5EJBGD8gVz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_04,2026-01-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=932
 phishscore=0 adultscore=0 spamscore=0
 suspectscore=0 clxscore=1030
 malwarescore=0 bulkscore=0 mlxscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2601140114
X-JNJ: AAAAAAABh+aFZq9+LeBi/jRHtiOK9fNicJk4zKsYl6qpODiP+vZC19vU9aRTWVbUhkppxo4En2hkIneiRHpJQOJyddvoGaD2S7kc5gp2YMhXkZDp4TsLDZJnO0RxG6pt7y+5Jg2q+RlznFV3Bb9nugyUrZCxu18kRp73X3ycUXYnabWRyGciUw49RcGVFViDJjx6uqDJ2y9AWwzSWAiOmcoLeLxqz7xAX2DClb7GiTVt8YA6SOzVoE7KuX9i+LMQk/X+MzXDGsmk/6PiewJcmoSEHcfWOA4+YnbhZb8UG3NQ+jIbDVfTxTpsHGQFHd/FK3v7NLK1sxCoD9FdsvG8dmA6WAf6Fdw/lPr7k7HRHD6vyfxZGCo2DzChctboheRs8LGeBuFQbZ+JBBPMotWAei9+tDJFrg3v8cvEi4bdE6iOWNUVzVB1kLto8k++UTND7M6I4LK/xPtwivPa7deTmOWgM4TBfTD4sUOTO58ReHQclTBfcqm4F6CpeStBPdAyWrBxsjEhz+dQ1MwHpaMbw9cTcvNUfGiuFQK1jNkWpbQdI6/AmKdNwoB8N7NuNPWoM9APXs8SJnZkl696Z2QlvOwFSw4buJVSpLQdOkBn1oTEcwd3zkTjWB4buS6a8x/ZEUfQfVLKL2U0m+7IHFKid3QqnWW7mXodvGvtDdNlHPgWGCJoc1zX20bSQOwum6CECCMSwaPX/46QBwv8o//GQmRqOciTHH5ks1xAtPVh3hBuFOFY28nuHFXsHNgCatgQ0yfQ+7eP2RG2F1RnvJPhEeUqL5g0IZsmp8vkIEMm2u/34ajKM4RNkWzitJHtJu642XnB3P3pGgy1jJCi1NpT1H53JlmuYID7F93tJPq1MsHsIFE6QVauXIOLd5ZfmbSo8Y5y6wm0Kt5unywRqFkk2/MmiFDvDs6fWiH1Pu6KDemI
Received-SPF: pass client-ip=57.103.76.93;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This resets non-architectural state to allow for reboots to succeed.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/system/whpx-internal.h | 2 ++
 target/arm/whpx/whpx-all.c     | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/include/system/whpx-internal.h b/include/system/whpx-internal.h
index 8ded54a39b..ad6ade223e 100644
--- a/include/system/whpx-internal.h
+++ b/include/system/whpx-internal.h
@@ -86,6 +86,8 @@ void whpx_apic_get(APICCommonState *s);
   X(HRESULT, WHvSetVirtualProcessorInterruptControllerState2, \
         (WHV_PARTITION_HANDLE Partition, UINT32 VpIndex, PVOID State, \
          UINT32 StateSize)) \
+  X(HRESULT, WHvResetPartition, \
+        (WHV_PARTITION_HANDLE Partition)) \
 
 #define LIST_WINHVEMULATION_FUNCTIONS(X) \
   X(HRESULT, WHvEmulatorCreateEmulator, (const WHV_EMULATOR_CALLBACKS* Callbacks, WHV_EMULATOR_HANDLE* Emulator)) \
diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
index def85988e7..e1611f8660 100644
--- a/target/arm/whpx/whpx-all.c
+++ b/target/arm/whpx/whpx-all.c
@@ -497,6 +497,8 @@ int whpx_vcpu_run(CPUState *cpu)
             if (arm_cpu->power_state != PSCI_OFF) {
                 whpx_psci_cpu_off(arm_cpu);
             }
+            /* Partition-wide reset, to reset state for reboots to succeed. */
+            whp_dispatch.WHvResetPartition(whpx->partition);
             bql_unlock();
             break;
         case WHvRunVpExitReasonNone:
-- 
2.50.1 (Apple Git-155)


