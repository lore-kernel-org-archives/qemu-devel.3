Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AEE3C531F9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 13:31:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnFzL-0001Sk-2i; Fri, 24 Jul 2026 09:30:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1wnFzJ-0001Ry-51; Fri, 24 Jul 2026 09:30:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1wnFzH-0007C2-Jm; Fri, 24 Jul 2026 09:30:52 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66ODC4VT1835044; Fri, 24 Jul 2026 13:30:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=HJ8p/T
 M06QQAFzZ38ag+IpGL5bSSrx7H0l3+a0lodDg=; b=cchUq4t4Lt/c5frURRYU7Z
 nH0tEX1Egb1AJbeC5VdmvNpM8/QIEgmrGXwnHflnNzLgybGx+VImq94Xp0DhJOH/
 U7AqGp8Ip7k3Trkmj9Fqe4pnRwl5TtVB9v6SSbWorWNxkuVMiIebOMCn481EZDnL
 0CNM8KPxH5DlWP6S9Du/AadEogbMLtylohCwvIqYFPdJe0mg1TgBdSckbhyHc7LS
 7lzk8WmwpbL7SCx4E1aoIbFzCvnZSFwn7UyVbzEVJeElnCd3FqjGobUvAXGXr6gH
 QPIyiONYXbfhxIP/8Pf7h1H5gTD6dZ6vLmEjPAZgkx4jVCr6FlaFC6bqiDooKuvw
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77km8w6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Jul 2026 13:30:49 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66ODJfdM024691;
 Fri, 24 Jul 2026 13:30:49 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgmtk9291-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Jul 2026 13:30:48 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66ODUiFZ21824184
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 24 Jul 2026 13:30:45 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DB56220074;
 Fri, 24 Jul 2026 13:30:44 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9B098200B4;
 Fri, 24 Jul 2026 13:30:42 +0000 (GMT)
Received: from shivang.upadyay (unknown [9.39.21.214])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 24 Jul 2026 13:30:42 +0000 (GMT)
Message-ID: <2da971b00afc1460b48c2260b366ce6f78fb6fc7.camel@linux.ibm.com>
Subject: Re: [PATCH] tests/functional/ppc: skip remote interrupts test if
 -net user not built
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: adityag@linux.ibm.com, amachhiw@linux.ibm.com, harshpb@linux.ibm.com,
 milesg@linux.ibm.com, npiggin@gmail.com
Date: Fri, 24 Jul 2026 19:00:25 +0530
In-Reply-To: <3295a8fa-b7c3-4502-a5cd-3dbb67083c19@redhat.com>
References: <20260724085440.520125-1-shivangu@linux.ibm.com>
 <3295a8fa-b7c3-4502-a5cd-3dbb67083c19@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=HJXz0Itv c=1 sm=1 tr=0 ts=6a636909 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=a-YK2fyEdcK8M2ktA50A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDExOSBTYWx0ZWRfXzr+8+MO5VESl
 DjB+vueGBDhonZNpCYX7wpCkAochrR7ZAd3gTGvEihCaTpz2D4FsfCFkPwPxYbRFSTLY7WVbF+c
 4jtC0PJbZGEcU0tovKoQRb6T/OqgJWohdS+dwCvbEexyfb7QD6LAEawII//scyXd3UmXTwOjPg9
 I639N1eiWbyws0Z7W//jErZDo7g+MDXlxgoZ1IMABhCWytVRRXEeTJXpaS6+NFyYKf74Aj29x99
 C24O+7S7mICKLA4zfPkvIWmhycETLSCIe4nCqBg1Aa3SDv9ovRDBdHqN9LF49ilUaQ3elVprRCQ
 ogFQFmzhMkxjN5ofoN6ONJzjPjTsazCd9WSSAcOiPgLI+0QEc2Y/S19ZOh4TgPm2Xqhsb2Mzuxw
 InGVUlcyjlU7OGEqQq0BLwcuxntJNz5TgvksjVBzymAuZyeRHXDwrOpwjwIVpqy6PvcVg2cP3yg
 qs63jOy0wbGjZZisXoA==
X-Proofpoint-ORIG-GUID: 4pm0v95waWZ3QyS2b0JLKbXGC53kvwRB
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDExOSBTYWx0ZWRfXxCTKXw0Qb41p
 KDfxaOhUqiompC0IbSgg8AXjiPjpRrvXPUbgs+EGupGhYgzfMTVQHCMq2MrKIdaZrajNi3qznJm
 d7snuqfMrgLrbsVJItNg2V869i9+EYA=
X-Proofpoint-GUID: Nled6FNltMoQOJVjWEIVoIqdjVrBsDCX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_03,2026-07-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607240119
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=shivangu@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

On Fri, 2026-07-24 at 11:02 +0200, Thomas Huth wrote:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # Wait for=
 boot to complete
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 console_pa=
ttern =3D 'CPU maps initialized for 1 thread per
> > core'
>=20
> Please use self.require_netdev('user') instead, like it is already
> done in=20
> other tests.
>=20
> =C2=A0 Thanks,
> =C2=A0=C2=A0=C2=A0 Thomas


Thanks Thomas, I didn't see this case. I saw some other tests using
VMLaunchFailure this way, so went ahead like this. I'll send a
revision.

~Shivang.

