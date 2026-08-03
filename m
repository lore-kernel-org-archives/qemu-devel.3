Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAA82C55184
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2026 16:03:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqv7U-0001uR-Vb; Mon, 03 Aug 2026 12:02:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <freude@linux.ibm.com>)
 id 1wqv7T-0001o1-9V; Mon, 03 Aug 2026 12:02:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <freude@linux.ibm.com>)
 id 1wqv7R-0000wn-6g; Mon, 03 Aug 2026 12:02:27 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 673EHidi2201838; Mon, 3 Aug 2026 16:02:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=Iyj9crm+VRLjWm5bjVht9K0DwiaObMDuJ27TTpmbIKE=; b=PpR000OXDWho
 f8uq8i1vCtZCIbTnRXOKQB67y1nnAnaemd7mNN/xe2urYwMzMPKGgLk9stzOV58R
 aJzTssGF44eBsL5//f+7AJEOpAaepUHBFmNMFbkdyFEm0rrzFwVqwS/yF7/y982D
 9CefP1FTPeCwbRUOlAO1eDsPBW1PqZJXoq5fqqt7l1pDXJUzIRPJ4RrNhQR2u4Hj
 Hvi2aXs+ZwRhGwytW4jg6GqRnAx3LcaAJH9dxTaI5WKWY2p8tBNwlmiCdz1Kxsk6
 L2GhDzInZjeuhCRFlE5DsAkO47Do4LHDeok1+VLVEnbONtoD8l6tLQ3CsRkrKnsv
 dr/1pid1cg==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs67hhmhn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Aug 2026 16:02:18 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 673FuJGt022293;
 Mon, 3 Aug 2026 16:02:17 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswbg5wy5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Aug 2026 16:02:17 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 673G2GIj14025444
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 3 Aug 2026 16:02:16 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 138D958063;
 Mon,  3 Aug 2026 16:02:16 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 05F2158052;
 Mon,  3 Aug 2026 16:02:15 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  3 Aug 2026 16:02:14 +0000 (GMT)
MIME-Version: 1.0
Date: Mon, 03 Aug 2026 18:02:14 +0200
From: Harald Freudenberger <freude@linux.ibm.com>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: richard.henderson@linaro.org, david@kernel.org, thuth@redhat.com,
 berrange@redhat.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 linux-s390@vger.kernel.org, dengler@linux.ibm.com,
 borntraeger@linux.ibm.com, fcallies@linux.ibm.com, cohuck@redhat.com
Subject: Re: [PATCH v12 17/17] tests/tcg/s390x: Add tests for CPACF
 instructions
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <33187980-d8d8-43f4-a138-34c67fa63d8b@linux.ibm.com>
References: <20260710152906.80207-1-freude@linux.ibm.com>
 <20260710152906.80207-18-freude@linux.ibm.com>
 <33187980-d8d8-43f4-a138-34c67fa63d8b@linux.ibm.com>
Message-ID: <72aea3ecd43734528217857025ed8540@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDE0MSBTYWx0ZWRfX1vWLjRirQPdb
 +Kb2PCikWC8IX8LEkwJHR8ae9KkS3Yjipbb16exog+vyEVRhdDAmBmutBUP/JqrS5qdIVLsi3Qt
 tvRh7PEwZAxPCuZDS632h2rSH6YaYcM=
X-Authority-Analysis: v=2.4 cv=I7VVgtgg c=1 sm=1 tr=0 ts=6a70bb8a cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=woZNQi_L4tNMqXH-QfIA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDE0MSBTYWx0ZWRfX/AOgi5Dt1bLK
 uyU5e33y75lQHGKh9tQYxLQDZVKQzo83yxDekDCQDCGtk55EE4CSurVx/A36X+i4BruJqnbJO6E
 DjtxrWBA65Wye5ThAV38oKOqfH9vS4Vv+tAVoCqXvqZolRtgZEM6VFEra3NRk6d1KSjtPy9TyYu
 CP8z2ItTRvOlNlyraS56XBJvvaLD7cJiV8fCa2Gpuwlfr8z4XaWNbtspdAL3L6D33ZZHEghh+zK
 EzPUKK/qUwuFAZ1NinABISa7k+5nDP3e+LsPMKrMe7fQqLR/UG/MIVa1kTFnbweBCSb4uowYr1g
 ihMpQyzhd40O9h8v//DuB1FbbE2NQP/GxOakhKsOpZDMNNSoU8Kp65nxJDQuj33UD1Zuiag5Hse
 yASTziMUmy1G3j7ujlCKoE9ATlinVxr6NSllRO/90Ps3tfTqzJaydOIBARHlSdNV1+egTsbpwZR
 9GOD93jAsIafKlERwLw==
