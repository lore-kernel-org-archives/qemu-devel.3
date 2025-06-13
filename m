Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCE24C61DB2
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 11:38:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uQ2jb-0001cy-1S; Fri, 13 Jun 2025 07:38:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shalini@linux.ibm.com>)
 id 1uQ2jY-0001ca-4A; Fri, 13 Jun 2025 07:38:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shalini@linux.ibm.com>)
 id 1uQ2jU-0003fS-Qt; Fri, 13 Jun 2025 07:38:07 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55D7TKqh019993;
 Fri, 13 Jun 2025 11:38:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=KM3O3+
 9vbldgRNBnYUR7mOlchK3YvpLrieCMg3pYtEU=; b=X6FpH3JnVreuqAiA51Q+BT
 8sj7/tvfJ3ywiMiGeR4YCgZczC60cdIxncTuNZvqpnwHzbRvTigNkqJ26gDOvOBW
 b3vzKZaGF6pdkMCWehSiLTDFLEBUMmG/A9ZMuIozu9Xnxi2gZ2/0ZeZ/cEI5qbkT
 w1LDBjH8WV1I3RoaMhUQcbmr7msbLG4DvWuAbdFXQA4YJctPQQSS3GWH9XSw+kSj
 Z8xEqIMAANrP/EldNGAj3PvQSk3FRLcdCrc+8vXclAfRgrrSfmFZZc/70brQHLLV
 0kfIxCuzODsQx3x5biNxoSis5lfEssggR7i/vkm3LHLs7TDFYoHrtd79YHErPNQA
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474cxjrx0b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Jun 2025 11:38:00 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55D9UBbo015192;
 Fri, 13 Jun 2025 11:37:59 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 474yrtt12w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Jun 2025 11:37:59 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 55DBbvtt3605186
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Jun 2025 11:37:58 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B408458054;
 Fri, 13 Jun 2025 11:37:57 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0D77B5805A;
 Fri, 13 Jun 2025 11:37:57 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 13 Jun 2025 11:37:56 +0000 (GMT)
MIME-Version: 1.0
Date: Fri, 13 Jun 2025 13:37:56 +0200
From: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x mailing list <qemu-s390x@nongnu.org>, Daniel Berrange
 <berrange@redhat.com>, qemu-devel mailing list <qemu-devel@nongnu.org>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>, Hendrik Brueckner
 <brueckner@linux.ibm.com>, Sebastian Mitterle <smitterl@redhat.com>, Boqiao
 Fu <bfu@redhat.com>
Subject: Re: [PATCH v5 2/3] hw/s390x: add Control-Program Identification to QOM
In-Reply-To: <7e228759-2fea-48e9-a604-4dadb9882f13@redhat.com>
References: <20250603135655.595602-1-shalini@linux.ibm.com>
 <20250603135655.595602-3-shalini@linux.ibm.com>
 <7e228759-2fea-48e9-a604-4dadb9882f13@redhat.com>
Message-ID: <356561a646fc891240f42c95d64e8c32@linux.ibm.com>
X-Sender: shalini@linux.ibm.com
Organization: IBM Deutschland Research & Development GmbH
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: bBozqg5UCtJ2H-MUCTFABJQvSRuyRfVm
X-Proofpoint-GUID: bBozqg5UCtJ2H-MUCTFABJQvSRuyRfVm
X-Authority-Analysis: v=2.4 cv=fZWty1QF c=1 sm=1 tr=0 ts=684c0d98 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=Bz7YMBVqm1x7Jq11-RIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEzMDA4MiBTYWx0ZWRfX3QdMv1sOqmL7
 rEB7lN1oiA7GEVGd8us5F0qc2JvxVyPDkYp48UviMVuQkCZB+AsKmt3wVmnJnMdqtGGvbK3dUGf
 smFMhwRUklvx4LFCQ4vajG5kU3tdu97JjQ2FArsUT8fwAUVo6UPljym3UEsg2NlJ1ZZXCFEQjg4
 29KELkvTcWg/cCla90shlC8EAnC1qCjAoNkhS4aaJ59HswMSvNMd2aGN9dHK1ajYxuguwuWHzZV
 2HXtuJhNci5ZCYczh6Tnr+dbgCwGrLlUVyCjfmdTozfJVqWjqCLQQEQqcyajn+e9plOxvrnW4at
 hk+sRuwdgoo4PbTOfONQc+QYa48WXO3vbLN6Mv6F35onutkmkNbmE6jBsqrFpp19QIVcaypPEWY
 C17fHpfSbE7eKZaGjgKcOw3AUOcj9AqilKLvnbNuKbtp+r/sC6oJnLuY4iiJMWxIoh5NIdmd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-13_01,2025-06-12_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0
 priorityscore=1501 spamscore=0 bulkscore=0 phishscore=0 suspectscore=0
 adultscore=0 mlxscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=999
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506130082
Received-SPF: pass client-ip=148.163.156.1; envelope-from=shalini@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

