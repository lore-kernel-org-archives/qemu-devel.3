Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AE96CD37AC
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 13:01:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMQFs-0007yV-Tz; Mon, 11 May 2026 09:01:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wMQFe-0007n6-NB; Mon, 11 May 2026 09:00:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wMQFa-0007YX-HE; Mon, 11 May 2026 09:00:48 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64BC2ltL3334475; Mon, 11 May 2026 13:00:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=q8D3Xo
 Hu6i8IdYSf8K9sT5Tn8r+KZajPsLaygZpwMrg=; b=f/2vXM0/FzhPDgfPf3yxdB
 uNdujRyV1YTCrp2hLh+mpB9DXKbZ6HZhqFH5d9wD80gFYGLTrcmdQc2LCkan8AO5
 1XQevpwnu0dIWaD4AZyH5IGVCUvvRt+u2XT138gttiiswpIIMLZyiwkmjL+5KDnn
 td+9YFacBGAMB7jzW9NI0sn1fylZnvk84ZQpD4qRD27qFwHNf/MZilYYgBVWY5wf
 xAAiYtStaSckE/fp5dPTxox4XNu3wE2+kK2EzySPRU6VGGAQ0jxKWrBdomSrb2xQ
 4ZVR6vT8QwALdJBO3YFkGcvYb5G9W+SITuElzKT3hl7EkEu7J62jCdLnjCTPfIrg
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e1vju7qmt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 May 2026 13:00:37 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64BCdQgq023377;
 Mon, 11 May 2026 13:00:37 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e2hfg54r6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 May 2026 13:00:36 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64BD0ZE821627634
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 May 2026 13:00:35 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 22D7858067;
 Mon, 11 May 2026 13:00:35 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 545EF5805D;
 Mon, 11 May 2026 13:00:34 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.111.34]) by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 11 May 2026 13:00:34 +0000 (GMT)
Message-ID: <4a098f0bc624dd5b4214e09e43a947305b03c867.camel@linux.ibm.com>
Subject: Re: [PATCH v2 2/2] vfio/ccw: Return false when IRQ notifier setup
 fails
From: Eric Farman <farman@linux.ibm.com>
To: zhaoguohan@kylinos.cn, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Alex Williamson <alex@shazbot.org>,
 =?ISO-8859-1?Q?C=E9dric?= Le Goater	 <clg@redhat.com>, Cornelia Huck
 <cohuck@redhat.com>, Matthew Rosato	 <mjrosato@linux.ibm.com>, Tony Krowiak
 <akrowiak@linux.ibm.com>, Halil Pasic	 <pasic@linux.ibm.com>, Jason Herne
 <jjherne@linux.ibm.com>
Date: Mon, 11 May 2026 09:00:33 -0400
In-Reply-To: <20260510084353.58263-3-zhaoguohan@kylinos.cn>
References: <20260510084353.58263-1-zhaoguohan@kylinos.cn>
 <20260510084353.58263-3-zhaoguohan@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=cYbiaHDM c=1 sm=1 tr=0 ts=6a01d2f5 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=6b0_1KtOqNYRJENXbOIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: opZ07VGJ5WOOJKrGtQGpZE29p6h3XvO2
X-Proofpoint-ORIG-GUID: opZ07VGJ5WOOJKrGtQGpZE29p6h3XvO2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDE0MCBTYWx0ZWRfX3u/8nCyv24y+
 tR4jKpszejZCR/FyeFg9h55q20IrCauUn3y3r8IPEPI9EIiP+SQXiq859fH3fBSTEL8dHMqGAAk
 Fs6bwWxOPNE3H9mwSLSdevxnyND3n7hQ0hPYF03uy5Q8Z4dpBjfacUrqmxPJ/6fZW0wgpjW1X/y
 cVnkvOod9Pk1bOquvIidlX9+480pvUB66c9xCBeAsbMiWiikI7wf016xkX5recIxIsJO/3dreDQ
 0CWAf0wjOHIhWsZn5s02ELTGUd29Y4kVLGqPg5xr5toZ5G5uel5Jr/z5rnrVdPnOdGj4ImbjivF
 Q7z6Xdn4bS2jxt47IzbB+j7PRscydWtEGu/eFw5j9zasMu3nrkoIwRzgI8GcgIxY7sF0pc/E6UC
 ZIiW1rr4UkSJ0YysQxzXTbplBChFDk1ftVbDIycf4PhU0UKM3y3e+43rcTdN+pgep2Y3x2as8ou
 rL0PAHxVG5cTWcrBLAA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_03,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1011 spamscore=0 priorityscore=1501
 suspectscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605110140
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farman@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

On Sun, 2026-05-10 at 16:43 +0800, zhaoguohan@kylinos.cn wrote:
> From: GuoHan Zhao <zhaoguohan@kylinos.cn>
>=20
> vfio_ccw_register_irq_notifier() cleans up the fd handler and EventNotifi=
er
> when vfio_device_irq_set_signaling() fails, but still returns true to its
> caller.
>=20
> Return false after cleanup so the caller can handle the failed
> registration path instead of treating it as a successful notifier setup.
>=20
> Fixes: 8aaeff97acee ("vfio/ccw: Make vfio_ccw_register_irq_notifier() ret=
urn a bool")
> Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>
> ---
>  hw/vfio/ccw.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Eric Farman <farman@linux.ibm.com>

