Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C86A3C4829C
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 00:24:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rX9Fo-0001kJ-W6; Mon, 05 Feb 2024 19:24:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rX9Fm-0001jG-7L
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 19:23:58 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rX9Fk-0003sR-7U
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 19:23:57 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 4160LX3c023430; Tue, 6 Feb 2024 00:23:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=On0cXnAM/VIOLau6BhfyMy6ezCUC5MviB/LlM3G3vMg=;
 b=tgi4/nkVVof0lYAgMu/72WYxHHcUkxGHcdh3w+t13N7hbuAOxoBKmy4csurJwpNIoS0r
 lpTBvlHslsG2+3XMwIPEtTWfXRhxZ3AvPgZKo+rLgs/xRU4mrN+Yg4Bp0vzUnj8rCJN5
 2ji4LhENnaJ3QkHSSQxSavAHVDBaDUye7OOKVXk8gepcgVdrI3nbE2lJoxbmHchJYOBP
 NaPBWW/lcGsa1ZzihVstpRnZLdkrP+OU31mQucCA0utqNUHHaqzybOBOnK+tvsV5LadT
 9ydxMPmhmF9qajUHMplUrBhAjBBZ262kJ0WBXLkl+wEe/Ym9k5xSbQh8QH8Jr72yXBSi DA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w3a1b04ur-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Feb 2024 00:23:51 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4160MREZ027649;
 Tue, 6 Feb 2024 00:23:51 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w3a1b04uh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Feb 2024 00:23:51 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 415L9ujq008527; Tue, 6 Feb 2024 00:23:50 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w221judsf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Feb 2024 00:23:50 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4160NmMY22217390
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 6 Feb 2024 00:23:48 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 739CE2004B;
 Tue,  6 Feb 2024 00:23:48 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9006520043;
 Tue,  6 Feb 2024 00:23:47 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.171.57.170])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  6 Feb 2024 00:23:47 +0000 (GMT)
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
Subject: [PATCH v3 1/4] tests/vm: Set UseDNS=no in the sshd configuration
Date: Tue,  6 Feb 2024 01:22:00 +0100
Message-ID: <20240206002344.12372-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240206002344.12372-1-iii@linux.ibm.com>
References: <20240206002344.12372-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: WeyJueHIf02_T5wwHJZuz31MOJrrGh3i
X-Proofpoint-ORIG-GUID: G4YbgauUn_SGLnoafyLauhsKfJncTkNt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_18,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 clxscore=1015 mlxscore=0 mlxlogscore=999
 spamscore=0 malwarescore=0 adultscore=0 impostorscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402060000
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

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tests/vm/basevm.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 61725b83254..c0d62c08031 100644
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -406,40 +406,42 @@ def console_send(self, command):
             vm.console_socket.send(char.encode("utf-8"))
             time.sleep(0.01)
 
     def console_wait_send(self, wait, command):
         self.console_wait(wait)
         self.console_send(command)
 
     def console_ssh_init(self, prompt, user, pw):
         sshkey_cmd = "echo '%s' > .ssh/authorized_keys\n" \
                      % self._config['ssh_pub_key'].rstrip()
         self.console_wait_send("login:",    "%s\n" % user)
         self.console_wait_send("Password:", "%s\n" % pw)
         self.console_wait_send(prompt,      "mkdir .ssh\n")
         self.console_wait_send(prompt,      sshkey_cmd)
         self.console_wait_send(prompt,      "chmod 755 .ssh\n")
         self.console_wait_send(prompt,      "chmod 644 .ssh/authorized_keys\n")
 
     def console_sshd_config(self, prompt):
         self.console_wait(prompt)
         self.console_send("echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config\n")
+        self.console_wait(prompt)
+        self.console_send("echo 'UseDNS no' >> /etc/ssh/sshd_config\n")
         for var in self.envvars:
             self.console_wait(prompt)
             self.console_send("echo 'AcceptEnv %s' >> /etc/ssh/sshd_config\n" % var)
 
     def print_step(self, text):
         sys.stderr.write("### %s ...\n" % text)
 
     def wait_ssh(self, wait_root=False, seconds=300, cmd="exit 0"):
         # Allow more time for VM to boot under TCG.
         if not kvm_available(self.arch):
             seconds *= self.tcg_timeout_multiplier
         starttime = datetime.datetime.now()
         endtime = starttime + datetime.timedelta(seconds=seconds)
         cmd_success = False
         while datetime.datetime.now() < endtime:
             if wait_root and self.ssh_root(cmd) == 0:
                 cmd_success = True
                 break
             elif self.ssh(cmd) == 0:
                 cmd_success = True
-- 
2.43.0


