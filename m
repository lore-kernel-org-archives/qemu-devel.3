Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FC59D73E87
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 21:47:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlZr2-0006qB-SO; Thu, 29 Jan 2026 16:47:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1vlZqg-0006nC-6j; Thu, 29 Jan 2026 16:46:57 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1vlZqb-00038w-Nq; Thu, 29 Jan 2026 16:46:45 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60TEppom011231;
 Thu, 29 Jan 2026 21:46:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=C2eGLk
 vSPk1gxsHMmSqMUS3hktSE6ZpKLyPj83RGXMU=; b=KoxspoDDb0T4pZTzmUE4TV
 GdKMtXLOM9uGjiIDDiZc8ZYWZ3ubjVFoDJhDdVqwT12zTjOJbL9Df9DvHIKEyiUL
 SkiP2O+JXyLzf1rOfn0158qIgCreoNJO5qojjC0yfTDNvffCXzUKri0FcXzb3yLq
 lPG/gSSihFYQQkAFDTiGmCgyXWWmpKqsBVBTDnjJ3Zyu7gJdcUr2EcI7WOq4UalX
 GOKRoXwOuhWncy9EjzZAkjuRzJETPGUJPbvzdSa7iKBC813VcyU8HOPn+8Vt5Erf
 8IQmB32BG6PrRXU0ihlPtrBlyV4wYNr632gaDve2KHlbTQhMHEQIZceorgayteYw
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvmgg8dqb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Jan 2026 21:46:33 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60TJYwur023341;
 Thu, 29 Jan 2026 21:46:32 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bwamk3ngq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Jan 2026 21:46:32 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60TLkVx014811654
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 Jan 2026 21:46:31 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8352158055;
 Thu, 29 Jan 2026 21:46:31 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 542585804B;
 Thu, 29 Jan 2026 21:46:30 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.53.37]) by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 29 Jan 2026 21:46:30 +0000 (GMT)
Message-ID: <1c899641213407613647adcc10ce1d5b10f3fce9.camel@linux.ibm.com>
Subject: Re: [PATCH v3 06/14] include/hw/s390x: Move CLP definitions for
 easier BIOS access
From: Eric Farman <farman@linux.ibm.com>
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 thuth@redhat.com, mst@redhat.com
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, mjrosato@linux.ibm.com,
 zycai@linux.ibm.com
Date: Thu, 29 Jan 2026 16:46:29 -0500
In-Reply-To: <20260127161547.459443-7-jrossi@linux.ibm.com>
References: <20260127161547.459443-1-jrossi@linux.ibm.com>
 <20260127161547.459443-7-jrossi@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Z4vh3XRA c=1 sm=1 tr=0 ts=697bd539 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=1LVPMEDt2vtEygA9br4A:9
 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: B-HwyIv_WnFCp_stCKqR5GzsiHjQQxAq
X-Proofpoint-ORIG-GUID: B-HwyIv_WnFCp_stCKqR5GzsiHjQQxAq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDE1OSBTYWx0ZWRfX72PLZRWJiaHc
 fpecTHqYpihzGXIJ41u65pK2iRnwRSAMEI96t2vZTdTatB5G7TpHyJbC0E4P7QY5x2iT/J0EKn0
 MgBwh1Ro8OobUa+A1Mh7lyOZC+WOlVfWoaBVhkjx6FnWnh1FTP8kDSrwXFWGQw+ZL5YKhLuEPBc
 Wl9bry/E5TdQrzDj7sRR3/2PSIJMQdRf/DhwJlHK1r3AJPXQjKtVe2PVUC71aItfeaWbqSktw3H
 8F55YiapukOaesJ32R7NP77hzoxsvIgfuv7H51lmn/k2YR9OlYZOpzwQzTNu9mljgTvVJt82Fqe
 zNrJuYIPZ3HRwYA+WHxDzzcTnbZLaJ880Qo1wmp3x7dZqe+cTij6GyOf3cqP374iTcHGpqriaRK
 GCf7FWe270FdwwCWBLHw+faSk4thE9ocSwyareYfYkCj/gkP3isSwf7/YtNYGK0EXToMa03EbJu
 XwwMp8y/DiyZbv9Myfw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_03,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 phishscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2601290159
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farman@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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
> Move the s390-pci-clp definitions into the "ipl" sub-directory, which is =
visible
> to the s390-bios.  This allows the bios to reuse the architected definiti=
ons and
> prevents code duplication.
>=20
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
> ---
>  hw/s390x/s390-pci-vfio.c                  | 2 +-
>  include/hw/s390x/{ =3D> ipl}/s390-pci-clp.h | 0
>  include/hw/s390x/s390-pci-bus.h           | 2 +-
>  3 files changed, 2 insertions(+), 2 deletions(-)
>  rename include/hw/s390x/{ =3D> ipl}/s390-pci-clp.h (100%)

Reviewed-by: Eric Farman <farman@linux.ibm.com>

