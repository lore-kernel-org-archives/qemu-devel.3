Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26FABC5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 17:16:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwNPw-0007dH-3a; Tue, 18 Aug 2026 13:16:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1wwNPu-0007b0-8V; Tue, 18 Aug 2026 13:16:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1wwNPs-0008BL-HO; Tue, 18 Aug 2026 13:16:02 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IE3vqT2831848; Tue, 18 Aug 2026 17:15:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=O6GrjMr2sNsiPeIvnZh2cSHE6+fvAcKhNgImIzM+M
 nk=; b=o8DzIkgkaBK1+wuwMsP5pu29drX+l/HdtupbOlYOT9laWRBV6zPAlOtIz
 mkBrHD/CMYePt0u1vZ8Qj/8YnV1dPV6M1JTeMSEtQJQeLBusDcwauKQCmFiN7Zzv
 2bPPV/9kwFXgAjviI4gDZR0GJgVRkOIcplyxXPP9C3xs91ntUyjvESeQZlBOVoKC
 2paytVw6kodjWGLr7wpvjQ1pHRW9ufIg3NagJNPyzz7A883LLoLxzhAfexZqElov
 HrkUSroahuA52s2LO8KXWGdWSkZ/LsyGnlBDYbEMf4IQIe2NzSsybE+raOHCImvB
 QzUr3FZteZy6HXwwbedUUozEkYzeg==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2fsqspnv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Aug 2026 17:15:56 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67IHDfMY002862;
 Tue, 18 Aug 2026 17:15:55 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g354yc5sj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Aug 2026 17:15:55 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67IHFp9C45744506
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Aug 2026 17:15:51 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8712E20040;
 Tue, 18 Aug 2026 17:15:51 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 29E392004B;
 Tue, 18 Aug 2026 17:15:48 +0000 (GMT)
Received: from shivang.com (unknown [9.124.212.164])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 18 Aug 2026 17:15:47 +0000 (GMT)
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: shivangu@linux.ibm.com, adityag@linux.ibm.com, harshpb@linux.ibm.com,
 hbathini@linux.ibm.com, mahesh@linux.ibm.com, npiggin@gmail.com,
 rathc@linux.ibm.com, sourabhjain@linux.ibm.com, vaibhav@linux.ibm.com
Subject: [PATCH v2 0/2] MAINTAINERS: reorg PowerPC RAS code for better
 maintainability
Date: Tue, 18 Aug 2026 22:45:31 +0530
Message-ID: <20260818171541.903431-1-shivangu@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDEyNSBTYWx0ZWRfXyWmVw0NxobNh
 2rNwx+EfLiq82pPI8OHNyywLeQSjAp01B5x00mIgkiDuZKJ5dB2QYFl4zun6fN4vhzGhBrGugSj
 v9mE+5HgnIQabhXlPuymBo0HELGVyOT2ujcnoZLmtOk29otkJSGxq8VSnVcA92qo5Bj1E86xFxg
 uNZ7P0DFqAk49lD2OEruMYz9YkUE7hU/E39fkm2e97QUWbMeAnagFe1NAJS2xOgKUegnwc4NBj5
 TMKCVvhEvGWcYczq2ASwxzEX87I4B6V5K8hY/cPwLIkroxZ4vmvILpN4+cQaPZiqpCO1jtIDM5W
 VzXW+vDxWaWWqxtnmwsQNl3DwmmU12YhhyM2Gn1qBjYEkeoqAhrnnfg7AgkUMFcStsSoFH/JupI
 OWMBAnKqFPchroJyBOk1sUqU5fhrp/18aMlFmU6MGNHL/RoSdy/3tzLbCkolAwbkxltY2C25iEA
 bEt5tlATehljS9TfIOQ==
X-Proofpoint-ORIG-GUID: BL0JsPuD8cLXTTKLxoglwvxRgyrFlhEB
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDEyNSBTYWx0ZWRfX5oG3cQsg5tNu
 OpF3DntikeAAwOOfMsZioHjNVnuP1x375kDaZNzPIpGUgaO8cn+bk7CuCmYqIhpxKsquGmcwm9M
 wsyFnSprigIY0na1lRoLOvK0FWxNybc=
X-Authority-Analysis: v=2.4 cv=DJe/JSNb c=1 sm=1 tr=0 ts=6a84934c cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=fttg0JU-8XFNvovTB6AA:9
X-Proofpoint-GUID: -ppEFx-t6kgGX5XGiFBVq1kV2zL4kre7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_02,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180125
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=shivangu@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

Combining Fadump and MPIPL entries under PowerPC RAS section. Additionally
adding myself as a reviewer, to help share the review workload.

--
ChangeLog:

v2:
  Dropping the rtas_ras.c file refactor, as suggested by vaibhav.

v1: https://lore.kernel.org/all/20260714164745.573141-1-shivangu@linux.ibm.com/

--
Shivang Upadhyay (2):
  MAINTAINERS: add dedicated PowerPC RAS section
  MAINTAINERS: add self as reviewer for PowerPC RAS

 MAINTAINERS | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

-- 
2.54.0


