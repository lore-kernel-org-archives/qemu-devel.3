Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9AFAC5DF81
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 21:32:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wycHR-0003B2-4G; Mon, 24 Aug 2026 17:32:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wycHN-00039N-Rv; Mon, 24 Aug 2026 17:32:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wycHL-00008A-41; Mon, 24 Aug 2026 17:32:28 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67OJVkkI2744492; Mon, 24 Aug 2026 21:32:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=n7EJQ3
 /dB+uboMfq7HAkM69dHRvN2zAHZaQ1BIFR/4s=; b=pH2UAR98AbR9xFs7WFfPmi
 kMOj7/z6sbMsPwymRsXWS/Tv3clznvZ4yyEBBVv9BrHHsvFa/foYlRsDRU4df0iZ
 /v8VtBSwcPu2uhoP158Aa45s8G05Cc84XikZfZ7T8X+reNHUNtQk9GqEIO6cmoWD
 DqKy5TJetzOIGlU9g8Uyf/+/x1D5xtIE0pBB+V58Jt+9Xo1kk5gbM+hETRFMCUKS
 qS17Fv+StmBUjZ0jD51eWKcmFFiQOkq9WFPRkKTLV1eHTkBgqKhECZ3RndCPGglm
 YzNBQ0ZxecFf3P/8P3mxZVTuAUMiuC1SFMBpPvJY1zOZ//fwYCTdob+fv4okueSA
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g716hmg7g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Aug 2026 21:32:22 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67OLQHdj004309;
 Mon, 24 Aug 2026 21:32:21 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7q3jrmbu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Aug 2026 21:32:21 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67OLWKJ565077538
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Aug 2026 21:32:20 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 242065805A;
 Mon, 24 Aug 2026 21:32:20 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 62E0A58052;
 Mon, 24 Aug 2026 21:32:19 +0000 (GMT)
Received: from [9.61.21.147] (unknown [9.61.21.147])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 24 Aug 2026 21:32:19 +0000 (GMT)
Message-ID: <911fbd9b-d335-4d6e-96e8-2a1e2e9622e4@linux.ibm.com>
Date: Mon, 24 Aug 2026 17:32:19 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 09/15] s390x/pci: Move g_iota from S390PCIIOMMU to
 S390PCIBusDevice
To: Konstantin Shkolnyy <kshk@linux.ibm.com>
Cc: alifm@linux.ibm.com, farman@linux.ibm.com, richard.henderson@linaro.org,
 iii@linux.ibm.com, david@kernel.org, cohuck@redhat.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
References: <20260818172521.223460-1-kshk@linux.ibm.com>
 <20260818172521.223460-10-kshk@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260818172521.223460-10-kshk@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDE4MiBTYWx0ZWRfXx4TEVX/KRqzI
 t0kwbvTuFsfmZHlPv6mkY+7Yb/Z6zGRLUmkikt8b1dXLssPOt8vpXd7pPAvxyr1BSMLI6Ba+8J4
 MabNG0UbNwAth6ElqkTy52UnFmhnJ7A=
X-Proofpoint-GUID: OjWEgDBrUFhl973A5-wBjR1ZF4Sc_G7w
X-Proofpoint-ORIG-GUID: OjWEgDBrUFhl973A5-wBjR1ZF4Sc_G7w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDE4MiBTYWx0ZWRfX7Yd9PvKVD0aR
 n94MPed1acPIc/SmL1iRPcndMQnVtJ6ODTs2RLZ2Y96vqLS4ZdFx0ALBpxDZsMr8YvMUxK5nkpI
 6kSJ5ywNkqJdDMIezHbaWTxOSX+dtMmuPSjzfYA06grnVbZJ8vxlkVtQEiY+3aiJa4lDx4qZPak
 DWxkFcoCKVmU8JctmfFnQk/5c3vLV/HZW8H8BqOSFsFUq3Rtx3gg+CtcN+zJrIs+N92158Rf79g
 Oo6TQzXvhXpSMRv2DLPJVvWGCSjAFSNMFrQXybCqMGD7QY5Ljy0G2UznPSIKbWvYCwmLE9TEYS2
 yLte55cw2/Bcq47hcLrbVMh0MKBGKsJrVq9/+gmnHM+CZyJOfS4MHxvuXciII4zK/+0PS1pmxiz
 T0eo0kkGIeyAWX3nu4U43ig6Jl13jhceBLKN8smukB5p/heavSXhVOxBYkxecczIIZBNJTjXB/2
 k+A6d89CnjR55tPLQsA==
X-Authority-Analysis: v=2.4 cv=H7brBeYi c=1 sm=1 tr=0 ts=6a8cb866 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=K5RFVuYA7s4pMnEJfqwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_06,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240182
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

On 8/18/26 1:25 PM, Konstantin Shkolnyy wrote:
> This field is only used when S390PCIBusDevice exists, so it can be moved
> there to simplify S390PCIIOMMU which purpose is just to store the "root"
> AddressSpace.
> 
> This also allows to save/restore this field during migration.
> 
> Reviewed-by: Farhan Ali<alifm@linux.ibm.com>
> Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
With commit message fixed as described in patch 3:

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>

