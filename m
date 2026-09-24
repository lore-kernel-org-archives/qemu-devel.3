Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FD0AC98310
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 07:21:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9dlm-00069a-Mr; Thu, 24 Sep 2026 03:21:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@de.ibm.com>)
 id 1x9dll-00068o-5W; Thu, 24 Sep 2026 03:21:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@de.ibm.com>)
 id 1x9dli-0007mQ-QL; Thu, 24 Sep 2026 03:21:24 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68O5bUnH159982; Thu, 24 Sep 2026 07:21:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=bLuhdA
 /SE5yusO0HelyQxg+E+84TiToBLAvzRiGDgUM=; b=QEZapxs1DA772IbxLLUanO
 /FlZNxONYKwcgrKO035KBTSGxLVBhTaLdIxJbijhFN66TwK48MecCzplqDt3EpGA
 OYD3baElJaP4QAyKeJoUr10LbeiUZXK+Qnquh0J0+3RakG9s/1BFxET9wOS7hSsn
 jpi7w6CdsngDByILmLG/uYhFRB2Gh9ptzZcyr3Ry8qqOfseXYgPwEVwgb+Rqb8rJ
 U5bE6TEQE30N+kDthifKaELvk5p4f5w9nEYRXtstSLl5dgUYNp1f2OwartCorW5j
 hrcIuI+tGdmSe81PsGNE+66Mxl2Ioz4G2whlNksbFJ6v+S6FEqOfRDh3NM863FRA
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgqpv9j-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 07:21:18 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68O5lUEu1539501; Thu, 24 Sep 2026 07:21:18 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbe1vk6t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 07:21:18 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68O7LEX447841728
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Sep 2026 07:21:14 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3756620043;
 Thu, 24 Sep 2026 07:21:14 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BCD7020040;
 Thu, 24 Sep 2026 07:21:13 +0000 (GMT)
Received: from [9.224.77.173] (unknown [9.224.77.173])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 24 Sep 2026 07:21:13 +0000 (GMT)
Message-ID: <cf1e54be-aa00-4f5d-89a3-cc710ec6f99e@de.ibm.com>
Date: Thu, 24 Sep 2026 09:21:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] s390x: Expose pv attribute in QOM
To: Matthew Rosato <mjrosato@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, brueckner@linux.ibm.com, cohuck@redhat.com,
 farman@linux.ibm.com, david@kernel.org, iii@linux.ibm.com,
 richard.henderson@linaro.org
References: <20260923083406.64128-1-frankja@linux.ibm.com>
 <4b4de309-7ba7-45a0-a485-e9474d2732b6@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@de.ibm.com>
In-Reply-To: <4b4de309-7ba7-45a0-a485-e9474d2732b6@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=G+OJgNk5 c=1 sm=1 tr=0 ts=6ab4cf6e cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=dpsumrQSPbuwYy20ZNMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDAzMCBTYWx0ZWRfX/t2LSIVL02AJ
 XDzIuNGvCxFhRS5WLLdpydDG11tpb6e2XuVojp+smqhVpo/HqsMGs/bNFo+0Zqd/7LDpPptMHTs
 NHW6f4c8s++1FwG2D0gXiUw1NclsAeCV2L0Vz1VwBeha3X4+hXegXoroMaDw8ubdpzzSduAGy/t
 b5bFlt3ZTO38IYq1N5s+c3OnlQxbhK5YmhT74i0FvP//05IcIEsC5D14VuWU/rdd3BtKRrQ4PTP
 eR7Qf7VPDP3up/3I8XH0Oy80/nIo0odXySnpkSIjg9lSl/B7CWL5MYdrS8gqh/+y8D25UDTgt3B
 5Ib609JiM2JS0KFgtR+xz5BljP7M/Qzy5OkIdKDn5vlCilX9ygJIAqC9JTqmEjFp8L+gZd694PH
 s+FKCmRPSXOLUAtRw9uBRhYtqZsnUDs+5mMTuBS3XZEXd1ZWwMBCIeH5Tt81a7uSwyrS5LUWejL
 gNag0kdYAga1/lVlytg==
X-Proofpoint-ORIG-GUID: H5MSU9-7JfwjUKU3-B6B5KCTstSXrDxR
X-Proofpoint-GUID: H5MSU9-7JfwjUKU3-B6B5KCTstSXrDxR
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDAzMCBTYWx0ZWRfX993xvSmwT/XD
 czNuh3Q97r4zo1ZZXzBN6rGiW/hn6F2nBjStdHJGsFdL1VoLDFRBwBVobIWf2w1JVrvaGcoZKXD
 MD1Z1FBxGfU8mBb5C3s3qRzzcesWl2o=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240030
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=borntraeger@de.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



Am 23.09.26 um 23:44 schrieb Matthew Rosato:
> On 9/23/26 4:33 AM, Janosch Frank wrote:
>> People doing VM management requested a way to query if a VM is in PV
>> or not. This of course does never replace attestation, it's merely
>> QEMU's view of the situation.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> CC: Hendrik Brueckner <brueckner@linux.ibm.com>
> 
> I wondered for a bit about migration, but seeing as it's fenced for pv I
> think the only weird scenario would be migrating to an older QEMU using
> a pre-11.2 machine type and go from being able to see the attribute read
> 'false' to no longer being able to see the attribute with the same qemu
> command line.
> 
> Do you think that would matter for tooling e.g. do we need tie the
> visibility of the property to 11.2+ machine?

I dont think so
- Whether the property exists depends on the QEMU binary, not the machine type. Tools find it with qom-list.
- The command line can't change, because the property can't be set.
- Other read-only properties aren't tied to machine versions either, e.g. spapr vfio-no-msix-emulation


