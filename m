Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5420BFE51EE
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 09:10:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGCY1-0000za-5f; Fri, 24 Apr 2026 05:10:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wGCXf-0000ss-6r; Fri, 24 Apr 2026 05:09:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wGCXd-0000bJ-9F; Fri, 24 Apr 2026 05:09:42 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63NIbdGN3107946; Fri, 24 Apr 2026 09:09:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=3rrvkI
 SdaSx3TO/72ORMYjGwk/rcZKkNfMQHTudy4Mk=; b=sr/if0bfY5//YMbTcCbauu
 9Acdq6icorrJo6zjlq/2OWMG93o8ZNZYCStajwgC0RemA39ppyF3/soCf6sL6ZOI
 /hhoE9elmPrwKCZVXULND6CxPEv3vjuCwoXkYhTjiZHhXCCZiiqc3yWxv0DlPETZ
 lBQheeLH3xaJLsZhVOS5xqioVae1wQ8kaKbKhlFn/EVgPY6+VpBOBDwQlwaM1BGS
 s8gJ4T9BdshXO9lo1995oMBDAkZa7kxekNoUEl4AvhRhfoWSXqvJvbNZTCRumFLx
 xHv00djanVDd/HNC76RuoCyzM42WtUwWCuPO3wzrqN/4c1uH6rcziExdNNVrQg3g
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dpeu6m86v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Apr 2026 09:09:37 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63O95NpT026930;
 Fri, 24 Apr 2026 09:09:37 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dpjkyj653-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Apr 2026 09:09:37 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63O99ZFR39191076
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 24 Apr 2026 09:09:35 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C8F1858053;
 Fri, 24 Apr 2026 09:09:35 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5245958043;
 Fri, 24 Apr 2026 09:09:32 +0000 (GMT)
Received: from [9.124.218.196] (unknown [9.124.218.196])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 24 Apr 2026 09:09:31 +0000 (GMT)
Message-ID: <9ae1a152-891e-436d-85b1-51d38bf1f44d@linux.ibm.com>
Date: Fri, 24 Apr 2026 14:39:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ppc/pnv_phb3: Error out on invalid config access
Content-Language: en-GB
To: Aditya Gupta <adityag@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Zexiang Zhang <chan9yan9@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Miles Glenn <milesg@linux.ibm.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20260326190438.734239-1-adityag@linux.ibm.com>
 <20260326190438.734239-2-adityag@linux.ibm.com>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20260326190438.734239-2-adityag@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDA4MSBTYWx0ZWRfX2KvqaoWvbg5u
 izHPRLZze34AFF+ZXQeBC1U5onNwxUz8w1jZVuhtqeIkKMf0wKisHq4Pi+mYyQncwgMXO4vmk0q
 FR/xYNc04nL/QpkR3EVIh9aJ66NDycQJNJ5XNmRBq6IyUlftvRpLMCyu/XERekpkh9CPmJfeR4M
 rOcVwZrQjt10/IAXJr+jYXBtcsBqQ1AknVwSp0c13tJBllofnBkpk6Kmc5xrDmxtXv6hRIpsd2e
 L/cyrnlDUrUFgQ8KAuXlqeO+8Y3hIW8soN/xhIR+6Uixc477j9SEo9cDUi8p/WqimqZJ1s9PksW
 obMakUP2utZ/Gx65EodpX5DK4xBRx3De8eXtTrU6V5VslmeSwT3Dq7G6nAX8DFSbTOeHxhva8le
 FD3oOEPfZZyryxnVEb484LqsQJnELzSoKDQ2U2KsTtfEZSE24CQYRvl8l80pibeaRqj8v8lEMsG
 PDLWzq+tT9AoW79kEDw==
X-Proofpoint-ORIG-GUID: 6X8d5Kqt1v6syQjTyZ_P8mwu3rukAbQp
X-Proofpoint-GUID: 1ezJWk1HjQLFJFcF9m50tQ2ICUQuMzfr
X-Authority-Analysis: v=2.4 cv=BYfoFLt2 c=1 sm=1 tr=0 ts=69eb3352 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=f7IdgyKtn90A:10 a=sWKEhP36mHoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22
 a=p0WdMEafAAAA:8 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=sTfHyYWmAmTSg6sTLhcA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 clxscore=1015 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604240081
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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



On 27/03/26 12:34 am, Aditya Gupta wrote:
> PHB in Power8 supports 8 byte registers, and hence the ops structure
> allows accessing of 8 bytes in 'pnv_phb3_reg_ops'
> 
> Both 'pnv_phb3_reg_read' & 'pnv_phb3_reg_write' pass the arguments as is
> to 'pnv_phb3_config_{read,write}', if offset is PHB_CONFIG_DATA.
> 
> This when called with size as 8, causes following assert failure in
> 'pci_host_config_read_common' & 'pci_host_config_write_common':
> 
>      assert(len <= 4);
> 
> Validate that size is <=4, before jumping to pci_host_config_{read,write}_common
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3334
> Reported-by: Zexiang Zhang <chan9yan9@gmail.com>
> Fixes: 9ae1329ee2fe ("ppc/pnv: Add models for POWER8 PHB3 PCIe Host bridge")
> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> ---
>   hw/pci-host/pnv_phb3.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/hw/pci-host/pnv_phb3.c b/hw/pci-host/pnv_phb3.c
> index d6ab5153374f..4ffdb4ce31ae 100644
> --- a/hw/pci-host/pnv_phb3.c
> +++ b/hw/pci-host/pnv_phb3.c
> @@ -475,6 +475,11 @@ void pnv_phb3_reg_write(void *opaque, hwaddr off, uint64_t val, unsigned size)
>   
>       /* Special case configuration data */
>       if ((off & 0xfffc) == PHB_CONFIG_DATA) {
> +        if (size > 4) {

Shouldn't we be doing write/read in chunks of 4 bytes when requested 
size is 8 instead of returning from here?

regards,
Harsh

> +            phb3_error(phb, "Invalid config access, offset: 0x%"PRIx64" size: %d",
> +                      off, size);
> +            return;
> +        }
>           pnv_phb3_config_write(phb, off & 0x3, size, val);
>           return;
>       }
> @@ -597,6 +602,11 @@ uint64_t pnv_phb3_reg_read(void *opaque, hwaddr off, unsigned size)
>       uint64_t val;
>   
>       if ((off & 0xfffc) == PHB_CONFIG_DATA) {
> +        if (size > 4) {
> +            phb3_error(phb, "Invalid config access, offset: 0x%"PRIx64" size: %d",
> +                      off, size);
> +            return ~0ull;
> +        }
>           return pnv_phb3_config_read(phb, off & 0x3, size);
>       }
>   


