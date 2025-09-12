Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C8B5CA101F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 18:07:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ux8A2-0007xz-Ns; Fri, 12 Sep 2025 14:06:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1ux8A0-0007nL-SE; Fri, 12 Sep 2025 14:06:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1ux89w-0002ai-Au; Fri, 12 Sep 2025 14:06:11 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58C8mXCL004387;
 Fri, 12 Sep 2025 18:05:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=zSMqrk
 DbOP3cBecAYWg9XI76hMVlEVpYNvfH3RiZW4k=; b=lICBsUumb5POG14rW1EuE8
 rbz1SgCzjtHYmLdwRGUmjjSKrMOBvae0v2x9MuAfkq2r1FyGyTS1f6b+WmHPsVH5
 hQwSDn0mI8lqfKa8oIWJd6e4eTdWMLvBSUlM1uKR++f/2Un7aIYqwSSjQdv246g8
 zO8hHHwzrnnskiQuEd4j8L/GTOjDdI8t1aHyCea232EGc4yAEsWKDULHmvBP1Tqb
 YP5qdxM7qJl6ftUKSUwKDaWZACIJQsvSTHfXTK0iBiGjfjHDcIzlYGE9aG4Hhe2C
 07kxeNJ91uH/0/mt49ZpVGSFn0VQcueN3LQBf5UZRJdjr97o3J1BkxtmAyHpETww
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490bctbsv4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 12 Sep 2025 18:05:53 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58CGx2d3020465;
 Fri, 12 Sep 2025 18:05:53 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 490yp1cenc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 12 Sep 2025 18:05:53 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58CI5pqs24052420
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Sep 2025 18:05:51 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B2F0C5805E;
 Fri, 12 Sep 2025 18:05:51 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AB11658052;
 Fri, 12 Sep 2025 18:05:50 +0000 (GMT)
Received: from [9.61.30.241] (unknown [9.61.30.241])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 12 Sep 2025 18:05:50 +0000 (GMT)
Message-ID: <3d930413-d809-4650-b1d8-446eb4ee7daa@linux.ibm.com>
Date: Fri, 12 Sep 2025 14:05:49 -0400
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
 <ffb4d32b-d2bc-45f0-91ce-6472d64c02bb@linux.ibm.com>
 <87wm64b29p.fsf@pond.sub.org>
Content-Language: en-US
From: Zhuoying Cai <zycai@linux.ibm.com>
In-Reply-To: <87wm64b29p.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAxMCBTYWx0ZWRfX+HFZHquHTiEF
 xLBnzjp2LzwKrgrGhkt/N81sffP58xmfINJDSKNb1fYICLC6hms7l5Kxvsu1v8AjDdIHbjIOIVu
 z49JAQhviYPuo1N22nlFlm/sCtl1eYn4NC79LWc8A3rOCvtj+0dFPA5gPm3+Rl7UH49s599Qi3r
 Yy3g/rqq5LxHwjUVUjfIgMumi3IgeqQOJsLM4UVpwblaBtA2mU+OdUNZDreHTzB62FdDj3PR7iO
 kFr9xtark+V8EogpqX8xHVcpPOHdzjHuicbuooxb2yNdaVQuFLYWOsAlwQ1qmlWvu7aYaA1yEPD
 GFGSTKFKhCPrEOHRza7Y41iYvAOfGiYnn9YkyowU+28DRhIO+xOwbuFpzu2INSYh8bBxH9aJXL4
 XxC+uxUq
X-Authority-Analysis: v=2.4 cv=SKNCVPvH c=1 sm=1 tr=0 ts=68c46101 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=_BZWnx9QUCZQft_O9CsA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: _fooTIWCfqHHx67eTrciaWcF-ZwvRzNb
X-Proofpoint-ORIG-GUID: _fooTIWCfqHHx67eTrciaWcF-ZwvRzNb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_06,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 adultscore=0 suspectscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060010
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

