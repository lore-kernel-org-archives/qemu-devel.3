Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5914AC43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 17:04:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfhIx-0006rT-A7; Fri, 03 Jul 2026 13:03:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wfhIv-0006mM-Hu; Fri, 03 Jul 2026 13:03:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wfhIt-0004S9-ON; Fri, 03 Jul 2026 13:03:53 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663GIhlF3497514; Fri, 3 Jul 2026 17:03:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=SueXvt
 yAWEnc7p8n2Ph+MV/r1F2LCAR94O+iOGY6QNc=; b=kWy6atxKcnTQ2guYqbr4Bl
 LnhBfP0ftVNl6lmpRnreQez64LcmkhQrLyZBdwtqbIT5JXK23xYd86NxdMoB9OMX
 xecRUlRSi9Q7lXlu6qcTgjZ+Bf1IBDVz7ucTV7TXNfet21EvQfjaVEQUcgBGuspd
 I6DlI7wUebYeXRDmYX1Un/Rshaqq5D1WCa1Am9pdrAuZVFH0eunbaEYeKt63+Q1K
 Lvy2K94PD1pEnRbtBla7CdgnPjPU0TMliyyA/ZWGVijG7W7nHtFGXJrb+gK8bsvJ
 90FLzh0c1d8xm8zdxSezNYHtYLgYjBP2Ks1uwYyqB8c0vHtzpWx8uh7A2j/GtyVw
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26qgg752-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Jul 2026 17:03:47 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 663GnbN1019653;
 Fri, 3 Jul 2026 17:03:46 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2ruqsyw2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Jul 2026 17:03:46 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 663H3j5V5112470
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 3 Jul 2026 17:03:46 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9DD2658056;
 Fri,  3 Jul 2026 17:03:45 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B407A5803F;
 Fri,  3 Jul 2026 17:03:43 +0000 (GMT)
Received: from [9.61.65.1] (unknown [9.61.65.1])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  3 Jul 2026 17:03:43 +0000 (GMT)
Message-ID: <0ec6576b-4efb-497f-b23e-1261189fc388@linux.ibm.com>
Date: Fri, 3 Jul 2026 13:03:43 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 04/33] hw/s390x/ipl: Create certificate store
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@kernel.org, walling@linux.ibm.com,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
References: <20260703170032.1893204-1-zycai@linux.ibm.com>
 <20260703170032.1893204-5-zycai@linux.ibm.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260703170032.1893204-5-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=RYqgzVtv c=1 sm=1 tr=0 ts=6a47eb73 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=-B5pnveW0ibvkdq23fEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE2NyBTYWx0ZWRfXxfsvl6a0PGpZ
 +ocb5IvoyGqm41NcxekHHPCA6zTnlaEW9rfYSs71yFQydoovsvD2F5bIjme+Pkql4vQMGSESowS
 RTn5M4bPtoFr165qwwHrHE06qbZa1l0=
X-Proofpoint-GUID: QZsxmbYuNr-2hBzJZibkmbz6vm0NpNg-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE2NyBTYWx0ZWRfX6encAGeBcUrE
 dXDpDSUuS2U27JshtiZwbLAntgARBOsOMMPoyd2s71zCBLWfgRwN1oKoJw0z76xEkoJXd7G1RcY
 jPGCuznP9BgUKTnnxehLw+BGTvRmjp6HI2AnC67ALGT+1xcBt5uZQjsL0dNa119kp1H0BnXjWfq
 Pv7kG83+R6Q8MpfGuOZS+MrOmeVe3BuVChRHkOQ4sdgdNcAKHD8ofS1IR+e9mrQp/rDWK4ph3eY
 svRIjW3pu6lDUIFY8eEao1sNogAhBgqyuk7e1N9/7yTmJSD8YU/oy2xUObePCw8FKZlINtuSC6I
 tCqCshsz0I8gVp0cyII1JCxp7f07JgdkhA+H7ggJYIScTwardRzk1UYQr9hNBHuhGJlkTul/457
 fmV2JbCfdWfMYGKcW45Nk98fjAxufZGszSyFmXAWpy2MqUI1WLvn7ZCDELxhBKCaoFb8s4QwXTD
 3q3ex1F7GA//qXWGnTA==
