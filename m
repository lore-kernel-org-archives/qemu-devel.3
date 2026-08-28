Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48603C61DB9
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 23:01:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x05Xx-0000Is-35; Fri, 28 Aug 2026 18:59:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x05Xu-0000Gy-Os
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:59:39 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x05Xt-0005lJ-6x
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:59:38 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67SMTfgm227143
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 22:59:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=RBnYWGfLDA1
 gt1J6Cw1Kcn5g3TexB8FZRZbiLEs+8Yo=; b=nZJrVD5U/uJRQCQemk+ez0DFnlO
 1TqI+wCqmPibqTWghXOZioz2QcDVWqlKLbt2gnoUMczf9JW5kxqoq72Kik5cs6/P
 laLY12hmk4nJ4KpxRDuZ+7ho+yoAGY32pd2Ao5smMKXji9/pyP9NOs5Q+sKoknSE
 UgtxyaTkjXo5bmDU/xSR9MwnBQKSbE/fKOAZBFqH00fnaRmBXjXZ3YrT24UNXGwo
 TaYgo4HbUVtHCeI9+2fvVDtFghk/DOQq0mup1/yg6tuZHxJLLWDKFkhQiObwzeKC
 0tH0PN7kl5KrmvxYuoJ4bkQaWOR/z+zUd4CaSg8Dl3SBFuel8i10EHYN/HA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gb62h3a79-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 22:59:36 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3965ba1ba3eso2302973a91.2
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 15:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787957975; x=1788562775; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RBnYWGfLDA1gt1J6Cw1Kcn5g3TexB8FZRZbiLEs+8Yo=;
 b=SC6XawFHpjjpeslMrg0tILpvst2WLbnciZLXoasuKHun7UoLzsREsnEezVM7ozFpsV
 cqOZ/mRf3i0Rsp/6uJcK74GtqzGj8hYTrUmLgdceECMR/yiJqWTyj6P5KSZw0Yc9Z589
 SVn4g1+WqY5CRFmMvgpvefPv/C5oxFETQ7R1Kts724kLftz2G6iqlU50ea5IgutIRgIM
 oMEqWbfML8pjhQmpMvS0iFD9sRPd0r+mGOLXf6PMjVmsuyG9x2RAVjjT90sn7a1GPNPY
 4D+vQODc0ROZcn6Qu5cK74iebZC+WQ5sndiS/g9kTNCueJmCxKB2c7EqtfyAcr1ZoBD2
 SY2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787957975; x=1788562775;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=RBnYWGfLDA1gt1J6Cw1Kcn5g3TexB8FZRZbiLEs+8Yo=;
 b=rZX9SZ5+Utp2APgUfI9icAjeJn3bl84xr1druJ4INMwqMJRbZ8nwOxuwUCEPGAzIOs
 7snTRtm2nWCltY2ulRxmYbozMhL9Ep3SV7z3dq/C1YJR48CaJsHVWeu25RjLZGBuEP/8
 MgnvW0NIGzLG2OlyCL9RorXo6jrBZYHvs+qbMQlKucdOG0lSGGpUUHOdC6t6uAUpUg8w
 e4IxrKzoGl/+08+2a436vi9s/AFnF6vk9ySokAzBFu8fMWH8gfOv51VVby1N3ARXPtro
 RCKj96AE97x2yKTd6tYxRLTOyLKkjW5oaSamnaXINgsICq1sGXRrrGKlvXzjC9J3w9pV
 NdKw==
X-Gm-Message-State: AFuF++kvaOgE7L/ls+Jmo8Va5F7gjvoZmTSGxOHgIPIovC5YUXD7PFKD
 fUN3wFvCrnuF+ibekNShmJ0OGI/o74EwrRQgFbECYjFi3g1V4motnRHqUqtpYBBrsQuAVrP5L32
 YUFp0hXxCWaYZgaYfcoGn+tyLOOVnZIqv43ITZ51XmuPPlkER5M1AyNvpGZAR7DP/3w==
X-Gm-Gg: AYBFou1Ol5iTQu/sLB1FNP8BmtOef4A595ETLzZSrgxuFq14QVbYfDqZxPP/36aVjAZ
 MI0BbqxCYQL+/WnKsh0PfTdMFhBsxh9ZbZQpqsLx4ckO9ZQZKPFsr1QEDrarq5UYrnTppkMpNya
 eRPK2hUT7K68xfVH3diZj35brhifT+1BikPRKxNzkMTXcvzh/wLB6x7d+l5xz3RijbL/0WcUCXa
 sDNeBuSZ8Gbxm5RH5jKO7xWKvYutdMJs/XJPOPd8T1bEEFAGEI0bqQHoerog5wmFYzu54Vcq9eA
 1FDQBMhey8vyXq/Qq5NGN+NErW/+H9cB492CRAJnQ4l7X2ACSiWughlRfFYo5UeCF793JXYHcIT
 3aYiOBjqhGgXMQgGCzLSUvDqNGBtUXZzu5gTzH0WWGTPl+MhL2ZJEkT3tmHk=
X-Received: by 2002:a17:90b:164b:b0:37f:fdc8:71b4 with SMTP id
 98e67ed59e1d1-396d0e27d7amr18017641a91.2.1787957975248; 
 Fri, 28 Aug 2026 15:59:35 -0700 (PDT)
