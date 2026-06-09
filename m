Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30E85CD98C6
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 21:50:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX4JQ-0007Kk-Ma; Tue, 09 Jun 2026 17:48:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wX4JD-0006xH-CC
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 17:48:31 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wX4J9-0008DL-0C
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 17:48:30 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 659K4gCt3167742
 for <qemu-devel@nongnu.org>; Tue, 9 Jun 2026 21:48:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=snlS5uMJx+h
 0aiTu08VoOdBNINufa/tcLpfDL/Lfixc=; b=HpiLnh3qP46K2bN8JDqU0fwLRay
 7BN13UlYwUeu2ZGXXMuuQI+KHL0PTpdWokbxCPzRZPXK4eT0teS8tcGsNRuETPxK
 zbZifbb6RxWI4riakB9EfodSTCVMLopjpQ0+vhYc1ru0C9Iu0X3YgU/omIpkrlRV
 BAbtXSR0wyPz2BXSD3apw55RKvqkD3qyUxpBUBZ0yFawffTLrunSIJiC3SpYJXeb
 grcEYQHkl9QVa+sNbQFhGzFhtw38oD6mkx8i9BQdluR/HBX/Tb6vfOqDHwT2hqS8
 YBOXt/Y4202uuVHtwG5uZcalihHls3lfAG+ZrtIu9FItMaV+yOszpnRVC6Q==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epenrc0dm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 21:48:14 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-1383975f18bso52991c88.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 14:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781041694; x=1781646494; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=snlS5uMJx+h0aiTu08VoOdBNINufa/tcLpfDL/Lfixc=;
 b=c3gwLroG7dU9ATY7YOXlcaolcY7Ks2YeUu9il8DXOozR9x2MwGQT0jkx0fuXcjnoxC
 WK+U5VOed/w0Cj2Kpk7ebB1/mJG4LPW8ivBGrpvjE5yCgdTZ6i5tnBuKanNp7o4yXWq5
 5BnjGIODmXDDg7BLvVbPkqhcc2KoI59KA46/9fXXDcCKFIX0PXjjB+N2r5NHPGADvg6C
 E+vsdJ9ACnhPiyVJK9/hvDe01z1GYW6ptXprSk3FkVbkBljal7ui+p4SYko6+USBnrcZ
 Bwxrvjx3VJQYhu4NRQX3vz0xeJrL8WQl0uBkuYSoQHvupmIAEK4LOD2M1G9LwIKrSWla
 vj6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781041694; x=1781646494;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=snlS5uMJx+h0aiTu08VoOdBNINufa/tcLpfDL/Lfixc=;
 b=rsM8Rw0rchNAClADjasXVIwSadPSpE3d8dNwPX/9ZJeAwywf0XoH05msZ+zflUEkaZ
 5LO1YE62HcnK4era79K8eczXkn8Fc6ye2wLiUdWlayq/lHAnamTbQyT3lO61CkFFeNg+
 vjvpLKKofgqbTLoCiwfe15IsyDLAhuPbKXS/A0zsWxAB+SLPq0odHS4westgV/ZmrmIX
 kfETjHDczEVWjWucUCV3dVi3ADYDLGDGvYymUP6tdABOBjS5XSNmmOzGYQzzucpb+Lhc
 VcmU2oE6AYCR2tt/uesNb+pd+QVhJ+ci0rY+5BQGfsfTv0mj7cLv5dguDB3u/8VaN/IV
 0gdQ==
X-Gm-Message-State: AOJu0YyHQvPHBCLDFBVFukA2LSPcOtC9kotiq3JaBf8sbSKqrfYIosLD
 5+VFZDTC5QnVO1cq95q3DZQL0LWW1ex4D8Ok6mkjiHRFqoeTelFvaqm+L7NxXelJUTjeSFObZjw
 4Q9r2nk0ymyhGPxDALAqklZv9At9s4rU7zLBO6VOJe0DjeYWPQvm1LppdS5jkI5qX2NKN
X-Gm-Gg: Acq92OEtLZhkixP/NZSPgj7Zxmr+oQNli7E3ZqWVTqe3hHCoDGXtFJ5bXQKjpKBKBSF
 ZROAuvLrAXRFTHnW6WqGa/5cGnBre/mguV21J4lQtIX1IJl8u+66RAoiOowQMQ/kofn8QR2iI8+
 AkQ9cm3culuUuuQpTFJZqrwOrnZ4zAfFS7AzEkDDQnY532+LB7u/zx7c1Z4yzOyPrnXM4JzI7qT
 e38M2biHcgngixmMuBQ3XBw2p2yttMxASPxaXUFkKB6M7vzerYrBvjJil+Z6W2nlCQTaMB/dj8r
 +XcV1eS5nS3VnVFUm+ZpTw09mBH8mtX/CQhcvWHGz1++iA4a2beoSXuDE4mAhnyZT3aJgQpJQyn
 C5013NPxdlV1R0kJ3e5jqatJrD4Y7/NMB94TvcqzbEK3V/dL6cG1uGebrZAg9Pu3AMU/vCnKpuu
 uLcf3gRNaLNJmMw+5l
