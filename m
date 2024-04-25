Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F335C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 12:33:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzyGk-0003gj-V1; Thu, 25 Apr 2024 08:32:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1rzyGg-0003gB-Hn; Thu, 25 Apr 2024 08:32:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1rzyGd-0002u1-3b; Thu, 25 Apr 2024 08:32:01 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 43PCMMVG018880; Thu, 25 Apr 2024 12:31:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=Jhigs+Igzil5BYvSHsGqOtb0PyXud2VlHDSqrtuQUXA=;
 b=K0jk825BFoVrF0ICFjrgKMur+hePw7qrhY0LLqCklPgqdA3fVm5Swo4qIqqTIZLNKIVz
 AisQmfkDlHu3t87XirgiZvA+Yu2UjYIlznSUyiUUYdRPDq4Y+ay1M8FC91hZbKwGaHjR
 5kfkNA+F0gL4TrafMZvqXweo193Kvpw4DLI/rV2FwOGM82V+UMKXxjTix2bAN5BOk0Ux
 6qvzb5K3UjLjDLsT/0AE8vJH7pOT10xkJkIjt9TDsilwDqdT1v7MVJ/pMHlHIFllrk2G
 gYGqSyjRECWHXn0oc1Srd/njW3uhW2i43bhXrrtgWG/Ut4infAE4+eUVgdz7UKB2XpZD 2Q== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xqq4680uq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Apr 2024 12:31:53 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43PCVrgw002656;
 Thu, 25 Apr 2024 12:31:53 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xqq4680um-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Apr 2024 12:31:53 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 43PBpnCc023042; Thu, 25 Apr 2024 12:31:51 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xms1p9pqh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Apr 2024 12:31:51 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 43PCVn9m41026026
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 25 Apr 2024 12:31:51 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7E54A5803F;
 Thu, 25 Apr 2024 12:31:49 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 67F5D58060;
 Thu, 25 Apr 2024 12:31:48 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.53.65]) by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 25 Apr 2024 12:31:48 +0000 (GMT)
Message-ID: <51013f75a6175781b7243aed1b3004911724a915.camel@linux.ibm.com>
Subject: Re: [PATCH v2 3/4] vfio/ccw: Use g_autofree variable in
 vfio_ccw_register_irq_notifier()
From: Eric Farman <farman@linux.ibm.com>
To: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>, Alex Williamson
 <alex.williamson@redhat.com>, Thomas Huth <thuth@redhat.com>, Matthew
 Rosato <mjrosato@linux.ibm.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Date: Thu, 25 Apr 2024 08:31:47 -0400
In-Reply-To: <20240425090214.400194-4-clg@redhat.com>
References: <20240425090214.400194-1-clg@redhat.com>
 <20240425090214.400194-4-clg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Mj8GP343RoJ6nATspQXP7es65-NK4x2-
X-Proofpoint-ORIG-GUID: D6zNLCMozMsM7OKhZhGwp73hi06JXErx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_12,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 mlxlogscore=962 spamscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 phishscore=0 adultscore=0 malwarescore=0 priorityscore=1501 clxscore=1011
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404250091
Received-SPF: pass client-ip=148.163.156.1; envelope-from=farman@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, 2024-04-25 at 11:02 +0200, C=C3=A9dric Le Goater wrote:
> Signed-off-by: C=C3=A9dric Le Goater <clg@redhat.com>
> ---
> =C2=A0hw/vfio/ccw.c | 9 +++------
> =C2=A01 file changed, 3 insertions(+), 6 deletions(-)

I realize this was just split out of v1, but probably need a commit
description here.

Regardless,

Reviewed-by: Eric Farman <farman@linux.ibm.com>

