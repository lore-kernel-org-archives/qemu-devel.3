Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4FE3CAC58E
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 19:04:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwmaD-0000gn-QF; Thu, 11 Sep 2025 15:03:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uwmaC-0000gV-3S; Thu, 11 Sep 2025 15:03:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uwma9-00032E-M9; Thu, 11 Sep 2025 15:03:47 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58BBplhA028539;
 Thu, 11 Sep 2025 19:03:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=am8pHU
 kA2dNSFWw45qlOHaDoyBfLnn9kUcY749v6c1I=; b=KXGg/A9/IH2Zc3zR7zStOR
 uy0R1b4RvslMG4YpqXrUPwqs6NnV4vbw7FLJ5eio9tBReNjKUXzrQE6xTo3gRMdo
 lsqFc9nWq9AiwZaSN1702L4yGL9hMkZU+KaN2ULfsiNy0njy3yyWFeHzh0GW9Tjr
 Q3Wt9K1vlyg6iaMJZQYdFja+4SC2cGus599jcQH7/ik+NtjN2l24znpZBiA0NtLL
 dd/jz0hxEsxNDhvlcY6UhjMTTe67dQzZShXQ306+o4W2veULbPbKvs84808hbeQy
 HsxZB38Y9LzIO7NKZNbdxIRTBiHtizf3G278V21hYPMMeMfurjNG1HrPcIZMLJ0Q
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490ukeubtu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Sep 2025 19:03:42 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58BI5usA017219;
 Thu, 11 Sep 2025 19:03:42 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4911gmq5hm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Sep 2025 19:03:42 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58BJ3eCw31523470
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 11 Sep 2025 19:03:40 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 745BC5805A;
 Thu, 11 Sep 2025 19:03:40 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F413258054;
 Thu, 11 Sep 2025 19:03:38 +0000 (GMT)
Received: from [9.61.156.147] (unknown [9.61.156.147])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Thu, 11 Sep 2025 19:03:38 +0000 (GMT)
Message-ID: <ffb4d32b-d2bc-45f0-91ce-6472d64c02bb@linux.ibm.com>
Date: Thu, 11 Sep 2025 15:03:37 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/29] Add boot-certs to s390-ccw-virtio machine type
 option
To: Markus Armbruster <armbru@redhat.com>
Cc: thuth@redhat.com, berrange@redhat.com, richard.henderson@linaro.org,
 david@redhat.com, jrossi@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, walling@linux.ibm.com, jjherne@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 alifm@linux.ibm.com
References: <20250818214323.529501-1-zycai@linux.ibm.com>
 <20250818214323.529501-2-zycai@linux.ibm.com> <87v7lpjvsw.fsf@pond.sub.org>
Content-Language: en-US
From: Zhuoying Cai <zycai@linux.ibm.com>
In-Reply-To: <87v7lpjvsw.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDE5NSBTYWx0ZWRfX8L0OARgtIq0P
 efRkprd8fX5u9P9DNBsaLayhO0O5+QlzaxS8ckVLGHR5YS2TqItBzGf5OZxlhSd6kWTPwjoyjE+
 WSmyX7sn0ax20UCHXWzBDLuX+va5vtrVCRUABwJcPryLVF5aKCWW8+0QeDWkkX0KDihp0uMsdA6
 Nf2kyHkMLA0X8KZYFmPflzRhAGGCEn+2QtItwIvsQ9xj7b43l9pEnKiAFS9McMJ6KGCqqcxezjA
 leGk7yrJanflcZQhD587M/uNt4Xr+5MgRxIKZR+srswmAuhwCNtBsxiZ026W61AoPZYkCPwyjWJ
 j5u/QiJNgOCVDW5l4dHEpb0JU1BJKIa7Nls8SObbkrJrkQ2NHa4lxm6+s0pR9qUG0q9WxkSVzEP
 EaP7SYOO
X-Proofpoint-ORIG-GUID: 01yiro66y8tJQnRWHsf29D9RrQS6le6G
X-Proofpoint-GUID: 01yiro66y8tJQnRWHsf29D9RrQS6le6G
X-Authority-Analysis: v=2.4 cv=StCQ6OO0 c=1 sm=1 tr=0 ts=68c31d0f cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=jKY45INLLk0cNB3xUyoA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-11_03,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 bulkscore=0 clxscore=1015 adultscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060195
Received-SPF: pass client-ip=148.163.158.5; envelope-from=zycai@linux.ibm.com;
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

Thanks for the feedback.

