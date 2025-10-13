Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13C3BCCD183
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 16:51:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8Lkx-0001NP-Gu; Mon, 13 Oct 2025 12:50:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1v8Lkv-0001N4-3k; Mon, 13 Oct 2025 12:50:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1v8Lkq-0007ue-Ud; Mon, 13 Oct 2025 12:50:40 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59D9ILll004365;
 Mon, 13 Oct 2025 16:50:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=MRD1MI
 6/tlBWkk5PzYQj1kxP712ADV+5yLzIXiPcduc=; b=CjnWTt1GvdGWJ4Pros8uqV
 xHwjsCvOQ4jD1CfWKkFLwrSt1t6sb6N0iAylaMORxDcVdvjP+Ss0RHkH7b/6FqMS
 WAKvqc2ui8V8eIWPk+Ckf7c0uYNhQs4IRQEPKi77uI+sXyHNu/qlsNe/EFNy50cr
 hw2jnP1Ihpxk2UkzT+L/kpEXDObNtuG0d07TgQ/ZpCG5KorqE16msWHU3/9tlqLj
 PXXtZDtmtF05rjwhDKVzpufZRqkNWG2BgkSXgI/z2sUXmeWUT0HnyGqXttHpPrBJ
 U3wn1pjotfqrlZ8JPXO8NaBl7Fdkf3EEfr1O4zTuDpv3hor4ZU8ZLUKCHt0WSwaA
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49rfp7my4p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 13 Oct 2025 16:50:29 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59DE5pN3018823;
 Mon, 13 Oct 2025 16:50:28 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49r2jmew3p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 13 Oct 2025 16:50:27 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59DGoOAp44892646
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 13 Oct 2025 16:50:24 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 15CC820043;
 Mon, 13 Oct 2025 16:50:24 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B415720040;
 Mon, 13 Oct 2025 16:50:23 +0000 (GMT)
Received: from li-978a334c-2cba-11b2-a85c-a0743a31b510.ibm.com (unknown
 [9.111.26.139]) by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 13 Oct 2025 16:50:23 +0000 (GMT)
Message-ID: <cb6b2a02856cffcb51b6049e7bc03ed8e160f03c.camel@linux.ibm.com>
Subject: Re: [PATCH v2 1/2] qapi/machine-s390x: add QAPI event
 SCLP_CPI_INFO_AVAILABLE
From: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
To: Shalini Chellathurai Saroja <shalini@linux.ibm.com>, qemu-s390x
 mailing list <qemu-s390x@nongnu.org>, Thomas Huth <thuth@redhat.com>
Cc: Sebastian Mitterle <smitterl@redhat.com>, qemu-devel mailing list
 <qemu-devel@nongnu.org>, Hendrik Brueckner <brueckner@linux.ibm.com>,
 Michael Mueller <mimu@linux.ibm.com>
Date: Mon, 13 Oct 2025 18:50:03 +0200
In-Reply-To: <20251013133902.111233-1-shalini@linux.ibm.com>
References: <20251013133902.111233-1-shalini@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: E8i2t-1Sg8DFUS7d9yKFsrPFlpdrwXIm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEyMDA4NCBTYWx0ZWRfX5VuffbrULoYe
 BcOlYCe3m4j7Am/NSgLNiw6YV9Bs4bZ3Q5+6YJeduJxejSAALIfWEHge7/bTXBUCtlmTgZVKVgr
 SDyPO5LcmZQhjexhXaMVaNSS4w8ZJn3avk2KSh96YgPLQIkwug26mOhflaUHXMd3HPMF1PSvy0i
 mRgRgxccUruD7YaI92E6XY9nsCiloneWsXArAxI1yLDcWymz6cczcuY7dKQI6BWfzOn0ryVMm6q
 qD3h2E3XWARIx0kd5n6gz3t747iwTcJPmbx+lxZ3GGClWVbGZq2DPkW5s832dnnf8VGkgw+FjIG
 UhQlXav+qWpOov2N42US1mcHCP+F2lu+Vkc4s14ZMn6rPzxKBzt3t2zIZkm7n2VkGHG9AIPwhoi
 7OEKSbGoICoRvr4M0wg+Vp9WmtEVCQ==