X-Proofpoint-ORIG-GUID: biStc7ri1XmccvK00SEhB5y-NX8aWkIf
X-Proofpoint-GUID: biStc7ri1XmccvK00SEhB5y-NX8aWkIf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_03,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030141
Received-SPF: pass client-ip=148.163.158.5; envelope-from=freude@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: freude@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2026-07-14 14:01, Ilya Leoshkevich wrote:
> On 7/10/26 17:29, Harald Freudenberger wrote:
>> Add simple tests for the CPACF instructions implemented:
>> - kdsa - minimal as only query is implemented
>> - kimd - query, sha256, sha512
>> - klmd - query, sha256, sha512
>> - km - query, aes 128, 192, 256 with clear and prot key
>> - kmac - minimal as only query is implemented
>> - kmc - query, aes 128, 192, 256 with clear and prot key
>> - kmctr - query, aes 128, 192, 256 with clear and prot key
>> - pcc - query, xts aes 128, 256 and prot key xts aes 128, 256
>> - prno - query, trng
>> No test for pckmo as this is a privileged instruction.
>> No test for kma, kmf, kmo as these instructions are currently
>> not implemented at all.
>> 
>> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
>> ---
>>   target/s390x/tcg/cpacf.h        |   7 +
>>   tests/tcg/s390x/Makefile.target |   9 +
>>   tests/tcg/s390x/cpacf-kdsa.c    |  58 ++++
>>   tests/tcg/s390x/cpacf-kimd.c    | 166 +++++++++
>>   tests/tcg/s390x/cpacf-klmd.c    | 206 +++++++++++
>>   tests/tcg/s390x/cpacf-km.c      | 590 
>> ++++++++++++++++++++++++++++++++
>>   tests/tcg/s390x/cpacf-kmac.c    |  58 ++++
>>   tests/tcg/s390x/cpacf-kmc.c     | 351 +++++++++++++++++++
>>   tests/tcg/s390x/cpacf-kmctr.c   | 360 +++++++++++++++++++
>>   tests/tcg/s390x/cpacf-pcc.c     | 245 +++++++++++++
>>   tests/tcg/s390x/cpacf-prno.c    | 131 +++++++
>>   tests/tcg/s390x/cpacf.h         | 571 
>> +++++++++++++++++++++++++++++++
>>   12 files changed, 2752 insertions(+)
>>   create mode 100644 tests/tcg/s390x/cpacf-kdsa.c
>>   create mode 100644 tests/tcg/s390x/cpacf-kimd.c
>>   create mode 100644 tests/tcg/s390x/cpacf-klmd.c
>>   create mode 100644 tests/tcg/s390x/cpacf-km.c
>>   create mode 100644 tests/tcg/s390x/cpacf-kmac.c
>>   create mode 100644 tests/tcg/s390x/cpacf-kmc.c
>>   create mode 100644 tests/tcg/s390x/cpacf-kmctr.c
>>   create mode 100644 tests/tcg/s390x/cpacf-pcc.c
>>   create mode 100644 tests/tcg/s390x/cpacf-prno.c
>>   create mode 100644 tests/tcg/s390x/cpacf.h
> 
> I get failures when running these on a real z17, for example:
> 
> $ ./cpacf-kdsa
> test_kdsa_query failed
> cpacf-kdsa: 1 failures

I've reworked the testcases - see v13 coming soon.
The query function now compares against the minimal expected
subfunction set but does not fail if there are more subfunctions
available. However, the tests will still fail when run on real
hardware when it comes to protected key related operations.

