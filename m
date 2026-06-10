Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25D82CD98C7
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 21:43:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXQha-0007kS-FT; Wed, 10 Jun 2026 17:43:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wXQh4-0007DL-IN
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 17:42:41 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wXQgu-0003Bj-7u
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 17:42:33 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65AJYUpK2600866
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 21:42:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tE5gJaTJDHmzLYqIinmlPsIUtD77L0kCiSMoL/P7C90=; b=L2n8VlveGAGRMO0O
 n0vGPDAZ8vmoBNqTCa2nu+OuCQsBcuiNZjoK4YUSj5gXTcbjq02giG+UeTm7/IHz
 jckOs+j/vuY46PzK36Tv1R3YYn/RK2JyDh5HfA58w1xU874Th/Za4axKTDwOo2CX
 RsEg11FH9CCDkc6nd5CZcdNUOUOqXtyamhkihJ4+9nBY5pJ6dbdEvqMvKHnU92QW
 0+8Gb5aL51vtCxMn5CtR2l4Y7wFn5PDbwQKMvAuC63Ukz8xgG9RYrZb2AYfu5Mot
 53sdW++8o8zRvjMKNCDC41ZRr/bg1EUE1V/KjYEfnyVM4xXFCy8EqOa7xn2472Pt
 uKOCJg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe700f0f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 21:42:13 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-517e054fe07so28724281cf.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 14:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781127733; x=1781732533; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tE5gJaTJDHmzLYqIinmlPsIUtD77L0kCiSMoL/P7C90=;
 b=NUNxGJwwLBhyT9fCljCAzruRHBJD4bIAzBmTifcTHMyZ/KdPvL8sFqbYzXt0ei/t0f
 znyJxcNQXLF6MCXzWet/hdCkUlVnlL+IgUwXpMXOFTfXkQeTG11rLXuMLEDTp+tGbsi4
 rKUHvKJiX4A2h5pYlneKECggyyJXNt3gvAd7TKEkUvnKPT1cNmX8Wy4shDX+MWvnJCW5
 5KmI0dqt1j9q06XrB7m8JItQHznXQmZ3ZeiYtMhKh6a4OS6K2Pr2PAZKa+hHxZHMyzNj
 sAjxF3blP/xvqnlCl6pCOtl8BNinSV3uU05K3j/BST9TrHuLaIRDnzwrmjYzTtjUYDR7
 xa5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781127733; x=1781732533;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tE5gJaTJDHmzLYqIinmlPsIUtD77L0kCiSMoL/P7C90=;
 b=cE//CJxD/rb9uQjtLhBPD/1Lrm/VAveQZf+HrkK1N2QLjRZN0alGny+1xHGBn7aJiy
 0r1xV/0u2FGESRThE6vON+XSvj4G4Tnghvdbmi+Ial8AAUswbmIDKEeHz0meppy0sRmG
 iYqhYmD+Ik4Zg+/BbEThot++PdOLOB7/kXiVSZw6EONcw3HIFc7VVXcvngOYplz9DJeS
 fvrs/z0/cOo3wijKzbOG9NgkJUN2/E3tUy0Y5FDtkf8HEw/6rueF2Os0+ij3d2AuTDlV
 oyVY87CavU3lfnnAz9zb8nMiVie1unxBg3r74pcan3KVJjKtO4MDl2xlFQaWRsHwV/C3
 JgOg==
X-Gm-Message-State: AOJu0YxqgkIwJtM/8W47ueCLHVj3LQdo2pS7+tvStNB1Xuw6Ghk+q709
 rgw4LfgESTL36glO+sfJQnPg7D5ZpB3YaBaZMzoLHATdyWkGZb8neggxc1+qN+GPnwEWCwd9A9J
 y7Eiya8yPi2ADcc4sCNgHk1d/+MX5elb0n993JjtDV8xZDgUvCPEXnO/K9QXIUXD28A==
X-Gm-Gg: Acq92OHC1d2L3XuZcsEUjF4RkO1FKqw6/ghJXKSY9Go/bHrZii8a2cpIxtmaLD+eUIL
 IuLduZHpXJOMRZtikVxBtF/IUkE5gJEg2Ir9p7Tqmrdj7+kFv4HD1/hK45ua7kifHDOnxoWEsEP
 XRflZ2iMiWws20kpalSgFyvImnozXujd9LnA7RvWEloZUTTx9smWlnhgAxxbGhRHygIfVIjWXev
 ePjbjpF8LXq7dlpgEapbyQln9HvoLWWcLssXL59bddDJ1MIz1epeMabWT8W32vDz6byByRcs7ZJ
 iEvrlfQFwgRI/2JAOFwglVfs+SYZWqTJiBnMCrq/D/59Vk2udxIcMooIobUY82HjwQXe68rBA5V
 lX1LRh5QUXFsjPcoDGlO0nN/0631nY1249Jq4SAy1dNhI8D+Pe5VrsTywZvi8o/rpkHCF/A==
X-Received: by 2002:a05:622a:5a09:b0:516:d943:175c with SMTP id
 d75a77b69052e-517ee3eb048mr361611cf.56.1781127732634; 
 Wed, 10 Jun 2026 14:42:12 -0700 (PDT)
X-Received: by 2002:a05:622a:5a09:b0:516:d943:175c with SMTP id
 d75a77b69052e-517ee3eb048mr361041cf.56.1781127732253; 
 Wed, 10 Jun 2026 14:42:12 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([177.170.117.62])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5a6d777996csm20766280e0c.7.2026.06.10.14.42.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 14:42:11 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 andrew.jones@oss.qualcomm.com, leif.lindholm@oss.qualcomm.com,
 uwu@icenowy.me, Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v8 6/7] tests/functional/riscv64: add riscv-server-ref TPM
 selftest
