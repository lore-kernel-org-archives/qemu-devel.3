Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CA36CD8CA8
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 21:51:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX4JL-00079i-Ql; Tue, 09 Jun 2026 17:48:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wX4JD-0006x3-4J
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 17:48:31 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wX4J7-0008D0-AZ
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 17:48:30 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 659K4hmV3229325
 for <qemu-devel@nongnu.org>; Tue, 9 Jun 2026 21:48:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=eYH4V0CzIEe
 VpXJVnPZp7TO1QlnGAy5uVHmPTMef5SI=; b=CzeFlylXL3fcR1Ylrw0QdxKi/fC
 e1ugqiXsmD2tp5Sel71gc2GSh+FUCa+gtrIvbgkscmd034OlnQJm/tK8tUke9Hzq
 buOdtKFNThJqW19TTTaVemSN8klYs2GiE038TobvNTuuNAidUalkP3KlPdGY8yku
 6lr66oVvybfY3eYxn3XpK2Q4PknpP4OYvFt8qQnhhASqNfKecw3wu4lZAwLZJ8Xl
 ZVRIYsvQcEbrlsXYgBPPSKBfVgtKnh5mCPH5NFvUrydzSiJacQWD9rVaBHV7QVbD
 dGb6+4UZubAOUkeyREmj2FsHeyV7M+o1wzoh6T0wDmNxq/TUJB8/4UX0jjg==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epg3wkg2s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 21:48:13 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-137fe4a3640so8866036c88.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 14:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781041693; x=1781646493; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eYH4V0CzIEeVpXJVnPZp7TO1QlnGAy5uVHmPTMef5SI=;
 b=hUTFg9UhI1dHTtdckK4WMG947JxPHmrbNo2dIOwyhgjfMFzi2MuqGdARM7l9psEW5V
 5/lApeyfilfgkCe1iI5lfHjO5DDsnYsamPCwSpSSla7/qbPHlbjeB8oWQ/fAr4LkItDW
 pQYyk+ROPlE2AyBaQcLi0IiXJrCHu0eGEG2QhTvTGcernSN2A+Ekn9hb5vV7B637ZIXI
 aE/ApDjWO8wRU9+frynRDC6Qeo2cL+9zIdlQSdavJQ8VItCfB4354RDvrgaW0TmbS108
 X7b86cVpZ2trvZ0VVtEKAePhPE/TJCMAH3kg+3Sq/KOhaPagOEreaDD6dMK7t4xt/N0s
 J16A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781041693; x=1781646493;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eYH4V0CzIEeVpXJVnPZp7TO1QlnGAy5uVHmPTMef5SI=;
 b=VwfqtY+5EoiOr3Om5jPn5ogbVraeCsMyctgFJq2qfrckfPzpUvTwgSrTiLkqDzwZqF
 yJRBpeBSIdg1sOhv7g9ee7F+34zJi6vBXjEQbU8kWgu5Xqp9tP+rW/WuWEY0urhvkxED
 hYujlHuohC/P//FBWogWW5n8LZDLF88W1KDMrgl7XHDbmhXrphe/NoBLR7dfFRSZnZNL
 /ZYSqUGsqmo1W9KMH5x8TlSgDH4TA5RAgrhN2RZtS+2HWFa0x4hkkK78ZEJ3dCj1k8P3
 rdUvXwtPr2E+m0YLCTOfC3GYUU978nThqbBV/3K0DdZKESbFd/FYyagwj1IpXsEITUSG
 HkNg==
X-Gm-Message-State: AOJu0Yyzh+gJVxO3APSjjadBeQ+f/jHpLuX2BPvZbId6sfjkYAlcMs5V
 eRsUkV++/d1VdYZx1/7kN2JhEpFyWzJT5oRsg6WlvCBetP1qYAmmTEiJcVjJ66pj0ZFVp/23N+t
 g+nY2mBZcbwBuRlV/3CJxmtIaUiPzDrAqlhhwcQ+19NrTAzWnqTY8/HCRsMYMvIr3gVY6
X-Gm-Gg: Acq92OGg21+p8hM1xeK39K/DT6pT57rL2ZzT+4NwLnbrmYgAaEHOsTWGZECCM1kQ/O4
 huv5xI/Fiy2QS/kSHqlBsXac474KdmeQK2u4YRxlVilgClgZFusKTxSX2jXrvXmQzLcu4d8vBs/
 S+NYnQi2raAaNLemhKynXAe1KSi9TgkkOUC/ls1jABzTqXtWp46bCSPtr8T2VeRkbgX+yJczGVd
 IkbiVmWD+CGPgdppeWRmGJYghzBlG9EhVjwtxf3GcDX115O/0nCAeumisT8KIBYbJv7jLE1PBTo
 hcsM8eghqEfFe6KuzYfMhECb0p+XT67QRfGAqIw67+9s1t6yg/i161s/g+9gVvv0zatUbe/Rt1A
 CAHqVfemdjl5Y07V6HOWhB90WEd4Pm+wkGGdut6HFF7eNQ6yhbhdRPp8XuZOaNn0SQtEVT9MaS6
 6KqzbqGbOxM0ejoVGc
