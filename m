Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D80DEFCE53
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 02:31:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxyTe-0007fI-J9; Wed, 04 Mar 2026 21:30:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1vxyTZ-0007ee-IJ; Wed, 04 Mar 2026 21:30:09 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1vxyTY-0001Fw-0L; Wed, 04 Mar 2026 21:30:09 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 624DFEN61761459; Thu, 5 Mar 2026 02:30:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=pMc82+
 7pKsBqa1xScFO7+skilTk9d9SKZ3dkPZQSklY=; b=jYMwqkqLCbd//me/1FGQ3D
 6/dVVgJ4p8aZwXarXNT1XjDGa0tOqskoZZO+R9TqkoVE7+YEEiIEaV/mkP6eU/AO
 dvSjunUD5Iuodct/+tq/t9Drjs5jPFD9PZZUtmu+OvqMjN7A43if62jyLDz52SPN
 B+ygCUOjyfBEVB9ochG3Xw7MOe3F8x0OvsucDyZb8xxOAzFpgHiY7wzw7A136sL9
 3DenkkKkBlX1/pNr/1gPBsvGBO8JScxO2w6fTrI40LRXsDnj0PlMlHVyi/yFs462
 3rX+Nl7sR8GyHdsrMXU66Y613S6xlYQfupNpXgyTjMufHrgq2saT12zqX0tdb9jA
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cksjdhwkk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Mar 2026 02:30:02 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6252LkBD008769;
 Thu, 5 Mar 2026 02:30:01 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cmdd1h0qa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Mar 2026 02:30:01 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6252U0P032244306
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 5 Mar 2026 02:30:00 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E90C458145;
 Thu,  5 Mar 2026 02:29:59 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5A0E358144;
 Thu,  5 Mar 2026 02:29:58 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.133.56]) by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  5 Mar 2026 02:29:58 +0000 (GMT)
Message-ID: <f963a6619ef76e60fb1417fd497307841b62881a.camel@linux.ibm.com>
Subject: Re: [PATCH v3 16/18] hw/s390x/css: drop use of .err_hint for vmstate
From: Eric Farman <farman@linux.ibm.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, peterx@redhat.com
Cc: farosas@suse.de, qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Farhan Ali <alifm@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, Richard
 Henderson <richard.henderson@linaro.org>, Ilya Leoshkevich
 <iii@linux.ibm.com>, David Hildenbrand	 <david@kernel.org>, Matthew Rosato
 <mjrosato@linux.ibm.com>, "open list:S390 channel subs..."
 <qemu-s390x@nongnu.org>
Date: Wed, 04 Mar 2026 21:29:57 -0500
In-Reply-To: <20260304212303.667141-17-vsementsov@yandex-team.ru>
References: <20260304212303.667141-1-vsementsov@yandex-team.ru>
 <20260304212303.667141-17-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=M9BA6iws c=1 sm=1 tr=0 ts=69a8eaaa cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=6R7veym_AAAA:8
 a=VnNF1IyMAAAA:8 a=qlzTgSgKFU-KgPLnRtkA:9 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19
 a=QEXdDO2ut3YA:10 a=ILCOIF4F_8SzUMnO7jNM:22
X-Proofpoint-ORIG-GUID: Ov24qNuOYXkAmyIrL66g4LuYfHGpilHb
X-Proofpoint-GUID: Ov24qNuOYXkAmyIrL66g4LuYfHGpilHb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDAxNiBTYWx0ZWRfXyJubr7/PpH7d
 4VN7gLcrpjf5lX8yOj6JPmxgLyQrST2e4EJLbei/qeFnOemTANvDKzmolHrs5JTo2BkYTJKTkGi
 aYtZaAJSMjyXHOH2OfUTB8KDGjFO7fwDNvW4OZzUH6w9wFZ6HFdSYH1uMLNesMKDGRfW90kSBVq
 89Jkv/w4dgwhSGSA255Rxa2i4DkNfeOB73Bzb7aD9FwvrJyij+3s7fqPbJooToZwkk0XBwg0l13
 iQzL64Gy0CJXVflxPW8lbqeX66MG1L03LPZYvd8+jGKQALjaHPKY5G4veqLczA9yJr3qvCrA0L2
 szpTAqbFUlCs9l5ZwoHPc1LwRIxVZjGZP91jGGfLrrLV8Cr9kyo068u594IB8+TxNap+T+54OeO
 UGajh3nBvHB1Yx4BMRNOUPfu20kdJPn67iSdWnz2RFYf1Uu22DL/eaPgTb9B+nW9zIGCxA9HwGL
 flvu9JhefH34n/s1alw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_09,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603050016
Received-SPF: pass client-ip=148.163.156.1; envelope-from=farman@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, 2026-03-05 at 00:23 +0300, Vladimir Sementsov-Ogievskiy wrote:
> That's the only usage through the whole base. Doesn't
> worth keeping the whole complexity. And 2.7 machines were
> long ago.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  hw/s390x/css.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)

Agreed that the two "Bug!" hints aren't helpful, and the devno hint is prob=
ably offering more
confusion than anything else.

Reviewed-by: Eric Farman <farman@linux.ibm.com>

>=20
> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
> index 04ce3178a0b..df5f0bc27f1 100644
> --- a/hw/s390x/css.c
> +++ b/hw/s390x/css.c
> @@ -192,10 +192,6 @@ static const VMStateDescription vmstate_schdev_orb =
=3D {
>  static int subch_dev_post_load(void *opaque, int version_id);
>  static int subch_dev_pre_save(void *opaque);
> =20
> -const char err_hint_devno[] =3D "Devno mismatch, tried to load wrong sec=
tion!"
> -    " Likely reason: some sequences of plug and unplug  can break"
> -    " migration for machine versions prior to  2.7 (known design flaw)."=
;
> -
>  const VMStateDescription vmstate_subch_dev =3D {
>      .name =3D "s390_subch_dev",
>      .version_id =3D 1,
> @@ -203,10 +199,15 @@ const VMStateDescription vmstate_subch_dev =3D {
>      .post_load =3D subch_dev_post_load,
>      .pre_save =3D subch_dev_pre_save,
>      .fields =3D (const VMStateField[]) {
> -        VMSTATE_UINT8_EQUAL(cssid, SubchDev, "Bug!"),
> -        VMSTATE_UINT8_EQUAL(ssid, SubchDev, "Bug!"),
> +        VMSTATE_UINT8_EQUAL(cssid, SubchDev, NULL),
> +        VMSTATE_UINT8_EQUAL(ssid, SubchDev, NULL),
>          VMSTATE_UINT16(migrated_schid, SubchDev),
> -        VMSTATE_UINT16_EQUAL(devno, SubchDev, err_hint_devno),
> +        /*
> +         * If devno mismatch on target, it may be due to some
> +         * sequences of plug and unplug breaks migration for
> +         * machine versions prior to 2.7 (known design flaw).
> +         */
> +        VMSTATE_UINT16_EQUAL(devno, SubchDev, NULL),
>          VMSTATE_BOOL(thinint_active, SubchDev),
>          VMSTATE_STRUCT(curr_status, SubchDev, 0, vmstate_schib, SCHIB),
>          VMSTATE_UINT8_ARRAY(sense_data, SubchDev, 32),

