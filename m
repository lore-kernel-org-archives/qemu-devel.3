Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FEDCCA9ECA
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2026 23:17:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFgJU-0001F0-4h; Sat, 10 Oct 2026 19:17:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xFgJL-0001Du-E3
 for qemu-devel@nongnu.org; Sat, 10 Oct 2026 19:17:09 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xFgJJ-0003qu-Ba
 for qemu-devel@nongnu.org; Sat, 10 Oct 2026 19:17:03 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69AMECLB2308511
 for <qemu-devel@nongnu.org>; Sat, 10 Oct 2026 23:17:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=bOnexhYfvVR
 dMNUntca9cUmBID3gqSg3/xxOQS0LM/M=; b=WH8BAQP/Ju3UV5XokXSbKYgro7v
 +opTx6RwKC6HhqJ6BLuy5lOCLmX4hixN6otEjet2tXxB/0JNwUjMvWqj/yvvTDsO
 QO4dj8HoNXkMj0ewEXTce1p3rouDutpYtr1J6THq7hfZodKZfidvZ+AqZVw8cBPa
 0biN8DpDRYKTq99pGWc3k4IzA2RW5zwWdf+92OyWk6ct7s5u+ghfh25FOD7ODDJJ
 GL9fFnLyFoyN9pV2ee7R/T6x+/u4Q33JX5W2JLj+oD63+/DsW6Yf1B15dn8/bzB0
 5fSrJvPk6i6QcRW+kFxbTBWE9ZkcUhr97GDmKX0buzK9ButRQDK97fNEorg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h7cxxj23b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 10 Oct 2026 23:17:00 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-357e2bc3b1bso1375894eec.0
 for <qemu-devel@nongnu.org>; Sat, 10 Oct 2026 16:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791674219; x=1792279019; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bOnexhYfvVRdMNUntca9cUmBID3gqSg3/xxOQS0LM/M=;
 b=PzDRbl6netPIZI5AnQoUHB3xi4sTH2+V52vLHUWyEqEQELblyOvM7H7g2ksBHcoruQ
 CxfsV/47WSkKQCWj+Kqnw1SZ1/eL24gwvNhCZEA2whBaG89x6fkiDWqJV6fo4xiVO/Sk
 dzJxNz3hSPiv4efV5wLiGu7ajpZHy4E+gMB4dOt3dlVMnntc5b80CM/UOf4+M+U8qxN1
 n0DsmihCkrQzk0XbiBkYLXyVGd8v4bmatDPRq9crLaXI8+SBqnE0/bwNS4nXqw1CcEZ/
 AJ3J0ei1+cKpJpyh9bQC5aZAdvqOTctscmK1zA+4sE9QnpcQQle9IchGWRNqXCY8PA/i
 d26w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791674219; x=1792279019;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=bOnexhYfvVRdMNUntca9cUmBID3gqSg3/xxOQS0LM/M=;
 b=ki9fB2v43x5YSx1mWpBlXI8hMxD6/rBF+JuLOUSk212kYnVyDQ6vW+XIb/b8RPdVee
 4mutkwbzEdV0iU7d7UFa/6h1AXYeaJjqo6NWPS5/TY/fkYLOcTKFy5+neSN2zvRVx0Lr
 J84YYk58XS65YjcGZe5WlwDZONZYjMP4Emrdcx1tIwS66irVJoOR0V2IDfRF/4L7bMHO
 c+BIlFzeTggs1fb3S//QT7d9ALDv+jk/oD3F4DDy9kxKh+AeQjNW5Y5dkgBQ4k0bdDU5
 jS960QDu/KJFt/XpFRCcic7x9cDRty2W99sNKGddjHChCPxoE2vr92c7UBQMa1a30F6l
 Z0jg==
X-Gm-Message-State: AFq9FYIsbmHuR/X6RHsB8rwQsRCPLfbQVf75ufLQSVL7s1KJNNgwVrE4
 1NPYNFV8S44bPA6o6PpT3SqLFe/01SgpUFVS/SUYjMsRO1Z01nB42Bgpf9K6MOcfjB32sSWhI98
 IHJJa/wMh8q/H55qmQDWatL6Ob2q6CKZEdWJJRZ6tRRUwyuq8vh/F0JUqGBKYtN1AtA==
X-Gm-Gg: AYBFou2Tut7uFk3Cu2br5nLjiN5Um2KwqyIVxx0GrFxyIfePtkp5iAcaQ+oJw0kyPdI
 2DHq088xrZ3minK9P93H2Z4k1CzAHZTKzx/2yjl+TMtbHr0vx2CBwJsQ14tR8pf/6mQc+BoxJ32
 96P4VrBTwXuqdhU+feYGAI9V2XHJsxKOfNdvJ81SYYIgpPjIF6RFKEQDry+EHIpuLoS6h8Ipg9X
 JxbOUQgii1loiI4bZoUEVTrPwnHg8DvL9iS+5f0wv6gmGayz/axtGzG+JlTtcZZ7J+gQY+HNIdm
 l1P6YpLB3ZDeMYg7no5RfuuN+Vb2XScXP9emAIo1272vIMdyyaIbVlvbQQqkCFU4Tkop04FeDBB
 wFNzlo9W84YoT+OaMKRldkR3f+D1V4jnppMwim1RbpjgoTn/R893EGqtH9JrV
X-Received: by 2002:a05:7301:e0c5:b0:359:ef9:9be3 with SMTP id
 5a478bee46e88-3590f090316mr1877409eec.11.1791674219074; 
 Sat, 10 Oct 2026 16:16:59 -0700 (PDT)
