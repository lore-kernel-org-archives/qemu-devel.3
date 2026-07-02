Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAE6CC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 03:17:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wf7ut-00044s-HO; Wed, 01 Jul 2026 23:16:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wf7uk-00043u-6S; Wed, 01 Jul 2026 23:16:34 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wf7ui-0002Cf-4O; Wed, 01 Jul 2026 23:16:33 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6621KJM42509473; Thu, 2 Jul 2026 03:16:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=XwE+wd
 ULm9zo3VfSJ5IIBZCOgUP8VoFc4NI3Uw5o4bc=; b=PLVAsb2JfpUD6uVJku8Ev6
 cqgB0/oCXgwXesfDeY3Y8BVk4zOskqEKl/3rz8K1c9zNaLM9YD8J+FeVs0Y/wcHf
 TOA8Wz+8RpRygbcyt3Ikd6k72QHjosGziIoiUkMC3moUcpBWkrCNP35fj+lRh0oN
 20DuzvhQM1yQGqqk/YENjmuAoGMmsa7NaLoI9qmuTN17Ilo1HL4zwMJ0M8iPn091
 U/zC8BgpOQ7jIxjoCfwzVC3sk0YC/lbiei0Jw+AQJOq63jd1q1Mc1X8GqBSg+MhF
 u8p8QWQRlGS+M9Ui9eJNmIy9fFp/jYNReGkMC5GVCi8nKdlLnGCLM0dBZaqjV7kw
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26pe7vxv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Jul 2026 03:16:27 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6622nbcY017507;
 Thu, 2 Jul 2026 03:16:26 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2tbhj4c2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Jul 2026 03:16:26 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6623GPad29491948
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 2 Jul 2026 03:16:25 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3F2E358059;
 Thu,  2 Jul 2026 03:16:25 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0ACA458058;
 Thu,  2 Jul 2026 03:16:24 +0000 (GMT)
Received: from [9.61.143.111] (unknown [9.61.143.111])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Thu,  2 Jul 2026 03:16:23 +0000 (GMT)
Message-ID: <b767f553-109a-4b4b-b69f-0239be32f3bb@linux.ibm.com>
Date: Wed, 1 Jul 2026 23:16:23 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 28/35] hw/s390x/ipl: Set IPIB flags for secure IPL
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: cohuck@redhat.com, berrange@redhat.com, richard.henderson@linaro.org,
 david@kernel.org, walling@linux.ibm.com, jjherne@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
References: <20260701204922.1320349-1-zycai@linux.ibm.com>
 <20260701204922.1320349-29-zycai@linux.ibm.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <20260701204922.1320349-29-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: RMH_GjOKS5K6VwnfbJpXsqRk6oXA5Kh3
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDAyNiBTYWx0ZWRfX4KS8BizQACce
 Ub+13O5rjnLkqxsN/BJFGHCrpVFIg7pXIGDlSEI/pOo5lTlJAFynH6a0sbxt01WjuGm5SqyfKnP
 oyFlieY0a8+g/cAYgi344WLt6XanEHI=
X-Authority-Analysis: v=2.4 cv=edsNubEH c=1 sm=1 tr=0 ts=6a45d80b cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=20KFwNOVAAAA:8 a=YyEUnw4G0FhARttIG-sA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDAyNiBTYWx0ZWRfX74DEP8hkgDMX
 9KHQbZRk1cpnSPtA0AIWx5ZU5eT6rFp8bzfgQeWvbFx5fPhQw+oOFq2Uhfca2rszEIihcOTJ223
 XbjkPXhvnnOi69bi3pEBv1cqr+6gm2cBkdIT+bmjrpHU1SGAMX7ihCPJ4WAimc3SYnM4oTbo+uX
 Ltg12VpBBTcpvV4eunFRJEkIRpQHybhjrrv3QnMCT4lR/9T9ygnY+HXyOaiUKalO8wHQesBeT/L
 h/BaI+A1wWmR9bZTCBPFWLfcdwJs/20rA621+dgBqZhs4IqXtpbzCnv97D7le6IuDT2tVvrZ3n7
 INkhY0/7DJ8ld5iGN0puPlYkg3WYbcJPXDKHlo+1mFYV1DhYvzTy4i692bG48oAJ4duGxLNNjM9
 WzjO43cO4DXhGPpLo2BoHC3JxKPMSN/6zyo7eBKTMWvJR/uZ3kqCFdjmEdzEWNSniK3Xml4QU0T
 otxmvfJTjSCqNGAGvWQ==
X-Proofpoint-ORIG-GUID: RMH_GjOKS5K6VwnfbJpXsqRk6oXA5Kh3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0 bulkscore=0
 spamscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020026
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jrossi@linux.ibm.com;
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



On 7/1/26 4:49 PM, Zhuoying Cai wrote:
> If `-M secure-boot=on` is specified on the command line option, indicating
> true secure IPL enabled, set Secure-IPL bit and IPL-Information-Report
> bit on in IPIB Flags field, and trigger true secure IPL in the S390 BIOS.
>
> Any error that occurs during true secure IPL will cause the IPL to
> terminate.
>
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Collin Walling <walling@linux.ibm.com>
> ---
>   hw/s390x/ipl.c | 19 ++++++++++++++++++-
>   1 file changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> index 7734b6edc7..da826908c1 100644
> --- a/hw/s390x/ipl.c
> +++ b/hw/s390x/ipl.c
> @@ -467,6 +467,11 @@ static bool s390_has_certificate(void)
>       return ipl->cert_store.count > 0;
>   }
>   
> +static bool s390_secure_boot_enabled(void)
> +{
> +    return S390_CCW_MACHINE(qdev_get_machine())->secure_boot;
> +}
> +
>   static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
>   {
>       CcwDevice *ccw_dev = NULL;
> @@ -523,6 +528,18 @@ static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
>           s390_ipl_convert_loadparm((char *)lp, iplb->loadparm);
>           iplb->flags |= DIAG308_FLAGS_LP_VALID;
>   
> +        /*
> +         * If secure-boot is enabled, then toggle the secure IPL flags to
> +         * trigger secure boot in the s390 BIOS.
> +         *
> +         * Boot process will terminate if any error occurs during secure boot.
> +         *
> +         * If SIPL is on, IPLIR must also be on.
> +         */
> +        if (s390_secure_boot_enabled()) {
> +            iplb->hdr_flags |= (DIAG308_IPIB_FLAGS_SIPL | DIAG308_IPIB_FLAGS_IPLIR);
> +            iplb->len = cpu_to_be32(S390_IPLB_MAX_LEN);
> +        }
>           /*
>            * Secure boot in audit mode will perform
>            * if certificate(s) exist in the key store.
> @@ -532,7 +549,7 @@ static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
>            *
>            * Results of secure boot will be stored in IIRB.
>            */
> -        if (s390_has_certificate()) {
> +        else if (s390_has_certificate()) {
>               iplb->hdr_flags |= DIAG308_IPIB_FLAGS_IPLIR;
>               iplb->len = cpu_to_be32(S390_IPLB_MAX_LEN);
>           }

Reviewed-by: Jared Rossi <jrossi@linux.ibm.com>

