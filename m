Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECD18C28B2E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 15:20:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tresD-00023D-4E; Mon, 10 Mar 2025 11:16:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shalini@linux.ibm.com>)
 id 1trers-0001mX-G8; Mon, 10 Mar 2025 11:16:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shalini@linux.ibm.com>)
 id 1trerm-0008VO-73; Mon, 10 Mar 2025 11:16:34 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52ADeUgM017855;
 Mon, 10 Mar 2025 15:16:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=ww+lYC
 BEw62dIq3QvSJ3TqGFT3xvbhBUsDJIYVwGPsk=; b=VDr39igRsRovR85TTlGygV
 RaVcd6nW2D/ziZf7qPyIzIu3Xd42/CsYcIIfjyyNjXdb585Crtcn7DuaKslGlZnh
 eOnuxSdr28OI7Wx6z2624V0Q4PviURng6m2EDm7ARXTM3xQjX2j9q3VszccuseVe
 ycYm9fEhgrOcnspjCeMOT9HJDbI48+jGLmJyNcFXLiDgN7EHwZOIm6MKnPT0goFI
 Y2dDEZAb8YMnTE0Ac1vbQdb2Rn7iriZbYizUnLxvh7yfpGlS6xiGaqgM4C+xxK+s
 gq3gcF2BilqEhUMJqDJRptBxGEyOWRFoTuxTVeA7BemuKAyt/ztuKSsjkd2nUtGQ
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 459rf939e7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 10 Mar 2025 15:16:25 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52AC0m0E014914;
 Mon, 10 Mar 2025 15:16:25 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4592ek6xwa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 10 Mar 2025 15:16:25 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 52AFGN5727984600
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 10 Mar 2025 15:16:23 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8751958059;
 Mon, 10 Mar 2025 15:16:23 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 01E3B58043;
 Mon, 10 Mar 2025 15:16:23 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 10 Mar 2025 15:16:22 +0000 (GMT)
MIME-Version: 1.0
Date: Mon, 10 Mar 2025 16:16:22 +0100
From: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Nina Schoetterl-Glausch <nsg@linux.ibm.com>, Thomas Huth
 <thuth@redhat.com>, qemu-s390x mailing list <qemu-s390x@nongnu.org>,
 qemu-devel mailing list <qemu-devel@nongnu.org>, Hendrik Brueckner
 <brueckner@linux.ibm.com>, "<Shalini Chellathurai Saroja"
 <shalini@linux.ibm.com>
Subject: Re: [PATCH qemu v2 1/3] hw/s390x: add CPI identifiers to QOM
In-Reply-To: <Z8nHlBnfcT7H87fB@redhat.com>
References: <20250224120449.1764114-1-shalini@linux.ibm.com>
 <48caabe7-c112-4454-96a8-742d154c77ee@redhat.com>
 <78b6c548212517ef8620fce0c6832e4f@imap.linux.ibm.com>
 <f64b5ce4-8843-4d92-af97-24160f687698@redhat.com>
 <98ab6ad416f0dcf7d1beb5105cace9ca46ad3c84.camel@linux.ibm.com>
 <Z8nHlBnfcT7H87fB@redhat.com>
Message-ID: <ca53c6eea802225a83f13559360d1264@linux.ibm.com>
X-Sender: shalini@linux.ibm.com
Organization: IBM Deutschland Research & Development GmbH
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: m-dECthUc9AHuxxPY1OW9YCi0KiHwoPW
X-Proofpoint-GUID: m-dECthUc9AHuxxPY1OW9YCi0KiHwoPW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-10_06,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 mlxscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503100117
Received-SPF: pass client-ip=148.163.156.1; envelope-from=shalini@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 2025-03-06 17:05, Daniel P. Berrangé wrote:
> On Thu, Mar 06, 2025 at 04:44:33PM +0100, Nina Schoetterl-Glausch 
> wrote:
>> On Thu, 2025-03-06 at 15:55 +0100, Thomas Huth wrote:
>> > On 06/03/2025 13.23, shalini wrote:
>> > > On 2025-03-05 16:56, Thomas Huth wrote:
>> > > > On 24/02/2025 13.04, Shalini Chellathurai Saroja wrote:
>> > > > > Add Control-Program Identification (CPI) to the QEMU Object
>> > > > > Model (QOM). The CPI identifiers provide information about
>> > > > > the guest operating system. The CPI identifiers are:
>> > > > > system type, system name, system level and sysplex name.
>> > > > >
>> > > > > The system type provides the OS type of the guest (e.g. LINUX).
>> > > > > The system name provides the name of the guest (e.g. TESTVM).
>> > > > > The system level provides the distribution and kernel version
>> > > > > of the guest OS (e.g. 0x50e00).
>> > > > > The sysplex name provides the sysplex name of the guest
>> > > > > (e.g. SYSPLEX).
>> > > > >
>> > > > > Signed-off-by: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
>> > > > > ---
>> > > > >   hw/s390x/s390-virtio-ccw.c         | 29 +++++++++++++++++++++++++++++
>> > > > >   include/hw/s390x/s390-virtio-ccw.h |  8 ++++++++
>> > > > >   qapi/machine.json                  | 24 ++++++++++++++++++++++++
>> > > > >   3 files changed, 61 insertions(+)
>> > > > >
>> > > > > diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
>> > > > > index 51ae0c133d..13ea8db1b0 100644
>> > > > > --- a/hw/s390x/s390-virtio-ccw.c
>> > > > > +++ b/hw/s390x/s390-virtio-ccw.c
>> > > > > @@ -50,6 +50,7 @@
>> 
>> [...]
>> 
>> > > > > +##
>> > > > > +{ 'struct': 'S390ControlProgramId', 'data': {
>> > > > > +     'system-type': 'str',
>> > > > > +     'system-name': 'str',
>> > > > > +     'system-level': 'str',
>> > > >
>> > > > Not sure, but would it make sense to use a number for the system-level
>> > > > instead? At least it's a number in ControlProgramId, not a string.
>> > > >
>> > >
>> > > The system-level, when interpreted as an int provides the output below
>> > >
>> > > 'system-level': 74872343805430528
>> > >
>> > > But the desired output below is obtained only when interpreted as a str.
>> > > please refer https://www.ibm.com/docs/en/linux-on-systems?
>> > > topic=identification-system-level for details on system-level. I will also
>> > > document this in the description of system-level as suggested by Daniel.
>> > > Thank you.
>> > >
>> > > 'system-level': '0x10a000000060b00'
>> >
>> > Well, the idea of QOM/QAPI is: It's an *API* for machines, not meant for
>> > direct consumption by the end user. So passing an integer as a string is not
>> > the right way here. For the user, you'd require some upper level instead
>> > that renders the integer in the right shape for the user. So please don't
>> > use a string for this at the QOM/QAPI level.
>> 
>> In a sense the system level is a bitfield.
>> So this could become a struct
>> 
>> {
>> 	'hypervisor-use' : true,
>> 	'distribution-id': 3,	// or an enum?
>> 	'distribution-version-major: 24,
>> 	...
>> }
> 
> Yes, if this is a mandatory format, breaking out the fields makes 
> sense.
> 
>> Not sure how to handle the 3 undefined bits in the highest byte.
> 
> If they're always left zero, might as well just omit them until
> such time as they have semantics defined (if ever)
> 

Hello Nina, Daniel,

The semantics as suggested by the split is applicable only if the 
system-type is LINUX. So, I will just change the system_level to int 
format.

Thank you.


> With regards,
> Daniel

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

