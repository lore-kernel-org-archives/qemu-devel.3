Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7041C02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 18:09:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbO7S-0001Mo-Vw; Fri, 24 Jan 2025 13:09:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1tbO7Q-0001M5-Kt; Fri, 24 Jan 2025 13:09:24 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1tbO7O-0006o3-P8; Fri, 24 Jan 2025 13:09:24 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50OFdQGN013311;
 Fri, 24 Jan 2025 18:09:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=EzcNeS
 yIQOajauRsfCA1OntBEzUEWOaHbUCmiEkdZc0=; b=m58oYkuQPHmRzj89FGQw8H
 WdiIR6FFaRRpxFF+ThYOwScyw6NSvB1hompuBNxKZY1XQ3cVbrFO80+VvB+iyeZh
 vJ0YwN4ZxFQf4l4ACfQ7DmdzBDtNHK9ZTLNGrBqcsyuTJshePHMs0qIt0fB7QMnD
 GyONDtgw+Dc2p6jdo8mntqCjO6pF3pGU2Zl1z7UGKAHg4Nve1AUY3bdrTKVjnwsJ
 BNWKCDxsr3dIWLMGzz8STytyN7HhTtVKId9vDROGt+CNeqUbPMK4YF/xB8XqsvXw
 9NScuhQL+zxhwmpi8rXF+q62kYXSj9TKnGE+LD9vmSlNTg2Ga62ENGyhTq75k1zg
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44cdptrr80-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Jan 2025 18:09:20 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50OHZ3XO032274;
 Fri, 24 Jan 2025 18:09:19 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 448ruk4c25-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Jan 2025 18:09:19 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 50OI9GF457278790
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 24 Jan 2025 18:09:16 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6EFDE2007F;
 Fri, 24 Jan 2025 18:09:16 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2C6662007D;
 Fri, 24 Jan 2025 18:09:16 +0000 (GMT)
Received: from li-978a334c-2cba-11b2-a85c-a0743a31b510.ibm.com (unknown
 [9.179.27.114]) by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 24 Jan 2025 18:09:16 +0000 (GMT)
Message-ID: <1c844d5fefcbcfa5c969c4b6d5ad1ebf121861b2.camel@linux.ibm.com>
Subject: Re: [PATCH v1 3/3] hw/s390x: support migration of CPI values
From: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
To: Shalini Chellathurai Saroja <shalini@linux.ibm.com>, qemu-s390x
 mailing list <qemu-s390x@nongnu.org>
Cc: qemu-devel mailing list <qemu-devel@nongnu.org>, Hendrik Brueckner
 <brueckner@linux.ibm.com>
Date: Fri, 24 Jan 2025 19:09:15 +0100
In-Reply-To: <20250115133106.3034445-3-shalini@linux.ibm.com>
References: <20250115133106.3034445-1-shalini@linux.ibm.com>
 <20250115133106.3034445-3-shalini@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 37j9R1mqlBfKP-JyMqqsMP-Hxjy8Y-Is
X-Proofpoint-GUID: 37j9R1mqlBfKP-JyMqqsMP-Hxjy8Y-Is
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-24_07,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0
 priorityscore=1501 impostorscore=0 clxscore=1015 lowpriorityscore=0
 bulkscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 spamscore=0
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501240125
Received-SPF: pass client-ip=148.163.158.5; envelope-from=nsg@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, 2025-01-15 at 14:31 +0100, Shalini Chellathurai Saroja wrote:
> This commit saves the state of CPI values in the guest and
> transfers this state during live migration of the guest.

IMO, using active voice and directly stating what is done is preferable.

Something like:
Register Control-Program Identifier data with the migration infrastructure.

"This commit" doesn't really add anything.
(Applies to other commits also)
I also prefer verbosity when it comes to abbreviations.

>=20
> Signed-off-by: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
> ---
>  hw/s390x/s390-virtio-ccw.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>=20
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index 35fb523af9..8fe0c5c1cb 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -259,6 +259,20 @@ static void s390_create_sclpconsole(SCLPDevice *sclp=
,
>      qdev_realize_and_unref(dev, ev_fac_bus, &error_fatal);
>  }
> =20
> +static const VMStateDescription vmstate_cpi =3D {
> +    .name =3D "s390_cpi",
> +    .version_id =3D 0,
> +    .minimum_version_id =3D 0,
> +    .fields =3D (const VMStateField[]) {
> +        VMSTATE_UINT8_ARRAY(system_type, Cpi, 8),
> +        VMSTATE_UINT8_ARRAY(system_name, Cpi, 8),
> +        VMSTATE_UINT64(system_level, Cpi),
> +        VMSTATE_UINT8_ARRAY(sysplex_name, Cpi, 8),
> +        VMSTATE_UINT64(timestamp, Cpi),
> +        VMSTATE_END_OF_LIST()

I see, you need the Cpi type here.
How about naming it ControlProgramId and renaming CPI
to ControlProgramIdMsg or similar?

With that sorted out:

Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>


