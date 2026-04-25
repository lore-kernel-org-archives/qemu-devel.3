Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BEB3FF885E
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Apr 2026 00:32:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGQw7-0000HN-8g; Fri, 24 Apr 2026 20:31:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wGQw5-0000H0-Mq
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 20:31:53 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wGQw3-0001AX-R8
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 20:31:53 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63OLpNhK4113120
 for <qemu-devel@nongnu.org>; Sat, 25 Apr 2026 00:31:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=tl/p2kFnZhA
 cE9CX6ZEC2lFso5rIi8YfUwbB+a7ctDY=; b=V6bnpGAJselSnbGYOvBUiiW+deJ
 zy3FKf4QMDgg2chOePN3rpF1vitybudk40RN+ySWu6D6taEWanu2S7t1ow2kc82y
 1yebvr7G6XEYplIfeWLO4b/xQy7NHam9CHhwo01s49dVVo9p3j66xa+hJO8mkOYW
 ONuJcNtx0+jhHOr8197fxBf6V0OKKYUWimCydP1GkV8oWBs6WwtIqnqkjDVxnm40
 eOCyqb5mU/y2JpeKdGye9zuyohIZQwidivCPzdvYvDIhdgY5h+uksXes6zB1un2V
 i5e05MCK0DvbJ2sTERHoxClADcXu3rHGbkoiDxj/VkqfiuLEeUSdT6WOUug==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dr2nrm3fm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 25 Apr 2026 00:31:49 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2ba9a744f7dso11027567eec.0
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 17:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777077109; x=1777681909; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tl/p2kFnZhAcE9CX6ZEC2lFso5rIi8YfUwbB+a7ctDY=;
 b=KG/UnmYlXM4TQCBKh4V/35vV5fD8JFo723M5CFhROYjnKTiwFVlZbdyjcVcIcWASzv
 X+4PMsWtuWCKkWM3fFoUuPZ7jryex8h0KfGs5Lf0bGt+09OIs0C+iPGrnxccr/CWfOd8
 rpiWuPvYqxkWsh3ua647aHnRiaUCcgLSsfzYmZJD0dpCsY5qM+o/1iD6h39OlKMSOadG
 AqSlaj7MaWYLe9b44iA+0aK+12M6KyEHviIq03Kc+YtofjJ5sEEpiXfaTA5ZlTMiIgUe
 HXIb91+wOk1bfyEN+DPhsL7tWsdFxym0gPF1rk4kCxLgCJP6R3JYYJEvOQZC4/UMQEkV
 15lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777077109; x=1777681909;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tl/p2kFnZhAcE9CX6ZEC2lFso5rIi8YfUwbB+a7ctDY=;
 b=l2KeiiTpz9jbc6L6LwvdS+SSwEKqc5GxzC0zEp8y88tlaDN1s82J75IuL2XDdRiJVd
 zwAXeXXaBPJ+HjPsqPHRoR6Fs7BocRmP8NDM6ej5d7XufUPmoyhLXGD2Emstbx7FAGUF
 EHCwyg/Fil/g5s315yUKYviy1S3A4IfbWeMEqfUyDNIyMnR/UTYpesr5Bwa4OxsgDOCj
 FtyXucLClhRZcJpakJ4mxuLTc9U83mo2W+Yr1Gm+PLujy2oKKpFy0kgpFvA4gCjpwNJr
 lk1LHOKryiX0QhnxYqYbFmO8gXhBUx9KWcbuLgrKnIKIa7JNYmEC65NBLJHKrM9OflZa
 6C9A==
X-Gm-Message-State: AOJu0YwKw4pzZvABoM7KQZnPlzSE2FfnZ4LAAh7fMRv4JHAU/vrUGoAF
 R4WqM92hbmjyeJZ6FPrwNnj/mnz9Vg4Kfl97ohy1TG/QVPovPCz2iQaGKGn/8sDuDT2Y8uVJJOa
 ofcYhiwWU88F+ZhhvxFZ49Y5JyLzLcFonPtXKryic/E0lbIFKYqG4J1WiDdFVa2LFwvmd
