Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1495AEE20AB
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 15:50:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voO5M-0006bt-5Z; Fri, 06 Feb 2026 10:49:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1voO5J-0006bD-QD; Fri, 06 Feb 2026 10:49:29 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1voO5E-0001x2-Kt; Fri, 06 Feb 2026 10:49:27 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 6161NOKt023248;
 Fri, 6 Feb 2026 15:49:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=sjySMu
 I4pIaI7slxBkMErSsFKTV0jQ4OSyB5sdG4+2M=; b=ZBFm3T5nvqB8+SeOFtwqN/
 kLJBBTShhxQ8bYIgXng58gokneuhliVa42m82p7DlcnheGuu9vVqoYhXmakDd8sq
 ttwzmFxFFU81ZxRkcUcfNNBIWrj1SEEMmioZg79ffscQDWerJMu1dqyulay+t6wX
 P25vfBCH2b3GgCaZ6QnDhN3rygnbk+lZMKf4R/dB6+j5/UzFfVSzOaqvb1WFDqRE
 ggiH8kFg7hzpv8sKz1XTQkQTCfcrNd+4MNnoz9QvhF0q2XoRiNJ/hZDnKIFBWVa/
 h4ZIlzN7JMBk1MjoanvUyfVASU0HOeWBSRAdeQBwpJPbhkNth6rIpahxXqfR9sZw
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c1986vb4u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Feb 2026 15:49:21 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 616FZ74D009198;
 Fri, 6 Feb 2026 15:49:20 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4c1veyeu95-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Feb 2026 15:49:20 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 616FnI2m24969770
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 6 Feb 2026 15:49:18 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B4CB958060;
 Fri,  6 Feb 2026 15:49:18 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 151635805A;
 Fri,  6 Feb 2026 15:49:18 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.130.235]) by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  6 Feb 2026 15:49:17 +0000 (GMT)
Message-ID: <39547b13fa4ad8f7060732bc9718551d04a6343d.camel@linux.ibm.com>
Subject: Re: [PATCH v3 08/14] s390x: Add definitions for PCI IPL type
From: Eric Farman <farman@linux.ibm.com>
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 thuth@redhat.com, mst@redhat.com
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, mjrosato@linux.ibm.com,
 zycai@linux.ibm.com
Date: Fri, 06 Feb 2026 10:49:17 -0500
In-Reply-To: <20260127161547.459443-9-jrossi@linux.ibm.com>
References: <20260127161547.459443-1-jrossi@linux.ibm.com>
 <20260127161547.459443-9-jrossi@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA2MDExMSBTYWx0ZWRfX+zGeyDx+tM5j
 AdO5GaqXFLs4KigY+/+0lwLgF8Pwwncisd8Y9KyED1jR+0XmrDfAHsltHkHFi4ZYyAQ4iSg9q73
 +2ptMw5IPJpa7g3rqcDhaBeGfPTbkLnr6iSKXiC2wkdqjKqMG70BZU57UskzJk0ULKAbWZzE801
 xKtdnmbDtjcnXFvMohebP4G1sXMLegbOuxfdyA/cl5JXV2bA/Rt9v/YFkq1cBYSJIgXBKKvPcXv
 KY9eS4EJ5J6RCBZkGidEw09ibQDWefNjPjNAtmsWWKoZN0ybeORG5LJeEN01B7siySaFs1JqjWq
 EOmId2U5QhYvaOONl+NjlrFiZ0o5ntwj80lJLUga/9yfwzufv974+lHXzB5FIufntGHOrM8/kxu
 b8aSJUJlL7R8NQsaDCziQav3UZSf2cX6kR970Idlx5wujzpzm/zoK01KmUH7uM+TZtMbKs3YNge
 kfYHGbMSW2B3loCracA==
X-Proofpoint-GUID: FTyCKzH7WyRwlIgRVwTEKuGVN-6elNKC
X-Authority-Analysis: v=2.4 cv=DbAaa/tW c=1 sm=1 tr=0 ts=69860d81 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8
 a=cUnqiC08biq_tdeLAnAA:9 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: FTyCKzH7WyRwlIgRVwTEKuGVN-6elNKC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-06_04,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 adultscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2602060111
Received-SPF: pass client-ip=148.163.156.1; envelope-from=farman@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, 2026-01-27 at 11:15 -0500, jrossi@linux.ibm.com wrote:
> From: Jared Rossi <jrossi@linux.ibm.com>
>=20
> Define a new PBT code and IPLB layout in preperation for supporting PCI d=
evice

s/preperation/preparation/

> IPL on s390x.
>=20
> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
> ---
>  include/hw/s390x/ipl/qipl.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Reviewed-by: Eric Farman <farman@linux.ibm.com>

