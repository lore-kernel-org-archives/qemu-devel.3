Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85C3CCCF2C2
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 18:15:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHmSc-0007Ji-L8; Fri, 16 Oct 2026 14:15:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHmRz-000799-FC
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 14:14:39 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHmRx-0000Xd-LH
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 14:14:39 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GE5iDw996806
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 18:14:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=RoKpM541Uve
 ahOApnUOLTMixK7bOKy+huXm/Ph8EjaI=; b=VaH2xG7swfCE9wCDlKzThAdDaEb
 poDLyAsLk6nNMj6fA8LAwyA4d7JqM6f/SHOjMByNfTtCRSaGOdHUAqdJ3gE/7J4b
 eWJ9Jo5zgxIx4WX4BM0fK3Orq54KCzwWshv8p3nRtfIFWawhw627dspo02ygYuDL
 63614Y9w1JpAHWO9mJm3Gzmjg6PdQibT0t1q/gDtQg/lLwZLF5gU2KzcCxhIdY8T
 qI2uvHjOGzIomLTE8Ml1Yd9ilwly8NbJVz2ffS64U+0IGaNlMj4SSeqa+tj2NkN1
 MmieAjgickXJ+9H1Lnb3thgGD0fBqSiYruxd6YgoQEmA6pqN8n77TUZVHAQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbcjtb5pr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 18:14:36 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-39de4e72b33so286832a91.2
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 11:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792174475; x=1792779275; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RoKpM541UveahOApnUOLTMixK7bOKy+huXm/Ph8EjaI=;
 b=LehtbD6CnuR5l02DIYsOtP8sZ0b3utDe9UePBF9v0qVTXAu2dwDsv8mhpAEsWiF0G9
 LaysW4E9PbocSZoVgrvBp6JT8aV6FeCPOfLxW+BYtys/Vhbo+3ucEW9R6ZHXfLTEcmgk
 qZa6kTm7WvYqiwqrCApsVQBbJruzuSl00+Hxgh2Fwd7a87vrw2nrjCmuBvwZa/vUBkdy
 8SCFlV5BYgox2LnN6qC7X6ArIcFOxDXHkWhLbdxVWHqPQFWBoGBJiD1rRsMeZ+z0WLyQ
 4wrXewD2AguYabOBDNF8G7BWPocZowI0OPdmyW7C/7psftIGgl4t8g1r+YxWWA2GxOT0
 X3AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792174475; x=1792779275;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=RoKpM541UveahOApnUOLTMixK7bOKy+huXm/Ph8EjaI=;
 b=GKAuFlbeoVApydYvmyNNDxqoSE7BI+3GJm8nRpvRiu9vMNCwhQpyl4R2Drck43bdox
 AbPBUj0ssaBTqID9wrhEnOsI9uaeSdg6uJqJ2tj6KAUHWtWPtS8EJ/F2pLaG1Kggoyuw
 ejhygbFQ/Vg2i8/SxdT/qX8atKlBVSl71ktZ4u4NRxOEmoxVg+V27rTyVBsN/6Bi0g0g
 D60NHu1cG9qlQxwJPOg+BSZD0SocKRoX9JyveIOt4PsrJkphxfVnKL6iOaXpA1k5pSkv
 09QRmBCuP/6w7CLsq9XMmSOf5MLi8+5z+adsaBFADF+HGXrUVwWa3mmVitqetGzOASJE
 sXGQ==
X-Gm-Message-State: AFq9FYIHM8zT1eTpU9uRkpi9YnXJlM/r1OE4os2Ttm4GBkrWifsCKg5r
 UZT1EWkpq+SdNpCEsnGHwFTEdg88uKB8LHVVDqyUscBDPbhadtYMKWwcIwFQ2GmXwEKvkacsq+/
 OmEu3/SyqRbpG666aBF8cUi/WFp8nfwaczub++GVSaDfu5bGmToqDLtyebjbWcgy1gQ==
X-Gm-Gg: AYBFou2vXC1BcyALwCuIys0pc1QHK3gPx3NIbi6vMkYzmxhJxbjlG9uy45XTPpOgatA
 YmQ410uKfG5+Up0dalxtJ+WozFfHZyE3WK5j4qiBupRUVosmyOsC9EdjrXklPnhvtkbZweODTVM
 ncF6JLBONGlIluwku6ztDow0vCuFg6ugOg2PhLK/+UmXCZCrUo0YMrZzQwEVka7WELjtQePkX70
 z2REYP2Ao+PjIn7a6Q//adfhp6/OajsxG+cEmwv/J4gIy6YUZJIvE0siiLGUCFDawTg8FtCpJIk
 XsJouDvEABRtD6UW9MZxBu3jSaZuGV1GMvRLga6k4eoVW6dtk62p6tbXHxG65W7goa+4NUG00em
 mvXUBqoBad3ZHWtTLq8nC+OPs70qxCOZ7JjI29blgWai7nLHSpR2YJGN3jP4C1/Y=