On 9/12/25 2:42 AM, Markus Armbruster wrote:
> Zhuoying Cai <zycai@linux.ibm.com> writes:
> 
>> Thanks for the feedback.
>>
>> On 9/11/25 3:24 AM, Markus Armbruster wrote:
>>> Zhuoying Cai <zycai@linux.ibm.com> writes:
>>>
>>>> Introduce a new `boot-certs` machine type option for the s390-ccw-virtio
>>>> machine. This allows users to specify one or more certificate file paths
>>>> or directories to be used during secure boot.
>>>>
>>>> Each entry is specified using the syntax:
>>>> 	boot-certs.<index>.path=/path/to/cert.pem
>>>>
>>>> Multiple paths can be specify using array properties:
>>>> 	boot-certs.0.path=/path/to/cert.pem,
>>>> 	boot-certs.1.path=/path/to/cert-dir,
>>>> 	boot-certs.2.path=/path/to/another-dir...
>>>>
>>>> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
>>>> ---
>>>>  docs/system/s390x/secure-ipl.rst   | 20 ++++++++++++++++++++
>>>>  hw/s390x/s390-virtio-ccw.c         | 30 ++++++++++++++++++++++++++++++
>>>>  include/hw/s390x/s390-virtio-ccw.h |  2 ++
>>>>  qapi/machine-s390x.json            | 24 ++++++++++++++++++++++++
>>>>  qemu-options.hx                    |  6 +++++-
>>>>  5 files changed, 81 insertions(+), 1 deletion(-)
>>>>  create mode 100644 docs/system/s390x/secure-ipl.rst
>>>>
>>>> diff --git a/docs/system/s390x/secure-ipl.rst b/docs/system/s390x/secure-ipl.rst
>>>> new file mode 100644
>>>> index 0000000000..9b3fd25cc4
>>>> --- /dev/null
>>>> +++ b/docs/system/s390x/secure-ipl.rst
>>>> @@ -0,0 +1,20 @@
>>>> +.. SPDX-License-Identifier: GPL-2.0-or-later
>>>> +
>>>> +Secure IPL Command Line Options
>>>> +===============================
>>>> +
>>>> +New parameters have been introduced to s390-ccw-virtio machine type option
>>>> +to support secure IPL. These parameters allow users to provide certificates
>>>> +and enable secure IPL directly via the command line.
>>>
>>> All too soon these parameters will no longer be new.  Consider something
>>> like "The s390-ccw-virtio machine type supports secure TPL.  To enable
>>> it, you need to provide certificates."
>>>
>>>> +
>>>> +Providing Certificates
>>>> +----------------------
>>>> +
>>>> +The certificate store can be populated by supplying a list of certificate file
>>>> +paths or directories on the command-line:
>>>
>>> File is clear enough (use the certificate found in the file).  What does
>>> directory do?
>>
>> A directory contains a list of certificate files, and allowing both
>> files and directories could make the CLI more flexible.
> 
> I figure when @path names a file, it's an error when the file doesn't
> contain a valid cetificate.
> 
> What is @path names a directory, and one of the directory's files
> doesn't contain a valid certificate?
> 
> Can a single file contain multiple certificates?
> 

A certificate file path is expected to contain exactly one certificate.

Certificates provided through the CLI, whether as individual files or
within a directory, are validated before use. If a certificate is
invalid (e.g., unsupported format), it will be skipped and not added to
the S390 certificate store.

When iterating through the provided paths, the program will terminate on
fatal configuration errors, such as when a specified path is neither a
file nor a directory.

