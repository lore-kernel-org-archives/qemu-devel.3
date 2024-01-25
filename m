Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0B3AC47258
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 19:49:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rT5ie-0001NZ-MZ; Thu, 25 Jan 2024 14:49:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rT5ic-0001NC-Sz
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 14:48:58 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rT5ib-0007yW-95
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 14:48:58 -0500
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40PJTusJ028624; Thu, 25 Jan 2024 19:48:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=1aXNMtXqDOFZ4/4XM1jhbh4Ge1wdZLWmcGewq2S0We0=;
 b=e/JUhDlDCBABeCzydI8D/ULUuUrETbDfF2PROhH4AFHgujF0L1ZnjXC7Sw/D3oDGOLbd
 ACzKX8+3eoS56hi7AFi8sxeAe6eNw0PPFgjdxMQ5p/Y0gcNyRdFJOkf9sF6LBsFW/NtJ
 TgRTGOHzeLSR5aWhCQWK1nVnWvpuYfLBUO6C0RttNYLpMB/5Q5BCsnJFztpJRqK7p0C0
 1girtpQdrJ3P9hyK1OuhKy2CnC6Bg2iygHy0gQpBw6ya7wcwAk1RcuHUbPv/eT5eyHCK
 5ogykdifkGmdNNhligoyt6iqBGwUBxL7uGxOIv418YG4xfEjw/AuDLFp8YRKJU+lPtKb yg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vuqt8twut-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Jan 2024 19:48:51 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40PJUTfJ032709;
 Thu, 25 Jan 2024 19:48:50 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vuqt8twub-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Jan 2024 19:48:50 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 40PJKDDg022412; Thu, 25 Jan 2024 19:48:49 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vrt0me59s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Jan 2024 19:48:49 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 40PJmlMR24314462
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 25 Jan 2024 19:48:47 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 405C120043;
 Thu, 25 Jan 2024 19:48:47 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5256220040;
 Thu, 25 Jan 2024 19:48:46 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.171.21.210])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 25 Jan 2024 19:48:46 +0000 (GMT)
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
Subject: [PATCH 1/3] tests/vm: Set UseDNS=no in the sshd configuration
Date: Thu, 25 Jan 2024 20:48:16 +0100
Message-ID: <20240125194840.1564-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240125194840.1564-1-iii@linux.ibm.com>
References: <20240125194840.1564-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: O0_n9glCsR7Y6FYeu78rzsZgpDzTZxhp
X-Proofpoint-GUID: p5UZdQ6UXGTJUKinLfyrOxcfUo5VVC5l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_12,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015
 lowpriorityscore=0 bulkscore=0 adultscore=0 impostorscore=0 mlxscore=0
 spamscore=0 malwarescore=0 phishscore=0 priorityscore=1501 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401250143
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

make vm-build-freebsd sometimes fails with "Connection timed out during
banner exchange". The client strace shows:

    13:59:30 write(3, "SSH-2.0-OpenSSH_9.3\r\n", 21) = 21
    13:59:30 getpid()                       = 252655
    13:59:30 poll([{fd=3, events=POLLIN}], 1, 5000) = 1 ([{fd=3, revents=POLLIN}])
    13:59:32 read(3, "S", 1)                = 1
    13:59:32 poll([{fd=3, events=POLLIN}], 1, 3625) = 1 ([{fd=3, revents=POLLIN}])
    13:59:32 read(3, "S", 1)                = 1
    13:59:32 poll([{fd=3, events=POLLIN}], 1, 3625) = 1 ([{fd=3, revents=POLLIN}])
    13:59:32 read(3, "H", 1)                = 1

There is a 2s delay during connection, and ConnectTimeout is set to 1.
Raising it makes the issue go away, but we can do better. The server
truss shows:

    888: 27.811414714 socket(PF_INET,SOCK_DGRAM|SOCK_CLOEXEC,0) = 5 (0x5)
    888: 27.811765030 connect(5,{ AF_INET 10.0.2.3:53 },16) = 0 (0x0)
    888: 27.812166941 sendto(5,"\^Z/\^A\0\0\^A\0\0\0\0\0\0\^A2"...,39,0,NULL,0) = 39 (0x27)
    888: 29.363970743 poll({ 5/POLLRDNORM },1,5000) = 1 (0x1)

So the delay is due to a DNS query. Disable DNS queries in the server
config.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tests/vm/basevm.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 61725b83254..c0d62c08031 100644
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -423,6 +423,8 @@ def console_ssh_init(self, prompt, user, pw):
     def console_sshd_config(self, prompt):
         self.console_wait(prompt)
         self.console_send("echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config\n")
+        self.console_wait(prompt)
+        self.console_send("echo 'UseDNS no' >> /etc/ssh/sshd_config\n")
         for var in self.envvars:
             self.console_wait(prompt)
             self.console_send("echo 'AcceptEnv %s' >> /etc/ssh/sshd_config\n" % var)
-- 
2.43.0


