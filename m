Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26263C02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 17:41:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbNfr-00047P-7g; Fri, 24 Jan 2025 12:40:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1tbNfo-00045D-EM; Fri, 24 Jan 2025 12:40:53 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1tbNfm-0002zM-9t; Fri, 24 Jan 2025 12:40:52 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50OEGrDN013468;
 Fri, 24 Jan 2025 17:40:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Cn4oGS
 j36iqj/Qu/EBiNSXazZaUQvXMuZuHP2vjKSLs=; b=hs7vspi4htcns1r/a/u+s/
 VJm1bC0eWjpuiNr3LSXrW+xnR/nnOU7Fv9ONC5owNvtqsjI9tYLneg0f/RHCljCB
 10b+M1xgTIBnDPi/YinzfgSvy+ETDdrGTRCnJFb1iADEjixyWGSK5yzmODX01GJ1
 KUeABGQJZEF6xC4c9mAeu/V7LoszkXxMSfom7XslfXevMwPhy0rwtSkZNJX1hI+M
 OYXzSMpu0XrWjSieoAuT//e06F22z91rYU1tYEAHcvLrSIuZ46IuM21af5kTxfm8
 A5zdOaxE+cvRH31h2quhWmykh3Xp6V5SK4EYaPunfEecpFsbq6JQi3/SCunFNiLQ
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44c4p7uy1n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Jan 2025 17:40:46 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50OGhT71022384;
 Fri, 24 Jan 2025 17:40:45 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 448r4kmgga-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Jan 2025 17:40:45 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 50OHefg152822394
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 24 Jan 2025 17:40:41 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4ABE7200BA;
 Fri, 24 Jan 2025 17:40:41 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 05504200B7;
 Fri, 24 Jan 2025 17:40:41 +0000 (GMT)
Received: from li-978a334c-2cba-11b2-a85c-a0743a31b510.ibm.com (unknown
 [9.179.27.114]) by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 24 Jan 2025 17:40:40 +0000 (GMT)
Message-ID: <b7bae92a5d75cc1e94170c762e96a83fd23d154f.camel@linux.ibm.com>
Subject: Re: [PATCH v1 1/3] hw/s390x: add SCLP event type CPI
From: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
To: Shalini Chellathurai Saroja <shalini@linux.ibm.com>, qemu-s390x
 mailing list <qemu-s390x@nongnu.org>
Cc: qemu-devel mailing list <qemu-devel@nongnu.org>, Hendrik Brueckner
 <brueckner@linux.ibm.com>
Date: Fri, 24 Jan 2025 18:40:40 +0100
In-Reply-To: <20250115133106.3034445-1-shalini@linux.ibm.com>
References: <20250115133106.3034445-1-shalini@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: k6OKvMZ7XRw62SnK2Y1oDaPAqHAuzkty
X-Proofpoint-ORIG-GUID: k6OKvMZ7XRw62SnK2Y1oDaPAqHAuzkty
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-24_07,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxscore=0
 priorityscore=1501 adultscore=0 phishscore=0 clxscore=1011
 lowpriorityscore=0 mlxlogscore=808 bulkscore=0 malwarescore=0
 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501240122
Received-SPF: pass client-ip=148.163.156.1; envelope-from=nsg@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

Please swap patch 1 and 2 and incorporate the changes of write_event_data
into this patch.

Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>

See some minor nits below.

On Wed, 2025-01-15 at 14:31 +0100, Shalini Chellathurai Saroja wrote:
> This commit implements the SCLP event type Control-Program
> Identification in QEMU. Control-program is an IBM term for
> operating system. This event is used to send firmware
> program identifiers from KVM guest to SCLP. The program

This event is used to send information about the guest OS
to the host.

> identifiers provide data about the guest OS. The program
> identifiers are system type, system name, system level and

identifiers are: ...
> sysplex name.
>=20
> System type provides the OS type of the guest. System name
> provides the name of the guest. System level provides the
> distribution and kernel version of the guest OS.  Sysplex
> name provides sysplex name of the guest.

The system type provides the OS type of the guest (e.g. LINUX).
The system name provides the name of the guest (e.g. TESTVM).
The system level provides the distribution and kernel version of the guest =
OS (e.g. 0x50e00).
The sysplex name provides the sysplex name of the guest (e.g.=C2=A0SYSPLEX)=
.

>=20
> Signed-off-by: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
> ---
>  hw/s390x/event-facility.c         | 12 +++-
>  hw/s390x/meson.build              |  1 +
>  hw/s390x/sclpcpi.c                | 94 +++++++++++++++++++++++++++++++
>  include/hw/s390x/event-facility.h |  3 +
>  4 files changed, 109 insertions(+), 1 deletion(-)
>  create mode 100644 hw/s390x/sclpcpi.c
>=20
[...]
>=20
> diff --git a/hw/s390x/sclpcpi.c b/hw/s390x/sclpcpi.c
> new file mode 100644
> index 0000000000..64bc730f47
> --- /dev/null
> +++ b/hw/s390x/sclpcpi.c
> @@ -0,0 +1,94 @@
> +/*
> + * SCLP event type 11 - Control-Program Identification(CPI):
> + *    CPI is used to send program identifiers from control-program to th=
e SCLP.

...from the control-program...

> + *    The program identifiers provide data about Linux instance. It is n=
ot sent

... about the guest instance...

> + *    by the SCLP.
> + *
> + *    The program identifiers are system type, system name, sysplex name=
 and
> + *    system level. The system type, system name, and sysplex name use E=
BCDIC
> + *    ucharacters from this set: capital A-Z, 0-9, $, @, #, and blank. T=
he
> + *    system level is hex value.

... is a hex value...
(Well I guess it's just a number)

> + *
> + * Copyright IBM, Corp. 2024
> + *
> + * Authors:
> + *  Shalini Chellathurai Saroja <shalini@linux.ibm.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or (a=
t your
> + * option) any later version.  See the COPYING file in the top-level dir=
ectory.
> + *
> + */
> +
[...]

