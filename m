Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46198C71136
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 07:16:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uR44U-00048l-5s; Mon, 16 Jun 2025 03:15:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shalini@linux.ibm.com>)
 id 1uR43P-0003EJ-RQ; Mon, 16 Jun 2025 03:14:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shalini@linux.ibm.com>)
 id 1uR43M-0000sd-1v; Mon, 16 Jun 2025 03:14:51 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55FNSga5005057;
 Mon, 16 Jun 2025 07:14:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=azy6xu
 AsWxqm0DK21a4aOvY4DZqdN0YbvOux1a1Rgfs=; b=khtHpqegwevB3Lil4XgiKO
 iWgbTJZ23HNDLSLoSKzkV7RIrySrqJTRyUHrgD/urMZe3BDCtIS1poBBrWgIfMfu
 c5I3stecm0owC2D/T7ckYdWNFiU/idZkv/7pfebjgNQd38cbp/9oNjksGkbTktz9
 Ics1BuVIMNAIwaMZiTL9OlX5UaAQnNonJqOPqLgezwIbg1FY1/S1bZNt+qXNU5fg
 QpVwicJR8MMYQ5TrQFtB30KpqKgMy//UGgiUdOfApgYNI8Ka55EuAeChHcqYPnXL
 HoX7GEB5AjEKYbmS5/NKk3Wyd82cqY58wBBiTdZg8NCXPPOkdBBPBBtcWGMWu2+g
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4790r1qyja-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Jun 2025 07:14:42 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55G60siK014267;
 Mon, 16 Jun 2025 07:14:41 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 479p424m4c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Jun 2025 07:14:41 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 55G7EdbG31523454
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 16 Jun 2025 07:14:39 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8136D58058;
 Mon, 16 Jun 2025 07:14:39 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2423258057;
 Mon, 16 Jun 2025 07:14:39 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 16 Jun 2025 07:14:39 +0000 (GMT)
MIME-Version: 1.0
Date: Mon, 16 Jun 2025 09:14:38 +0200
From: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
To: Nina Schotterl-Glausch <Nina.Schoetterl-Glausch@ibm.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 brueckner@linux.ibm.com, =?UTF-8?Q?Daniel_Berrang=C3=A9?=
 <berrange@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v5 2/3] hw/s390x: add Control-Program Identification to QOM
In-Reply-To: <3b95b9ad476e7ea1dd2afb95813f78a7680e7688.camel@ibm.com>
References: <20250603135655.595602-1-shalini@linux.ibm.com>
 <20250603135655.595602-3-shalini@linux.ibm.com>
 <9bf3dbd97aea3e8811e3064c4f1f79ab3ba65ecd.camel@linux.ibm.com>
 <581bb44f-6549-44cc-9466-ef4172fe6ddc@redhat.com>
 <3b95b9ad476e7ea1dd2afb95813f78a7680e7688.camel@ibm.com>
Message-ID: <d38f19752c6c91e087130cd52c292a97@linux.ibm.com>
X-Sender: shalini@linux.ibm.com
Organization: IBM Deutschland Research & Development GmbH
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: LtUY37lokKU32mJgmfdvCMgGvxKznEu9
X-Proofpoint-ORIG-GUID: LtUY37lokKU32mJgmfdvCMgGvxKznEu9
X-Authority-Analysis: v=2.4 cv=AqTu3P9P c=1 sm=1 tr=0 ts=684fc462 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=vTFfrk9CnFET2wp3WpgA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE2MDA0NCBTYWx0ZWRfX8AYKWxwOJZ4a
 s2/iBrY5tW1c6fVcmAhh+HThnr55luHN4/7v2AJHmnkyTkPOsYFACdKw8zXhPN0Cox2BFenCtMy
 IYuDFfZ+xSmZaAOfEHCxMGP6rddgyP7OG3bsYiV2cXWG+XOGttq3hcnmKWi8WtJQ901fSomQ/eT
 B6v7jxXA+cCdd5AFYYOyLx+pJCdcCTBVoKmqcCxSm+ic81dMamuaL7eFNvIf31yT/YTFqkHswzk
 YOS9pZw8FqJAYUYi68tJn5Ta8SSdpRNSqi2qURHsSyiw/U9mOmbBAdU32NFzgH4bncGsafcx19K
 ljgvddXN64aCy1r/Jrbysh9p5oGr03ir5FlMh61n10vIWqA+gWC4hM/eYVBqmVu0OpA6Z5Rt09n
 yrtvnGO8acCy0n39bz1qlAdFqh5ktpdhYO6b7PYJ7XZXkr+eg+MBF+w//NTbs7WmR/rwZUb0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-16_02,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015
 lowpriorityscore=0 suspectscore=0 adultscore=0 impostorscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 mlxscore=0 spamscore=0
 bulkscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506160044
