Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0E16C982E6
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 23:15:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8nEF-0008FQ-Uo; Mon, 21 Sep 2026 19:15:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x8nEB-0008AO-Si
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 19:15:16 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x8nE9-0000Ez-92
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 19:15:15 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68LKfvFA2412159
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 23:15:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=fnZqnkVs/cX
 mvnGk5vW1MoKdT6ik2v77J2yaMJICc9k=; b=UojtfPjs73EDpP5DbteorIrkhtw
 r3uEytOaxBnt1T1V1BTmyTf2x2CfpHuDYnW4jN7vsnoz5gpHznuGEFCuVG3/7ZNZ
 FY23C7aPQseyKAwDMf2OAq4yXEIST9vZhflFO/7zRkwcoEwc+g/46MSYzDO8UagA
 Tz8WNtHSv6dM9nyN10+f1nea5jF5wZPRFM9oPpp0nE/VXhxu3lbdpBskOwD40Y7t
 8x/O9ZkwB/f6zwvZOB8V9Xh1uqdTPXjO+KXZg6G3jYuqAe4V3c7g+UZRrdozszKv
 +NyEiLfpXaCCLGqAXESSQqsZ3UdeNcZWZQ6737TehhVkUpAuI7WKlmdWtoA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gu3csjtp4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 23:15:11 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-39512608fb1so8403119a91.1
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 16:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790032511; x=1790637311; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fnZqnkVs/cXmvnGk5vW1MoKdT6ik2v77J2yaMJICc9k=;
 b=cfafG+lZcJ3XpF7Bd5Bbklx97wZWun3hMl+qACSWM4XFpwYdsjdq4Ap+SG+eI7IH7O
 PeGobBrrtlU2dQ1BI61DENi6GLkY+x7wvyNJCsKJGJI4deqF0CwSsOKhUJ2pl8ohRtbX
 voZdp9j1H3hWOYydZXgxTPsHHUwCEh+oyELOzc2YwC5MHbojl8vUqK0xTgxnx/ROk2RG
 Feh2tMNFAChp3L4dwMAO3mNnVQvtbonzakCJGVt6wnt5TJd945p44rHTSITpfY3Uqjis
 TjJVL9l56EKxTxfK/FVSgbF9HShflD2BIlh951ht68l8nMCtnqE4Lp+YEWi/d+8+/Xb4
 L4ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790032511; x=1790637311;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=fnZqnkVs/cXmvnGk5vW1MoKdT6ik2v77J2yaMJICc9k=;
 b=lMWLsxLHgn4BWn3COB2GHcyBz7xkZDR0Ak+egQ+S8Z7uSzd9l8riBPFco9r7BtsUUH
 ymYsoHW6wao2ftwosm8RADuczJIlKLLtrjoNtjfjHX5MFDDnAdpIAJl64vWsCazGbNay
 54y7Nfp/531gp4X+++YV8iElaxJbSV3VWwT9KO3nUX7TxciaPk3b+1UvuwukoAlpVE5z
 xlFL7Bf3OCLo9guFrfWFKMltnN0DjlsUQe4RVrT/TjGD6XzqTt2pfKVeIRGnx7Dq+19G
 /lISv6Rj04QM3LpqZ9lWbAGuTWa8WsHao8+0m+wF9ZJNk6bgZPGuFJi7G2+5ncjhtyxA
 8Y4w==
X-Gm-Message-State: AFuF++kE1EWnKtSybovPF0e8iZ+DXswI1AaBBn/BnL/2zWIxTFZBMKAM
 I+2oMHn2FXgifxFvQ2xWMxi6eSbjVVzUlhEga80tK4Hrz9aLYNNRPzSFrM8kq9HWzO7wyDNqyEA
 998MwGXmP5hy15AagJNwvUkZ5/DF7lxE4NdleSLEiMldXpauGJa6Uh1ACY2au9imDhQ==
X-Gm-Gg: AYBFou0n+enzIucopsrZlcJHaihzlVZ2OrtsjIe8GXHTJ23TMu++A/ih8AhvMEtKqsN
 VUIYflVrqc7k7qWFG5iCCkD3DyyzzKhTxvM+Tm+zVkgVkaFyEeImBnd/zbBkpeKyxMbUM0Lumdq
 T68hFzov1RaPz+SlJJobGT7+DDVJeysmggW5hr+4tWCoQ+9aKgG72Tns/46JXxvv4TLWj6ZEhCQ
 bRmDy7VBlziiyJ7k53wpeFtZEfPktH2QSM4yxsQHYRJmp9Uer9kdm5J8bv+GIJHCn7FKL80Bscd
 7bz5Vsst/f4R/8/TLjG99OAo3aMxP76axGEzbMdLfvmg1tKlfzCBc8PCYCSzZ6Sb9FnLsXWbw/l
 XmKa7iFU+9PgvlX9gL1IktWMIW8R8+QyExaf7X8xSSmn8Qtw/IdU9yckAhoW64w==
X-Received: by 2002:a17:90b:5388:b0:39e:21a7:5dff with SMTP id
 98e67ed59e1d1-39e54d1e037mr19306374a91.11.1790032510938; 
 Mon, 21 Sep 2026 16:15:10 -0700 (PDT)
X-Received: by 2002:a17:90b:5388:b0:39e:21a7:5dff with SMTP id
 98e67ed59e1d1-39e54d1e037mr19306346a91.11.1790032510407; 
 Mon, 21 Sep 2026 16:15:10 -0700 (PDT)