X-Received: by 2002:a17:90b:164b:b0:37f:fdc8:71b4 with SMTP id
 98e67ed59e1d1-396d0e27d7amr18017586a91.2.1787957974703; 
 Fri, 28 Aug 2026 15:59:34 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-142e0de4de3sm12862827c88.12.2026.08.28.15.59.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 15:59:34 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: anjo@rev.ng, Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 philmd@oss.qualcomm.com, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 21/47] hw/riscv: remove DEFINE_MACHINE_{RISCV32,RISCV64}
Date: Fri, 28 Aug 2026 22:58:35 +0000
Message-ID: <20260828225901.367438-22-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDIwMCBTYWx0ZWRfX5wBTW3Zyjq7k
 uEbawYGbGEl+7BlVQWmW5fProAbt2Wcz91vpPX0P+T0AQChZXK/v/+jsCQGr9zM1PY0+ct3Xudz
 UUPDSUVo9n8cUrNBwuLqqp4i7AwAOOE=
X-Proofpoint-GUID: ZSTWqeobuHp0aekx66SnTIiNiOaavPH4
X-Proofpoint-ORIG-GUID: ZSTWqeobuHp0aekx66SnTIiNiOaavPH4
X-Authority-Analysis: v=2.4 cv=I5dVgtgg c=1 sm=1 tr=0 ts=6a9212d8 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=kt-N5C0VSMjj5JecdnAA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDIwMCBTYWx0ZWRfX5UKWNypjs1MF
 TC/5hP+/Fy1lB/ZTOtEpclBULnOz5+n6wavcNo4fxhzczptHOQAlBn2orh30P6H8+FdTnZbbgFO
 zYxqEBqH1LgEg9VirQMdQpHlPkFw/51nAQRqk9LmQccBC6YGCHtmTX5yV3tRd5bOxKBhd4e2LHW
 3zP3EqemDqUiCGllMO+4PRIebU5a6WOp9GuXkpgNKbG1SGyAfeUmhG8ctk8XznUEu6T4QSzimyF
 GCWfTMM6AYQ2UTVEr6Vy6fAuHcUGWMIxR/LaxmjqCb2noNlzjPKpxUB0Ihxqy3hR2gGJqNMNy4J
 K5mRh+s73hoG9pUqXu69ez7yoVKp/ieIIp6OaFo6voXL19f4i1amES0EOrx3Lswct8MJ6zq75p+
 AzywbK04InR9ZCPGmDR5PZBU20xwRX59PwhftFbWhMMrKxKgEU+K83GH2we8lSmQA9PpeMqvxw4
 fkfpddQotiNsmVoiU+A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_07,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 clxscore=1015 malwarescore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608280200
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 hw/riscv/boston-aia.c           |  2 +-
 hw/riscv/microblaze-v-generic.c |  2 +-
 include/hw/riscv/machines-qom.h | 17 -----------------
 3 files changed, 2 insertions(+), 19 deletions(-)

diff --git a/hw/riscv/boston-aia.c b/hw/riscv/boston-aia.c
index 965d0f5699e..30eff10bc5f 100644
--- a/hw/riscv/boston-aia.c
+++ b/hw/riscv/boston-aia.c
@@ -474,4 +474,4 @@ static void boston_mach_class_init(MachineClass *mc)
     mc->default_cpu_type = TYPE_RISCV_CPU_MIPS_P8700;
 }
 
-DEFINE_MACHINE_RISCV64("boston-aia", boston_mach_class_init)
+DEFINE_MACHINE("boston-aia", boston_mach_class_init)
diff --git a/hw/riscv/microblaze-v-generic.c b/hw/riscv/microblaze-v-generic.c
index d33ac39a68c..503e8e08992 100644
--- a/hw/riscv/microblaze-v-generic.c
+++ b/hw/riscv/microblaze-v-generic.c
@@ -187,4 +187,4 @@ static void mb_v_generic_machine_init(MachineClass *mc)
     mc->default_cpus = 1;
 }
 
-DEFINE_MACHINE_RISCV32_64("amd-microblaze-v-generic", mb_v_generic_machine_init)
+DEFINE_MACHINE("amd-microblaze-v-generic", mb_v_generic_machine_init)
diff --git a/include/hw/riscv/machines-qom.h b/include/hw/riscv/machines-qom.h
index e5f45b32e69..79d212eeb7d 100644
--- a/include/hw/riscv/machines-qom.h
+++ b/include/hw/riscv/machines-qom.h
@@ -11,21 +11,4 @@
 
 #include "hw/core/boards.h"
 
-/*
- * Helper macros for defining machines available in qemu-system-riscv32,
- * qemu-system-riscv64, or both.
- */
-
-#define DEFINE_MACHINE_RISCV32(namestr, machine_initfn) \
-        DEFINE_MACHINE_WITH_INTERFACE_ARRAY(namestr, machine_initfn, \
-                                            NULL)
-
-#define DEFINE_MACHINE_RISCV64(namestr, machine_initfn) \
-        DEFINE_MACHINE_WITH_INTERFACE_ARRAY(namestr, machine_initfn, \
-                                            NULL)
-
-#define DEFINE_MACHINE_RISCV32_64(namestr, machine_initfn) \
-        DEFINE_MACHINE_WITH_INTERFACE_ARRAY(namestr, machine_initfn, \
-                                            NULL)
-
 #endif
-- 
2.43.0


