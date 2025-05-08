Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31DFFC3ABBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 22:53:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDA5w-0004gT-7z; Thu, 08 May 2025 18:52:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uDA5j-0004II-8m; Thu, 08 May 2025 18:51:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uDA5g-0006Vr-Hw; Thu, 08 May 2025 18:51:45 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 548IkZ4n025963;
 Thu, 8 May 2025 22:51:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=90g9DFNKT+dYssY4f
 HWb4xFMe5c7/mmXx+n7/8U/B/Q=; b=lII6mGMhdIooUniIJQReuT41254EI4Ieu
 SbJA/iAIFhbnnQg5tj4I3nG2a7PQRKGk/BtnfwglPSI2j1FcGl4YuHqBstvEBVtm
 0vXmFDLUbV/9TSWbQltA0/Sa2qggwD74M2ZaHduSRsSaYeg/fZyPsKvwA5dfcV14
 7kw9knysgAnLSXlk2Sc2aq6JWq97PnjxaOwHmhbGD3UUAos69DSKGdjMQpLsvO4D
 UXWM5OHu2EdRQRiV6lwtkQ744eCQ/tLAVUkSzbX/INDvWxYzoyBC1jObQFmu3XK3
 c/K6BoFf0G/DFAnhvclmAEEs9xMTfLx7vckEUzSLCf6uoydlUPPkg==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46gthkbhb0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 08 May 2025 22:51:41 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 548LCJcP002728;
 Thu, 8 May 2025 22:51:40 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46dxfp837w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 08 May 2025 22:51:40 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 548Mpd4D13632148
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 8 May 2025 22:51:39 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F299A5805B;
 Thu,  8 May 2025 22:51:38 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 779AE5804B;
 Thu,  8 May 2025 22:51:37 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.11.238])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  8 May 2025 22:51:37 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 pbonzini@redhat.com
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, jrossi@linux.ibm.com,
 fiuczy@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, iii@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, zycai@linux.ibm.com
Subject: [PATCH v2 13/25] hw/s390x/ipl: Set iplb->len to maximum length of IPL
 Parameter Block
Date: Thu,  8 May 2025 18:50:29 -0400
Message-ID: <20250508225042.313672-14-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250508225042.313672-1-zycai@linux.ibm.com>
References: <20250508225042.313672-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA4MDIwNSBTYWx0ZWRfX0BDiPJPt0+Qj
 L5cD4CoUhPtrunLhZJErDAMtqiXJLf7gq/qKg4o1Fi2V59Q6jdjuPfVVkn60OTl7UBictOy1txF
 qgLt8kAz2UBxHgDNMx2XJlUKbF5VrHJ2BkOXdeRp+4mxXDyM4PIiP8BQynTk1nJSZSTQRY3erjx
 DQoGnRgq+Ax8MDSOGPjOSQWA8FuVpzTZ2TEDZBQ3Sgoc8mpZLe0QbL5FWPpdmMtABtF4nFA6j0d
 dS6leor5xJOYIEwCZF66dSqYbwoYFDnKA7q25R0vcH8dZBM4aHRr4uB3aFejtB1QWQeHcDQrJ+H
 kda/PJ8zlqy9gHcFRNLpd7UcLsupArOsudSLuSqfEXwckFVWGuVdcKc1H/TkfiKNB/j8m6HWgEN
 nzAUvBUaaiaAP3J1bki1dTyE8iH7OXsR3zhm45hIGDGIlfljvSM0mp1ryVpnMTke4p16MQQW
X-Proofpoint-ORIG-GUID: 2j5MQm2-q5N59tIh46lBsijcaxF7kiDZ
X-Authority-Analysis: v=2.4 cv=PvCTbxM3 c=1 sm=1 tr=0 ts=681d357d cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=MJvGgyB-O-neVO77w_cA:9
X-Proofpoint-GUID: 2j5MQm2-q5N59tIh46lBsijcaxF7kiDZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-08_07,2025-05-08_04,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 phishscore=0 spamscore=0 clxscore=1015 mlxlogscore=819 bulkscore=0
 impostorscore=0 suspectscore=0 mlxscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505080205
Received-SPF: pass client-ip=148.163.156.1; envelope-from=zycai@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The IPL Information Report Block (IIRB) immediately follows the IPL
Parameter Block (IPLB).

The IPLB struct is allocated 4KB in memory, and iplb->len indicates
the amount of memory currently used by the IPLB.

To ensure proper alignment of the IIRB and prevent overlap, set
iplb->len to the maximum length of the IPLB, allowing alignment
constraints to be determined based on its size.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
---
 hw/s390x/ipl.c | 6 +++---
 hw/s390x/ipl.h | 1 +
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index 8ac0cee73d..d1a972ac8d 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -459,7 +459,7 @@ static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
             if (scsi_lp && strlen(scsi_lp) > 0) {
                 lp = scsi_lp;
             }
-            iplb->len = cpu_to_be32(S390_IPLB_MIN_QEMU_SCSI_LEN);
+            iplb->len = cpu_to_be32(S390_IPLB_MAX_LEN);
             iplb->blk0_len =
                 cpu_to_be32(S390_IPLB_MIN_QEMU_SCSI_LEN - S390_IPLB_HEADER_LEN);
             iplb->pbt = S390_IPL_TYPE_QEMU_SCSI;
@@ -470,14 +470,14 @@ static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
             iplb->scsi.ssid = ccw_dev->sch->ssid & 3;
             break;
         case CCW_DEVTYPE_VFIO:
-            iplb->len = cpu_to_be32(S390_IPLB_MIN_CCW_LEN);
+            iplb->len = cpu_to_be32(S390_IPLB_MAX_LEN);
             iplb->pbt = S390_IPL_TYPE_CCW;
             iplb->ccw.devno = cpu_to_be16(ccw_dev->sch->devno);
             iplb->ccw.ssid = ccw_dev->sch->ssid & 3;
             break;
         case CCW_DEVTYPE_VIRTIO_NET:
         case CCW_DEVTYPE_VIRTIO:
-            iplb->len = cpu_to_be32(S390_IPLB_MIN_CCW_LEN);
+            iplb->len = cpu_to_be32(S390_IPLB_MAX_LEN);
             iplb->blk0_len =
                 cpu_to_be32(S390_IPLB_MIN_CCW_LEN - S390_IPLB_HEADER_LEN);
             iplb->pbt = S390_IPL_TYPE_CCW;
diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
index 3e7190c7d8..ed29881dfa 100644
--- a/hw/s390x/ipl.h
+++ b/hw/s390x/ipl.h
@@ -101,6 +101,7 @@ QEMU_BUILD_BUG_MSG(offsetof(S390IPLState, iplb) & 3, "alignment of iplb wrong");
 #define S390_IPLB_MIN_CCW_LEN 200
 #define S390_IPLB_MIN_FCP_LEN 384
 #define S390_IPLB_MIN_QEMU_SCSI_LEN 200
+#define S390_IPLB_MAX_LEN 4096
 
 static inline bool diag_parm_addr_valid(uint64_t addr, size_t size, bool write)
 {
-- 
2.49.0


