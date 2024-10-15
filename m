Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2B09D1F9C2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 18:59:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0mkY-0000dp-2J; Tue, 15 Oct 2024 14:58:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1t0mkV-0000dg-VO
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 14:58:28 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1t0mkT-0007kh-Ss
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 14:58:27 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49FIp1Pg030623;
 Tue, 15 Oct 2024 18:58:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=9q07z3
 M2I2HkZ/xWaoiMSEgiaGvIB1fC2kvNtH8zJkk=; b=ZqHkFrF2mGcN1MLP9sW3wc
 4p1JQzPEX9q5XO8KG9pQz+L9O1DZQzjR1DgNW5WeEslG4gFCgjxJ/bGD1WwWOq2e
 1vF8IgoKXsrtpWWzme2+U8u2ZhBnatV3puPyw1Ha9u25Ttm93BO8T1uq0FLqCew8
 FyRmw+Uj87ZFiyyhHdbN+Qda0XV/kleDXkcIezpARlVQTLX7or/CvEiLPhdEX7G+
 3U/BdqEz83A/Zl0diNBGZPIaIjgzff6uLonfAz1KmWB2zdD50A5cRoXrpNkqTAsN
 VR3HS7tXiU0N9o8xEw//OsbZwX9kTK483ON6uAs/IHoioFjFlnczvQTR4aeyENcw
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 429x17g133-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Oct 2024 18:58:23 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49FI6W3m006757;
 Tue, 15 Oct 2024 18:58:22 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4284xk5cfd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Oct 2024 18:58:22 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 49FIwMBH44630412
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 15 Oct 2024 18:58:22 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ED1F65803F;
 Tue, 15 Oct 2024 18:58:21 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EF91758056;
 Tue, 15 Oct 2024 18:58:16 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 15 Oct 2024 18:58:16 +0000 (GMT)
Message-ID: <077cee03-efd0-4716-865a-b9990afb91a3@linux.ibm.com>
Date: Tue, 15 Oct 2024 14:58:16 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: tpm-tis-device-swtpm-test timeout
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
References: <87jze9qlrp.fsf@suse.de>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <87jze9qlrp.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: o4Jo56U3OKex7BjqDRQvCR7IOX50OB1r
X-Proofpoint-GUID: o4Jo56U3OKex7BjqDRQvCR7IOX50OB1r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 clxscore=1011
 adultscore=0 spamscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410150126
Received-SPF: pass client-ip=148.163.158.5; envelope-from=stefanb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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



On 10/15/24 2:11 PM, Fabiano Rosas wrote:
> Hi Stefan,
> 
> I see the tpm-tis-device-swtpm test timing out, could you take a look?
> 
> qemu:qtest+qtest-aarch64 / qtest-aarch64/tpm-tis-device-swtpm-test time out (After 60.0 seconds)
> 135/138 qemu:qtest+qtest-aarch64 /
> qtest-aarch64/tpm-tis-device-swtpm-test TIMEOUT 60.01s killed by signal 11 SIGSEGV

Is this something new or been happening for a while? Does it happen 
consistently? I just build the master branch and ran the tests on a very 
old machine, I mean 13 years old. The host runs Fedora 40 with 
libtpms-0.96-6 + swtpm-0.9.0 from the distro:

104/473 qemu:qtest+qtest-aarch64 / 
qtest-aarch64/tpm-tis-device-swtpm-test           OK               2.32s 
   2 subtests passed

I see some other non-TPM tests timing out but not this one. Same result 
for TIS test on 2nd run.

104/473 qemu:qtest+qtest-aarch64 / 
qtest-aarch64/tpm-tis-device-swtpm-test           OK               2.51s 
   2 subtests passed

3rd run:

104/473 qemu:qtest+qtest-aarch64 / 
qtest-aarch64/tpm-tis-device-swtpm-test           OK               2.37s 
   2 subtests passed

4th run:

104/473 qemu:qtest+qtest-aarch64 / 
qtest-aarch64/tpm-tis-device-swtpm-test           OK               2.63s 
   2 subtests passed



If I run it as a single test on the command line like this then it 
consistently works here - I ran it >10 times now.

