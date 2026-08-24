Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90E32C5DF81
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 15:58:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyX4L-00058a-Tf; Mon, 24 Aug 2026 11:58:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wyX4F-00055p-79
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 11:58:35 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wyX4B-0001jF-S5
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 11:58:34 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67OFn1gw2261384
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 15:58:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=7E1UnthV/su
 2TSgv9f4eQlHMCEu4/TPOkROxWe+ZpM0=; b=l9A23p2zS+2haGzmR1XKqUGqKS3
 Z3PU4fw9aKxoKRinoljwfFC3j17XMVowsm0IBSnEeMbr1twf9luC0Y51lZUypYiR
 ui9yGtGakrMKmozCFCPHVhBeuVJQOZrFiAaIlLstV0HLDflENR9E7MWnte7SRzG6
 NbbuwU0QqZgK/SEfeB9yHTsnTvHOEpzcGa0w63FfmIxkaCVWQPm7dMdVmK1WkBbS
 fudIsMq4ri3KZFHetJ7LlZU8gkZRHJr9pUST29U2GyR2s+iqIgSCwFff1j4/A6P7
 7H+s2rQh39xEDXf/26QUuo7/DTVp0qbbvE83Qw4k/3HKU8mo+An376vGT8A==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8huf22jh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 15:58:28 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-388b404eaa4so5723081a91.0
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 08:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787587107; x=1788191907; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7E1UnthV/su2TSgv9f4eQlHMCEu4/TPOkROxWe+ZpM0=;
 b=X8JLJVecGCap5wZwdM5kaU29LE2TgSvV5OUXmy6qzBzLTOEtLiLW8+ixBNpwXbjf09
 +DfOGt2vbwlD28fMN44oka3CF7/LBbI/9vVImi0y6eBso1udPhUrCKC0b8fE584/T9vj
 yLH8ueWtBW4/SmPRioIOAOOV/QU5kUqyOflvqu4pAi0BgxGu+UIa9dzfQGEa8p/szf/W
 uN1zbvSkPt9ZCF+PK2eFr5Rf/pDAL9fFwGXFu2dl8ymQPYNM5MXKJL2ctDvxVb/q68mn
 HaSWTCRcHcYexxZzvVQz0pA8HckT08FTijjzmEzMpxIoJAMoL1B80Qg/IVa3jWk0Pdc0
 iBZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787587107; x=1788191907;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=7E1UnthV/su2TSgv9f4eQlHMCEu4/TPOkROxWe+ZpM0=;
 b=I+qcnzUMYkha70tKQRu8BpFmBGKBRBDrpRTVo7YmcLWFAtHIb5BhvJ3v2e0OjRGKLC
 vin0MuvzSsChayUG5undMF09fv1l6jtCHB7hvRv26Yx1YlrB5QXTaqygcw8VEj+sKP1+
 ijZE+eseNoHV8s524tF0Q2zmP9DBxFwQA+2MRK5VwAbb9w3Tl2aPNE1o6mIaGP5yG0HM
 IU/27k0iSzPDCd1XKz3yfeF3QDFtZmSeYJj/OGFKOiKtwVQpSB4Vzgz/7II/Xww7k9jr
 7WYFTy5VG2P3qfYou+fTBIGPOv9wXWAJEoFg/LPEXicbAZmGvssAV1FVj6o6rmcZBVLY
 ON7A==
X-Gm-Message-State: AFuF++mviLpllZlCia7kz99/cGg1CqYKntWT+HvW1KcSZaP5bUW9e8FS
 Cfy7IoKsE3kXhPXIGYFyIu/RkUWcqv/Efp2BWFtdaBHih1Hdy3i4/fmIk/OkJXDLyBYYymKyyxE
 /QD79hDq7UMJ+PelZ1+7Btlsm4YyULvrLQsWM8RKIhLGC4ajLwtJk7Fuvrkpe4bzqknHT
X-Gm-Gg: AR+sD12OdiCiJ/bcOScGf+fC0T1aSWXq/op3iR1P3acADzgmCtBe/oPuSbEDRar64cH
 QhMmDF/1sAZG4qSUzBMBqLeDQayxDOhI76KKROb5bwLgxgC+ApJ26hJnsA2OTd7QnBKxL32R+Fo
 zu4QwRO6+iHGDjUYDK99Bw5vTVNeMqvzw/yA3dA323g5206GSSWlT7Zq3M9Mwmq4NtE/VGFH5r3
 vuqDV0gve/EAupSAgVFpelGnZcAo8bV/ehuqyNOtn4VOETa+fSaMiHUinu/7sp793TqTJZqQWFe
 yS06b21s3sEOb9tFrz/VO7FENTvQQz/H9YeJwOpcSICW7ZUzowqlCZCS8gUrk/TavmlshOol2/L
 w9riZQlfLvyfAuHXJi4+hPhlNRIABXGP7K4xcseVOnMyq0IQxkF4eq/N1V63ey+8=
