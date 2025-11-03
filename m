Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1773ACCFA00
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 02:23:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFkCi-0003qS-0i; Sun, 02 Nov 2025 21:21:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vFkCf-0003pj-1j; Sun, 02 Nov 2025 21:21:53 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vFkCc-0006xi-2G; Sun, 02 Nov 2025 21:21:52 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A2Cup9L005487;
 Mon, 3 Nov 2025 02:21:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=F2OvPD
 Q6/+j9KfIZFJerpAQQx/syfUEg3EnuyllDbzY=; b=rL77g5SE8yeTnsIKBNh6g7
 I09viegb47AUe1RDr1ZEqlGj8GuJyO4okNOkzYdh8bv0wZ6emNPXfdqgXDq/aDv4
 q/jbJviomxOPXK9MbY8QdXhSI+OyBoj03Y7Ht+c9BnP6SCCMo2FH89QYPz1Ct1EU
 CuJTQcUzh3iW8RcXoI8Qm+yf+h5+v85CnTdq1iHveMH/U/8EIi/w3n3IX0kxhWos
 9ZfPSCW/oexerhtsghSm/BwewyFOFujdVc21tqGlxwy4/WhEVkxSDwf3C1ZlFKfN
 9EUuQVFYRpW9KL/hTK5dRwb328pcE+YHJUyk5lfPJrJ7lEM/XsBOPPz5xkcetHdQ
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a59vu4ngv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Nov 2025 02:21:38 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5A32LcBo003624;
 Mon, 3 Nov 2025 02:21:38 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a59vu4ngt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Nov 2025 02:21:38 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5A2LA40T009855;
 Mon, 3 Nov 2025 02:21:37 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4a5x1k3d31-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Nov 2025 02:21:37 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5A32LaCv6160916
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 3 Nov 2025 02:21:36 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3A929580C6;
 Mon,  3 Nov 2025 02:21:36 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3B46A580C7;
 Mon,  3 Nov 2025 02:21:34 +0000 (GMT)
Received: from [9.124.213.97] (unknown [9.124.213.97])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  3 Nov 2025 02:21:33 +0000 (GMT)
Message-ID: <078c2da0-ac1e-4f07-a777-d8615a4456bd@linux.ibm.com>
Date: Mon, 3 Nov 2025 07:51:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/ppc/pegasos: Fix memory leak
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20251101165236.76E8B5972E3@zero.eik.bme.hu>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20251101165236.76E8B5972E3@zero.eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: TvXo2AT2HtmnJdXBi_B1peMD-dNR_Bpk
X-Proofpoint-GUID: wiiTeNDAGAU3VFuGvdi5EppqyhYnVU0Q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDAyMSBTYWx0ZWRfXz4G6DCkXPSrS
 pXpKGHHzc3RRrbXvQqhUoAs4OUyMvFTlFQQnLZ4jzxoAm4As4l+12txwyj2ju1NRiDg4K5VRSfX
 6XVgO/eS4tIw0r4euqsSDL38xSbkQyjHpKDCzl7UV8cEhCWEMK+JCFs7mzICTQG712/BiMGznNa
 lTlvsG3HaRahC0/rUNRtK3y9Na1sxdQkx18EU69SaLe9Ckedq7S4WPLX3Xl8CaRhMs3wLuSoT/w
 hXujsE+RcMKC2qwkdepkcz+2wlTVWCxckFJLBjRpDa/Mwn7tANxIBn3N9N1D10Rwbnh/E4i6Qp1
 DD81oQFUGBCt6eIleoZRZZZjBtCNNrA/4d5caND6+DIpLJ6OK9OEHerUR8w42UoK2S4hGHTCwo+
 y+vPDW6vFfzqOmxoimC7LTs8ua0NrQ==
X-Authority-Analysis: v=2.4 cv=U6qfzOru c=1 sm=1 tr=0 ts=690811b2 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8
 a=CZjf9LS-qkpWPA1xOPEA:9 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
 a=oH34dK2VZjykjzsv8OSz:22 a=pHzHmUro8NiASowvMSCR:22 a=n87TN5wuljxrRezIQYnT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-02_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 spamscore=0 phishscore=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511010021
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Hi Balaton,

Thanks for taking care of this ...

On 11/1/25 22:22, BALATON Zoltan wrote:
> Commit 9099b430a4 introduced an early return that caused a leak of a
> GString. Allocate it later to avoid the leak.
> 

I think we also want to mention:

Reported-by: Peter Maydell <peter.maydell@linaro.org>

> Fixes: 9099b430a4 (hw/ppc/pegasos2: Change device tree generation)
> Resolves: Coverity CID 1642027
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   hw/ppc/pegasos.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/ppc/pegasos.c b/hw/ppc/pegasos.c
> index 3a498edd16..8ce185de3e 100644
> --- a/hw/ppc/pegasos.c
> +++ b/hw/ppc/pegasos.c
> @@ -847,7 +847,7 @@ static struct {
>   static void add_pci_device(PCIBus *bus, PCIDevice *d, void *opaque)
>   {
>       FDTInfo *fi = opaque;
> -    GString *node = g_string_new(NULL);
> +    GString *node;

Curious to know if there were any technical reasons for not using 
g_autoptr which Peter initially suggested ?

Anyways, it fixes the leak, so

Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>


>       uint32_t cells[(PCI_NUM_REGIONS + 1) * 5];
>       int i, j;
>       const char *name = NULL;
> @@ -871,6 +871,7 @@ static void add_pci_device(PCIBus *bus, PCIDevice *d, void *opaque)
>               break;
>           }
>       }
> +    node = g_string_new(NULL);
>       g_string_printf(node, "%s/%s@%x", fi->path, (name ?: pn),
>                       PCI_SLOT(d->devfn));
>       if (PCI_FUNC(d->devfn)) {