X-Gm-Gg: AeBDievSaFH7I1vVkPuGCKgfQkg5dw6MbXZYq1ZCteCeLFhP/flwjdjMfVrH/w6c/Ee
 iokcKKc1rQxN2AN2WjLky5i0XY+bo3Yx2VBBGSKgZ9xiUeqvbbM2yn/o3DH/k7+vgeU0Ci/3lUq
 nkYOk0XCaW5GOK7Gvp7Oh+Wa0i+J/rb22dXNRIF+pPX8byMJV2OjBFLq0M49M/8bd8jbGr/nLhl
 1ZQVgqcgFYNhLlMVoUf1TFPj4kD/ApSucCeUt+ilFm0uy95qJGPLARtj+4GFL6b9XAL/4nL/O/6
 YQBd8QdBT9FxgRgvBIpCrcaxHlRQCRpBSJCySQvCW4B5GPpggrG+o/ISCJq3uzjO8o2AePk4hiK
 fjDQLxpJlK9K4HhhQZWFs6yVmID4XOv59aLBBDn+ZRnd9gyofnKZTQq3X6O3HZXwXpM7Erv6ttX
 v9BqctmOzBzjp15jvB
X-Received: by 2002:a05:7022:6ba1:b0:12b:ee92:a60e with SMTP id
 a92af1059eb24-12c73f6c422mr15596220c88.8.1777077108776; 
 Fri, 24 Apr 2026 17:31:48 -0700 (PDT)
X-Received: by 2002:a05:7022:6ba1:b0:12b:ee92:a60e with SMTP id
 a92af1059eb24-12c73f6c422mr15596192c88.8.1777077108170; 
 Fri, 24 Apr 2026 17:31:48 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2e539fa3ce1sm32510323eec.4.2026.04.24.17.31.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2026 17:31:47 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 1/2] contrib/plugins/uftrace_symbols.py: fix symbols reading
Date: Fri, 24 Apr 2026 17:31:39 -0700
Message-ID: <20260425003140.1688666-2-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260425003140.1688666-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260425003140.1688666-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI1MDAwNCBTYWx0ZWRfXzJ74RyGIGNag
 iaBKtxzj+LOjmQzlDsQ8/oQnRMAE6SLLETvX7CLlhJ4tDVcQi8IG9TpY12FYIQJ5gmjAOl2+sd8
 dBHL4F/mTq5BDalNG5ocGdioAvqT3D0Q1AyUmDZpwgxUC1CEdvXUTJ4AenOhrrBweqPo8xLxIkc
 S2XJmVJFrovXGKF0yzSqAuWt+0UXVegD6shsx5e4hgiQtEGMLHBU7mD1UF0VznFMJ6dB21fNuvC
 WqU9moE1peSgilOwRKnkmphsHwRFxJCbiu2jiB8h5YYMEQAZg4j4BplsFGcej8zS+WgBhrSyaXV
 yvWeWuQ5djQH2X4GXjknAhNsf5Od1oyP6bCvpRIflkSFlLtZNPy0GJzw3lBm66gwdHX85ZXgeiL
 uZvgM3aabZ7ejADXN3LZjDg01+ZMtzvdgkw2nEuR8op7+47JsUZWzTyFHI5hi0X1U0QafcjGpUJ
 3ZB4149Lyvz3I8wQCGw==
X-Authority-Analysis: v=2.4 cv=UqpT8ewB c=1 sm=1 tr=0 ts=69ec0b75 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=t33ULwWO7eDJZn57WcoA:9
 a=bBxd6f-gb0O0v-kibOvt:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: zH1sDSAwuOB-5AM6I9GReZWNBQGNYtSZ
X-Proofpoint-GUID: zH1sDSAwuOB-5AM6I9GReZWNBQGNYtSZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-24_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 clxscore=1015 bulkscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 adultscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604250004
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

When running this on hexagon binary, we observe some undefined symbols
without any address or size.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20260424194451.1439316-2-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 contrib/plugins/uftrace_symbols.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/plugins/uftrace_symbols.py b/contrib/plugins/uftrace_symbols.py
index 02d1221228c..6eb999bca5f 100755
--- a/contrib/plugins/uftrace_symbols.py
+++ b/contrib/plugins/uftrace_symbols.py
@@ -36,8 +36,8 @@ def get_symbols(elf_file):
     out = out.strip().split('\n')
     for line in out:
         info = line.split(' ')
-        if len(info) == 3:
-            # missing size information
+        if len(info) != 4:
+            # missing size/address information
             continue
         addr, size, type, name = info
         # add only symbols from .text section
-- 
2.43.0


