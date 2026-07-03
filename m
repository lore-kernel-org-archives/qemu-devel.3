Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14EFAC43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 17:15:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfhTk-00057q-Eb; Fri, 03 Jul 2026 13:15:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wfhTh-00056z-Vx; Fri, 03 Jul 2026 13:15:02 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wfhTd-0001Hv-13; Fri, 03 Jul 2026 13:15:01 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663GJ8ui3237356; Fri, 3 Jul 2026 17:14:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=3rhY09
 ycpQx/iwKRL7d5pVajmQA6orIFA3/RqLyFZfE=; b=fW8TiQYMOzhNMQ3xVdrw53
 oXAjpPMWOmdJpnkl5DvzQj1PJo25/Zst7mNatAnigNUcL5r8TllYI9aa73ID1WMM
 LRJFvAU+6UPUAN485hytMvVyQtpih1G8s/36XNLi3vK+Ub+aY0jB5lvuYvoAhpiG
 fFT/6GtCLn66ODU2LznxQemDjVSbxsGOZwGFnKg/QrZTMZBFEL2g9gyxxz2/v/Pe
 Gpz8I8Pqy/EL+1HWA8KOEcBGX5KawImWOtn9xbOeQGRjWF+3ieg5x0la1T6i8p7e
 LePZoBoUHFsnau91t+7+enMy4qSiw2m6Dx3ONm4zkLshFdYJfMl7YR0HlKq9x1Pw
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26rffntr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Jul 2026 17:14:53 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 663H4dpU020321;
 Fri, 3 Jul 2026 17:14:52 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2tbhsqh0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Jul 2026 17:14:52 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 663HEpr916712194
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 3 Jul 2026 17:14:51 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1BE055803F;
 Fri,  3 Jul 2026 17:14:51 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 252A958054;
 Fri,  3 Jul 2026 17:14:49 +0000 (GMT)
Received: from [9.61.65.1] (unknown [9.61.65.1])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  3 Jul 2026 17:14:48 +0000 (GMT)
Message-ID: <d29358bc-c306-45d1-8505-49cb9691f483@linux.ibm.com>
Date: Fri, 3 Jul 2026 13:14:48 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 19/33] s390x: Guest support for Secure-IPL Facility
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@kernel.org, walling@linux.ibm.com,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
References: <20260703170032.1893204-1-zycai@linux.ibm.com>
 <20260703170032.1893204-20-zycai@linux.ibm.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260703170032.1893204-20-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=a4kAM0SF c=1 sm=1 tr=0 ts=6a47ee0d cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=87MjNmDPHvOGOkPE-qcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: s_M9Y-pmiFIQd4bzOUk__SIIS9nOEOkM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE2NyBTYWx0ZWRfXyf0KBVBgO7Ct
 GKXOx0H2A9gDKTJb5m8ZGX5shRwFe728pr0jv+Vg9Ls3QN1kdFs/jD/VwPSX7FoU1fB19d/jnoX
 TaPXdNWRU8XK/0LqN5N72hrpeA3R7HTrzfGi9uFbxfuI0IkIfawKy9R60J22s9ISLAhpPAncphA
 F5LvuuDinDFGNSEq6urgnDC/hjoGnN10BJ2953GkBW1LQI/3neR3U/GAa5PLzqyqXIMjVn74xwp
 Xv80tEM0C4nB7A8JhbnJrWdig27Q2d6M7oTnKRlpnR0wygh/AdOles63k+clRSPinQSUkkjgxt+
 Gnc3BbcGnKuMTWf8jabLBPSQuHrdcfCRWDVK+9B6gdCTSpU9ytJFTKmEpGLJL9D0StrDIdH+5Sv
 x6dpLVtL126fbcS2uL/+lTynrEm6bvAHlAAPa3Lg3ng1QVX2OStJA0SMdTKCeW5mrMmfu2qYg9s
 RaAMDQWSHNssUdyH0xA==
X-Proofpoint-GUID: s_M9Y-pmiFIQd4bzOUk__SIIS9nOEOkM
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE2NyBTYWx0ZWRfX2aoRy0ge+vXR
 8rws6otegiPJh7SZqv2fnE/IaGMOG4054p3bDI2LqS8KiWLJqHMX3yqCg4VWJyYfMEJImZQf1d9
 WXyqL0mDWTxhXGe4Sa0KZv2fTP+BTfs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 spamscore=0 priorityscore=1501 adultscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030167
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

On 7/3/26 1:00 PM, Zhuoying Cai wrote:
> Introduce Secure-IPL (SIPL) facility.
> 
> Use fac_ipl to represent bytes 136 and 137 for IPL device facilities
> of the SCLP Read Info block.

SCLP Read SCP Info

Otherwise,
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>



