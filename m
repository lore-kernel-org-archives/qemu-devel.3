Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71298C83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 22:32:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubRiB-0006XE-Em; Mon, 14 Jul 2025 18:31:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1ubRQi-00060C-3V; Mon, 14 Jul 2025 18:13:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1ubRQg-0001bB-7C; Mon, 14 Jul 2025 18:13:47 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56EIYoEq002333;
 Mon, 14 Jul 2025 22:13:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=fex3dh
 6Qdzr0L44ELvj+dpfCgsdruk0y8LcLsBPsbAY=; b=nRF7rDZieeKmmIwtVtUspe
 Dfghi4ZpF44g5ED3fAzV5v98w9ttlqggBt4R6WC8U4+SAYC1T6Z011FjC29MJdN7
 Lyt7tacnh9BWp9mbehfM397K7sTORhnQS5autUChUdblTNvRrfEgS3Ct6qCHPxjB
 j4qb9OTR2hlP4UQhkiIQsif5Vk6rBvjl/EGGrB9r4RrFN7JGbPvx7yY6U/A60WB6
 7bToGa8HPqbH8Jre5F2nzL+OSiqDK+N6sME9j+uGU6Sfpcp+/Tmk9bfmLLsSxQEg
 IWP8YgHaupWg0sqRsARK72flgpmJIdwXQPvERBVPThR+rmHdJm1REqjoOAhhgbQA
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47ue4tuvkj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Jul 2025 22:13:44 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56EIkUMO008941;
 Mon, 14 Jul 2025 22:13:43 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47v3hmfp02-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Jul 2025 22:13:43 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 56EMDgoX23396998
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Jul 2025 22:13:42 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F167158043;
 Mon, 14 Jul 2025 22:13:41 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9AF3F58059;
 Mon, 14 Jul 2025 22:13:40 +0000 (GMT)
Received: from [9.12.68.85] (unknown [9.12.68.85])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 14 Jul 2025 22:13:40 +0000 (GMT)
Message-ID: <c331ce40-2f77-4636-8cb2-4cd3a34ccd12@linux.ibm.com>
Date: Mon, 14 Jul 2025 18:13:39 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 21/28] s390x: Guest support for Secure-IPL Code Loading
 Attributes Facility (SCLAF)
To: Zhuoying Cai <zycai@linux.ibm.com>, thuth@redhat.com, berrange@redhat.com, 
 richard.henderson@linaro.org, david@redhat.com, pbonzini@redhat.com,
 jrossi@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com
References: <20250711211105.439554-1-zycai@linux.ibm.com>
 <20250711211105.439554-22-zycai@linux.ibm.com>
Content-Language: en-US
From: Collin Walling <walling@linux.ibm.com>
In-Reply-To: <20250711211105.439554-22-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=baBrUPPB c=1 sm=1 tr=0 ts=68758118 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=hxafNF8EEUUuVJEmDPgA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Zt7aoUIQc9zzgAUA6cDBPObWEGEmVX7S
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDE0OSBTYWx0ZWRfX77VbXmQldx9F
 qa4bTZPMmxijyYpikpMTs2lL8dUqb039noAuOz9weIRJOb/W8K9Zb9RP2mUuxX647mNA49C3vgj
 a5Eu/nymKQRbOUJnN2kzIwkLLkkfmZuFLQNCyZIpDyFrZsTmbRmzaf6bkpNKAGbrvDXF4tb8mzk
 Y0mYI3zQrlsS5kXKl0rGH/41Wd5FgCCuZQlcSF4fp0CXSPOkxydyswJv3q5kWbF9VZO8Z4Ck2TW
 lIiKkgHftQRC/PNCYijGTOwR0KkHMAIGMLGv24yFFCyvrX1uVde1SFUIudmnVANi5FK8FcTdiul
 GcA78zE8/F9elpEGkddhfYyxOKUgjEdVE7zzxSUuPUCoRXRlP/q7oycDnUzo7qILxBX75/ytq+Q
 LmkUR1e0V07YtbCjdT22nW8Qy+9hfNtz8aGjX+qorFm3SGV07ITW0i5mHMiRQ3sYozsycKfb
X-Proofpoint-ORIG-GUID: Zt7aoUIQc9zzgAUA6cDBPObWEGEmVX7S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_02,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 mlxscore=0
 malwarescore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507140149
Received-SPF: pass client-ip=148.163.158.5; envelope-from=walling@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 7/11/25 5:10 PM, Zhuoying Cai wrote:
> The secure-IPL-code-loading-attributes facility (SCLAF)
> provides additional security during IPL.
> 
> Availability of SCLAF is determined by byte 136 bit 3 of the
> SCLP Read Info block.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>

Aside from the comment I made in patch 17, LGTM.

Reviewed-by: Collin Walling <walling@linux.ibm.com>