Received: from localhost.localdomain (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0674c0b4bsm1295939a91.13.2026.09.21.16.15.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 16:15:09 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 3/7] tests/lci/refresh: add parameter to override container
 registry
Date: Mon, 21 Sep 2026 23:14:54 +0000
Message-ID: <20260921231458.3369-4-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260921231458.3369-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260921231458.3369-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDM0MCBTYWx0ZWRfX1HGjdndSETPT
 XuiFkfhlwf8vWLT8aIF/D1MpU0euVMFqnGR9l7qYR964G59EOE8N+LyKVOdFOSnh/q8v+cqT7A9
 Z8JkGOxZGztjSBP/ASbJKJqwWqVDy5I=
X-Proofpoint-GUID: IZB3Q7zv7McwavRo5EVkNEaVI7R6NiQS
X-Authority-Analysis: v=2.4 cv=QovLTlyd c=1 sm=1 tr=0 ts=6ab1ba7f cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=4J3MZNeQsNbOYB5HGrwA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDM0MCBTYWx0ZWRfXy/OKNicqCLiK
 vwFpDP+vSBdF801/qRvUEf8dzj05ZW3UwiQlMqM+y0Q03lvrtAZADZjPc/3AMl0gaRNIf4oLZLO
 +khvMdiT0FhZoJ/18uTR8mH/yLSt7DW/i/jOaAJQtjka/H9stDSSYWwO7oGns5lqHECcYti9v94
 LSQwUjdH56VJcjogxqcNvhmog//PD6djVWQgToQlR0sOFrOHz+Ll2PGXtGv8YdQW6EhlomwEC+W
 eMLY2YCXP03KB4oS0qFfwQKcxqjC2MwWCHgerjjeX3z9450/FZX21qPuH6Zmeij4SDUn3iI401w
 2u6O9qlfh/0M8rVHxtN8qfNZc3kdjnQ0pg69qhl/SJ/NygDZwowFdFzpph35E8fcnWdM3jd8Fvd
 QWijut3jwJHLmJx+aNjaOybaMifejIcQCgdxwN3te4QnJVeLMkQPalS3IY9mPrP12KZw17yX3Vz
 9knrXWpDqGM0fO26wlQ==
X-Proofpoint-ORIG-GUID: IZB3Q7zv7McwavRo5EVkNEaVI7R6NiQS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_06,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 spamscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210340
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

We'll use this in next patch to switch FROM docker.io/library to
docker.io/amd64. It would not make sense to add a new target to
libvirt-ci for this, since it's just a variant of an existing target.
Simply replace container registry with arch specific one.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/lcitool/refresh | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index 9a71af0e41d..4e3cbb81acf 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -12,6 +12,7 @@
 # or (at your option) any later version. See the COPYING file in
 # the top-level directory.
 
+import re
 import sys
 import subprocess
 
@@ -41,7 +42,7 @@ def atomic_write(filename, content):
         raise
 
 
-def generate(filename, cmd, trailer):
+def generate(filename, cmd, trailer, registry_path):
     print("Generate %s" % filename)
     lcitool = subprocess.run(cmd, capture_output=True, encoding='utf8')
 
@@ -49,6 +50,10 @@ def generate(filename, cmd, trailer):
         raise Exception("Failed to generate %s: %s" % (filename, lcitool.stderr))
 
     content = lcitool.stdout
+
+    if registry_path is not None:
+        content = re.sub("FROM.*/", "FROM " + registry_path + '/', content)
+
     if trailer is not None:
         content += trailer
     atomic_write(filename, content)
@@ -64,7 +69,7 @@ add_user_mapping = [
 ]
 
 def generate_dockerfile(host, target, project="qemu", cross=None, trailer=None,
-                        enable_rust=True):
+                        enable_rust=True, registry_path=None):
     filename = Path(src_dir, "tests", "docker", "dockerfiles", host + ".docker")
     cmd = lcitool_cmd + ["dockerfile"]
     if cross is not None:
@@ -79,26 +84,26 @@ def generate_dockerfile(host, target, project="qemu", cross=None, trailer=None,
 
     if enable_rust:
         trailer += "\nENV ENABLE_RUST=1\n"
-    generate(filename, cmd, trailer)
+    generate(filename, cmd, trailer, registry_path)
 
 
 def generate_vars(target, trailer=None):
     filename = Path(src_dir, ".gitlab-ci.d", target + ".vars")
     cmd = lcitool_cmd + ["variables", "--format", "shell", target, "qemu"]
-    generate(filename, cmd, trailer)
+    generate(filename, cmd, trailer, None)
 
 
 def generate_pkglist(vm, target, project="qemu"):
     filename = Path(src_dir, "tests", "vm", "generated", vm + ".json")
     cmd = lcitool_cmd + ["variables", "--format", "json", target, project]
-    generate(filename, cmd, None)
+    generate(filename, cmd, None, None)
 
 
 def generate_yaml(os, target, arch, trailer=None):
     filename = Path(src_dir, "scripts", "ci", "setup", os, f"{target}-{arch}.yaml")
     cmd = lcitool_cmd + ["variables", "--format", "yaml", "-a",
                          arch, target, "qemu"]
-    generate(filename, cmd, trailer)
+    generate(filename, cmd, trailer, None)
 
 
 alpine_extras = r"""
-- 
2.43.0