X-Received: by 2002:a05:7301:e0c5:b0:359:ef9:9be3 with SMTP id
 5a478bee46e88-3590f090316mr1877381eec.11.1791674218463; 
 Sat, 10 Oct 2026 16:16:58 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537ca67b21sm18285396eec.11.2026.10.10.16.16.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Oct 2026 16:16:58 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, mjt@tls.msk.ru,
 peterx@redhat.com
Subject: [PATCH 3/3] scripts: add generate_release_links.sh
Date: Sat, 10 Oct 2026 23:16:48 +0000
Message-ID: <20261010231648.3105-4-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261010231648.3105-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261010231648.3105-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: bX-fcOwBjx60PNyslN3Ua1TVqGz9EVFS
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEwMDA5MiBTYWx0ZWRfX0zTZLFSnGSPD
 mSPVFvP+gJgqHmf1b9p9VphVs7/FRQ9sBKwMgygDj//hZ5WvlnPF8V/eivgJuxJc5jRitYKCYcT
 k1u7hY0WyxoX1/Ugnq/+iElXbTiTQtY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEwMDA5MiBTYWx0ZWRfXw6//VYnKh6cj
 pLWHnm6YPx3AUtzkj4MPSVop7JeCP/gm4RpCDqdFgybi/E/QPisA3FICj5upIPdSgSxlbU1KSgn
 haOzh/FGJahifDOr2+d50+UFeXa4MbnyduorM5o2A/yHX1DD5qmSz2NlXDc37FEpAlvdCTM8IMn
 o3SvQd8zodJkNPjMjrhtytXjFZEbSW9uH/VDxc0cMUKGP/q90+z6A4DBFOnPGaN6KLgrq1Tj0dh
 0Hs/O4sfq73t5k+obPnFY5rBNWbvjdYNXZBmL0zByDuPlak6S0MLJfCGcT3+YmlnYkydCHUYpw5
 JKiMdik70Fbx/xKpAKbMZyB2rcubyBdHF7chzr46awbmkH5827+qIeuYPRFugD9vztHAw4WgdTZ
 C6uJbNMRqguWV+IOXkq1Rz7GDX9jlgQqqkXIckHSUQoGmbIfhlLZLNSI+pyjdMw2XktU9b8Is6v
 neqzg77VYqdyo11+9Aw==
X-Authority-Analysis: v=2.4 cv=AsJ7T+9P c=1 sm=1 tr=0 ts=6acac76c cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=n6MYwUk4AAAA:8
 a=EUspDBNiAAAA:8 a=z6BG1H5jNmwsGlzAzHUA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: bX-fcOwBjx60PNyslN3Ua1TVqGz9EVFS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-10_05,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 adultscore=0 priorityscore=1501 clxscore=1015 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610100092
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

Now that it's easy to build containers for all QEMU versions, we can go
further and offer "links" (scripts) to all qemu binaries from all
versions.

Note: this is based on prebuilt container images, that are hosted on my
dockerhub (https://hub.docker.com/repository/docker/pboqemu/qemu-releases).
If there is enough interest, I would be happy to relocate that on an
official QEMU registry, or even add it to our CI in case people get
paranoid about where those binaries come from.

$ ./scripts/generate_release_links.sh qemu-releases/
$ ./qemu-releases/v1.6.1/qemu-system-arm --version
QEMU emulator version 1.6.1, Copyright (c) 2003-2008 Fabrice Bellard
$ ./qemu-releases/v10.0.0/qemu-system-arm --version
QEMU emulator version 10.0.0 (v10.0.0)
Copyright (c) 2003-2025 Fabrice Bellard and the QEMU Project developers

Container engine automatically download and runs the right image, so no
build is needed on developer machine.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 scripts/generate_release_links.sh | 66 +++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)
 create mode 100755 scripts/generate_release_links.sh

diff --git a/scripts/generate_release_links.sh b/scripts/generate_release_links.sh
new file mode 100755
index 00000000000..112546a4edd
--- /dev/null
+++ b/scripts/generate_release_links.sh
@@ -0,0 +1,66 @@
+#!/usr/bin/env bash
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+set -euo pipefail
+
+script_dir=$(dirname $(readlink -f $0))
+
+if [ $# -ne 1 ]; then
+    echo "usage: out_folder"
+    exit 1
+fi
+
+out=$1;shift
+
+releases()
+{
+    git tag --sort=creatordate |
+        grep '^v[0-9]' |
+        grep -A 10000 'v1\.6\.1' |
+        grep -v '\-rc[0-9]$'
+}
+
+qemu_targets()
+{
+    version=$1;shift
+    git ls-tree -r $version --name-only |
+        grep configs.*mak |
+        sed -e 's#.*/##' -e 's#\.mak$##'
+}
+
+softmmu_binaries()
+{
+    qemu_targets "$@" |
+        grep softmmu |
+        sed -e 's/-softmmu//' -e 's/^/qemu-system-/'
+}
+
+linux_user_binaries()
+{
+    qemu_targets "$@" |
+        grep linux-user |
+        sed -e 's/-linux-user//' -e 's/^/qemu-/'
+}
+
+root=$(readlink -f $script_dir/..)
+docker=$($root/tests/docker/docker.py probe)
+
+registry=docker.io/pboqemu/qemu-releases
+for release in $(releases); do
+    echo "generate links for $release"
+    public_image=$registry:$release
+    mkdir -p $out/$release
+    for bin in $(softmmu_binaries $release) $(linux_user_binaries $release); do
+        script=$out/$release/$bin
+        cat > $script << EOF
+#!/usr/bin/env bash
+
+here=\$(pwd)
+exec $docker run -u $UID \\
+     --security-opt label=disable \\
+     -w \$(pwd) -v \$(pwd):\$(pwd) \\
+     $public_image $bin "\$@"
+EOF
+        chmod +x $script
+    done
+done
-- 
2.43.0


