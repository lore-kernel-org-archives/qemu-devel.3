Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 540A8C7115B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 20:12:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTnWp-0004fi-Ro; Mon, 23 Jun 2025 16:12:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1uTnWj-0004eq-DM; Mon, 23 Jun 2025 16:12:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1uTnWh-000432-8A; Mon, 23 Jun 2025 16:12:25 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55NIlEYx012599;
 Mon, 23 Jun 2025 20:12:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=IEhoK4sYsNkGAns0CHYZ9YWQ4ItOO83BALyijvSNm
 wY=; b=cFmtvQ1uDdo1TjkcpiwoxBp4dKlte8DCMHZ3Q3h75qBkVqAZytoNapQ6C
 jpzxydT8RVB1wgMg6p7sWl/1Rc9tRXXy5VRnXO1+tO0x+hte+cHKsaRYy9PBA4Ns
 0RAwKBjkE1Lt+HxQuoKROY6pbNP7iwBgPOGRUBvtPb1kNut6WsY2W9n4O5ehQCFz
 eWiFFGy/oKbEs+YLkl7+Q3a5fKOT0rDPu05IjtA3OZaA4VcwTFmLzBIRNjBGQB0T
 0qz1XjyAoztG1fjSygm8dJgQD26o2uPsgb60w8aImHdUWxtvxBYRa1LafXkKmkat
 h0URGThgYpbS4gxSzJbOP2RqtOafw==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dmf2v6hu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Jun 2025 20:12:21 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55NH8V5c031277;
 Mon, 23 Jun 2025 20:12:20 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47e7eyrnn3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Jun 2025 20:12:20 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 55NKCJ3O29491798
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 23 Jun 2025 20:12:19 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D8BC258051;
 Mon, 23 Jun 2025 20:12:18 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6069D5805C;
 Mon, 23 Jun 2025 20:12:18 +0000 (GMT)
Received: from t15.ibmuc.com (unknown [9.61.75.155])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 23 Jun 2025 20:12:18 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com,
 philmd@linaro.org
Cc: jrossi@linux.ibm.com, zycai@linux.ibm.com
Subject: [PATCH 0/1] hw/s390x: Remediate legacy API call
Date: Mon, 23 Jun 2025 16:12:15 -0400
Message-ID: <20250623201216.721130-1-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=M5FNKzws c=1 sm=1 tr=0 ts=6859b525 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=axOvbl6LhLO34FXo3wUA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDEyOSBTYWx0ZWRfX527nxpe2hczP
 U5jwdu4/08GNSHK5GTiL1fqPU3O6HrG3BmacxjqwU2a/hSwwx0MlDj3V5JDnRswkjLDevbSWaUo
 ZFR177NKRufcgTQqgMGGKhfoIVMqmBVjNeez+7xikX4tza8bhBiSgsn2D6UHdo1oV60StJtWp5j
 lJQv2UxCnCMT84DM9vNzmnh2cZwOyXQdbVpG/UJYcUZuLKBbTDa6jxZxWSdL38TgdyCi83p+ugc
 zyNwi4aKfJ3RjjvZH8g/1974Ouvwcc03AHCSiZLLewV8g+3hGvp0Oo3Wewq1UKbNl3K/GPpFLT3
 qJIMEB9bYdrd+X20brr2CtLVY9KtpaJGxPwQCAWOGc+EUdnN/1SGk0FOBuJDWh+gQU2RjGCsSyS
 B93lvtludnWsJaTlCX9Yi5BrFuLq+Fn9dMjYUsy5UrqXA6E8mY5d6ZiBLPkaX4+D4KMdX+O4
X-Proofpoint-GUID: UiPONIrIzkyadsSb61t5GFZidDc-PNOC
X-Proofpoint-ORIG-GUID: UiPONIrIzkyadsSb61t5GFZidDc-PNOC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-23_06,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 spamscore=0 clxscore=1015 adultscore=0
 mlxscore=0 mlxlogscore=616 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506230129
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jrossi@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Jared Rossi <jrossi@linux.ibm.com>

Remediate the use of a legacy API call introduced by a recent patch.

Jared Rossi (1):
  hw/s390x: Use preferred API call for IPLB chain write

 hw/s390x/ipl.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

-- 
2.49.0


