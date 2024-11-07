Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF2D9D43370
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 15:06:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t944y-0005Gl-4t; Thu, 07 Nov 2024 10:05:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1t944w-0005Fb-GI
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 10:05:46 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1t944u-00067r-QM
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 10:05:46 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7EeB2V027536;
 Thu, 7 Nov 2024 15:05:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=4VQhFF
 7b4AH7bbtERoec1XebOebZuW7wSAubis4ydC4=; b=D7mSTSCSonaABTPZDX8BcZ
 vLV1a27aHUJEzkNIzgiVU6DQWuBjMGU9gfPY99y4zZhajDRiUb/t80hild5PPDBu
 wXOHWa5c6keCiafsH6cOD8DwV7OF3IphJxbXN8Sapk4b7moMyit/4vyQdGIokgQE
 2Ll9orXS1bCumFmaQevkYJ/ZnAAZ5j+rhAxwJhKSvBgiyQqEoWsn5QpOFRtq1V01
 JaZqTMwJ9+DzwcVawMmfMr3OYzeXEyVgv4alOrvDm9CqiM8Oy8TLlNfNGKbRluRc
 CYt011TElG4YxcPwH1C6r8Mk3RXOmUJX+c9XXxc0JZRIdH3408Dip2GVaoMG951A
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42rygs84am-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 07 Nov 2024 15:05:41 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7CfhPD019606;
 Thu, 7 Nov 2024 15:05:41 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 42nxds8epe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 07 Nov 2024 15:05:41 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4A7F5exC13566494
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 7 Nov 2024 15:05:40 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 532EB5804E;
 Thu,  7 Nov 2024 15:05:40 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D8E295803F;
 Thu,  7 Nov 2024 15:05:39 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  7 Nov 2024 15:05:39 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Stefan Berger <stefanb@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL v2 1/1] tests: Adjust path for swtpm state to use path under
 /var/tmp/
Date: Thu,  7 Nov 2024 10:05:34 -0500
Message-ID: <20241107150534.38651-2-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241107150534.38651-1-stefanb@linux.ibm.com>
References: <20241107150534.38651-1-stefanb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: njJ6fTdU7a8XN1kB58cVxfylHf4Etgps
X-Proofpoint-GUID: njJ6fTdU7a8XN1kB58cVxfylHf4Etgps
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 mlxscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2411070114
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

To avoid AppArmor-related test failures when functional test are run from
somewhere under /mnt, adjust the path to swtpm's state to use an AppArmor-
supported path, such as /var/tmp, which is provided by the python function
tempfile.TemporaryDirectory().

An update to swtpm's AppArmor profile is also being done to support /var/tmp.

Link: https://lore.kernel.org/qemu-devel/CAFEAcA8A=kWLtTZ+nua-MpzqkaEjW5srOYZruZnE2tB6vmoMig@mail.gmail.com/
Link: https://github.com/stefanberger/swtpm/pull/944
Tested-by: Peter Maydell <peter.maydell@linaro.org>
Fixes: f04cb2d00d5c ("tests/functional: Convert most Aspeed machine tests")
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 tests/functional/test_arm_aspeed.py | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tests/functional/test_arm_aspeed.py b/tests/functional/test_arm_aspeed.py
index 9761fc06a4..274eb20e81 100644
--- a/tests/functional/test_arm_aspeed.py
+++ b/tests/functional/test_arm_aspeed.py
@@ -227,11 +227,14 @@ def test_arm_ast2600_evb_buildroot_tpm(self):
 
         image_path = self.ASSET_BR2_202302_AST2600_TPM_FLASH.fetch()
 
-        socket_dir = tempfile.TemporaryDirectory(prefix="qemu_")
-        socket = os.path.join(socket_dir.name, 'swtpm-socket')
+        tpmstate_dir = tempfile.TemporaryDirectory(prefix="qemu_")
+        socket = os.path.join(tpmstate_dir.name, 'swtpm-socket')
 
+        # We must put the TPM state dir in /tmp/, not the build dir,
+        # because some distros use AppArmor to lock down swtpm and
+        # restrict the set of locations it can access files in.
         subprocess.run(['swtpm', 'socket', '-d', '--tpm2',
-                        '--tpmstate', f'dir={self.vm.temp_dir}',
+                        '--tpmstate', f'dir={tpmstate_dir.name}',
                         '--ctrl', f'type=unixio,path={socket}'])
 
         self.vm.add_args('-chardev', f'socket,id=chrtpm,path={socket}')
-- 
2.47.0


