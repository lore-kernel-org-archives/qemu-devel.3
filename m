Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8503CA5FE2
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 14:26:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCeCt-0001H8-7m; Fri, 02 Oct 2026 10:25:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1xCeCj-0001CZ-3m
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 10:25:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1xCeCg-0001nE-TD
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 10:25:40 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 692DZTIM633763; Fri, 2 Oct 2026 14:25:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=1Zu1y3
 yKbCvTd2/B224uu1gg8Wk2aY3rdA49zALZhvY=; b=EJKAWkowC0SI03/ultFAuA
 V4+JEcOBbeDPMkYgDUSOgY/c42GUEJtaZX2Gw8PFCjZDEMR42ORLzOfeeYY3i2GA
 3MGQ2tfqinceuh2JzUf7XbjB1OfhGddU6OyjGoaTmtlHQDblFfMkiNcZfxpbTYi1
 FP+YcG9uEb0LM4FGm4EVq1IXyO6+DxTne8wHVOJYR4+JLTgL71B4H34BRwNuH+il
 g/3xJqMxcdyoDjxYYvOPjDPFTLYxeU8XahsPYVwxMUeyRmhxJckI5zwtfwSG3Xkc
 Ru4YRAn7Ekv80Tz+/Wa8F9EWPlGK1bRcMawCxpFhNEAAejKMLRrsLHpyrvXfuM8g
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5ptr88h-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 02 Oct 2026 14:25:30 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 692DHVoT2540243; Fri, 2 Oct 2026 14:25:29 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h1y2dk22j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 02 Oct 2026 14:25:29 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 692EPTG264291082
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 2 Oct 2026 14:25:29 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 88A5458054;
 Fri,  2 Oct 2026 14:25:29 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F05B75805C;
 Fri,  2 Oct 2026 14:25:28 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  2 Oct 2026 14:25:28 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: armenon@redhat.com, marcandre.lureau@gmail.com,
 Stefan Berger <stefanb@linux.ibm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v3 05/10] hw/tpm: tis: Use uint32_t for len to avoid
 truncating size of command
Date: Fri,  2 Oct 2026 10:25:11 -0400
Message-ID: <20261002142516.2063735-6-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261002142516.2063735-1-stefanb@linux.ibm.com>
References: <20261002142516.2063735-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: ETrEaUlEUNGqdcwFx5EvKfqNwA1fhuML
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA1NiBTYWx0ZWRfX2djwlg9V1kUN
 FYKbAeKspqbyDZOv2su4wnJpMm2M5Dy5yNNBN630YTzSMtf1hcqFc7wa3R/a0P4wYDYVfmJzmBz
 1yrBT011a8JfDPclkCWcRQkITffXg8ARhzi1+q6xeQlpj/SN7A0bXqGxfJPAT12ahTXfKYqH2Gf
 IUpO+SarB1BUdGeoQ4Q+usENB2vLdNZ2az5A6Vd5VB4a3bTEEFoteBLrPp0qEz3+FljZ8SfKtOM
 az7Q5xmoWacpNF6RiUbGLVOObTLDdhXPIe4y9OaJInDISx/lEAL9pvc5CHPzaCiM/3RtVcPAgNA
 PCDmQkshibEVvKYileiqGzc9FHGMSpwGezuwIjVcyqgXQYKDxRZrYdgt6lgX+GDavKr3b75mN8d
 BoTeyS0mBtus+1x3gB3H4ovczN6bMGZ0xIh1r2acIIp6hIwUNdBrC7LsmHM9ng+cZhkzGB642Ef
 amUSt2EF8x0Xd6YLqKQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDA1NiBTYWx0ZWRfXyQZdqZ7eXwBT
 ZMHPfaOTNGxSBKUanfj/8Z3DWIf1bWgAzaz+oT6TWL2UmGeGulmB2VadiBgkn2SqbgehJPbcckc
 sH/f1+gW31DXPOpb3N9kz8d0iKG3T/c=
X-Authority-Analysis: v=2.4 cv=EY5d0/mC c=1 sm=1 tr=0 ts=6abfbeda cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RY3EVia8NYhRY2h5:21 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22
 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=k5BCUbyaT9HKcZ68nHAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-GUID: u2OE2ctOGS3uWMIxpfQAwDreJZxNH0pU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_04,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 adultscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610020056
Received-SPF: pass client-ip=148.163.158.5; envelope-from=stefanb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

To avoid truncating the uint32_t return value from tpm_cmd_get_size()
declare len as uint32_t rather than uint16_t.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 hw/tpm/tpm_tis_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/tpm/tpm_tis_common.c b/hw/tpm/tpm_tis_common.c
index 4ba228116b..8fa1bee771 100644
--- a/hw/tpm/tpm_tis_common.c
+++ b/hw/tpm/tpm_tis_common.c
@@ -481,7 +481,7 @@ static void tpm_tis_mmio_write(void *opaque, hwaddr addr,
     uint8_t locty = tpm_tis_locality_from_addr(addr);
     uint8_t active_locty, l;
     int c, set_new_locty = 1;
-    uint16_t len;
+    uint32_t len;
     uint32_t mask = (size == 1) ? 0xff : ((size == 2) ? 0xffff : ~0);
 
     trace_tpm_tis_mmio_write(size, addr, val);
-- 
2.55.0


