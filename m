Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E2B1C5B572
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 16:12:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuY1q-0005PJ-NS; Thu, 13 Aug 2026 12:11:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nikhilks@linux.ibm.com>)
 id 1wuY1m-0005P0-AF
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 12:11:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nikhilks@linux.ibm.com>)
 id 1wuY1k-0006tV-HK
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 12:11:34 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67DFXAqI2642019
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 16:11:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=PbjpYY
 Kcuu/4C4R1yrlP02twIUSBY8JuIWNBnAofC6k=; b=FxoSE8LyjJzq0BBJOP9vCI
 lOc7N7+gDDB0S+EiXJg/0W1WZ8UZj26lQFjvtoNNGA6JghftAsymHWlrHxBxO/1w
 2shVaTkM/AyuPQTiaQh8+cbhkBXcfNsY8Okpw7ai8CjKBoZBWeDxJWOLAQwp1gU1
 dJ3+E606IVgxUt3ru395iujMKGY83e60n+N5oIwlUAqZD3jrc3bdF46+Ags5dy3w
 4XqbDCg5teUuyhkmM+nE9T9gcqU4K1JP0tY2lJG8DwzGtnnpXxVT7z8dIjHC+E5J
 tsIvnKiJ83MTaOQtu38XB2CnsWkqWpfsZQAdEd9+HcGWbfZgStRMbluWTqO1+/Rg
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvp37rye-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 16:11:30 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67DGBJbC013937
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 16:11:30 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxg9hbmhu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 16:11:30 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67DGBRvG51118364
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 16:11:28 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D917B2004D
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 16:11:27 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5C25C20043
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 16:11:27 +0000 (GMT)
Received: from [9.43.103.247] (unknown [9.43.103.247])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 16:11:27 +0000 (GMT)
Message-ID: <fe415f6a-82c5-4d65-9716-8e90466e51d0@linux.ibm.com>
Date: Thu, 13 Aug 2026 21:41:25 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/6] ppc/spapr: Add ibm,errinjct RTAS call handler
To: qemu-devel@nongnu.org
References: <20260520095446.64206-1-nnmlinux@linux.ibm.com>
 <20260520095446.64206-3-nnmlinux@linux.ibm.com>
Content-Language: en-US
From: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
In-Reply-To: <20260520095446.64206-3-nnmlinux@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AMtp2X5w c=1 sm=1 tr=0 ts=6a7decb2 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=3doAkQKauoBHkhqFJVoA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: iLVd9BL5ShNkrjtf60bSBLIJIiNzz71p
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDExNSBTYWx0ZWRfX2wKzK4IvEmNV
 zydhr+8/e+0HH4/22/dL1KthJpj4eUgePAnmSZIo0qapV/34lV45sTSax2I/9Z4Y9SdI2cqpaBa
 Vh9wkhBDMgIePlC+x7zunQW2G+brT3+MWE8oDFO4Uq1eYrrLCRzCpKFFdov31EcHofLu0LyTiMl
 fBZpOzjS10yHj33DhrPjxJ2MhzFBcgoZytSxkCsD01X50pG+NNi26AyIuQH5HXHKrYV+Eh4jYUj
 FWl8aYlT7LmX3gegxrdaLJVVbHu0A7+M886ipuFp+za8/qEfhd/eRAcbtm4IN8t6Pk2WIideW1P
 VebfJJBHQcBwH1G4h5COfknJSf7QtFyQ4z6ZwX0L51I2564PnoaUt6fS6aZiAdCBHYw0teTCYTZ
 mLzoFHxxfNQmevsSf9gUWwojTJs1ufpdsfNOh7hwwMHMk4KgxNkblEmjdQ+khh0clSM0uo77nc5
 DNKKF8Kz5sc+folOz8A==
X-Proofpoint-ORIG-GUID: iLVd9BL5ShNkrjtf60bSBLIJIiNzz71p
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDExNSBTYWx0ZWRfXyQwQaN6Nxwjo
 G3jPA5LwoQDbVlZtqdNsaXOPUo8l9f2RrN/gib2jXyK8Cv7VbJ0wUFxJFQY6QvKda7lu95N6rVj
 ITmCHBWBnOXzvo9ukyKkPFGNAApS4sM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608130115
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=nikhilks@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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



On 20/05/26 15:24, Narayana Murty N wrote:
> +    sphb = QLIST_FIRST(&spapr->phbs);
> +    if (!sphb) {
> +        goto param_error_exit;
> +    }

Hi Narayana,

By using QLIST_FIRST(&spapr->phbs), are we assuming or hardcoding this 
to the first PHB?

Thanks
~ Nikhil

