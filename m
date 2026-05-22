Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93C89CD5BAC
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 20:31:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQWWL-0005qR-88; Fri, 22 May 2026 16:31:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1wQWVr-0005iR-Ho; Fri, 22 May 2026 16:30:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1wQWVp-0005kc-Dj; Fri, 22 May 2026 16:30:31 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64MF5MZf995533; Fri, 22 May 2026 20:30:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=AiIOcw
 cz9KHDd0ncwvpeYysmdzuzZ2PovyIDTz9CysY=; b=kHZUahydQna3XTVaOkVPom
 r4lGNo4Qc+BJF/kkXmeuNpV7ypCszpBt2MxuLqmGZvUywAcupH68TuZ4qSfGDt3s
 6oYaarEVZSAdbTmlaq4sAq4H+JzOcYS+1s4IpjyvjFrnxwLD9V/6F+LA35EkyC/E
 hwnT1fpkBursWzHqHyUNOsK1EI59nlP3krXHoMY+KPj01CFNih4AP+U7dLuRX4vD
 dayktuzIMk8lO3ebLcr8L7W18TrJY47tMOVkHqxal3LEfYv/TtliR7cGUqNvy6F4
 B2QXrUC0OwfsvQwRGQEY8eP9hLuWcBaY/vw63zb0uKJcoHUgVJ4EGTpu00Mwg3KA
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h8n5rkp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 22 May 2026 20:30:25 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64MKO445031484;
 Fri, 22 May 2026 20:30:24 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e73wkjj68-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 22 May 2026 20:30:24 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64MKUMaS31392368
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 22 May 2026 20:30:23 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CE2A45806A;
 Fri, 22 May 2026 20:30:22 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CC6B45805F;
 Fri, 22 May 2026 20:30:20 +0000 (GMT)
Received: from [9.67.42.213] (unknown [9.67.42.213])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 22 May 2026 20:30:20 +0000 (GMT)
Message-ID: <443afcfc-a813-431a-b78b-c5fd38659253@linux.ibm.com>
Date: Fri, 22 May 2026 16:30:19 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Collin Walling <walling@linux.ibm.com>
Subject: Re: [PATCH v11 10/32] hw/s390x: Define finite size for single entry
 VCEntry
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@kernel.org, jjherne@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
References: <20260505201905.997996-1-zycai@linux.ibm.com>
 <20260505201905.997996-11-zycai@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260505201905.997996-11-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: OQAhvboTNO_f-8CNkBGRDMACIZhy-8mA
X-Authority-Analysis: v=2.4 cv=GYMnWwXL c=1 sm=1 tr=0 ts=6a10bce1 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=BBO6kFDeb1kAoO7j7vYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: OQAhvboTNO_f-8CNkBGRDMACIZhy-8mA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDIwMCBTYWx0ZWRfX3kh2UAr9RHDc
 jNF1rbu8G4QwxhYs/6gl3gfXnpIB4BAcgZd/SKAcSFZPagyCeBTTWzFybsf+pcdvUzPJbjxur6K
 E74DGT9GR0ZDwmuVvAPdrvsnXkZ7LJFboTMCm5DDTZISaWKl2mIJVG3HVUpl8uxiglukvlT2TqG
 QR8II3kk2qPukxb6tchjOlPW6MYWowoqLJOi2x0NvtM5y87dJ+o31eGcfJXOdOcqHhVazqxg78V
 PUPOha/SyMJobl3On7Jv+WzaREEuWzNFa2SCvLYRKbdF2Ixg6mHDqGVWxAk4elxP7esMFF3Xqy9
 qzdYTa4T2e4MfaAb69f4JQe4yoe0XS5Eximuq1aSUq15gdyOxVHChdb6GZIsKIJqaktzYNQ13ji
 K6cczytfKqGmxReZsxc705JivJk0/XgeZIJmRaBzMKw5B4zEhi1QbpYp1hY8uzJC2RGodUjCrw5
 aJCGFok0f+4RQfaCYFQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_05,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220200
