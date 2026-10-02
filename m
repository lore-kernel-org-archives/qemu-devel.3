Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A54C7CA5FD4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 14:26:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCeCt-0001IP-Su; Fri, 02 Oct 2026 10:25:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1xCeCh-0001CT-H7
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 10:25:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1xCeCY-0001mu-IZ
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 10:25:32 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 692DZVsS633776; Fri, 2 Oct 2026 14:25:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=IAH3CO
 OHbUwd/msYhDNKJmyyzPJ13MIZ3bHbPT6lAfY=; b=M+kM8grPB4oZjtdCyONYiw
 IZE2aMeuOL9pS6Vhq//I4Eh8dYpl3B7DDnrFm+nh233Lid6QBzQnBYQIDEO9seLO
 cnBgYPDMFL5VyYdRQABySQy8U+SO/cnw5MC7g3FKlStjrQ0L/ZTFhTjKpTlJjfrO
 jGBvqKqXVAjV9SsfZFFz8FpQXKSzZxdAesxbzgHr/cL5fU1bQHn7nhRINQ97MZt/
 aWalnswmwkcYZIFfO5YobfwNW4r1D9BMc1mi1jZ0puLQR05MyDEGIlS7BvmPt2Cy
 CFPX5IivNVhUkcMAIuWRYAbQZYTE7KRWgCNHP6LUCgPA5uurMRGiseNFhs5PZXIw
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5ptr88a-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 02 Oct 2026 14:25:28 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 692DHWTS2540248; Fri, 2 Oct 2026 14:25:27 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h1y2dk22g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 02 Oct 2026 14:25:27 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 692EPRRv21103134
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 2 Oct 2026 14:25:27 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6032858054;
 Fri,  2 Oct 2026 14:25:27 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C81375805A;
 Fri,  2 Oct 2026 14:25:26 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  2 Oct 2026 14:25:26 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: armenon@redhat.com, marcandre.lureau@gmail.com,
 Stefan Berger <stefanb@linux.ibm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v3 02/10] tpm_emulator: Reject TPM responses whose size is too
 small
Date: Fri,  2 Oct 2026 10:25:08 -0400
Message-ID: <20261002142516.2063735-3-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261002142516.2063735-1-stefanb@linux.ibm.com>
References: <20261002142516.2063735-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: j4L7tDteqKsLjmWeeZqdXE5iqz942pup
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA1NiBTYWx0ZWRfX3MV0215qqZMl
 LRLGWlaSTezq/c5LxRDGoV8uHyRxnUQWex/5iZiLe3ZiDZnN0AgFXpoOQsupXr2dYOlfduCtxTx
 C6rrgf9PhX4fT2/vWj8gQKR/Jx6Ul9l1sOb5f5Zn1dpjU4npdVnUin6bi6sMRWqeirf0/8zfO2h
 JX0B6ProlgivaB1QF88VfMCjybg4O5dokC2xYNMamMo5+d1wNHwYKrbQRFPDuSmVcpDj8a3lpy1
 EF7hCL9A/4XS5jaKffRpD8ue+bZSyKe6aBgIrMbyU6wN5WJj70seLJvA9eRZW3lZb3XvDIlvO0i
 HVyPRhkYHzl3h+WrTs5lIcxly3xmxwhco222JSdU6N/q/1hopDmHbKVKyMBTd+m7eddgu32XUoL
 PHGzDVWoP45aPDkVT25j4Oz/AxzdGSqNPgSqVpZ1Qu1IL9xea1EpqD0KI65PzYjyCWzpQ0Ttojo
 qFYqGPzKsLtZK+mtOmw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDA1NiBTYWx0ZWRfX0Y37e4MDXg2i
 9nFciaJBni3qcw7jx388u3Mge/JrNOU251u0Lf4bGNevbwrKa5+atVa0caWe5LHrLrGfDLt1DHs
 R50j7bCOMfvHtwh2dTbD90P1KZZHPY4=
X-Authority-Analysis: v=2.4 cv=EY5d0/mC c=1 sm=1 tr=0 ts=6abfbed8 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=20KFwNOVAAAA:8
 a=VnNF1IyMAAAA:8 a=luQVlvl-W8lCxKXVFxcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: dT8jJM8wrhDZcQbO_40_iEpTJVzkdaMf
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

Reject a response from the TPM emulator whose size field indicates that the
response is smaller than the size of the header.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 backends/tpm/tpm_emulator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/backends/tpm/tpm_emulator.c b/backends/tpm/tpm_emulator.c
index 16ae44c8d7..9c95b4d878 100644
--- a/backends/tpm/tpm_emulator.c
+++ b/backends/tpm/tpm_emulator.c
@@ -202,13 +202,13 @@ static int tpm_emulator_unix_tx_bufs(TPMEmulator *tpm_emu,
      * size)
      */
     to_read = tpm_cmd_get_size(out);
-    if (to_read > out_len) {
+    if (to_read > out_len || to_read < sizeof(struct tpm_resp_hdr)) {
         if (qio_channel_shutdown(tpm_emu->data_ioc, QIO_CHANNEL_SHUTDOWN_BOTH,
                                  &local_err) < 0) {
             error_report_err(local_err);
         }
         error_setg(errp, "tpm-emulator: Disconnected after receiving "
-                   "unacceptable large response (%u > %u)",
+                   "unacceptable response size (%u max: %u)",
                    to_read, out_len);
         return -1;
     }
-- 
2.55.0


