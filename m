Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0314C36008
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Mar 2025 13:46:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tyWVq-00049D-Tu; Sat, 29 Mar 2025 09:46:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1tyWVh-00048e-Ag; Sat, 29 Mar 2025 09:46:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1tyWVe-0004F2-4A; Sat, 29 Mar 2025 09:46:04 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52T1WR6u012296;
 Sat, 29 Mar 2025 13:45:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=28WuMh
 C/1BKYI6Et3YQVP5IlO9UpjAsCwP14o+qxzKc=; b=IdYrFL8I8fxBsFa4CW3Get
 jlcaXly1/fYShYBKwaMYvUvJpjxqxKtbCC1X95ZCnzdshBpB+tsQR5Eu/getEEfN
 L3NyX860fK3fkBoTOuvqsJF88eEqykv2a9I9mIo2rmta/95bH+dFmaStVQ4I/ZgG
 4pvkYQoJB38JgMnjV/6qjqdIfqoyyT/J3hwkoEEhzDLDOAdUWUVsRPIehf0LztN5
 p3lYqAOw4qXiEN4oyAZ+ZrkNagRJHrvhGBzCl9+Gy1gCb8tOvf0/QfDvLZ2p77sI
 oWeboaNrdJf5w+WJSa+ykn6iujtzl7i6Ufex7VlSls6T+HTBSEDJZo8O3eeDjFEA
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45p79j26vq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 29 Mar 2025 13:45:54 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52TDjswM018988;
 Sat, 29 Mar 2025 13:45:54 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45p79j26vn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 29 Mar 2025 13:45:54 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52TCNrip025443;
 Sat, 29 Mar 2025 13:45:53 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45j7x0qw7s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 29 Mar 2025 13:45:53 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 52TDjn2j42139912
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 29 Mar 2025 13:45:49 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 71DEA20043;
 Sat, 29 Mar 2025 13:45:49 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E24F720040;
 Sat, 29 Mar 2025 13:45:46 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.124.216.105])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Sat, 29 Mar 2025 13:45:46 +0000 (GMT)
Date: Sat, 29 Mar 2025 19:15:21 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Subject: Re: [PATCH] target/ppc: Deprecate Power8E and Power8NVL
Message-ID: <hn6lrnkskpfuoyxlnqtv5hw5iwzwpvryjxpl33q2jwuznpcp3g@2m2rq326vju3>
References: <20250328040608.1580515-1-adityag@linux.ibm.com>
 <1c786c2f-1773-43d2-a4ea-531e0373df43@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1c786c2f-1773-43d2-a4ea-531e0373df43@kaod.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 90bWBhmTxtnWB8e9nRGTUiXmmL98eO1z
X-Proofpoint-ORIG-GUID: WguQGQGS9zDmLRktBbfHlFz29EY6ql1D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-29_01,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 spamscore=0
 mlxlogscore=999 clxscore=1015 priorityscore=1501 phishscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503290096
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
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

On 25/03/28 08:23AM, Cédric Le Goater wrote:
> On 3/28/25 05:06, Aditya Gupta wrote:
> > Power8E and Power8NVL variants are not of much use in QEMU now, and not
> > being maintained either.
> > 
> > Deprecate the 8E and 8NVL variants.
> > 
> > After deprecation, QEMU will print a warning like below when the
> > CPU/Chips are used:
> > 
> >      $ ./build/qemu-system-ppc64 -M powernv8 --cpu power8nvl -nographic
> >      qemu-system-ppc64: warning: CPU model power8nvl_v1.0-powerpc64-cpu is deprecated -- CPU is unmaintained.
> >      ...
> >      $ ./build/qemu-system-ppc64 -M powernv8 --cpu power8e -nographic
> >      qemu-system-ppc64: warning: CPU model power8e_v2.1-powerpc64-cpu is deprecated -- CPU is unmaintained.
> >      ...
> >      $ ./build/qemu-system-ppc64 -M pseries --cpu power8e -nographic
> >      qemu-system-ppc64: warning: CPU model power8e_v2.1-powerpc64-cpu is deprecated -- CPU is unmaintained.
> >      ...
> > 
> > Suggested-by: Cédric Le Goater <clg@kaod.org>
> > Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> 
> Please update the documentation too.
> 
> https://qemu.readthedocs.io/en/v9.2.0/about/deprecated.html

Sure Cédric, will mention it there.

> 
> 
> > 
> > ---
> > Cover Letter
> > ============
> > 
> > For me, Power8NVL won't even boot, getting stuck somewhere in early boot
> > in OPAL.
> 
> Looks like a skiboot issue. skiboot-v6.4 works fine.

Yes, did a git bisect, this seems to be the first bad commit:

    c5424f683ee3f8d07faeb87f41f4572c6afd67b1 is the first bad commit
    commit c5424f683ee3f8d07faeb87f41f4572c6afd67b1 (HEAD)
    Author: Nicholas Piggin <npiggin@gmail.com>
    Date:   Sun Oct 3 11:22:08 2021 +1000
    
        Remove support for POWER8 DD1
        
        This significantly simplifies the SLW code.
        
        HILE is now always supported.
        
		...