X-Received: by 2002:a05:7022:11c:b0:130:68a1:a237 with SMTP id
 a92af1059eb24-13831bd7475mr3440211c88.35.1781041693796; 
 Tue, 09 Jun 2026 14:48:13 -0700 (PDT)
X-Received: by 2002:a05:7022:11c:b0:130:68a1:a237 with SMTP id
 a92af1059eb24-13831bd7475mr3440186c88.35.1781041693351; 
 Tue, 09 Jun 2026 14:48:13 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-137f5550bcdsm17095895c88.14.2026.06.09.14.48.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 14:48:12 -0700 (PDT)
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
Subject: [PATCH 20/27] tests/tcg/meson.build: add wrapper check_plugin_output
Date: Tue,  9 Jun 2026 14:47:38 -0700
Message-ID: <20260609214745.772536-21-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609214745.772536-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260609214745.772536-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: JN5fitrs5gZTf8dDwUAVpY8fS1lCNg05
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDIwNSBTYWx0ZWRfX0i0kE+42hdbT
 YE/0uf3YGLsT+H3Gw73tUhb2eK6miTSEe3j0zIKcasKWLkpAP18eFh2ZEwNdRnGYKAFLbog6ulZ
 vapnmDOcIsXCeEPBsy5Z/hgsPDYZmOJHRRroRNNMp8Zb9qYNAhsZvzaiGg6Tu4YLG6AY/bI7MKG
 GnoCOw7tvOfmuqdetp4zpXFdkwxD6PEJUIk48YO3/175TH78SxrQlfTQiEBAyc9/jjkdTxmW+3d
 ypEz36NaRptycLthC76fJOh2CuJfiPs7f0hMaZ8NHTVBsd1ouWwFfxO+YnB8QEJPDxvGnhTNKVI
 3kguEQWutQP/U4adu5Up/cDpkRy3XOkBLGjUvGpkFZjlkHciazun/zg2Z5T7gr/NuBVtu5iN3yR
 XqBU7yHK5rgO6cTrmwqJ1HaeAzdeblI1AcTMwTC8tp3oSy0iurpExLxwsxR6oWjipoHgoB6WW4F
 bpDmpw8czbVhm0ZJAVA==
X-Authority-Analysis: v=2.4 cv=NKPlPU6g c=1 sm=1 tr=0 ts=6a288a1e cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=hdZq433CFCy24dSF354A:9 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-ORIG-GUID: JN5fitrs5gZTf8dDwUAVpY8fS1lCNg05
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_04,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 impostorscore=0 malwarescore=0 phishscore=0 suspectscore=0
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This wrapper runs a qemu command, record command output and plugin
output, and forward both to a check script.
We use this pattern in several plugin tests (for instance, with
validate-memory-counts.py).

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build                    |  1 +
 tests/tcg/scripts/check_plugin_output.sh | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)
 create mode 100755 tests/tcg/scripts/check_plugin_output.sh

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index f0efd46ee3e..6e46c121fda 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -6,6 +6,7 @@ if config_host.has_key('GDB')
   gdb_progs = [config_host['GDB'], gdb_progs]
 endif
 gdb = find_program(gdb_progs, required: false)
+prog_check_plugin_output = find_program('./scripts/check_plugin_output.sh')
 prog_gdb_test = find_program('../guest-debug/run-test.py')
 prog_record_replay = find_program('./scripts/record_replay.sh')
 prog_run_and_diff = find_program('./scripts/run_and_diff.sh')
diff --git a/tests/tcg/scripts/check_plugin_output.sh b/tests/tcg/scripts/check_plugin_output.sh
new file mode 100755
index 00000000000..4d12e23ad60
--- /dev/null
+++ b/tests/tcg/scripts/check_plugin_output.sh
@@ -0,0 +1,19 @@
+#!/usr/bin/env bash
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+set -euo pipefail
+
+if [ $# -lt 3 ]; then
+    echo "check_plugin_output: check_cmd qemu_bin [args]..." 1>&2
+    exit 1
+fi
+check_cmd="$1"; shift
+qemu="$1"; shift
+tmp=$(mktemp -d)
+trap "rm -rf $tmp" EXIT
+
+set -x
+
+$qemu -d plugin -D $tmp/plugin "$@" |& tee $tmp/output
+cat $tmp/plugin
+$check_cmd $tmp/output $tmp/plugin
-- 
2.43.0


