Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08B43C19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 15:23:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqZXM-0004Gj-7E; Fri, 07 Mar 2025 10:22:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shalini@linux.ibm.com>)
 id 1tqZXI-0004FW-HN; Fri, 07 Mar 2025 10:22:52 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shalini@linux.ibm.com>)
 id 1tqZXG-0007Vf-Jm; Fri, 07 Mar 2025 10:22:52 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 527E38je028483;
 Fri, 7 Mar 2025 15:22:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=tC1sNL
 lnSJVvokfCSBPMfrC30pxEBMcgR73v/yvQXIE=; b=OnWeBPAba5mwI5c+XYh+xS
 l+saL1FtmRCCNEaEfLNX10BdWPcbn+A6BNk0gTHNForI2F1ectO4lrTNtAy3bMl+
 OXRTVW/xH42sGg7UUJkOmbU5DKCIQRP/bYu7wbY5lAxMZ7Biv+3K/hCg/QCp1lz+
 HxMqrpZoIJcWKsMC4ZWXJ59+SnQastFMJ4wTKCmFOnlresRb9sXuS19YVfXGA1L5
 r3GGHSTtgvD4P5QCM70ga56a1WnGEI7vMd3yCynDx7Tl1qtOYVaG1OY/DfZdw5H8
 xHmPlWy+LUQTbLzSLC3nph0FgK6/6N5wfnL4KWrSd+fNdVKpHw9satcehcYLmcZg
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45827p8ddh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 07 Mar 2025 15:22:47 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 527Ekaua032243;
 Fri, 7 Mar 2025 15:22:46 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 454cjtfr2t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 07 Mar 2025 15:22:46 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 527FMjTx29360866
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 7 Mar 2025 15:22:45 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5C94D5803F;
 Fri,  7 Mar 2025 15:22:45 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D094858054;
 Fri,  7 Mar 2025 15:22:44 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  7 Mar 2025 15:22:44 +0000 (GMT)
MIME-Version: 1.0
Date: Fri, 07 Mar 2025 16:22:44 +0100
From: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-s390x mailing list <qemu-s390x@nongnu.org>, qemu-devel mailing list
 <qemu-devel@nongnu.org>, Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>, Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH qemu v2 1/3] hw/s390x: add CPI identifiers to QOM
In-Reply-To: <Z8m5pV0kPIfp2jo2@redhat.com>
References: <20250224120449.1764114-1-shalini@linux.ibm.com>
 <Z8h2hNFlNvjWWHqd@redhat.com>
 <b44e0b46f69ee6f86a15ecabecd6942c@imap.linux.ibm.com>
 <Z8m5pV0kPIfp2jo2@redhat.com>
Message-ID: <ccfdc0de96646f09f1c7211bdea261c1@linux.ibm.com>
X-Sender: shalini@linux.ibm.com
Organization: IBM Deutschland Research & Development GmbH
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: AFujJSBwhqlNpsDXdRjv5xmfG02cSB6Y
X-Proofpoint-GUID: AFujJSBwhqlNpsDXdRjv5xmfG02cSB6Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-07_06,2025-03-06_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 impostorscore=0 bulkscore=0 clxscore=1011 spamscore=0 mlxlogscore=999
 malwarescore=0 lowpriorityscore=0 phishscore=0 adultscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503070111
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

On 2025-03-06 16:06, Daniel P. Berrangé wrote:
> BTW, your email client is possibly mis-configured - your mail
> came through with "From: shalini <shalini@imap.linux.ibm.com>"
> and attempting to reply to that gets an error saying that
> 'imap.linux.ibm.com' does not exist.
> 

Hello Daniel,
Thank you very much for pointing this out. I have fixed it.