X-Proofpoint-GUID: E8i2t-1Sg8DFUS7d9yKFsrPFlpdrwXIm
X-Authority-Analysis: v=2.4 cv=af5sXBot c=1 sm=1 tr=0 ts=68ed2dd5 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=RKBmHt94fYA7jx5VqUUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_06,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 spamscore=0 adultscore=0 suspectscore=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510120084
Received-SPF: pass client-ip=148.163.156.1; envelope-from=nsg@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

On Mon, 2025-10-13 at 15:39 +0200, Shalini Chellathurai Saroja wrote:
> Add QAPI event SCLP_CPI_INFO_AVAILABLE to notify the availability
> of Control-Program Identification data in QOM.
>=20
> Signed-off-by: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
> Suggested-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/s390x/sclpcpi.c      |  4 ++++
>  qapi/machine-s390x.json | 25 +++++++++++++++++++++++++
>  2 files changed, 29 insertions(+)
>=20
> diff --git a/hw/s390x/sclpcpi.c b/hw/s390x/sclpcpi.c
> index 7aa039d510..90da61b1c8 100644
> --- a/hw/s390x/sclpcpi.c
> +++ b/hw/s390x/sclpcpi.c
> @@ -54,6 +54,7 @@
>  #include "hw/s390x/event-facility.h"
>  #include "hw/s390x/ebcdic.h"
>  #include "qapi/qapi-visit-machine.h"
> +#include "qapi/qapi-events-machine-s390x.h"
>  #include "migration/vmstate.h"
> =20
>  typedef struct Data {
> @@ -106,6 +107,9 @@ static int write_event_data(SCLPEvent *event, EventBu=
fferHeader *evt_buf_hdr)
>      e->timestamp =3D qemu_clock_get_ns(QEMU_CLOCK_HOST);
> =20
>      cpim->ebh.flags =3D SCLP_EVENT_BUFFER_ACCEPTED;
> +
> +    qapi_event_send_sclp_cpi_info_available(true);
> +
>      return SCLP_RC_NORMAL_COMPLETION;
>  }
> =20
> diff --git a/qapi/machine-s390x.json b/qapi/machine-s390x.json
> index 966dbd61d2..338653e0b8 100644
> --- a/qapi/machine-s390x.json
> +++ b/qapi/machine-s390x.json
> @@ -119,3 +119,28 @@
>  { 'command': 'query-s390x-cpu-polarization', 'returns': 'CpuPolarization=
Info',
>    'features': [ 'unstable' ]
>  }
> +
> +##
> +# @SCLP_CPI_INFO_AVAILABLE:
> +#
> +# Emitted when the Control-Program Identification data is available
> +# in the QOM tree.
> +#
> +# @iscpiavailable: is CPI data available in QOM
> +#
> +# Features:
> +#
> +# @unstable: This event is experimental.
> +#
> +# Since: 10.2
> +#
> +# .. qmp-example::
> +#
> +#     <- { "event": "SCLP_CPI_INFO_AVAILABLE",
> +#          "data": { "iscpiavailable": true },
> +#          "timestamp": { "seconds": 1401385907, "microseconds": 422329 =
} }
> +##
> +{ 'event': 'SCLP_CPI_INFO_AVAILABLE',
> +  'data': { 'iscpiavailable': 'bool' },


What is the point of this payload?=20

> +  'features': [ 'unstable' ]
> +}

--=20
IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Wolfgang Wendt
Gesch=C3=A4ftsf=C3=BChrung: David Faller
Sitz der Gesellschaft: B=C3=B6blingen / Registergericht: Amtsgericht Stuttg=
art, HRB 243294

