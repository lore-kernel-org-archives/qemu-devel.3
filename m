Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2A70C4828F
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 15:26:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVvQ1-0005SF-F0; Fri, 02 Feb 2024 10:25:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rVvPu-0005R3-2x
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 10:25:22 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rVvPr-0006qZ-3I
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 10:25:21 -0500
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 412EIwoG018590; Fri, 2 Feb 2024 15:25:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=OQo91iZmvNk611L8ybyJ1axOZbex8oBEkfPXN0s0S/8=;
 b=e/ntawsh6wvMgq+i/16LhuwI0RspiPkpd3FpzJo9ToOBDZF74ubeQryDfyCyWOhxWckx
 YxgJojhzb5R+ZjGE+2wKg11XwUdvVXoMUIkLmTC5dLgDFNUqm3td3LMU4+JMDFXFidDq
 eBWXh15PxoMbtShABhdKePuvwOB+zr0D4ySry3hDpTLXYbSbF9Sidre6MuckL2qlzzUf
 hh7u0Qseg4tlPLUrj7i4INaNw2uU2OAo2ICHJoEztE8LuJiy2rjYl2Wv4jjP6M0R/xth
 mnE8e2WaP6WmtyNqwpa1j5NOX0cNpX2KLyhWgI1wPwex7UaLpr8O27aXdhgUJKKF0NVU xg== 
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w121vskbk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 02 Feb 2024 15:25:12 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 412F1AxU017746; Fri, 2 Feb 2024 15:25:11 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vwcj0c8b9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 02 Feb 2024 15:25:11 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 412FP9rr6554250
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 2 Feb 2024 15:25:09 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7AD0E2004D;
 Fri,  2 Feb 2024 15:25:09 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3BDB220043;
 Fri,  2 Feb 2024 15:25:09 +0000 (GMT)
Received: from black.boeblingen.de.ibm.com (unknown [9.155.200.166])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  2 Feb 2024 15:25:09 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v3 1/5] gdbstub: Expose TARGET_SIGTRAP in a target-agnostic way
Date: Fri,  2 Feb 2024 16:23:43 +0100
Message-ID: <20240202152506.279476-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202152506.279476-1-iii@linux.ibm.com>
References: <20240202152506.279476-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: jcakCqSg2ceAbzN2gvkP7uy16vyDc_g4
X-Proofpoint-GUID: jcakCqSg2ceAbzN2gvkP7uy16vyDc_g4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-02_08,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0
 mlxscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 mlxlogscore=962
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402020112
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

The upcoming syscall catchpoint support needs to send SIGTRAP stop
packets to GDB. Being able to compile this support only once for all
targets is a good thing, and it requires hiding TARGET_SIGTRAP behind
a function call.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 gdbstub/internals.h   | 1 +
 gdbstub/user-target.c | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/gdbstub/internals.h b/gdbstub/internals.h
index 5c0c725e54c..aeb0d9b5377 100644
--- a/gdbstub/internals.h
+++ b/gdbstub/internals.h
@@ -136,6 +136,7 @@ void gdb_append_thread_id(CPUState *cpu, GString *buf);
 int gdb_get_cpu_index(CPUState *cpu);
 unsigned int gdb_get_max_cpus(void); /* both */
 bool gdb_can_reverse(void); /* softmmu, stub for user */
+int gdb_target_sigtrap(void); /* user */
 
 void gdb_create_default_process(GDBState *s);
 
diff --git a/gdbstub/user-target.c b/gdbstub/user-target.c
index c4bba4c72c7..b7d4c37cd81 100644
--- a/gdbstub/user-target.c
+++ b/gdbstub/user-target.c
@@ -418,3 +418,8 @@ void gdb_handle_query_xfer_exec_file(GArray *params, void *user_ctx)
                     ts->bprm->filename + offset);
     gdb_put_strbuf();
 }
+
+int gdb_target_sigtrap(void)
+{
+    return TARGET_SIGTRAP;
+}
-- 
2.43.0