On 9/11/25 3:24 AM, Markus Armbruster wrote:
> Zhuoying Cai <zycai@linux.ibm.com> writes:
> 
>> Introduce a new `boot-certs` machine type option for the s390-ccw-virtio
>> machine. This allows users to specify one or more certificate file paths
>> or directories to be used during secure boot.
>>
>> Each entry is specified using the syntax:
>> 	boot-certs.<index>.path=/path/to/cert.pem
>>
>> Multiple paths can be specify using array properties:
>> 	boot-certs.0.path=/path/to/cert.pem,
>> 	boot-certs.1.path=/path/to/cert-dir,
>> 	boot-certs.2.path=/path/to/another-dir...
>>
>> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
>> ---
>>  docs/system/s390x/secure-ipl.rst   | 20 ++++++++++++++++++++
>>  hw/s390x/s390-virtio-ccw.c         | 30 ++++++++++++++++++++++++++++++
>>  include/hw/s390x/s390-virtio-ccw.h |  2 ++
>>  qapi/machine-s390x.json            | 24 ++++++++++++++++++++++++
>>  qemu-options.hx                    |  6 +++++-
>>  5 files changed, 81 insertions(+), 1 deletion(-)
>>  create mode 100644 docs/system/s390x/secure-ipl.rst
>>
>> diff --git a/docs/system/s390x/secure-ipl.rst b/docs/system/s390x/secure-ipl.rst
>> new file mode 100644
>> index 0000000000..9b3fd25cc4
>> --- /dev/null
>> +++ b/docs/system/s390x/secure-ipl.rst
>> @@ -0,0 +1,20 @@
>> +.. SPDX-License-Identifier: GPL-2.0-or-later
>> +
>> +Secure IPL Command Line Options
>> +===============================
>> +
>> +New parameters have been introduced to s390-ccw-virtio machine type option
>> +to support secure IPL. These parameters allow users to provide certificates
>> +and enable secure IPL directly via the command line.
> 
> All too soon these parameters will no longer be new.  Consider something
> like "The s390-ccw-virtio machine type supports secure TPL.  To enable
> it, you need to provide certificates."
> 
>> +
>> +Providing Certificates
>> +----------------------
>> +
>> +The certificate store can be populated by supplying a list of certificate file
>> +paths or directories on the command-line:
> 
> File is clear enough (use the certificate found in the file).  What does
> directory do?
> 

A directory contains a list of certificate files, and allowing both
files and directories could make the CLI more flexible.

>> +
>> +.. code-block:: shell
>> +
>> +    qemu-system-s390x -machine s390-ccw-virtio, \
>> +                               boot-certs.0.path=/.../qemu/certs, \
>> +                               boot-certs.1.path=/another/path/cert.pem ...
>> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
>> index c294106a74..9ac425c695 100644
>> --- a/hw/s390x/s390-virtio-ccw.c
>> +++ b/hw/s390x/s390-virtio-ccw.c
>> @@ -45,6 +45,7 @@
>>  #include "target/s390x/kvm/pv.h"
>>  #include "migration/blocker.h"
>>  #include "qapi/visitor.h"
>> +#include "qapi/qapi-visit-machine-s390x.h"
>>  #include "hw/s390x/cpu-topology.h"
>>  #include "kvm/kvm_s390x.h"
>>  #include "hw/virtio/virtio-md-pci.h"
>> @@ -798,6 +799,30 @@ static void machine_set_loadparm(Object *obj, Visitor *v,
>>      g_free(val);
>>  }
>>  
>> +static void machine_get_boot_certs(Object *obj, Visitor *v,
>> +                                   const char *name, void *opaque,
>> +                                   Error **errp)
>> +{
>> +    S390CcwMachineState *ms = S390_CCW_MACHINE(obj);
>> +    BootCertPathList **certs = &ms->boot_certs;
>> +
>> +    visit_type_BootCertPathList(v, name, certs, errp);
>> +}
>> +
>> +static void machine_set_boot_certs(Object *obj, Visitor *v, const char *name,
>> +                                   void *opaque, Error **errp)
>> +{
>> +    S390CcwMachineState *ms = S390_CCW_MACHINE(obj);
>> +    BootCertPathList *cert_list = NULL;
>> +
>> +    visit_type_BootCertPathList(v, name, &cert_list, errp);
>> +    if (!cert_list) {
>> +        return;
>> +    }
>> +
>> +    ms->boot_certs = cert_list;
>> +}
>> +
>>  static void ccw_machine_class_init(ObjectClass *oc, const void *data)
>>  {
>>      MachineClass *mc = MACHINE_CLASS(oc);
>> @@ -851,6 +876,11 @@ static void ccw_machine_class_init(ObjectClass *oc, const void *data)
>>              "Up to 8 chars in set of [A-Za-z0-9. ] (lower case chars converted"
>>              " to upper case) to pass to machine loader, boot manager,"
>>              " and guest kernel");
>> +
>> +    object_class_property_add(oc, "boot-certs", "BootCertPath",
> 
> Isn't this a BootCertPathList, not a BootCertPath?
> 

If I understand correctly, would BootCerts also be the correct option to
use here?

>> +                              machine_get_boot_certs, machine_set_boot_certs, NULL, NULL);
>> +    object_class_property_set_description(oc, "boot-certs",
>> +            "provide paths to a directory and/or a certificate file for secure boot");
>>  }
>>  
>>  static inline void s390_machine_initfn(Object *obj)
>> diff --git a/include/hw/s390x/s390-virtio-ccw.h b/include/hw/s390x/s390-virtio-ccw.h
>> index 526078a4e2..b90949355c 100644
>> --- a/include/hw/s390x/s390-virtio-ccw.h
>> +++ b/include/hw/s390x/s390-virtio-ccw.h
>> @@ -14,6 +14,7 @@
>>  #include "hw/boards.h"
>>  #include "qom/object.h"
>>  #include "hw/s390x/sclp.h"
>> +#include "qapi/qapi-types-machine-s390x.h"
>>  
>>  #define TYPE_S390_CCW_MACHINE               "s390-ccw-machine"
>>  
>> @@ -31,6 +32,7 @@ struct S390CcwMachineState {
>>      uint8_t loadparm[8];
>>      uint64_t memory_limit;
>>      uint64_t max_pagesize;
>> +    BootCertPathList *boot_certs;
>>  
>>      SCLPDevice *sclp;
>>  };
>> diff --git a/qapi/machine-s390x.json b/qapi/machine-s390x.json
>> index 966dbd61d2..3e89ef8320 100644
>> --- a/qapi/machine-s390x.json
>> +++ b/qapi/machine-s390x.json
>> @@ -119,3 +119,27 @@
>>  { 'command': 'query-s390x-cpu-polarization', 'returns': 'CpuPolarizationInfo',
>>    'features': [ 'unstable' ]
>>  }
>> +
>> +##
>> +# @BootCertPath:
>> +#
>> +# Boot certificate path.
>> +#
>> +# @path: path of certificate(s)
>> +#
>> +# Since: 10.1
>> +##
> 
> No mention of file vs. directory.
> 
> Why do you wrap the file name in a struct?  One possible reason is
> providing for future extensions.  Can you think of any?
> 
> If you extend it, the name BootCertPath could become suboptimal.
> BootCertificate?
> 

