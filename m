Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09AE6C54E64
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 15:34:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1romKS-0006e9-5d; Mon, 25 Mar 2024 11:33:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1romKO-0006dS-9u
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 11:33:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1romKM-0001B8-C4
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 11:33:36 -0400
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42PDiIIV001586; Mon, 25 Mar 2024 15:33:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Nt/7aLwD1Ryr2kW+Dq6ZqOgE/1Q5GG08X3g2BeRFpfU=;
 b=qnjJwisRFJuUBlNi835NcnW/CsZV2ZywAi/p/JZ13Q6dFOg3GphdAQgmiw7f6noSedNX
 awoY+Lxkdp/YJT3d1CRluAhzpgFbAxQt6p/Ky65c/ysTSlqN/GRUXPdBN1jS8DByVATh
 5l/IhxkUx71+ztbZCrVd7zP49Rd0al1jPMttwYMzCiqwp2wAO9+LUif8RvnBDPqyWOA9
 4nqzyD/4B8+HIADEAxPmphEN1+B92Z2F4+BTAbOLeqvy2+yF9DJYOuxJZKLeO6pT5fA9
 9IXEgprxfrgqqDx3N2/MhKw4ARYLkggFnCWIL8cs80VbOR2TI5hz2ZhMgxelaxVx+/Qt SA== 
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x2b71b46r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 25 Mar 2024 15:33:31 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 42PDekMR013358; Mon, 25 Mar 2024 15:33:30 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3x29t0a6se-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 25 Mar 2024 15:33:30 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 42PFXQ0o28967528
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 25 Mar 2024 15:33:29 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D36642004E;
 Mon, 25 Mar 2024 15:33:26 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7B2892004B;
 Mon, 25 Mar 2024 15:33:26 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.171.7.191])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 25 Mar 2024 15:33:26 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 2/4] linux-user: Fix shmat() strace
Date: Mon, 25 Mar 2024 16:07:39 +0100
Message-ID: <20240325153313.526888-3-iii@linux.ibm.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240325153313.526888-1-iii@linux.ibm.com>
References: <20240325153313.526888-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: IXLbydQOEVg2-eouF6Brt86Jmj34afIM
X-Proofpoint-GUID: IXLbydQOEVg2-eouF6Brt86Jmj34afIM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-25_11,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999
 impostorscore=0 mlxscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 suspectscore=0 adultscore=0 bulkscore=0
 clxscore=1015 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403250084
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The indices of arguments passed to print_shmat() are all off-by-1,
because arg1 is the ipc() command. Fix them.

New output for linux-shmat-maps test:

    3501769 shmat(4784214,0x0000000000800000,SHM_RND) = 0

Fixes: 9f7c97324c27 ("linux-user: Add strace for shmat")
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 linux-user/strace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index 9be71af4016..3b4ccd9fa04 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -703,7 +703,7 @@ print_ipc(CPUArchState *cpu_env, const struct syscallname *name,
         break;
     case IPCOP_shmat:
         print_shmat(cpu_env, &(const struct syscallname){ .name = "shmat" },
-                    arg1, arg4, arg2, 0, 0, 0);
+                    arg2, arg5, arg3, 0, 0, 0);
         break;
     default:
         qemu_log(("%s("
-- 
2.44.0


