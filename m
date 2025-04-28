Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB83CC3ABA4
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 12:05:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9NEi-000338-7j; Mon, 28 Apr 2025 08:05:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1u9NEX-0002xf-Ul; Mon, 28 Apr 2025 08:05:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1u9NES-0003aD-Kr; Mon, 28 Apr 2025 08:05:11 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53S8iS6t007086;
 Mon, 28 Apr 2025 12:05:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=7Vg1CD
 mGYOBsRxeJ4xt4Vhy6Jvl9S+ZgznYrQDa9tBs=; b=NrhmJVS0boiF3fprrXBu+6
 GxAseXRMRe8rTsWLbiSkm+B2mF05Sgs3JFFHrUCeQXnN4GRJmLWiG3Rr1oNyAEmy
 ezfgZcJGN3HPErsN12LgPz0sR+Zx5juucjF8cXCO+sxP/6cNq+QiPTPfNLRYSTcn
 rImfAx2cO1mF3E9cMT8RZGD83nuA+FDOA/GPzYfUKr/5dSKTfzvumzfRJT2YP/Nf
 /G/Oq0PeTi7RVPrLHdKjY9Wk4T33opJ0maXwJ1D7bvDD+31cdVZnIOGjQzGaHRwS
 TkefVISzTUueKtRPqFDjJ4XqruQrKbYqUyHuR4RSzPWn+QVSS3QbCqCpNg7dnnEg
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 469vqvjw23-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 28 Apr 2025 12:05:05 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53SBdIr2001830;
 Mon, 28 Apr 2025 12:05:04 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 469bame74d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 28 Apr 2025 12:05:04 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 53SC50e655836962
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 28 Apr 2025 12:05:00 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5D87420043;
 Mon, 28 Apr 2025 12:05:00 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2AE5C20040;
 Mon, 28 Apr 2025 12:05:00 +0000 (GMT)
Received: from li-978a334c-2cba-11b2-a85c-a0743a31b510.ibm.com (unknown
 [9.152.224.80]) by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 28 Apr 2025 12:05:00 +0000 (GMT)
Message-ID: <cabf1f945a3072e3eada75ceae828bd346855e9d.camel@linux.ibm.com>
Subject: Re: [PATCH v4 4/4] hw/s390x: compat handling for backward migration
From: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
To: Shalini Chellathurai Saroja <shalini@linux.ibm.com>, qemu-s390x mailing
 list <qemu-s390x@nongnu.org>, Thomas Huth <thuth@redhat.com>, Daniel
 Berrange <berrange@redhat.com>
Cc: qemu-devel mailing list <qemu-devel@nongnu.org>, Hendrik Brueckner
 <brueckner@linux.ibm.com>
Date: Mon, 28 Apr 2025 14:05:01 +0200
In-Reply-To: <20250410150934.1331433-5-shalini@linux.ibm.com>
References: <20250410150934.1331433-1-shalini@linux.ibm.com>
 <20250410150934.1331433-5-shalini@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI4MDA5MiBTYWx0ZWRfX/fubGJhfoZlw
 WollgOlCQRwHQtotfHKvyxwMEK1JuyvLNGMUTtVdQIdgAhJDOGYbXXRbpfaARyDAw73ogpwlJjE
 P6IGGfXWVbl5RQvM1cWdhJ03u4ZUal6Uj+ecHLmEkwv3iYMf33TyML48fp5SkPJI1qpdJ9axkoV
 qpBaEZQ2wdaEJ2inbYSdehgpGT58EYqaFN6laPHb4fSRFRK/37W3xxC9F2IINtSmaNwKWIbQbGO
 YESi+uGMb7Hdf200+I902K68bifkO1gRAkYOxmGaKofaD4aog4FYGhodd8qoSnS60LPr7iW5p/p
 alCGOQ54t3i7SNWevTPbC/PJSwhFt1E+49soTSGEAzB3Gfb4wPArTbolkQcavc6wUdWUC/7gmQh
 WL8OaR9H6Uxxa2KTaF8Fy7t6j0zBf7rxjrU1MnOpK394jVqpGzLj2rF8/gFUqnUhKOeBVCIt
