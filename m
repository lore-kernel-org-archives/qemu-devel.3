Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12D6DC44500
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 13:49:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfeG6-0008Sm-V2; Fri, 03 Jul 2026 09:48:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wfeFE-0008Aw-Ls; Fri, 03 Jul 2026 09:47:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wfeFA-0004n3-Is; Fri, 03 Jul 2026 09:47:52 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6636IHgW2062868; Fri, 3 Jul 2026 13:47:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Zdu0Ne
 oIeaHjCx8GNgrRLIOvgs0eb4vEkm1juOBRswg=; b=nKwgPtBeXweVA5yg1mWtdD
 cSw4aNoAf0ztgbIqHTmyZjyrWxbV0fUkgVan6TjxGqlIyPnu5Y2wc+FwM6xF+ezs
 9gkqvNNkEbW50LxWNCUoProgo4OCnHZ+pBGeQNva+HvRlMfxFwFgWuEoXWJ5j80a
 d0uzcr9mmxyxQIlTUOiY9jBbJ3LS/Wgl5mNNqQrDaK9TPkEJtD+nhn6LRAGgQw8n
 3/1ivWN69ITux72JeAO0mHZyP3cQHimvHhrxIiqXWKjqazcjclt5ZhS8NObH6Ulc
 SXsH+0a4w8Fka1cw38kvDmqO5huunJ8Jtp/9GJBpbrShcLRennYf/IkA/p0bT/iQ
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26qgfhqg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Jul 2026 13:47:43 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 663DYaJ8026986;
 Fri, 3 Jul 2026 13:47:42 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2uhyrvsh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Jul 2026 13:47:42 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 663Dlft060490224
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 3 Jul 2026 13:47:41 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B6ECB58061;
 Fri,  3 Jul 2026 13:47:41 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E509458056;
 Fri,  3 Jul 2026 13:47:39 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.116.196]) by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  3 Jul 2026 13:47:39 +0000 (GMT)
Message-ID: <db845ce9116cf17192791912aa735f9bc9d74aaa.camel@linux.ibm.com>
Subject: Re: [PATCH v13 18/33] hw/s390x/ipl: Rework s390_ipl_map_iplb_chain
 for certificate storage
From: Eric Farman <farman@linux.ibm.com>
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@kernel.org, walling@linux.ibm.com,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
Date: Fri, 03 Jul 2026 09:47:39 -0400
In-Reply-To: <20260703022933.1805010-19-zycai@linux.ibm.com>
References: <20260703022933.1805010-1-zycai@linux.ibm.com>
 <20260703022933.1805010-19-zycai@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=RYqgzVtv c=1 sm=1 tr=0 ts=6a47bd7f cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=xNZy16nkJWahHqu70j4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDEzMSBTYWx0ZWRfX9TnheJz23PYQ
 1uCbXLqlIvhgMYH2LIr4mSSD/ylIyr1kEKJ5oBiZQ2QITk0W/m7PmcAmgfJ86LgIqSzqbZRBt9h
 6toAIAUWOxCC+Vxf9m/zG2Q3BUIGrhs=
X-Proofpoint-GUID: fVUdY0L7cGMzJker_1FqJ11p24UjjyW7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDEzMSBTYWx0ZWRfX1fnBCXyDFyDy
 06EEefguriCDkxVLvV51T92CT8n2K5D7qbWoftpPMv4agYROl6Cu7J+wiJ9+6vulu4bIHepxax3
 rm1iebxkVP/wPpXmJ+k5BjdgMYlGq8PrbF2vMMiGMq3RDTzw2UxUDcWoNgMqAFpTr03HEDwQKCv
 XTrrpMYUjhsTWQYCvts1Y/DyzYF0sNTrEY8jty81Fz0nVm17/qxHOA2PhTpy5wy8qFh/T3srbwh
 q0IlJtHKH3ygV95XicJ6XZmfzYz43elnC0VpBv1+PrOV0rR2Pkebm93KtghlOkxlXeR99uV5haD
 JjxlH3En2Y+xta+oWOGpaFtB5AcnJyoP9JbKaHHJC/mh3m/QKw7o+xhzFjSpOFoj+Odt0d/b5qF
 uL/h8rweD6dD0a1cdQGDXDXS1osDQuwhUQmESL2CGonxh8Aidb+VooIT/ZPbKd2SWMfEXSL65zf
 6SqgmsVBZfjBlMApBsA==
X-Proofpoint-ORIG-GUID: fVUdY0L7cGMzJker_1FqJ11p24UjjyW7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030131
Received-SPF: pass client-ip=148.163.156.1; envelope-from=farman@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

On Thu, 2026-07-02 at 22:29 -0400, Zhuoying Cai wrote:
> Rework s390_ipl_map_iplb_chain to always allocate maximum memory for
> the IPLB chain, regardless of the number of boot devices. This space
> is also used to store certificates during secure boot, providing a
> safe location for certificates until the kernel reads them during boot.
>=20
> Rename next_iplb to ipl_data to better reflect its multiple purposes:
> storing both IPLB chains and certificate data.
>=20
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
>  hw/s390x/ipl.c              | 17 +++++++++++++----
>  include/hw/s390x/ipl/qipl.h |  3 ++-
>  pc-bios/s390-ccw/iplb.h     |  4 ++--
>  3 files changed, 17 insertions(+), 7 deletions(-)

Thanks, Joy,

Reviewed-by: Eric Farman <farman@linux.ibm.com>