> On Thu, Mar 06, 2025 at 02:55:27PM +0100, shalini wrote:
>> On 2025-03-05 17:06, Daniel P. Berrangé wrote:
>> > On Mon, Feb 24, 2025 at 01:04:47PM +0100, Shalini Chellathurai Saroja
>> > wrote:
>> > > Add Control-Program Identification (CPI) to the QEMU Object
>> > > Model (QOM). The CPI identifiers provide information about
>> > > the guest operating system. The CPI identifiers are:
>> > > system type, system name, system level and sysplex name.
>> > >
>> > > The system type provides the OS type of the guest (e.g. LINUX).
>> > > The system name provides the name of the guest (e.g. TESTVM).
>> > > The system level provides the distribution and kernel version
>> > > of the guest OS (e.g. 0x50e00).
>> > > The sysplex name provides the sysplex name of the guest
>> > > (e.g. SYSPLEX).
>> > >
>> > > Signed-off-by: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
>> > > ---
>> > >  hw/s390x/s390-virtio-ccw.c         | 29 +++++++++++++++++++++++++++++
>> > >  include/hw/s390x/s390-virtio-ccw.h |  8 ++++++++
>> > >  qapi/machine.json                  | 24 ++++++++++++++++++++++++
>> > >  3 files changed, 61 insertions(+)
>> > >
>> > > diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
>> > > index 51ae0c133d..13ea8db1b0 100644
>> > > --- a/hw/s390x/s390-virtio-ccw.c
>> > > +++ b/hw/s390x/s390-virtio-ccw.c
>> > > @@ -50,6 +50,7 @@
>> > >  #include "hw/s390x/virtio-ccw-md.h"
>> > >  #include "system/replay.h"
>> > >  #include CONFIG_DEVICES
>> > > +#include "qapi/qapi-visit-machine.h"
>> > >
>> > >  static Error *pv_mig_blocker;
>> > >
>> > > @@ -803,6 +804,26 @@ static void machine_set_loadparm(Object *obj,
>> > > Visitor *v,
>> > >      s390_ipl_fmt_loadparm(ms->loadparm, val, errp);
>> > >  }
>> > >
>> > > +static void machine_get_control_program_id(Object *obj, Visitor *v,
>> > > +                                           const char *name, void
>> > > *opaque,
>> > > +                                           Error **errp)
>> > > +{
>> > > +    S390CcwMachineState *ms = S390_CCW_MACHINE(obj);
>> > > +    S390ControlProgramId *cpi;
>> > > +    cpi = &(S390ControlProgramId){
>> > > +        .system_type = g_strndup((char *) ms->cpi.system_type,
>> > > +                       sizeof(ms->cpi.system_type)),
>> > > +        .system_name = g_strndup((char *) ms->cpi.system_name,
>> > > +                       sizeof(ms->cpi.system_name)),
>> > > +        .system_level = g_strdup_printf("0x%lx",
>> > > ms->cpi.system_level),
>> >
>> > If the data is an integer, we must return it in QMP as an integer,
>> > not formatted into a hex string.
>> >
>> 
>> Hello Daniel,
>> 
>> Thank you very much for the review.
>> 
>> The system-level, when interpreted as an int provides the output below
>> 
>> 'system-level': 74872343805430528
> 
> Yes, that is correct from a QMP design POV. Data should formatted
> in the most appropriate way for machines to consume, using native
> JSON data types.
> 
>> But the desired output below is obtained only when interpreted as a 
>> str.
>> 
>> 'system-level': '0x10a000000060b00'
> 
> If a human wants to read the data in hex format, that should be
> formatted by whatever tool is consuming the data from QMP and
> presenting it in the user.
> 

Thank you for the explanation. I will change this.

>> > > +# @system-name: system name of Linux instance
>> >
>> > What is a system name ?  Is that a hostname, or is that something
>> > else ?
>> >
>> 
>> Yes, it is the hostname of the guest virtual machine.
> 
> Lets rename it to 'system-hostname' to be unambiguous.
> 

I was wrong. System name is not the hostname of the guest virtual 
machine. As mentioned by Nina it is a user configurable name of the 
system. So system-name cannot be change to 'system-hostname'. I am sorry 
for the inconvenience. Thank you.

> 
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

