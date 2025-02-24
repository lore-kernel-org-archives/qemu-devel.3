Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E22CEC021BE
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 17:08:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmbw9-0003rZ-4A; Mon, 24 Feb 2025 12:08:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1tmbw4-0003qL-Ei
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 12:08:04 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1tmbw0-0004Jb-D8
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 12:08:01 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51OEMAEZ025070;
 Mon, 24 Feb 2025 17:07:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=f7zR3D
 7/VuKgHB2BVwIOzC2Zs2JePbvTTiUPhahkZqQ=; b=DKbiUY1hQAMNfW1XTk46k9
 IFIp1WbNxgupx/NQUv78YRJb4Z882JmWQi2dnUe/jfDvdVksqWGd4NQRQEZFORP9
 umdkWBuEbQdVeo9FsCJvq2SeJM81p8RrG54rlRDPakFzOzQTZabD+qU48Mz8U2xj
 ewZno3A3Ilm4Op8XY80ktV9WtorbghDgBVIuPp8XktgRlDGIG0AmLwzTpBAROlcq
 UZ3RKozxwyozG1H4P0Qq1npRM0J8P8PQK9TV+MNJVGSfcTn7feNWPKr+GIkIuodI
 G0b6QGfRuA4L3jhfYJHrbR1J6h9sbZGoxLBAfcEcd1eVfqX63cSDiYSMQXMAsiGQ
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 450eu9uxhm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Feb 2025 17:07:59 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51OF1LT8012470;
 Mon, 24 Feb 2025 17:07:58 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 44yrwsgga7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Feb 2025 17:07:58 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 51OH7vnl59244860
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Feb 2025 17:07:57 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2DF9F58057;
 Mon, 24 Feb 2025 17:07:57 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C84AF58058;
 Mon, 24 Feb 2025 17:07:56 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.172.201]) by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 24 Feb 2025 17:07:56 +0000 (GMT)
Message-ID: <e8f51190d833d6a283b4602bd20b42483983d9b1.camel@linux.ibm.com>
Subject: Re: [PATCH] vfio/ccw: Replace warn_once_pfch() with warn_report_once()
From: Eric Farman <farman@linux.ibm.com>
To: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Matthew Rosato
 <mjrosato@linux.ibm.com>
Date: Mon, 24 Feb 2025 12:07:56 -0500
In-Reply-To: <20250214161936.1720039-1-clg@redhat.com>
References: <20250214161936.1720039-1-clg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9HLj_HSX_O3Cb4Dt_yd4c_EjU9Y3u8_N
X-Proofpoint-ORIG-GUID: 9HLj_HSX_O3Cb4Dt_yd4c_EjU9Y3u8_N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_08,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 mlxscore=0
 suspectscore=0 bulkscore=0 clxscore=1015 phishscore=0 spamscore=0
 malwarescore=0 impostorscore=0 lowpriorityscore=0 mlxlogscore=579
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502240116
Received-SPF: pass client-ip=148.163.156.1; envelope-from=farman@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Fri, 2025-02-14 at 17:19 +0100, C=C3=A9dric Le Goater wrote:
> Use the common helper warn_report_once() instead of implementing its
> own.
>=20
> Cc: Eric Farman <farman@linux.ibm.com>
> Signed-off-by: C=C3=A9dric Le Goater <clg@redhat.com>
> ---
>  hw/vfio/ccw.c | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)

Reviewed-by: Eric Farman <farman@linux.ibm.com>

