Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0F2CCA6016
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 21:30:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEvfh-0000QA-IZ; Thu, 08 Oct 2026 17:29:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1xEveT-0000MW-OQ
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 17:27:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1xEveQ-0002oy-VY
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 17:27:45 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 698L6E2i2502347; Thu, 8 Oct 2026 21:27:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=CLVaUn
 RAOS8pZn74ZhIFTxpgOVjBFXp9m/vcXac7ObM=; b=GWl4m4W4988wXnPZF7/dde
 INQRqOfirIBsqS+I0AAF1Zhlu1n0+t/6tc33R4HnDACij8h0SmTcundkWBDT9F4j
 zyyptRbLMSwiYuH6cI9GZtxyo9Q1Z92QfvJh/7GnF0bHxHl8fS7YpoU6BXL5eTqf
 IfZQfaFW8cOArzVRWCTHboRILjFIZ2A5w4qHjbhBFbW0Vq1zC+V8+YuV3GVMAiXU
 eX5Vf6eRNxBHXZi8LzWhEDn/QjFosmrB2FI0mjqYfZ2dpv/Z4rFn4VVTXMtszYC8
 vF5ZsSvrzZVEO7Hk3JeE5fHgGxhylY3F5IimjKcpgKKyn9Skl6YIDWhpQ0N39XBw
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h5xjvxq0d-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 08 Oct 2026 21:27:28 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 698L2cdH4019512; Thu, 8 Oct 2026 21:27:27 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h58d5sgua-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 08 Oct 2026 21:27:27 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 698LRQJe64553278
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 8 Oct 2026 21:27:27 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D4F3658054;
 Thu,  8 Oct 2026 21:27:26 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5384A5805A;
 Thu,  8 Oct 2026 21:27:26 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  8 Oct 2026 21:27:26 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Stefan Berger <stefanb@linux.ibm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL v1 02/10] tpm_emulator: Reject TPM responses whose size is too
 small
Date: Thu,  8 Oct 2026 17:27:15 -0400
Message-ID: <20261008212723.3679685-3-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261008212723.3679685-1-stefanb@linux.ibm.com>
References: <20261008212723.3679685-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: yipBoTaRXUiuBoBvdCj54GEDoCtVpHzO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA4NCBTYWx0ZWRfX5k4SSGZfNoPC
 yzdQtbgvMmrJAZ8aIdeCaUejCYDNDHvGBc4MCySVhmQnurYDo5O1YXpvbgo65ezJteyEYEg39vZ
 swFzUU7yx7ebB4EHB70lihf+X3GOuaT6GeA0RYL+i30NWx8bbgEfWuslf/bz0qEWCY303bugcT+
 okbt9qUW7sQ6ftO4xRwviUbDPobGXnNicKUOMyONJpFYgJx6EwkC7YwvG/DaJK+HVVZ0MiSl06o
 2Tp7G3Z4GnVb0pQalOB5nNA2kRdbvKIDqcNseh0Nqwkz11t81u8Z6rJkMo8sVicnyfHqJ90/pXl
 9rv8euMq9OvdYdOAHC1Nsm3DNjf8lyHN5/bAOIhpuLSaTS1I2MUUAbCPvHqF2BFO825cXY4Zk1d
 AESJ14yRtv04ntsqU/EfDvNMBvCYfPpPM4t1FRAiyId5ed8ESpEIpM26dOXhJqGyZjiLOFrjA3k
 lFIRLGaNJmjR3di9qrQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA4NCBTYWx0ZWRfX1HNZhsNyfNTu
 JXIE4N7chyuQ6csyYgmIy8B/vu/dIxCQ6Hl0J16XMZnzGEfEfusAcLGIvXk81D4lqqh1MGJVLOm
 Vp7NSglT1ktZUPWgVaH5DmkQ7ttTiEo=
X-Proofpoint-GUID: yipBoTaRXUiuBoBvdCj54GEDoCtVpHzO
X-Authority-Analysis: v=2.4 cv=FLCOVOos c=1 sm=1 tr=0 ts=6ac80ac0 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=luQVlvl-W8lCxKXVFxcA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_07,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 clxscore=1015 bulkscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080084
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

Reject a response from the TPM emulator whose size field indicates that the
response is smaller than the size of the header.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20261002142516.2063735-3-stefanb@linux.ibm.com
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