X-Received: by 2002:a17:90b:28c7:b0:3ac:945c:7f69 with SMTP id
 98e67ed59e1d1-3acef15c97cmr573899a91.66.1792174475470; 
 Fri, 16 Oct 2026 11:14:35 -0700 (PDT)
X-Received: by 2002:a17:90b:28c7:b0:3ac:945c:7f69 with SMTP id
 98e67ed59e1d1-3acef15c97cmr573881a91.66.1792174474983; 
 Fri, 16 Oct 2026 11:14:34 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3acc48e8646sm4895282a91.10.2026.10.16.11.14.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 11:14:34 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v3 13/23] dump: use get_dump_info sysemu op
Date: Fri, 16 Oct 2026 11:14:00 -0700
Message-ID: <20261016181410.191743-14-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261016181410.191743-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261016181410.191743-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA3MiBTYWx0ZWRfX9Ar+JErvVzjz
 q7lwTbem3YGAbzVqdRIYYU6g1WknfXKqgUSM6paRfwDNAhyYz1okgM3lKx7iZjE9zNR37mgBnmr
 htjtmMCk1CtBdXJ0LXt9hpXiP8RADYs52lvQRDpZO5OROZForbarV2OByfrND09f3qkdUy1iZ6l
 aQCKRpQofZ854EV9QFB/Ch/j9MWbHE+vD3VMwPrfv5XIQ4VbSYjXHBj+ryOvQHrM3bku+tJ74iF
 Ju49Gl3JROYN9/LdH+gDbkJgMnY+eUOfSyuwuAoGe3ICG7Si3HlbTa4f0IMeeFiB09CWyOXHMMs
 siacaM5YJScj2Kx8tv7L+pP2blshiifdpS5UvdXEDpjIOL/raVeROc3cZZ3k74uNF5BVh8SaSFk
 KgRIebLpueSo7U/yJciMmokh9u5pChM0b4j18mQhH3f3m+mcg4D1vIfY1tYnA48UVhrlGVMLnIZ
 rwchQZOP3gxQdVmd81A==
X-Proofpoint-ORIG-GUID: Tmm61DfCiMCP7sX6tzY061NHhn3DqnBz
X-Proofpoint-GUID: Tmm61DfCiMCP7sX6tzY061NHhn3DqnBz
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA3MiBTYWx0ZWRfX4SbBZZWxmoJt
 5I3SGyizJ9yKYhgFuGGtswmDyccPUEo+wc2fnjK7ooRLlVfe0xoRRRjZEZa/wEneoHrxK54PJlL
 r0GRNUo+qBPFZjgmdUqSJP/GBMYOLk0=
X-Authority-Analysis: v=2.4 cv=VpS2kO2n c=1 sm=1 tr=0 ts=6ad2698c cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=VElpqANncUZJAANGsKUA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 adultscore=0 phishscore=0 clxscore=1015
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610160072
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

Now that all targets implement this interface, we can replace the
cpu_get_dump_info() call with the new interface.

We always check if there is at least one cpu available. For instance,
machine null has no cpu present. Heterogeneous emulation is
already handled by the check above which disable dump.

Reviewed-by: Anton Johansson <anjo@rev.ng>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 dump/dump.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/dump/dump.c b/dump/dump.c
index 0ecff682dd4..e0a7dfd5878 100644
--- a/dump/dump.c
+++ b/dump/dump.c
@@ -32,6 +32,7 @@
 #include "migration/blocker.h"
 #include "migration/misc.h"
 #include "hw/core/cpu.h"
+#include "hw/core/sysemu-cpu-ops.h"
 #include "win_dump.h"
 #include "qemu/range.h"
 
@@ -1793,7 +1794,6 @@ static void dump_init(DumpState *s, int fd, bool has_format,
     VMCoreInfoState *vmci = vmcoreinfo_find();
     CPUState *cpu;
     int nr_cpus;
-    int ret;
 
     if (target_heterogeneous()) {
         error_setg(errp,
@@ -1858,12 +1858,16 @@ static void dump_init(DumpState *s, int fd, bool has_format,
         goto cleanup;
     }
 
-    /* get dump info: endian, class and architecture.
-     * If the target architecture is not supported, cpu_get_dump_info() will
-     * return -1.
+    /*
+     * get dump info: endian, class and architecture.
+     * If the cpu does not support dumping this information, get_dump_info
+     * returns -1.
      */
-    ret = cpu_get_dump_info(&s->dump_info, &s->guest_phys_blocks);
-    if (ret < 0) {
+    const SysemuCPUOps *sysemu_ops =
+        first_cpu ? CPU_GET_CLASS(first_cpu)->sysemu_ops : NULL;
+    if (!sysemu_ops || !sysemu_ops->get_dump_info ||
+        sysemu_ops->get_dump_info(first_cpu, &s->dump_info,
+                                  &s->guest_phys_blocks) < 0) {
         error_setg(errp,
                    "dumping guest memory is not supported on this target");
         goto cleanup;
-- 
2.47.3


