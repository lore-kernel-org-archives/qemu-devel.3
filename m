Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14807F417F3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 16:18:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzdIa-0007pk-J7; Mon, 09 Mar 2026 12:17:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1vzdIP-0007mE-4S; Mon, 09 Mar 2026 12:17:29 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1vzdIL-0003ms-Ii; Mon, 09 Mar 2026 12:17:28 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 629GEiJE1554633; Mon, 9 Mar 2026 16:17:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=ElG+qh
 R292rULm3egNwxjGTJKEc0DrnsfbbnQo6B+nY=; b=HuJZPGDIZDh3u25DTkyaO3
 O2nlyTpz+IWidGAUyxauGlUikhkvy/KrgtUpooHQ74L6HUeaiRTqJkWV4+ypiRNJ
 I4tcNwDYybMqxKO1+/Yyi2SthwUYS/3Dcog/1+i/wtEdQPy8ge8zghwk2a6FnmXc
 h25DfFzrQ5MFdC+DzHC+XCPuYYxbuPaCzlseM9NposdYGszjUo1yrUeBHwdanJOm
 LXOBDWy4DQHc8y0/y6GtdXjsSHJjIWvjqlL8hQA6SzODAhiAnVnmO2+LkJiKJIr7
 /EFijiWEPeFVMebnxxjXau0917V0sFsaS87T7K75IsREPlqb6oLITl/ADPooQKVA
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crd1mf59f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Mar 2026 16:17:23 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 629E6dKY021521;
 Mon, 9 Mar 2026 16:17:22 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4crxbsntc5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Mar 2026 16:17:22 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 629GHKFD40174172
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 9 Mar 2026 16:17:21 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DABDB58056;
 Mon,  9 Mar 2026 16:17:20 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 418685803F;
 Mon,  9 Mar 2026 16:17:20 +0000 (GMT)
Received: from [9.61.138.24] (unknown [9.61.138.24])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  9 Mar 2026 16:17:20 +0000 (GMT)
Message-ID: <19a72bb3-6852-4d32-aef7-545525b8b2f1@linux.ibm.com>
Date: Mon, 9 Mar 2026 12:17:19 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/15] s390x: Add support for virtio-blk-pci IPL device
To: Thomas Huth <thuth@redhat.com>, jrossi@linux.ibm.com,
 qemu-devel@nongnu.org, qemu-s390x@nongnu.org, mst@redhat.com
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
 zycai@linux.ibm.com
References: <20260309003601.242634-1-jrossi@linux.ibm.com>
 <4bef56aa-8b2c-43c7-9449-fea7c31d00b2@linux.ibm.com>
 <2e5a8e6a-6513-4726-b43d-5933427f524c@redhat.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <2e5a8e6a-6513-4726-b43d-5933427f524c@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=ds3Wylg4 c=1 sm=1 tr=0 ts=69aef293 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=Ci8l2pZZUM2kTSr-spoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDE0NSBTYWx0ZWRfX5gP/LKs23rX6
 4/pcXHmQ2bY1I5jr1zJ0GJ43cw+22RwrDK05hbbl16GEK39DU/Wi5M3OLLqH+rO4lIFWH6w8+3u
 B9lsaKRq60P0fDeOhLMF9MTodn+v2ils9+o8JpLzUDMlGXX2F/5ZQCcjdBiP8PPI1lR7GBQsYQK
 CKl05KSOqusiP52aZJDLBvMScVTVEjpWKsUC0cdHYS/K+XlVaUJadySHFn6lWOjWTMMUQHqTpGU
 U8hBoxxuR4lq1s4f25JpoOL9B3PDKmEN91XnNqxaSsao5BVyEqQuGMlhjc8EUXXJPpL2zy0JI3Q
 g2Oa01tIbhRCsKNFAGnlPqIIzH0Mhxdg9W3oSVJEOA14O0X9zNvSCa+EjWU43Tj4JkdCJRWPGoE
 F+j0bEiwY9pmmugqUsO/U8QbRDGE3694mHkAuIhizINBDmAmCbo1x1uO+jk8bkPrkXLF0njTPRP
 4dRmZjmZ4kTRUIIR1BQ==
X-Proofpoint-GUID: oP1tgVQs1vao1DYFfz1veWX_LzOkI-5J
X-Proofpoint-ORIG-GUID: oP1tgVQs1vao1DYFfz1veWX_LzOkI-5J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_04,2026-03-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090145
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 3/9/26 11:40 AM, Thomas Huth wrote:
> On 09/03/2026 15.00, Matthew Rosato wrote:
>> On 3/8/26 8:35 PM, jrossi@linux.ibm.com wrote:
>>> From: Jared Rossi <jrossi@linux.ibm.com>
>>>
>>> This patch series introduces an IPLB subtype to support PCI devices, which may
>>> be built if a device has been assigned a boot index and is identified as a PCI
>>> device with a corresponding s390 PCI Bus device.
>>>
>>> Boot support is only added for virtio-blk-pci at this time and is limited to
>>> devices with an assigned bootindex.
>>>
>>> A "loadparm" property is added to virtio-blk-pci boot devices on s390x.
>>>
>>> A simple test to check basic functionality is added to the cdrom-tests in qtest.
>>>
>>> Changes v4 -> v5:
>>>      - Fix incorrect switch/case for virtio block device ID
>>>      - Use target_s390x() instead of qemu_arch_available(QEMU_ARCH_S390X)
>>>      - Properly denote switch fallthrough
>>>      - Remove reduntant RC checks in PCI read/write
>>>
>>
>> Rather than reply to individual patches, I noticed new copyright lines with 2025 dates on the following patches that should be updated to 2026:
>>
>> 6: pc-bios/s390-ccw: Split virtio-ccw and generic virtio
>> 8: pc-bios/s390-ccw: Introduce CLP Architecture
>> 10: pc-bios/s390-ccw: Introduce PCI device
>> 11: pc-bios/s390-ccw: Introduce virtio-pci functions
>>
>> Thomas, if there are no further comments would you still like Jared to respin for that kind of change or would you just fix up when you pick up the series?
> 
> I've seen different opinions on the year in copyright statements in the past (also from various people from IBM) - some say, it should be the year when the code was written/initially posted, some say, it should be the year when the code gets merged ... I personally don't mind too much anymore. For me, it's also ok if we keep the 2025.
> 
> Anyway, tomorrow (Tuesday) is softfreeze, so I'm going to send a pull request for this series tomorrow - let me know by then if you want me to fix up the year, or if you rather prefer to keep 2025.
> 

I actually wonder why we have the year at all (besides convention)...  But I do not have a strong opinion about it and was checking about a re-spin exactly because of soft freeze.

If you are OK with 2025 then that is also fine by me, leave it as-is.  

Thanks,
Matt

