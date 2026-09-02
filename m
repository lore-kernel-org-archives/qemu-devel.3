Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D940C624D9
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 12:57:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1kW7-0006aI-OT; Wed, 02 Sep 2026 08:56:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1x1kW5-0006Zc-Pp; Wed, 02 Sep 2026 08:56:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1x1kW4-0003Ck-3t; Wed, 02 Sep 2026 08:56:37 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 682CVrQn4187031; Wed, 2 Sep 2026 12:56:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=DQh2fN
 d2l0/FzllI732ZSVyrji2qBKDypas0kKmLjwE=; b=r9iEWsCnTQ79w+I4eX78RI
 ltKtC7v15lj/NthPCW1dzvH8+2TuaYC/qq1nITeurbaAzwKX/xka9jXBgTMxMW13
 nBMf/YNtU0umvGJlCu/ZNs0fYspYVnBr4lMN6Fxk6MOHpobNAUVhAAM/OUG1YVEL
 Gj5mmlk5d9OxRFlWmzMVpwnstSEITpTQqnXZA7o8clk+8MIJ1/uEl5N+Cctkp4zp
 /vcIOePigE9Fonc5eF5YbIWl/GyQLV0MONl0RMUPzxlIHWbxQ4jfNQUOOiy46Jax
 4757HjUl6Y2Ro/yPj+i1FS6iQULP/k/RJ1nSlsyNK9krTpX7GeGVvsIr5RBxqvCw
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq54xhgh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 02 Sep 2026 12:56:26 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 682CuGSV018995;
 Wed, 2 Sep 2026 12:56:25 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gcbyghj14-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 02 Sep 2026 12:56:25 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 682CuPvT30016030
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 2 Sep 2026 12:56:25 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 23C875805B;
 Wed,  2 Sep 2026 12:56:25 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B7C8758058;
 Wed,  2 Sep 2026 12:56:21 +0000 (GMT)
Received: from [9.111.54.112] (unknown [9.111.54.112])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  2 Sep 2026 12:56:21 +0000 (GMT)
Message-ID: <c6e08e07-a721-4c6b-a716-9245468c35fa@linux.ibm.com>
Date: Wed, 2 Sep 2026 18:26:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/5] mac99: Boot OpenBSD/macppc
To: "Kirill A. Korinsky" <kirill@korins.ky>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 mark.cave-ayland@ilande.co.uk
References: <20260827155310.7223-1-kirill@korins.ky>
Content-Language: en-US
From: Chinmay Rath <rathc@linux.ibm.com>
In-Reply-To: <20260827155310.7223-1-kirill@korins.ky>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDExMSBTYWx0ZWRfX7qjBUC0EdqFT
 VxXJ3gwSnTG/xVktMAqQmWaQi061ImEOcd/NEwWctaKDUHUuxIiSFs+3dRnFcIMB9ZdFDmt+9Zv
 e2SzoM0wZ/891UZ6EKfWF0pSFcknG7s0VG7YnDM5T6AVjwOupCwU8l5oVIiXQFdwWVLtlx0+umB
 Sy04LcYqc57GWJaBmChgXnpsGUelIobhEvek4/x56KFyzJXlA31PZ/gBYLdL4HFlL0kklgYHRqw
 Ir67MTfPqpU4wAafmfY7yrxGmY42nn0qasVE/9cRkhMrXut2vYR13OJh+bI9l8UeJbHK3p3bD0M
 0XGyRgRtsIXLerRtwDLTddauWZcBB8Y0lzM196RNua0Y+ggyxi68UZIeJX6SXYkUhX5U9hCXrME
 qXuPtWqYEFQ/b4dZMoFIJOgjTfqbH3hMQ4GNn0hUaN53Kmep8T6OB/Kj3Rx9o0idaxpS4qynx4K
 4jXSaOewNsPdPk9jQOA==
X-Proofpoint-ORIG-GUID: 1INT03ns9r881gv5-PjPj6xIMxXq00f2
X-Authority-Analysis: v=2.4 cv=CNgamxrD c=1 sm=1 tr=0 ts=6a981cfa cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=xI8mmIURqZhCa0dEe2AA:9
 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10 a=zZCYzV9kfG8A:10
X-Proofpoint-GUID: 1INT03ns9r881gv5-PjPj6xIMxXq00f2
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDExMSBTYWx0ZWRfX0RDzqYo9juPp
 j0bKC3kwaqSABVjZwdnrpqz8Fw1e9c6LzKksktDn5PPIzahwsTq5c2piYB1+fRqWj1AIhfVCj9h
 xWynYb10H1KLOTTbH3ZIYN9xAxT8vVI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_03,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1011 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020111
Received-SPF: pass client-ip=148.163.156.1; envelope-from=rathc@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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


On 8/27/26 21:20, Kirill A. Korinsky wrote:
> Greetings,
>
> OpenBSD/macppc does not complete early boot on mac99: OpenPIC can
> reassert an interrupt still masked by CTPR; the edge triggered
> decrementer does not raise on zero; successful CUDA ADB replies omit the
> original command; and the fixed CUDA shift register delay can stretch
> packet delivery past the guest timeout on hosts with coarse timers.
>
> This series corrects these four behaviours and adds a functional test
> which boots the official OpenBSD 7.9 macppc CD to the installer prompt.
>
> P.S. this is second attempt to send the same patch because first one had
> wrong subject and missed qemu-ppc@
>
Hi Kirill,
Thanks for the patch. Please cc the respective maintainers. This will 
help bring the patch in the notice of the correct people. You can check 
who they are using the scripts/get_maintainer.pl script.
++ Mark

Thanks,
Chinmay
>

