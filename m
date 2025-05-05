Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C24CBC3ABB6
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 08:55:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBrat-0006hK-89; Mon, 05 May 2025 04:54:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shalini@linux.ibm.com>)
 id 1uBraq-0006gJ-Hz; Mon, 05 May 2025 04:54:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shalini@linux.ibm.com>)
 id 1uBrao-00041u-MR; Mon, 05 May 2025 04:54:32 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 544L3IVf029483;
 Mon, 5 May 2025 08:54:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=ro6hK9
 NCty/JFCBmbBxr6KjDirMh4JB4yDH2q6H299o=; b=LPTVPbjc9JsmvxK4HsOCst
 K7pJPPvkb4kkLsu+rbte8gprHnGCofVFS7B33q7LIOPfiX6Z500CMALTYHxMZHaF
 ELVq0g5Fy/vAwbhd0qDJTs1y6NWI5jIeBJ2KI/ob9Hvy8aA0NvyDVP8D+9icSOYh
 BkbKsJfRBu4R0HLXz3h9/aIkUdR6Q86EJuBZe8s5s73jaE2Ctug56CENh/EoTE8V
 WlO04y5c+oMdDaj6/J4ZY7f3SxLtLNiiXDjKIbi8pu6FJc6PQbkQOzxCBngNdW8y
 CRn/6jF22i8UkVYQDZhf4stX5AoYLoe3+o4n341xrMLbGe1X68HJOnT3sA64AJ8A
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46eftkj2gd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 May 2025 08:54:28 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5455LKiU013765;
 Mon, 5 May 2025 08:54:27 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 46e06252xv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 May 2025 08:54:27 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5458sQ1226018440
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 5 May 2025 08:54:26 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E5DBC5805C;
 Mon,  5 May 2025 08:54:25 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 50B4158064;
 Mon,  5 May 2025 08:54:25 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  5 May 2025 08:54:25 +0000 (GMT)
MIME-Version: 1.0
Date: Mon, 05 May 2025 10:54:24 +0200
From: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
To: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Cc: qemu-s390x mailing list <qemu-s390x@nongnu.org>, Thomas Huth
 <thuth@redhat.com>, Daniel Berrange <berrange@redhat.com>, qemu-devel
 mailing list <qemu-devel@nongnu.org>, Hendrik Brueckner
 <brueckner@linux.ibm.com>, "<Shalini Chellathurai Saroja"
 <shalini@linux.ibm.com>
Subject: Re: [PATCH v4 4/4] hw/s390x: compat handling for backward migration
In-Reply-To: <cabf1f945a3072e3eada75ceae828bd346855e9d.camel@linux.ibm.com>
References: <20250410150934.1331433-1-shalini@linux.ibm.com>
 <20250410150934.1331433-5-shalini@linux.ibm.com>
 <cabf1f945a3072e3eada75ceae828bd346855e9d.camel@linux.ibm.com>
Message-ID: <7390ada124fe80862e7661672c75fda4@linux.ibm.com>
X-Sender: shalini@linux.ibm.com
Organization: IBM Deutschland Research & Development GmbH
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA1MDA4MSBTYWx0ZWRfX9otXi8UvdKlS
 sF+Ysysyf34H5YJ51mJK1oWG9U7keDYSnULpGCWOM80XqqABk4cFBWr1I/eVgsVtzuPbjCBdiq4
 gKkYTi28PxKhpQpTehGtz7ySf8qSOjlVCIo3mI8zE8aG5L71k7NHZXkwOPKTpkDD2p1mqarEXFb
 KNbmbKgFtIngrz7F1avhPQ5Q/La9/ntjoXyDozaBpIItQQVp3Fr3lgPc9RrFsmExfOc6w5OOPhX
 aK3CmAUwTPMNmycO4DDJrJhzeNWO7zliSnG0hh7gnXBmHhhtisCbxg5BdKhdBrkPNZbFkYQU8TV
 r30So4pBgaWGh9mQIzJAuCASe+XdKNcm+I9N88kV8zGpPd7OydMPsCyzZqO6MYKh+BSZLhUoADQ
 jw/DYZT65o0Z/U65WeZle6N/4TsIb1K9F4hubsOI2Gd9+luT3eoLmAcsP2d1oDy5/d7lxEN1
