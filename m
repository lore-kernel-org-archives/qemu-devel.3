Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 413EECD13D3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 19:50:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIXOf-0003iw-QZ; Thu, 30 Apr 2026 15:50:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wIXOe-0003in-FG
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 15:50:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wIXOc-0003XG-MD
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 15:50:04 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63UDipJN3991826; Thu, 30 Apr 2026 19:49:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=nnJagK
 mUCFujgqM6BdRSIF6tr0LtG8qavzwxyUGXDXk=; b=Yw9nvmR80U1X3kLpKQjOvi
 j5VANSZvl7mVJH6i8XCVTPLYbsQbOGHGP2k/DsrFV1epoWEjOYaURshok4rRU/ZA
 /XSzuqASPJO6pxTzGoNEvJBDmhGRDnj7N6hrpRdt1N2bVgoCcY/Fn+gfXT4x+tpZ
 jjp78h9X0jWeKVSBePRy+bFgAqMWpJ4cxrVuR9WFF+WzFO/62oXbYo+opKcFn6X9
 jk404Gkbe1JY6VJYhDd4tmt4WMCG6oho1UVAUnaBeoAKwr1WGWf0OrtWVuELQBT+
 4ryxEOW1pOoxnckkJvk0xu4iI9/p9jKb5YeOfrcLIP3gCUlueD6zI3ko88zoyw6Q
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn451t8n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Apr 2026 19:49:51 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63UJctiC009941;
 Thu, 30 Apr 2026 19:49:50 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ds7xqmpwd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Apr 2026 19:49:50 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63UJnnlI12517970
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Apr 2026 19:49:50 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D672058053;
 Thu, 30 Apr 2026 19:49:49 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 576E358043;
 Thu, 30 Apr 2026 19:49:48 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 30 Apr 2026 19:49:48 +0000 (GMT)
Message-ID: <f0658044-a615-4255-b6a0-be8b67ba14f3@linux.ibm.com>
Date: Thu, 30 Apr 2026 15:49:47 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/10] hw/tpm: Add support for VM migration with TPM
 CRB chunking
To: Arun Menon <armenon@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Igor Mammedov <imammedo@redhat.com>, marcandre.lureau@redhat.com,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>, Ani Sinha <anisinha@redhat.com>
References: <20260422103018.123608-1-armenon@redhat.com>
 <20260422103018.123608-7-armenon@redhat.com>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20260422103018.123608-7-armenon@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: r0mb9fkFThGWGphDADBHZbmfWZIM1ZoO
X-Authority-Analysis: v=2.4 cv=Ft81OWrq c=1 sm=1 tr=0 ts=69f3b260 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=20KFwNOVAAAA:8
 a=y6YOFbA8I-8_Z2G9m14A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: XlRt69wDQ7poNKIUvY7TpA6P9yC4YQu8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDIwNSBTYWx0ZWRfX2AQLg9uPR/qs
 61ZNEHlysEXgIOXK9pwNUQUnTXNY+Y5LFedIEDpTofovLEK0JOjDW8PF/QDH/5Nu52I3eLaeAJf
 Ezo8f4kxw01ba/cPYztWPoZhLzSz+DreIGJuJ8UdNNehHu29HF4lAsNnMeh6b1am32kfFKjjZek
 1Scpwz1JqEPMXnOH6dfWocHaM9Cj4oEJozujcvMQwT/opY/l5fkkb070u2XQlTqeFjBOk2MjH4a
 /F4ba2vTr3m9nDj1kSdtZ2RhvFWcKgcQDYiOAs44mZqZ3yIzKQutMMYjJ61luiouJdnNY8XPkog
 R7a5bg8jXY92ShIvqb9fYBaPVTGgLS/Y/rblc2/FOR7S1OVXB7MfXJvkCWcI3vUx/EO46//DqdB
 yH2xDX4VU97ZsXgf3Ogr5qyR1ZSPzyCS5jlgZejwluKHuNxnc3a2MwzvU5JyJn4IIHlMvLUyM85
 9tikDrONf940BQaC8NQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_05,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604300205
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
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



On 4/22/26 6:30 AM, Arun Menon wrote:
> From: Arun Menon <armenon@redhat.com>
> 
> - Add subsection in VMState for TPM CRB with the newly introduced
>    command and response buffer GByteArrays, along with a needed callback,
>    so that newer QEMU only sends the buffers if it is necessary.
> - Implement a migration blocker to prevent migration of the VM if the
>    user manually enables chunking capability, cap-chunk, but the machine
>    type does not support it, using a new hw_compat property called
>    allow_chunk_migration.
> - Add a post_load_errp hook so that during a migration, the buffers are
>    validated before destination VM is started.
> 
> Signed-off-by: Arun Menon <armenon@redhat.com>
> ---
>   hw/core/machine.c |  1 +
>   hw/tpm/tpm_crb.c  | 71 +++++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 72 insertions(+)
> 
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 6d27cf69a2..b590af0125 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -40,6 +40,7 @@
>   
>   GlobalProperty hw_compat_11_0[] = {
>       { "tpm-crb", "cap-chunk", "off"},
> +    { "tpm-crb", "x-allow-chunk-migration", "off"},

Nit: A space after the "off". Also in previous patch that added "cap-chunk".



