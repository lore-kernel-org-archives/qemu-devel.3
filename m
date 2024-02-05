Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08712C48297
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 18:15:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rX3Ts-0005zy-Ft; Mon, 05 Feb 2024 13:14:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rX3Tq-0005zb-Vk
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 13:14:07 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rX3Tn-0005tb-VG
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 13:14:06 -0500
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 415HuU4N020446; Mon, 5 Feb 2024 18:14:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=+tlkukPWLeQ6WDnmUAlPzilmjd4qxQFNB9qyvD8yiI8=;
 b=X8PgDf6dAmuK2QkD+t/c0u6xb9k7QliqWWM6yvqJ4pz0drPCPL1oGvwJEsPygnfIOc4Y
 FyLNxaWZmQGtaxKvqWe5DEx7kDtcDPdS0rJtq+H81rNnwnzYhAeoq+qFfslSny4YsDJ6
 nyvvIui+UF7exp/2IEnBahHuYHZQB4WqsqvYtPRJgFJ6NmlaiCBkm+axvMOh9fKnrvLP
 ZsOEUjddjCG98u7qoONVR17wMYfzSFeCCpzyaxIrNX6qYXYCkcbM115MSv0Bb1jTErmL
 NNHnkfkP1cX3DpHXBtaz6sPqoklqkXA+4CxJkaNt72WxM4sxwpl1gktW01Q2rjntO6IL Zg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w34gyge8s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Feb 2024 18:14:00 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 415HwZ21025664;
 Mon, 5 Feb 2024 18:14:00 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w34gyge82-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Feb 2024 18:14:00 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 415HILbW005756; Mon, 5 Feb 2024 18:13:59 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w21aka0bh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Feb 2024 18:13:59 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 415IDv2W22610466
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 5 Feb 2024 18:13:57 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 61D3420043;
 Mon,  5 Feb 2024 18:13:57 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AECA520040;
 Mon,  5 Feb 2024 18:13:56 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.171.57.170])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  5 Feb 2024 18:13:56 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ed Maste <emaste@freebsd.org>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Warner Losh <imp@bsdimp.com>
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Kyle Evans <kevans@freebsd.org>,
 qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 2/4] tests/vm/freebsd: Reload the sshd configuration
Date: Mon,  5 Feb 2024 19:11:33 +0100
Message-ID: <20240205181352.1567-3-iii@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240205181352.1567-1-iii@linux.ibm.com>
References: <20240205181352.1567-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8AU3CE_MnLRwABmgbaFRk__gSP-v-e9N
X-Proofpoint-ORIG-GUID: cAynI-UH-Rb65ZTzm-z57feTwjfjpvOv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_12,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0
 bulkscore=0 mlxlogscore=999 clxscore=1015 impostorscore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402050137
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

After console_sshd_config(), the SSH server needs to be nudged to pick
up the new configs. The scripts for the other BSD flavors already do
this with a reboot, but a simple reload is sufficient.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tests/vm/freebsd | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/vm/freebsd b/tests/vm/freebsd
index b581bd17fb7..1247f40a385 100755
--- a/tests/vm/freebsd
+++ b/tests/vm/freebsd
@@ -81,50 +81,51 @@ class FreeBSDVM(basevm.BaseVM):
         self.console_wait("Full name")
         self.console_send("%s\n" % self._config["guest_user"])
         self.console_wait_send("Uid",                   "\n")
         self.console_wait_send("Login group",           "\n")
         self.console_wait_send("Login group",           "\n")
         self.console_wait_send("Login class",           "\n")
         self.console_wait_send("Shell",                 "\n")
         self.console_wait_send("Home directory",        "\n")
         self.console_wait_send("Home directory perm",   "\n")
         self.console_wait_send("Use password",          "\n")
         self.console_wait_send("Use an empty password", "\n")
         self.console_wait_send("Use a random password", "\n")
         self.console_wait("Enter password:")
         self.console_send("%s\n" % self._config["guest_pass"])
         self.console_wait("Enter password again:")
         self.console_send("%s\n" % self._config["guest_pass"])
         self.console_wait_send("Lock out",              "\n")
         self.console_wait_send("OK",                    "yes\n")
         self.console_wait_send("Add another user",      "no\n")
         self.console_wait_send("~ #", "exit\n")
 
         # setup qemu user
         prompt = "$"
         self.console_ssh_init(prompt, self._config["guest_user"], self._config["guest_pass"])
         self.console_wait_send(prompt, "exit\n")
 
         # setup root user
         prompt = "root@freebsd:~ #"
         self.console_ssh_init(prompt, "root", self._config["root_pass"])
         self.console_sshd_config(prompt)
+        self.console_wait_send(prompt, "service sshd reload\n")
 
         # setup virtio-blk #1 (tarfile)
         self.console_wait(prompt)
         self.console_send("echo 'chmod 666 /dev/vtbd1' >> /etc/rc.local\n")
 
         pkgs = self.get_qemu_packages_from_lcitool_json()
         self.print_step("Installing packages")
         self.ssh_root_check("pkg install -y %s\n" % " ".join(pkgs))
 
         # shutdown
         self.ssh_root(self.poweroff)
         self.wait()
 
         if os.path.exists(img):
             os.remove(img)
         os.rename(img_tmp, img)
         self.print_step("All done")
 
 if __name__ == "__main__":
     sys.exit(basevm.main(FreeBSDVM, config=FREEBSD_CONFIG))
-- 
2.43.0