Received-SPF: pass client-ip=148.163.158.5; envelope-from=shalini@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

On 2025-06-05 15:16, Nina Schotterl-Glausch wrote:
> On Thu, 2025-06-05 at 13:56 +0200, Thomas Huth wrote:
>> On 05/06/2025 10.34, Nina Schoetterl-Glausch wrote:
>> > On Tue, 2025-06-03 at 15:56 +0200, Shalini Chellathurai Saroja wrote:
>> > > Add Control-Program Identification (CPI) data to the QEMU Object
>> > > Model (QOM), along with the timestamp in which the data was received
>> > > as shown below.
>> >
>> > [...]
>> > >
>> > > Signed-off-by: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
>> > > ---
>> > >   hw/s390x/sclpcpi.c                | 47 +++++++++++++++++++++++++
>> > >   include/hw/s390x/event-facility.h |  5 +++
>> > >   qapi/machine.json                 | 58 +++++++++++++++++++++++++++++++
>> > >   3 files changed, 110 insertions(+)
>> > >
>> > > diff --git a/hw/s390x/sclpcpi.c b/hw/s390x/sclpcpi.c
>> > > index 935fa87acd..ec711e2291 100644
>> > > --- a/hw/s390x/sclpcpi.c
>> > > +++ b/hw/s390x/sclpcpi.c
>> > > @@ -15,7 +15,9 @@
>> > >     */
>> >
>> > [...]
>> > >
>> > > +static void cpi_init(Object *obj)
>> > > +{
>> > > +    SCLPEventCPI *e = SCLP_EVENT_CPI(obj);
>> > > +
>> > > +    object_property_add_str(obj, "system_type", get_system_type, NULL);
>> > > +    object_property_add_str(obj, "system_name", get_system_name, NULL);
>> > > +    object_property_add_str(obj, "sysplex_name", get_sysplex_name, NULL);
>> > > +    object_property_add_uint64_ptr(obj, "system_level", &(e->system_level),
>> > > +                                   OBJ_PROP_FLAG_READ);
>> > > +    object_property_add_uint64_ptr(obj, "timestamp", &(e->timestamp),
>> > > +                                   OBJ_PROP_FLAG_READ);
>> > > +}
>> >
>> > I think it would be cleaner if those were class properties.
>> > You could use object_class_property_add_str in cpi_class_init,
>> > but I think it'd be nice to use DEFINE_PROP_(STR|UINT64) and
>> > device_class_set_props.
>> 
>> For "normal" properties I'd say "yes" ... but in this case, this would 
>> also
>> allow the user to set the properties from the host side - which would 
>> be a
>> little bit weird? So I think it might be cleaner to keep it this way 
>> here
>> without the "setter" functions? WDYT?
> 
> Oh, yeah I didn't consider this.
> Still, object_class_property_add_str would be better I think, all 
> instances
> of the class should have these properties.
> 
Hello Nina,

Ok, I will use object_class_property_add_str and 
object_class_property_add methods instead.
Thank you.
> 
> [...]

-- 
Mit freundlichen Grüßen / Kind regards
Shalini Chellathurai Saroja
Software Developer
Linux on IBM Z & KVM Development
IBM Deutschland Research & Development GmbH
Dept 1419, Schoenaicher Str. 220, 71032 Boeblingen
Vorsitzender des Aufsichtsrats: Wolfgang Wendt
Geschäftsführung: David Faller
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht 
Stuttgart, HRB 243294

