Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2BE3C98315
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 14:41:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9kdI-0003fK-3a; Thu, 24 Sep 2026 10:41:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1x9kcq-0003SH-DI
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 10:40:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1x9kco-0004Y7-3a
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 10:40:40 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OC6XHw2183891; Thu, 24 Sep 2026 14:40:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=1Zu1y3
 yKbCvTd2/B224uu1gg8Wk2aY3rdA49zALZhvY=; b=JeS6VBfE4YhIVO80VRni1n
 hl8ZyL4h521aPSiB4RceVml0w8nVGyLmVu908aNl+j0sslNJYAnWGCRoOA3UHcKt
 WU3IATGaMfznrSTJxr0GlG9i09TVgFWzoS5NxMvcmUL7yCjktYHdkpfslCBV2muF
 eWmGToJHbF8usi30WNJwf6R/YKvqG4Prtt8gl5NINbRv65qW+lf+7JjcgKMXWY8Y
 fjEBWpLlzki3hWR00WiCbgO8/Fh5Fwy9Kc5WTNwwDb/jNoMCmjTOm/5j0fdc4ioW
 kVbjvig0bFV8APjlfCPzeXZE6cD1Clx1hIslERKkgoPIetSJxfuNuUyoPB/kmojw
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgshp25-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 14:40:36 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OENhbq2188226; Thu, 24 Sep 2026 14:40:35 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbu8x5hq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 14:40:35 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68OEeZl522872658
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Sep 2026 14:40:35 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E973658059;
 Thu, 24 Sep 2026 14:40:34 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 57DD158058;
 Thu, 24 Sep 2026 14:40:34 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 24 Sep 2026 14:40:34 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: armenon@redhat.com, marcandre.lureau@gmail.com,
 Stefan Berger <stefanb@linux.ibm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v2 05/10] hw/tpm: tis: Use uint32_t for len to avoid
 truncating size of command
Date: Thu, 24 Sep 2026 10:40:21 -0400
Message-ID: <20260924144026.953360-6-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924144026.953360-1-stefanb@linux.ibm.com>
References: <20260924144026.953360-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=V/XoQuni c=1 sm=1 tr=0 ts=6ab53664 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RY3EVia8NYhRY2h5:21 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22
 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=k5BCUbyaT9HKcZ68nHAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-ORIG-GUID: K-EAplxyRQ4XRt_8tR74i9M3tz8EzbrT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA2MCBTYWx0ZWRfX5uiR1KHdiTOF
 zoDTh6CStPNyojHmPoL+/MK6PfsQNruX1jVwNGxlw32HKaJf4SLo0poGf0gvPgpOrKWwrEAImtC
 ratdXeRaz1WGhoi0GSgyXUod5hDPmCGk+VKc+zGkrClpgosZi6CZ8LNWC1G3X2Qllyk+SvJNYXg
 w9ezeA2/uPauWTJffA12Bp+P9BO2fDlQdxKtNyicNR8RmeOTORM9i62FPOFAUQ5LHRATM4tJrR6
 R+dOVRxmUV4T+JoMtozwu2MHDK+p+jswEX8iROVaoo3KUWG4MfzM+OWldhpdb0QwUf6E8W8u2Fw
 nGokuSD5U4H+D2i/SqMrG+ukQGDHI5uggAaPSS/Rq4oiQu6xj/F/ELw7Z+McuXXcSnIoZqW7byl
 oKk7eKlB11z5b/+De06doDkgzi4Jd2BCQh7F7t+zBCIDoOJ25wO1LToQAPDYxSPTBRvIUQinjEs
 IFzDSxSWItw6jzj2CnQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA2MCBTYWx0ZWRfX8bgDWnlMBd/a
 Pj9RxCODK3F2sHtJirkm3EGo9EZOonGzAzpivz5/Ky529OZ0BiAOM0QxILOqUMlQbB469kUaAHy
 Eh599omndAinn1MDJ9sg0lRdGyD9Kzw=
X-Proofpoint-GUID: PQsVWzlWVWOD4FEQrYrPL8ZyUynSKPjB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 malwarescore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240060
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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


