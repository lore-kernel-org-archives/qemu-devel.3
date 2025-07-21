Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 706BEC83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 21:32:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udy77-0005Mo-6U; Mon, 21 Jul 2025 17:32:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1udy67-0004zR-El; Mon, 21 Jul 2025 17:31:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1udy65-0006IO-B0; Mon, 21 Jul 2025 17:30:59 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56LBCGre015841;
 Mon, 21 Jul 2025 21:30:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=K+bgz8
 GjTlrnwbjEOVXT/KhcyyzhcOvTLK4BDlyWPgE=; b=tFOvNs6FoaZRgWclJnKMc8
 ngVKYvYXS5WBGZItnO/wOVcZ6mpbGOXvpt1+fWw7D7cDIz50pu2DouI8e6JuWnGb
 au6zKZB81I7tmoKvT5F6lrB1ZKoRMzyonhP0G18yPihz5e1arK/KxyIz8edsnAj1
 S4gIKaLv3bhU3KsI5l1kVsQhucVf3GfD7swoUq5VhzUw2HHZ2LPvmcWizJcSy3/+
 xf4STAmDpB8F5e6BntT4xpd96Edh95aywnERFzHiL5g5+OzrF3JmfC+T79ghLPNL
 DBwDK4+3XomlmBqAhyiPZmziapvRxfNZ5g8sFnMJNfd8NE1C/zwGkc084MMbjCoA
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4805ut2vyq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 21 Jul 2025 21:30:54 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56LJhDvY012404;
 Mon, 21 Jul 2025 21:30:54 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 480p3005hs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 21 Jul 2025 21:30:54 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 56LLUqYD50659820
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 21 Jul 2025 21:30:52 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7A50B58059;
 Mon, 21 Jul 2025 21:30:52 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C1F5358058;
 Mon, 21 Jul 2025 21:30:51 +0000 (GMT)
Received: from [9.12.68.85] (unknown [9.12.68.85])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 21 Jul 2025 21:30:51 +0000 (GMT)
Message-ID: <84eea732-145a-4650-bec3-0b9daf25723e@linux.ibm.com>
Date: Mon, 21 Jul 2025 17:30:51 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/28] s390x: Guest support for Certificate Store
 Facility (CS)
To: Zhuoying Cai <zycai@linux.ibm.com>, thuth@redhat.com, berrange@redhat.com, 
 richard.henderson@linaro.org, david@redhat.com, pbonzini@redhat.com,
 jrossi@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com
References: <20250711211105.439554-1-zycai@linux.ibm.com>
 <20250711211105.439554-5-zycai@linux.ibm.com>
Content-Language: en-US
From: Collin Walling <walling@linux.ibm.com>
In-Reply-To: <20250711211105.439554-5-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIxMDE4OCBTYWx0ZWRfX2Wykm+oLAalf
 /zGX0aW4KIOIA6PPW+xyLgcfDXgtvdp6jvi9roy21Ibl5tS1TNwC/bW2EKKzNktl1G54l186OhB
 /3e/JA/h3Bd6kpyfbNtOsGrn3JJdE4z0aqWD7cUMDVNN+CKZDQAM/3mT9JhdQKp8HC/uz9sG4Tq
 OBeSR3DdHIRIwiqvoD65IV3AEV7UBwzbssNrJgdDco73KkqQpa8qVWXWbTj2LwvXl+oSbMzGSW0
 45DQbNCc3hYlw5HTdl1REoR5nPNBgzj5OySLOSaXw6zBNn2hPaiyAs//gEs6i8XN639NpWqcuGz
 k9tgC2svtzy2YlvFth4PW9fGO2eD6CbDVV4JqNodJQeL8VBrZBOkrP1vfsuMl5the9Kp5f9Trfj
 s9e2O1L0yFLwrOPGfDgLbaqjkv2+MXl505zcvqEG+S0grgRGNzk0izntTWtJ/zdRcIYiOG03
X-Proofpoint-ORIG-GUID: eNwkvedTQwkoLQjKzjmTOR6nDX_n-spr
X-Authority-Analysis: v=2.4 cv=cIDgskeN c=1 sm=1 tr=0 ts=687eb18e cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=sFiGHyX3b9B8Ka-s2VAA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: eNwkvedTQwkoLQjKzjmTOR6nDX_n-spr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-21_05,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0
 adultscore=0 phishscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507210188
Received-SPF: pass client-ip=148.163.158.5; envelope-from=walling@linux.ibm.com;
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

On 7/11/25 17:10, Zhuoying Cai wrote:
> DIAG 320 is supported when the certificate-store (CS) facility
> is installed.
> 
> Availability of CS facility is determined by byte 134 bit 5 of the
> SCLP Read Info block. Byte 134's facilities cannot be represented
> without the availability of the extended-length-SCCB, so add it as
> a check for consistency.
> 
> Note: secure IPL is not available for Secure Execution (SE) guests,
> as their images are already integrity protected, and an additional
> protection of the kernel by secure IPL is not necessary.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>

