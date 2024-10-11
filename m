Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82123D1A427
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2024 22:37:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szOFD-0003Q0-LL; Fri, 11 Oct 2024 18:36:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1szOFC-0003Pn-JE
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 18:36:22 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1szOFB-0006Br-2m
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 18:36:22 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49BJ41tJ009937
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2024 22:36:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding; s=pp1; bh=x/rWXMHNlc3s+JR0goVrKLvvRU
 8jVM3k1TwJNwPMfGI=; b=FymeIL7JJ9GX+Ro8nOlyhsCfI7U/NRWeBxV9tmTLJk
 peB159Z9Lvf6Z+fGWLJXcFjq5jXNC4cYjrRR8bj+ZfxfyJWw4VhntJSt8jwlfSOY
 RYQEYdocsixfWi7C+x2SxPAGN0M1cO6xH5Xue2Liof3X+hf+mx7TBJZykipC7pIJ
 CCPEEANc6EIvTCRld465mJ2pf8CFcqWJ4qHbFyW+bnWfu6lr4DwRoLlzeTvgGjSb
 Ogo5OhGnRDEPIV/Cldjq3QHo3A9buXnkhYdoJxqgSljvTR5jGQ3oeu32MQ+joSmn
 nzXMmKm6dTy1UBSNCzUOw/uJRtWL9XQBW7Jd2hVm5qoA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4279uernkj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2024 22:36:09 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49BMXcpC021996
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2024 22:36:08 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4279uernkg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Oct 2024 22:36:08 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49BKKDbF013790;
 Fri, 11 Oct 2024 22:36:08 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 423fssr4bm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Oct 2024 22:36:08 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 49BMa7nv51052848
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 11 Oct 2024 22:36:07 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 67C5558053;
 Fri, 11 Oct 2024 22:36:07 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D41425805F;
 Fri, 11 Oct 2024 22:36:06 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 11 Oct 2024 22:36:06 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, marcandre.lureau@gmail.com,
 Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH 0/2] tpm: Resolve potential blocking forever issue
Date: Fri, 11 Oct 2024 18:35:54 -0400
Message-ID: <20241011223556.2953808-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.46.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 4kbZUeUnQzZyL79HZ5uq3yYJcAgu4WMS
X-Proofpoint-GUID: 4HIT7T8OEsy_71pHz-3kB4N1xi0WCXls
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-11_19,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 priorityscore=1501 mlxscore=0 adultscore=0 mlxlogscore=582 bulkscore=0
 spamscore=0 malwarescore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410110157
Received-SPF: pass client-ip=148.163.158.5; envelope-from=stefanb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

In case swtpm was to return a control channel message with an error code it
would only return 4 bytes. However, some of the commands expect a response
with more bytes and QEMU would get stuck in qemu_chr_fe_read_all() waiting
for bytes following the error code. Therefore, read the response in 2
passes stopping if an error code is received in the first 4 bytes to avoid
getting stuck.

   Stefan

Stefan Berger (2):
  tpm: Use new ptm_cap_n structure for PTM_GET_CAPABILITY
  tpm_emulator: Read control channel response in 2 passes

 backends/tpm/tpm_emulator.c | 39 +++++++++++++++++++++++++++++--------
 backends/tpm/tpm_ioctl.h    | 13 ++++++++++++-
 backends/tpm/trace-events   |  2 +-
 3 files changed, 44 insertions(+), 10 deletions(-)

-- 
2.46.2


