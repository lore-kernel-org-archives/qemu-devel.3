Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F51EC54FB3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 14:47:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJZ5o-0006Pc-ON; Mon, 26 May 2025 10:46:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brueckner@linux.ibm.com>)
 id 1uJZ5l-0006OW-N0; Mon, 26 May 2025 10:46:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brueckner@linux.ibm.com>)
 id 1uJZ5i-0001bc-Ob; Mon, 26 May 2025 10:46:17 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54QCQfDj012077;
 Mon, 26 May 2025 14:46:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=aHbEkQXTfVzMbXnBW+CG4Dz78i7iBX
 6wWnfGEzjN3RQ=; b=JTqud3ERdfCxY971JTRMPwrSac156tIZG+qd/XhoLh5r0M
 VeW9peJf4r2QOjsZ3IXEQ5ityhZAiVzBs1IyjX3n10xMTMpH8wD46iJVhlQ4peos
 fygukKSW41QPuWi4pAGy+8vHdIvaQqCyR/8fVMAj0V+90Dx/smUN+rtf2IYD4hKu
 ra088WARl10e3p07MJSrYByPjUbcF3dbHZyq70rpYJrq/jZx3PlzLKAaqdRCt2nZ
 r0J2Dmrle0IPBOgYIvpq38Vu5eA1pjWXsWF3nWIKj/1Knoh6ma9gD5IplYunloIl
 bwCvFck0tMumIhsGcPMXfrnuXVNARUxYwbNHpjSQ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46u3hrt3hr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 May 2025 14:46:10 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54QCZ7L4010571;
 Mon, 26 May 2025 14:46:09 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46useppjms-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 May 2025 14:46:09 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54QEk5Iw45744422
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 26 May 2025 14:46:05 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D244220043;
 Mon, 26 May 2025 14:46:05 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BF2B520040;
 Mon, 26 May 2025 14:46:05 +0000 (GMT)
Received: from vela (unknown [9.155.211.206])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 26 May 2025 14:46:05 +0000 (GMT)
Received: from brueckner by vela with local (Exim 4.98.2)
 (envelope-from <brueckner@linux.ibm.com>) id 1uJZ5Y-00000000Dxh-2ts7;
 Mon, 26 May 2025 16:46:04 +0200
Date: Mon, 26 May 2025 16:46:04 +0200
From: Hendrik Brueckner <brueckner@linux.ibm.com>
To: Zhuoying Cai <zycai@linux.ibm.com>
Cc: thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 pbonzini@redhat.com, walling@linux.ibm.com, jjherne@linux.ibm.com,
 jrossi@linux.ibm.com, fiuczy@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com, iii@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 18/25] s390x: Guest support for Secure-IPL Code
 Loading Attributes Facility (SCLAF)
Message-ID: <aDR+rB+iV8VTx1uM@linux.ibm.com>
References: <20250508225042.313672-1-zycai@linux.ibm.com>
 <20250508225042.313672-19-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250508225042.313672-19-zycai@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AOOMbaiN c=1 sm=1 tr=0 ts=68347eb2 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=K-mOPpQVvbxahjPmrMMA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: 2EfOw-IRzPUxOgP2lulLdCIMU1NzRM-X
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI2MDEyNCBTYWx0ZWRfX3sZp2C8uyL9M
 sJfHrTY1tpC1mcPxCuv/0PTPrreJSX/g6s3ItrSF0GCvOjmuPX2PfUgAdprju3WK4Y+0gKHAC7m
 XmUO58buYcfGygV7chzet8CwjDiI9MkzxECbSvUKJyJ2cOIIXOpFUsQ0UAeX9urGaGBe/vVnO0i
 VCEQtAigo/bc0w1axmqTOalK0CCHJXAGspACHOsVuuB4GLPXujqBoqLtuHFsJeKgEi1XjJKyQv4
 gJnflOH0+mQm2JZA2Em/LvMPdpRMEIsQblV/HPOy3zf94h0XmGXcc7LSkmOVcjIUURERcH7Y2dc
 UNyeA1FlaSaI2oZOy9TRbhCCrKEjjMuSzOd/UCPjnM1LitgHeVf6jlXrG3ycyfHgrEAAFv7Z1ri
 HBZ+O5ET1PPSDHXYnO9spzvCYnIe5l8KUYWzU4inkR0dLQ0q7sDGvBkGauYYNahyaUFQSVOl
X-Proofpoint-GUID: 2EfOw-IRzPUxOgP2lulLdCIMU1NzRM-X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-26_07,2025-05-26_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 mlxscore=0 spamscore=0
 impostorscore=0 mlxlogscore=999 malwarescore=0 lowpriorityscore=0
 phishscore=0 clxscore=1011 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505260124
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=brueckner@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, May 08, 2025 at 06:50:34PM -0400, Zhuoying Cai wrote:
> The secure-IPL-code-loading-attributes facility (SCLAF)
> provides additional security during IPL.
> 
> Availability of SCLAF is determined by byte 136 bit 3 of the
> SCLP Read Info block.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
>  target/s390x/cpu_features.c         | 1 +
>  target/s390x/cpu_features_def.h.inc | 1 +
>  target/s390x/cpu_models.c           | 2 ++
>  target/s390x/gen-features.c         | 1 +
>  target/s390x/kvm/kvm.c              | 3 +++
>  5 files changed, 8 insertions(+)
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
> index 516d65d245..23079fe117 100644
> --- a/target/s390x/cpu_features_def.h.inc
> +++ b/target/s390x/cpu_features_def.h.inc
> @@ -142,6 +142,7 @@ DEF_FEAT(DIAG_320, "diag320", SCLP_FAC134, 5, "Provide Certificate Store functio
>  
>  /* Features exposed via SCLP SCCB Facilities byte 136 - 137 (bit numbers relative to byte-136) */
>  DEF_FEAT(SIPL, "sipl", SCLP_FAC_IPL, 1, "Secure-IPL facility")
> +DEF_FEAT(SCLAF, "sclaf", SCLP_FAC_IPL, 3, "Secure-IPL-code-loading-attributes facility")
>  
>  /* Features exposed via SCLP CPU info. */
>  DEF_FEAT(SIE_F2, "sief2", SCLP_CPU, 4, "SIE: interception format 2 (Virtual SIE)")
> diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
> index 63d4120640..5a0bdd6659 100644
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
> @@ -509,6 +510,7 @@ static void check_consistency(const S390CPUModel *model)
>          { S390_FEAT_DIAG_318, S390_FEAT_EXTENDED_LENGTH_SCCB },
>          { S390_FEAT_DIAG_320, S390_FEAT_EXTENDED_LENGTH_SCCB },
>          { S390_FEAT_SIPL, S390_FEAT_EXTENDED_LENGTH_SCCB },
> +        { S390_FEAT_SCLAF, S390_FEAT_EXTENDED_LENGTH_SCCB },

For SCLAF, should we also check if SIPL is enabled? I think, SCLAF w/o SIPL
does not make much sense.