X-Received: by 2002:a05:7022:111:b0:137:f0a7:beb0 with SMTP id
 a92af1059eb24-13806713868mr12796666c88.20.1781041693040; 
 Tue, 09 Jun 2026 14:48:13 -0700 (PDT)
X-Received: by 2002:a05:7022:111:b0:137:f0a7:beb0 with SMTP id
 a92af1059eb24-13806713868mr12796651c88.20.1781041692523; 
 Tue, 09 Jun 2026 14:48:12 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-137f5550bcdsm17095895c88.14.2026.06.09.14.48.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 14:48:11 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>
Subject: [PATCH 19/27] tests/tcg/meson.build: add wrapper record_replay
Date: Tue,  9 Jun 2026 14:47:37 -0700
Message-ID: <20260609214745.772536-20-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609214745.772536-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260609214745.772536-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDIwNSBTYWx0ZWRfX/2WlqoTcJKvs
 5jMOUWbS0VrVfCevD9urvMJ4AA9+ICR7YOmgiCwuIgPOljQZ0ojQA+UdU6z/EuMOQ0XlD0Iyx3y
 f/mc4GU+xoZ+y4PSxZKnJAi0Cvi3K7KDl7ZyX00wCa5aDUG3ceTWH3dzCyzzn9LKjrhHlGkneMU
 AjYKjXdBFOUUTK1xw2A4akRLdqUczSaHdGmy6CDUbFgS0cO2dDaq8FcslvjEsQH3Ki2DvBw+xT9
 FwK0EkS5PYYsyibJ1YGZpZyFKN2Cb//5f0/niCVwfS764yXfrxKVWmQr9LkUC2fAyHX4v+hN23L
 xcwcDHuHU/4AZWIQfGWlEx4Wk6Pseu7d6OEoi1+XmqKZKFPVy7oQOx+mUC5fAE49mdMxOqu9P7k
 e3c0naPLg92W2fSjXprJrwPbgtBgW4sDTzN7+jExGO1AVii+zsEmc3TJ4IPuMD5MbpNaX2M9vXi
 WXjETIp4txknK31PbUA==
X-Authority-Analysis: v=2.4 cv=csWrVV4i c=1 sm=1 tr=0 ts=6a288a1d cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=B0LFpWwdb5_kycexZfEA:9 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-GUID: knnnswUDd6YDVJph1952o5EhYcw-P-d2
X-Proofpoint-ORIG-GUID: knnnswUDd6YDVJph1952o5EhYcw-P-d2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_04,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 spamscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 phishscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090205
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

Runs a record and replay test, and make sure the output produced by
both runs is the same.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build              |  1 +
 tests/tcg/scripts/record_replay.sh | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)
 create mode 100755 tests/tcg/scripts/record_replay.sh

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 7201a7809e1..f0efd46ee3e 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -7,6 +7,7 @@ if config_host.has_key('GDB')
 endif
 gdb = find_program(gdb_progs, required: false)
 prog_gdb_test = find_program('../guest-debug/run-test.py')
+prog_record_replay = find_program('./scripts/record_replay.sh')
 prog_run_and_diff = find_program('./scripts/run_and_diff.sh')
 prog_run_with_input = find_program('./scripts/run_with_input.sh')
 prog_run_and_check_forbidden_output = find_program(
diff --git a/tests/tcg/scripts/record_replay.sh b/tests/tcg/scripts/record_replay.sh
new file mode 100755
index 00000000000..57775a2d4c1
--- /dev/null
+++ b/tests/tcg/scripts/record_replay.sh
@@ -0,0 +1,16 @@
+#!/usr/bin/env bash
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+set -euo pipefail
+
+if [ $# -lt 2 ]; then
+    echo "record_replay: qemu_bin [args]..." 1>&2
+    exit 1
+fi
+qemu="$1";shift
+tmp=$(mktemp -d)
+trap "rm -rf $tmp" EXIT
+set -x
+$qemu -icount shift=5,rr=record,rrfile=$tmp/rr.bin "$@" |& tee $tmp/record
+$qemu -icount shift=5,rr=replay,rrfile=$tmp/rr.bin "$@" |& tee $tmp/replay
+diff $tmp/record $tmp/replay
-- 
2.43.0


