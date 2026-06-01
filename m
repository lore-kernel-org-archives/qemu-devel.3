Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18B4CCD5BD1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 21:55:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUAak-0006cI-9j; Mon, 01 Jun 2026 17:54:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wUAah-0006as-Mp
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 17:54:35 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wUAag-0003rH-0w
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 17:54:35 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 651FfpOV1648854; Mon, 1 Jun 2026 21:54:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Y1iE8V
 4VOnXJTVnc5bGufKVvHR4Uy6Kg/1WQvhlMlrU=; b=PNGBQ7xXjIHUSI1ebQqfiP
 W/LzuXqWYGI9ZWSnAy976QSB+oVAfhD1um25pwmMhpPMflsfy3Vw1FrxDezPVBq/
 k9u8MuVTvI6KR/bc+eehKxX2y8+lKy5sDZ5QSmKsi+aZQFWtH7XHqtRAaQPjNNqL
 i1NL9CbGwb7w0LLG6u+jS+3pLarRbqnIUUwj6TWhgrVzn5mWqv8mUUYTxiUrxjmk
 pxpguHk0FXOiv7OxQcFHfBpLj62K1PCkMWYxAVEmejs18+mrkixWk6VlPgFzVI0e
 vU3e8WSt+PSWgTx+/tJkIFVuVziGW6OCNd4Smyht4WFWXm4Ot70RRXmfXe32HkSw
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqd434he-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 01 Jun 2026 21:54:31 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 651Ls8vF002482;
 Mon, 1 Jun 2026 21:54:30 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egbqh869r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 01 Jun 2026 21:54:30 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 651LsUrO9962150
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 1 Jun 2026 21:54:30 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 394FE5805A;
 Mon,  1 Jun 2026 21:54:30 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 912FF58054;
 Mon,  1 Jun 2026 21:54:29 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  1 Jun 2026 21:54:29 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Arun Menon <armenon@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PULL v1 08/16] ui/vdagent: Use VMSTATE_GBYTEARRAY to safely migrate
 outbuf
Date: Mon,  1 Jun 2026 17:54:01 -0400
Message-ID: <20260601215410.517009-9-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260601215410.517009-1-stefanb@linux.ibm.com>
References: <20260601215410.517009-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDIxMSBTYWx0ZWRfX0SnBHVIdvDHp
 f7eAbny0YrzfNsufEjF5rrAaUIn72QW464D8whblYrECRLqNm2PZGwQR+xDIXwRFdLDeEdiS3wU
 VQsknH2b6BO2f682USZ39ta9kFBYj6WoEbA4SoYBxX+1Bz6k2lJdSaxywFxnc0QWytM1W19BMoc
 y+K1wj8EgrZ0IGZz84tEdejbSkcnxV1ah1yBObyLnYwIAcCIdJTO6fEaVDxMiOisj43e3DONpEH
 VP+lObIA2ZCaVG/OBLrP4n3vQB1bzCiVFUCVTa4/GyrV2vfRYTDLnPsyaav9tO6SXNv56Iw75D5
 3cFJs8cl9OT1iHa4ruM/FpRezIMEK2BTQG84VOfNqaQgXzOnaAboqjHuUW1IpEBZy0ir209nUhg
 47lFM+KerQB7XIpPAaPTD4MYK64bbDRg9qKWXz5VFZMcq+3XJp7LB8pnxE0va+2IZhVgXZcboGo
 LNeUD3y0kMGV5JwVdOw==
X-Proofpoint-GUID: cf4I66GbT05Bcj1L5KVJYVTYMJMKuIiw
X-Proofpoint-ORIG-GUID: cf4I66GbT05Bcj1L5KVJYVTYMJMKuIiw
X-Authority-Analysis: v=2.4 cv=DZknbPtW c=1 sm=1 tr=0 ts=6a1dff97 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=LLg8hcPoKadeHjzegnYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 suspectscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010211
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

From: Arun Menon <armenon@redhat.com>

Migrating a GLib GByteArray is now possible directly using the newly
introduced VMSTATE_GBYTEARRAY. It uses the standard GLib API calls to
create the array, or resize it.

This is safer than implementing a C struct and manually updating the
data and len fields. This commit uses the VMSTATE_GBYTEARRAY in vdagent
to store the outbuf variable.

Signed-off-by: Arun Menon <armenon@redhat.com>
Suggested-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260423105733.113046-3-armenon@redhat.com
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 ui/vdagent.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/ui/vdagent.c b/ui/vdagent.c
index 8fa325bffa..b9784d4d9b 100644
--- a/ui/vdagent.c
+++ b/ui/vdagent.c
@@ -964,17 +964,6 @@ static const VMStateDescription vmstate_chunk = {
     }
 };
 
-static const VMStateDescription vmstate_vdba = {
-    .name = "vdagent/bytearray",
-    .version_id = 0,
-    .minimum_version_id = 0,
-    .fields = (const VMStateField[]) {
-        VMSTATE_UINT32(len, GByteArray),
-        VMSTATE_VBUFFER_ALLOC_UINT32(data, GByteArray, 0, 0, len),
-        VMSTATE_END_OF_LIST()
-    }
-};
-
 struct CBInfoArray {
     uint32_t n;
     QemuClipboardInfo cbinfo[QEMU_CLIPBOARD_SELECTION__COUNT];
@@ -1064,7 +1053,7 @@ static const VMStateDescription vmstate_vdagent = {
         VMSTATE_UINT32(xsize, VDAgentChardev),
         VMSTATE_UINT32(xoff, VDAgentChardev),
         VMSTATE_VBUFFER_ALLOC_UINT32(xbuf, VDAgentChardev, 0, 0, xsize),
-        VMSTATE_STRUCT_POINTER(outbuf, VDAgentChardev, vmstate_vdba, GByteArray),
+        VMSTATE_GBYTEARRAY(outbuf, VDAgentChardev, 0),
         VMSTATE_UINT32(mouse_x, VDAgentChardev),
         VMSTATE_UINT32(mouse_y, VDAgentChardev),
         VMSTATE_UINT32(mouse_btn, VDAgentChardev),
-- 
2.54.0