For consistency with documentation, please change this from
"S390_FEAT_DIAG_320" to "S390_FEAT_CERT_STORE".

> ---
>  target/s390x/cpu_features.c         | 1 +
>  target/s390x/cpu_features_def.h.inc | 1 +
>  target/s390x/cpu_models.c           | 2 ++
>  target/s390x/gen-features.c         | 3 +++
>  target/s390x/kvm/kvm.c              | 2 ++
>  5 files changed, 9 insertions(+)
> 
> diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
> index 4b5be6798e..99089ab3f5 100644
> --- a/target/s390x/cpu_features.c
> +++ b/target/s390x/cpu_features.c
> @@ -147,6 +147,7 @@ void s390_fill_feat_block(const S390FeatBitmap features, S390FeatType type,
>          break;
>      case S390_FEAT_TYPE_SCLP_FAC134:
>          clear_be_bit(s390_feat_def(S390_FEAT_DIAG_318)->bit, data);
> +        clear_be_bit(s390_feat_def(S390_FEAT_DIAG_320)->bit, data);
>          break;
>      default:
>          return;
> diff --git a/target/s390x/cpu_features_def.h.inc b/target/s390x/cpu_features_def.h.inc
> index e23e603a79..7b13a95d98 100644
> --- a/target/s390x/cpu_features_def.h.inc
> +++ b/target/s390x/cpu_features_def.h.inc
> @@ -138,6 +138,7 @@ DEF_FEAT(SIE_IBS, "ibs", SCLP_CONF_CHAR_EXT, 10, "SIE: Interlock-and-broadcast-s
>  
>  /* Features exposed via SCLP SCCB Facilities byte 134 (bit numbers relative to byte-134) */
>  DEF_FEAT(DIAG_318, "diag318", SCLP_FAC134, 0, "Control program name and version codes")
> +DEF_FEAT(DIAG_320, "cstore", SCLP_FAC134, 5, "Provide Certificate Store functions")
>  
>  /* Features exposed via SCLP CPU info. */
>  DEF_FEAT(SIE_F2, "sief2", SCLP_CPU, 4, "SIE: interception format 2 (Virtual SIE)")
> diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
> index 954a7a99a9..33ef5c190c 100644
> --- a/target/s390x/cpu_models.c
> +++ b/target/s390x/cpu_models.c
> @@ -248,6 +248,7 @@ bool s390_has_feat(S390Feat feat)
>      if (s390_is_pv()) {
>          switch (feat) {
>          case S390_FEAT_DIAG_318:
> +        case S390_FEAT_DIAG_320:
>          case S390_FEAT_HPMA2:
>          case S390_FEAT_SIE_F2:
>          case S390_FEAT_SIE_SKEY:
> @@ -505,6 +506,7 @@ static void check_consistency(const S390CPUModel *model)
>          { S390_FEAT_PTFF_STOUE, S390_FEAT_MULTIPLE_EPOCH },
>          { S390_FEAT_AP_QUEUE_INTERRUPT_CONTROL, S390_FEAT_AP },
>          { S390_FEAT_DIAG_318, S390_FEAT_EXTENDED_LENGTH_SCCB },
> +        { S390_FEAT_DIAG_320, S390_FEAT_EXTENDED_LENGTH_SCCB },
>          { S390_FEAT_NNPA, S390_FEAT_VECTOR },
>          { S390_FEAT_RDP, S390_FEAT_LOCAL_TLB_CLEARING },
>          { S390_FEAT_UV_FEAT_AP, S390_FEAT_AP },
> diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
> index 8218e6470e..86486def23 100644
> --- a/target/s390x/gen-features.c
> +++ b/target/s390x/gen-features.c
> @@ -720,6 +720,7 @@ static uint16_t full_GEN16_GA1[] = {
>      S390_FEAT_PAIE,
>      S390_FEAT_UV_FEAT_AP,
>      S390_FEAT_UV_FEAT_AP_INTR,
> +    S390_FEAT_DIAG_320,
>  };
>  
>  static uint16_t full_GEN17_GA1[] = {
> @@ -919,6 +920,8 @@ static uint16_t qemu_MAX[] = {
>      S390_FEAT_KIMD_SHA_512,
>      S390_FEAT_KLMD_SHA_512,
>      S390_FEAT_PRNO_TRNG,
> +    S390_FEAT_EXTENDED_LENGTH_SCCB,
> +    S390_FEAT_DIAG_320,
>  };
>  
>  /****** END FEATURE DEFS ******/
> diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
> index 2e02d2c4de..8f655a4b7f 100644
> --- a/target/s390x/kvm/kvm.c
> +++ b/target/s390x/kvm/kvm.c
> @@ -2490,6 +2490,8 @@ bool kvm_s390_get_host_cpu_model(S390CPUModel *model, Error **errp)
>          set_bit(S390_FEAT_DIAG_318, model->features);
>      }
>  
> +    set_bit(S390_FEAT_DIAG_320, model->features);
> +
>      /* Test for Ultravisor features that influence secure guest behavior */
>      query_uv_feat_guest(model->features);
>  


-- 
Regards,
  Collin