> ---
>  target/s390x/cpu_features.c         | 1 +
>  target/s390x/cpu_features_def.h.inc | 1 +
>  target/s390x/cpu_models.c           | 3 +++
>  target/s390x/gen-features.c         | 2 ++
>  target/s390x/kvm/kvm.c              | 3 +++
>  5 files changed, 10 insertions(+)
> 
> diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
> index 3f3d6a80af..8d5614fa59 100644
> --- a/target/s390x/cpu_features.c
> +++ b/target/s390x/cpu_features.c
> @@ -151,6 +151,7 @@ void s390_fill_feat_block(const S390FeatBitmap features, S390FeatType type,
>          break;
>      case S390_FEAT_TYPE_SCLP_FAC_IPL:
>          clear_be_bit(s390_feat_def(S390_FEAT_SIPL)->bit, data);
> +        clear_be_bit(s390_feat_def(S390_FEAT_SCLAF)->bit, data);
>          break;
>      default:
>          return;
> diff --git a/target/s390x/cpu_features_def.h.inc b/target/s390x/cpu_features_def.h.inc
> index 956bd8a123..2e91817d75 100644
> --- a/target/s390x/cpu_features_def.h.inc
> +++ b/target/s390x/cpu_features_def.h.inc
> @@ -142,6 +142,7 @@ DEF_FEAT(DIAG_320, "cstore", SCLP_FAC134, 5, "Provide Certificate Store function
>  
>  /* Features exposed via SCLP SCCB Facilities byte 136 - 137 (bit numbers relative to byte-136) */
>  DEF_FEAT(SIPL, "sipl", SCLP_FAC_IPL, 1, "Secure-IPL facility")
> +DEF_FEAT(SCLAF, "sclaf", SCLP_FAC_IPL, 3, "Secure-IPL-code-loading-attributes facility")
>  
>  /* Features exposed via SCLP CPU info. */
>  DEF_FEAT(SIE_F2, "sief2", SCLP_CPU, 4, "SIE: interception format 2 (Virtual SIE)")
> diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
> index ab46204d9e..cb1c6b5350 100644
> --- a/target/s390x/cpu_models.c
> +++ b/target/s390x/cpu_models.c
> @@ -264,6 +264,7 @@ bool s390_has_feat(S390Feat feat)
>          case S390_FEAT_SIE_PFMFI:
>          case S390_FEAT_SIE_IBS:
>          case S390_FEAT_SIPL:
> +        case S390_FEAT_SCLAF:
>          case S390_FEAT_CONFIGURATION_TOPOLOGY:
>              return false;
>              break;
> @@ -509,6 +510,8 @@ static void check_consistency(const S390CPUModel *model)
>          { S390_FEAT_DIAG_318, S390_FEAT_EXTENDED_LENGTH_SCCB },
>          { S390_FEAT_DIAG_320, S390_FEAT_EXTENDED_LENGTH_SCCB },
>          { S390_FEAT_SIPL, S390_FEAT_EXTENDED_LENGTH_SCCB },
> +        { S390_FEAT_SCLAF, S390_FEAT_EXTENDED_LENGTH_SCCB },
> +        { S390_FEAT_SCLAF, S390_FEAT_SIPL },
>          { S390_FEAT_NNPA, S390_FEAT_VECTOR },
>          { S390_FEAT_RDP, S390_FEAT_LOCAL_TLB_CLEARING },
>          { S390_FEAT_UV_FEAT_AP, S390_FEAT_AP },
> diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
> index 6ee9bad4c6..987e291cf9 100644
> --- a/target/s390x/gen-features.c
> +++ b/target/s390x/gen-features.c
> @@ -722,6 +722,7 @@ static uint16_t full_GEN16_GA1[] = {
>      S390_FEAT_UV_FEAT_AP_INTR,
>      S390_FEAT_DIAG_320,
>      S390_FEAT_SIPL,
> +    S390_FEAT_SCLAF,
>  };
>  
>  static uint16_t full_GEN17_GA1[] = {
> @@ -924,6 +925,7 @@ static uint16_t qemu_MAX[] = {
>      S390_FEAT_EXTENDED_LENGTH_SCCB,
>      S390_FEAT_DIAG_320,
>      S390_FEAT_SIPL,
> +    S390_FEAT_SCLAF,
>  };
>  
>  /****** END FEATURE DEFS ******/
> diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
> index fc9cad32a1..be3ad7316d 100644
> --- a/target/s390x/kvm/kvm.c
> +++ b/target/s390x/kvm/kvm.c
> @@ -2523,6 +2523,9 @@ bool kvm_s390_get_host_cpu_model(S390CPUModel *model, Error **errp)
>      /* Secure-IPL facility is handled entirely within QEMU */
>      set_bit(S390_FEAT_SIPL, model->features);
>  
> +    /* Secure-IPL-code-loading-attributes facility is handled entirely within QEMU */
> +    set_bit(S390_FEAT_SCLAF, model->features);
> +
>      /* Test for Ultravisor features that influence secure guest behavior */
>      query_uv_feat_guest(model->features);
>  


-- 
Regards,
  Collin