Received-SPF: pass client-ip=148.163.156.1; envelope-from=walling@linux.ibm.com;
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

On 5/5/26 16:18, Zhuoying Cai wrote:
> Define MAX_ENTRY_SIZE (8KB) and CERT_BUF_MAX_LEN to establish a finite
> size for a single entry VCEntry. Add validation in update_cert_store() to
> ensure certificate data does not exceed this limit.
> 
> This finite size definition is needed for proper memory allocation and
> will be used in a later commit to handle VCEntry structures with known
> size constraints.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
>  hw/s390x/cert-store.c          | 15 +++++++++++++--
>  include/hw/s390x/ipl/diag320.h |  3 +++
>  2 files changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/s390x/cert-store.c b/hw/s390x/cert-store.c
> index a4f15627e9..221267781b 100644
> --- a/hw/s390x/cert-store.c
> +++ b/hw/s390x/cert-store.c
> @@ -73,7 +73,7 @@ static S390IPLCertificate *init_cert(char *path, Error **errp)
>      return cert;
>  }
>  
> -static void update_cert_store(S390IPLCertificateStore *cert_store,
> +static int update_cert_store(S390IPLCertificateStore *cert_store,
>                                S390IPLCertificate *cert)

In patch 4, you can define this function as an int type in anticipation
of these changes, and where you call the g_assert() for cert count,
change that to an if (check) return -1.

The if (update_cert_store(...) { ... } code should also go in patch 4.

This will make this patch much more streamlined, where only the #defines
and the new check in update_cert_store is introduced.

>  {
>      size_t data_buf_size;
> @@ -87,6 +87,12 @@ static void update_cert_store(S390IPLCertificateStore *cert_store,
>      cert_buf_size = ROUND_UP(cert->der_size, 4);
>      data_buf_size = keyid_buf_size + hash_buf_size + cert_buf_size;
>  
> +    if (data_buf_size > CERT_BUF_MAX_LEN) {
> +        error_report("Certificate data size %zu exceeds maximum buffer size %ld",
> +                     data_buf_size, CERT_BUF_MAX_LEN);
> +        return -1;
> +    }
> +
>      if (cert_store->largest_cert_size < data_buf_size) {
>          cert_store->largest_cert_size = data_buf_size;
>      }
> @@ -96,6 +102,8 @@ static void update_cert_store(S390IPLCertificateStore *cert_store,
>      cert_store->certs[cert_store->count] = *cert;
>      cert_store->total_bytes += data_buf_size;
>      cert_store->count++;
> +
> +    return 0;
>  }
>  
>  static GPtrArray *get_cert_paths(Error **errp)
> @@ -214,7 +222,10 @@ void s390_ipl_create_cert_store(S390IPLCertificateStore *cert_store)
>              exit(1);
>          }
>  
> -        update_cert_store(cert_store, cert);
> +        if (update_cert_store(cert_store, cert)) {
> +            g_ptr_array_free(cert_path_builder, TRUE);
> +            exit(1);
> +        }
>      }
>  
>      g_ptr_array_free(cert_path_builder, TRUE);
> diff --git a/include/hw/s390x/ipl/diag320.h b/include/hw/s390x/ipl/diag320.h
> index 35c652ff56..75065d2fe4 100644
> --- a/include/hw/s390x/ipl/diag320.h
> +++ b/include/hw/s390x/ipl/diag320.h
> @@ -83,6 +83,9 @@ struct VCEntry {
>  };
>  typedef struct VCEntry VCEntry;
>  
> +#define MAX_ENTRY_SIZE      (8 * 1024)

s/MAX_ENTRY_SIZE/MAX_VCENTRY_SIZE ?

> +#define CERT_BUF_MAX_LEN    (MAX_ENTRY_SIZE - sizeof(VCEntryHeader))
> +
>  struct VCBlockHeader {
>      uint32_t in_len;
>      uint32_t reserved0;

-- 
Regards,
  Collin

