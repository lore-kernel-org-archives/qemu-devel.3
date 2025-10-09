Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2B31CCD185
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 14:56:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6s2T-0003wE-P0; Thu, 09 Oct 2025 10:54:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1v6s2P-0003vG-84; Thu, 09 Oct 2025 10:54:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1v6s2H-0005TJ-3S; Thu, 09 Oct 2025 10:54:36 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 599Bj1fF031098;
 Thu, 9 Oct 2025 14:54:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=nC3KpB
 HsdstQRk6/Z0SMa6ILfZlbSKWNxtYsuCgKOK4=; b=JQkoo9JhUKm3oiVUdW2zo+
 +yDp4aZ8BPiK7n/kkpQBTe1dzss3smf0RS/Zr2e81Yd7s4hOjrFpk70V4E423wV/
 9beQoLyDKqUeBA/6Be5HIrSU3IJavbS/87cpxA8l2vAbW7totTD8u0BPTla+n7sT
 NyKI02PTVGKa8IBPn0rbo4z4Pnjphpi6isbRs/Lpa42AvG60AJdWK+uO8EWlWKVL
 397DKYGKF/Pmw74PA5iJmf5QLPc+J64kmEQXq9QXsF0/Iv55OhmBvuaQlH9hfbCR
 uvBYULC7MTmA3FoXcjiqhoGdvVAP/6nofk/ZJDALi7YF7fNszkaat6rnVXSTGWOg
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49nv81nc2m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 09 Oct 2025 14:54:20 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 599CAtVo026053;
 Thu, 9 Oct 2025 14:54:20 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49nvamn2qp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 09 Oct 2025 14:54:20 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 599EsIBs20054614
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 9 Oct 2025 14:54:19 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C2F5C58059;
 Thu,  9 Oct 2025 14:54:18 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B8F5D5805B;
 Thu,  9 Oct 2025 14:54:17 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.142.86]) by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  9 Oct 2025 14:54:17 +0000 (GMT)
Message-ID: <91a9835f6580c38aaa2dbe3d03c76bf03eb434ae.camel@linux.ibm.com>
Subject: Re: [PATCH v3] s390x/pci: set kvm_msi_via_irqfd_allowed
From: Eric Farman <farman@linux.ibm.com>
To: Matthew Rosato <mjrosato@linux.ibm.com>, qemu-s390x@nongnu.org
Cc: thuth@redhat.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com,
 alifm@linux.ibm.com, qemu-devel@nongnu.org
Date: Thu, 09 Oct 2025 10:54:17 -0400
In-Reply-To: <20251008203350.354121-1-mjrosato@linux.ibm.com>
References: <20251008203350.354121-1-mjrosato@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 161UZR9MuMpMTERFGSv8Xp5o-2PrCaKw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfXzqHWd/LTVoiD
 DIxqmQyZm+/T0tRd4XJRTs995WxsQFf4ZFdkiqC7Z8jHDoz4G9HW8Rm4QN5N6FTpmgF5QnBq1GT
 2alOTX0l5wDh9apqG1kt6WZSbP0YjO8KvHll7s4HVqRRATwNy7uXcPzX5lbRBJT8uqHf8j93Ta5
 XQRV3tdo+Ow/n+6GNWlhlydw/uvUw3/3UDrix47cKAlt30HyvtbdLO+7T7Nw6mtOwQ+OIl4FKmS
 8QkydbsmYF+nsQ9EB26PKwRx49POzvy7SFAg4hTs7EICeHMNAj/TU6EG8Ioc1FrgjT1svZaRtE1
 aI0xbYJ2lfGlcOkB/R2PZ3ztnC6Qn+D89sqDKPo45+nfkgCgw0DlWDRX940Bu0zOy42iW8wNrbT
 /XlLsbRvl5Y7Q1X7G/okyMaM51O4Rw==
X-Authority-Analysis: v=2.4 cv=cKntc1eN c=1 sm=1 tr=0 ts=68e7cc9c cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VnNF1IyMAAAA:8 a=HxSfouJ9v2ZbyTOdTxkA:9
 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: 161UZR9MuMpMTERFGSv8Xp5o-2PrCaKw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_05,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 phishscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farman@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, 2025-10-08 at 16:33 -0400, Matthew Rosato wrote:
> Allow irqfd to be used for virtio-pci on s390x if the kernel supports
> it.  This improves s390x virtio-pci performance when using kvm
> acceleration by allowing kvm to deliver interrupts instead of QEMU.
>=20
> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
> ---
> v3:
>  - Fix builds when !KVM (Thomas). Tested build on x86 and s390.
>  - Note: Dropped all review tags due to the code re-organization.

Ah, my apologies for missing the !KVM case before.

Reviewed-by: Eric Farman <farman@linux.ibm.com>