X-Received: by 2002:a17:90b:580d:b0:38f:5869:387b with SMTP id
 98e67ed59e1d1-395df24e757mr38169915a91.9.1787587107261; 
 Mon, 24 Aug 2026 08:58:27 -0700 (PDT)
X-Received: by 2002:a17:90b:580d:b0:38f:5869:387b with SMTP id
 98e67ed59e1d1-395df24e757mr38169831a91.9.1787587106821; 
 Mon, 24 Aug 2026 08:58:26 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14186183c0esm41152935c88.12.2026.08.24.08.58.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 08:58:26 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, anjo@rev.ng, brian.cain@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, philmd@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com
Subject: [PATCH v4 01/14] disas/hexagon: honour target byte order when
 printing instructions
Date: Mon, 24 Aug 2026 08:58:10 -0700
Message-Id: <16f730778fcbb7c287416aa246367c1d0244b267.1787586642.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1787586642.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1787586642.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDEzNCBTYWx0ZWRfXw7soMc0arIQO
 tN/n3vZmrqYrtGZdD/w/2t5WamDgsBfAl0jpXi5NLoMOGdv+cYche9A4EjgS9h5JWphPU+C943a
 b6cA8WZtRE6d8/aWwl4JwldwqF26ay0=
X-Authority-Analysis: v=2.4 cv=Wac8rUhX c=1 sm=1 tr=0 ts=6a8c6a24 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=Y0R2AH0urpkzOH2ra7cA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: LmUhrh2mZAEEDykwG6YlDhjNptm-ynqa
X-Proofpoint-GUID: LmUhrh2mZAEEDykwG6YlDhjNptm-ynqa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDEzNCBTYWx0ZWRfXzkRmdjJy7W/R
 pK6ezgsoxq5klMaA4iw7W5aEu38vkw1VgteMQCge336mcuidT8JyLD1T+l8HwPXR0jYejrYZk5/
 ote6IdJ29LtRUUeLW6tKQCknW254u6v+ovawHOHmQcjE9BzHaXkiBiXNhMoEEz6k4KfO7vlEysy
 KKg3S4reqo0IB1GQzfUPDjHMz97lG9Cfl1ql/m88lIVNHUMzg0dTS8C1+npfmoRQ0nLvAxmK3Ax
 cip++FxiexGO1FIFh/TmaMoi+YW2ohZoEP/lTcnCWL2JKzh82366FK52pcXdX39fOnknDNeu+Jf
 30r3foscAHifALkedImPI9qjIvAJvUJHGD+gCY8C9vEqPo46d/LYPMxtL/O57puVTS0FP2R33ib
 lcScnkdhXJFTewRDrv3Jp611CbKfhS5y59wdK71jR3f3ve3WRa6UsZl5pEd8mYC1tmEaKPsyoYe
 oAA06+TthtoCYCIV64w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_05,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0 spamscore=0
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

print_insn_hexagon() read each instruction word as a host-order integer,
thus getting them inverted on a big-endian host. Instead, read into a
byte buffer and convert with ldl_le_p().

Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
---
 disas/hexagon.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/disas/hexagon.c b/disas/hexagon.c
index e2d3804606..62e0cba661 100644
--- a/disas/hexagon.c
+++ b/disas/hexagon.c
@@ -20,6 +20,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/bswap.h"
 #include "disas/dis-asm.h"
 #include "target/hexagon/cpu_bits.h"
 
@@ -37,9 +38,9 @@ int print_insn_hexagon(bfd_vma memaddr, struct disassemble_info *info)
     int i, len;
 
     for (i = 0; i < PACKET_WORDS_MAX && !found_end; i++) {
+        bfd_byte insn[sizeof(uint32_t)];
         int status = (*info->read_memory_func)(memaddr + i * sizeof(uint32_t),
-                                               (bfd_byte *)&words[i],
-                                               sizeof(uint32_t), info);
+                                               insn, sizeof(uint32_t), info);
         if (status) {
             if (i > 0) {
                 break;
@@ -47,6 +48,7 @@ int print_insn_hexagon(bfd_vma memaddr, struct disassemble_info *info)
             (*info->memory_error_func)(status, memaddr, info);
             return status;
         }
+        words[i] = ldl_le_p(insn);
         if (is_packet_end(words[i])) {
             found_end = true;
         }
-- 
2.37.2


