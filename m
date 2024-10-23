Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F839CDDE5E
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 10:31:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3Yds-0000XZ-9Q; Wed, 23 Oct 2024 06:31:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1t3Ydo-0000We-Pk; Wed, 23 Oct 2024 06:31:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1t3Ydl-0002Wh-BY; Wed, 23 Oct 2024 06:31:00 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49N0N9MV003009;
 Wed, 23 Oct 2024 10:30:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=++bt8w
 y2zgYyqv+EuAfcqNFtCFA29EuEB9kc+QiRP44=; b=NVZMdOFFvCumrDzatYpQSB
 wRBI9PW/bABd21tVdrbUmZXzoEAeezjygH7FQtRq+CjLRhkA9fBi/d4k7MJr0wSC
 jTjt0waTeNcU2Dv7h//QcwUNKiH5QtuWblLDAYiUUCCpHlGnL0TtwWYNsn/96p0C
 6Z6c6Pbalp8IjXCy4uddsed7UR0caB1m+ME+OWDpvMoAd4ktURW+n5qz74iVUnWD
 xT2IG3d3kUgxH12rfOSawDVd/kzb2uQhpIhFZeHmhdPK9HdL3SzOW69uSaiJDv/5
 5IMiIApujI3I8RjgoF9lFl9VqSasyueGV6ulzCNmJAeyv5J3HgkJ8Z0oljYRmU5Q
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42emaftfcq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 23 Oct 2024 10:30:55 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49N7TXkh008791;
 Wed, 23 Oct 2024 10:30:54 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 42emkajd4y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 23 Oct 2024 10:30:54 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 49NAUrg924969828
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 23 Oct 2024 10:30:53 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 777395805A;
 Wed, 23 Oct 2024 10:30:53 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1D3E85806C;
 Wed, 23 Oct 2024 10:30:53 +0000 (GMT)
Received: from [9.61.94.176] (unknown [9.61.94.176])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Wed, 23 Oct 2024 10:30:53 +0000 (GMT)
Message-ID: <76a1414b-6582-480d-80c0-a39042774751@linux.ibm.com>
Date: Wed, 23 Oct 2024 06:30:52 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/19] pc-bios/s390-ccw: Use the libc from SLOF and
 remove sclp prints
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: frankja@linux.ibm.com
References: <20241020012953.1380075-1-jrossi@linux.ibm.com>
 <20241020012953.1380075-3-jrossi@linux.ibm.com>
 <7bf513ce-a4e6-47a9-8c56-6cc835cb4d17@redhat.com>
 <39ac6705-8787-4a00-a825-934d4897fdf4@linux.ibm.com>
 <a189b1fa-4cac-46e5-9253-e2bb2143c3c1@redhat.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <a189b1fa-4cac-46e5-9253-e2bb2143c3c1@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SegCBDOcFm_G6HxrU5bh5W94wPZATBFu
X-Proofpoint-ORIG-GUID: SegCBDOcFm_G6HxrU5bh5W94wPZATBFu
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 malwarescore=0
 mlxscore=0 adultscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410230063
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jrossi@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 10/23/24 12:51 AM, Thomas Huth wrote:
> On 22/10/2024 22.12, Jared Rossi wrote:
>>
>>
>> On 10/22/24 1:36 PM, Thomas Huth wrote:
>>> On 20/10/2024 03.29, jrossi@linux.ibm.com wrote:
>>>> From: Jared Rossi <jrossi@linux.ibm.com>
>>>>
>>>> We are already using the libc from SLOF for the s390-netboot.img, and
>>>> this libc implementation is way more complete and accurate than the
>>>> simple implementation that we currently use for the s390-ccw.img 
>>>> binary.
>>>> Since we are now always assuming that the SLOF submodule is available
>>>> when building the s390-ccw bios (see commit bf6903f6944f), we can drop
>>>> the simple implementation and use the SLOF libc for the s390-ccw.img
>>>> binary, too.
>>>>
>>>> Additionally replace sclp_print calls with puts/printf now that it 
>>>> is avaliable.
>>>>
>>>> Co-authored by: Thomas Huth <thuth@redhat.com>
>>>> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
>>>> ---
>>>>   pc-bios/s390-ccw/netboot.mak     |  3 --
>>>>   pc-bios/s390-ccw/bootmap.h       |  4 +-
>>>>   pc-bios/s390-ccw/libc.h          | 89 
>>>> --------------------------------
>>>
>>> I just had to discover that the removal of the old libc breaks "make 
>>> check-tcg" since it uses the sclp.c from the firmware for printing.
>>>
>>> I'll squash this patch to fix it:
>>>
>>> diff --git a/tests/tcg/s390x/console.c b/tests/tcg/s390x/console.c
>>> --- a/tests/tcg/s390x/console.c
>>> +++ b/tests/tcg/s390x/console.c
>>> @@ -4,7 +4,10 @@
>>>   *
>>>   * SPDX-License-Identifier: GPL-2.0-or-later
>>>   */
>>> +
>>>  #include "../../../pc-bios/s390-ccw/sclp.c"
>>> +#include "../../../roms/SLOF/lib/libc/string/memset.c"
>>> +#include "../../../roms/SLOF/lib/libc/string/memcpy.c"
>>>
>>>  void __sys_outc(char c)
>>>  {
>>> diff --git a/tests/tcg/s390x/Makefile.softmmu-target 
>>> b/tests/tcg/s390x/ Makefile.softmmu-target
>>> --- a/tests/tcg/s390x/Makefile.softmmu-target
>>> +++ b/tests/tcg/s390x/Makefile.softmmu-target
>>> @@ -3,7 +3,9 @@ VPATH+=$(S390X_SRC)
>>>  # EXTFLAGS can be passed by the user, e.g. to override the --accel
>>>  QEMU_OPTS+=-action panic=exit-failure -nographic -serial 
>>> chardev:output $(EXTFLAGS) -kernel
>>>  LINK_SCRIPT=$(S390X_SRC)/softmmu.ld
>>> -CFLAGS+=-ggdb -O0
>>> +CFLAGS+=-ggdb -O0 \
>>> +    -I$(SRC_PATH)/roms/SLOF/lib/libc/include/ \
>>
>> I'm not sure if it is just a problem with my setup, but with this 
>> patch applied I hit an error when running "make check-tcg --always-make"
>>
>>          In file included from 
>> /root/staging/qemu/tests/tcg/multiarch/ system/memory.c:17:
>>          /usr/include/inttypes.h:351:8: error: unknown type name 
>> ‘intmax_t’
>>            351 | extern intmax_t imaxabs (intmax_t __n) __THROW 
>> __attribute__ ((__const__));
>>
>> It seems to be cause by including the SLOF libc, because it works for 
>> me without that.
>>
>> For what it's worth, it worked until used I "--always-make", so if 
>> you aren't building all targets some change might not be picked up here.
>
> I don't see it locally, but I've hit the same problem in the CI:
>
>  https://gitlab.com/thuth/qemu/-/jobs/8156508094#L6090
>
> It seems to work for me, if I simply drop that 
> "-I$(SRC_PATH)/roms/SLOF/lib/libc/include/" line again and only use 
> the other -I line. I initially struggled a little bit with my 
> cross-compiler setup, that's why I thought I'd need the line, but I 
> think it is not required with a proper setup.
> Could you please check whether it works for you if you remove that line?
>
>  Thanks,
>    Thomas
>

Yes, it works for me too if I remove 
"-I$(SRC_PATH)/roms/SLOF/lib/libc/include/" and keep the other changes.

Regards,
     Jared Rossi

