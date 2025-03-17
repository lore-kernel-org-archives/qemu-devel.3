Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86681C282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 06:52:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tu4Kc-0007Tp-UJ; Mon, 17 Mar 2025 02:52:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1tu4Jm-0006qt-Oa; Mon, 17 Mar 2025 02:51:22 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1tu4Jj-0000zJ-5q; Mon, 17 Mar 2025 02:51:22 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52GNIAcJ024773;
 Mon, 17 Mar 2025 06:51:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=iA4I9c
 /upNAOZwuQflRq+mpjNDpROdDCgp2iI7dKarU=; b=qwT0SMzZleybXIKrFayQ1F
 2hMsjMFuJlOxTU1fT2T97OPaVuJlb8ifzsfbxprTahPEWPXEtqzGZbjhSqjwKpq4
 U+6RYlA/nfIA5Q3g3GvhR34sKKA33ujB8z0aCsIkLICgZNy27ko8RWwSQNTBtMN9
 2LjRXiv0qT88IDa8C+tgzsThWq8KAfsSensy2hJhCxABfUiT12klZBDJzgXfET+u
 eQo9VFvpn29X/c/2uUqEpbKnQrn6uKCzPebvdoR/bw0LTF59lTkOwy9SBo1f5dsy
 Qxy9PAT1nifLqqJmK1mBN2dv5QM6kp9+NbuRt+SMzYTCVDMQ3FgmmggS4YuD/PBw
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45e5v01q2y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Mar 2025 06:51:16 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52H6pFsH012410;
 Mon, 17 Mar 2025 06:51:15 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45e5v01q2v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Mar 2025 06:51:15 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52H6eAwE005803;
 Mon, 17 Mar 2025 06:51:14 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 45dpk24ed9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Mar 2025 06:51:14 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 52H6pBf758720746
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Mar 2025 06:51:11 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 575BB20043;
 Mon, 17 Mar 2025 06:51:11 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F1F4E20040;
 Mon, 17 Mar 2025 06:51:08 +0000 (GMT)
Received: from [9.109.199.160] (unknown [9.109.199.160])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 17 Mar 2025 06:51:08 +0000 (GMT)
Message-ID: <9eaf6719-ce8f-4d38-8ae3-b23506d69fe2@linux.ibm.com>
Date: Mon, 17 Mar 2025 12:21:07 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 8/8] tests/functional: Add test for fadump in PSeries
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>
References: <20250315064636.611714-1-adityag@linux.ibm.com>
 <20250315064636.611714-9-adityag@linux.ibm.com>
 <8dad5654-6d0a-4045-abb1-2dee489f3102@redhat.com>
Content-Language: en-US
From: Aditya Gupta <adityag@linux.ibm.com>
In-Reply-To: <8dad5654-6d0a-4045-abb1-2dee489f3102@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 9FD0aNJPtOWEcGCfQ6wIOjg0bcLQmlez
X-Proofpoint-GUID: rjFpq_wo77EY_n7I-guM7QbNlZHSl69R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-17_02,2025-03-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0
 impostorscore=0 adultscore=0 mlxscore=0 spamscore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503170045
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Hi Thomas,

On 17/03/25 11:55, Thomas Huth wrote:
>  Hi!
>
> On 15/03/2025 07.46, Aditya Gupta wrote:
>> Add testcases for testing fadump with PSeries and PSeries+KVM
>> combinations
> ...
>> diff --git a/tests/functional/test_ppc64_fadump.py 
>> b/tests/functional/test_ppc64_fadump.py
>> new file mode 100755
>> index 000000000000..3d6d3734e243
>> --- /dev/null
>> +++ b/tests/functional/test_ppc64_fadump.py
>> @@ -0,0 +1,185 @@
>> +#!/usr/bin/env python3
>
> scripts/checkpatch.pl recently got a check for SPDX license tags, so 
> please add a SPDX-License-Identifier here now to avoid a warning when 
> the script is run with your patch.
>
Sure, don't know how I missed it. Will fix it.


>> <...snip...>
>>
>> +    @skipUnless(platform.machine().startswith("ppc64"),
>> +                "KVM tests require the same host and guest 
>> architecture")
>
> I think this is likely unreliable: The test could run on a ppc64 host, 
> but KVM could still be unavailable, e.g. if it has been disabled in 
> the kernel. It's better to use self.require_accelerator("kvm") instead 
> (which will also skip the test if it is not available).
>
Thanks, agreed, will remove it, and add self.require_accelerator("kvm").
>
> Also, shouldn't there be a "-accel kvm" somewhere if you really want 
> to be sure to enable KVM ?
>
Will add it, this whole time I thought it's using kvm, guess the tests 
were running in tcg mode only.
>> +    def test_fadump_pseries_kvm(self):
>> +        """
>> +        Test Fadump in PSeries with KVM accel
>> +        """
>> +        self.do_test_fadump(is_kvm=True, is_powernv=False)
>> +
>> +if __name__ == '__main__':
>> +    if os.getenv("DEBUG"):
>> +        logging.basicConfig(level=logging.DEBUG)
>
> The setUp function in QemuSystemTest already sets the log level to 
> DEBUG, so this should not be necessary?
>
I did that to see the QEMU VM booting logs. I see in QemuSystemTest, it 
sets the log level of some loggers to DEBUG, don't know if it's the 
same, as I didn't see the boot logs during testing (also, in 
QemuSystemTest, we are setting specific loggers to DEBUG, while I did 
.basicConfig to DEBUG which I think is like a global debug level setting)

How do I get the system booting logs in `make check` ? I didn't find it 
in the docs.


Thanks,

Aditya Gupta

>  Thomas
>

