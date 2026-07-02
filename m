Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00398C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 01:44:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wf6Tr-0003fo-Cu; Wed, 01 Jul 2026 21:44:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wf6Tp-0003fb-Qq; Wed, 01 Jul 2026 21:44:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wf6To-00048f-Gn; Wed, 01 Jul 2026 21:44:41 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6621LYiI2348651; Thu, 2 Jul 2026 01:44:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=WiIVag
 IrL43PlvKzdL9a2ryh6bcoL7t29SMvI9RMtQY=; b=eltWQiZPCCXji2TbvyirkK
 rCYul8ihTC0Es/PzUUELPgJRt13OmOgw4vYbXcBdI2JHc+kNS5HcVvAc4B0RRXVW
 IqOTvTf7sDSGeH+T5TODO6QDXtcFnYDTlM8GHTGQT0trDSMH1VQ85xaDlpGOsIZ3
 CtGvGPYyIE7Q2TtTNneYsTP+WyiVCgYy8RKzXjegt/QZ4Ng2BLKM/3sqs3dB3MXK
 DG6ruXSU9Pt171yh2NKQh8q2w+aU7TXbmxNvz7I16nqHT8ozcYVFM4sjQqq/6tf3
 i54tqwwz3h/VQzQ/xHyQ8NvZO0TQtM56kQl3kaXy8PE1R+jFwwuVFVqjjGuqYS+g
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26mjy6j1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Jul 2026 01:44:37 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6621Yg07029353;
 Thu, 2 Jul 2026 01:44:37 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2s7wa1hr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Jul 2026 01:44:37 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6621iZiR53805390
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 2 Jul 2026 01:44:36 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CC47758055;
 Thu,  2 Jul 2026 01:44:35 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D73515805D;
 Thu,  2 Jul 2026 01:44:34 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.136.69]) by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  2 Jul 2026 01:44:34 +0000 (GMT)
Message-ID: <b4ed613880ee4e1fcf465df51e8790cf533a5069.camel@linux.ibm.com>
Subject: Re: [PATCH v2 2/6] pc-bios/s390-ccw/virtio.c: Fix missing break for
 PCI notifications
From: Eric Farman <farman@linux.ibm.com>
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 cohuck@redhat.com, mjrosato@linux.ibm.com
Cc: zycai@linux.ibm.com, jdaley@linux.ibm.com, jjherne@linux.ibm.com,
 nrb@linux.ibm.com
Date: Wed, 01 Jul 2026 21:44:34 -0400
In-Reply-To: <20260630141917.673995-3-jrossi@linux.ibm.com>
References: <20260630141917.673995-1-jrossi@linux.ibm.com>
 <20260630141917.673995-3-jrossi@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDAxMCBTYWx0ZWRfXyvxSxg12+jw0
 XbCFyAt8Qgad4Z7BiFwQTKzbCOVEDJ9LRMUcZNUSvKChD0LoeIfd+uGmVipHqMWyYsoxyj+cimj
 7uXD4J8LeVnHUg2ktyncdhqAWGrQ/CbqcvoKsx5Fp/fR5jU+91CDZE7Qx9BPCCOU6WBM+xi8OFB
 RqGX8SiYPyJNGqpvTCh+hLGWqMd/W4K48GV7uu/0OBHILvbm0aTtlpy+lKXlICeH2i2MwfKJu9X
 D0Fq2d8Rz7zztU81U5Jk0qjBImqRIw4ctKmLRK/QXMp6u9ZKcvOUeQXsYItc88RL+e0cJC/fUYA
 5A1wPLnawQh6HhmmvXkMoIHe8d2ON2m2K1jv+CqQCr9vyGXTE13mEdVg8N7+uqIWwjYIDRt2cVR
 3YGOURkKsPhydN1LoL+US+RvrUBASsDQFB185Ag6Y06CE4Ein2s//SyEqX/RmkU/lpqYhPZ+gKa
 Y3/bGzQh50rymO2incw==
X-Proofpoint-GUID: 2odho7-PlkGOsxGwcpZq4l2wRqys7Q7F
X-Authority-Analysis: v=2.4 cv=Z8bc2nRA c=1 sm=1 tr=0 ts=6a45c285 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=UJnXFHHSjimePnNXT_MA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDAxMCBTYWx0ZWRfX23kZB+ZcmONO
 FwyJ9DXcyArTXQyjMCo98gQVUb9IAIzBuHmVNv+0eNgR2l7r4Q15q695T9GZhnadsq/ALNoXm3e
 XePVAIQbqOqTL+VLHzWmgHfL+t+1wUg=
X-Proofpoint-ORIG-GUID: 2odho7-PlkGOsxGwcpZq4l2wRqys7Q7F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020010
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farman@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On Tue, 2026-06-30 at 10:19 -0400, jrossi@linux.ibm.com wrote:
> From: Jared Rossi <jrossi@linux.ibm.com>
>=20
> Add a break after calling the PCI specific notification function instead =
of
> falling through to the default case.
>=20

Fixes: d72fb5e6b2 ("pc-bios/s390-ccw: Add support for virtio-blk-pci IPL")

> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
> ---
>  pc-bios/s390-ccw/virtio.c | 1 +
>  1 file changed, 1 insertion(+)
>=20

Reviewed-by: Eric Farman <farman@linux.ibm.com>