On 2025-06-13 11:59, Thomas Huth wrote:
> On 03/06/2025 15.56, Shalini Chellathurai Saroja wrote:
>> Add Control-Program Identification (CPI) data to the QEMU Object
>> Model (QOM), along with the timestamp in which the data was received
>> as shown below.
> ...
>> diff --git a/qapi/machine.json b/qapi/machine.json
>> index 5373e1368c..1f2db68032 100644
>> --- a/qapi/machine.json
>> +++ b/qapi/machine.json
>> @@ -2279,3 +2279,61 @@
>>   # Since: 1.2
>>   ##
>>   { 'command': 'query-cpu-definitions', 'returns': 
>> ['CpuDefinitionInfo'] }
>> +
>> +##
>> +# @S390ControlProgramId:
>> +#
>> +# Control-program identifiers provide data about the guest operating 
>> system.
>> +# The control-program identifiers are: system type, system name, 
>> system level
>> +# and sysplex name.
>> +#
>> +# In Linux, all the control-program identifiers are user 
>> configurable. The
>> +# system type, system name, and sysplex name use EBCDIC characters 
>> from
>> +# this set: capital A-Z, 0-9, $, @, #, and blank.  In Linux, the 
>> system type,
>> +# system name and sysplex name are arbitrary free-form texts.
>> +#
>> +# In Linux, the 8-byte hexadecimal system-level has the format
>> +# 0x<a><b><cc><dd><eeee><ff><gg><hh>, where:
>> +# <a>: is one hexadecimal byte, its most significant bit indicates 
>> hypervisor
>> +# use
> 
>  Hi Shalini!
> 
> While testing the patches, the above description caused some headache
> for me, but I think it's simply typo here: This is not a hexadecimal
> byte, it's just a nibble / 4-bit digit for this <a>, right? Could you
> please fix the description in the next version of the patch series,
> please?


Hello Thomas,
Yes, that is correct. <a> is a 4-bit digit and not a byte. I will 
correct this
in the next version. Thank you very much.

> 
>  Thanks,
>   Thomas
> 
> 
>> +# <b>: is one digit that represents Linux distributions as follows
>> +# 0: generic Linux
>> +# 1: Red Hat Enterprise Linux
>> +# 2: SUSE Linux Enterprise Server
>> +# 3: Canonical Ubuntu
>> +# 4: Fedora
>> +# 5: openSUSE Leap
>> +# 6: Debian GNU/Linux
>> +# 7: Red Hat Enterprise Linux CoreOS
>> +# <cc>: are two digits for a distribution-specific encoding of the 
>> major version
>> +# of the distribution
>> +# <dd>: are two digits for a distribution-specific encoding of the 
>> minor version
>> +# of the distribution
>> +# <eeee>: are four digits for the patch level of the distribution
>> +# <ff>: are two digits for the major version of the kernel
>> +# <gg>: are two digits for the minor version of the kernel
>> +# <hh>: are two digits for the stable version of the kernel
>> +# (e.g. 74872343805430528, when converted to hex is 
>> 0x010a000000060b00). On
>> +# machines prior to z16, some of the values are not available to 
>> display.
>> +#
>> +# Sysplex refers to a cluster of logical partitions that communicates 
>> and
>> +# co-operates with each other.
>> +#
>> +# @system-type: operating system (e.g. "LINUX   ")
>> +#
>> +# @system-name: user configurable name of the VM (e.g. "TESTVM  ")
>> +#
>> +# @system-level: distribution and kernel version in Linux
>> +#
>> +# @sysplex-name: sysplex which the VM belongs to, if any (e.g. "PLEX 
>> ")
>> +#
>> +# @timestamp: latest update of CPI data in nanoseconds since the UNIX 
>> EPOCH
>> +#
>> +# Since: 10.1
>> +##
>> +{ 'struct': 'S390ControlProgramId', 'data': {
>> +     'system-type': 'str',
>> +     'system-name': 'str',
>> +     'system-level': 'uint64',
>> +     'sysplex-name': 'str',
>> +     'timestamp': 'uint64' } }

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

