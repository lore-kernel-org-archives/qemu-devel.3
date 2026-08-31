Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF166C624A4
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 14:10:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x12hz-0002wI-4R; Mon, 31 Aug 2026 10:09:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1x12hx-0002w8-BA
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 10:09:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1x12hv-0006OR-OQ
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 10:09:56 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67VBViDD1974522; Mon, 31 Aug 2026 14:09:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=RMlAhU
 wui8mjyYkhz3iuNR68BWAlL4QaeHa27+gA7ME=; b=eUowi4sTaCTcmGBTZrLnCX
 xUlOBRKYxmce4znnl3Eo9KYAWdCj4oFLdKF9xNRa2OjqZQSlGdNtb8XgwVvTIfkv
 GlSXjd2YD3AtveqAR+paaS1U9IDTHXZ6lq8w1RHLxtLv8Cfw6fcpZhCqhr8V6Swo
 DUANvsi81knWod9IihvvRXYeEac+Hld4KGdW27G4qA2Atx+ZK2jH/BHT8rux1cpq
 e6Jn2pbYmWEUJH4ol//Hxx1nCIhZ+XIKJnyoaTe/CLMxcbljVQq7iVlP82H78SOl
 vnhxtmqLlO9pdb4OvKCD0V/nDf9OjZHDoHRE55cC+Y9zfD0IGEYWq27ajDcA2DKA
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbmuhhw4u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Aug 2026 14:09:53 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67VDuGDA001643;
 Mon, 31 Aug 2026 14:09:52 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gccexx1e1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Aug 2026 14:09:52 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67VE9pq710224194
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 31 Aug 2026 14:09:52 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C4EAD58059;
 Mon, 31 Aug 2026 14:09:51 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5EE1658058;
 Mon, 31 Aug 2026 14:09:51 +0000 (GMT)
Received: from [9.61.31.247] (unknown [9.61.31.247])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 31 Aug 2026 14:09:51 +0000 (GMT)
Message-ID: <b5ee5fe3-8315-450c-a60c-5ed5c943acc4@linux.ibm.com>
Date: Mon, 31 Aug 2026 10:09:50 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] crypto/x509-utils: don't double set errp
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: berrange@redhat.com
References: <20260831120926.2809313-1-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Zhuoying Cai <zycai@linux.ibm.com>
In-Reply-To: <20260831120926.2809313-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7Eody1DP2XPgVnG4k9r7YPWsHbb43fkz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDEyMSBTYWx0ZWRfX2GouyJ+6Sztu
 uTFM6BFbMsxx0U3fwYw0f2xVQ9lAemx3VBCls22V+fKn25mQcvu2WoNFvbqhZEeaj8Wu+JQwK+p
 lVWqGbQJh+hB+m2nT12gODizBhrSy6Q4NCBHDhnmqlZJHw1RdGR1NadpRtOSLLA+Bkua6of/RVh
 A4eOu05JOqpWhmmDRYSAldHEeZ8RdiF2O/qU7LWF5nusj8zIqjeHQ77oQgY1cMgG25mbjZIQ7B1
 nRG3Nubf1tsntu1dgVbxis+umCzGIupFzFvZHFOr0+oxj5mI3uuKIREkbBTLxjASnLT+nzqkLCC
 SXmm7ToI21fQkGlLaK9Ms4d0srLZi6JCmvV5tPlG2JUS5FhKkPwaleaveEfumCS1jWTINpQKtN3
 OmEglYeQsm10EyshAvxFC1zrZ+ENN8pF1+DD4BV8dLP1jX9zESHX5PxysFuJOncPi166jwBo/vA
 b1UahBrL0Wj0HWt85Cw==
X-Authority-Analysis: v=2.4 cv=Osl/DS/t c=1 sm=1 tr=0 ts=6a958b31 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=20KFwNOVAAAA:8 a=TjfjCoCuwQYMyLlKo68A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDEyMSBTYWx0ZWRfX4Klt218CuZgb
 KyBQwOB5R8GP0btpdxCcQ6lXv0nLiUUSazKbIQIZdZS+X99UxeLfAz2SCiBPHidXGObkosGo7qP
 8IZPqe/bTh5UsQXIK8TJxKTfT5Kbj9s=
X-Proofpoint-ORIG-GUID: 7Eody1DP2XPgVnG4k9r7YPWsHbb43fkz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_04,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 phishscore=0 clxscore=1011 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310121
Received-SPF: pass client-ip=148.163.158.5; envelope-from=zycai@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Reviewed-by: Zhuoying Cai <zycai@linux.ibm.com>

On 8/31/26 8:09 AM, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> qcrypto_x509_get_ecc_curve() already sets errp on failure.
> 
> Fixes: e8317c4c9f68 ("crypto/x509-utils: Add helper functions for DIAG 320 subcode 2")
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  crypto/x509-utils.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/crypto/x509-utils.c b/crypto/x509-utils.c
> index e4767f98384e..34cbfca26bff 100644
> --- a/crypto/x509-utils.c
> +++ b/crypto/x509-utils.c
> @@ -325,7 +325,6 @@ int qcrypto_x509_check_ecc_curve_p521(uint8_t *cert, size_t size, Error **errp)
>  
>      curve_id = qcrypto_x509_get_ecc_curve(cert, size, errp);
>      if (curve_id == -1) {
> -        error_setg(errp, "Failed to get ECC curve");
>          return -1;
>      }
>  


