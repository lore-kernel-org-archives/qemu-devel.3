Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BFE2D59F5C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 18:08:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8kRw-0003sl-EX; Wed, 06 Nov 2024 13:08:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.vnet.ibm.com>)
 id 1t8kRv-0003rV-1i
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 13:08:11 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.vnet.ibm.com>)
 id 1t8kRt-0005mI-8G
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 13:08:10 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A6HA9hZ013161;
 Wed, 6 Nov 2024 18:08:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=JFWnUsYDG6ff4mPzZQxPOJnYWH2mF3xog+FuGn1rF
 QM=; b=kzV98o5BUaOds8rvuD7eRF4JwQ9oApeE/jT6nsKCoMCOXG9bmww9ioT+Z
 lXI4N3vcmevxMnF93Jg3gftLxDG56qvfWupoHvCYQtwpeFhD7CBVW+awjSwJPn6I
 CcU3Cs47ruNSdrMh1wnVWLVyZElx2CB7AA2PwqLTahIW0DaBnv+qLD6pCdsEHFCU
 Vdd1fasIRG5mjlKQ2Prx91tKA8waGskCZs9+bbe/p0S3tPMFMoBqexgf5JSM4USi
 NEgVo7tsZnVJTl8EnIys9YPE9TON6IZo6MtNdp7oHw48lYEA7cOeIPsNfE6pwsmn
 i9pmogcKiSHCERqITEiPhUZThkA7g==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42rcm3gb6c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 06 Nov 2024 18:08:03 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4A6I82gS001218;
 Wed, 6 Nov 2024 18:08:03 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42rcm3gb67-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 06 Nov 2024 18:08:02 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4A6GB6sL019503;
 Wed, 6 Nov 2024 18:08:02 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 42p0mj6mek-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 06 Nov 2024 18:08:02 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4A6I81CJ18678442
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 6 Nov 2024 18:08:01 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3EA3D58063;
 Wed,  6 Nov 2024 18:08:01 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 95D1D58055;
 Wed,  6 Nov 2024 18:08:00 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  6 Nov 2024 18:08:00 +0000 (GMT)
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: peter.maydell@linaro.org, qemu-devel@nongnu.org
Cc: marcandre.lureau@gmail.com, clg@redhat.com, lena.voytek@canonical.com,
 Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH] tests: Adjust path for swtpm state to use path under /var/tmp/
Date: Wed,  6 Nov 2024 13:07:51 -0500
Message-ID: <20241106180751.6859-1-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.47.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: jQY8kr9-L3a--Ft4HpIau6cZby3TRSjl
X-Proofpoint-ORIG-GUID: mijDPM4hfiXsLZy04kVjHHhv1za7mCLJ
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 clxscore=1011
 adultscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 mlxlogscore=839 spamscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411060141
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=stefanb@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

From: Stefan Berger <stefanb@linux.ibm.com>

To avoid AppArmor-related test failures when functional test are run from
somewhere under /mnt, adjust the path to swtpm's state to use an AppArmor-
supported path, such as /var/tmp, which is provided by the python function
tempfile.TemporaryDirectory().

An update to swtpm's AppArmor profile is also being done to support /var/tmp.

Link: https://lore.kernel.org/qemu-devel/CAFEAcA8A=kWLtTZ+nua-MpzqkaEjW5srOYZruZnE2tB6vmoMig@mail.gmail.com/
Link: https://github.com/stefanberger/swtpm/pull/944
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 tests/functional/test_arm_aspeed.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/functional/test_arm_aspeed.py b/tests/functional/test_arm_aspeed.py
index 9761fc06a4..a574b1e521 100644
--- a/tests/functional/test_arm_aspeed.py
+++ b/tests/functional/test_arm_aspeed.py
@@ -227,11 +227,11 @@ def test_arm_ast2600_evb_buildroot_tpm(self):
 
         image_path = self.ASSET_BR2_202302_AST2600_TPM_FLASH.fetch()
 
-        socket_dir = tempfile.TemporaryDirectory(prefix="qemu_")
-        socket = os.path.join(socket_dir.name, 'swtpm-socket')
+        tpmstate_dir = tempfile.TemporaryDirectory(prefix="qemu_")
+        socket = os.path.join(tpmstate_dir.name, 'swtpm-socket')
 
         subprocess.run(['swtpm', 'socket', '-d', '--tpm2',
-                        '--tpmstate', f'dir={self.vm.temp_dir}',
+                        '--tpmstate', f'dir={tpmstate_dir.name}',
                         '--ctrl', f'type=unixio,path={socket}'])
 
         self.vm.add_args('-chardev', f'socket,id=chrtpm,path={socket}')
-- 
2.34.1


