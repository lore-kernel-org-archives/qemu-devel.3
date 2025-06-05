Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B707C5B543
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 13:20:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNAVa-0005Zm-Fe; Thu, 05 Jun 2025 09:19:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1uNAVY-0005Z6-19; Thu, 05 Jun 2025 09:19:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1uNAVW-0003nx-5a; Thu, 05 Jun 2025 09:19:47 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 555Am0hQ022848;
 Thu, 5 Jun 2025 13:19:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=/qZ450
 MzyPINNgy5xJxYx7RIihkYWhhRggHusYKvbpc=; b=VPLxMG92jQD4405UXpc1o0
 FLykQr6ZZOYYMSwSb5+G17SFNvZOUfesyXOHkBAuGF4znC/U3eb4mLQ+tenqOY7i
 Exs0fXkuFq8d2P22uNzmn69CeZJtSC6qZ88WbSYKFT3/p8uSI1VsiKjCJEK0CHRg
 1YPb3uX3iFxMLKTcOC2PrvA9EG1MUnvFNl3yGMIUnHaPL/xu36tmMGyd30H8CgYn
 +Xnzu/RfdPmEzLCg29KLN9VRLnxtIBEgVrNGmYHeSMajOvE5EVRHzycnkhbHStHD
 axp9p6wOSKXeivXZA9O089G/WPtr7a3rcLjXVHaE4ojcx7EVRCF7lUehWJ5Y4/nw
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 471gf00wfb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Jun 2025 13:19:42 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 555D8gew022534;
 Thu, 5 Jun 2025 13:19:41 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 470c3tn1g1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Jun 2025 13:19:41 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 555DJb8V35324382
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 5 Jun 2025 13:19:37 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7FE8520043;
 Thu,  5 Jun 2025 13:19:37 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1CDBB20040;
 Thu,  5 Jun 2025 13:19:37 +0000 (GMT)
Received: from li-978a334c-2cba-11b2-a85c-a0743a31b510.ibm.com (unknown
 [9.111.89.238]) by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  5 Jun 2025 13:19:37 +0000 (GMT)
Message-ID: <64495f006100dfd615009a0862a5e6aab6a697b1.camel@linux.ibm.com>
Subject: Re: [PATCH v5 2/3] hw/s390x: add Control-Program Identification to QOM
From: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>, Shalini Chellathurai Saroja
 <shalini@linux.ibm.com>, qemu-s390x mailing list <qemu-s390x@nongnu.org>
Cc: Daniel Berrange <berrange@redhat.com>, qemu-devel mailing list
 <qemu-devel@nongnu.org>, Hendrik Brueckner <brueckner@linux.ibm.com>
Date: Thu, 05 Jun 2025 15:19:36 +0200
In-Reply-To: <00c7e7f0-1c94-4f6f-aa08-5e557bbb91aa@redhat.com>
References: <20250603135655.595602-1-shalini@linux.ibm.com>
 <20250603135655.595602-3-shalini@linux.ibm.com>
 <9bf3dbd97aea3e8811e3064c4f1f79ab3ba65ecd.camel@linux.ibm.com>
 <581bb44f-6549-44cc-9466-ef4172fe6ddc@redhat.com>
 <00c7e7f0-1c94-4f6f-aa08-5e557bbb91aa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 (3.56.1-1.fc42) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Pq2TbxM3 c=1 sm=1 tr=0 ts=6841996e cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=ZiMIAIO6AAAA:8
 a=VnNF1IyMAAAA:8 a=x4kxwI2lhZTCVj833_4A:9
 a=QEXdDO2ut3YA:10 a=KohFQSMcaiS2QNUyYz07:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA1MDExMSBTYWx0ZWRfXw/WnYfExV5Mo
 DiP1D8IcgwZPJGfS0gb4wzc4IBVvxjTL+YGw8652rEpvUa3miBsH5+UpD6W6F4Cy2Nm80MW3Rmf
 QUVRV/XIrCf88TFP4zRgIuVX5MDN02cyt1vq+liLI8J/pdxUJ+e67kb8hKtxrHgoiEIA4SMqvli
 Hb/DZ+SRG+zeigPKwyzUrM3wqYD+Q7vjmEiqQ+cGwdqWtyWzhNMQkUkIiKRjU+kgogiqm1L/cr+
 52IE1oqRMHUF/9XZ6byD8EjfKz0Ds7pNeSpFmb0/QzHL4d+3GpohmSZfGSZoqcMfRsJIOAJY56s
 0Xoil9Ue9C/iLuEVMlHGSBJy9lvNfPBcSAVN7q0OZtpLLVrK+gEkBIylx4df3JufJZWhdRyN0HI
 23KbJW6RnMks1f1zUG3xv1ItnD6LkkivrrH/jw6tXNroCfxISgpCB2Cl/x9SynWr//XWEEau
X-Proofpoint-GUID: jwwgqmegUamJ4cmV-JbmjG3jDOEd5ely
X-Proofpoint-ORIG-GUID: jwwgqmegUamJ4cmV-JbmjG3jDOEd5ely
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-05_02,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 mlxlogscore=759
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 mlxscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506050111
Received-SPF: pass client-ip=148.163.156.1; envelope-from=nsg@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

On Thu, 2025-06-05 at 14:03 +0200, Thomas Huth wrote:
> On 05/06/2025 13.56, Thomas Huth wrote:
> > On 05/06/2025 10.34, Nina Schoetterl-Glausch wrote:
> > > On Tue, 2025-06-03 at 15:56 +0200, Shalini Chellathurai Saroja wrote:
> > > > Add Control-Program Identification (CPI) data to the QEMU Object
> > > > Model (QOM), along with the timestamp in which the data was receive=
d
> > > > as shown below.
> > >=20
> > > [...]
> > > >=20
> > > > Signed-off-by: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
> > > > ---

[...]
>=20
> PS: FWIW, Markus recently also provided a nice summery about the differen=
t=20
> property types here:
>   https://lore.kernel.org/qemu-devel/87o6vfzdig.fsf@pond.sub.org/

Thanks!

> This Property part of qdev isn't actually device-specific.  We could
> lift it into Object.  But would that be an improvement?  I'm not sure;
> QOM is confusing enough as it is.

:D indeed it is.

--=20
IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Wolfgang Wendt
Gesch=C3=A4ftsf=C3=BChrung: David Faller
Sitz der Gesellschaft: B=C3=B6blingen / Registergericht: Amtsgericht Stuttg=
art, HRB 243294

