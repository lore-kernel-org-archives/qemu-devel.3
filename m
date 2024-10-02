Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5804CF31AE
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 10:14:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svwMA-0006t7-CL; Wed, 02 Oct 2024 06:13:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhartmay@linux.ibm.com>)
 id 1svwM9-0006sn-4j; Wed, 02 Oct 2024 06:13:17 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhartmay@linux.ibm.com>)
 id 1svwM7-0007aY-9Q; Wed, 02 Oct 2024 06:13:16 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4929w58t024840;
 Wed, 2 Oct 2024 10:13:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:in-reply-to:references:date:message-id
 :mime-version:content-type:content-transfer-encoding; s=pp1; bh=
 JqeOownoJkrK4xDeMvarkkxd5WSV8j2IIuD8hQoEheQ=; b=Dj7o5A6zEw7UAv34
 vKEO49x5wVY+fIqTmz/aGC1ZxwZ9/pGRqQoZA55N3YMFIa9RPeJQevG8p74gjzbI
 VqEg7rSc32WSmDP8sq48OQF+FNNnUXZ4n0B6YdO75ym6DI1GMrtbQlsRq871/AmI
 3O0jOlKGdVDzsXHSaLsN+H6KXKE1hjNKkPGT9eu+vL3TQdvhRpvdRbh+ZE5LD6vs
 M9OltDBj64GBi6qYMMudRzrIwTFeagdjijZRCteHUp/k174FMaq2B3Lo07HOTNdg
 mfjs3TpX2Eq/bgQ3bnQGsQ9b9XpPwuZ599K1LFHHhI6fF9D42+kGoTsAuCSAQGS8
 p4bZEQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4213gpg6km-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 02 Oct 2024 10:13:12 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 492ADCkZ024263;
 Wed, 2 Oct 2024 10:13:12 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4213gpg6kj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 02 Oct 2024 10:13:12 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4929sMYv007947;
 Wed, 2 Oct 2024 10:13:11 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41xvgy1r2s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 02 Oct 2024 10:13:10 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 492AD52657672118
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 2 Oct 2024 10:13:05 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E748620043;
 Wed,  2 Oct 2024 10:13:04 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8CD4B20040;
 Wed,  2 Oct 2024 10:13:04 +0000 (GMT)
Received: from li-1de7cd4c-3205-11b2-a85c-d27f97db1fe1.ibm.com (unknown
 [9.171.80.96]) by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Wed,  2 Oct 2024 10:13:04 +0000 (GMT)
From: "Marc Hartmayer" <mhartmay@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x <qemu-s390x@nongnu.org>, Christian Borntraeger
 <borntraeger@de.ibm.com>, Jens Remus <jremus@linux.ibm.com>
Subject: Re: [PATCH v1 0/3] pc-bios/s390-ccw: Small Makefile improvements
In-Reply-To: <7bf7a119-1878-4e47-9004-13ccbf7110e6@redhat.com>
References: <20241001153618.17791-1-mhartmay@linux.ibm.com>
 <7bf7a119-1878-4e47-9004-13ccbf7110e6@redhat.com>
Date: Wed, 02 Oct 2024 12:13:03 +0200
Message-ID: <875xqaq0cw.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: DmcH3AUqzBpR7EWvdsGz0uLzTdYPetk7
X-Proofpoint-ORIG-GUID: iYcxdelrMg2zSx3DW30TMXjN7_3WwDKh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-02_09,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 adultscore=0 clxscore=1015 impostorscore=0 mlxscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2410020073
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=mhartmay@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Oct 02, 2024 at 11:57 AM +0200, Thomas Huth <thuth@redhat.com> wrot=
e:
> On 01/10/2024 17.36, Marc Hartmayer wrote:
>>=20
>> Jens Remus (2):
>>    pc-bios/s390-ccw: Clarify alignment is in bytes
>>    pc-bios/s390-ccw: Don't generate TEXTRELs
>>=20
>> Marc Hartmayer (1):
>>    pc-bios/s390-ccw: Introduce `EXTRA_LDFLAGS`
>>=20
>>   pc-bios/s390-ccw/netboot.mak |  2 +-
>>   pc-bios/s390-ccw/Makefile    |  5 +++--
>>   pc-bios/s390-ccw/start.S     | 11 +++++++----
>>   3 files changed, 11 insertions(+), 7 deletions(-)
>
> Series
> Reviewed-by: Thomas Huth <thuth@redhat.com>

Thanks.

>
> I'll queue it ... but will likely wait with sending a merge request for a=
=20
> while to see whether other s390-ccw bios patches will be ready within the=
=20
> next weeks (so that I don't have to build the s390-ccw.img multiple times=
=20
> within a release cycle)

Makes sense.

>
>   Thomas
>
>
--=20
Kind regards / Beste Gr=C3=BC=C3=9Fe
   Marc Hartmayer

IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Wolfgang Wendt
Gesch=C3=A4ftsf=C3=BChrung: David Faller
Sitz der Gesellschaft: B=C3=B6blingen
Registergericht: Amtsgericht Stuttgart, HRB 243294

