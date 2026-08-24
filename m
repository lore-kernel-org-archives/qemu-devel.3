Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 378F4C5DF81
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 16:00:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyX4Q-00059l-3e; Mon, 24 Aug 2026 11:58:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wyX4J-00057y-VK
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 11:58:40 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wyX4I-0001lq-3p
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 11:58:39 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67OFmqdu3234833
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 15:58:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=LPhEBKq1x4e
 /BOddVE3zuRODvz5LnOso+2gMy+UCqFc=; b=gA5ShNXpoUH+fY4l04zJKnwwxVX
 QSPCU4Ym+holri0inYj7x1G9k35kihQrWu4cBWBeni7Q2LC7o6oB8oa5eUh25jL2
 Tejm0f9Wk1CaZz41G8iCZTq5b+5p75JxtQuralwHuiEk9h7lwk6Z90CIkA1bhUI1
 bes970V6TmQp0Lz9sgCInWBC8UFj/P/ISzuzlEKFBxS/gI2co+8ue33nx4RwTCMa
 AV4eteD0ecNBivd5H7MXa4cLuvGAryrTm44P014dc1FX7AQIzNbCrFFqxZq500sf
 7V3F3k8TF7fgqTbR9Ugl8XQ+/gKnvZyKCa3ZZ+4Fu/L14mtMCEm5JMoc9Dg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8gqnab19-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 15:58:36 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-39512608fb1so9143531a91.1
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 08:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787587116; x=1788191916; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LPhEBKq1x4e/BOddVE3zuRODvz5LnOso+2gMy+UCqFc=;
 b=Zb4Bodza5iuinQ7y40D4gdR7OqF4l+D9JaUMog3MWweN2itL9LObr8ycmJhuOVbOQ6
 OreI0+yfj7nrjw+ynUF8clBuL58u1E7VaFBY47ZraGjzTu+c2htAYktlrX+DCuaAoz2x
 Cw7ERQZKWTs9gKTrP3N89NRnz3z/YAoz3jaa0uFFBSqBf8DDDbwJNaUCMFul+HxH4Pmw
 M8b4u2JDTM8w6o3ZssVQRJWmGykPp1U3tC0cY8eQFyXsZqH2OeM0HvbuiJG3RG1RNZNU
 X/+9ZwESKdm71DKmJy94q2KRL41wujvXeimGPqBtVs945sPs6zZY4XD0fsV6H673hsfY
 TmcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787587116; x=1788191916;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=LPhEBKq1x4e/BOddVE3zuRODvz5LnOso+2gMy+UCqFc=;
 b=e6s6Vi2MmIxUbOjk901u1omY1JMUci3WQBFOAfI7LAHcGgmZtUyH+93g93pRvmRb0Y
 iE3IdwWiHOhER9vdwQrCMzpMvokV3wCXjiDABP8vPEy+wliQVgBhK+ER5ZLKeoPX2+4b
 Zfl3Aa0mXoLiOTSjN0HFMGPHhlshnBnBtTOAOdCmH4hW7I/LgDeHYRpWESq47d4v/2hm
 pTmbaF71veWt9AeuVsZNQJRqdqYNZAUYRwIU/wByhVjjavvecvPbClFgzh70of9VXvUv
 NtyaME0jhTpe/oHghZsDgq6ktuEJifqvJGX/eeOib+9KN4E+VtkNaArcV6N8ji9MPx9P
 kIQg==
X-Gm-Message-State: AFuF++lszVJnl7X/HDMT1dyl/PZEqNP48/8EbMKs/hEtDB+nGlpZ+AKn
 k3NDpuSO2Xh87CbjLX7/njc5cSbYro1S9XinAu9WQGXA5UFkCS/7GHlzL7X8iXVDTtv9AS8OFtQ
 KgZ11bVBvONO4fujwTI6wcbRAegzGujIR3oTp3qfvusdTW9VKDaAfdUP/jqwyA3p8aw==
X-Gm-Gg: AR+sD12DS5Op1pKaT8FIXVpJzgnSkcW+QTH0wwNL+6JKQRTvwg/TpZQ9hQukyOdisex
 RZMLMFtPaMVgZDLzFox6MmYxVyHnULtvp2NGsnWczP0HlvJfS/bddryESu8yBcFWKtsXf+M6V6+
 06nSDf0vOcytFl1xQqKLJWiOig0BkMRkJJZX8qBZ01Bi6a/Yqd0LMJCMdoQ5yCHJZiYolASctVD
 YFbeI8ATPckI6fwqnnumNrwR9ahyJU0AQcbnNXaEnDl1PA/QGITvj7bYFw8eVjfWXUP6qxSzIuK
 XtzezuvTHbFBsUxTKFDaqspUjJvyUfwdD0lWLEDElNfgXNJsHkauptRngLtiUdpzL2rR7P1uH/m
 uRnLhLi2sKebg4qiqg5vsGlzLt8/vcx+3MyhrtB7iaIjR3x7qTRNJHSCK75Gj6Sw=
X-Received: by 2002:a17:90b:3b4d:b0:38d:ef48:b04 with SMTP id
 98e67ed59e1d1-395c39b1750mr46325353a91.10.1787587115970; 
 Mon, 24 Aug 2026 08:58:35 -0700 (PDT)
