Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5893C83F17
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Jul 2025 22:21:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uehoy-0007jx-8K; Wed, 23 Jul 2025 18:20:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1uehov-0007gh-L2; Wed, 23 Jul 2025 18:20:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1uehot-0003KD-M6; Wed, 23 Jul 2025 18:20:17 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56NFF8wC027835;
 Wed, 23 Jul 2025 22:20:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=YN2teq
 c4F1X47HCE/PlkuRLgY0GqZ1ReQowyPxlquW0=; b=e9Obr/9IhNIkI2SZgzYnil
 y0121EeMKKWf1/HX3MPvzjzOWY1zAqkJfDzCSch9pK95yGwGnl1o/6amzEdfQ5C2
 go5jEY+BW5TCWt5BpCq4LOiWAeCf1/lRSD/Kli7e7+iuTCTgCZBS8XwajLdyclDt
 iQwsB52CaT6DnaF1X5mgf95274EEn18EKLczemRZI/UwcEFTh3GcN5ccazVhRO1o
 Sk1j6tMtrrNsnBc8tw5V14OPbS05ciIZVKv4OcwmeGLD79piO2fAEFsqT/dwVXif
 kfzfB27l+vG1CeL1qqG5e5vC1ru0TQMOD8QI/O+Pv9JcYxLJN3ewTE0xZnMRRDhw
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 482ff5qanx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 23 Jul 2025 22:20:13 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56NLWOCA005445;
 Wed, 23 Jul 2025 22:20:12 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 480tvr0y46-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 23 Jul 2025 22:20:12 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 56NMKBJd9962158
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 23 Jul 2025 22:20:11 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 477CA58058;
 Wed, 23 Jul 2025 22:20:11 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EFC4858061;
 Wed, 23 Jul 2025 22:20:09 +0000 (GMT)
Received: from [9.12.68.85] (unknown [9.12.68.85])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Wed, 23 Jul 2025 22:20:09 +0000 (GMT)
Message-ID: <8fea0206-180c-468a-bbfe-4cc1244afc54@linux.ibm.com>
Date: Wed, 23 Jul 2025 18:20:09 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/28] s390x/diag: Implement DIAG 320 subcode 1
From: Collin Walling <walling@linux.ibm.com>
To: Zhuoying Cai <zycai@linux.ibm.com>, thuth@redhat.com, berrange@redhat.com, 
 richard.henderson@linaro.org, david@redhat.com, pbonzini@redhat.com,
 jrossi@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com
References: <20250711211105.439554-1-zycai@linux.ibm.com>
 <20250711211105.439554-8-zycai@linux.ibm.com>
 <6bc858c5-ad3a-4445-900f-5aba34011553@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <6bc858c5-ad3a-4445-900f-5aba34011553@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDE5MCBTYWx0ZWRfXyKOOQsnUr9OG
 EFVtkz7eFAYjAfhEza6eFRVKoGhYbYvk998veq039yj0HUSlQBIaTqUfgDkoxSabkPt9RYANhQb
 tPFb5Vc0fYSUEv4LcmVAfQ762f0QMBVWl2/6UZeAXrVnKfzJViZXghbG/qAnY3Zw1WEQ2P3F1DK
 bjonCuA3WRlD63UquO9IvG1A47Nj+bjAV6lu/DNlcJTfw5tMAzh0bM96gad92x0LJK0sz5Dsgj4
 v0qRuGVjju25q6KBLWtzttc5AtkP8Yx+ZdwAI64nyLXpv43xVz09OCbvgNxv9wigUx1phG4TvzI
 ByoSIebq8W/Fmwq2XalqMRas4MeQ7ZwD1eTptBiNtjakQCC+HqeAvlx/vznOzzjfxNVE4Myd7N5
 W4yDOoDVb/7fKXtMxV6/kfQrQ5jQ/aDWpPFL+SSQ+6Vh2rQVn5rpbx1jJJK9o2H30bDX2zbU
X-Authority-Analysis: v=2.4 cv=evLfzppX c=1 sm=1 tr=0 ts=6881601d cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=do-8Exzwan7GSTbcn_MA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: uJqrsKbvTiCLxVct0aG1zCltlXMB00xN
X-Proofpoint-ORIG-GUID: uJqrsKbvTiCLxVct0aG1zCltlXMB00xN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_03,2025-07-23_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 spamscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 mlxscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 mlxlogscore=957 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507230190
Received-SPF: pass client-ip=148.163.158.5; envelope-from=walling@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 7/23/25 18:15, Collin Walling wrote:
> On 7/11/25 17:10, Zhuoying Cai wrote:
>> DIAG 320 subcode 1 provides information needed to determine
>> the amount of storage to store one or more certificates.
>>
>> The subcode value is denoted by setting the left-most bit
>> of an 8-byte field.
> 
> This is general DIAG knowledge.  Remove this sentence.
> 
>>
>> The verification-certificate-storage-size block (VCSSB) contains
>> the output data when the operation completes successfully.
>>
> 
> Please add more detail describing where the data that the VCSSB gets
> filled with comes from (s390 cert store), how this subcode is useful
> (e.g. getting num of certs, knowing how much space may need to be
> allocated to store a cert).
> 
> There are some #defines for the VCE (cert entries) and VCB (subcode 2
> data structure).  Please elaborate on them in the commit message.
> 

This may get satisfied when merging in the relevant documentation from
patch 28, but it's still good practice to summarize things in the commit
message.


-- 
Regards,
  Collin

