Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EE5AD6C29A
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 21:13:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDVWT-0003uJ-9G; Tue, 19 Nov 2024 16:12:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1tDVWR-0003tx-I4; Tue, 19 Nov 2024 16:12:31 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1tDVWP-0001qr-Ie; Tue, 19 Nov 2024 16:12:30 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJKoWgC023630;
 Tue, 19 Nov 2024 21:11:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=FNF+lBstRPt7YpGNOe/6XDjCFa//FEiep3+qWjMfC
 pU=; b=a4Uwy/JdJ9hkdyEkUsD5eAd0k7IAsqTtW/65TZOIZKfEWtYHpds+rQmWE
 35HJl42/k3rQUiEoctZZGfo9bi4JojepZ3Jba3DGnneF46KUC6OOS5H8hXTqR0kB
 vpLmiknw8Ev4qIWq+bb8YS//UuneynB8IfXLe/sY7uNyxNwyPMUHbopE/uc/5A8F
 qvbDO/ScJNPT1B1aEt9ySYjT4qrNTeU7Y9OQ1cEDy/pj/NOZBq04M/HXZP69KlkM
 KPcHKapngkbCQCLgYy+mU5wLeWJ/SeDqHVYO2dStYc4yL2ToHCQVJvOW/UstpuS/
 8LJtOQA6sV6ZeNeA1bbnHaEJRRf+A==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42xyu1r9b9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 Nov 2024 21:11:57 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJJc4ft030980;
 Tue, 19 Nov 2024 21:11:56 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42y63ym4tn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 Nov 2024 21:11:56 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4AJLBsAm45220180
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 19 Nov 2024 21:11:54 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5437A20049;
 Tue, 19 Nov 2024 21:11:54 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D7A9E20040;
 Tue, 19 Nov 2024 21:11:53 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.171.67.28])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 19 Nov 2024 21:11:53 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Laurent Vivier <laurent@vivier.eu>, Thomas Huth <thuth@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 qemu-stable@nongnu.org
Subject: [PATCH] linux-user: Fix strace output for s390x mmap()
Date: Tue, 19 Nov 2024 22:11:21 +0100
Message-ID: <20241119211138.148806-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: enZYBY9vHP-u9EwR9tAVslfdetO4YCBW
X-Proofpoint-ORIG-GUID: enZYBY9vHP-u9EwR9tAVslfdetO4YCBW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 bulkscore=0 spamscore=0 mlxlogscore=999 adultscore=0 mlxscore=0
 clxscore=1015 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411190153
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

print_mmap() assumes that mmap() receives arguments via memory if
mmap2() is present. s390x (as opposed to s390) does not fit this
pattern: it does not have mmap2(), but mmap() still receives arguments
via memory.

Fix by special-casing s390x.

Cc: qemu-stable@nongnu.org
Fixes: d971040c2d16 ("linux-user: Fix strace output for old_mmap")
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 linux-user/strace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index b70eadc19ef..50f41e746ec 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -3971,7 +3971,7 @@ print_mmap(CPUArchState *cpu_env, const struct syscallname *name,
 {
     return print_mmap_both(cpu_env, name, arg0, arg1, arg2, arg3,
                            arg4, arg5,
-#if defined(TARGET_NR_mmap2)
+#if defined(TARGET_NR_mmap2) || defined(TARGET_S390X)
                             true
 #else
                             false
-- 
2.47.0