So support has been removed from skiboot sometime back ?

So releases before this are working with 8nvl. Maybe I can mention this
also in the deprecation in QEMU that newer versions of skiboot don't
support booting 8NVL QEMU.

> 
> > 
> > No direct way to deprecate the pnv chips, a field like deprecation_note
> > could be added, but felt not needed as the chip will only get used if
> > the user requests corresponding 8E / 8NVL CPU, which will print
> > deprecation warning.
> > 
> > Also, no separate pnv machine for 8E and 8NVL, user has to pass --cpu,
> > which will throw the deprecation warning. So just deprecating CPUs should
> > be enough.
> > 
> > Power8 itself also can be a candidate for deprecation if not needed ?
> 
> That's a bit early.

Got it

> 
> run 'qemu-system-ppc64  -cpu ?' to see which CPUs are currently
> available.

Checked, lists a lot of CPUs. This gave me the idea to print
"(deprecated)" in that list for deprecated CPUs (currently only 8e and
8nvl), like QEMU's 'cpu_list'.

Thanks,
- Aditya G

> 
> 
> Thanks,
> 
> C.
> 
> 
> 
> > Will follow up if decided.
> > ---
> > ---
> >   target/ppc/cpu-models.c | 17 ++++++++++++++---
> >   1 file changed, 14 insertions(+), 3 deletions(-)
> > 
> > diff --git a/target/ppc/cpu-models.c b/target/ppc/cpu-models.c
> > index ece348178188..6f2062e2c484 100644
> > --- a/target/ppc/cpu-models.c
> > +++ b/target/ppc/cpu-models.c
> > @@ -32,17 +32,22 @@
> >   /* PowerPC CPU definitions                                                 */
> >   #define POWERPC_DEF_PREFIX(pvr, svr, type)                                  \
> >       glue(glue(glue(glue(pvr, _), svr), _), type)
> > -#define POWERPC_DEF_SVR(_name, _desc, _pvr, _svr, _type)                    \
> > +#define POWERPC_DEF_SVR_DEPR(_name, _desc, _pvr, _svr, _type, _is_deprecated) \
> >       static void                                                             \
> >       glue(POWERPC_DEF_PREFIX(_pvr, _svr, _type), _cpu_class_init)            \
> >       (ObjectClass *oc, void *data)                                           \
> >       {                                                                       \
> >           DeviceClass *dc = DEVICE_CLASS(oc);                                 \
> > +        CPUClass *cc    = CPU_CLASS(oc);                                    \
> >           PowerPCCPUClass *pcc = POWERPC_CPU_CLASS(oc);                       \
> >                                                                               \
> >           pcc->pvr          = _pvr;                                           \
> >           pcc->svr          = _svr;                                           \
> >           dc->desc          = _desc;                                          \
> > +                                                                            \
> > +        if (_is_deprecated) {                                               \
> > +            cc->deprecation_note = "CPU is unmaintained.";                  \
> > +        }                                                                   \
> >       }                                                                       \
> >                                                                               \
> >       static const TypeInfo                                                   \
> > @@ -63,6 +68,12 @@
> >       type_init(                                                              \
> >           glue(POWERPC_DEF_PREFIX(_pvr, _svr, _type), _cpu_register_types))
> > +#define POWERPC_DEF_SVR(_name, _desc, _pvr, _svr, _type)                    \
> > +    POWERPC_DEF_SVR_DEPR(_name, _desc, _pvr, _svr, _type, false)
> > +
> > +#define POWERPC_DEPRECATED_CPU(_name, _pvr, _type, _desc)                   \
> > +    POWERPC_DEF_SVR_DEPR(_name, _desc, _pvr, POWERPC_SVR_NONE, _type, true)
> > +
> >   #define POWERPC_DEF(_name, _pvr, _type, _desc)                              \
> >       POWERPC_DEF_SVR(_name, _desc, _pvr, POWERPC_SVR_NONE, _type)
> > @@ -722,11 +733,11 @@
> >                   "POWER7 v2.3")
> >       POWERPC_DEF("power7p_v2.1",  CPU_POWERPC_POWER7P_v21,            POWER7,
> >                   "POWER7+ v2.1")
> > -    POWERPC_DEF("power8e_v2.1",  CPU_POWERPC_POWER8E_v21,            POWER8,
> > +    POWERPC_DEPRECATED_CPU("power8e_v2.1",  CPU_POWERPC_POWER8E_v21, POWER8,
> >                   "POWER8E v2.1")
> >       POWERPC_DEF("power8_v2.0",   CPU_POWERPC_POWER8_v20,             POWER8,
> >                   "POWER8 v2.0")
> > -    POWERPC_DEF("power8nvl_v1.0", CPU_POWERPC_POWER8NVL_v10,         POWER8,
> > +    POWERPC_DEPRECATED_CPU("power8nvl_v1.0", CPU_POWERPC_POWER8NVL_v10, POWER8,
> >                   "POWER8NVL v1.0")
> >       POWERPC_DEF("power9_v2.0",   CPU_POWERPC_POWER9_DD20,            POWER9,
> >                   "POWER9 v2.0")
> 

