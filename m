Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 754F9CF07DE
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 09:31:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sypUZ-0001lR-B2; Thu, 10 Oct 2024 05:29:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1sypUX-0001kU-5h
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 05:29:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1sypUV-000421-8X
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 05:29:52 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49A3p856009556;
 Thu, 10 Oct 2024 09:29:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=pp1; bh=dFuj6Hn6kok/C
 BdjstBhKZXei+/iC/1+QozKCBxd9fg=; b=X4R3XwlF0hIJCtul4nPZu6itMj2ZR
 AgTNWuTy/QwZ2kjFtCrzozN5NOxMRa65zyjjT6JT2sG7ZCLjchKTGorD/8AL0nhT
 HGUbwQ5e7xC3jxSztDhFZ3wClj3Ug2g5xJ9BFT4KMSCRuxQqhhImGAtDxyIj3hsE
 jssiR2qC94M4ofT6TVoqs8AUH/cApxviwMvxHr0lKMSmxJo2/WpQHJ8uIWwITB43
 1c5jj+HgjVm6hxZKld2V7FprNf53pfGfwh7L8+KJFfDhu4honWJnVdsx4hs3Wvf7
 uuUmx3pBIlLiHkaLJPwnUBS43O9RWiVK8rfIAam75JSc29z8K9Op0oUlA==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4267cmshrb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Oct 2024 09:29:48 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49A6MGlv022847;
 Thu, 10 Oct 2024 09:29:47 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 423h9k6uwn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Oct 2024 09:29:46 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 49A9TjPT57934148
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 10 Oct 2024 09:29:45 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 09FD72004B;
 Thu, 10 Oct 2024 09:29:45 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8FAFE20040;
 Thu, 10 Oct 2024 09:29:44 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.171.88.135])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 10 Oct 2024 09:29:44 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 1/4] gdbstub: Make gdb_get_char() static
Date: Thu, 10 Oct 2024 11:26:56 +0200
Message-ID: <20241010092938.226868-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241010092938.226868-1-iii@linux.ibm.com>
References: <20241010092938.226868-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Jw85FKBZWbwLiOZ32C70tQstAKQxF3UL
X-Proofpoint-GUID: Jw85FKBZWbwLiOZ32C70tQstAKQxF3UL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-10_05,2024-10-09_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 phishscore=0 mlxlogscore=920 mlxscore=0 spamscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410100062
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

It's user-only since commit a7e0f9bd2ace ("gdbstub: abstract target
specific details from gdb_put_packet_binary").

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 gdbstub/internals.h | 2 --
 gdbstub/user.c      | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/gdbstub/internals.h b/gdbstub/internals.h
index bf5a5c63029..5acc36846f3 100644
--- a/gdbstub/internals.h
+++ b/gdbstub/internals.h
@@ -142,8 +142,6 @@ void gdb_create_default_process(GDBState *s);
 int gdb_signal_to_target(int sig);
 int gdb_target_signal_to_gdb(int sig);
 
-int gdb_get_char(void); /* user only */
-
 /**
  * gdb_continue() - handle continue in mode specific way.
  */
diff --git a/gdbstub/user.c b/gdbstub/user.c
index 0b4bfa9c488..1fef5201f4e 100644
--- a/gdbstub/user.c
+++ b/gdbstub/user.c
@@ -103,7 +103,7 @@ typedef struct {
 
 static GDBUserState gdbserver_user_state;
 
-int gdb_get_char(void)
+static int gdb_get_char(void)
 {
     uint8_t ch;
     int ret;
-- 
2.46.2


