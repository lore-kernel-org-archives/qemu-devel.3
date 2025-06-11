Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D858C61CE7
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 09:21:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPHdr-0004VM-Sl; Wed, 11 Jun 2025 05:21:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1uPHdq-0004V7-1z; Wed, 11 Jun 2025 05:21:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1uPHdn-0000lM-NZ; Wed, 11 Jun 2025 05:21:05 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55B8lEDS029189;
 Wed, 11 Jun 2025 09:21:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=T3/JpI
 X8K63+79FCzoYkQ+0dWfNkiYRilyM4KdhbQgE=; b=YJk3Ac5EAXpQ2k5WM2/o+r
 3PK3e1cQWvL46L4PiPIsiAB6Gnx4X5MjJYkycly3U9A+FgltcE7vsG++CANVUyZU
 Xt5gc2EUWsJALtmbHGuR1VkazZohF1dUmvQKXagwEgw5CVUFPNVgxp0o3680VlM1
 Fu5f16JdB5SVcesz8JfH8aclB49sJRU5AtPT7hW/DdeKencP3RF8LT1yGbMMmseq
 tjKcm53+Y75nOsdnlR4SRWNfBGHRN8cmdjvjWeBV8yeXClzAgta2eBMK94XyWaL8
 KnzbW4qsDM+2bnvXiptZU4pWE5S5bXSOsrFAbLpxY/6qPVKmFyulQXVfxJdz6D6w
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474hgujnau-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 11 Jun 2025 09:21:01 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55B81BHI015184;
 Wed, 11 Jun 2025 09:21:00 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 474yrtf77e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 11 Jun 2025 09:21:00 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 55B9KxtE61079950
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 11 Jun 2025 09:20:59 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8D6005805D;
 Wed, 11 Jun 2025 09:20:59 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8C2E458053;
 Wed, 11 Jun 2025 09:20:56 +0000 (GMT)
Received: from [9.39.28.10] (unknown [9.39.28.10])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 11 Jun 2025 09:20:56 +0000 (GMT)
Message-ID: <adfbfd74-bea3-4479-99bd-079a22548f3e@linux.ibm.com>
Date: Wed, 11 Jun 2025 14:50:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 25/31] hw/ppc/spapr_tpm_proxy: skip automatic zero-init of
 large arrays
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>
References: <20250610123709.835102-1-berrange@redhat.com>
 <20250610123709.835102-26-berrange@redhat.com>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20250610123709.835102-26-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Pfr/hjhd c=1 sm=1 tr=0 ts=68494a7d cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=f7IdgyKtn90A:10 a=20KFwNOVAAAA:8
 a=VnNF1IyMAAAA:8 a=RGSA8qlED6iX_nMAe8wA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: BVpNZqKzhHuT8gDDcD2XJXTduJf4YAlc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjExMDA3OSBTYWx0ZWRfX7vLlniUZIxk4
 mGO5vmnhv94fKge6bVyBQFk5rtE8oTlcntTvnC7bR6ejnkik1b/nqIWLRruJLw2M77Ryr/Y+lQF
 gu9DX1oeLv0Gz6lxPBLf78crbTiiQSH9io0+Rsg4XcHjr34lmWCcs8Num6zaAvX5FNib5u/eus8
 LAx/MzkaTqKoY/flbV/BliHbCVz4I19FaT4+4dxhVPNEe1G5tf5EXNYhvp7xqA3/lCHiI1nO3vt
 mT6CwtLmBAOPZwdXYLRmuTBGio400JDj/vWKJFTl51nQznEAaF6lQlxKsic9U+Bx6Tqvg7hBx3r
 B04lj0fV4SPcI7uM2vYBwJ3+4zJpPXYSogwdYcKBIsGjuKjAINtJCZS0+9faLsXXs8kiMNsOxIk
 jSjDBjZbQ8gMWdsuT5B1VQTNQuSWTJUoPs8iAsNwdABDcuZco+7fU9e+vMpFNoTFDc6qeBgP
X-Proofpoint-ORIG-GUID: BVpNZqKzhHuT8gDDcD2XJXTduJf4YAlc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-11_03,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 adultscore=0
 clxscore=1015 phishscore=0 bulkscore=0 malwarescore=0 mlxlogscore=828
 mlxscore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506110079
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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



On 6/10/25 18:07, Daniel P. Berrangé wrote:
> The 'tpm_execute' method has a pair of 4k arrays used for copying
> data between guest and host. Skip the automatic zero-init of these
> arrays to eliminate the performance overhead in the I/O hot path.
> 
> The two arrays will be fully initialized when reading data from
> guest memory or reading data from the proxy FD.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   hw/ppc/spapr_tpm_proxy.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/ppc/spapr_tpm_proxy.c b/hw/ppc/spapr_tpm_proxy.c
> index 862eeaa50a..1297b3ad56 100644
> --- a/hw/ppc/spapr_tpm_proxy.c
> +++ b/hw/ppc/spapr_tpm_proxy.c
> @@ -41,8 +41,8 @@ static ssize_t tpm_execute(SpaprTpmProxy *tpm_proxy, target_ulong *args)
>       target_ulong data_in_size = args[2];
>       uint64_t data_out = ppc64_phys_to_real(args[3]);
>       target_ulong data_out_size = args[4];
> -    uint8_t buf_in[TPM_SPAPR_BUFSIZE];
> -    uint8_t buf_out[TPM_SPAPR_BUFSIZE];
> +    QEMU_UNINITIALIZED uint8_t buf_in[TPM_SPAPR_BUFSIZE];
> +    QEMU_UNINITIALIZED uint8_t buf_out[TPM_SPAPR_BUFSIZE];

Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

>       ssize_t ret;
>   
>       trace_spapr_tpm_execute(data_in, data_in_size, data_out, data_out_size);

