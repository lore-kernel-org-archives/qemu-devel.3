Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86DE3CCF9EA
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 23:55:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDtQi-0001i9-CX; Tue, 28 Oct 2025 19:48:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vDtQe-0001gt-Dv
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 19:48:41 -0400
Received: from p-east1-cluster6-host7-snip4-2.eps.apple.com ([57.103.90.193]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vDtQQ-0004jp-TT
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 19:48:39 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-20-percent-0 (Postfix) with ESMTPS id
 077C618034C7; Tue, 28 Oct 2025 23:48:15 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=aRq3YU5535mG5uSPAFBSlmsbBJkL1R5+IAqIsTf/zZw=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=A3vakTCiIMpW6mwSHSnULiFJyWjLBPzI4oOIzY1XFMWXa2Jvst4+g9r7IgJY+W3rAmTvhVmFjvnqPhlLDoRTP1Erxsv6MwcCVm7a4jeoQj5Sbtl14VN6f+wxhd8/XdSVUmTwXKc8cQvFiwXV3IhCKaMoLxT45VUqsHhMWZ8GeIHxQfF5sl+ZFCZ1hQTr4oITYGdchY4wNUQH7xN+TeO+Fr6ZP1/PhCkUPFhAAF5sNnnWZ+W3jd7gUjX5GxxIEQiRz8iH2ntyfScdelTogzlZqABdc3C1l9SIHXihIAiZtBVUtZCBC4fI9OmxJB9o2wvdch2ow4j6kGgd8xvVAmcaFA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-20-percent-0 (Postfix) with ESMTPSA id
 D15E818034DC; Tue, 28 Oct 2025 23:48:13 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: mohamed@unpredictable.fr,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>
Subject: [PATCH v9 02/27] accel/system: Introduce hwaccel_enabled() helper
Date: Wed, 29 Oct 2025 00:47:32 +0100
Message-ID: <20251028234757.39609-3-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251028234757.39609-1-mohamed@unpredictable.fr>
References: <20251028234757.39609-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: irMAp5n1h27AZ4cQmgQc6G3uHmyV1OCs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDIwMiBTYWx0ZWRfX7Q4UvLa5B55Y
 NGmQvRK8k9AwSsz/acOj9ZC76zwTC/py0BRfq5g9Pu56pc9sWMjsyYrpIYM8FlLJLMEGL+KZ8Dp
 /fdZoO6qGsSTrl3ocr7frhOwFdHddwmptN9HBa1OPKfijJk1PenojZ0naEDVU8mctyehbosbqvr
 3licskB22ZnQjKV8KuNRXKVvRQuuEhk5jaMqbrzXd3vbtpyTBnfyvALdesqqhK6Od6z7ioK5n4L
 8+JZDKeq6WjxO9A3r2OlipreVweGox2lmgmIR/MHHBE5CRTIMaGDNjPyaRBjf5W9oXr1X4sgw=
X-Proofpoint-ORIG-GUID: irMAp5n1h27AZ4cQmgQc6G3uHmyV1OCs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_09,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxlogscore=999 clxscore=1030 mlxscore=0 adultscore=0 malwarescore=0
 suspectscore=0 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2510280202
X-JNJ: AAAAAAABvtwbKL8UPhaJphuapSy6pkdxwDAqDHfSyesqBnhp462ohAad2zzREiaTwHqR8+/ALWjnfi9SvUyC4ENdHZbOrTOjtzcR0vrSu/OBz1wWz9OKD1vSSVBAh8qHGh7sLMDQVpBbMXcShwsOOfQ6/dgnY8lode6T9zBmo53nFPMWoghJrxETaotd5cn8Tz4QoBaDF4LSZUNrpVq2PST8sliaYNuoi4gCcBK6GFXqXEMR5Nz1JYmTNYFa3kscrvUg4ZqTp+40TfqrsOvyopWv6ibiD5DkztBtZZJsVx9EHaO+tYbSwomadjkWo6JbJE/9hSb+gR2CFFR7NmkH1SEirBzvk6A+3GBbXDVr5D2iCHnuWwEMofuDxUz1Tad3eyzviSz6JMBg6KXSr+m8C2EHoi5FDzD2Zl46ljG0L2D+rJcqL5shseYnFJYhp1CWfZwICSqIKlxbHDvUEZZkhhzeMi/KZBWNNTCtO9D9C9K9s9c87wyoWEKzwVWiXpw30nEkoBRU4BvUwLyeCvuyfwQAmBue3GxCtED83ZILTXApgOCsHFNYQUzUuKC6IBq2/UHxHdCgA16HaMmoSHBWcChjdBT0r6kzFFvw2yixKnsuERopqqUIEIfnsR9xoYOH/D43RD9Vxn3iYuM4VQoDutepV82XJ8ivQFVEySN903FcRnX7ENTB2JM4iEejq6urMX28P0yKe9UaLyOCtZ3F6aOnqjTzsI9ghtZ5g6kmunXd/IfddlMcl66X5y11L/yUXL36n5G+PA==
Received-SPF: pass client-ip=57.103.90.193;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


