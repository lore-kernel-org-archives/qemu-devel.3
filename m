Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77DE3CA5FC5
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 15:25:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBwB1-0000Aa-Px; Wed, 30 Sep 2026 11:25:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xBwAz-00009e-I5; Wed, 30 Sep 2026 11:24:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xBwAy-00023D-06; Wed, 30 Sep 2026 11:24:57 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UE5TTs2986176; Wed, 30 Sep 2026 15:24:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=FtTb0mW5MWM1J2gT4
 xydNoipirPw7WYwXKq6Lc/xJCg=; b=bRSjrxAevpvjxYDDeDrMZYzl1QD0yIoPp
 V4uedqzPRZXQQJWJHO2XrjxnAEe0W7wvpF6YoHCRunmGo1rSqilJ5iV6f2KUbUuI
 cvGO3gbmKFY1HnWomHpUBy/6JMsQkXUsLc025vFxKAm0VTR3K89+l+mvfXRF1OuK
 IxrBLW77zZEo/qlwtB/8oHKWM1y4JbTI9PGpTLZxnj3boQ3X5dG7h8gmEr9Dl813
 BPen+Xy2WGnQI5Y9i36JkehuVg3f9KtjLEuwhaNGzymFPD96a1sFoIIVfHH8gStM
 DRIstLRnYR8xpgO3pBQRdnyAugN7lufC2+9X3ASFzGvNz2dqtF83w==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx3fkd8be-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 30 Sep 2026 15:24:34 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UE38TY3605933; Wed, 30 Sep 2026 15:24:34 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gxsvhq2fh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 30 Sep 2026 15:24:34 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68UFOXbo31326972
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 30 Sep 2026 15:24:33 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0938558060;
 Wed, 30 Sep 2026 15:24:33 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 85F6C5805A;
 Wed, 30 Sep 2026 15:24:32 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com.com (unknown
 [9.61.5.156]) by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 30 Sep 2026 15:24:32 +0000 (GMT)
From: Eric Farman <farman@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>
Subject: [PULL 19/23] s390x/sclpconsole: fix indentation for console_reset
Date: Wed, 30 Sep 2026 11:24:16 -0400
Message-ID: <20260930152420.1956230-20-farman@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930152420.1956230-1-farman@linux.ibm.com>
References: <20260930152420.1956230-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: isOp7K1Xdx3qyA1VAC7dYDKr5hwSAHYW
X-Proofpoint-GUID: isOp7K1Xdx3qyA1VAC7dYDKr5hwSAHYW
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA2MCBTYWx0ZWRfX0UT/AP3TWNoF
 DrPXClsJEP2nyctKDiumEAfmD6ARR2+DWacIMr9Ua8sigCZ3aq5DefQPlbcu8nwSAS6cxRDenqM
 LOyMut8AC3u7H7SbSYejz0M6iXfJvVA=
X-Authority-Analysis: v=2.4 cv=Vv62kO2n c=1 sm=1 tr=0 ts=6abd29b2 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=og5TcVbNlwXT-lVP8TsA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA2MCBTYWx0ZWRfX9BOsqODnyQHx
 Wual42JQ2Bn1HIg7hqZZ4SXwaD1HQxissxwkrcbp1a4HAqCK5YOTai7PAG5udTxrXlV2nfWw2PG
 9ikvqjim/fb8bKZf26K27ZTu9qemUojnJh4tDXb0nd/RgPCDWJSNyk2LFLKzFxZQg7TvhhMMmIR
 8ovBEQsuL5mMyj3b/5wHXs86m5KiVT5A4j0eviDUlQo2FzCqmBlBNMKD4v92U1Fv4634dy0l06j
 GETxQcm5gZwSX9xkrueXf6K1P3gFbBDkz9Ot0Odc6IJ7s3455g1/iaJlXRHREVScBa/cFLFv263
 89lpaqFKqjKaXI8AveyI1tDHN9UqsL03LbFCFemIAgiQWsWyetvE1sLou+X3fnvImFkJcpdUPqE
 xty3fEIhDbX4UqccQX+IyGNby6B8L+9DDm6kRe0lgkAtQBVJRoGB+W7trUigj5Wcec+qBrqwguO
 pkZBauXxGizYFqJgahA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609300060
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farman@linux.ibm.com;
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

From: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>

Adjust indentation to match the rest of the file. No functional change
intended.

Signed-off-by: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260929152012.2696005-2-maxbr@linux.ibm.com
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 hw/char/sclpconsole.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/hw/char/sclpconsole.c b/hw/char/sclpconsole.c
index 179d12745c..1ad39084d3 100644
--- a/hw/char/sclpconsole.c
+++ b/hw/char/sclpconsole.c
@@ -240,15 +240,15 @@ static int console_init(SCLPEvent *event)
 
 static void console_reset(DeviceState *dev)
 {
-   SCLPEvent *event = SCLP_EVENT(dev);
-   SCLPConsole *scon = SCLP_CONSOLE(event);
-
-   event->event_pending = false;
-   scon->iov_sclp = 0;
-   scon->iov_bs = 0;
-   scon->iov_data_len = 0;
-   scon->iov_sclp_rest = 0;
-   scon->notify = false;
+    SCLPEvent *event = SCLP_EVENT(dev);
+    SCLPConsole *scon = SCLP_CONSOLE(event);
+
+    event->event_pending = false;
+    scon->iov_sclp = 0;
+    scon->iov_bs = 0;
+    scon->iov_data_len = 0;
+    scon->iov_sclp_rest = 0;
+    scon->notify = false;
 }
 
 static const Property console_properties[] = {
-- 
2.55.0