>>>> +
>>>> +.. code-block:: shell
>>>> +
>>>> +    qemu-system-s390x -machine s390-ccw-virtio, \
>>>> +                               boot-certs.0.path=/.../qemu/certs, \
>>>> +                               boot-certs.1.path=/another/path/cert.pem ...
>>>> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
>>>> index c294106a74..9ac425c695 100644
>>>> --- a/hw/s390x/s390-virtio-ccw.c
>>>> +++ b/hw/s390x/s390-virtio-ccw.c
>>>> @@ -45,6 +45,7 @@
>>>>  #include "target/s390x/kvm/pv.h"
>>>>  #include "migration/blocker.h"
>>>>  #include "qapi/visitor.h"
>>>> +#include "qapi/qapi-visit-machine-s390x.h"
>>>>  #include "hw/s390x/cpu-topology.h"
>>>>  #include "kvm/kvm_s390x.h"
>>>>  #include "hw/virtio/virtio-md-pci.h"
>>>> @@ -798,6 +799,30 @@ static void machine_set_loadparm(Object *obj, Visitor *v,
>>>>      g_free(val);
>>>>  }
>>>>  
>>>> +static void machine_get_boot_certs(Object *obj, Visitor *v,
>>>> +                                   const char *name, void *opaque,
>>>> +                                   Error **errp)
>>>> +{
>>>> +    S390CcwMachineState *ms = S390_CCW_MACHINE(obj);
>>>> +    BootCertPathList **certs = &ms->boot_certs;
>>>> +
>>>> +    visit_type_BootCertPathList(v, name, certs, errp);
>>>> +}
>>>> +
>>>> +static void machine_set_boot_certs(Object *obj, Visitor *v, const char *name,
>>>> +                                   void *opaque, Error **errp)
>>>> +{
>>>> +    S390CcwMachineState *ms = S390_CCW_MACHINE(obj);
>>>> +    BootCertPathList *cert_list = NULL;
>>>> +
>>>> +    visit_type_BootCertPathList(v, name, &cert_list, errp);
>>>> +    if (!cert_list) {
>>>> +        return;
>>>> +    }
>>>> +
>>>> +    ms->boot_certs = cert_list;
>>>> +}
>>>> +
>>>>  static void ccw_machine_class_init(ObjectClass *oc, const void *data)
>>>>  {
>>>>      MachineClass *mc = MACHINE_CLASS(oc);
>>>> @@ -851,6 +876,11 @@ static void ccw_machine_class_init(ObjectClass *oc, const void *data)
>>>>              "Up to 8 chars in set of [A-Za-z0-9. ] (lower case chars converted"
>>>>              " to upper case) to pass to machine loader, boot manager,"
>>>>              " and guest kernel");
>>>> +
>>>> +    object_class_property_add(oc, "boot-certs", "BootCertPath",
>>>
>>> Isn't this a BootCertPathList, not a BootCertPath?
>>
>> If I understand correctly, would BootCerts also be the correct option to
>> use here?
> 
> This is object_class_property_add()'s @type argument.  It's an arbitrary
> string, not checked in any way.  When the property's actual type is a
> QAPI type, like it is here, then the @type argument should be the name
> of the QAPI type.
> 
> Questions?
> 
>>>> +                              machine_get_boot_certs, machine_set_boot_certs, NULL, NULL);
>>>> +    object_class_property_set_description(oc, "boot-certs",
>>>> +            "provide paths to a directory and/or a certificate file for secure boot");
>>>>  }
>>>>  
>>>>  static inline void s390_machine_initfn(Object *obj)
>>>> diff --git a/include/hw/s390x/s390-virtio-ccw.h b/include/hw/s390x/s390-virtio-ccw.h
>>>> index 526078a4e2..b90949355c 100644
>>>> --- a/include/hw/s390x/s390-virtio-ccw.h
>>>> +++ b/include/hw/s390x/s390-virtio-ccw.h
>>>> @@ -14,6 +14,7 @@
>>>>  #include "hw/boards.h"
>>>>  #include "qom/object.h"
>>>>  #include "hw/s390x/sclp.h"
>>>> +#include "qapi/qapi-types-machine-s390x.h"
>>>>  
>>>>  #define TYPE_S390_CCW_MACHINE               "s390-ccw-machine"
>>>>  
>>>> @@ -31,6 +32,7 @@ struct S390CcwMachineState {
>>>>      uint8_t loadparm[8];
>>>>      uint64_t memory_limit;
>>>>      uint64_t max_pagesize;
>>>> +    BootCertPathList *boot_certs;
>>>>  
>>>>      SCLPDevice *sclp;
>>>>  };
>>>> diff --git a/qapi/machine-s390x.json b/qapi/machine-s390x.json
>>>> index 966dbd61d2..3e89ef8320 100644
>>>> --- a/qapi/machine-s390x.json
>>>> +++ b/qapi/machine-s390x.json
>>>> @@ -119,3 +119,27 @@
>>>>  { 'command': 'query-s390x-cpu-polarization', 'returns': 'CpuPolarizationInfo',
>>>>    'features': [ 'unstable' ]
>>>>  }
>>>> +
>>>> +##
>>>> +# @BootCertPath:
>>>> +#
>>>> +# Boot certificate path.
>>>> +#
>>>> +# @path: path of certificate(s)
>>>> +#
>>>> +# Since: 10.1
>>>> +##
>>>
>>> No mention of file vs. directory.
>>>
>>> Why do you wrap the file name in a struct?  One possible reason is
>>> providing for future extensions.  Can you think of any?
>>>
>>> If you extend it, the name BootCertPath could become suboptimal.
>>> BootCertificate?
>>>
>>
>> I wrapped the path in a struct to follow the array-style structure used
>> by cxl-fmw and smp-cache options (as Daniel suggested).
>>
>> ```
>>   It would be something like this on the CLI:
>>
>>
>> boot-certs.0.path=/path/to/dir,boot-certs.1.path=/to/other/dir,boot-certs.2.path=/some/...
>> ```
>>
>> This could potentially leave room for future extensions, such as
>> including details about the certificate (e.g., issuer, hashing
>> algorithm, etc).
> 
> No objections to the wrapping.  I'd prefer naming the struct
> BootCertificates.
> 