$ QTEST_QEMU_BINARY=build/qemu-system-aarch64 
./build/tests/qtest/tpm-tis-device-swtpm-test
TAP version 13
# random seed: R02S8155b3cf024c2696e895e5f548396138
1..2
# Start of aarch64 tests
# Start of tpm tests
# Start of tis-swtpm tests
# starting QEMU: exec build/qemu-system-aarch64 -qtest 
unix:/tmp/qtest-3738308.sock -qtest-log /dev/null -chardev 
socket,path=/tmp/qtest-3738308.qmp,id=char0 -mon 
chardev=char0,mode=control -display none -audio none -machine 
virt,gic-version=max -accel tcg -chardev 
socket,id=chr,path=/tmp/qemu-tpm-tis-device-swtpm-test.YEUOV2/sock 
-tpmdev emulator,id=dev,chardev=chr -device tpm-tis-device,tpmdev=dev 
-accel qtest
ok 1 /aarch64/tpm/tis-swtpm/test
# slow test /aarch64/tpm/tis-swtpm/test executed in 0.66 secs
# End of tis-swtpm tests
# Start of tis-swtpm-migration tests
# starting QEMU: exec build/qemu-system-aarch64 -qtest 
unix:/tmp/qtest-3738308.sock -qtest-log /dev/null -chardev 
socket,path=/tmp/qtest-3738308.qmp,id=char0 -mon 
chardev=char0,mode=control -display none -audio none -machine 
virt,gic-version=max -accel tcg -chardev 
socket,id=chr,path=/tmp/qemu-tpm-tis-device-swtpm-test.YEUOV2/sock 
-tpmdev emulator,id=dev,chardev=chr -device tpm-tis-device,tpmdev=dev 
-accel qtest
# starting QEMU: exec build/qemu-system-aarch64 -qtest 
unix:/tmp/qtest-3738308.sock -qtest-log /dev/null -chardev 
socket,path=/tmp/qtest-3738308.qmp,id=char0 -mon 
chardev=char0,mode=control -display none -audio none -machine 
virt,gic-version=max -accel tcg -chardev 
socket,id=chr,path=/tmp/qemu-tpm-tis-device-swtpm-test.V9TOV2/sock 
-tpmdev emulator,id=dev,chardev=chr -device tpm-tis-device,tpmdev=dev 
-incoming unix:/tmp/qemu-tpm-tis-device-swtpm-test.YEUOV2/migsocket 
-accel qtest
ok 2 /aarch64/tpm/tis-swtpm-migration/test
# slow test /aarch64/tpm/tis-swtpm-migration/test executed in 1.10 secs
# End of tis-swtpm-migration tests
# End of tpm tests
# End of aarch64 tests




> 
> (gdb) bt
> #0 0x00005654e7ac4872 in tpm_tis_transfer (s=0x5654e7dec570, req=0x5654e7b42410 <tpm_pcrread> "\200\001", req_size=21, rsp=0x7ffd2295ca00 '\377' <repeats 200 times>..., rsp_size=1024) at ../tests/qtest/tpm-tis-util.c:490
> #1 0x00005654e7ac1879 in tpm_util_pcrread (s=0x5654e7dec570, tx=0x5654e7ac467a <tpm_tis_transfer>, exp_resp=0x5654e7b42620 <tpm_pcrread_resp> "\200\001", exp_resp_size=63) at ../tests/qtest/tpm-util.c:96
> #2 0xffffffffffffffff in ?? ()
> ...
> 
> (gdb) l
> 485         sts = qtest_readl(s, TIS_REG(0, TPM_TIS_REG_STS));
> 486         bcount = (sts >> 8) & 0xffff;
> 487
> 488         memset(rsp, 0, rsp_size);
> 489         for (i = 0; i < bcount; i++) {
> 490             rsp[i] = qtest_readb(s, TIS_REG(0, TPM_TIS_REG_DATA_FIFO));
> 491         }
> 492
> 493         /* relinquish use of locality 0 */
> 494         qtest_writeb(s, TIS_REG(0, TPM_TIS_REG_ACCESS),
> (gdb) p rsp_size
> $5 = 1024
> (gdb) p bcount
> $6 = 65535
> 
> Thanks!
> 