I wrapped the path in a struct to follow the array-style structure used
by cxl-fmw and smp-cache options (as Daniel suggested).

```
  It would be something like this on the CLI:


boot-certs.0.path=/path/to/dir,boot-certs.1.path=/to/other/dir,boot-certs.2.path=/some/...
```

This could potentially leave room for future extensions, such as
including details about the certificate (e.g., issuer, hashing
algorithm, etc).

>> +{ 'struct': 'BootCertPath',
>> +  'data': {'path': 'str'} }
>> +
>> +##
>> +# @BootCerts:
>> +#
>> +# List of boot certificate paths.
>> +#
>> +# @boot-certs: List of BootCertPath
> 
> Anti-pattern: the description text restates the type.
> 
>> +#
>> +# Since: 10.1
>> +##
>> +{ 'struct': 'BootCerts',
>> +  'data': {'boot-certs': ['BootCertPath'] } }
> 
> Where is this type used?
> 

Please correct me if I'm wrong, but from what I've seen, it is not used
directly in the implementation. It provides a list property for
BootCertPath, which makes the BootCertPathList definition valid and able
to accept multiple paths. If BootCerts is removed, then BootCertPathList
becomes underfined and results in compilation errors.

>> diff --git a/qemu-options.hx b/qemu-options.hx
>> index ab23f14d21..ac497eb3a0 100644
>> --- a/qemu-options.hx
>> +++ b/qemu-options.hx
>> @@ -44,7 +44,8 @@ DEF("machine", HAS_ARG, QEMU_OPTION_machine, \
>>  #endif
>>      "                memory-backend='backend-id' specifies explicitly provided backend for main RAM (default=none)\n"
>>      "                cxl-fmw.0.targets.0=firsttarget,cxl-fmw.0.targets.1=secondtarget,cxl-fmw.0.size=size[,cxl-fmw.0.interleave-granularity=granularity]\n"
>> -    "                smp-cache.0.cache=cachename,smp-cache.0.topology=topologylevel\n",
>> +    "                smp-cache.0.cache=cachename,smp-cache.0.topology=topologylevel\n"
>> +    "                boot-certs.0.path=/path/directory,boot-certs.1.path=/path/file provides paths to a directory and/or a certificate file\n",
>>      QEMU_ARCH_ALL)
>>  SRST
>>  ``-machine [type=]name[,prop=value[,...]]``
>> @@ -205,6 +206,9 @@ SRST
>>          ::
>>  
>>              -machine smp-cache.0.cache=l1d,smp-cache.0.topology=core,smp-cache.1.cache=l1i,smp-cache.1.topology=core
>> +
>> +    ``boot-certs.0.path=/path/directory,boot-certs.1.path=/path/file``
>> +        Provide paths to a directory and/or a certificate file on the host [s390x only].
>>  ERST
>>  
>>  DEF("M", HAS_ARG, QEMU_OPTION_M,
> 