X-Proofpoint-GUID: NK-B6oE-rOziyyBNIv-aSPITAeIr8tvZ
X-Authority-Analysis: v=2.4 cv=Q7vS452a c=1 sm=1 tr=0 ts=68187cc4 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=bWfykSnRqgQD1k4gbUEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: NK-B6oE-rOziyyBNIv-aSPITAeIr8tvZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-05_04,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0 impostorscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 clxscore=1015 adultscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505050081
Received-SPF: pass client-ip=148.163.156.1; envelope-from=shalini@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On 2025-04-28 14:05, Nina Schoetterl-Glausch wrote:
> On Thu, 2025-04-10 at 17:09 +0200, Shalini Chellathurai Saroja wrote:
>> Add Control-Program Identification (CPI) device to QOM only when the 
>> virtual
>> machine supports CPI. CPI is supported from "s390-ccw-virtio-10.0" 
>> machine
>> and higher.
>> 
>> Signed-off-by: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
>> ---
>>  hw/s390x/s390-virtio-ccw.c         | 10 +++++++++-
>>  include/hw/s390x/s390-virtio-ccw.h |  1 +
>>  2 files changed, 10 insertions(+), 1 deletion(-)
>> 
>> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
>> index 7f28cbd1de..81832ee638 100644
>> --- a/hw/s390x/s390-virtio-ccw.c
>> +++ b/hw/s390x/s390-virtio-ccw.c
>> @@ -274,6 +274,7 @@ static void s390_create_sclpcpi(SCLPDevice *sclp)
>>  static void ccw_init(MachineState *machine)
>>  {
>>      MachineClass *mc = MACHINE_GET_CLASS(machine);
>> +    S390CcwMachineClass *s390mc = S390_CCW_MACHINE_CLASS(mc);
>>      S390CcwMachineState *ms = S390_CCW_MACHINE(machine);
>>      int ret;
>>      VirtualCssBus *css_bus;
>> @@ -336,7 +337,10 @@ static void ccw_init(MachineState *machine)
>>      s390_init_tod();
>> 
>>      /* init SCLP event Control-Program Identification */
>> -    s390_create_sclpcpi(ms->sclp);
>> +    if (s390mc->use_cpi) {
>> +        s390_create_sclpcpi(ms->sclp);
>> +    }
> 
> Fixing this in a separate commit could be bad for bisecting.

Ok.

> You introduce use_cpi in an earlier commit set to false and
> then flipping it in the migration patch for new machines.
> This way there is no broken intermediate state.
> 
> I would also squash the compat migration changes into the previous
> patch.
> 

Hello Nina,

If use_cpi is set to false in patch 1, then the sclpcpi device will not 
be instantiated even for new machines at that point. The sclpcpi device 
will only be instantiated when the use_cpi is set to true in the 
migration patch.

I prefer to squash this entire patch to patch 1, then the sclpcpi device 
will only be instantiated for new machines with the code in patch 1 
itself and will not be dependent on the migration patch. I like this 
approach as the logic to add sclpcpi device is complete in patch 1.

What do you think?, thank you.

>>  }
>> 
>>  static void s390_cpu_plug(HotplugHandler *hotplug_dev,
>> @@ -827,6 +831,7 @@ static void ccw_machine_class_init(ObjectClass 
>> *oc, void *data)
>> 
>>      s390mc->hpage_1m_allowed = true;
>>      s390mc->max_threads = 1;
>> +    s390mc->use_cpi = true;
>>      mc->reset = s390_machine_reset;
>>      mc->block_default_type = IF_VIRTIO;
>>      mc->no_cdrom = 1;
>> @@ -955,6 +960,9 @@ static void 
>> ccw_machine_9_2_class_options(MachineClass *mc)
>>          { TYPE_S390_PCI_DEVICE, "relaxed-translation", "off", },
>>      };
>> 
>> +    S390CcwMachineClass *s390mc = S390_CCW_MACHINE_CLASS(mc);
>> +    s390mc->use_cpi = false;
>> +
>>      ccw_machine_10_0_class_options(mc);
>>      compat_props_add(mc->compat_props, hw_compat_9_2, 
>> hw_compat_9_2_len);
>>      compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
>> diff --git a/include/hw/s390x/s390-virtio-ccw.h 
>> b/include/hw/s390x/s390-virtio-ccw.h
>> index 686d9497d2..fc4112fbf5 100644
>> --- a/include/hw/s390x/s390-virtio-ccw.h
>> +++ b/include/hw/s390x/s390-virtio-ccw.h
>> @@ -55,6 +55,7 @@ struct S390CcwMachineClass {
>>      /*< public >*/
>>      bool hpage_1m_allowed;
>>      int max_threads;
>> +    bool use_cpi;
>>  };
>> 
>>  /* 1M huge page mappings allowed by the machine */

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

