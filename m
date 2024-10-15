Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F35ED1F9C2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 19:33:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0nI2-0007MV-1W; Tue, 15 Oct 2024 15:33:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1t0nI0-0007MC-K7
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 15:33:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1t0nHw-0003NB-LD
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 15:33:03 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49FIJHxv001188;
 Tue, 15 Oct 2024 19:32:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=P6xdwV
 xsM9/HVLbZuPbu1+BImNMwp80BylWPr9BikkQ=; b=BSOrbi5hmeaNVDe9Q78Mop
 i3wbkD1/lVlYu3jUk+VDAFvBBf9ImH5+JT51lu8gicUgsLyoI7hKvL18o/gQ2poz
 ZCHrOG1/k+CcN2yrOWOpKAcgZwvZDn/4hpLrwIZuih3fXqpG0sIv0P4ZyY5uJLIH
 fetqcq0NuOrj73h+m3nSBirofZikuAw31eENfD0+/avjO1RteFRmpP1Lv2atHUPG
 eNSBS732lzQ1mcxZNP+7sooKL3NoabkQasNOFM5kZmTA4x+g9s1TPP81yfVnDFmS
 lzcgEcJS/VfRtRBJksT93NOae8XQOmm2Y4xxNgnhKCiOIURtdYLJ5J6i6a67R9AA
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 429vrw8jj1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Oct 2024 19:32:56 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49FIF5QV002452;
 Tue, 15 Oct 2024 19:32:55 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4284emnmkq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Oct 2024 19:32:55 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 49FJWtR946662062
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 15 Oct 2024 19:32:55 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0872558056;
 Tue, 15 Oct 2024 19:32:55 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CC7E35803F;
 Tue, 15 Oct 2024 19:32:54 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 15 Oct 2024 19:32:54 +0000 (GMT)
Message-ID: <865424c1-f79c-44ad-b70f-8bf3e455e025@linux.ibm.com>
Date: Tue, 15 Oct 2024 15:32:54 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: tpm-tis-device-swtpm-test timeout
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
References: <87jze9qlrp.fsf@suse.de>
 <077cee03-efd0-4716-865a-b9990afb91a3@linux.ibm.com> <87h69dqigg.fsf@suse.de>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <87h69dqigg.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: s1rDkvqOzEdliA-EBmP3vjhxKLKAUGAH
X-Proofpoint-GUID: s1rDkvqOzEdliA-EBmP3vjhxKLKAUGAH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 phishscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 priorityscore=1501 mlxscore=0 clxscore=1015 spamscore=0 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410150131
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 10/15/24 3:22 PM, Fabiano Rosas wrote:
> Stefan Berger <stefanb@linux.ibm.com> writes:
> 
>> On 10/15/24 2:11 PM, Fabiano Rosas wrote:
>>> Hi Stefan,
>>>
>>> I see the tpm-tis-device-swtpm test timing out, could you take a look?
>>>
>>> qemu:qtest+qtest-aarch64 / qtest-aarch64/tpm-tis-device-swtpm-test time out (After 60.0 seconds)
>>> 135/138 qemu:qtest+qtest-aarch64 /
>>> qtest-aarch64/tpm-tis-device-swtpm-test TIMEOUT 60.01s killed by signal 11 SIGSEGV
>>
>> Is this something new or been happening for a while? Does it happen
>> consistently? I just build the master branch and ran the tests on a very
>> old machine, I mean 13 years old. The host runs Fedora 40 with
>> libtpms-0.96-6 + swtpm-0.9.0 from the distro:
> 
> It's the first time I see it. I can reproduce consistently by running
> that test in a loop while make -j16 check is running in another window.

So this here is failing for you every time?

QTEST_QEMU_BINARY=build/qemu-system-aarch64 
./build/tests/qtest/tpm-tis-device-swtpm-test

This test would start swtpm. Do you see it running while this test is 
running? It should show process like this running for a very short time 
obviously  [ while :; do ps aux | grep -v grep | grep swtpm; done ]:

stefanb  4087462  0.0  0.0  11040  3732 pts/6    S+   15:30   0:00 swtpm 
socket --tpmstate dir=/tmp/qemu-tpm-tis-device-swtpm-test.D3SLV2 --ctrl 
type=unixio,path=/tmp/qemu-tpm-tis-device-swtpm-test.D3SLV2/sock --tpm2
stefanb  4087467  0.0  0.0  11040  3660 pts/6    S+   15:30   0:00 swtpm 
socket --tpmstate dir=/tmp/qemu-tpm-tis-device-swtpm-test.H1SLV2 --ctrl 
type=unixio,path=/tmp/qemu-tpm-tis-device-swtpm-test.H1SLV2/sock --tpm2


> 
> I'm on openSUSE Leap 15.5:
> 
> $ rpm -qa | grep libtpms
> libtpms0-0.8.2-150300.3.9.1.x86_64
> 
> $ rpm -qa | grep swtpm
> swtpm-0.7.3-150500.2.1.x86_64
> 


