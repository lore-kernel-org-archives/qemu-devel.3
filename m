Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD7A8C43602
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 22:35:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgrtu-00038P-7W; Mon, 06 Jul 2026 18:34:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgrtc-0002q2-9t
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:34:40 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgrtZ-0005c0-If
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:34:35 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666KE3i01626296
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 22:34:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=neHUG9CZSfs
 6TOtth22fpUMQPpmhJWzE9VMMwM3GkIg=; b=Vasa/tdo7THRqBspKZzyqFZrtBk
 /94Lh3QKw7aunOxgP0xDr6ZknYqSbpb1OlCh0uA7xpRyJBzY0yWnZ0A09T2V8o5b
 v8yjXNPdm/0JE+CrROP9BT8Eszu6LCMtLz9EAN0pNbWop//WbPltrQbJZ1tR7UZM
 hP+mgG10LnGXagEZnMQCHI8gIxACZxzBFQKUAGdaGP4N8d7CuBRR4ym6D5R/tCkN
 nmhHZj0QjbqtIUzYBVskMq2lZH65Tw45peZgat5kYeOuCdwevaWqiNUS7daqayko
 q7qo+ylY8xE/Vqn+rohDny9cVi0dIGA2qOPywaU6n8fRcYiUmwYrRoEcK/Q==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88h9bn5j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 22:34:22 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c9c26587e67so59801a12.0
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 15:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783377262; x=1783982062; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=neHUG9CZSfs6TOtth22fpUMQPpmhJWzE9VMMwM3GkIg=;
 b=kgWYkqMXtp2/cT9TAVeab5HDyyfeVlSMCJYwFWfVyRKqrMTTen0ahhzAD+vhY68h0I
 xv5yEb4HE2OzfEj3qSxBatX5jy6iKFHLi+cvxdXriVxJtKBs7Khv3Q25RkubqyoxRVsW
 myUWzKqQvtjCURiTl3Q9z94yzFgj5lhGuApsXlBgiviyMfDS0g/HoM+Wzh3T+Kd3FZBQ
 7yyEGQjI/Dl8kpnSa/duJqPVodTqGmFpYZPyQKYX4kCx5ragt2gM9/YrMas/WXE9QoD5
 Q+VLRAMPUxiDKvLDVQpRodmu69TZmY0hngTD3tznfNdJngigi54BlCRLa683bBsPJFgg
 +9bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783377262; x=1783982062;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=neHUG9CZSfs6TOtth22fpUMQPpmhJWzE9VMMwM3GkIg=;
 b=lvHTC6hqJDQhhMICVxCQr9uwEaLzzNr63ZmMloTQa+hPYrF9AncihotmklzyaoTYca
 mQQprnPYzHi0cgZYO02sMJBwgNyU4Ef94b7EqbY1soTFeFtx4Bt3rRtEuRMnn3c52v0M
 Vn7tqH+kpWGaJinMA4IWIP4dqoKIDy66koB3bQQdtQrgMAqIedRXdrc8i1cyQvg2J8Yf
 smCYPWme1r2dbayxl5w9CNym/oX3lfSJUcZF1srZReGFMTs75wzg0ISaMKmMRbuapucE
 pCeAJWqaqK7dhITsLtkONs3yVoKcgy4VPhMUNqgqoqnwOozYKEcJX9uVHybfuD+bpG65
 M7/g==
X-Gm-Message-State: AOJu0YxtxZDYEY9TdJvkiiW4PxXjOy3pNKU73TEuZki5IGGNlYH5G5R2
 AKNC7OQ+eaZ3rv567iBm6uoHZQFs/CnQ8oN2GwMEt57qJrcmoxUbzdI0eThUgsa+Oyoiol8/NIg
 aLGOEqLdilM2OkqswjzQURzA+7Ap3kqKsX32MjzlXxmOfiNF2ydjmCdGgEaLq7fWKLA==
X-Gm-Gg: AfdE7ckPLi/7Zn+/FvORx3MM7B9K5ykSs1WKOAZhKDOg3rvc4u/TXkVbT7tqnOFTv20
 18AYLgM87+vv6IMtuY5J+8etTno3ADtTdhQVxcHVSB4AJtNT8LBj2wrs39KzLGovSTYJTa+rLLj
 ZRrqFVXji2KZN4lH61qn3HNhrSS1K6cZ2lp/WZ2325iPKd/qs8o21wCQqNvYlF6QODWrsA86MAn
 afYFfhwAJ7B63yoW0TE4s2cBmQOkCFO/vHsWEqstScxogcRmn7X4h5/Nf834jrKrhONjcRuuIma
 rX7VUJfqX/l/D+ZBaAKRwgYqmdBT4nP+h/9MVE9Qgs9JG8kNINj5dhpkGxRjIiMTQeOJy1Jqfwl
 CWfSBZbX9ppeFGeTX1xSZ7qOSRE2cCzOOMJOWGfVUxGE5SYr3tgH4dpvGPA0KkKYn4Yrv4AN4cp
 Owl9gN1A==
