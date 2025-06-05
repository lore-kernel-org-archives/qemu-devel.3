Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F134C5B543
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 08:48:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uN6FC-00059w-TC; Thu, 05 Jun 2025 04:46:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1uN6Ei-0004ff-Ql; Thu, 05 Jun 2025 04:46:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1uN6Ee-0001qi-Q8; Thu, 05 Jun 2025 04:46:08 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5558hHD3028846;
 Thu, 5 Jun 2025 08:46:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=pj68p8
 JQD4J1HZOfTDk8PbzVkKme7SXTopC5MNetVds=; b=EuvV6uJ861v4UTPb3MacUC
 r25yJ667SvS4yp2TlPgKIgbf6+jKnTSxJZXdlVNj66Eoo5dPVcia1pVKF30OTMMF
 /C1WpetOzb/cJa8kwHZEgyqs4tKS3LcupPTtfl+uhO5cgg6XILcg+mlpDa3BRi+Y
 iEYhqxYsxI9IOGCuDHAGYmrLHwOw6EySug+JFru0YGDikBVitnNFHsELIlCNzH9d
 8ZRRhz2BCZ8A3hsPafqcy2T3yolWnX7rclUeRuaH4lTEE9Fp05q9wGIv8R/qidKC
 THy8JDVAhrPJbX4pEVFhwJkaxtoSVURi6UePjibDDNsJcJFgA7dQwSyefe+sl2xw
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 471geyfp7c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Jun 2025 08:46:01 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5554fl0B012508;
 Thu, 5 Jun 2025 08:46:00 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 470et2kkfu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Jun 2025 08:46:00 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5558juMT34013750
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 5 Jun 2025 08:45:56 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 737E12004B;
 Thu,  5 Jun 2025 08:45:56 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 208C520040;
 Thu,  5 Jun 2025 08:45:56 +0000 (GMT)
Received: from li-978a334c-2cba-11b2-a85c-a0743a31b510.ibm.com (unknown
 [9.111.39.61]) by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  5 Jun 2025 08:45:56 +0000 (GMT)
Message-ID: <beb12864fd3571a929eba525fcb40f0619f32729.camel@linux.ibm.com>
Subject: Re: [PATCH v5 1/3] hw/s390x: add SCLP event type CPI
From: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
To: Shalini Chellathurai Saroja <shalini@linux.ibm.com>, qemu-s390x
 mailing list <qemu-s390x@nongnu.org>, Thomas Huth <thuth@redhat.com>
Cc: Daniel Berrange <berrange@redhat.com>, qemu-devel mailing list
 <qemu-devel@nongnu.org>, Hendrik Brueckner <brueckner@linux.ibm.com>
Date: Thu, 05 Jun 2025 10:45:55 +0200
In-Reply-To: <20250603135655.595602-2-shalini@linux.ibm.com>
References: <20250603135655.595602-1-shalini@linux.ibm.com>
 <20250603135655.595602-2-shalini@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 (3.56.1-1.fc42) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=ea09f6EH c=1 sm=1 tr=0 ts=68415949 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=d4LToudSVkjQPbQJ9YAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: L2zaBfgCmKY82Xh-7TdznkRGXo0IK9sn
X-Proofpoint-ORIG-GUID: L2zaBfgCmKY82Xh-7TdznkRGXo0IK9sn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA1MDA3NCBTYWx0ZWRfX9QGIBmaQR9hT
 KbBJPXZFgLrg7tX0qroA2bUDOFYALamU1c5YVP/wxhbX2DzOAa7CxyHcaeQ5wlV+ZaoIo6LE5j0
 OFEQS/TZWeBJ9/ZKiXmSjyuFdb09o+0a5+X3Mp4mkYP7yY28ElsdWnrIGtLda54h4JBo0O2+MWw
 S9s6XUBMC+HGee5Njrdyqj7460XVLfOpEtXXP+6yH4MycVKJ4QUEHnn0itrEF03PtmsziTsxn1a
 X9xmw/vvLKEzXdGbpVh9B+JM/QYzoGXwmxDRkJxxCZoeyU8fGlikAoI28SWh1rbZB4tiZjdy71A
 3kSkQUOUTtZxoLI0HYKmroaw7BkXmweG4XLR2gEhRn2UKDV+imtpz3O1uxC5T50hbcvPIO75/wH
 vuCMnYIB94VonNPjbNzJaKMsbt1yuugCeraZGne3llAxVgL9+t74Py9G+pYhoSoad4rUSc+H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-05_02,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 bulkscore=0
 spamscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 phishscore=0 mlxscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506050074
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

On Tue, 2025-06-03 at 15:56 +0200, Shalini Chellathurai Saroja wrote:
> Implement the Service-Call Logical Processor (SCLP) event
> type Control-Program Identification (CPI) in QEMU. This
> event is used to send CPI identifiers from the guest to the
> host. The CPI identifiers are: system type, system name,
> system level and sysplex name.
>=20
> System type: operating system of the guest (e.g. "LINUX").
> System name: user configurable name of the guest (e.g. "TESTVM").
> System level: distribution and kernel version, if the system type is Linu=
x
> (e.g. 0x50e00).
> Sysplex name: name of the cluster which the guest belongs to (if any)
> (e.g. "PLEX").
>=20
> The SCLP event CPI is supported only from "s390-ccw-virtio-10.1" machine
> and higher.
>=20
> Signed-off-by: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>

--=20
IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Wolfgang Wendt
Gesch=C3=A4ftsf=C3=BChrung: David Faller
Sitz der Gesellschaft: B=C3=B6blingen / Registergericht: Amtsgericht Stuttg=
art, HRB 243294