Date: Wed, 10 Jun 2026 18:41:32 -0300
Message-ID: <20260610214133.1882563-7-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610214133.1882563-1-daniel.barboza@oss.qualcomm.com>
References: <20260610214133.1882563-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: yd_1Rht62DrGU5yA8qSMv2B64pvYsckI
X-Authority-Analysis: v=2.4 cv=B9eJFutM c=1 sm=1 tr=0 ts=6a29da35 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=gdiugJE53z4H+vvYeRBHqw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=9Fx0H_d4LJWXQYxSPGgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDIwNyBTYWx0ZWRfX+JEFzs8mxkiC
 fXSCQen7vJIz49EmMdBj+LR0r2c1NtINsVu02In191JF+r8DDkoITGZWVAmn6viWILCH9v2JRqn
 anfWo3Ck8D6Pd1bLMm36ZApVThcj/cCDs5No88NQoR/SVTRRVbSSworBvSswQmXoxH/wYRCRBsG
 Qy7a8NiXcoDVK1wp9np1beP0qPhdYILi0rRzN0/SA0G69mL9KbIRw5dGsBK+GpavFz9jAyJ/5In
 4YKX+ThO21QqozHYjwvDsd65g11Emqr4RbUvk0NJImpBEGt0ul2G1qi6qk0R2+JFEYf30vZ75UN
 1BAy8JT/BLaE8Y+p5Md56ggBE+PnCqh//dJTs1IVkAjiznr7UWlgTD+g9dZSlTAxPlOrDUpQx19
 9LuzK74OE2TAQ34WCwfPiOsej6iOYTsXeAn5NWLwMTYvhmeTlcKYc415JoLaYcD96YoCkqwyK+w
 pmZ0E5nPg408PtJO1lg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEwMDIwNyBTYWx0ZWRfXwMMx7SlrJp0b
 45gsVr8RNPjqy6lZDn496uYSw2wpP81HSzteesJnuI6kevUGj/5ttrMl867qmbx8XcO/zFM5LLu
 ThKcHTJPf9D0mhEanvmq+JNJmpDoj+c=
X-Proofpoint-ORIG-GUID: yd_1Rht62DrGU5yA8qSMv2B64pvYsckI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_04,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0
 phishscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606100207
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

Add a TPM specific selftest for the riscv-server-ref board.  The test
will be skipped if there's no 'swtpm' in the host.

The test has been basically cloned from our Aspeed ast2600 friends.
Shoutout to monsieur Cédric Le Goater for the code.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 tests/functional/riscv64/test_server_ref.py | 31 ++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/tests/functional/riscv64/test_server_ref.py b/tests/functional/riscv64/test_server_ref.py
index 2ecfcf60ad..9b120628dc 100755
--- a/tests/functional/riscv64/test_server_ref.py
+++ b/tests/functional/riscv64/test_server_ref.py
@@ -8,8 +8,13 @@
 riscv-server-ref board test
 """
 
+import os
+import tempfile
+import subprocess
+
 from qemu_test import QemuSystemTest, Asset
 from qemu_test import wait_for_console_pattern
+from qemu_test import skipIfMissingCommands
 
 class RiscvServerRefTest(QemuSystemTest):
     """
@@ -26,7 +31,7 @@ class RiscvServerRefTest(QemuSystemTest):
          'master/riscv/images/virt64/buildroot/rootfs.ext2'),
         'f00bb88749f945d80675540a1338bd1ccb226574685a5b6c65ab44027d0411a8')
 
-    def test_boot_linux_test(self):
+    def _test_boot_linux_test(self, tpmstate_dir=None):
         self.set_machine('riscv-server-ref')
         kernel_path = self.ASSET_KERNEL.fetch()
         rootfs_path = self.ASSET_ROOTFS.fetch()
@@ -38,6 +43,22 @@ def test_boot_linux_test(self):
         self.vm.add_args('-device', 'ahci,id=ahci')
         self.vm.add_args('-device', 'ide-hd,drive=hd0,bus=ahci.0')
 
+        if tpmstate_dir is not None:
+            # Note: code taken verbatim from
+            # tests/functional/arm/test_aspeed_ast2600_buildroot_tpm.py
+
+            # We must put the TPM state dir in /tmp/, not the build dir,
+            # because some distros use AppArmor to lock down swtpm and
+            # restrict the set of locations it can access files in.
+            socket = os.path.join(tpmstate_dir, 'swtpm-socket')
+            subprocess.run(['swtpm', 'socket', '-d', '--tpm2',
+                            '--tpmstate', f'dir={tpmstate_dir}',
+                            '--ctrl', f'type=unixio,path={socket}'],
+                           check=True)
+            self.vm.add_args('-chardev', f'socket,id=chrtpm,path={socket}')
+            self.vm.add_args('-tpmdev', 'emulator,id=tpm0,chardev=chrtpm')
+            self.vm.add_args('-device', 'tpm-tis-device,tpmdev=tpm0')
+
         self.vm.set_console()
         self.vm.launch()
 
@@ -55,5 +76,13 @@ def test_boot_linux_test(self):
         # Wait for boot to complete - system reaches login prompt
         wait_for_console_pattern(self, 'Run /sbin/init as init process')
 
+    def test_boot_linux_test(self):
+        self._test_boot_linux_test()
+
+    @skipIfMissingCommands('swtpm')
+    def test_boot_linux_test_tpm(self):
+        with tempfile.TemporaryDirectory(prefix="qemu_") as tpmstate_dir:
+            self._test_boot_linux_test(tpmstate_dir)
+
 if __name__ == '__main__':
     QemuSystemTest.main()
-- 
2.43.0