X-Authority-Analysis: v=2.4 cv=AP4PelLR c=1 sm=1 tr=0 ts=680f6ef1 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VnNF1IyMAAAA:8 a=bwpn5bAzf_V3yRxoKHIA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: ype7PBLgiO2siJoJhh0MVCG6AOhjS9PM
X-Proofpoint-GUID: ype7PBLgiO2siJoJhh0MVCG6AOhjS9PM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-28_04,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 clxscore=1015 malwarescore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 spamscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504280092
Received-SPF: pass client-ip=148.163.158.5; envelope-from=nsg@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, 2025-04-10 at 17:09 +0200, Shalini Chellathurai Saroja wrote:
> Add Control-Program Identification (CPI) device to QOM only when the virt=
ual
> machine supports CPI. CPI is supported from "s390-ccw-virtio-10.0" machin=
e
> and higher.
>=20
> Signed-off-by: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
> ---
>  hw/s390x/s390-virtio-ccw.c         | 10 +++++++++-
>  include/hw/s390x/s390-virtio-ccw.h |  1 +
>  2 files changed, 10 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index 7f28cbd1de..81832ee638 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -274,6 +274,7 @@ static void s390_create_sclpcpi(SCLPDevice *sclp)
>  static void ccw_init(MachineState *machine)
>  {
>      MachineClass *mc =3D MACHINE_GET_CLASS(machine);
> +    S390CcwMachineClass *s390mc =3D S390_CCW_MACHINE_CLASS(mc);
>      S390CcwMachineState *ms =3D S390_CCW_MACHINE(machine);
>      int ret;
>      VirtualCssBus *css_bus;
> @@ -336,7 +337,10 @@ static void ccw_init(MachineState *machine)
>      s390_init_tod();
> =20
>      /* init SCLP event Control-Program Identification */
> -    s390_create_sclpcpi(ms->sclp);
> +    if (s390mc->use_cpi) {
> +        s390_create_sclpcpi(ms->sclp);
> +    }

Fixing this in a separate commit could be bad for bisecting.
You introduce use_cpi in an earlier commit set to false and
then flipping it in the migration patch for new machines.
This way there is no broken intermediate state.

I would also squash the compat migration changes into the previous
patch.

>  }
> =20
>  static void s390_cpu_plug(HotplugHandler *hotplug_dev,
> @@ -827,6 +831,7 @@ static void ccw_machine_class_init(ObjectClass *oc, v=
oid *data)
> =20
>      s390mc->hpage_1m_allowed =3D true;
>      s390mc->max_threads =3D 1;
> +    s390mc->use_cpi =3D true;
>      mc->reset =3D s390_machine_reset;
>      mc->block_default_type =3D IF_VIRTIO;
>      mc->no_cdrom =3D 1;
> @@ -955,6 +960,9 @@ static void ccw_machine_9_2_class_options(MachineClas=
s *mc)
>          { TYPE_S390_PCI_DEVICE, "relaxed-translation", "off", },
>      };
> =20
> +    S390CcwMachineClass *s390mc =3D S390_CCW_MACHINE_CLASS(mc);
> +    s390mc->use_cpi =3D false;
> +
>      ccw_machine_10_0_class_options(mc);
>      compat_props_add(mc->compat_props, hw_compat_9_2, hw_compat_9_2_len)=
;
>      compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
> diff --git a/include/hw/s390x/s390-virtio-ccw.h b/include/hw/s390x/s390-v=
irtio-ccw.h
> index 686d9497d2..fc4112fbf5 100644
> --- a/include/hw/s390x/s390-virtio-ccw.h
> +++ b/include/hw/s390x/s390-virtio-ccw.h
> @@ -55,6 +55,7 @@ struct S390CcwMachineClass {
>      /*< public >*/
>      bool hpage_1m_allowed;
>      int max_threads;
> +    bool use_cpi;
>  };
> =20
>  /* 1M huge page mappings allowed by the machine */

--=20
IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Wolfgang Wendt
Gesch=C3=A4ftsf=C3=BChrung: David Faller
Sitz der Gesellschaft: B=C3=B6blingen / Registergericht: Amtsgericht Stuttg=
art, HRB 243294