X-Received: by 2002:a05:6a20:a127:b0:39b:bc11:9ec5 with SMTP id
 adf61e73a8af0-3c09b014471mr272859637.13.1783377261647; 
 Mon, 06 Jul 2026 15:34:21 -0700 (PDT)
X-Received: by 2002:a05:6a20:a127:b0:39b:bc11:9ec5 with SMTP id
 adf61e73a8af0-3c09b014471mr272819637.13.1783377261220; 
 Mon, 06 Jul 2026 15:34:21 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31174ac0557sm977244eec.26.2026.07.06.15.34.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 15:34:20 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 18/91] tests/tcg/meson.build: add wrapper run_with_input
Date: Mon,  6 Jul 2026 15:32:30 -0700
Message-ID: <20260706223343.988769-19-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Fs4mOWCNG9b9LCpqnIE8dRo71PFhUw9O
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIyNyBTYWx0ZWRfX1n4hkIUcqGwX
 b9cOWKNqYSv0SxdeHyXOFgKIWB+8vOdOpwqeWeWohT5RH9tGUPWgp+qoOKzPDveN5xuacq5CnKE
 +ci5AYEfwT5kq6rx3VUAz3+6tLUpxfE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIyNyBTYWx0ZWRfX2LNT12iH5zNA
 Ui47t33/crToxDR2CkDWjEnDVIQqTak6Cw4PiglyvtqesFPUcLZxrVpmlxeIFbIs+aaKPNG+FTH
 8jbeeom6E1buarXZMQntWOHdOGGXFql7uizadv2JBo/2hbGhv+ltpBWIqmIVmkQX+ZqnAjTu2NY
 XSRqq5NxWJoG0cRkWNep+By/Ip6bJgeodZA3c3TZPcHCbD6CV6EjFnX82CAcXA7yDfvj3h+nWVG
 B/ud8qBD3iAazYwt+fyBwRGpZjnM+2agL39z2T1Ovm/ONEYVJqmjkkxDaXDIGYvadfJxs0fNCg4
 ebngJSz8hgFA31FCI3KwqG4QWe9cohuIre404kmy9Sjk37Wgrj2bFTmhSLyXSQx4DsV8l+uYiu6
 HH9PPIGHR4QfheAAWjS8iynXwNSZRfkyxKIV5anIN+VbhMMdqMK6cQWez1bbGZXYA8Ap5t3wmiV
 1IFFhaqIyXmRuTpMHYA==
X-Proofpoint-GUID: Fs4mOWCNG9b9LCpqnIE8dRo71PFhUw9O
X-Authority-Analysis: v=2.4 cv=GulyPE1C c=1 sm=1 tr=0 ts=6a4c2d6e cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=xR2A3ow12ysiLA1IkLQA:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060227
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Semihosting console tests require console interaction, and were flagged
as manual because of this. This wrapper automates interaction, by
sending a specific string on stdin.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build               |  1 +
 tests/tcg/scripts/run_with_input.sh | 12 ++++++++++++
 2 files changed, 13 insertions(+)
 create mode 100755 tests/tcg/scripts/run_with_input.sh

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index adb11af7acb..30178df0f7a 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -8,6 +8,7 @@ endif
 gdb = find_program(gdb_progs, required: false)
 prog_gdb_test = find_program('../guest-debug/run-test.py')
 prog_run_and_diff = find_program('./scripts/run_and_diff.sh')
+prog_run_with_input = find_program('./scripts/run_with_input.sh')
 prog_run_and_check_forbidden_output = find_program(
   './scripts/run_and_check_forbidden_output.sh'
 )
diff --git a/tests/tcg/scripts/run_with_input.sh b/tests/tcg/scripts/run_with_input.sh
new file mode 100755
index 00000000000..3d280547c3a
--- /dev/null
+++ b/tests/tcg/scripts/run_with_input.sh
@@ -0,0 +1,12 @@
+#!/usr/bin/env bash
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+set -euo pipefail
+
+if [ $# -lt 2 ]; then
+    echo "run_with_input: input_string cmd [args]..." 1>&2
+    exit 1
+fi
+input="$1";shift
+set -x
+echo "$input" | "$@"
-- 
2.47.3


