Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44673106FD83
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 06:16:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0voE-0006Yd-Gv; Fri, 13 Mar 2026 02:15:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1w0vo7-0006Uu-3U; Fri, 13 Mar 2026 02:15:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1w0vo4-0005v3-Ng; Fri, 13 Mar 2026 02:15:34 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62D5mGn72308220; Fri, 13 Mar 2026 06:15:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=EfQ22NVSfSvoEz8TCogYE1pdJ3xCbc
 pyvW2lotww6E0=; b=smmNJ84Enoc7K8gXQbXZJFIA2J7aIcVSMxG7i3MUmp5lUM
 TD5PvBNg9cpMJUqYvRpSoGDeCx45FbJSfLFgaAYrJC8i9XqwE2wSuWUoefZmW27S
 NWOr6u9QbJyb7XyurraiJrhRWNPYjZyzbIQNXX/4zVzn6Z+gWhnWMjEn5RBL8jKT
 hYYn5mLodkoczO49tOlklJ4zWgsFJYd0FnH0Pu/NF4q8o3R2UqEflJcq859+1kkJ
 naoH+RgfeZrSUYS3DhjLSrWOOb4zqjC7xU2V52zbzbc4IMWT5UveJ8f3FYvA+wfR
 WVJi0wjTA2nUuxWV3yWAoZ+zRfSg+e/jeqSI75UA==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cuh96e61t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Mar 2026 06:15:19 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62D5Nuam018371;
 Fri, 13 Mar 2026 06:15:18 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cuha85fus-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Mar 2026 06:15:18 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62D6FEqt42729946
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Mar 2026 06:15:14 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 38B232004D;
 Fri, 13 Mar 2026 06:15:14 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2E94220043;
 Fri, 13 Mar 2026 06:15:12 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.124.217.239])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 13 Mar 2026 06:15:12 +0000 (GMT)
Date: Fri, 13 Mar 2026 11:45:10 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: Shivang Upadhyay <shivangu@linux.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, npiggin@gmail.com,
 milesg@linux.ibm.com, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-stable@nongnu.org
Subject: Re: [PATCH v2] ppc/pnv: fix dumpdtb option
Message-ID: <abOq6LFmRLmQOZGE@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
References: <20260311143549.118720-1-shivangu@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311143549.118720-1-shivangu@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDA0NiBTYWx0ZWRfXwlj1jo/+0jrd
 OkJ2bStGds4jLD7ovonEyavsSk8EDwKvwK12KTHiyjWWCcSLd/OgxnrftbTNeUPmJOs5aHEpxWi
 BFs0db7VPuYnOcT9qwNXf451Hs6qfeXPh0SLEOGqBE3q99l8z9qP1/d0eTXtF/5v30WF3xlfYb7
 WDxEryWtzRJO/1Zphhwxy1LzoZ70N6vZhTPDyz0iMk0ttKt3JmzVMlUCwEdp+SuSo5VdrxSBNqt
 CE6xDcmaTPF1zazignUSuxWSumLfiVa7jpOmMgQnYdQVq+xzP+pM49WtxeiISAmxr/Cc2SAguo3
 OB5fRTlUr7AwwEn4LY2O0S+lt5fH/G5GXVmqrXRWFuvH/yWV0AWnyQz91snhqR5zjeSFjiznHgg
 2jsoUTZ7v6fIW5PpEmT8INmuU9LTbWKVUM/ewTq8Sj+3APjf6EEbRyQH4yd9Wuogy+L/WKn28qD
 zGs+ukOvjXK3kjstEgg==
X-Proofpoint-ORIG-GUID: QfYx2pdbSFYQfcbREM_k2hhfEe_9sVB4
X-Authority-Analysis: v=2.4 cv=RLO+3oi+ c=1 sm=1 tr=0 ts=69b3ab77 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=69wJf7TsAAAA:8 a=Uaa_Ldjkp140y4n9bqsA:9
 a=CjuIK1q_8ugA:10 a=cvBusfyB2V15izCimMoJ:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-GUID: ZS7KFiHAOWNnJEoIsdOQScVgmCL7fBoH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-12_03,2026-03-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 clxscore=1011 impostorscore=0 bulkscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130046
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

On 26/03/11 08:05PM, Shivang Upadhyay wrote:
> The '-machine dumpdtb' command line option stopped working on
> PowerPC/pnv systems after recent design change [1].
> 
> Fixing this by generating fdt blob in `pnv_init`.
> 
> [1] https://lore.kernel.org/qemu-devel/20250206151214.2947842-1-peter.maydell@linaro.org/
> 
> Cc: Aditya Gupta <adityag@linux.ibm.com>
> Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: BALATON Zoltan <balaton@eik.bme.hu>
> Cc: qemu-stable@nongnu.org
> Fixes: 8fd2518ef2f8d34 ("hw: Centralize handling of -machine dumpdtb option")
> Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
> 
> <...snip...>
> 
>  static ISABus *pnv_chip_power8_isa_create(PnvChip *chip, Error **errp)
> @@ -1261,6 +1243,11 @@ static void pnv_init(MachineState *machine)
>      if (pmc->i2c_init) {
>          pmc->i2c_init(pnv);
>      }
> +
> +    if (!machine->fdt) {
> +        machine->fdt = pnv_dt_create(machine);
> +        _FDT((fdt_pack(machine->fdt)));
> +    }

This if check is not needed, pnv_init is only called once during start,
and machine->fdt will always be NULL, so we can just assign machine->fdt
directly.

Rest all looks fine to me.

Thanks,
- Aditya G