X-Received: by 2002:a17:90b:3b4d:b0:38d:ef48:b04 with SMTP id
 98e67ed59e1d1-395c39b1750mr46325254a91.10.1787587115471; 
 Mon, 24 Aug 2026 08:58:35 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14186183c0esm41152935c88.12.2026.08.24.08.58.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 08:58:35 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, anjo@rev.ng, brian.cain@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, philmd@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com
Subject: [PATCH v4 09/14] semihosting: add ftruncate helper (to be used for
 hexagon)
Date: Mon, 24 Aug 2026 08:58:18 -0700
Message-Id: <2b36fa49933ab9e8df729a2794826a6368d53182.1787586642.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1787586642.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1787586642.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDEzNCBTYWx0ZWRfX+W47Bs3IGkf/
 M2gyoY+TTmdGMgWrJd5R/TUKKt1M66+oCBKRF1uq0IusRyuGS0DbfKsePO1xinnRYiUhXh+P1yI
 AvMIk+bd9ccSLrhD9oyZlqO5QyJcVAI=
X-Proofpoint-GUID: -A8Vt1q8Ci0ZeCr9-C9IU-z5fvLVm8iH
X-Authority-Analysis: v=2.4 cv=fqXsol4f c=1 sm=1 tr=0 ts=6a8c6a2d cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=H7u-uynIU280lupyLLIA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDEzNCBTYWx0ZWRfX7CWDrn0z4L24
 q7Kszb49gymXw2d8Wxh2A88PAKrb2Jj6eaIfbsjJUq6TwFOKFu1Ov0S5nk4NUxkOeKoVjGr/p0b
 n6W2s495tHNyDtQL+TL1IDe/mtel5C5V7Xn4fDztXsbsZmxEQ9gZaLI6ZIk8dTTb/0CBPiy9xgN
 PeU1Fn+kiI1BE+uFVlE+A7SxDDYSy803EacTVpqENSZUxyg+z9pVlzxwvnAHhDs508v+5S1tu1H
 fPF5e4V7dNVeoEpYrVp5ZGn5RpQSsj5aaiJiZnZGSm2BqmS/zlxA8cffLO9720w+PQ9nQ6QGvDV
 oy9SU0ZLHcu4cSVgKgP11zD1xk70sww6aSRNLsb/b0ID/eEc6laDC/k+scNATkaSvml54hFqR16
 DPO0YwVqic9x28zP7WksemmQI2DELLt2RLaK2OSRwncFjyYxYrEfQsc7C/dOsimDuXlmot9H8wi
 fcM8aDmSHE4yTyuQJKA==
X-Proofpoint-ORIG-GUID: -A8Vt1q8Ci0ZeCr9-C9IU-z5fvLVm8iH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_05,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 phishscore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240134
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The common semihosting syscall layer has no ftruncate
helper, but the Hexagon semihosting ABI includes an FTRUNC
operation.  Add semihost_sys_ftruncate() so that Hexagon
can delegate to it rather than calling ftruncate directly.

Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
---
 include/semihosting/syscalls.h |  2 ++
 semihosting/syscalls.c         | 29 +++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/include/semihosting/syscalls.h b/include/semihosting/syscalls.h
index 03aa45b7bb..3919ab64c7 100644
--- a/include/semihosting/syscalls.h
+++ b/include/semihosting/syscalls.h
@@ -75,4 +75,6 @@ void semihost_sys_gettimeofday(CPUState *cs, gdb_syscall_complete_cb complete,
 void semihost_sys_poll_one(CPUState *cs, gdb_syscall_complete_cb complete,
                            int fd, GIOCondition cond, int timeout);
 
+void semihost_sys_ftruncate(CPUState *cs, gdb_syscall_complete_cb complete,
+                            int fd, off_t len);
 #endif /* SEMIHOSTING_SYSCALLS_H */
diff --git a/semihosting/syscalls.c b/semihosting/syscalls.c
index 20f155f869..0456db0bef 100644
--- a/semihosting/syscalls.c
+++ b/semihosting/syscalls.c
@@ -8,10 +8,12 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
+#include "qemu/error-report.h"
 #include "gdbstub/syscalls.h"
 #include "semihosting/guestfd.h"
 #include "semihosting/syscalls.h"
 #include "semihosting/console.h"
+#include "semihosting/semihost.h"
 #ifdef CONFIG_USER_ONLY
 #include "qemu.h"
 #else
@@ -541,6 +543,13 @@ static void host_poll_one(CPUState *cs, gdb_syscall_complete_cb complete,
 }
 #endif
 
+static void host_ftruncate(CPUState *cs, gdb_syscall_complete_cb complete,
+                           GuestFD *gf, off_t len)
+{
+    int err = ftruncate(gf->hostfd, len);
+    complete(cs, err, err < 0 ? errno : 0);
+}
+
 /*
  * Static file semihosting syscall implementations.
  */
@@ -982,3 +991,23 @@ void semihost_sys_poll_one(CPUState *cs, gdb_syscall_complete_cb complete,
     }
 }
 #endif
+
+void semihost_sys_ftruncate(CPUState *cs, gdb_syscall_complete_cb complete,
+                            int fd, off_t len)
+{
+    GuestFD *gf = get_guestfd(fd);
+    if (!gf) {
+        complete(cs, -1, EBADF);
+        return;
+    }
+
+    switch (gf->type) {
+    case GuestFDHost:
+        host_ftruncate(cs, complete, gf, len);
+        break;
+    default:
+        error_report("ftruncate call not implemented "
+                     "for this semihosting mode.");
+        g_assert_not_reached();
+    }
+}
-- 
2.37.2