I'll update this in the next version.

>>>> +{ 'struct': 'BootCertPath',
>>>> +  'data': {'path': 'str'} }
>>>> +
>>>> +##
>>>> +# @BootCerts:
>>>> +#
>>>> +# List of boot certificate paths.
>>>> +#
>>>> +# @boot-certs: List of BootCertPath
>>>
>>> Anti-pattern: the description text restates the type.
>>>
>>>> +#
>>>> +# Since: 10.1
>>>> +##
>>>> +{ 'struct': 'BootCerts',
>>>> +  'data': {'boot-certs': ['BootCertPath'] } }
>>>
>>> Where is this type used?
>>
>> Please correct me if I'm wrong, but from what I've seen, it is not used
>> directly in the implementation. It provides a list property for
>> BootCertPath, which makes the BootCertPathList definition valid and able
>> to accept multiple paths. If BootCerts is removed, then BootCertPathList
>> becomes underfined and results in compilation errors.
> 
> Aha!
> 
> Your QOM property setter and getter need visit_type_BootCertPathList().
> 
> The QAPI generator generates code for BootCertPathList, including
> visit_type_BootCertPathList(), only when it knows it's actually used.
> It can only see uses within the QAPI schema.  So, when ['BootCertPath']
> doesn't occur there, visit_type_BootCertPathList() won't exist, and your
> QOM code won't compile.
> 
> Since you don't actually need BootCertPathList in the schema, you need
> to add an artifical use just to get it generated.  The common way to do
> that is using it in a dummy type like this:
> 
>     ##
>     # @DummyForceS390Arrays:
>     #
>     # Not used by QMP; hack to let us use BootCertPathList internally
>     #
>     # Since: 10.2
>     ##
>     { 'struct': 'DummyForceArrays',
>       'data': { 'unused': ['BootCertPath'] } }
> 
> You also need to add it to pragme documentation-exceptions is
> pragma.json.
> 
> Yes, this is clunky.  Sorry :)
> 

Thanks for all the explanations! I'll make the changes in the next version.

> [...]
> 