X-Proofpoint-ORIG-GUID: QZsxmbYuNr-2hBzJZibkmbz6vm0NpNg-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030167
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

On 7/3/26 1:00 PM, Zhuoying Cai wrote:
> Create a certificate store for boot certificates used for secure IPL.
> 
> Load certificates from the `boot-certs` parameter of s390-ccw-virtio
> machine type option into the cert store.
> 
> Currently, only X.509 certificates in PEM format are supported, as the
> QEMU command line accepts certificates in PEM format only.
> 
> The raw Base64 data is stored, as well as the certificate's size.  The
> binary (DER) size is stored as well, which may later be utilized for
> secure boot (signature verification).
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> Reviewed-by: Farhan Ali<alifm@linux.ibm.com>

Looks like v14 was coming out as a I commented on v13...  Everything
still applies here, so will repeat:

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>

With a few minor things below:

> ---
>  docs/specs/index.rst            |   1 +
>  docs/specs/s390x-secure-ipl.rst |  20 +++
>  hw/s390x/cert-store.c           | 238 ++++++++++++++++++++++++++++++++
>  hw/s390x/cert-store.h           |  39 ++++++
>  hw/s390x/ipl.c                  |  10 ++
>  hw/s390x/ipl.h                  |   3 +
>  hw/s390x/meson.build            |   1 +
>  include/hw/s390x/ipl/qipl.h     |   2 +
>  8 files changed, 314 insertions(+)
>  create mode 100644 docs/specs/s390x-secure-ipl.rst
>  create mode 100644 hw/s390x/cert-store.c
>  create mode 100644 hw/s390x/cert-store.h
> 
> diff --git a/docs/specs/index.rst b/docs/specs/index.rst
> index b7909a108a..76d439782c 100644
> --- a/docs/specs/index.rst
> +++ b/docs/specs/index.rst
> @@ -40,3 +40,4 @@ guest hardware that is specific to QEMU.
>     riscv-aia
>     aspeed-intc
>     iommu-testdev
> +   s390x-secure-ipl
> diff --git a/docs/specs/s390x-secure-ipl.rst b/docs/specs/s390x-secure-ipl.rst
> new file mode 100644
> index 0000000000..d7c0d4eaac
> --- /dev/null
> +++ b/docs/specs/s390x-secure-ipl.rst
> @@ -0,0 +1,20 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
> +s390 Certificate Store and Functions
> +------------------------------------
> +
> +s390 Certificate Store
> +^^^^^^^^^^^^^^^^^^^^^^
> +
> +A certificate store is implemented for s390-ccw guests to retain within
> +memory all certificates provided by the user via the command-line, which
> +are expected to be stored somewhere on the host's file system. The store
> +will keep track of the number of certificates, their respective size,
> +and a summation of the sizes.
> +
> +Each certificate is stroed in an S390IPLCertificate struct, which has a

stored

...

> +static int update_cert_store(S390IPLCertificateStore *cert_store,
> +                             S390IPLCertificate *cert)
> +{
> +    size_t data_buf_size;
> +    size_t keyid_buf_size;
> +    size_t hash_buf_size;
> +    size_t cert_buf_size;
> +
> +    /* length field is word aligned for later DIAG use */
> +    keyid_buf_size = ROUND_UP(CERT_KEY_ID_LEN, 4);
> +    hash_buf_size = ROUND_UP(CERT_HASH_LEN, 4);
> +    cert_buf_size = ROUND_UP(cert->der_size, 4);
> +    data_buf_size = keyid_buf_size + hash_buf_size + cert_buf_size;
> +
> +    if (cert_store->largest_cert_size < data_buf_size) {
> +        cert_store->largest_cert_size = data_buf_size;
> +    }
> +
> +    if (cert_store->count >= MAX_CERTIFICATES) {
> +        error_report("Cert store is full");
> +        return -1;
> +    }
> +

Seems we should check this first before updating largest_cert_size?

I think ultimately it will not matter because we will exit anyway, but
for debug may be useful to not have the largest_cert_size potentially
clobbered by a cert that was never added.

