Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63A61CA6015
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 14:21:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFBTQ-00072z-6j; Fri, 09 Oct 2026 10:21:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1xFBMg-0004mb-Nx; Fri, 09 Oct 2026 10:14:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1xFBMf-0008P2-3k; Fri, 09 Oct 2026 10:14:26 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 699DZtSs3214287; Fri, 9 Oct 2026 14:14:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=RpWTER
 2lQI1x0JarDBCS5UPr0XvkPyw431zvg3iBUZE=; b=sfBZdK/Nre6DoVT2DqkPb4
 hafCnOI6mOLCIfeqsSDR64JJjXEXUQj6J8MWkxdTWj17XnXE8j7Dil4WanlXbQSZ
 Yfhkq1DMcKUJw/0iJP3Tdq4+ml6PaXy07w60I9kKoZUxuTbuXgfhuNTcuNt/o6NL
 US3dSTI+l+HVH342kf56SyMJSpyTrfvHFmz2oopMZ7hynocM+roqEbeW9GQKqBD8
 9X10lp83JVYGvEke4TKzRu6n2J2gUJgxSajKQWaUmNEIgXYyIG+r3YBYC5a4xITs
 LyaL4O5FyXGtAfrQuNuL0UG91+QpZVAqoodPUdbuFGRT8gaIXH770ppUwhc5Sksg
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h5xk1jc1s-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 09 Oct 2026 14:14:15 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 699DWVrS905720; Fri, 9 Oct 2026 14:14:15 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h6udd1e2x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 09 Oct 2026 14:14:15 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 699EEDWs38142706
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 9 Oct 2026 14:14:13 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7BC3C58050;
 Fri,  9 Oct 2026 14:14:13 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A91A858045;
 Fri,  9 Oct 2026 14:14:12 +0000 (GMT)
Received: from [9.67.47.107] (unknown [9.67.47.107])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Fri,  9 Oct 2026 14:14:12 +0000 (GMT)
Message-ID: <38439cb8-af66-48c0-9d50-35439f145b6c@linux.ibm.com>
Date: Fri, 9 Oct 2026 10:15:53 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] target/s390x: mark feats dependent on deprecated
 feats as deprecated
To: Matthew Rosato <mjrosato@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: Hendrik Brueckner <brueckner@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>
References: <20261008215956.164881-1-walling@linux.ibm.com>
 <20261008215956.164881-3-walling@linux.ibm.com>
 <9d0a930c-9dbe-47a2-9424-3ad0190c2b74@linux.ibm.com>
Content-Language: en-US, en-GB, en-ZM
From: Collin Walling <walling@linux.ibm.com>
In-Reply-To: <9d0a930c-9dbe-47a2-9424-3ad0190c2b74@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=YtCa1IYX c=1 sm=1 tr=0 ts=6ac8f6b7 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=TvMA7OA32NgICoYhVkkA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA1NiBTYWx0ZWRfXwaBiZPu3ZMEn
 p8ymq3K/4VIFttZsGacoAiGRPBtc5XFsif3kO6z4hy/tvEjHTgPZZ4FlGunbVVuX3obQRS2C9wu
 14TbBPnPJLXjE1HKsKJFMLkjstmWzqQS53lOKAKgHDmA+RCi+bYk4L7D/hNSxwEygN4GVPO7fnm
 mdDD+UrvPCerGh3JjN/FypDgzx06ydJ8eMtkBIccehoX5O6PPFOU1Zmr7YLiGsVNlI/LgTrrwMF
 ajNrGjQcAFRG/4YHmXebFQ8XINYp5gaVrAmsSsvPqITNZ4wFrRMjcO2DSswEylDKJlAZbndaXWQ
 zraKEiAhJlsgDO8BiGEk8PEHtRktxjORtoruTwCTFsySTfbm+pLXCiCq2AHzhyq+YLVZ1RG0uUP
 MAkK/wO99KARJEWvxmQ+UmyjNv709Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA1NiBTYWx0ZWRfX888kuSD/Ch7R
 9pVxYQ5UWNMP7ftjZX/vG7vWO2OjZY1EScwkNKSYThpIErnsNwWi2Sao6kQsjtBdcpiw1/pA2xn
 CBCjCUg2n0mW5GIKrpKH9WnWz9qTHOg=
X-Proofpoint-GUID: EBNcHrYbVMHs01DRsxKXmck0Gx4Lu4UV
X-Proofpoint-ORIG-GUID: EBNcHrYbVMHs01DRsxKXmck0Gx4Lu4UV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_04,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 adultscore=0 malwarescore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2610020000 definitions=main-2610090056
Received-SPF: pass client-ip=148.163.158.5; envelope-from=walling@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

On 10/8/26 18:53, Matthew Rosato wrote:
> On 10/8/26 5:59 PM, Collin Walling wrote:
>> There are certain CPU model features that depend on other features
>> that are flagged for deprecation. For example `ineff_nc_tx` depends
>> on the `te` deprecated feature.
>>
>> If a user defines a VM with the current list of deprecated features
>> disabled, the following is observed:
>>
>> 	warning: 'ineff_nc_tx' requires 'te'
>>
>> In some cases, this will cause a VM to crash or it may refuse to
>> start.
> 
> Does this need cc stable and/or a fixes tag then?
> 
> 
> 

Yes, I should've tagged one of the deprecated features patches. I think
the one where te was flagged is appropriate:

Fixes: 6e55b32d45 ("target/s390x: flag te and cte as deprecated")

-- 
Regards,
  Collin

