Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A23FDCD3420
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 12:33:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slSih-00047D-K1; Tue, 03 Sep 2024 08:33:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1slSig-00046K-2W; Tue, 03 Sep 2024 08:33:14 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1slSid-0006Mw-MU; Tue, 03 Sep 2024 08:33:13 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 483BqSYh031122;
 Tue, 3 Sep 2024 12:33:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:subject:from:to:cc:date:in-reply-to:references
 :content-type:content-transfer-encoding:mime-version; s=pp1; bh=
 ry2LPYS3V9WJ9Kh++RuKMd1dC94w5RyMH9hA/ahPYPo=; b=PnLzWehlpgAN2GB/
 hzeA9xAppyu4660x32IWl23zgcVHUjFnqZ3hSrGXwo8/HctrKQGxfn2udcuKNOHM
 jeP0IWo3yE6B1cLdIwVzAhscOnfmdRmLH7vyJc9LLtY0TOSKWssEvywgli1ei8KW
 4ZDI2McvxrnWmWeg9XDfwOFXVUugODRbWiIGl0pV0+t9DKdNRzvj2q+qVWS8FaM2
 e9EJHD6sgAV1d0hFHZEsEJYdDA+qp3H9EDHXysYvRx6gWxD6+amisrg7aolKMEdo
 EOwmET1542I8YDgfgXtfVn0YICQBCcphlrUqPa7lrCdQ6fypiDCE0WNk1yxD5CC8
 xn6Qdw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41brkqp0tg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 03 Sep 2024 12:33:06 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 483CX6BA020145;
 Tue, 3 Sep 2024 12:33:06 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41brkqp0td-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 03 Sep 2024 12:33:06 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 483BI6ng012045;
 Tue, 3 Sep 2024 12:33:05 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41cegptq23-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 03 Sep 2024 12:33:05 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 483CX10l18481638
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 3 Sep 2024 12:33:01 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 843862004F;
 Tue,  3 Sep 2024 12:33:01 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B769D2004B;
 Tue,  3 Sep 2024 12:33:00 +0000 (GMT)
Received: from li-978a334c-2cba-11b2-a85c-a0743a31b510.ibm.com (unknown
 [9.171.92.164]) by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  3 Sep 2024 12:33:00 +0000 (GMT)
Message-ID: <1e9ecbc18d3afcf8199e80dd041cd8414678b9bd.camel@linux.ibm.com>
Subject: Re: [PATCH v2 01/11] hw/s390/ccw-device: Convert to three-phase reset
From: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=
 <philmd@linaro.org>, David Hildenbrand <david@redhat.com>, Ilya Leoshkevich
 <iii@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic
 <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Christian
 Borntraeger <borntraeger@linux.ibm.com>, Nico Boehr <nrb@linux.ibm.com>
Date: Tue, 03 Sep 2024 14:33:00 +0200
In-Reply-To: <20240830145812.1967042-2-peter.maydell@linaro.org>
References: <20240830145812.1967042-1-peter.maydell@linaro.org>
 <20240830145812.1967042-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SjPKuw4uen53Etf5yC-U8QXvS46v0IXA
X-Proofpoint-ORIG-GUID: DpUjjDrCkiM_H1gJ-Cj_46vSnfu66Sgt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-02_06,2024-09-03_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 clxscore=1015 mlxscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 adultscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2409030102
Received-SPF: pass client-ip=148.163.158.5; envelope-from=nsg@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Fri, 2024-08-30 at 15:58 +0100, Peter Maydell wrote:
> Convert the TYPE_CCW_DEVICE to three-phase reset. This is a
> device class which is subclassed, so it needs to be three-phase
> before we can convert the subclass.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>

> ---
>  hw/s390x/ccw-device.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/s390x/ccw-device.c b/hw/s390x/ccw-device.c
> index a7d682e5af9..14c24e38904 100644
> --- a/hw/s390x/ccw-device.c
> +++ b/hw/s390x/ccw-device.c
> @@ -44,9 +44,9 @@ static Property ccw_device_properties[] =3D {
>      DEFINE_PROP_END_OF_LIST(),
>  };
> =20
> -static void ccw_device_reset(DeviceState *d)
> +static void ccw_device_reset_hold(Object *obj, ResetType type)
>  {
> -    CcwDevice *ccw_dev =3D CCW_DEVICE(d);
> +    CcwDevice *ccw_dev =3D CCW_DEVICE(obj);
> =20
>      css_reset_sch(ccw_dev->sch);
>  }
> @@ -55,11 +55,12 @@ static void ccw_device_class_init(ObjectClass *klass,=
 void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
>      CCWDeviceClass *k =3D CCW_DEVICE_CLASS(klass);
> +    ResettableClass *rc =3D RESETTABLE_CLASS(klass);
> =20
>      k->realize =3D ccw_device_realize;
>      k->refill_ids =3D ccw_device_refill_ids;
>      device_class_set_props(dc, ccw_device_properties);
> -    dc->reset =3D ccw_device_reset;
> +    rc->phases.hold =3D ccw_device_reset_hold;
>      dc->bus_type =3D TYPE_VIRTUAL_CSS_BUS;
>  }
> =20


